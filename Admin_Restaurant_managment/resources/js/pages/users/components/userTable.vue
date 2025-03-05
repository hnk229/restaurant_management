
<template>
    <v-data-table :headers="headers" :items="users" :search="search"
        :sort-by="[{ key: 'nom', order: 'asc' }]" class="w-100 px-3"
        itemsPerPageText ="Eléments par page"
        :footer-props="{
            showFirstLastPage: true,
            itemsPerPageOptions: [5, 10, 20],
            showCurrentPage: true
        }"
        >
        <!-- Personnalisation de l'en-tête pour chaque colonne -->
        <!-- <template v-slot:header.name="{ header }">
            {{ header.name.toUpperCase() }}
        </template>
        <template v-slot:header.image="{ header }">
            <span style="font-weight: bold;">{{ header.text }}</span>
        </template> -->

        <!-- Barre d'outils avec barre de recherche et bouton "Add" -->
        <template v-slot:top>
            <v-toolbar flat color="white" >
                <!-- Barre de recherche -->
                <v-text-field
                    :value="search"
                    @input="$emit('update:search', $event.target.value)"
                    label="Rechercher un utilisateur"
                    append-inner-icon="mdi-close"
                    density="compact"
                    variant="outlined"
                    single-line
                    class="mt-5 input-search"
                    @click:append-inner="$emit('update:search', '')"
                    >

                </v-text-field>
                <!-- Bouton pour ajouter un nouvel élément -->
                <v-dialog v-model="dialog" max-width="35rem">
                    <template v-slot:activator="{ props }">
                        <v-btn class="mx-4 rounded-lg my-1 transition delay-150 duration-150 ease-in-out hover:-translate-y-1 hover:scale-110"
                            color="primary" v-bind="props" prepend-icon="mdi-plus"
                            active>
                            <span class=" font-bold">Add</span>
                        </v-btn>
                    </template>
                    <!-- Formulaire pour ajouter une nouvelle catégorie -->
                    <UserCreateDialog
                    v-model="dialog"
                    @save="$emit('save', $event)"
                    />
                </v-dialog>
            </v-toolbar>
        </template>

        <!-- Actions pour chaque ligne (éditer et supprimer) -->
        <template v-slot:item.actions="{ item }"><!-- eslint-disable-line vue/valid-v-slot -->
            <v-btn
                active
                class="rounded-lg py-2 mr-2"
                variant="text"
                size="small"
                color="warning"
                icon="mdi-pencil"
                @click="$emit('edit', item)">
            </v-btn>
            <v-btn
                active
                class="rounded-lg py-2"
                variant="text"
                size="small"
                color="primary"
                icon="mdi-delete"
                @click="$emit('delete', item)">
            </v-btn>
        </template>
        <template v-slot:no-data>
      <div class="text-center">
        <v-icon size="100" color="grey">mdi-database-remove</v-icon>
        <p class="mt-3">Aucun utilisateur disponible</p>
      </div>
    </template>
    </v-data-table>
</template>

<script setup>
    import { ref, defineProps } from 'vue'; // Importer ref et defineProps de Vue
    import UserCreateDialog from './userCreateDialog.vue';

    defineProps({
        users: Array,
        search: String,
    });
    const dialog = ref(false); // Définir dialog comme une variable réactive

    const headers = [
        { title: 'NOM & PRENOM', key: 'nom', align: 'start', sortable: true },
        { title: 'EMAIL', key: 'email', align: 'start', sortable: false },
        { title: 'USERNAME', key: 'username', align: 'start', sortable: false },
        { title: 'ROLE', key: 'role', align: 'start', sortable: false },
        { title: ' ', key: 'actions', sortable: false },
    ];
</script>
