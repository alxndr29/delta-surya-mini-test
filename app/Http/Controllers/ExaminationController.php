<?php

namespace App\Http\Controllers;

use App\Models\Examination;
use App\Models\File;
use App\Models\MedicalPrescription;
use App\Models\Medicine;
use App\Models\MedicinePrice;
use App\Models\Patient;
use Barryvdh\DomPDF\Facade\Pdf;
use Illuminate\Http\Request;
use Illuminate\Http\RedirectResponse;
use Illuminate\Support\Facades\Storage;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Str;
use Illuminate\View\View;

/**
 * Handle patient examinations: create/update examinations,
 * manage prescriptions, file uploads, payments, and PDF receipts.
 */
class ExaminationController extends Controller
{
    /**
     * Display paginated list of patients with their examination (if any).
     *
     * @return View
     */
    public function index(): View
    {
        $patients = Patient::with(['examination'])
            ->paginate(10);

        return view('template.menu.examintation.index', compact('patients'));
    }

    /**
     * Show the create examination form with medicine list.
     *
     * @return View
     */
    public function create(): View
    {
        $medicines = Medicine::all();

        return view('template.menu.examintation.create', compact('medicines'));
    }

    /**
     * Update patient identity, examination vitals, prescriptions, and optional file.
     *
     * @param  Request  $request
     * @param  int      $id       Patient ID
     * @return RedirectResponse
     */
    public function update(Request $request, int $id): RedirectResponse
    {
        $validator = Validator::make(
            $request->all(),
            [
                'nik'               => ['required', 'digits:16'],
                'bpjs'              => ['nullable', 'digits:13'],
                'name'              => ['required', 'string', 'max:255'],
                'phone'             => ['required', 'string', 'max:20'],
                'bhirt_place'       => ['required', 'string', 'max:100'],
                'bhirt_date'        => ['required', 'date'],
                'address'           => ['required', 'string', 'max:500'],
                'date'              => ['required', 'date'],
                'weight'            => ['required', 'numeric', 'between:1,500'],
                'height'            => ['required', 'numeric', 'between:30,250'],
                'diastole'          => ['required', 'integer', 'between:40,130'],
                'systole'           => ['required', 'integer', 'between:70,250', 'gt:diastole'],
                'respiratory_rate'  => ['required', 'integer', 'between:8,40'],
                'temperature'       => ['required', 'numeric', 'between:30,45'],
                'heart_rate'        => ['required', 'integer', 'between:30,220'],
                'quantities'        => ['required', 'array'],
                'quantities.*'      => ['nullable', 'integer', 'min:0'],
                'file'              => ['nullable', 'file', 'mimes:pdf,jpg,jpeg,png,doc,docx,xlsx,xls', 'max:2048'],
            ]
        );

        if ($validator->fails()) {
            return back()->withErrors($validator)->withInput();
        }

        // Update patient
        $patient = Patient::findOrFail($id);
        $patient->nik         = $request->nik;
        $patient->bpjs        = $request->bpjs;
        $patient->name        = $request->name;
        $patient->phone       = $request->phone;
        $patient->bhirt_place = $request->bhirt_place;
        $patient->bhirt_date  = $request->bhirt_date;
        $patient->address     = $request->address;
        $patient->save();

        // Update examination
        $examination = Examination::where('patient_id', $patient->id)->firstOrFail();
        $examination->date             = $request->date;
        $examination->weight           = $request->weight;
        $examination->height           = $request->height;
        $examination->diastole         = $request->diastole;
        $examination->systole          = $request->systole;
        $examination->respiratory_rate = $request->respiratory_rate;
        $examination->temperature      = $request->temperature;
        $examination->heart_rate       = $request->heart_rate;
        $examination->save();

        // Rebuild prescriptions
        MedicalPrescription::where('examination_id', $examination->id)->delete();

        foreach ($request->quantities as $medicineId => $qty) {
            if ($qty > 0) {
                $medicinePrice = MedicinePrice::where('medicine_id', $medicineId)
                    ->where('start_date', '<=', $request->date)
                    ->where(function ($q) use ($request) {
                        $q->whereNull('end_date')
                            ->orWhereDate('end_date', '>=', $request->date);
                    })
                    ->first();

                if ($medicinePrice) {
                    MedicalPrescription::create([
                        'examination_id'    => $examination->id,
                        'medicine_price_id' => $medicinePrice->id,
                        'qty'               => $qty,
                        'total_price'       => $qty * $medicinePrice->unit_price,
                    ]);
                }
            }
        }

        // Replace file if new one uploaded
        if ($request->hasFile('file')) {
            $file     = $request->file('file');
            $folder   = 'uploads/examinations';
            $filename = Str::uuid() . '.' . $file->getClientOriginalExtension();
            $path     = $file->storeAs($folder, $filename, 'public');

            if ($old = File::where('examination_id', $examination->id)->first()) {
                Storage::disk('public')->delete($old->file_path);
                $old->delete();
            }

            File::create([
                'examination_id' => $examination->id,
                'file_path'      => $path,
                'file_name'      => $file->getClientOriginalName(),
                'file_mime'      => $file->getClientMimeType(),
                'file_size'      => $file->getSize(),
            ]);
        }

        return redirect()->back()->with('success', 'Data berhasil diperbarui!');
    }

