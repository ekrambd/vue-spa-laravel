<template>
    <div>
      <!-- Navbar -->
        <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
        <div class="container">
            <a class="navbar-brand" href="#">Presale</a>
            <button class="btn btn-outline-light ms-auto">Connect Wallet</button>
        </div>
        </nav>

        <!-- Hero Section -->
        <section class="hero-section mt-5">
        <h1>Welcome to TokenX Presale</h1>
        <p class="mt-3">Get your tokens now before the presale ends!</p>
        <div class="countdown my-4">Presale Ends In: <span id="countdown-timer">00:00:00</span></div>
        <button class="btn btn-light btn-lg">Buy Tokens Now</button>
        </section>

        <!-- Token Purchase Section -->
        <section id="purchase-section" class="container my-5"> <!-- Changed my-5 to my-3 -->
            <div class="row justify-content-center">
                <div class="col-md-6 buy-section">
                <h4 class="text-center mb-4">Purchase Tokens</h4>
                <div class="mb-3">
                    <label for="walletAddress" class="form-label">Wallet Address</label>
                    <input type="text" class="form-control" id="walletAddress" placeholder="Connect your wallet">
                </div>
                <div class="mb-3">
                    <label for="tokenAmount" class="form-label">Enter Token Amount</label>
                    <input type="number" class="form-control" id="tokenAmount" placeholder="e.g. 100">
                </div>
                <div class="mb-3">
                    <label for="paymentMethod" class="form-label">Payment Method</label>
                    <select class="form-select" id="paymentMethod">
                    <option value="eth">ETH</option>
                    <option value="bnb">BNB</option>
                    <option value="usdt">USDT</option>
                    </select>
                </div>
                <button class="btn btn-primary w-100">Confirm Purchase</button>
                </div>
            </div>
        </section>
    </div>
</template>

<script>
 export default{
    mounted(){
        console.log("Home");
    }
 }
</script>