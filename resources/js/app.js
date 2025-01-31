import './bootstrap';
import { createApp } from 'vue'

import router from './routes.js'


import App from './components/App.vue'

import "vue-toast-notification/dist/theme-sugar.css"; // Import a theme CSS
import VueToast from "vue-toast-notification";

import store from './store/index.js'
import walletPlugin from './plugins/wallet.js';

const app = createApp(App);

app.use(router);

app.use(store);
app.use(walletPlugin);
app.use(VueToast,{
	position: 'top-right',
	duration: 1000,
});

app.mount('#app');