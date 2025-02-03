<template>
    <div>
      <!-- Navbar -->
      <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
        <div class="container">
          <a class="navbar-brand" href="#">Presale</a>
          <div v-if="wallet.isConnected">
            <button class="btn btn-outline-danger ms-auto" @click="wallet.disconnectWallet()">Disconnect</button>
          </div>
          <div v-else>
            <button class="btn btn-outline-light ms-auto" @click="wallet.openModal()">Connect Wallet</button>
          </div>
        </div>
      </nav>
  
      <!-- Hero Section -->
      <section class="hero-section mt-5 text-center">
        <h1>Welcome to TokenX Presale</h1>
        <p class="mt-3">Get your tokens now before the presale ends!</p>
        <div class="countdown my-4">Presale Ends In: 
          <span id="countdown-timer">
            {{ formattedCountdown }}
          </span>
        </div>
        <div v-if="wallet.isConnected">
            <button class="btn btn-light btn-lg">Buy Tokens Now</button>
        </div>
        <div v-else>
            <button class="btn btn-light btn-lg" @click="wallet.openModal()">Connect Wallet</button>
        </div>
      </section>
  
      <!-- Token Purchase Section -->
      <section id="purchase-section" class="container my-5">
        <div class="row justify-content-center">
          <div class="col-md-6 buy-section">
            <h4 class="text-center mb-4">Purchase Tokens</h4>
            <form @submit.prevent="purchaseToken">
            <div class="mb-3">
              <label for="walletAddress" class="form-label">Wallet Address</label>
              <input type="text" v-model="accountAddress" class="form-control" id="walletAddress" placeholder="Connect your wallet" readonly required/>
            </div>
            <div class="mb-3">
              <label for="tokenAmount" class="form-label">Enter Token Amount</label>
              <input type="text"  v-model="amount" class="form-control" id="tokenAmount" placeholder="e.g. 100" required>
            </div>
            <div class="mb-3">
              <label for="paymentMethod" class="form-label">Payment Method</label>
              <select class="form-select" id="paymentMethod">
                <option value="polygon">Polygon</option>
              </select>
            </div>
            <div v-if="wallet.isConnected">
                <button type="submit" class="btn btn-primary w-100" :disabled="loading">{{ loading ? "Please Wait..." : "Buy Now" }}</button>  
            </div>
          
            <div v-else>
              <button type="button" class="btn btn-primary w-100" @click="wallet.openModal()">Connect Wallet</button>  
            </div>
          </form>
          </div>
        </div>
      </section>
    </div>
  </template>
  
  <script setup>
  import { ref, onMounted, onBeforeUnmount, computed, watchEffect, getCurrentInstance } from 'vue'; 
  import { BrowserProvider } from 'ethers';
  import { useAppKitProvider } from '@reown/appkit/vue';
  import { useToast } from 'vue-toast-notification';
  import axios from "axios";
  import { ethers } from "ethers";

  const days = ref(0);
  const hours = ref(0);
  const minutes = ref(0);
  const seconds = ref(0);
  const endTimeVal = ref(0);
  const amount = ref('');
  const loading = ref(false);
  
  const instance = getCurrentInstance();
  const wallet = instance.appContext.config.globalProperties.$wallet;
  const accountAddress = ref('');
  const balance = ref('');
  const toast = useToast();
  const contractAddress = '0x1D1e4E7028C6335c1cD1d78b2bB0cD3CBABD08b9';
  const balanceABI = [
      {
        "inputs": [
          { "internalType": "address", "name": "account", "type": "address" }
        ],
        "name": "balanceOf",
        "outputs": [
          { "internalType": "uint256", "name": "", "type": "uint256" }
        ],
        "stateMutability": "view",
        "type": "function"
      }
    ];
  watchEffect(async() => {
    if (wallet.isConnected) {
        accountAddress.value = wallet.accountAddress;
    } else {
        accountAddress.value = ''; // Clear the address if disconnected
    }
  });

  let timerInterval;
  
  
  const endTimeABI = [
    {
      "constant": true,
      "inputs": [],
      "name": "endTime",
      "outputs": [{ "name": "", "type": "uint256" }],
      "payable": false,
      "stateMutability": "view",
      "type": "function"
    }
  ];

  const targetDateTimestamp = computed(() => endTimeVal.value * 1000);
  
  // Update the countdown time dynamically
  const updateCountdown = () => {
    if (targetDateTimestamp.value === 0) return; // Wait for valid timestamp
  
    const now = Date.now();
    const timeLeft = targetDateTimestamp.value - now; // Time remaining in milliseconds
  
    if (timeLeft > 0) {
      days.value = Math.floor(timeLeft / (1000 * 60 * 60 * 24));
      hours.value = Math.floor((timeLeft % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
      minutes.value = Math.floor((timeLeft % (1000 * 60 * 60)) / (1000 * 60));
      seconds.value = Math.floor((timeLeft % (1000 * 60)) / 1000);
    } else {
      clearInterval(timerInterval);
    }
  };
  
  // Computed property for formatted countdown
  const formattedCountdown = computed(() => {
    return `${days.value.toString().padStart(2, '0')}:${hours.value.toString().padStart(2, '0')}:${minutes.value.toString().padStart(2, '0')}:${seconds.value.toString().padStart(2, '0')}`;
  });
  
  // Fetch `endTime` from contract
  const getEndTime = async () => {
    try {
      const provider = new ethers.JsonRpcProvider("https://polygon-rpc.com");
      const contract = new ethers.Contract(contractAddress, endTimeABI, provider);
      let endTime = await contract.endTime();
      endTimeVal.value = Number(endTime); // Convert BigInt to Number
    } catch (error) {
      console.error("Error fetching endTime:", error);
    }
  };
  
  onMounted(async () => {
    await getEndTime(); // Fetch end time first
    updateCountdown(); // Initialize countdown with fetched value
    timerInterval = setInterval(updateCountdown, 1000); // Update every second
    // if (wallet.isConnected) {
    //     accountAddress.value = wallet.accountAddress;
    //     const { walletProvider } = useAppKitProvider('eip155');
    //     const provider = new BrowserProvider(walletProvider);
    //     const signer = await provider.getSigner();
    //     const contract = new ethers.Contract(contractAddress, balanceABI, signer);
    //     const balance = await contract.balanceOf(accountAddress.value);
    //     console.log(parseFloat(balance));  
    // }
  });
  
  onBeforeUnmount(() => {
    clearInterval(timerInterval);
  });

  let purchaseToken = async() => {    
     try
     { 
       loading.value = true;
       const abi = [
      {
        "inputs": [],
        "stateMutability": "payable",
        "name": "buy",
        "outputs": [
          {
            "internalType": "bool",
            "name": "",
            "type": "bool"
          }
        ],
        "type": "function"
      },
    ];
      const { walletProvider } = useAppKitProvider('eip155');
      const provider = new BrowserProvider(walletProvider);
      const signer = await provider.getSigner();
      const contract = new ethers.Contract(contractAddress, abi, signer);
      const valueInWei = ethers.parseUnits(amount.value.toString(), 'ether');
      const tx = await contract.buy({
        value: valueInWei,
      });
      console.log(tx.hash);
      axios.post('/api/save-purchase/', {
          wallet_address: accountAddress.value,
          polygon_amount: amount.value,
          transaction_hash: tx.hash 
        },{
          headers: {
            Accept: 'application/json',
            'Content-Type': 'application/json'
          }
        })
        .then((response) => {
          console.log(response.data);
          toast.success(response.data.message, { position: 'top-right', duration: 1000 });
        })
        .catch((error) => {
           console.log(error);
        });

     }catch (error) {
      console.error("Error during transaction:", error);
    } finally {
      loading.value = false;
    }
     
  };
  </script>
  
  