<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Mattiverse\Userstamps\Traits\Userstamps;

class MedicalPrescription extends Model
{
    //
    use Userstamps;

    protected $fillable = [
        'examination_id',
        'medicine_price_id',
        'qty',
        'total_price',
        'description',
        'created_by',
        'updated_by',
        'deleted_by',
    ];

    protected $casts = [
        'qty' => 'integer',
        'total_price' => 'float',
    ];

    public function examination(): BelongsTo
    {
        return $this->belongsTo(Examination::class, 'examination_id', 'id');
    }

    public function medicine_price(): BelongsTo
    {
        return $this->belongsTo(MedicinePrice::class, 'medicine_price_id', 'id');
    }
}
