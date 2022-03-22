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

    public function getAllPharmacies() {
        //$pharmacies = Pharmacie::get();
        $pharmacies = Info::join('pharmacies','pharmacies.pharmacy_id','=','infos.user_id')
                ->get();

        
        return response()->json(
            $pharmacies,
            // $test,
        );
    }
}
