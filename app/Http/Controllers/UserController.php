<?php

namespace App\Http\Controllers;

use App\Models\User;
use Illuminate\Http\Request;

class UserController extends Controller
{
    //
    public function index()
    {
        $users = User::paginate(3);
        return view('template.menu.user.index', compact('users'));
    }
}
