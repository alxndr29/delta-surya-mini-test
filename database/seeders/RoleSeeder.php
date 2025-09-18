<?php

namespace Database\Seeders;

use App\Models\Role;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class RoleSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        $data = [
            [
                'id' => 1,
                'name' => 'Administrator',
                'slug' => 'admin',

            ],
            [
                'id' => 2,
                'name' => 'Dokter',
                'slug' => 'dokter',
            ],
            [
                'id' => 3,
                'name' => 'Apoteker',
                'slug' => 'apoteker',
            ],

        ];

        DB::beginTransaction();
        try {
            foreach ($data as $item) {
                Role::updateOrCreate(['id' => $item['id']], [
                        'id' => $item['id'],
                        'name' => $item['name'],
                        'slug' => $item['slug'],
                    ]
                );
            }
            DB::commit();
        } catch (\Exception $e) {
            DB::rollBack();
            echo $e->getMessage();
        }

    }
}
