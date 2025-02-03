<template>
    <div class="container-fluid" id="container-wrapper">
      <div class="d-sm-flex align-items-center justify-content-between mb-4">
        <h1 class="h3 mb-0 text-gray-800">Set Rate</h1>  
        <ol class="breadcrumb">
          <li class="breadcrumb-item"><router-link to="/admin/dashboard">Dashboard</router-link></li> 
          <li class="breadcrumb-item">Forms</li>
          <li class="breadcrumb-item active" aria-current="page">Set Rate</li>
        </ol>
      </div>
      <div class="row">
        <div class="col-lg-12">
          <div class="card mb-4">
            <div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
              <h6 class="m-0 font-weight-bold text-primary">Set Rate</h6>
            </div>
            <div class="card-body">
              <form @submit.prevent="setRate">
                <div class="form-group">
                  <label for="rate">Rate</label>
                  <input 
                    v-model="rate" 
                    type="number" 
                    class="form-control" 
                    id="rate" 
                    placeholder="Rate" 
                    required 
                  />
                  <small v-if="errors.rate" class="text-danger">{{ errors.rate[0] }}</small>  
                </div> 
                <div class="form-group">
                  <button :disabled="loading" type="submit" class="btn btn-success btn-block">
                    {{ loading ? "Please Wait..." : "Set Rate" }}
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
  import { useStore } from 'vuex';
  import { BrowserProvider } from 'ethers';
  import { useAppKitProvider } from '@reown/appkit/vue'; 
  import { ethers } from "ethers";
  import { useToast } from 'vue-toast-notification';
  import axios from "axios";
  
  const rate = ref(""); // Reactive variable for input value
  const loading = ref(false); // Reactive variable to track loading state
  const toast = useToast();
  const store = useStore();
  const errors = ref({}); // Store validation errors
  
  const token = computed(() => store.getters.getToken);
  const form = ref({ token: null });
  
  watch(token, (newToken) => {
    form.value.token = newToken;
  });
  
  const tokenValue = token.value;
  
  onMounted(() => {
    form.value.token = token.value;
    axios.get('/api/get-rate/', {
        headers: {
            Accept: 'application/json',
            Authorization: `Bearer ${tokenValue}`,
            'Content-Type': 'application/json',
        },
    }).then((response) => {
        rate.value = response.data.data.rate;
    }).catch((error) => {
        console.error('Error:', error);
    });
  });
  
  const setRate = async () => {
    try {
      loading.value = true;
      errors.value = {}; // Clear previous errors
  
      const { walletProvider } = useAppKitProvider('eip155');
      const contractAddress = "0x1D1e4E7028C6335c1cD1d78b2bB0cD3CBABD08b9";
      const contractABI = ["function setRate(uint256 _rate) public returns (bool)"];
      
      const provider = new BrowserProvider(walletProvider);
      const signer = await provider.getSigner();
      const contract = new ethers.Contract(contractAddress, contractABI, signer);
      
      const tx = await contract.setRate(rate.value);
      console.log("Transaction sent:", tx.hash);
      
      const receipt = await tx.wait(); 
  
      axios.post('/api/save-rate/', {
          rate: rate.value,
          transaction_hash: receipt.hash
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
      console.error("Error during transaction:", error);
    } finally {
      loading.value = false;
    }
  };
  </script>
  