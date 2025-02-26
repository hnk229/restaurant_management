<script setup>
    import { ref } from 'vue';
const links = ref([
    { title: 'Dashboard', icon: 'mdi-view-dashboard', route: 'dashboard' },
    { title: 'Categories', icon: 'mdi-shape', route: 'categories' },
    { title: 'Users', icon: 'mdi-account-group', route: 'user' },
    // { title: 'Products', icon: 'mdi-package-variant-closed', route: 'products' },
    // { title: 'Settings', icon: 'mdi-cog', to: '/settings' },
]);
</script>

<template>
    <v-navigation-drawer
        floating
        class="pt-3"
        color="white"
        model-value
      >

        <v-list>
            <v-list-item
                v-for="({title, route, icon}, index) in links"
                :key="index"
                :to="{name: route}"
                :prepend-icon="icon"
                color="primary"
                class="mx-4 rounded-lg my-1"
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
