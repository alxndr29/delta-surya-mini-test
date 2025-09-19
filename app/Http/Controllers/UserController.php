<?php

namespace App\Http\Controllers;

use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\View\View;

class UserController extends Controller
{
    //
    public function index():View
    {
        $users = User::with(['role'])->paginate(10);
        return view('template.menu.user.index', compact('users'));
    }
}
