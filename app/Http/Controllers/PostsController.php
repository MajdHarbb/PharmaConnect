<?php

namespace App\Http\Controllers;

use Illuminate\Support\Facades\Auth;
use Illuminate\Http\Request;
use App\Models\User;
use App\Models\Post;
use App\Models\Postfind;
use App\Models\Info;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Storage;
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
        ]);
        if($validator->fails()){
            return response()->json($validator->errors()->toJson(), 400);
        }
        

        $data = $request->all();
        $user = new Post;

        $image_64 = $data["post_pic"];//your base64 encoded data
        $extension = explode('/', explode(':', substr($image_64, 0, strpos($image_64, ';')))[1])[1];   // .jpg .png .pdf

        $replace = substr($image_64, 0, strpos($image_64, ',')+1); 

        // find substring fro replace here eg: data:image/png;base64,

        $image = str_replace($replace, '', $image_64); 

        $image = str_replace(' ', '+', $image); 

        $imageName = $user->id.'.'.$extension;
        
        
        $user->user_id = $data["user_id"];
        $user->post_text = $data["post_text"];
        $user->post_pic = $imageName;
        $user->save();
        Storage::disk('posts')->put($user->id.'.'.$extension, base64_decode($image));
        return response()->json([
            'message' => 'Post successfully added',
            'post' => $image,
        ], 201);
    }
}
