import { createStore } from 'vuex'; 
import axios from 'axios'; // Import axios for making API calls if needed

const store = createStore({
  state: {
    token: localStorage.getItem('token') || null, // Initialize token to null if not found in localStorage
  },

  mutations: {
    // Update token
    UPDATE_TOKEN(state, payload) { 
      state.token = payload;
    }
  },

  actions: {
    // Set token in localStorage and Vuex state
    setToken({ commit }, payload) {
      localStorage.setItem('token', payload);
      commit('UPDATE_TOKEN', payload);
    },

    // Remove token from localStorage and Vuex state
    removeToken({ commit }) {
      localStorage.removeItem('token');
      commit('UPDATE_TOKEN', null); // Set token to null when removing
    },

    // ✅ Logout action that removes token and optionally makes an API request
    async logout({ dispatch }) {
      try {
        const token = localStorage.getItem('token');
        if (token) {
          await axios.post('/api/logout', {}, { 
            headers: { Authorization: `Bearer ${token}` }
          });
        }
      } catch (error) {
        console.error("Logout failed:", error);
      } finally {
        dispatch('removeToken'); // Clear token
      }
    }
  },

  getters: {
    // Get token from state
    getToken(state) {
      return state.token;
    }
  }
});

export default store;
