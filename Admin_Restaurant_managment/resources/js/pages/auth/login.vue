<script setup>
import { ref, nextTick } from 'vue';
import { useAuthStore } from '../../composables/authStore';
import { useRouter } from 'vue-router';

// États réactifs
const snackbar = ref(false);
const snackbarMessage = ref('');
const snackbarColor = ref('success');
const email = ref('');
const password = ref('');
const visible = ref(false);
const authStore = useAuthStore();
const router = useRouter();
const loading = ref(false);

const handleSubmit = async () => {
    loading.value = true;
    console.log("Valeur email :", email.value); // Vérifie si l'email est bien renseigné
  console.log("Valeur password :", password.value); // Vérifie si le mot de passe est bien récupéré

    // Appeler l'action login du store Pinia
    if(await authStore.login({ email: email.value, password: password.value })){
        snackbarMessage.value = "Bienvenu " + authStore.user.nom + " " + authStore.user.prenom;
        snackbarColor.value = 'success';
        snackbar.value = true;
    }else{
        snackbarMessage.value = authStore.errorMessage;
        snackbarColor.value = 'error';
        snackbar.value = true;
    }

    console.log(snackbar.value)
    loading.value = false;

};
</script>

<template>
    <!-- Snackbar pour les notifications -->
    <v-snackbar
         v-model="snackbar"
         :color="snackbarColor"
         top
         right
         class="custom-snackbar"
         app
        >
            {{ snackbarMessage }}
        </v-snackbar>
    <div class="d-flex align-center justify-center">
        <v-img class=" mx-4" max-width="200"
            src="https://cdn.vuetifyjs.com/docs/images/logos/vuetify-logo-v3-slim-text-light.svg"></v-img>

        <v-card class=" mx-10 pa-10 pb-8" style="width: 25rem;" elevation="8" rounded="lg">
            <div class="text-subtitle-1 text-medium-emphasis">Account</div>

            <v-text-field v-model="email" density="compact" placeholder="Email address"
                prepend-inner-icon="mdi-email-outline" variant="outlined"></v-text-field>

            <div class="text-subtitle-1 text-medium-emphasis d-flex align-center justify-space-between">
                Password

                <a class="text-caption text-decoration-none primary" href="#" rel="noopener noreferrer" target="_blank">
                    Forgot login password?
                </a>
            </div>

            <v-text-field v-model="password" :append-inner-icon="visible ? 'mdi-eye-off' : 'mdi-eye'"
                :type="visible ? 'text' : 'password'" density="compact" placeholder="Enter your password"
                prepend-inner-icon="mdi-lock-outline" variant="outlined"
                @click:append-inner="visible = !visible"></v-text-field>

            <!-- Afficher les erreurs -->
            <v-alert v-if="authStore.errorMessage" type="error" class="mt-3">
                {{ authStore.errorMessage }}
            </v-alert>


            <v-btn @click="handleSubmit" class="" style="font-weight: bold;" color="primary" size="large" variant="text" active block>
                <v-progress-circular v-if="loading" indeterminate color="primary" size="20"></v-progress-circular>
                <span v-else>Log In</span>
            </v-btn>

        </v-card>
    </div>
</template>

<style scoped>

</style>
