@extends('template.components.index')

@section('title', 'Detail Data Pasien')

@section('content')
    <div class="card mb-5 mb-xl-10" id="kt_profile_details_view">
        <div class="card-body">
            @if (\Illuminate\Support\Facades\Auth::user()->role->slug == "apoteker")
                @if($patients->examination->status == "process")
                    <form method="POST" action="{{ route('examination.payment', ['id' => $patients->examination->id]) }}">
                        @csrf
                        @method('PUT')
                        <button type="submit" class="btn btn-danger mb-3" id="kt_account_profile_details_submit">
                            Proses Pembayaran
                        </button>
                    </form>
                @endif
                @if($patients->examination->status == "done")
                    <button type="submit" class="btn btn-success mb-3" id="kt_account_profile_details_submit">
                        Cetak Resi
                    </button>
                @endif

            @endif

            <form method="POST" action="{{ route('examination.update', $patients->id) }}" enctype="multipart/form-data">
                @csrf
                @method('PUT')

                @if (\Illuminate\Support\Facades\Auth::user()->role->slug == "dokter")
                    @if($patients->examination->status == "process")
                        <div class="alert alert-info" role="alert">
                            Anda masih dapat mengubah resep jika masih belum di proses olek apoteker.
                        </div>
                    @else
                        <div class="alert alert-danger" role="alert">
                            Anda tidak dapat mengubah resep karena sudah selesai di proses apoteker.
                        </div>
                    @endif
                @endif
                <div class="card">
                    <div class="card-header cursor-pointer">
                        <div class="card-title m-0">
                            <h3 class="fw-bold m-0">Tanggal Pemeriksaan</h3>
                        </div>
                    </div>
                    <div class="card-body">
                        <div class="row mb-6">
                            <label class="col-lg-4 col-form-label required fw-semibold fs-6">Tanggal</label>
                            <div class="col-lg-8 fv-row fv-plugins-icon-container">
                                <input type="text" name="date"
                                       class="form-control form-control-lg form-control-solid"
                                       placeholder="Tanggal Pemeriksaan" required
                                       value="{{$patients->examination->date}}" readonly>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="card">
                    <div class="card-header cursor-pointer">
                        <div class="card-title m-0">
                            <h3 class="fw-bold m-0">Tambah Identitas Pasien</h3>
                        </div>
                    </div>
                    <div class="card-body">
                        <div class="row mb-6">
                            <label class="col-lg-4 col-form-label required fw-semibold fs-6">NIK & BPJS</label>
                            <div class="col-lg-8">
                                <div class="row">
                                    <div class="col-lg-6 fv-row fv-plugins-icon-container">
                                        <input type="number" name="nik"
                                               class="form-control form-control-lg form-control-solid mb-3 mb-lg-0"
                                               placeholder="No. NIK" required
                                               value="{{ $patients->nik }}" readonly>
                                    </div>
                                    <div class="col-lg-6 fv-row fv-plugins-icon-container">
                                        <input type="number" name="bpjs"
                                               class="form-control form-control-lg form-control-solid"
                                               placeholder="No. BPJS" required
                                               value="{{ $patients->bpjs }}" readonly>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row mb-6">
                            <label class="col-lg-4 col-form-label required fw-semibold fs-6">Nama Lengkap</label>
                            <div class="col-lg-8 fv-row fv-plugins-icon-container">
                                <input type="text" name="name"
                                       class="form-control form-control-lg form-control-solid"
                                       placeholder="Nama Lengkap" required
                                       value="{{ $patients->name }}" readonly>
                            </div>
                        </div>
                        <div class="row mb-6">
                            <label class="col-lg-4 col-form-label required fw-semibold fs-6">Telepon</label>
                            <div class="col-lg-8 fv-row fv-plugins-icon-container">
                                <input type="number" name="phone"
                                       class="form-control form-control-lg form-control-solid"
                                       placeholder="No. Telepon" required
                                       value="{{ $patients->phone }}" readonly>
                            </div>
                        </div>
                        <div class="row mb-6">
                            <label class="col-lg-4 col-form-label required fw-semibold fs-6">Tempat, Tanggal
                                Lahir</label>
                            <div class="col-lg-8">
                                <div class="row">
                                    <div class="col-lg-6 fv-row fv-plugins-icon-container">
                                        <input type="text" name="bhirt_place"
                                               class="form-control form-control-lg form-control-solid mb-3 mb-lg-0"
                                               placeholder="Tempat lahir" required
                                               value="{{ $patients->bhirt_place }}" readonly>
                                    </div>
                                    <div class="col-lg-6 fv-row fv-plugins-icon-container">
                                        <input type="date" name="bhirt_date"
                                               class="form-control form-control-lg form-control-solid"
                                               placeholder="Tanggal Lahir" required
                                               value="{{  $patients->bhirt_date }}" readonly>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row mb-6">
                            <label class="col-lg-4 col-form-label required fw-semibold fs-6">Alamat</label>
                            <div class="col-lg-8 fv-row fv-plugins-icon-container">
                                <input type="text" name="address"
                                       class="form-control form-control-lg form-control-solid"
                                       placeholder="Alamat" required
                                       value="{{  $patients->address }}" readonly>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="card">
                    <div class="card-header cursor-pointer">
                        <div class="card-title m-0">
                            <h3 class="fw-bold m-0">Data Pemeriksaan Pasien</h3>
                        </div>
                    </div>
                    <div class="card-body">
                        <div class="row mb-6">
                            <label class="col-lg-4 col-form-label required fw-semibold fs-6">Berat & Tinggi
                                Badan</label>
                            <div class="col-lg-8">
                                <div class="row">
                                    <div class="col-lg-6 fv-row fv-plugins-icon-container">
                                        <input type="number" name="weight"
                                               class="form-control form-control-lg form-control-solid mb-3 mb-lg-0"
                                               placeholder="Berat" required
                                               value="{{ $patients->examination->weight }}">
                                    </div>
                                    <div class="col-lg-6 fv-row fv-plugins-icon-container">
                                        <input type="number" name="height"
                                               class="form-control form-control-lg form-control-solid"
                                               placeholder="Tinggi Badan" required
                                               value="{{ $patients->examination->height }}">
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row mb-6">
                            <label class="col-lg-4 col-form-label required fw-semibold fs-6">Systole & Diastole</label>
                            <div class="col-lg-8">
                                <div class="row">
                                    <div class="col-lg-6 fv-row fv-plugins-icon-container">
                                        <input type="number" name="systole"
                                               class="form-control form-control-lg form-control-solid"
                                               placeholder="Systole" required
                                               value="{{ $patients->examination->systole }}">
                                    </div>
                                    <div class="col-lg-6 fv-row fv-plugins-icon-container">
                                        <input type="number" name="diastole"
                                               class="form-control form-control-lg form-control-solid mb-3 mb-lg-0"
                                               placeholder="Diastole" required
                                               value="{{$patients->examination->diastole}}">
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row mb-6">
                            <label class="col-lg-4 col-form-label required fw-semibold fs-6">Respiration Rate</label>
                            <div class="col-lg-8 fv-row fv-plugins-icon-container">
                                <input type="number" name="respiratory_rate"
                                       class="form-control form-control-lg form-control-solid"
                                       placeholder="Respiration Rate" required
                                       value="{{ $patients->examination->respiratory_rate }}">
                            </div>
                        </div>
                        <div class="row mb-6">
                            <label class="col-lg-4 col-form-label required fw-semibold fs-6">Suhu Tubuh</label>
                            <div class="col-lg-8 fv-row fv-plugins-icon-container">
                                <input type="number" name="temperature"
                                       class="form-control form-control-lg form-control-solid"
                                       placeholder="Suhu Tubuh" required
                                       value="{{ $patients->examination->temperature }}">
                            </div>
                        </div>
                        <div class="row mb-6">
                            <label class="col-lg-4 col-form-label required fw-semibold fs-6">Heart Rate</label>
                            <div class="col-lg-8 fv-row fv-plugins-icon-container">
                                <input type="number" name="heart_rate"
                                       class="form-control form-control-lg form-control-solid"
                                       placeholder="Heart Rate" required
                                       value="{{$patients->examination->heart_rate }}">
                            </div>
                        </div>

                    </div>
                </div>

                <div class="card">
                    <div class="card-header cursor-pointer">
                        <div class="card-title m-0">
                            <h3 class="fw-bold m-0">Resep Obat</h3>
                        </div>
                    </div>
                    <div class="card-body">
                        <div class="row mb-6">
                            <label class="col-lg-4 col-form-label required fw-semibold fs-6">Upload File Resep</label>
                            <div class="col-lg-8 fv-row fv-plugins-icon-container">
                                <input type="file" name="file"
                                       class="form-control form-control-lg form-control-solid"
                                       placeholder="File"
                                       accept=".pdf,.jpg,.jpeg,.png,.doc,.docx,.xls,.xlsx">
                            </div>
                        </div>
                        @php
                            $file = $patients->examination->file ?? null;
                            $url = $file && $file->file_path
                                ? \Illuminate\Support\Facades\Storage::disk('public')->url($file->file_path)
                                : null;
                        @endphp

                        @if ($url)
                            <a href="{{ $url }}" target="_blank" class="btn btn-sm btn-primary p-3">
                                Lihat / Unduh ({{ $file->file_name }})
                            </a>
                        @endif
                        <div class="row mb-6">
                            <label class="col-lg-4 col-form-label required fw-semibold fs-6">
                                Masukan jumlah obat yang
                                diperlukan dibawah ini
                            </label>
                        </div>
                        <div class="table-responsive">
                            <table
                                class="table table-bordered border align-middle table-row-dashed fs-6 gy-5 dataTable no-footer"
                                id="kt_subscriptions_table">
                                <thead>
                                <tr class="text-start text-muted fw-bold fs-7 text-uppercase gs-0">
                                    <th class="min-w-125px sorting" tabindex="0" aria-controls="kt_subscriptions_table"
                                        rowspan="1" colspan="1" aria-label="Customer: activate to sort column ascending"
                                        style="width: 223.094px;">No
                                    </th>
                                    <th class="min-w-125px sorting" tabindex="0" aria-controls="kt_subscriptions_table"
                                        rowspan="1" colspan="1" aria-label="Customer: activate to sort column ascending"
                                        style="width: 223.094px;">Nama
                                    </th>
                                    <th class="text-end min-w-70px sorting_disabled" rowspan="1" colspan="1"
                                        aria-label="Actions" style="width: 183.312px;"> Qty
                                    </th>
                                </tr>
                                </thead>
                                <tbody class="text-gray-600 fw-semibold">
                                @foreach ($medicines as $key => $value)

                                    <tr class="odd">
                                        <td>{{ $key + 1 }}</td>
                                        <td>{{ $value->name }}</td>
                                        <td class="text-end">
                                            <input type="number" name="quantities[{{ $value->id }}]"
                                                   class="form-control form-control-lg form-control-solid mb-3 mb-lg-0"
                                                   placeholder="0" min="0"
                                                   value="{{ $prescriptions[$value->id] ?? 0 }}">
                                        </td>
                                    </tr>
                                @endforeach
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
                <div class="card-footer d-flex justify-content-end py-6 px-9">
                    @if (\Illuminate\Support\Facades\Auth::user()->role->slug == "dokter")
                        <button type="submit" class="btn btn-primary" id="kt_account_profile_details_submit">Simpan
                            Perubahan
                        </button>
                    @endif
                </div>
                <input type="hidden">
            </form>
        </div>
    </div>
@endsection
