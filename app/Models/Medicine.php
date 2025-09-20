<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\HasMany;
use Illuminate\Database\Eloquent\Relations\HasOne;
use Mattiverse\Userstamps\Traits\Userstamps;
use Spatie\Activitylog\LogOptions;
use Spatie\Activitylog\Traits\LogsActivity;

class Medicine extends Model
{
    use Userstamps, LogsActivity;

    /**
     * Attributes that can be mass-assigned.
     */
    protected $fillable = [
        'name',
        'uuid',
    ];

    /**
     * Activity log options (spatie v4+).
     */
    public function getActivitylogOptions(): LogOptions
    {
        return LogOptions::defaults()
            ->useLogName('medicine')
            ->logOnly(['name', 'uuid'])
            ->logOnlyDirty()
            ->dontSubmitEmptyLogs();
    }

    /**
     * Customize log description (optional).
     */
    public function getDescriptionForEvent(string $eventName): string
    {
        return "Medicine {$eventName} (ID: {$this->id}, Name: {$this->name})";
    }

    /**
     * Relations.
     */
    public function medicine_prices(): HasMany
    {
        return $this->hasMany(MedicinePrice::class, 'medicine_id', 'id');
    }

    public function medicine_last_prices(): HasOne
    {
        return $this->hasOne(MedicinePrice::class, 'medicine_id', 'id')
            ->orderBy('start_date', 'desc');
    }
}
