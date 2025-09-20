@extends('template.components.index')

@section('title', 'Pemeriksaan')

@section('content')
    <div class="card mb-5 mb-xl-10" id="kt_profile_details_view">
        <div class="card-header cursor-pointer">
            <div class="card-title m-0">
                <h3 class="fw-bold m-0">Daftar Pemeriksaan</h3>
            </div>
            @if (\Illuminate\Support\Facades\Auth::user()->role->slug == "dokter")
                <a href="{{route('examination.create')}}" class="btn btn-sm btn-danger align-self-center">
                    Tambah Data Pemeriksaan
                </a>
            @endif
        </div>
        <div class="card-body">
            <div class="table-responsive">
                <table class="table table-bordered border align-middle table-row-dashed fs-6 gy-5 dataTable no-footer"
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
                        <th class="min-w-125px sorting" tabindex="0" aria-controls="kt_subscriptions_table"
                            rowspan="1" colspan="1" aria-label="Status: activate to sort column ascending"
                            style="width: 223.094px;">Alamat
                        </th>
                        <th class="min-w-125px sorting" tabindex="0" aria-controls="kt_subscriptions_table"
                            rowspan="1" colspan="1" aria-label="Status: activate to sort column ascending"
                            style="width: 223.094px;">Telepon
                        </th>
                        <th class="min-w-125px sorting" tabindex="0" aria-controls="kt_subscriptions_table"
                            rowspan="1" colspan="1" aria-label="Status: activate to sort column ascending"
                            style="width: 223.094px;">Status
                        </th>
                        <th class="text-end min-w-70px sorting_disabled" rowspan="1" colspan="1"
                            aria-label="Actions" style="width: 183.312px;">Aksi
                        </th>
                    </tr>
                    </thead>
                    <tbody class="text-gray-600 fw-semibold">
                    @foreach ($patients as $key => $value)
                        <tr class="odd">
                            <td>
                                {{ $key + 1 }}
                            </td>
                            <td>
                                <div>{{ $value->name }}</div>
                            </td>
                            <td>
                                <div>{{ $value->address }}</div>
                            </td>
                            <td>
                                <div>{{ $value->phone }}</div>
                            </td>
                            <td>
                                @if($value->examination->status != 'done')
                                    <div class="badge badge-warning">{{$value->examination->status}}</div>
                                @else
                                    <div class="badge badge-success">{{$value->examination->status}}</div>
                                @endif
                            </td>
                            <td>
                                <a href="{{ route('examination.edit', $value->id) }}"
                                   class="btn btn-sm btn-primary align-self-center">
                                    Detail
                                </a>
                            </td>

                        </tr>
                    @endforeach
                    </tbody>
                </table>
            </div>
            <div class="row pt-3">
                <div class="col d-flex justify-content-end">

                </div>
            </div>
        </div>
@endsection
