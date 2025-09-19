<?php

namespace App\Http\Controllers;

use App\Models\Examination;
use App\Models\Medicine;
use App\Models\Patient;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;
use Illuminate\View\View;

class ExaminationController extends Controller
{
    //
    public function index(): View
    {
        return view('template.menu.examintation.index');

    }

    public function create(): View
    {
        $medicines = Medicine::all();
        return view('template.menu.examintation.create', compact('medicines'));
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
                'bhirt_date' => ['required', 'date', 'before:today'],
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
            $examination->patient_id = $patient->id;
            $examination->weight = $request->get('weight');
            $examination->height = $request->get('height');
            $examination->diastole = $request->get('diastole');
            $examination->systole = $request->get('systole');
            $examination->respiratory_rate = $request->get('respiratory_rate');
            $examination->temperature = $request->get('temperature');
            $examination->heart_rate = $request->get('heart_rate');
            $examination->save();
        }
        return redirect()->back()->with('success', 'Berhasil menambahkan data!');
    }
}
