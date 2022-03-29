<?php

namespace App\Http\Controllers;

namespace App\Http\Controllers;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use App\Models\User;
use App\Models\Info;
use App\Models\Post;
use App\Models\Postfind;
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

    public function counts(){
        $users = User::all();
        $users = $users->count();

        $pharmacies = Pharmacie::all();
        $pharmacies = $pharmacies->count();

        $posts = Post::all();
        $posts = $posts->count();

        return response()->json([
            'users' => $users,
            'pharmacies' => $pharmacies,
            'posts' => $posts
        ], 201);
    }

    public function findsAccordingToGovernates(){
        $akkar = Postfind::join('pharmacies','pharmacies.pharmacy_id','=','postfinds.pharmacy_id')
        ->where("district", "=", 'akkar')
        ->get();

        $baalbek = Postfind::join('pharmacies','pharmacies.pharmacy_id','=','postfinds.pharmacy_id')
        ->where("district", "=", 'Baalbek')
        ->get();
        
        $beirut = Postfind::join('pharmacies','pharmacies.pharmacy_id','=','postfinds.pharmacy_id')
        ->where("district", "=", 'Beirut')
        ->get();

        $beqaa = Postfind::join('pharmacies','pharmacies.pharmacy_id','=','postfinds.pharmacy_id')
        ->where("district", "=", 'Beqaa')
        ->get();

        $mount_lebanon = Postfind::join('pharmacies','pharmacies.pharmacy_id','=','postfinds.pharmacy_id')
        ->where("district", "=", 'Mount Lebanon')
        ->get();

        $nabatieh = Postfind::join('pharmacies','pharmacies.pharmacy_id','=','postfinds.pharmacy_id')
        ->where("district", "=", 'Nabatieh')
        ->get();

        $north = Postfind::join('pharmacies','pharmacies.pharmacy_id','=','postfinds.pharmacy_id')
        ->where("district", "=", 'North Governate')
        ->get();

        $south = Postfind::join('pharmacies','pharmacies.pharmacy_id','=','postfinds.pharmacy_id')
        ->where("district", "=", 'South Governate')
        ->get();

        // $users = $users->count();

        return ($users);
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
