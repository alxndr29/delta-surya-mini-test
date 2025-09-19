@extends('template.components.index')

@section('title', 'Riwayat Harga Obat')

@section('content')
    <div class="card mb-5 mb-xl-10" id="kt_profile_details_view">
        <div class="card-header cursor-pointer">
            <div class="card-title m-0">
                <h3 class="fw-bold m-0">
                    Daftar Harga Obat: <a href="#" class="text-gray-400 "> {{$medicine->name}}</a>
                </h3>

            </div>
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
                            rowspan="1" colspan="1" aria-label="Status: activate to sort column ascending"
                            style="width: 223.094px;">Unit Price
                        </th>
                        <th class="min-w-125px sorting" tabindex="0" aria-controls="kt_subscriptions_table"
                            rowspan="1" colspan="1" aria-label="Status: activate to sort column ascending"
                            style="width: 223.094px;">Start Date
                        </th>
                        <th class="min-w-125px sorting" tabindex="0" aria-controls="kt_subscriptions_table"
                            rowspan="1" colspan="1" aria-label="Status: activate to sort column ascending"
                            style="width: 223.094px;">End Date
                        </th>
                    </tr>
                    </thead>
                    <tbody class="text-gray-600 fw-semibold">
                    @foreach ($medicinePrice as $key => $value)
                        <tr class="odd">
                            <td>
                                {{ $key + 1 }}
                            </td>

                            <td>
                                <div>{{ "Rp ". number_format($value->unit_price, 0, ',', '.') }}</div>
                            </td>
                            <td>
                                <div>{{ $value->start_date }}</div>
                            </td>
                            <td>
                                <div>{{ $value->end_date }}</div>
                            </td>
                        </tr>
                    @endforeach
                    </tbody>
                </table>
            </div>
            <div class="row pt-3">
                <div class="col d-flex justify-content-end">
                    {{ $medicinePrice->links() }}
                </div>
            </div>
        </div>
@endsection
