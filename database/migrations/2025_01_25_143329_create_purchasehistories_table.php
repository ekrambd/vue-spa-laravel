<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('purchasehistories', function (Blueprint $table) {
            $table->id();
            $table->string('wallet_address');
            $table->string('amount');
            $table->enum('currency', ['BNB', 'USDT']);
            $table->date('date');
            $table->string('time');
            $table->string('transaction_hash')->unique();
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('purchasehistories');
    }
};
