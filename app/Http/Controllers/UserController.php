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




class UserController extends Controller
{

    public function userProfile() {
        $user = Auth::user();
        return response()->json($user);
    }

    public function pharmacyprofile(Request $request) {
        // $user = Auth::user();
        // return response()->json($user);
        $data=$request->all();
        $type=$request->user_id;
        $table = new Pharmacie;
        
        $info = $table->get()->where('pharmacy_id', '=', $type);
        
        return response()->json([
            'pharmacy' => $info,
        ], 201);

    }

    public function info(Request $request){
        $data=$request->all();
        //$user_id=$data['user_id'];
        $type=$request->user_id;
 
        
        $info = Info::where('user_id', '=', $type)->get();
        
        return response()->json([
            'user' => $info,
        ], 201);
    }

    // public function addPost(Request $request){
    //     $validator = Validator::make($request->all(), [
    //         'post_text' => 'required|string|between:2,255',
    //         'post_pic' => 'required|string|between:2,255',
            
    //     ]);
    //     if($validator->fails()){
    //         return response()->json($validator->errors()->toJson(), 400);
    //     }
        

    //     $data = $request->all();
    //     $user = new Post;
    //     $user->user_id = $data["user_id"];
    //     $user->post_text = $data["post_text"];
    //     $user->post_pic = $data["post_pic"];
    //     $user->save();

    //     return response()->json([
    //         'message' => 'Post successfully added',
    //         'post' => $user,
    //     ], 201);
    // }

    // public function solvePost(Request $request){
        
    //     $data = $request->all();
    //     $user = new Postfind;
    //     $user->post_id = $data["post_id"];
    //     $user->poster_id = $data["poster_id"];
    //     $user->pharmacy_id = $data["pharmacy_id"];
    //     $user->save();

    //     return response()->json([
    //         'message' => 'Post successfully solved',
    //         'solved' => $user,
    //     ], 201);
    // }
}
