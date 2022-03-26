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

    public function getAllPharmacies() {
        //$pharmacies = Pharmacie::get();
        $pharmacies = Info::join('pharmacies','pharmacies.pharmacy_id','=','infos.user_id')
                ->get();

        
        return response()->json(
            $pharmacies,
            // $test,
        );
    }

    public function updateProfilePicture(Request $request){
        $data=$request->all();
        $user_id=$data['user_id'];
        $image_64 = $data["profile_pic"];//your base64 encoded data

        $extension = explode('/', explode(':', substr($image_64, 0, strpos($image_64, ';')))[1])[1];   // .jpg .png .pdf            $replace = substr($image_64, 0, strpos($image_64, ',')+1); 
        // find substring fro replace here eg: data:image/png;base64,
        $replace = substr($image_64, 0, strpos($image_64, ',')+1); 
        $image = str_replace($replace, '', $image_64); 
        $image = str_replace(' ', '+', $image); 
        $imageName = $user_id.'.'.$extension;

            
        Storage::disk('profile')->put($user_id.'.'.$extension, base64_decode($image));
        Storage::disk('profileflutter')->put($user_id.'.'.$extension, base64_decode($image));
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
            Info::where('id', $user_id)->update(['name' => $user_name]);
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

    
}
