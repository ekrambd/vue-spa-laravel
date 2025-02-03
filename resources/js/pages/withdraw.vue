<template>
  <div class="container-fluid" id="container-wrapper">
    <div class="d-sm-flex align-items-center justify-content-between mb-4">
      <h1 class="h3 mb-0 text-gray-800">Wtihdraw</h1>  
      <ol class="breadcrumb">
        <li class="breadcrumb-item"><router-link to="/admin/dashboard">Dashboard</router-link></li> 
        <li class="breadcrumb-item">Forms</li>
        <li class="breadcrumb-item active" aria-current="page">TokenX Withdraw</li> 
      </ol>
    </div>
    <div class="row">
      <div class="col-lg-12">
        <div class="card mb-4">
          <div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
            <h6 class="m-0 font-weight-bold text-primary">TokenX Withdraw</h6>
          </div>  
          <div class="card-body">
            <form @submit.prevent="withdraw">
              <div class="form-group">
                <label for="amount">Amount</label>
                <input type="text" v-model="amount" class="form-control"  id="amount" placeholder="Amount" required/>
              </div>
              <div class="form-group">
                <button type="submit" :disabled="loading" class="btn btn-success btn-block">
                    {{ loading ? "Please Wait..." : "Withdraw" }}
                </button>
              </div>   
            </form>
          </div>
        </div>
      </div>  
    </div>
  </div>  
</template>

<script setup>
  import { ref, computed, watch, onMounted } from "vue";
  import { BrowserProvider } from 'ethers';
  import { useAppKitProvider } from '@reown/appkit/vue'; 
  import { ethers } from "ethers";
  import { useToast } from 'vue-toast-notification';
  import axios from "axios";
  import { useRouter } from 'vue-router';
  import { useStore } from 'vuex';

  const store = useStore();
  const amount = ref("");
  const loading = ref(false);
  const toast = useToast();
  const token = computed(() => store.getters.getToken);
  const form = ref({ token: null }); 
  const errors = ref({});

  watch(token, (newToken) => {
    form.value.token = newToken;
 });
 const tokenValue = token.value;

 onMounted(()=>{
    //
 });

 let withdraw = async() => {
  try {
    loading.value = true;
    errors.value = {};
    const { walletProvider } = useAppKitProvider('eip155');
    const contractAddress = "0x1D1e4E7028C6335c1cD1d78b2bB0cD3CBABD08b9"; // Your contract address
    const abi = [
      {
        "inputs": [
          { "internalType": "uint256", "name": "amount", "type": "uint256" }
        ],
        "name": "withdrawPrice",
        "outputs": [
          { "internalType": "bool", "name": "", "type": "bool" }
        ],
        "stateMutability": "nonpayable", // This function doesn't accept ether directly
        "type": "function"
      }
    ];

    // Set up provider and signer
    const provider = new BrowserProvider(walletProvider);
    const signer = await provider.getSigner();
    const contract = new ethers.Contract(contractAddress, abi, signer);
    const amountInWei = ethers.parseUnits(amount.value.toString(), 'ether');

    const tx = await contract.withdrawPrice(amountInWei);

    console.log('Transaction hash:', tx.hash);

    await tx.wait(); 

    axios.post('/api/save-withdraw/', {
          amount: amount.value,

          transaction_hash: tx.hash
        }, {
          headers: {
            Accept: 'application/json',
            Authorization: `Bearer ${tokenValue}`,
            'Content-Type': 'application/json'
          }
        })
        .then((response) => {
          console.log(response.data);
          toast.success(response.data.message, { position: 'top-right', duration: 1000 });
        })
        .catch((error) => {
          console.error('API Error:', error);
          if (error.response && error.response.data && error.response.data.data) {
            errors.value = error.response.data.data; // Store validation errors
          } else {
            toast.error("Something went wrong!", { position: 'top-right' });
          }
        });

  } catch (error) {

    if (error.reason) {
      toast.error(error.reason, { position: 'top-right' });
    }
  }finally{
    loading.value = false;
  }
};



</script>