<?php

namespace App\Http\Controllers;

use App\Models\Medicine;
use App\Models\MedicinePrice;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Http;
use Illuminate\View\View;

/**
 * Controller for managing medicines and their prices.
 */
class MedicineController extends Controller
{
    /**
     * Display a paginated list of medicines with their latest price.
     *
     * @param Request $request
     * @return View
     */
    public function index(Request $request): View
    {
        $medicine = Medicine::with('medicine_last_prices')
            ->paginate(10);

        return view('template.menu.medicine.index', compact('medicine'));
    }

    /**
     * Display the specified medicine with all of its prices.
     *
     * @param int $id
     * @return View
     */
    public function show(int $id): View
    {
        $medicine = Medicine::with('medicine_prices')->find($id);
        $medicinePrice = MedicinePrice::where('medicine_id', $id)
            ->orderBy('start_date', 'desc')
            ->paginate(10);

        return view('template.menu.medicine.show', compact('medicine', 'medicinePrice'));
    }

    /**
     * Synchronize medicines and their prices from external API.
     *
     * - Authenticate using API credentials from env
     * - Fetch medicines list
     * - Store/update medicines and prices in local database
     *
     * @param Request $request
     * @return \Illuminate\Http\RedirectResponse
     */
    public function syncData(Request $request)
    {
        try {
            $authResponse = Http::post(env('API_URL') . 'auth', [
                'email' => env('API_AUTH_EMAIL'),
                'password' => env('API_AUTH_PASSWORD'),
            ]);

            if ($authResponse->successful()) {
                $authData = $authResponse->json();
                $token = $authData['access_token'] ?? null;

                if (!$token) {
                    return back()->with('error', 'Gagal autentikasi, periksa konfigurasi server!');
                }

                $medicinesResponse = Http::withToken($token)
                    ->get(env('API_URL') . 'medicines');

                if ($medicinesResponse->successful()) {
                    $dataListMedicine = $medicinesResponse->json();

                    foreach ($dataListMedicine['medicines'] as $item) {
                        $medicine = Medicine::updateOrCreate(
                            ['uuid' => $item['id']],
                            [
                                'uuid' => $item['id'],
                                'name' => $item['name'],
                            ]
                        );

                        $medicinesPriceResponse = Http::withToken($token)
                            ->get(env('API_URL') . 'medicines' . '/' . $item['id'] . '/prices');

                        if ($medicinesPriceResponse->successful()) {
                            $dataListMedicinePrice = $medicinesPriceResponse->json();

                            foreach ($dataListMedicinePrice['prices'] as $itemPrice) {
                                MedicinePrice::updateOrCreate(
                                    ['uuid' => $itemPrice['id']],
                                    [
                                        'medicine_id' => $medicine->id,
                                        'uuid' => $itemPrice['id'],
                                        'unit_price' => $itemPrice['unit_price'],
                                        'start_date' => $itemPrice['start_date']['value'],
                                        'end_date' => $itemPrice['end_date']['value'],
                                    ]
                                );
                            }

                            return back()->with('success', 'Berhasil sinkronisasi data obat!');
                        }

                        return back()->with('error', 'Gagal mendapatkan data harga obat!');
                    }
                } else {
                    return back()->with('error', 'Gagal mendapatkan data obat!');
                }
            }

            return back()->with('error', 'Gagal autentikasi, periksa konfigurasi server!');
        } catch (\Exception $exception) {
            return back()->with('error', $exception->getMessage());
        }
    }
}
