<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Mattiverse\Userstamps\Traits\Userstamps;
use Spatie\Activitylog\LogOptions;
use Spatie\Activitylog\Traits\LogsActivity;

class MedicinePrice extends Model
{
    use Userstamps, LogsActivity;

    protected $fillable = [
        'unit_price',
        'uuid',
        'start_date',
        'end_date',
        'medicine_id',
    ];

    /**
     * Activity log options.
     */
    public function getActivitylogOptions(): LogOptions
    {
        return LogOptions::defaults()
            ->useLogName('medicine_price')
            ->logOnly([
                'unit_price',
                'uuid',
                'start_date',
                'end_date',
                'medicine_id',
            ])
            ->logOnlyDirty()
            ->dontSubmitEmptyLogs();
    }

    /**
     * Customize log description.
     */
    public function getDescriptionForEvent(string $eventName): string
    {
        return "Medicine Price {$eventName} (ID: {$this->id}, Price: {$this->unit_price})";
    }

    public function medicine(): BelongsTo
    {
        return $this->belongsTo(Medicine::class, 'medicine_id', 'id');
    }
}
