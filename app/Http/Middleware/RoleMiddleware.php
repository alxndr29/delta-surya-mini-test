<?php

namespace App\Http\Middleware;

use Closure;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Symfony\Component\HttpFoundation\Response;

class RoleMiddleware
{
    public function handle(Request $request, Closure $next, ...$roles)
    {
        $user = Auth::user();

        if (!$user || !$user->role) {
            abort(403, 'Unauthorized');
        }

        // cek apakah role user ada dalam daftar role yang diizinkan
        if (! in_array($user->role->slug, $roles)) {
            abort(403, 'Unauthorized');
        }

        return $next($request);
    }
}
