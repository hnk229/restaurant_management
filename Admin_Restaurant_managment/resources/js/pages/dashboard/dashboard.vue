<template>
    <div>
        <v-snackbar v-model="snackbar" :color="snackbarColor" top right app>
            {{ snackbarMessage }}
        </v-snackbar>
        <div>Dashboard Pages</div>
    </div>
</template>

<script setup>
    import { useAuthStore } from '../../composables/authStore';
    import { ref, watchEffect } from 'vue';

    const snackbar = ref(false);
    const snackbarMessage = ref('');
    const snackbarColor = ref('success');
    const authStore = useAuthStore();

    watchEffect(() => {
        if (authStore.justLoggedIn && authStore.welcomeMessage) {
            snackbarMessage.value = authStore.welcomeMessage;
            snackbar.value = true;

            // Réinitialiser justLoggedIn après avoir affiché le message
            authStore.resetJustLoggedIn();
        }
    });

</script>

