<template>
  <div class="container-fluid" id="container-wrapper">
    <div class="d-sm-flex align-items-center justify-content-between mb-4">
      <h1 class="h3 mb-0 text-gray-800">Set Rate Timing</h1>
      <ol class="breadcrumb">
        <li class="breadcrumb-item"><router-link to="/admin/dashboard">Dashboard</router-link></li>
        <li class="breadcrumb-item">Forms</li>
        <li class="breadcrumb-item active" aria-current="page">Set Rate Timing</li>
      </ol>
    </div>
    <div class="row">
      <div class="col-lg-12">
        <div class="card mb-4">
          <div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
            <h6 class="m-0 font-weight-bold text-primary">Set Rate Timing</h6>
          </div>
          <div class="card-body">
            <form @submit.prevent="setDuration">
              <div class="form-group">
                <label for="duration">Set Duration</label>
                <input type="number" v-model="duration" class="form-control" id="duration" placeholder="Duration" required/>
              </div>
              <div class="form-group">
                <label for="duration_unit">Duration Unit</label>
                <select class="form-control" v-model="duration_unit" id="duration_unit" required>
                  <option value="" selected="" disabled="">Choose Option</option>
                  <option value="Day">Day</option>
                  <option value="Week">Week</option>
                  <option value="Month">Month</option>
                  <option value="Year">Year</option>
                </select>
              </div>
              <div class="form-group">
                <button :disabled="loading" type="submit" class="btn btn-success btn-block">
                    {{ loading ? "Please Wait..." : "Set Rate Timing" }}
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
  let duration = ref(""); 
  let duration_unit = ref("");
  let loading = ref(false);
  const toast = useToast();
  const store = useStore();
  const errors = ref({});
  const token = computed(() => store.getters.getToken);
  const form = ref({ token: null });
  watch(token, (newToken) => {
    form.value.token = newToken;
  });

  const tokenValue = token.value;

  //console.log(tokenValue);

  onMounted(()=>{
    form.value.token = token.value;
    axios.get('/api/duration-info/', {
        headers: {
            Accept: 'application/json',
            Authorization: `Bearer ${tokenValue}`,
            'Content-Type': 'application/json',
        },
    }).then((response) => {
        duration.value = response.data.data.duration;
        duration_unit.value = response.data.data.duration_unit;
    }).catch((error) => {
        console.error('Error:', error);
    });
  });

  let setDuration = async() => {
     try{
      loading.value = true;
      errors.value = {};
      const contractAddress = "0x0a9e734ea2253ae046fc3875278492d818e674bf"; 
      const contractABI = [
        "function presaleOn(uint256 _endTime) external returns (bool)",
        "event PresaleOn(uint256 endTime)"
      ];
      const { walletProvider } = useAppKitProvider('eip155');
      const provider = new BrowserProvider(walletProvider);
      let seconds;
      if(duration_unit.value == 'Day'){
        seconds = duration.value * 24 * 60 * 60;
      }
      else if(duration_unit.value == 'Week'){
        seconds = duration.value * 7 * 24 * 60 * 60;
      }
      else if(duration_unit.value == 'Month'){
        seconds = duration.value * 30 * 24 * 60 * 60;
      }
      else if(duration_unit.value == 'Year'){
        seconds = duration.value * 365 * 24 * 60 * 60;
      }
      console.log(seconds);
      const signer = await provider.getSigner();
      const contract = new ethers.Contract(contractAddress, contractABI, signer);
      const tx = await contract.presaleOn(seconds);
      //console.log("Transaction sent:", tx.hash);
      const receipt = await tx.wait();
      console.log("Transaction confirmed:", receipt.hash);

      axios.post('/api/save-duration/', {
          duration: duration.value,
          duration_unit: duration_unit.value,
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

     }catch(error){
      console.error("Error during transaction:", error);
     }finally {
      loading.value = false;
    }
  };

</script>

<style scoped>

</style>