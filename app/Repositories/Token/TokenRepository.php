<?php
 namespace App\Repositories\Token;
 use App\Models\Token;

 class TokenRepository implements TokenInterface
 {
 	public function fetch()
 	{
 		try
 		{
 			$tokens = Token::query();
 			return $tokens;
 		}catch(Exception $e){
 			return response()->json(['status'=>false, 'code'=>$e->getCode(), 'message'=>$e->message()],500);
 		}
 	}

 	public function store($request)
 	{
 		try
 		{
 			$token = Token::create([
 				'user_id' => auth()->user()->id,
 				'token_name' => $request->token_name,
 				'token_symbol' => $request->token_symbol,
 				'contract_address' => $request->contract_address,
 				'recipient_address' => $request->recipient_address,
 				'status' => $request->status,
 			]);
 			return response()->json(['status'=>true, 'token_id'=>intval($token->id), 'message'=>'Successfully a token has been added']);
 		}catch(Exception $e){
 			return response()->json(['status'=>false, 'code'=>$e->getCode(), 'message'=>$e->message()],500);
 		}
 	}

 	public function update($request,$token)
 	{
 		try
 		{
 			$token->update($request->validated());
 			return response()->json(['status'=>true, 'token_id'=>intval($token->id), 'message'=>'Successfully the token has been updated']);
 		}catch(Exception $e){
 			return response()->json(['status'=>false, 'code'=>$e->getCode(), 'message'=>$e->message()],500);
 		}
 	}

 	public function delete($token)
 	{
 		try
 		{
 			$token->delete();
 		    return response()->json(['status'=>true, 'message'=>"Successfully the token has been deleted"]);
 		}catch(Exception $e){
 			return response()->json(['status'=>false, 'code'=>$e->getCode(), 'message'=>$e->message()],500);
 		}
 	}

 	public function statusUpdate($request)
 	{
 		try
 		{
 			$token = $this->fetch()->findorfail($request->token_id);
 			$token->status = $request->status;
 			$token->update();
 			return response()->json(['status'=>true, 'message'=>"Successfully the token's status has been updated"]);
 		}catch(Exception $e){
 			return response()->json(['status'=>false, 'code'=>$e->getCode(), 'message'=>$e->message()],500);
 		}
 	}
 }