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
            [
                'id' => 6,
                'name' => 'Apoteker C',
                'email' => 'apoteker_c@email.com',
                'password' => bcrypt('12345678'),
                'role_id' => 3,
            ],
            [
                'id' => 7,
                'name' => 'Apoteker D',
                'email' => 'apoteker_d@email.com',
                'password' => bcrypt('12345678'),
                'role_id' => 3,
            ],
            [
                'id' => 8,
                'name' => 'Apoteker E',
                'email' => 'apoteker_e@email.com',
                'password' => bcrypt('12345678'),
                'role_id' => 3,
            ],
            [
                'id' => 9,
                'name' => 'Apoteker F',
                'email' => 'apoteker_f@email.com',
                'password' => bcrypt('12345678'),
                'role_id' => 3,
            ],
            [
                'id' => 10,
                'name' => 'Apoteker G',
                'email' => 'apoteker_g@email.com',
                'password' => bcrypt('12345678'),
                'role_id' => 3,
            ],
            [
                'id' => 11,
                'name' => 'Apoteker H',
                'email' => 'apoteker_h@email.com',
                'password' => bcrypt('12345678'),
                'role_id' => 3,
            ],
            [
                'id' => 12,
                'name' => 'Apoteker I',
                'email' => 'apoteker_i@email.com',
                'password' => bcrypt('12345678'),
                'role_id' => 3,
            ],
            [
                'id' => 13,
                'name' => 'Apoteker J',
                'email' => 'apoteker_j@email.com',
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
