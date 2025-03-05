import { defineStore } from 'pinia';
import useApi from './useApi';
import router from '../plugins/router';
import User from '../pages/users/user.vue';

interface User {
    id: number;
    nom: string;
    prenom: string;
    email: string;
    role: 'serveur' | 'cuisinier' | 'admin';
    username: string;
}

export const useAuthStore = defineStore('auth', {
  state: () => ({
    user: null as User | null, // Définir le type de `user` comme `User | null`
    token: localStorage.getItem('token') || null,
    errorMessage: null as string | null,
    justLoggedIn: false, //Etat pour suivre si l'utilisateur vien de login
  }),

  getters: {
    isAuthenticated: (state) => !!state.token,
    isAdmin: (state) => state.user?.role === 'admin', // Plus d'erreur maintenant
    welcomeMessage: (state) => {
        if (state.user) {
          return `Bienvenue, ${state.user.prenom} ${state.user.nom}`;
        }
      },
  },

  actions: {
    async login(credentials: { email: string; password: string }) {
        try {
            console.log("Tentative de connexion avec :", credentials); // Vérifie les valeurs avant envoi
          const response = await useApi().$post('auth/login', credentials);
          console.log("Réponse du serveur :", response); // Vérifie la réponse du serveur

          this.token = response.token;
          localStorage.setItem('token', this.token);

          await this.fetchUser();
          this.errorMessage = null; // Réinitialiser les erreurs après un succès
          this.justLoggedIn = true; // Marquer que l'utilisateur vien de Login

          router.push('/');
        } catch (error: any) {
          // Vérifier si la réponse contient un message d'erreur
          if (error.response && error.response.data && error.response.data.message) {
            this.errorMessage = error.response.data.message; // Message du backend
          } else {
            this.errorMessage = 'Une erreur est survenue. Veuillez réessayer.';
          }
        }
      },


    //
    async fetchUser() {
      try {
        const response = await useApi().$get('user', {
          headers: { Authorization: `Bearer ${this.token}` },
        });
        this.user = response as User; // Typage explicite de la réponse
        console.log("L'utilisateur récupérer : ",this.user)
      } catch (error) {
        this.logout();
      }
    },

    logout() {
      this.user = null;
      this.token = null;
      localStorage.removeItem('token');
      router.push('auth/login');
    },

    // Réinitialiser l'état justLoggedIn
    resetJustLoggedIn() {
        this.justLoggedIn = false;
      },
  },
});
