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

class PostsController extends Controller
{
    public function userProfile() {
        $user = Auth::user();
        return response()->json($user);
    }

    public function addPost(Request $request){
        $validator = Validator::make($request->all(), [
            'post_text' => 'required|string|between:2,255',
            'post_pic' => 'required|string|between:2,255',
            
        ]);
        if($validator->fails()){
            return response()->json($validator->errors()->toJson(), 400);
        }
        

        $data = $request->all();
        $user = new Post;
        $user->user_id = $data["user_id"];
        $user->post_text = $data["post_text"];
        $user->post_pic = $data["post_pic"];
        $user->save();

        return response()->json([
            'message' => 'Post successfully added',
            'post' => $user,
        ], 201);
    }
}
