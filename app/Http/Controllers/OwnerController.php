<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Owner;
use App\Models\Ownerlog;
use Validator;
use DB;
use App\Models\User;

class OwnerController extends Controller
{
    public function saveOwner(Request $request)
    {   
    	DB::beginTransaction();
    	try
    	{
    		$validator = Validator::make($request->all(), [
	            'wallet_address' => 'required|string',
	            'transaction_hash' => 'required|string|unique:ownerlogs',
	        ]);

	        if($validator->fails()){
	        	DB::commit();
	            return response()->json(['status'=>false, 'message'=>'The given data was invalid', 'data'=>$validator->errors()],422);  
	        }

	        $owner = Owner::find(1);
	        $owner->wallet_address = $request->wallet_address;
	        $owner->update();


	        User::updateOrCreate(
			    ['wallet_address' => $request->wallet_address], // Condition to find the user
			    [
			        'name' => 'Admin',
			        'password' => bcrypt('123456')
			    ]
			);

	        $log = new Ownerlog();
	        $log->user_id = auth()->user()->id;
	        $log->transaction_hash = $request->transaction_hash;
	        $log->date = date('Y-m-d');
	        $log->time = date('h:i:s A');
	        $log->save();

	        DB::commit();

	        return response()->json(['status'=>true, 'message'=>'Successfully ownership has been transfered']);

    	}catch(Exception $e){
        	DB::rollback();
        	return response()->json(['status'=>false, 'code'=>$e->getCode(), 'message'=>$e->getMessage()],500);
        }
    }

    public function getOwner()
    {
    	try
    	{
    		$owner = Owner::find(1);
    		return response()->json(['status'=>true, 'owner'=>$owner]);
    	}catch(Exception $e){
        	return response()->json(['status'=>false, 'code'=>$e->getCode(), 'message'=>$e->getMessage()],500);
        }
    }
}
