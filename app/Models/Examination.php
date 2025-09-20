<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;
use Illuminate\Database\Eloquent\Relations\HasOne;
use Mattiverse\Userstamps\Traits\Userstamps;

class Examination extends Model
{
    //
    use Userstamps;

    protected $fillable = [
        'date',
        'weight',
        'height',
        'systole',
        'diastole',
        'heart_rate',
        'respiratory_rate',
        'temperature',
        'patient_id',
        'status'
    ];

    public function patient(): BelongsTo
    {
        return $this->belongsTo(Patient::class, 'patient_id', 'id');
    }
    public function medical_prescriptions(): HasMany
    {
        return $this->hasMany(MedicalPrescription::class, 'examination_id', 'id');
    }
    public function file(): HasOne
    {
        return $this->hasOne(File::class, 'examination_id', 'id');
    }
}
