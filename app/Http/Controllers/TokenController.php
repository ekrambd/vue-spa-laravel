<?php

namespace App\Http\Controllers;

use App\Models\Token;
use App\Repositories\Token\TokenInterface;
use Illuminate\Http\Request;
use App\Http\Requests\StoreTokenRequest;
use App\Http\Requests\UpdateTokenRequest;

class TokenController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    protected $token;
    public function __construct(TokenInterface $token)
    {
        $this->token = $token;
    }
    public function index(Request $request)
    {
        $tokens = $this->token->fetch()->latest()->paginate(10);
        return $tokens;
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
        //
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(StoreTokenRequest $request)
    {
        $store = $this->token->store($request);
        return $store;
    }

    /**
     * Display the specified resource.
     *
     * @param  \App\Models\Token  $token
     * @return \Illuminate\Http\Response
     */
    public function show(Token $token)
    {
        return response()->json(['status'=>true, 'token'=>$token]);
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  \App\Models\Token  $token
     * @return \Illuminate\Http\Response
     */
    public function edit(Token $token)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \App\Models\Token  $token
     * @return \Illuminate\Http\Response
     */
    public function update(UpdateTokenRequest $request, Token $token)
    {
        $update = $this->token->update($request,$token);
        return $update;
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  \App\Models\Token  $token
     * @return \Illuminate\Http\Response
     */
    public function destroy(Token $token)
    {
        $token->delete($token);
        return response()->json(['status'=>true, 'message'=>"Successfully the token has been deleted"]);
    }
}
