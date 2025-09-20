<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Mattiverse\Userstamps\Traits\Userstamps;

class File extends Model
{
    use Userstamps;

    protected $fillable = [
        'examination_id',
        'file_path',
        'file_name',
        'file_mime',
        'file_size',
    ];

    public function examination(): BelongsTo
    {
        return $this->belongsTo(Examination::class, 'examination_id', 'id');
    }
}
