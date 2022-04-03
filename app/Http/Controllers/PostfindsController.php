<?php

namespace App\Http\Controllers;

use Illuminate\Support\Facades\Auth;
use Illuminate\Http\Request;
use App\Models\User;
use App\Models\Post;
use App\Models\Postfind;
use App\Models\Info;
use Illuminate\Support\Facades\DB;
use App\Models\Pharmacie;
use Validator;

class PostfindsController extends Controller
{
    //
    public function solvePost(Request $request){
        
        $data = $request->all();
        $user = new Postfind;
        $user->post_id = $data["post_id"];
        $user->poster_id = $data["poster_id"];
        $user->pharmacy_id = $data["pharmacy_id"];
        $user->save();

        return response()->json([
            'message' => 'Post successfully solved',
            'solved' => $user,
        ], 201);
    }

    public function postPharmacies(Request $request){
        $user_id = $request->user_id;
        $notifications=Postfind::where('poster_id', '=', $user_id)->exists();
        if($notifications){
            $posts = Postfind::where('poster_id', '=', $user_id)
            ->distinct()
            ->get();
            $user = null;
            foreach ($posts as $post) {
                $post;
            }
            
            return response()->json(
                $post,
            );
        }else{
            return response()->json([
                "No notifications yet",
            ], 400);
        }
    }
}
