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
    

    //add post to postfinds table
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
    //still working
    public function postPharmacies(Request $request){

        $user = auth()->user();
        $user_id=$user->id;
        $notifications=Postfind::where('poster_id', '=', $user_id)->exists();
        if($notifications){
            $posts = Postfind::join('posts','posts.id','=','postfinds.post_id')
            ->join('infos','infos.user_id','=','postfinds.pharmacy_id')
            ->select('posts.*','postfinds.post_id')
            ->where('poster_id', '=', $user_id)
            ->distinct()
            ->get();
            return response()->json(
                $posts,
            );
        }else{
            return response()->json([
                "No notifications yet",
            ], 400);
        }
    }

    public function pharmacyInfobyPostId(Request $request){
        $user = auth()->user();
        $user_id=$user->id;
        $post_id = $request->post_id;
        $notifications=Postfind::where('post_id', '=', $post_id)->exists();
        if($notifications){
            $pharmacies = Postfind::join('posts','posts.id','=','postfinds.post_id')
            ->join('infos','infos.user_id','=','postfinds.pharmacy_id')
            ->join('pharmacies','pharmacies.pharmacy_id','=','postfinds.pharmacy_id')
            ->select('infos.*','postfinds.post_id','pharmacies.*')
            ->where('post_id', '=', $post_id)
            ->distinct()
            ->get();
            return response()->json(
                $pharmacies,
            );
        }else{
            return response()->json([
                "No notifications yet",
            ], 400);
        }
    }
}
