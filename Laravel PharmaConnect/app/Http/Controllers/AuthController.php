<?php
namespace App\Http\Controllers;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use App\Models\User;
use App\Models\Info;
use App\Models\Pharmacie;
use Illuminate\Support\Facades\Storage;


use Validator;

class AuthController extends Controller
{

    //unauthorized route in middleware
     public function notFound(){
         return response()->json(['error' => 'Unauthorized'], 401);
     }

    //login returns jwt token
    public function login(Request $request){
        //validate input
    	$validator = Validator::make($request->all(), [
            'email' => 'required|email',
            'password' => 'required|string|min:6',
        ]);
        
        if ($validator->fails()) {
            return response()->json($validator->errors(), 422);
        }
        //check if authentication validation is true
        if (! $token = auth()->attempt($validator->validated())) {
            return response()->json(['error' => 'Unauthorized'], 401);
        }
        //return a jwt token
        return $this->createNewToken($token);
    }
    
    //register a user (patient and pharmacy)
    public function register(Request $request) {
        //validate input
        $validator = Validator::make($request->all(), [
            'name' => 'required|string|between:2,100',
            'email' => 'required|string|email|max:100|unique:users',
            'password' => 'required|string|confirmed|min:6',
            'phone' => 'required|regex:/[0-9]{8}/',
            //'profile_pic'  => 'required|mimes:png,jpg,jpeg,gif|max:2048',
             'profile_pic'  => 'required|string|between:2,255',
            
        ]);
        if($validator->fails()){
            return response()->json($validator->errors()->toJson(), 400);
        }
        //get user input
        $data = $request->all();
        $type=$request->user_type;
        //insert into table users
        $user = new User;
        $user->email = $data["email"];
        $user->password = bcrypt($data["password"]);
        $user->user_type = $data["user_type"];
        $user->save();
        
        //check if type is pharmacy and insert data into pharmacies table
        if($type=="pharmacy"){
            $pharmacy = new Pharmacie;
            $pharmacy->pharmacy_id = $user->id;
            $pharmacy->building = $data["building"];
            $pharmacy->street = $data["street"];
            $pharmacy->locality = $data["locality"];
            $pharmacy->district = $data["district"];
            $pharmacy->latitude  = $data["latitude"];
            $pharmacy->longitude  = $data["longitude"];

            //your base64 encoded image data
            //the pharmacy user role must upload an license image in order to register
            $image_64 = $data["license"];
            $extension = explode('/', explode(':', substr($image_64, 0, strpos($image_64, ';')))[1])[1];   // .jpg .png .pdf
            $replace = substr($image_64, 0, strpos($image_64, ',')+1); 
            // find substring fro replace here eg: data:image/png;base64,
            $image = str_replace($replace, '', $image_64); 
            $image = str_replace(' ', '+', $image); 
            $imageName = $user->id.'.'.$extension;
            $pharmacy->license = $imageName;
            $pharmacy->save();
            //save to public/licenses folder
            Storage::disk('license')->put($user->id.'.'.$extension, base64_decode($image));
            
        }
        //insert into infos table
        $info = new Info;
        $info->user_id =$user->id;
        $info->name = $data["name"];
        $info->email = $data["email"];
        $info->phone = $data["phone"];
        $info->profile_pic = $data["profile_pic"];
        $info->save();

        
        return response()->json([
            'message' => 'User successfully registered',
            'user' => $user,
            $type,
        ], 201);
    }

    //logout destroys the jwt token
    public function logout() {
        auth()->logout();
        return response()->json(['message' => 'User successfully signed out']);
    }

    //refresh the token
    public function refresh() {
        return $this->createNewToken(auth()->refresh());
    }
    //returns user info
    public function userProfile() {
        return response()->json(auth()->user());
    }

    //create a jwt token
    protected function createNewToken($token){
        return response()->json([
            'access_token' => $token,
            'token_type' => 'bearer',
            'expires_in' => auth()->factory()->getTTL() * 60,
            'user' => auth()->user()
        ]);
    }
}