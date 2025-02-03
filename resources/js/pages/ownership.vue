<template>
  <div class="container-fluid" id="container-wrapper">
    <div class="d-sm-flex align-items-center justify-content-between mb-4">
      <h1 class="h3 mb-0 text-gray-800">Tranfer Ownership</h1>  
      <ol class="breadcrumb">
        <li class="breadcrumb-item"><router-link to="/admin/dashboard">Dashboard</router-link></li> 
        <li class="breadcrumb-item">Forms</li>
        <li class="breadcrumb-item active" aria-current="page">Transfer OwnerShip</li>
      </ol> 
    </div> 
    <div class="row">
     <div class="col-lg-12">
       <div class="card mb-4">
         <div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
           <h6 class="m-0 font-weight-bold text-primary">Transfer OwnerShip</h6> 
         </div>
         <div class="card-body">
           <form @submit.prevent="transferOwnership">
            <div class="form-group">
              <label for="wallet_address">Wallet Address</label> 
              <input type="text" v-model="wallet_address" class="form-control" id="wallet_address" placeholder="Wallet Address" required/> 
            </div>
            <div class="form-group">
                <button :disabled="loading" type="submit" class="btn btn-success btn-block">
                    {{ loading ? "Please Wait..." : "Transfer OwnerShip" }}
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
 import { useRouter } from 'vue-router';

 const wallet_address = ref("");
 const loading = ref(false);
 const toast = useToast();
 const store = useStore();
 const errors = ref({});
 const router = useRouter();

 const token = computed(() => store.getters.getToken);
 const form = ref({ token: null }); 

 watch(token, (newToken) => {
    form.value.token = newToken;
 });
 
 const tokenValue = token.value;

 onMounted(() => {
    form.value.token = token.value;
    axios.get('/api/get-owner/', {
        headers: {
            Accept: 'application/json',
            Authorization: `Bearer ${tokenValue}`,
            'Content-Type': 'application/json',
        },
    }).then((response) => {
        wallet_address.value = response.data.owner.wallet_address;
    }).catch((error) => {
        console.error('Error:', error);
    });
  });

  let transferOwnership = async() => { 
    try
    {
        loading.value = true;
        errors.value = {};

        const { walletProvider } = useAppKitProvider('eip155');
        const contractAddress = "0x1D1e4E7028C6335c1cD1d78b2bB0cD3CBABD08b9";
        const contractABI = [
            "function transferOwnership(address newOwner) external returns (bool)",
            "event TransferOwnerShip(address indexed newOwner)"
        ];
        const provider = new BrowserProvider(walletProvider);
        const signer = await provider.getSigner();
        const contract = new ethers.Contract(contractAddress, contractABI, signer);
        const tx = await contract.transferOwnership(wallet_address.value);
        const receipt = await tx.wait();

        axios.post('/api/save-owner/', {
          wallet_address: wallet_address.value,
          transaction_hash: receipt.hash
        }, {
          headers: {
            Accept: 'application/json',
            Authorization: `Bearer ${tokenValue}`,
            'Content-Type': 'application/json'
          }
        })
        .then((response) => {
          toast.success(response.data.message, { position: 'top-right', duration: 1000 });
          store.dispatch('logout').then(() => {
            toast.success("Logged out successfully", { position: 'top-right', duration: 1000 });
          });
          localStorage.setItem('logout', 'true');
          router.push({ name: 'Login' });
        })
        .catch((error) => {
          console.error('API Error:', error);
          if (error.response && error.response.data && error.response.data.data) {
            errors.value = error.response.data.data; // Store validation errors
          } else {
            toast.error("Something went wrong!", { position: 'top-right' });
          }
        });

    }catch (error) {
      console.error("Error during transaction:", error);
    } finally {
      loading.value = false;
    }
  };

</script>