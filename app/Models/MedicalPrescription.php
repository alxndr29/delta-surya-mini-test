<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Mattiverse\Userstamps\Traits\Userstamps;
use Spatie\Activitylog\LogOptions;
use Spatie\Activitylog\Traits\LogsActivity;

class MedicalPrescription extends Model
{
    use Userstamps, LogsActivity;

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
        'qty'         => 'integer',
        'total_price' => 'float',
    ];

    /**
     * Activity log options.
     */
    public function getActivitylogOptions(): LogOptions
    {
        return LogOptions::defaults()
            ->useLogName('medical_prescription')
            ->logOnly([
                'examination_id',
                'medicine_price_id',
                'qty',
                'total_price',
                'description',
            ])
            ->logOnlyDirty()
            ->dontSubmitEmptyLogs();
    }

    /**
     * Customize log description.
     */
    public function getDescriptionForEvent(string $eventName): string
    {
        return "Medical Prescription {$eventName} (ID: {$this->id}, Qty: {$this->qty})";
    }

    /**
     * Relations.
     */
    public function examination(): BelongsTo
    {
        return $this->belongsTo(Examination::class, 'examination_id', 'id');
    }

    public function medicine_price(): BelongsTo
    {
        return $this->belongsTo(MedicinePrice::class, 'medicine_price_id', 'id');
    }
}
