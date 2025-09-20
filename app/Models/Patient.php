<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasOne;
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

    public function examination(): HasOne
    {
        return $this->hasOne(Examination::class, 'patient_id', 'id');
    }
}
