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
use App\Models\Message;

use Validator;

class MessagesContoller extends Controller
{
    public function sendMessage(Request $request){
        $validator = Validator::make($request->all(), [
            'message' => 'required|string|between:2,255',
        ]);
        if($validator->fails()){
            return response()->json($validator->errors()->toJson(), 400);
        }
        

        $user_id = $request->user_id;
        $message_text = $request->message_text;
        $messsage = new Message;
        $messsage->user = $request->user_id;
        $messsage->message_text = $request->message_text;
        $messsage->save();

        return response()->json([
            'message' => 'message sent successfully',
        ], 201);
    }
}
