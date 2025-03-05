<template>
    <v-container fluid class="fill-height">
        <!-- Layout pour les écrans larges (lg et plus) -->
        <v-layout v-if="isLargeScreen" class="h-screen">
            <!-- Section principale (contenu) -->
            <v-main class="d-flex align-center justify-center">
                <v-container class="max-w-420">
                    <router-view />
                </v-container>
            </v-main>
        </v-layout>

        <!-- Layout pour les écrans plus petits -->
        <v-layout v-else class="h-screen">
            <v-main>
                <v-container class="pa-4">
                    <v-row class="d-flex align-start justify-center">
                        <v-col cols="12" class="d-flex flex-column align-start">
                            <!-- Contenu -->
                            <router-view />
                        </v-col>
                    </v-row>
                </v-container>
            </v-main>
        </v-layout>
    </v-container>
</template>

<script lang="ts" setup>
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

    // URL du logo (à remplacer par le chemin de ton logo)
    const logoUrl = 'https://cdn.vuetifyjs.com/docs/images/logos/vuetify-logo-v3-slim-text-light.svg';
</script>

<style scoped>
    .max-w-420 {
        max-width: 850px;
    }
</style>
