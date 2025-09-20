@php
    $fmt = fn($n) => 'Rp '.number_format((int)$n, 0, ',', '.');

    $rx = $patient->examination?->medical_prescriptions ?? collect();
    $items = $rx->map(function ($p) {
        $unit = (int) ($p->medicine_price->unit_price ?? 0);
        $qty  = (int) ($p->qty ?? 0);
        return [
            'name'       => $p->medicine_price->medicine->name ?? '-',
            'qty'        => $qty,
            'unit_price' => $unit,
            'subtotal'   => (int) ($p->total_price ?? ($qty * $unit)),
        ];
    });

    $grandTotal = $items->sum('subtotal');
@endphp
    <!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="utf-8">
    <title>Resi Pembayaran Obat</title>
    <style>
        @page {
            size: A4;
            margin: 16mm 14mm;
        }

        * {
            box-sizing: border-box;
        }

        body {
            font-family: DejaVu Sans, Arial, Helvetica, sans-serif;
            font-size: 12px;
            color: #111;
        }

        h2, h3 {
            margin: 0 0 4px;
        }

        .muted {
            color: #666;
            font-size: 11px;
        }

        .head {
            text-align: center;
            margin-bottom: 10px;
        }

        .section {
            border: 1px solid #ddd;
            border-radius: 6px;
            padding: 10px;
            margin-bottom: 10px;
        }

        .grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 8px 16px;
        }

        .label {
            color: #555;
            width: 130px;
            display: inline-block;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 6px;
        }

        th, td {
            border: 1px solid #ddd;
            padding: 8px 10px;
            vertical-align: top;
        }

        th {
            background: #f7f7f7;
            text-transform: uppercase;
            font-size: 11px;
            letter-spacing: .3px;
        }

        .right {
            text-align: right;
        }

        .center {
            text-align: center;
        }

        tfoot td {
            font-weight: 700;
        }

        .sign {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 20px;
            margin-top: 18px;
        }

        .box {
            border: 1px dashed #bbb;
            border-radius: 6px;
            height: 90px;
            text-align: center;
            padding-top: 10px;
        }
    </style>
</head>
<body>

{{-- Header --}}
<div class="head">
    <h2>Resi Pembayaran Obat</h2>
    <div>RS Delta Surya Husada</div>
    <div class="muted">
        Tanggal Pemeriksaan:
        {{ optional($patient->examination)->date ? \Carbon\Carbon::parse($patient->examination->date)->format('d/m/Y') : '-' }}
    </div>
</div>


{{--<div class="section">--}}
{{--    <div class="grid">--}}
{{--        <div><span class="label">Nama Dokter</span>: __________________________</div>--}}
{{--        <div><span class="label">Nama Apoteker</span>: ________________________</div>--}}
{{--    </div>--}}
{{--</div>--}}

<div class="section">
    <strong>Data Pasien</strong>
    <div class="grid" style="margin-top:6px;">
        <div><span class="label">Nama</span>: {{ $patient->name ?? '-' }}</div>
        <div><span class="label">NIK</span>: {{ $patient->nik ?? '-' }}</div>
        <div><span class="label">No. BPJS</span>: {{ $patient->bpjs ?? '-' }}</div>
        <div><span class="label">Telepon</span>: {{ $patient->phone ?? '-' }}</div>
        <div><span class="label">Tanggal Lahir</span>:
            {{ $patient->bhirt_date ? \Carbon\Carbon::parse($patient->bhirt_date)->format('d/m/Y') : '-' }}
        </div>
        <div style="grid-column:1 / -1;"><span class="label">Alamat</span>: {{ $patient->address ?? '-' }}</div>
    </div>
</div>

{{-- Tabel Obat --}}
<table>
    <thead>
    <tr>
        <th style="width:36px;">No</th>
        <th>Nama Obat</th>
        <th class="right" style="width:70px;">Qty</th>
        <th class="right" style="width:110px;">Harga Satuan</th>
        <th class="right" style="width:120px;">Subtotal</th>
    </tr>
    </thead>
    <tbody>
    @forelse($items as $i => $row)
        <tr>
            <td class="center">{{ $i + 1 }}</td>
            <td>{{ $row['name'] }}</td>
            <td class="right">{{ $row['qty'] }}</td>
            <td class="right">{{ $fmt($row['unit_price']) }}</td>
            <td class="right">{{ $fmt($row['subtotal']) }}</td>
        </tr>
    @empty
        <tr>
            <td colspan="5" class="center muted">Tidak ada data obat.</td>
        </tr>
    @endforelse
    </tbody>
    <tfoot>
    <tr>
        <td colspan="4" class="right">Total</td>
        <td class="right">{{ $fmt($grandTotal) }}</td>
    </tr>
    </tfoot>
</table>

{{--<div class="sign">--}}
{{--    <div class="box">--}}
{{--        <strong>Dokter</strong>--}}
{{--        <div style="margin-top:56px;">(__________________________)</div>--}}
{{--    </div>--}}
{{--    <div class="box">--}}
{{--        <strong>Apoteker</strong>--}}
{{--        <div style="margin-top:56px;">(__________________________)</div>--}}
{{--    </div>--}}
{{--</div>--}}

</body>
</html>
