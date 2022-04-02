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


     public function notFound(){
         return response()->json(['error' => 'Unauthorized'], 401);
     }


    public function login(Request $request){
    	$validator = Validator::make($request->all(), [
            'email' => 'required|email',
            'password' => 'required|string|min:6',
        ]);
        
        if ($validator->fails()) {
            return response()->json($validator->errors(), 422);
        }
        if (! $token = auth()->attempt($validator->validated())) {
            return response()->json(['error' => 'Unauthorized'], 401);
        }
        return $this->createNewToken($token);
    }
    /**
     * Register a User.
     *
     * @return \Illuminate\Http\JsonResponse
     */
    public function register(Request $request) {
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
        // $user = User::create(array_merge(
        //             $validator->validated(),
        //             ['password' => bcrypt($request->password)]
        //         ));
        

        $data = $request->all();
        $type=$request->user_type;
        $user = new User;
        $user->email = $data["email"];
        $user->password = bcrypt($data["password"]);
        $user->user_type = $data["user_type"];
        $user->save();
        
        
        if($type=="pharmacy"){
            $pharmacy = new Pharmacie;
            $pharmacy->pharmacy_id = $user->id;
            $pharmacy->building = $data["building"];
            $pharmacy->street = $data["street"];
            $pharmacy->locality = $data["locality"];
            $pharmacy->district = $data["district"];
            $pharmacy->latitude  = $data["latitude"];
            $pharmacy->longitude  = $data["longitude"];

            //testttttttttttttttttttttttttttttttttttttttttttttttttt
            $image_64 = $data["license"];//your base64 encoded data
            $extension = explode('/', explode(':', substr($image_64, 0, strpos($image_64, ';')))[1])[1];   // .jpg .png .pdf
            $replace = substr($image_64, 0, strpos($image_64, ',')+1); 
            // find substring fro replace here eg: data:image/png;base64,
            $image = str_replace($replace, '', $image_64); 
            $image = str_replace(' ', '+', $image); 
            $imageName = $user->id.'.'.$extension;
            

            $pharmacy->license = $imageName;
            $pharmacy->save();
            
            Storage::disk('license')->put($user->id.'.'.$extension, base64_decode($image));
            
            //Pharmacie::where('id', $user->id)->update(['license' => $user->id.'.'.$extension]);
        }

        $info = new Info;
        $info->user_id =$user->id;
        $info->name = $data["name"];
        $info->email = $data["email"];
        $info->phone = $data["phone"];
        // $profile_pic_name = $request->file('profile_pic')->getClientOriginalName();
        // $profile_pic_extension = $request->file('profile_pic')->getClientOriginalExtension();
        // $info->profile_pic = $request->file('profile_pic')->storeAs('public\profile_pictures', $user->id.'.'.$profile_pic_extension);
        $info->profile_pic = $data["profile_pic"];
        $info->save();

        
        return response()->json([
            'message' => 'User successfully registered',
            'user' => $user,
            $type,
        ], 201);
    }

    /**
     * Log the user out (Invalidate the token).
     *
     * @return \Illuminate\Http\JsonResponse
     */
    public function logout() {
        auth()->logout();
        return response()->json(['message' => 'User successfully signed out']);
    }
    /**
     * Refresh a token.
     *
     * @return \Illuminate\Http\JsonResponse
     */
    public function refresh() {
        return $this->createNewToken(auth()->refresh());
    }
    /**
     * Get the authenticated User.
     *
     * @return \Illuminate\Http\JsonResponse
     */
    public function userProfile() {
        return response()->json(auth()->user());
    }
    /**
     * Get the token array structure.
     *
     * @param  string $token
     *
     * @return \Illuminate\Http\JsonResponse
     */
    protected function createNewToken($token){
        return response()->json([
            'access_token' => $token,
            'token_type' => 'bearer',
            'expires_in' => auth()->factory()->getTTL() * 60,
            'user' => auth()->user()
        ]);
    }
}