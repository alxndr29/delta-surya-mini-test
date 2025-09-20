@extends('template.components.index')

@section('title', 'Log Aktivitas')

@section('content')
    <div class="card mb-5 mb-xl-10" id="kt_profile_details_view">
        <div class="card-header cursor-pointer">
            <div class="card-title m-0">
                <h3 class="fw-bold m-0">Log Aktivitas Pengguna</h3>
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
                            rowspan="1" colspan="1" aria-label="Customer: activate to sort column ascending"
                            style="width: 223.094px;">Waktu
                        </th>
                        <th class="min-w-125px sorting" tabindex="0" aria-controls="kt_subscriptions_table"
                            rowspan="1" colspan="1" aria-label="Status: activate to sort column ascending"
                            style="width: 223.094px;">Log
                        </th>
                        <th class="min-w-125px sorting" tabindex="0" aria-controls="kt_subscriptions_table"
                            rowspan="1" colspan="1" aria-label="Billing: activate to sort column ascending"
                            style="width: 237.953px;">Deskripsi
                        </th>
                        <th class="min-w-125px sorting" tabindex="0" aria-controls="kt_subscriptions_table"
                            rowspan="1" colspan="1" aria-label="Billing: activate to sort column ascending"
                            style="width: 237.953px;">User
                        </th>
                        <th class="min-w-125px sorting" tabindex="0" aria-controls="kt_subscriptions_table"
                            rowspan="1" colspan="1" aria-label="Billing: activate to sort column ascending"
                            style="width: 237.953px;">Properties
                        </th>
                    </tr>
                    </thead>
                    <tbody class="text-gray-600 fw-semibold">
                    @foreach ($logs as $key => $log)
                        <tr class="odd">
                            <td>
                                {{ $key + 1 }}
                            </td>
                            <td>
                                <div>{{ $log->created_at->format('d-m-Y H:i:s') }}</div>
                            </td>
                            <td>{{ $log->causer?->name ?? 'System' }}</td>
                            <td>
                                <div>{{ $log->log_name }}</div>
                            </td>
                            <td>
                                <div>{{ $log->description  }}</div>
                            </td>
                            <td>
                                <pre class="mb-0">{{ json_encode($log->properties, JSON_PRETTY_PRINT) }}</pre>
                            </td>
                        </tr>
                    @endforeach
                    </tbody>
                </table>
            </div>
            <div class="row pt-3">
                <div class="col d-flex justify-content-end">
                    {{ $logs->links() }}
                </div>
            </div>
        </div>
@endsection
