<?php

namespace App\Http\Controllers;

use App\Models\Examination;
use App\Models\File;
use App\Models\MedicalPrescription;
use App\Models\Medicine;
use App\Models\MedicinePrice;
use App\Models\Patient;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Storage;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Str;
use Illuminate\View\View;

class ExaminationController extends Controller
{
    //
    public function index(): View
    {
        $patients = Patient::with([
            'examination',
        ])->paginate(10);
        return view('template.menu.examintation.index', compact('patients'));
    }

    public function create(): View
    {
        $medicines = Medicine::all();
        return view('template.menu.examintation.create', compact('medicines'));
    }

    public function update(Request $request, $id)
    {
        $validator = Validator::make(
            $request->all(),
            [
                'nik' => ['required', 'digits:16'],
                'bpjs' => ['nullable', 'digits:13'],
                'name' => ['required', 'string', 'max:255'],
                'phone' => ['required', 'string', 'max:20'],
                'bhirt_place' => ['required', 'string', 'max:100'],
                'bhirt_date' => ['required', 'date'],
                'address' => ['required', 'string', 'max:500'],
                'date' => ['required', 'date'],
                'weight' => ['required', 'numeric', 'between:1,500'],
                'height' => ['required', 'numeric', 'between:30,250'],
                'diastole' => ['required', 'integer', 'between:40,130'],
                'systole' => ['required', 'integer', 'between:70,250', 'gt:diastole'],
                'respiratory_rate' => ['required', 'integer', 'between:8,40'],
                'temperature' => ['required', 'numeric', 'between:30,45'],
                'heart_rate' => ['required', 'integer', 'between:30,220'],
                'quantities' => ['required', 'array'],
                'quantities.*' => ['nullable', 'integer', 'min:0'],
                'file' => ['nullable', 'file', 'mimes:pdf,jpg,jpeg,png,doc,docx,xlsx,xls', 'max:2048'],
            ]
        );

        if ($validator->fails()) {
            return back()->withErrors($validator)->withInput();
        }

        $patient = Patient::findOrFail($id);
        $patient->nik = $request->nik;
        $patient->bpjs = $request->bpjs;
        $patient->name = $request->name;
        $patient->phone = $request->phone;
        $patient->bhirt_place = $request->bhirt_place;
        $patient->bhirt_date = $request->bhirt_date;
        $patient->address = $request->address;
        $patient->save();

        $examination = Examination::where('patient_id', $patient->id)->firstOrFail();
        $examination->date = $request->date;
        $examination->weight = $request->weight;
        $examination->height = $request->height;
        $examination->diastole = $request->diastole;
        $examination->systole = $request->systole;
        $examination->respiratory_rate = $request->respiratory_rate;
        $examination->temperature = $request->temperature;
        $examination->heart_rate = $request->heart_rate;
        $examination->save();

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
                        'examination_id' => $examination->id,
                        'medicine_price_id' => $medicinePrice->id,
                        'qty' => $qty,
                        'total_price' => $qty * $medicinePrice->unit_price,
                    ]);
                }
            }
        }

        if ($request->hasFile('file')) {
            $file = $request->file('file');
            $folder = 'uploads/examinations';
            $filename = Str::uuid() . '.' . $file->getClientOriginalExtension();
            $path = $file->storeAs($folder, $filename, 'public');
            if ($old = File::where('examination_id', $examination->id)->first()) {
                Storage::disk('public')->delete($old->file_path);
                $old->delete();
            }
            File::create([
                'examination_id' => $examination->id,
                'file_path' => $path,
                'file_name' => $file->getClientOriginalName(),
                'file_mime' => $file->getClientMimeType(),
                'file_size' => $file->getSize(),
            ]);
        }
        return redirect()->back()->with('success', 'Data berhasil diperbarui!');
    }

    public function store(Request $request)
    {
        $validator = Validator::make(
            $request->all(),
            [
                'nik' => ['required', 'digits:16'],
                'bpjs' => ['nullable', 'digits:13'],
                'name' => ['required', 'string', 'max:255'],
                'phone' => ['required', 'string', 'max:20'],
                'bhirt_place' => ['required', 'string', 'max:100'],
                'bhirt_date' => ['required', 'date'],
                'address' => ['required', 'string', 'max:500'],
                'weight' => ['required', 'numeric', 'between:1,500'],
                'height' => ['required', 'numeric', 'between:30,250'],
                'diastole' => ['required', 'integer', 'between:40,130'],
                'systole' => ['required', 'integer', 'between:70,250', 'gt:diastole'],
                'respiratory_rate' => ['required', 'integer', 'between:8,40'],
                'temperature' => ['required', 'numeric', 'between:30,45'],
                'heart_rate' => ['required', 'integer', 'between:30,220'],
                'quantities' => ['required', 'array'],
                'quantities.*' => ['nullable', 'integer', 'min:0'],

                'file' => ['nullable', 'file', 'mimes:pdf,jpg,jpeg,png,doc,docx,xlsx,xls', 'max:2048'],
            ],
            [
                'required' => ':attribute wajib diisi.',
                'digits' => ':attribute harus :digits digit.',
                'numeric' => ':attribute harus berupa angka.',
                'integer' => ':attribute harus berupa bilangan bulat.',
                'date' => ':attribute harus tanggal yang valid.',
                'before' => ':attribute harus sebelum hari ini.',
                'between' => ':attribute harus antara :min dan :max.',
                'max' => ':attribute maksimal :max karakter.',
                'custom' => [
                    'systole' => [
                        'gt' => 'Sistole (mmHg) harus lebih besar dari Diastole (mmHg).',
                    ],
                ],
            ],
            [
                'nik' => 'NIK',
                'bpjs' => 'No. BPJS',
                'name' => 'Nama',
                'phone' => 'No. Telepon',
                'bhirt_place' => 'Tempat lahir',
                'bhirt_date' => 'Tanggal lahir',
                'address' => 'Alamat',
                'weight' => 'Berat badan (kg)',
                'height' => 'Tinggi badan (cm)',
                'diastole' => 'Diastole (mmHg)',
                'systole' => 'Sistole (mmHg)',
                'respiratory_rate' => 'Laju napas (x/menit)',
                'temperature' => 'Suhu tubuh (°C)',
                'heart_rate' => 'Detak jantung (bpm)',
                'quantities' => 'Daftar Obat'
            ]
        );

        if ($validator->fails()) {
            return back()->withErrors($validator)->withInput();
        } else {
            $patient = new Patient();
            $patient->nik = $request->get('nik');
            $patient->bpjs = $request->get('bpjs');
            $patient->name = $request->get('name');
            $patient->phone = $request->get('phone');
            $patient->bhirt_place = $request->get('bhirt_place');
            $patient->bhirt_date = $request->get('bhirt_date');
            $patient->address = $request->get('address');
            $patient->save();

            $examination = new Examination();
            $examination->date = $request->get('date');
            $examination->patient_id = $patient->id;
            $examination->weight = $request->get('weight');
            $examination->height = $request->get('height');
            $examination->diastole = $request->get('diastole');
            $examination->systole = $request->get('systole');
            $examination->respiratory_rate = $request->get('respiratory_rate');
            $examination->temperature = $request->get('temperature');
            $examination->heart_rate = $request->get('heart_rate');
            $examination->save();

            foreach ($request->quantities as $key => $value) {
                if ($value) {
                    $medicinePrice = MedicinePrice::where('medicine_id', $key)
                        ->where('start_date', '<=', $request->get('date'))
                        ->where(function ($q) use ($request) {
                            $q->whereNull('end_date')
                                ->orWhereDate('end_date', '>=', $request->get('date'));
                        })
                        ->first();
                    if ($medicinePrice) {
                        $medicalPrescription = new MedicalPrescription();
                        $medicalPrescription->examination_id = $examination->id;
                        $medicalPrescription->medicine_price_id = $medicinePrice->id;
                        $medicalPrescription->qty = $value;
                        $medicalPrescription->total_price = $value * $medicinePrice->unit_price;
                        $medicalPrescription->save();
                    }
                }
            }

            if ($request->hasFile('file')) {
                $file = $request->file('file');
                $folder = 'uploads/examinations';
                $filename = Str::uuid() . '.' . $file->getClientOriginalExtension();
                $path = $file->storeAs($folder, $filename, 'public');

                File::where('examination_id', $examination->id)->delete();

                $fileModel = new File();
                $fileModel->examination_id = $examination->id;
                $fileModel->file_path = $path;
                $fileModel->file_name = $file->getClientOriginalName();
                $fileModel->file_mime = $file->getClientMimeType();
                $fileModel->file_size = $file->getSize();
                $fileModel->save();
            }
        }
        return redirect()->back()->with('success', 'Berhasil menambahkan data!');
    }

    public function edit($id): View
    {
        $patients = Patient::with('examination',
            'examination.file',
            'examination.medical_prescriptions.medicine_price')
            ->findOrFail($id);

        $medicines = Medicine::all();
        $prescriptions = collect($patients->examination->medical_prescriptions ?? [])
            ->mapWithKeys(function ($prescription) {
                $medicineId = $prescription->medicine_price->medicine_id ?? null;
                return $medicineId
                    ? [$medicineId => $prescription->qty]
                    : [];
            });
        return view('template.menu.examintation.edit', compact(
                'patients',
                'medicines',
                'prescriptions')
        );
    }

    public function payment($id)
    {
        $examination = Examination::find($id);
        $examination->status = "done";
        $examination->save();
        return redirect()->back()->with('success', 'Berhasil melakukan pembayaran!');
    }
}
