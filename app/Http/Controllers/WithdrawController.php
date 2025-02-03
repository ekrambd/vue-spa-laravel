<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Withdraw;
use Validator;

class WithdrawController extends Controller
{
    public function saveWithdraw(Request $request)
    {
    	try
    	{
    		$validator = Validator::make($request->all(), [
	            'amount' => 'required|numeric',	            
	            'transaction_hash' => 'required|string|unique:withdraws',
	        ]);

	        if($validator->fails()){
	            return response()->json(['status'=>false, 'message'=>'The given data was invalid', 'data'=>$validator->errors()],422);  
	        } 
             
            $withdraw = new Withdraw();
            $withdraw->wallet_address = owner()->wallet_address;
            $withdraw->amount = $request->amount;
            $withdraw->transaction_hash = $request->transaction_hash;
            $withdraw->date = date('Y-m-d');
            $withdraw->time = date('h:i:s a');
            $withdraw->save();

            return response()->json(['status'=>true, 'withdraw_id'=>intval($withdraw->id), 'message'=>"Successfully withdraw"]);

    	}catch(Exception $e){
    		return response()->json(['status'=>false, 'code'=>$e->getCode(), 'message'=>$e->getMessage()],500);
    	} 
    }

    public function withdrawLogs(Request $request)
    {
    	try
    	{  

    		$query = Withdraw::query();
    		if($request->has('term'))
    		{
    			$query->where('withdraws.transaction_hash', 'LIKE', "%$request->term%");
    		}
    		if($request->has('from_date'))
    		{
    			$query->where('withdraws.date', '>=', $request->from_date);
    		}
    		if($request->has('to_date'))
    		{
    			$query->where('withdraws.date', '<=', $reqiest->to_date);
    		}
    		$logs = $query->latest()->paginate(10);
    		return $logs;

    	}catch(Exception $e){
    		return response()->json(['status'=>false, 'code'=>$e->getCode(), 'message'=>$e->getMessage()],500);
    	}
    }
}
