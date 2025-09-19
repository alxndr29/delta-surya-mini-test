<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\HasMany;
use Illuminate\Database\Eloquent\Relations\HasOne;
use Illuminate\Database\Eloquent\SoftDeletes;
use Mattiverse\Userstamps\Traits\Userstamps;

class Medicine extends Model
{
    use Userstamps;
    //
    protected $fillable = [
        'name',
        'uuid',
    ];

    public function medicine_prices(): HasMany
    {
        return $this->hasMany(MedicinePrice::class, 'medicine_id', 'id');
    }
    public function medicine_last_prices(): HasOne
    {
        return $this->hasOne(MedicinePrice::class, 'medicine_id', 'id')->orderBy('start_date','desc');
    }

}
