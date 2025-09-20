<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Mattiverse\Userstamps\Traits\Userstamps;
use Spatie\Activitylog\LogOptions;
use Spatie\Activitylog\Traits\LogsActivity;

class File extends Model
{
    use Userstamps, LogsActivity;

    protected $fillable = [
        'examination_id',
        'file_path',
        'file_name',
        'file_mime',
        'file_size',
    ];

    /**
     * Activity log options.
     */
    public function getActivitylogOptions(): LogOptions
    {
        return LogOptions::defaults()
            ->useLogName('file')
            ->logOnly([
                'examination_id',
                'file_path',
                'file_name',
                'file_mime',
                'file_size',
            ])
            ->logOnlyDirty()
            ->dontSubmitEmptyLogs();
    }

    /**
     * Customize log description.
     */
    public function getDescriptionForEvent(string $eventName): string
    {
        return "File {$eventName} (ID: {$this->id}, Name: {$this->file_name})";
    }

    /**
     * Relations.
     */
    public function examination(): BelongsTo
    {
        return $this->belongsTo(Examination::class, 'examination_id', 'id');
    }
}
