<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Auth;
use App\Models\User;
use Validator;
use DB;

class AuthController extends Controller
{
    public function login(Request $request)
    {   
        try
        {
            $validator = Validator::make($request->all(), [
                'wallet_address' => 'required|string',
                'signature' => 'required|string'
            ]);

            if($validator->fails()){
                DB::commit();
                return response()->json(['status'=>false, 'message'=>'The given data was invalid', 'data'=>$validator->errors()],422);  
            }

            $user = User::where('wallet_address',$request->wallet_address)->first();

            if($user)
            {
                $success['token'] = $user->createToken('MyApp')->plainTextToken;
                $success['id'] = $user->id;
                $success['name'] = $user->name;
                $success['wallet_address'] = $user->wallet_address;
                return response()->json(['status' => true, 'message' => 'Successfully Logged In', 'data' => $success]);
            }

            $user->signature = $request->signature;
            $user->update();

            DB::commit(); 
               
            return response()->json(['status' => false, 'message' => 'Invalid Credential', 'data' => ['token' => "", 'id' => 0, 'wallet_address' => ""]],500);

        }catch(Exception $e){
            DB::rollback();
            return response()->json(['status'=>false, 'code'=>$e->getCode(), 'message'=>$e->getMessage()],500);
        }
    }

    public function logout(Request $request)
    {
    	auth()->user()->tokens()->delete();
        return response()->json(['status' => true, 'message' => 'Successfully logged out!']);
    }
}
