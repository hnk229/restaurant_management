<script setup>
import { ref } from 'vue';
import SideBar from '../components/sideBar/sideBar.vue';
import AppBar from '../components/appBar/appBar.vue';


</script>
<template>
    <v-layout>
        <AppBar />
        <SideBar />
        <v-main
            class="d-flex"

            >
            <router-view ></router-view>
        </v-main>
    </v-layout>
</template>
