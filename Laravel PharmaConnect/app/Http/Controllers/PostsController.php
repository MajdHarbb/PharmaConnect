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
    //insert post to posts table
    public function addPost(Request $request){
        //validate text
        $validator = Validator::make($request->all(), [
            'post_text' => 'required|string|between:2,255',            
        ]);
        if($validator->fails()){
            return response()->json($validator->errors()->toJson(), 400);
        }
        
        //if validation is true:
        $data = $request->all();
        $user = new Post;
        //fetch base64 encoded image data
        $image_64 = $data["post_pic"];
        // divide the string to get extension ex: .jpg .png .pdf
        $extension = explode('/', explode(':', substr($image_64, 0, strpos($image_64, ';')))[1])[1];  
        $replace = substr($image_64, 0, strpos($image_64, ',')+1); 
        $image = str_replace($replace, '', $image_64); 
        $image = str_replace(' ', '+', $image); 
        $imageName = $user->id.'.'.$extension;
        
        
        $user->user_id = $data["user_id"];
        $user->post_text = $data["post_text"];
        $user->post_pic = $imageName;
        $user->save();
        //save post image to public/posts: disk('posts) is mapped to save in this directory in filesystems.php
        Storage::disk('posts')->put($user->id.'.'.$extension, base64_decode($image));
        //insert post
        Post::where('id', $user->id)->update(['post_pic' => $user->id.'.'.$extension]);
              
        return response()->json([
            'message' => 'Post successfully added',
        ], 201);
    }

    public function getAllPosts(Request $request) {

        $pharmacy_id=$request->pharmacy_id;

        $posts = Postfind::join('posts', 'posts.id', '=', 'postfinds.post_id')
        ->join('infos', 'posts.user_id', '=', 'infos.user_id')
        ->where('pharmacy_id','!=',$pharmacy_id)->get();

        return response()->json(
            $posts,
        );
    }
    //get all posts of a patient
    public function myPosts(Request $request){
        $user_id= $request->user_id;
        $post_exists=Post::where('user_id', '=', $user_id)->exists();
        //check if there are any posts at first
        if($post_exists){
            $posts = Post::orderBy('created_at', 'DESC')->where('user_id', '=', $user_id)->get();
            return response()->json(
                $posts,
            );
        }else{
            return response()->json([
                "No posts yet",
            ], 400);
        }
        
    }
    //delete post if exists
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

    public function updatePost(Request $request){
        $id=$request->post_id;
        $post_text=$request->post_text;
        //your base64 encoded data
        $image_64=$request->post_pic;
        //split to find extension
        $extension = explode('/', explode(':', substr($image_64, 0, strpos($image_64, ';')))[1])[1]; 
        $replace = substr($image_64, 0, strpos($image_64, ',')+1); 
        $image = str_replace($replace, '', $image_64); 
        $image = str_replace(' ', '+', $image); 
        $imageName = $id.'.'.$extension;

        if (Post::where('id', '=', $id)->exists()) {
            //add image to public/posts directory and update posts table
           Post::where('id', $id)->update(['post_text' => $post_text, 'post_pic' => $imageName]);
           Storage::disk('posts')->put($id.'.'.$extension, base64_decode($image));
           return response()->json([
            'message' => 'Post updated successfully',
        ], 201);
         }else{
            return response()->json([
                'message' => 'Record does not exist',
            ], 401);
         }
        
    }
    //get all posts from table posts joined with posters information from infos table
    public function allPosts(){
        $posts = Post::join('infos', 'infos.user_id', '=', 'posts.user_id')
               ->get(['infos.*', 'posts.*']);

               return response()->json($posts,201);
    }
}
