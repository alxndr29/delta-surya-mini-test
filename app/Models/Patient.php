<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Mattiverse\Userstamps\Traits\Userstamps;

class Patient extends Model
{
    use Userstamps;

    protected $fillable = [
        'name',
        'bhirt_place',
        'bhirt_date',
        'address',
        'phone',
        'nik',
        'bpjs'
    ];
}
