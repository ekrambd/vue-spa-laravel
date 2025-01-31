<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use DB;
use App\Models\Ratetiming;
use App\Models\Durationlog;
use Validator;

class DurationController extends Controller
{
    public function saveDuration(Request $request)
    {   
    	DB::beginTransaction();
    	try
    	{
    		$validator = Validator::make($request->all(), [
	            'duration' => 'required|integer',
	            'duration_unit' => 'required|in:Day,Week,Month,Year',
	            'transaction_hash' => 'required|string|unique:durationlogs',
	        ]);

	        if($validator->fails()){
	        	DB::commit();
	            return response()->json(['status'=>false, 'message'=>'The given data was invalid', 'data'=>$validator->errors()],422);  
	        }

	        $duration = Ratetiming::find(1);
	        $duration->duration = $request->duration;
	        $duration->duration_unit = $request->duration_unit;
	        $duration->update();

	        $log = new Durationlog();
	        $log->user_id = auth()->user()->id;
	        $log->transaction_hash = $request->transaction_hash;
	        $log->date = date('Y-m-d');
	        $log->time = date('h:i:s a');
	        $log->save();

	        DB::commit();

	        return response()->json(['status'=>true, 'message'=>"Successfully set rate timing"]);

    	}catch(Exception $e){
        	DB::rollback();
        	return response()->json(['status'=>false, 'code'=>$e->getCode(), 'message'=>$e->getMessage()],500);
        }
    }

    public function durationInfo()
    {
    	try
    	{
    		$duration = Ratetiming::find(1); 
    		return response()->json(['status'=>true, 'data'=>$duration]); 
    	}catch(Exception $e){
        	return response()->json(['status'=>false, 'code'=>$e->getCode(), 'message'=>$e->getMessage()],500);
        }
    }

    public function getDate()
    {
    	$timestamp = 1740898802;
		$readable_date = date("Y-m-d H:i:s", $timestamp);
		return $readable_date;
    }
}
