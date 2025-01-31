import { createWebHistory, createRouter } from 'vue-router';
import Home from './pages/Home.vue';
import login from './pages/login.vue';
import dashboard from './pages/dashboard.vue';
import SetRate from './pages/set_rate.vue';
import SetRateTiming from './pages/set_rate_timing.vue';
import OwnerShip from './pages/ownership.vue';
import AddToken from './pages/tokens/create.vue';

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