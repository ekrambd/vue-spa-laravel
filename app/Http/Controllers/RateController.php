<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Rate;
use App\Models\Ratelog;
use Validator;
use DB;

class RateController extends Controller
{
    public function saveRate(Request $request)
    {   
    	DB::beginTransaction();
        try
        {
        	$validator = Validator::make($request->all(), [
	            'rate' => 'required|integer',
	            'transaction_hash' => 'required|string|unique:ratelogs',
	        ]);

	        if($validator->fails()){
	        	DB::commit();
	            return response()->json(['status'=>false, 'message'=>'The given data was invalid', 'data'=>$validator->errors()],422);  
	        }

	        $rate = Rate::find(1);
	        $rate->rate = $request->rate;
	        $rate->update();

	        $log = new Ratelog();
	        $log->user_id = auth()->user()->id;
	        $log->transaction_hash = $request->transaction_hash;
	        $log->date = date('Y-m-d');
	        $log->time = date('h:i:s a');
	        $log->save();

	        DB::commit();

	        return response()->json(['status'=>true, 'message'=>"Successfully the contract's rate has been set"]);

        }catch(Exception $e){
        	DB::rollback();
        	return response()->json(['status'=>false, 'code'=>$e->getCode(), 'message'=>$e->getMessage()],500);
        }
    }

    public function getRate(Request $request)
    {
    	try
    	{
    		$rate = Rate::find(1);
    		return response()->json(['status'=>true, 'data'=>$rate]);
    	}catch(Exception $e){
    	   return response()->json(['status'=>false, 'code'=>$e->getCode(), 'message'=>$e->getMessage()],500);
    	}
    }

    public function rateLogs(Request $request)
    {   
        try{

            $query = Ratelog::query();
            if($request->has('term'))
            {
                $query->where('ratelogs.transaction_hash', 'LIKE', "%$request->term%");
            }
            $logs = $query->latest()->paginate(10);
            return response()->json($logs);
        }catch (Exception $e) {
            return response()->json([
                'status' => false,
                'code' => $e->getCode(),
                'message' => $e->getMessage(),
            ], 500);
        }
    }
}
