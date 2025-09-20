<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\HasOne;
use Mattiverse\Userstamps\Traits\Userstamps;
use Spatie\Activitylog\LogOptions;
use Spatie\Activitylog\Traits\LogsActivity;

class Patient extends Model
{
    use Userstamps, LogsActivity;

    protected $fillable = [
        'name',
        'bhirt_place',
        'bhirt_date',
        'address',
        'phone',
        'nik',
        'bpjs',
    ];

    /**
     * Activity log options.
     */
    public function getActivitylogOptions(): LogOptions
    {
        return LogOptions::defaults()
            ->useLogName('patient')
            ->logOnly([
                'name',
                'bhirt_place',
                'bhirt_date',
                'address',
                'phone',
                'nik',
                'bpjs',
            ])
            ->logOnlyDirty()
            ->dontSubmitEmptyLogs();
    }

    /**
     * Customize log description.
     */
    public function getDescriptionForEvent(string $eventName): string
    {
        return "Patient {$eventName} (ID: {$this->id}, Name: {$this->name})";
    }

    /**
     * Relations.
     */
    public function examination(): HasOne
    {
        return $this->hasOne(Examination::class, 'patient_id', 'id');
    }
}
