<?php

namespace App\Http\Controllers;

namespace App\Http\Controllers;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use App\Models\User;
use App\Models\Info;
use App\Models\Pharmacie;
use Illuminate\Support\Facades\Storage;


use Validator;


class AdminController extends Controller
{
    public function login(Request $request){
    	$validator = Validator::make($request->all(), [
            'email' => 'required|email',
            'password' => 'required|string|min:6',
        ]);
        $if_admin =User::where("email", "=", $request->email)
                       ->where("user_type", "=",'admin')
                       ->exists();
        if($if_admin){
            if ($validator->fails()) {
                return response()->json($validator->errors(), 422);
            }
            if (! $token = auth()->attempt($validator->validated())) {
                return response()->json(['error' => 'Unauthorized'], 401);
            }
            return $this->createNewToken($token);
        }else{
            return "Unauthorized: not an admin";
        }
        
    }

    public function adminGetAllPatients(){
        if(User::exists()){

            $patients = Info::join('users','users.id','=','infos.user_id')
                    ->where("user_type","=","patient")
                    ->get();

            return response()->json(
                $patients,
            );
        }else{
            return response()->json(
                "No users yet",
            );
        }
    }

    public function adminGetAllPharmacies(){
        if(Pharmacie::exists()){

            $pharmacies = Pharmacie::join('infos','pharmacies.pharmacy_id','=','infos.user_id')
                    ->select('infos.*','pharmacies.pharmacy_id as id', 'pharmacies.district', 'pharmacies.locality', 'pharmacies.street', 'pharmacies.building', 'pharmacies.license')
                    ->get();

            return response()->json(
                $pharmacies,
            );
        }else{
            return response()->json(
                "No users yet",
            );
        }
    }

    public function getSolvedPosts(){
        if(Post::exists()){

            $patients = Pharmacie::join('infos','pharmacies.pharmacy_id','=','infos.user_id')
                    
                    ->get();

            return response()->json(
                $patients,
            );
        }else{
            return response()->json(
                "No users yet",
            );
        }
    }

    public function getUnsolvedPosts(){
        if(Pharmacie::exists()){

            $patients = Pharmacie::join('infos','pharmacies.pharmacy_id','=','infos.user_id')
                    
                    ->get();

            return response()->json(
                $patients,
            );
        }else{
            return response()->json(
                "No users yet",
            );
        }
    }

    protected function createNewToken($token){
        return response()->json([
            'access_token' => $token,
            'token_type' => 'bearer',
            'expires_in' => auth()->factory()->getTTL() * 60,
            'user' => auth()->user()
        ]);
    }
}
