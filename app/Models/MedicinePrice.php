<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Mattiverse\Userstamps\Traits\Userstamps;

class MedicinePrice extends Model
{
    use Userstamps;
    protected $fillable = [
        'unit_price',
        'uuid',
        'start_date',
        'end_date',
        'medicine_id',
    ];

    public function medicine():BelongsTo
    {
        return $this->belongsTo(Medicine::class,'medicine_id','id');
    }
}
