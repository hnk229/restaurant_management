<script setup>
import { ref } from 'vue';
import SideBar from '../components/sideBar/sideBar.vue';
const links = ref([
    { title: 'Dashboard', icon: 'mdi-view-dashboard', route: 'dashboard' },
    { title: 'Users', icon: 'mdi-account-group', route: 'user' },
    // { title: 'Permissions', icon: 'mdi-lock', to: '/permissions' },
    // { title: 'Settings', icon: 'mdi-cog', to: '/settings' },
]);

</script>
<template>
    <v-layout class="rounded rounded-sm">
        <v-app-bar
        title="Application bar"
        elevation="0"
        
        >
        </v-app-bar>
        <SideBar />


        <v-main class="d-flex align-center justify-center" style="min-height: 300px;">
            <router-view ></router-view>
        </v-main>
    </v-layout>
</template>
