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
        ->count();

        $baalbek = Postfind::join('pharmacies','pharmacies.pharmacy_id','=','postfinds.pharmacy_id')
        ->where("district", "=", 'Baalbek')
        ->count();
        
        $beirut = Postfind::join('pharmacies','pharmacies.pharmacy_id','=','postfinds.pharmacy_id')
        ->where("district", "=", 'Beirut')
        ->count();

        $beqaa = Postfind::join('pharmacies','pharmacies.pharmacy_id','=','postfinds.pharmacy_id')
        ->where("district", "=", 'Beqaa')
        ->count();

        $mount_lebanon = Postfind::join('pharmacies','pharmacies.pharmacy_id','=','postfinds.pharmacy_id')
        ->where("district", "=", 'Mount Lebanon')
        ->count();

        $nabatieh = Postfind::join('pharmacies','pharmacies.pharmacy_id','=','postfinds.pharmacy_id')
        ->where("district", "=", 'Nabatieh')
        ->count();

        $north = Postfind::join('pharmacies','pharmacies.pharmacy_id','=','postfinds.pharmacy_id')
        ->where("district", "=", 'North Governate')
        ->count();
        
        $south = Postfind::join('pharmacies','pharmacies.pharmacy_id','=','postfinds.pharmacy_id')
        ->where("district", "=", 'South Governate')
        ->count();

        $users = Postfind::join('pharmacies','pharmacies.pharmacy_id','=','postfinds.pharmacy_id')
        ->where("district", "=", 'South Governate')
        ->get();
        // $users = $users->count();
        

        return response()->json([
            
            'Akkar' => $akkar,
            'Baalbek' => $baalbek,
            'Beirut' => $beirut,
            'Beqaa' => $beqaa,
            'Mount Lebanon' => $mount_lebanon,
            'Nabatieh' => $nabatieh,
            'North Governate' => $north,
            'South Governate' => $south,
            
        ]);
    }

    public function getSolvedPosts(){
        if(Post::exists()){

            $patients = Pharmacie::join('infos','pharmacies.pharmacy_id','=','infos.user_id')
                                ->select('infos.name', 'infos.email', 'infos.profile_pic as poster_profile_pic', 'infos.*')
                                ->get();

            $posts = Post::join('postfinds', 'posts.id', '=', 'postfinds.post_id')
                        ->join('infos','infos.user_id','=','postfinds.poster_id')
                        ->join('pharmacies', 'pharmacies.pharmacy_id','=','postfinds.pharmacy_id')
                        // ->select('infos.name')
                        // ->where('infos.user_id','=','pharmacies.pharmacy_id')
                        ->get();
            return response()->json(
                $posts,
            );
        }else{
            return response()->json(
                "No posts yet",
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
                "No posts yet",
            );
        }
    }

    public function pharmacyInfo(Request $request){
        $user_id=$request->user_id;

        $info = Info::where('user_id', '=', $user_id)
        ->join('pharmacies','infos.user_id','=','pharmacies.pharmacy_id')
        ->get();
        
        return response()->json($info,201);
    }

    public function patientInfo(Request $request){
        $user_id=$request->user_id;

        $info = Info::where('user_id', '=', $user_id)->get();
        
        return response()->json($info,201);
    }
    

    public function updatePatientInfo(Request $request){
    $validator = Validator::make($request->all(), [
        'name' => 'required|string|between:2,100',
        'email' => 'required|string|email|max:100|unique:users',
        'phone' => 'required|regex:/[0-9]{8}/',
        
    ]);
    if($validator->fails()){
        return response()->json($validator->errors()->toJson(), 400);
    }

    $user_id=$request->user_id;
    $name = $request->name;
    $email = $request->email;
    $phone = $request->phone;

    $all_except_email = User::all()->except($user_id);
    // $all_except_phone = Info::all()->where('user_id', '!=', $user_id)->all();
    $all_except_phone = Info::all()->except($user_id);
    $email_check = $all_except_email->where('email', '=', $email)->count() > 0;
    $phone_check = $all_except_phone->where('phone', '=', $phone)->count() > 0;

    if ($email_check || $phone_check) {
        return response()->json([
            'message' => 'Record already exists with another user',
        ], 401);
     }else{
        Info::where('user_id', $user_id)->update(['name' => $name, 'email' => $email, 'phone' => $phone]);
        User::where('id', $user_id)->update(['email' => "updated@email.com"]);

        return response()->json([
            'message' => 'Info Updated Successfully!',
        ], 201);
     }    
    
}

public function delete (Request $request) {
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



    protected function createNewToken($token){
        return response()->json([
            'access_token' => $token,
            'token_type' => 'bearer',
            'expires_in' => auth()->factory()->getTTL() * 60,
            'user' => auth()->user()
        ]);
    }
}
