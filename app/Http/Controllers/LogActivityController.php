<?php

namespace App\Http\Controllers;

use Illuminate\View\View;
use Spatie\Activitylog\Models\Activity;

class LogActivityController extends Controller
{
    /**
     * Display a paginated list of activity logs with their causer.
     *
     * @return View
     */
    public function index(): View
    {
        $logs = Activity::with('causer')
            ->latest()
            ->paginate(10);
        return view('template.logs.index', compact('logs'));
    }
}
