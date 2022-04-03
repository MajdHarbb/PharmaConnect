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
use Illuminate\Support\Facades\Storage;
use Illuminate\Support\Facades\Hash;

class UserController extends Controller
{
    //fetch user(patient) data
    public function userProfile() {
        $user = Auth::user();
        return response()->json($user);
    }

    //fetch user(pharmacy) data
    public function pharmacyprofile(Request $request) {

        $type=$request->user_id;
        $table = new Pharmacie;
        
        $info = $table->get()->where('pharmacy_id', '=', $type);
        
        return response()->json([
            'pharmacy' => $info,
        ], 201);

    }

    //fetch user information from infos table
    public function info(Request $request){
        $data=$request->all();
        $type=$request->user_id;
 
        
        $info = Info::where('user_id', '=', $type)->get();
        
        return response()->json([
            'user' => $info,
        ], 201);
    }

    //fetch all pharmacies with their data
    public function getAllPharmacies() {
        //check if the pharmacy exists the table first
        if(Pharmacie::exists()){
            $pharmacies = Info::join('pharmacies','pharmacies.pharmacy_id','=','infos.user_id')
                    ->get();
            return response()->json(
                $pharmacies,
            );
        }else{
            return response()->json(
                "No Pharmacies yet",
            );
        }   
    }

    //fetch all replies from the pharmacies according to patient id
    public function getNotifications(Request $request) {
        
        $data=$request->all();
        $user_id=$data["user_id"];
        $notifications=Postfind::where('poster_id', '=', $user_id)->exists();
        //if any notifications for patient with this id
        if($notifications){
            //join tables data
            $posts = Postfind::join('posts', 'postfinds.post_id', '=', 'posts.id')
            ->join('infos', 'infos.user_id', '=', 'postfinds.pharmacy_id')
            ->join('pharmacies', 'postfinds.pharmacy_id', '=', 'pharmacies.pharmacy_id')
            ->select('posts.*', 'postfinds.pharmacy_id', 'infos.name','infos.email','infos.phone','infos.profile_pic','pharmacies.building','pharmacies.street','pharmacies.district','pharmacies.locality','pharmacies.latitude','pharmacies.longitude')
            ->where('postfinds.poster_id', '=', $user_id)
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
    //update profile picture
    public function updateProfilePicture(Request $request){

        $data=$request->all();
        $user_id=$data['user_id'];
        //fetch base64 encoded data
        $image_64 = $data["profile_pic"];
        //get extension 
        $extension = explode('/', explode(':', substr($image_64, 0, strpos($image_64, ';')))[1])[1];
        $replace = substr($image_64, 0, strpos($image_64, ',')+1); 
        $image = str_replace($replace, '', $image_64); 
        $image = str_replace(' ', '+', $image); 
        //name the image user_id+extension
        $imageName = $user_id.'.'.$extension;

        //save to public path
        Storage::disk('profile')->put($user_id.'.'.$extension, base64_decode($image));
        Info::where('id', $user_id)->update(['profile_pic' => $user_id.'.'.$extension]);
        
        return response()->json([
            'message' => 'Image updated successfully',
        ], 201);
    }

    public function updateName(Request $request){

        $validator = Validator::make($request->all(), [
            'name' => 'required|string|between:2,100',
            'password' => 'required|string|confirmed|min:6',]);

        if($validator->fails()){
            return response()->json($validator->errors()->toJson(), 400);
        }
        
        $data=$request->all();

        $user_id=$data['user_id'];
        $user_name=$data['name'];

        $password = $data["password"];

        $passdatabase = User::where('id', $user_id)->value('password'); 
        if(Hash::check($password,$passdatabase)){
            Info::where('user_id', $user_id)->update(['name' => $user_name]);
            return response()->json([
                'message' => 'Name updated successfully',
            ], 201);
        }else{
            return response()->json([
                'message' => 'Wrong Pasword',
            ], 400);
        }
        
        
        
    }

    public function updatePhone(Request $request){

        $validator = Validator::make($request->all(), [
            'phone' => 'required|regex:/[0-9]{8}/',
            'password' => 'required|string|confirmed|min:6',]);

        if($validator->fails()){
            return response()->json($validator->errors()->toJson(), 400);
        }
        
        $data=$request->all();

        $user_id=$data['user_id'];
        $phone=$data['phone'];
        $password = $data['password'];
        $passdatabase = User::where('id', $user_id)->value('password'); 
        if(Hash::check($password,$passdatabase)){
            
            if (info::where('phone', '=', $phone)->exists()) {
                return response()->json([
                    'message' => 'Phone already exists',
                ], 400);
            }else{
                Info::where('id', $user_id)->update(['phone' => $phone]);
            return response()->json([
                'message' => 'Phone updated successfully',
            ], 201);
            }

        }else{
            return response()->json([
                'message' => 'Wrong Pasword',
            ], 400);
        }
        
    }

    public function updatePassword(Request $request){

        $validator = Validator::make($request->all(), [
            'new_password' => 'required|string|min:6',
            'password' => 'required|string|confirmed|min:6',]);

        if($validator->fails()){
            return response()->json($validator->errors()->toJson(), 400);
        }
        
        $data=$request->all();

        $user_id=$data['user_id'];
        $password = $data["password"];
        $new_password=$data['new_password'];

        $passdatabase = User::where('id', $user_id)->value('password'); 
        if(Hash::check($password,$passdatabase)){
            User::where('id', $user_id)->update(['password' => bcrypt($new_password)]);
            return response()->json([
                'message' => 'Password updated successfully',
            ], 201);
        }else{
            return response()->json([
                'message' => 'Wrong Pasword',
            ], 400);
        }

    }

    public function deleteUser (Request $request) {
        $id=$request->user_id;
        if (User::where('id', '=', $id)->exists()) {

           $user = User::find($id);
           $user->delete();
           return response()->json([
            'message' => 'User deleted successfully',
        ], 201);
         }else{
            return response()->json([
                'message' => 'Record does not exist',
            ], 401);
         }
    }

    public function sendImage(Request $request){
        // $id = $request->id;
        return response()->file(storage_path("app/public/posts_pictures/"));
        //C:\Users\User\Desktop\FSW\Final Project\PharmaConnect\storage\app\public\posts_pictures\5.jpg
    }

    public function imagename(Request $request){
        $id = $request->id;
        return response()->file(storage_path("app/public/posts_pictures/"));
        //C:\Users\User\Desktop\FSW\Final Project\PharmaConnect\storage\app\public\posts_pictures\5.jpg
    }

    

    
}
