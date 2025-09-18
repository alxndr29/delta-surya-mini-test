<?php

namespace Database\Seeders;

use App\Models\User;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class UserSeeder extends Seeder
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
                'email' => 'admin@email.com',
                'password' => bcrypt('12345678'),
                'role_id' => 1,
            ],
            [
                'id' => 2,
                'name' => 'Dokter A',
                'email' => 'dokter_a@email.com',
                'password' => bcrypt('12345678'),
                'role_id' => 2,
            ],
            [
                'id' => 3,
                'name' => 'Dokter B',
                'email' => 'dokter_b@email.com',
                'password' => bcrypt('12345678'),
                'role_id' => 2,
            ],
            [
                'id' => 4,
                'name' => 'Apoteker A',
                'email' => 'apoteker_a@email.com',
                'password' => bcrypt('12345678'),
                'role_id' => 3,
            ],
            [
                'id' => 5,
                'name' => 'Apoteker B',
                'email' => 'apoteker_b@email.com',
                'password' => bcrypt('12345678'),
                'role_id' => 3,
            ],
        ];

        DB::beginTransaction();
        try {
            foreach ($data as $item) {
                User::updateOrCreate(['id' => $item['id']], [
                        'id' => $item['id'],
                        'name' => $item['name'],
                        'email' => $item['email'],
                        'password' => $item['password'],
                        'role_id' => $item['role_id'],
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