    /**
     * Store a new patient, examination, prescriptions, and optional file.
     *
     * @param  Request  $request
     * @return RedirectResponse
     */
    public function store(Request $request): RedirectResponse
    {
        $validator = Validator::make(
            $request->all(),
            [
                'nik'               => ['required', 'digits:16'],
                'bpjs'              => ['nullable', 'digits:13'],
                'name'              => ['required', 'string', 'max:255'],
                'phone'             => ['required', 'string', 'max:20'],
                'bhirt_place'       => ['required', 'string', 'max:100'],
                'bhirt_date'        => ['required', 'date'],
                'address'           => ['required', 'string', 'max:500'],
                'weight'            => ['required', 'numeric', 'between:1,500'],
                'height'            => ['required', 'numeric', 'between:30,250'],
                'diastole'          => ['required', 'integer', 'between:40,130'],
                'systole'           => ['required', 'integer', 'between:70,250', 'gt:diastole'],
                'respiratory_rate'  => ['required', 'integer', 'between:8,40'],
                'temperature'       => ['required', 'numeric', 'between:30,45'],
                'heart_rate'        => ['required', 'integer', 'between:30,220'],
                'quantities'        => ['required', 'array'],
                'quantities.*'      => ['nullable', 'integer', 'min:0'],
                'file'              => ['nullable', 'file', 'mimes:pdf,jpg,jpeg,png,doc,docx,xlsx,xls', 'max:2048'],
            ],
            [
                'required' => ':attribute wajib diisi.',
                'digits'   => ':attribute harus :digits digit.',
                'numeric'  => ':attribute harus berupa angka.',
                'integer'  => ':attribute harus berupa bilangan bulat.',
                'date'     => ':attribute harus tanggal yang valid.',
                'before'   => ':attribute harus sebelum hari ini.',
                'between'  => ':attribute harus antara :min dan :max.',
                'max'      => ':attribute maksimal :max karakter.',
                'custom'   => [
                    'systole' => [
                        'gt' => 'Sistole (mmHg) harus lebih besar dari Diastole (mmHg).',
                    ],
                ],
            ],
            [
                'nik'              => 'NIK',
                'bpjs'             => 'No. BPJS',
                'name'             => 'Nama',
                'phone'            => 'No. Telepon',
                'bhirt_place'      => 'Tempat lahir',
                'bhirt_date'       => 'Tanggal lahir',
                'address'          => 'Alamat',
                'weight'           => 'Berat badan (kg)',
                'height'           => 'Tinggi badan (cm)',
                'diastole'         => 'Diastole (mmHg)',
                'systole'          => 'Sistole (mmHg)',
                'respiratory_rate' => 'Laju napas (x/menit)',
                'temperature'      => 'Suhu tubuh (°C)',
                'heart_rate'       => 'Detak jantung (bpm)',
                'quantities'       => 'Daftar Obat',
            ]
        );

        if ($validator->fails()) {
            return back()->withErrors($validator)->withInput();
        }

        // Create patient
        $patient = new Patient();
        $patient->nik         = $request->get('nik');
        $patient->bpjs        = $request->get('bpjs');
        $patient->name        = $request->get('name');
        $patient->phone       = $request->get('phone');
        $patient->bhirt_place = $request->get('bhirt_place');
        $patient->bhirt_date  = $request->get('bhirt_date');
        $patient->address     = $request->get('address');
        $patient->save();

        // Create examination
        $examination = new Examination();
        $examination->date             = $request->get('date');
        $examination->patient_id       = $patient->id;
        $examination->weight           = $request->get('weight');
        $examination->height           = $request->get('height');
        $examination->diastole         = $request->get('diastole');
        $examination->systole          = $request->get('systole');
        $examination->respiratory_rate = $request->get('respiratory_rate');
        $examination->temperature      = $request->get('temperature');
        $examination->heart_rate       = $request->get('heart_rate');
        $examination->save();

        // Create prescriptions
        foreach ($request->quantities as $medicineId => $qty) {
            if ($qty) {
                $medicinePrice = MedicinePrice::where('medicine_id', $medicineId)
                    ->where('start_date', '<=', $request->get('date'))
                    ->where(function ($q) use ($request) {
                        $q->whereNull('end_date')
                            ->orWhereDate('end_date', '>=', $request->get('date'));
                    })
                    ->first();

                if ($medicinePrice) {
                    $medicalPrescription = new MedicalPrescription();
                    $medicalPrescription->examination_id    = $examination->id;
                    $medicalPrescription->medicine_price_id = $medicinePrice->id;
                    $medicalPrescription->qty               = $qty;
                    $medicalPrescription->total_price       = $qty * $medicinePrice->unit_price;
                    $medicalPrescription->save();
                }
            }
        }

        // Optional file upload
        if ($request->hasFile('file')) {
            $file     = $request->file('file');
            $folder   = 'uploads/examinations';
            $filename = Str::uuid() . '.' . $file->getClientOriginalExtension();
            $path     = $file->storeAs($folder, $filename, 'public');

            File::where('examination_id', $examination->id)->delete();

            $fileModel               = new File();
            $fileModel->examination_id = $examination->id;
            $fileModel->file_path      = $path;
            $fileModel->file_name      = $file->getClientOriginalName();
            $fileModel->file_mime      = $file->getClientMimeType();
            $fileModel->file_size      = $file->getSize();
            $fileModel->save();
        }

        return redirect()->back()->with('success', 'Berhasil menambahkan data!');
    }

