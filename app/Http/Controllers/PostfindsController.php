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
        // $pharmacy_id=$request->pharmacy_id;
        // $posts = Post::join('infos', 'posts.user_id', '=', 'infos.user_id')
        //     ->join('postfinds', 'infos.user_id', '!=', 'postfinds.pharmacy_id')
        //     ->select('posts.*', 'infos.name', 'infos.email','infos.phone','infos.profile_pic','postfinds.pharmacy_id')
        //     ->where('postfinds.pharmacy_id', '!=', $pharmacy_id)
        //     ->distinct()->get();
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
}
