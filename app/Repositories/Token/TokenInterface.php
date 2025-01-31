<?php
 namespace App\Repositories\Token;
 
 interface TokenInterface
 {  
 	public function fetch();
    public function store($request);
    public function update($request,$token);
    public function delete($token);
    public function statusUpdate($request);
 }