    /**
     * Show the edit form with patient, examination, medicines,
     * and prefilled prescription quantities by medicine.
     *
     * @param  int  $id  Patient ID
     * @return View
     */
    public function edit(int $id): View
    {
        $patients = Patient::with([
            'examination',
            'examination.file',
            'examination.medical_prescriptions.medicine_price.medicine',
        ])->findOrFail($id);

        $medicines = Medicine::all();

        $prescriptions = collect($patients->examination->medical_prescriptions ?? [])
            ->mapWithKeys(function ($prescription) {
                $medicineId = $prescription->medicine_price->medicine_id ?? null;

                return $medicineId ? [$medicineId => $prescription->qty] : [];
            });

        return view('template.menu.examintation.edit', compact(
            'patients',
            'medicines',
            'prescriptions'
        ));
    }

    /**
     * Mark an examination as paid (done).
     *
     * @param  int  $id  Examination ID
     * @return RedirectResponse
     */
    public function payment(int $id): RedirectResponse
    {
        $examination         = Examination::find($id);
        $examination->status = 'done';
        $examination->save();

        return redirect()->back()->with('success', 'Berhasil melakukan pembayaran!');
    }

    /**
     * Generate and stream the prescription payment receipt (PDF) for a patient.
     *
     * @param  int  $id  Patient ID
     * @return \Symfony\Component\HttpFoundation\StreamedResponse
     */
    public function printReceipt(int $id)
    {
        $patient = Patient::with([
            'examination',
            'examination.file',
            'examination.medical_prescriptions.medicine_price.medicine',
        ])->findOrFail($id);

        return Pdf::loadView('pdf.receipt', ['patient' => $patient])
            ->setPaper('A4', 'portrait')
            ->stream('resi-obat-' . $patient->id . '.pdf');
    }
}
