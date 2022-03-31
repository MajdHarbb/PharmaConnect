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

class MessagesController extends Controller
{
    public function sendMessage(Request $request){
        $validator = Validator::make($request->all(), [
            'message_text' => 'required|string|between:2,255',
        ]);
        if($validator->fails()){
            return response()->json($validator->errors()->toJson(), 400);
        }
        $message = new Message;
        $message->user_id = $request->user_id;
        $message->message_text = $request->message_text;
        $message->save();

        return response()->json([
            'message' => 'message sent successfully',
        ], 201);
    }
}
