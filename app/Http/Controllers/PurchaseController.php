<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Validator;
use App\Models\Purchase;

class PurchaseController extends Controller
{
    public function savePurchase(Request $request)
    {
    	try 
    	{   
    		$validator = Validator::make($request->all(), [
	            'wallet_address' => 'required|string',
	            'polygon_amount' => 'required|numeric',	            
	            'transaction_hash' => 'required|string|unique:purchases',
	        ]);

	        if($validator->fails()){
	            return response()->json(['status'=>false, 'message'=>'The given data was invalid', 'data'=>$validator->errors()],422);  
	        }

    		$purchase = new Purchase();
    		$purchase->wallet_address = $request->wallet_address;
    		$purchase->polygon_amount = $request->polygon_amount;
    		$purchase->token_amount = $request->polygon_amount * rate()->rate;
    		$purchase->transaction_hash = $request->transaction_hash;
    		$purchase->date = date('Y-m-d');
    		$purchase->time = date('h:i:s a');
    		$purchase->save();
    		return response()->json(['status'=>true, 'purchase_id'=>intval($purchase->id), 'message'=>"Successfully Purchase"]);

    	}catch(Exception $e){
    		return response()->json(['status'=>false, 'code'=>$e->getCode(), 'message'=>$e->getMessage()],500);
    	}
    }

    public function purchaseLogs(Request $request)
    {
    	try
    	{
    		$query = Purchase::query();
    		if($request->has('term'))
    		{
    			$query->where('purchases.transaction_hash', 'LIKE', "%$request->term%");
    		}
    		if($request->has('from_date'))
    		{
    			$query->where('purchases.date', '>=', $request->from_date);
    		}
    		if($request->has('to_date'))
    		{
    			$query->where('purchases.date', '<=', $reqiest->to_date);
    		}
    		$logs = $query->latest()->paginate(10);
    		return $logs;
    	}catch(Exception $e){
    		return response()->json(['status'=>false, 'code'=>$e->getCode(), 'message'=>$e->getMessage()],500);
    	}
    }
}
