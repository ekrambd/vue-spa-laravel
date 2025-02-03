<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\User;

class UserController extends Controller
{
    public function userDetails()
    {
    	try
    	{
    		$user = auth()->user();
    		return response()->json(['status'=>true, 'user'=>$user]);
    	}catch(Exception $e){
    		return response()->json(['status'=>false, 'code'=>$e->getCode(), 'message'=>$e->getMessage()],500);
    	}
    }
}
