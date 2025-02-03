<?php
 use App\Models\Rate;
 use App\Models\Owner;

 function user()
 {
 	$user = auth()->user();
 	return $user->id;
 }

 function rate()
 {
 	$rate = Rate::find(1);
 	return $rate;
 }

 function owner()
 {
 	$owner = Owner::find(1);
 	return $owner;
 }