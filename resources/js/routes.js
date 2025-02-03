import { createWebHistory, createRouter } from 'vue-router';
import Home from './pages/Home.vue';
import login from './pages/login.vue';
import dashboard from './pages/dashboard.vue';
import SetRate from './pages/set_rate.vue';
import SetRateTiming from './pages/set_rate_timing.vue';
import OwnerShip from './pages/ownership.vue';
import RateLogs from './pages/rate_logs.vue';
import DurationLogs from './pages/duration_logs.vue';
import OwnerLogs from './pages/owner_logs.vue';
import Withdraw from './pages/withdraw.vue';
import PurchaseLogs from './pages/purchase_logs.vue';
import WithdrawLogs from './pages/withdraw_logs.vue';


const routes = [

	{
		path: '/',
		name: 'Home',
		component: Home,
		meta:{
			requiredAuth: false,
		}
   },

   {
   	  path: '/admin/login',
   	  name: 'Login',
   	  component: login,
   	  meta:{
   	  	requiredAuth: false,
   	  }
   },

   {
   	  path: '/admin/dashboard',
   	  name: 'Dashboard',
   	  component: dashboard,
   	  meta:{
   	  	requiredAuth: true,
   	  }
   },

   {
	path: '/admin/set-rate',
	name: 'SetRate',
	component: SetRate,
	meta:{
		requiredAuth: true,
	}
  },

  {
	path: '/admin/set-presale-timing',
	name: 'SetRateTiming',
	component: SetRateTiming,
	meta:{
		requiredAuth: true,
	}
  },
  
  {
	path: '/admin/transfer-ownership',
	name: 'OwnerShip',
	component: OwnerShip,
	meta:{
		requiredAuth: true,
	}
  },
  
  {
	path: '/admin/rate-logs',
	name: 'RateLogs',
	component: RateLogs,
	meta:{
		requiredAuth: true,
	}
  },

  {
	path: '/admin/duration-logs',
	name: 'DurationLogs',
	component: DurationLogs,
	meta:{
		requiredAuth: true,
	}
  },

  {
	path: '/admin/owner-logs',
	name: 'OwnerLogs',
	component: OwnerLogs,
	meta:{
		requiredAuth: true,
	}
  },

  {
	path: '/admin/withdraw',
	name: 'Withdraw',
	component: Withdraw,
	meta:{
		requiredAuth: true,
	}
  },

  {
	path: '/admin/purchase-logs',
	name: 'PurchaseLogs',
	component: PurchaseLogs,
	meta:{
		requiredAuth: true,
	}
  },

  {
	path: '/admin/withdraw-logs',
	name: 'WithdrawLogs',
	component: WithdrawLogs,
	meta:{
		requiredAuth: true,
	}
  },

];

const router = createRouter({
	history: createWebHistory(),
	routes
});

router.beforeEach((to,from)=>{
	if(to.meta.requiredAuth && !localStorage.getItem('token')){
		return {name: 'Login'}
	}
});

export default router;