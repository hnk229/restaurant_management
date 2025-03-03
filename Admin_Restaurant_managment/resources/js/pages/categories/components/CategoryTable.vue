<template>
    <v-data-table :headers="headers" :items="categories" :search="search" :loading="categories.length < 1"
        :sort-by="[{ key: 'name', order: 'asc' }]" class="w-100 px-3">
        <!-- Barre d'outils avec barre de recherche et bouton "Add" -->
        <template v-slot:top>
            <v-toolbar flat color="white" >
                <!-- Barre de recherche -->
                <v-text-field
                    :value="search"
                    @input="$emit('update:search', $event.target.value)"
                    label="Rechercher une catégorie"
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
                        <v-btn class="mx-4 rounded-lg my-1" color="primary" v-bind="props" prepend-icon="mdi-plus"
                            active>
                            Add
                        </v-btn>
                    </template>
                    <!-- Formulaire pour ajouter une nouvelle catégorie -->
                    <CategoryCreateDialog
                    v-model="dialog"
                    @save="$emit('save', $event)"
                    />
                </v-dialog>
            </v-toolbar>
        </template>

        <!-- Colonne pour l'image -->
        <template v-slot:item.image="{ item }"> <!-- eslint-disable-line vue/valid-v-slot -->
            <v-img v-if="item && item.image" :src="item.image" alt="Image" width="50" height="50" />
            <span v-else>Aucune image</span>
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
        <p class="mt-3">Aucune donnée disponible</p>
      </div>
    </template>
    </v-data-table>
</template>

<script setup>
import { ref, defineProps } from 'vue'; // Importer ref et defineProps de Vue
import CategoryCreateDialog from './CategoryCreateDialog.vue';

defineProps({
    categories: Array,
    search: String,
});
const dialog = ref(false); // Définir dialog comme une variable réactive

const headers = [
    { title: 'ID', key: 'id', align: 'start', sortable: true },
    { title: 'Nom', key: 'name', align: 'start', sortable: true },
    { title: 'Image', key: 'image', align: 'start', sortable: false },
    { title: ' ', key: 'actions', sortable: false },
];
</script>

<style scoped>
.tab-title {
    font-size: 2rem;
}

.custom-icon {
  border-radius: 50%; /* Rendre l'icône ronde avec un fond */
  display: inline-flex;
  justify-content: center;
  align-items: center;
}

/* Couleur d'arrière-plan avec opacité réduite pour les différentes couleurs */
.custom-icon.v-icon--primary {
  background-color: rgba(255, 111, 97, 0.5); /* primary #FF6F61 */
}

.custom-icon.v-icon--warning {
  background-color: rgba(17, 138, 178, 0.8); /* warning #118AB2 */
}

</style>
