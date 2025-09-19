@extends('template.components.index')

@section('title', 'Master Pegawai')

@section('content')
    <div class="card mb-5 mb-xl-10" id="kt_profile_details_view">
        <div class="card-header cursor-pointer">
            <div class="card-title m-0">
                <h3 class="fw-bold m-0">Daftar Pengguna</h3>
            </div>
        </div>
        <div class="card-body">
            <div class="table-responsive">
                <table class="table table-bordered border align-middle table-row-dashed fs-6 gy-5 dataTable no-footer" id="kt_subscriptions_table">
                    <thead>
                        <tr class="text-start text-muted fw-bold fs-7 text-uppercase gs-0">
                            <th class="min-w-125px sorting" tabindex="0" aria-controls="kt_subscriptions_table"
                                rowspan="1" colspan="1" aria-label="Customer: activate to sort column ascending"
                                style="width: 223.094px;">No</th>
                            <th class="min-w-125px sorting" tabindex="0" aria-controls="kt_subscriptions_table"
                                rowspan="1" colspan="1" aria-label="Customer: activate to sort column ascending"
                                style="width: 223.094px;">Nama</th>
                            <th class="min-w-125px sorting" tabindex="0" aria-controls="kt_subscriptions_table"
                                rowspan="1" colspan="1" aria-label="Status: activate to sort column ascending"
                                style="width: 223.094px;">Email</th>
                            <th class="min-w-125px sorting" tabindex="0" aria-controls="kt_subscriptions_table"
                                rowspan="1" colspan="1" aria-label="Billing: activate to sort column ascending"
                                style="width: 237.953px;">Role</th>
{{--                            <th class="text-end min-w-70px sorting_disabled" rowspan="1" colspan="1"--}}
{{--                                aria-label="Actions" style="width: 183.312px;">AKSI</th>--}}
                        </tr>
                    </thead>
                    <tbody class="text-gray-600 fw-semibold">
                        @foreach ($users as $key => $value)
                            <tr class="odd">
                                <td>
                                    {{ $key + 1 }}
                                </td>
                                <td>
                                    <div>{{ $value->name }}</div>
                                </td>
                                <td>
                                    <div>{{ $value->email }}</div>
                                </td>
                                <td>
                                    <div class="badge badge-light">{{ $value->role->name }}</div>
                                </td>
{{--                                <td class="text-end">--}}
{{--                                    <a href="" class="btn btn-sm btn-primary align-self-center">Aksi</a>--}}
{{--                                </td>--}}
                            </tr>
                        @endforeach
                    </tbody>
                </table>
            </div>
            <div class="row pt-3">
                <div class="col d-flex justify-content-end">
                    {{ $users->links() }}
                </div>
            </div>
        </div>
    @endsection
