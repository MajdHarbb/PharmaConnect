<?php

namespace App\Http\Middleware;

use Illuminate\Auth\Middleware\Authenticate as Middleware;

class Authenticate extends Middleware
{
    //if not authenticated --> go to route not found (returns unauthorized)
    protected function redirectTo($request)
    {
        if (! $request->expectsJson()) {
            return route('not-found');
        }
    }
}
