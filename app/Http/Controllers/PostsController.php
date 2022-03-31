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
        //remove
        Storage::disk('postsflutter')->put($user->id.'.'.$extension, base64_decode($image));
        
        Post::where('id', $user->id)->update(['post_pic' => $user->id.'.'.$extension]);
              
        return response()->json([
            'message' => 'Post successfully added',
            'post' => $user,
            'image_name' => $user->id.'.'.$extension,
        ], 201);
    }

    public function getAllPosts(Request $request) {
        // $pharmacy_id=$request->pharmacy_id;
        // $posts = Post::join('infos', 'posts.user_id', '=', 'infos.user_id')
        //     ->join('postfinds', 'infos.user_id', '=', 'postfinds.pharmacy_id')
        //     ->select('posts.*', 'infos.name', 'infos.email','infos.phone','infos.profile_pic','postfinds.pharmacy_id')
        //     ->where('postfinds.pharmacy_id', '!=', $pharmacy_id)
        //     ->distinct()->get();
        $pharmacy_id=$request->pharmacy_id;
        $posts = Post::join('infos', 'posts.user_id', '=', 'infos.user_id')
            ->join('postfinds', 'infos.user_id', '!=', 'postfinds.pharmacy_id')
            ->select('posts.*', 'infos.name', 'infos.email','infos.phone','infos.profile_pic','postfinds.pharmacy_id')
            ->where('postfinds.pharmacy_id', '!=', $pharmacy_id)
            ->distinct()->get();
        // $posts = Postfind::join('posts', 'posts.id', '=', 'postfinds.post_id')
        //         ->select('posts.*')
        //         ->where('postfinds.pharmacy_id', '=', $pharmacy_id)->get;
        return response()->json(
            $posts,
        );
    }

    // public function myPosts(Request $request){
    //     $user_id= $request->user_id;
    //     $post_exists=Post::where('user_id', '=', $user_id)->exists();

    //     if($post_exists){
    //         $posts = Post::where('user_id', '=', $user_id)->get();
    //         return response()->json(
    //             $posts,
    //         );
    //     }else{
    //         return response()->json([
    //             "No posts yet",
    //         ], 400);
    //     }
        
    // }

    public function myPosts(Request $request){
        $user_id= $request->user_id;
        $post_exists=Post::where('user_id', '=', $user_id)->exists();
        
        if($post_exists){
            $posts = Post::where('user_id', '=', $user_id)->get();
            return response()->json(
                $posts,
            );
        }else{
            return response()->json([
                "No posts yet",
            ], 400);
        }
        
    }

    public function deletePost (Request $request) {
        $id=$request->post_id;
        if (Post::where('id', '=', $id)->exists()) {

           $posts = Post::find($id);
           $posts->delete();
           return response()->json([
            'message' => 'Post deleted successfully',
        ], 201);
         }else{
            return response()->json([
                'message' => 'Record does not exist',
            ], 401);
         }
    }
}
