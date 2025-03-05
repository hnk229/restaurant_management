<script setup>
    import { useAuthStore } from '../../composables/authStore';
    import { ref, onMounted, onBeforeUnmount } from 'vue';
    import { useDisplay } from 'vuetify/lib/framework.mjs';

    // Utilisation de l'utilitaire `useDisplay` de Vuetify pour détecter la taille de l'écran
    const { lgAndUp } = useDisplay();
    const isLargeScreen = ref(lgAndUp.value);

    // Mise à jour de la valeur réactive lorsque la taille de l'écran change
    const updateScreenSize = () => {
        isLargeScreen.value = lgAndUp.value;
    };

    onMounted(() => {
        window.addEventListener('resize', updateScreenSize);
    });

    onBeforeUnmount(() => {
        window.removeEventListener('resize', updateScreenSize);
    });


    const authStore = useAuthStore();
</script>

<template>
    <v-app-bar
        title="Application bar"
        elevation="0"
        >
        <v-layout>

        </v-layout>
        <v-container max-width="10rem">

            <v-btn v-if="authStore.user"
                @click="authStore.logout"
                style="font-weight: bold; right: 1rem; width: 3rem;"
                color="primary" size="small"
                variant="plain"
                prepend-icon="mdi-logout"
                block>{{ authStore.user.nom || "" }} {{ authStore.user.prenom || "" }}</v-btn>
        </v-container>
        <!-- <v-container >

            <v-icon
                @click="authStore.logout"
                style="right: 1rem;"
                color="primary" size="small"
                variant="plain"
                block>mdi-logout</v-icon>
        </v-container> -->
    </v-app-bar>
</template>

<style>
    .max-w-420 {
        max-width: 920px;
    }
</style>
