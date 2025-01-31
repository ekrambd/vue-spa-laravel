<template>
  <div class="container-fluid" id="container-wrapper">
   <div class="d-sm-flex align-items-center justify-content-between mb-4">
     <h1 class="h3 mb-0 text-gray-800">Add Token</h1>
        <ol class="breadcrumb">
          <li class="breadcrumb-item"><router-link to="/dashboard">Dashboard</router-link></li>
          <li class="breadcrumb-item">Forms</li>
          <li class="breadcrumb-item active" aria-current="page">Add Token</li>
        </ol>
   </div>
   <div class="row">
     <div class="col-lg-12">
       <div class="card mb-4">
       	 <div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
            <h6 class="m-0 font-weight-bold text-primary">Add Token</h6>
        </div>
        <div class="card-body">
         <form @submit.prevent="insertToken">

          <div class="form-group">
	        <label for="token_name">Token Name</label>
	        <input type="text" class="form-control" id="token_name"
	            placeholder="Token Name" v-model="form.token_name" required="" />
	        <small class="text-danger" v-if="errors.token_name">{{ errors.token_name[0] }}</small>
           </div>

           <div class="form-group">
	        <label for="token_symbol">Token Symbol</label>
	        <input type="text" class="form-control" v-model="form.token_symbol" id="token_symbol"
	            placeholder="Token Symbol" />
	        <small class="text-danger" v-if="errors.token_symbol">{{ errors.token_symbol[0] }}</small>
           </div> 


           <div class="form-group">
	        <label for="contract_address">Contract Address</label>
	        <input type="text" class="form-control" id="contract_address" v-model="form.contract_address"
	            placeholder="Contract Address" required="" />
	        <small class="text-danger" v-if="errors.contract_address">{{ errors.contract_address[0] }}</small>
           </div>

           <div class="form-group">
	        <label for="recipient_address">Recipient Address</label>
	        <input type="text" class="form-control" v-model="form.recipient_address" id="recipient_address"
	            placeholder="Recipient Address" required="" />
	        <small class="text-danger" v-if="errors.recipient_address">{{ errors.recipient_address[0] }}</small>
           </div>

           <div class="form-group">
           	<label for="status">Status</label>
           	<select class="form-control" v-model="form.status" id="status" required="">
           	   <option value="" selected="" disabled="">Choose Option</option>
           	   <option value="Active">Active</option>
           	   <option value="Inactive">Inactive</option>
           	</select>
           	<small class="text-danger" v-if="errors.status">{{ errors.status[0] }}</small>
           </div>

           <div class="form-group">
           	 <button type="submit" class="btn btn-success">Submit</button>
           </div>
         </form>
        </div>
       </div>
     </div>
   </div>
  </div>	
</template>

<script>
  export default{
  	 mounted()
  	 {
  	 	console.log("Add Token");
  	 },
  	 data()
  	 {
  	 	return{
  	 		form:{
  	 			token_name: '',
  	 			token_symbol: '',
  	 			contract_address: '',
  	 			recipient_address: '',
  	 			status: '', 
  	 		},
			token: null, 
  	 		errors:{},
  	 	}
  	 },
	 watch: {
		// Watch for token changes and update form.token
		token(newToken) {
		  this.token = newToken;
		}
	 },
	 created() {
			// Initialize form.token with the current token
			this.token = localStorage.getItem('token') || '';
	 },
  	 methods:{ 	
		
    	insertToken(){
    		// axios.post('/api/tokens/',this.form)
    		// .then(() => {
    		// 	this.$router.push({ name: 'addToken' })
    		// 	Notification.success()
    		// })
			axios.post('/api/tokens/', this.form, {
				headers: {
				'Accept': 'application/json',
				'Authorization': `Bearer ${this.token}`,
				'Content-Type': 'application/json',
				},
			}).then((response) => {
				this.form.token_name = '';
				this.form.token_symbol = '';
				this.form.contract_address = '';
				this.form.recipient_address = '';
				this.form.status = '';
    			this.$toast.success(response.data.message);
                this.$router.push({ name: 'AddToken' });
    		})
    		.catch((error)=>{
				console.log(error);
				this.errors = error.response.data.errors
			})
    	},
        	
     }

  }
</script>