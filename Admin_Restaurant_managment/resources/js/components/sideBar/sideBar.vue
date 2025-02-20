<script setup>
    import { ref } from 'vue';
const links = ref([
    { title: 'Dashboard', icon: 'mdi-view-dashboard', route: 'dashboard' },
    { title: 'Users', icon: 'mdi-account-group', route: 'user' },
    // { title: 'Permissions', icon: 'mdi-lock', to: '/permissions' },
    // { title: 'Settings', icon: 'mdi-cog', to: '/settings' },
]);
</script>

<template>
    <v-navigation-drawer
        floating
        class="pt-3 mx-3 my-3 rounded-lg elevation-2"
        color="white"
        model-value
        elevation="5"
      >

        <v-list>
            <v-list-item
                v-for="({title, route, icon}, index) in links"
                :key="index"
                :to="{name: route}"
                :prepend-icon="icon"
            >
            {{ title }}
            </v-list-item>
        </v-list>
        <!-- <v-avatar
          v-for="n in 6"
          :key="n"
          :color="`grey-${n === 1 ? 'darken' : 'lighten'}-1`"
          :size="n === 1 ? 36 : 20"
          class="d-block text-center mx-auto mb-9"
        ></v-avatar> -->
      </v-navigation-drawer>

</template>

<style scoped>

</style>
