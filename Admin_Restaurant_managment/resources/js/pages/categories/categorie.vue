<script>
import { ref, computed, watch, onMounted } from 'vue';

export default {
  setup() {
    // États réactifs
    const dialog = ref(false);
    const dialogDelete = ref(false);
    const search = ref('');
    const headers = ref([
      { title: 'ID', key: 'id', align: 'start', sortable: true },
      { title: 'Icon', key: 'icon', align: 'start', sortable: false },
      { title: 'Name', key: 'name', align: 'start', sortable: true },
      { title: 'Actions', key: 'actions', sortable: false },
    ]);
    const desserts = ref([]);
    const editedIndex = ref(-1);
    const editedItem = ref({
      id: '',
      name: '',
      icon: '',
      iconFile: null,
    });
    const defaultItem = ref({
      id: '',
      name: '',
      icon: '',
      iconFile: null,
    });
    // Liens pour le breadcrumb
    const links = ref([
            { title: 'Dashboard', icon: 'mdi-view-dashboard', to: 'dashboard' },
            { title: 'Categories', icon: 'mdi-shape', to: 'categories' },
        ]);

    // Propriété calculée pour filtrer les éléments
    const filteredDesserts = computed(() => {
      if (!search.value) return desserts.value;
      return desserts.value.filter((dessert) =>
        dessert.name.toLowerCase().includes(search.value.toLowerCase())
      );
    });

    // Propriété calculée pour le titre du dialogue
    const formTitle = computed(() => {
      return editedIndex.value === -1 ? 'New Item' : 'Edit Item';
    });

    // Observateurs pour fermer les dialogues
    watch(dialog, (val) => {
      if (!val) close();
    });
    watch(dialogDelete, (val) => {
      if (!val) closeDelete();
    });

    // Initialisation des données au montage du composant
    onMounted(() => {
      initialize();
    });

    // Fonction pour initialiser les données
    function initialize() {
      desserts.value = [
        { id: 1,icon: 'https://via.placeholder.com/50', name: 'Frozen Yogurt'  },
        { id: 2, icon: 'https://via.placeholder.com/50', name: 'Ice cream sandwich' },
        // Ajoutez d'autres éléments ici
      ];
    }

    // Fonction pour gérer le téléversement de fichiers
    function handleIconUpload(event) {
      const file = event.target.files[0];
      if (file) {
        const reader = new FileReader();
        reader.onload = (e) => {
          editedItem.value.icon = e.target.result;
        };
        reader.readAsDataURL(file);
      }
    }

    // Fonction pour éditer un élément
    function editItem(item) {
      editedIndex.value = desserts.value.indexOf(item);
      editedItem.value = Object.assign({}, item);
      dialog.value = true;
    }

    // Fonction pour supprimer un élément
    function deleteItem(item) {
      editedIndex.value = desserts.value.indexOf(item);
      editedItem.value = Object.assign({}, item);
      dialogDelete.value = true;
    }

    // Fonction pour confirmer la suppression
    function deleteItemConfirm() {
      desserts.value.splice(editedIndex.value, 1);
      closeDelete();
    }

    // Fonction pour fermer le dialogue d'édition
    function close() {
      dialog.value = false;
      setTimeout(() => {
        editedItem.value = Object.assign({}, defaultItem.value);
        editedIndex.value = -1;
      }, 300);
    }

    // Fonction pour fermer le dialogue de suppression
    function closeDelete() {
      dialogDelete.value = false;
      setTimeout(() => {
        editedItem.value = Object.assign({}, defaultItem.value);
        editedIndex.value = -1;
      }, 300);
    }

    // Fonction pour sauvegarder les modifications
    function save() {
      if (editedIndex.value > -1) {
        Object.assign(desserts.value[editedIndex.value], editedItem.value);
      } else {
        desserts.value.push(editedItem.value);
      }
      close();
    }

    return {
      dialog,
      dialogDelete,
      headers,
      desserts: filteredDesserts,
      editedIndex,
      editedItem,
      formTitle,
      search,
      links,
      initialize,
      editItem,
      deleteItem,
      deleteItemConfirm,
      close,
      closeDelete,
      save,
      handleIconUpload,
    };
  },
};
</script>

<template>
  <div class="my-3 mx-3 px-1 py-1 d-flex flex-column flex-grow-1">
    <v-breadcrumbs :items="links" color="info" style="padding: 0; margin: 0;"></v-breadcrumbs>
    <h1 class="title">Catégories</h1>
    <!-- Tableau de données avec pagination et tri -->
    <v-data-table
    :headers="headers"
    :items="desserts"
    :sort-by="[{ key: 'name', order: 'asc' }]"
    class="w-100 px-3 font-bold"
    >
      <template v-slot:top>
        <!-- Barre d'outils avec barre de recherche -->
        <v-toolbar flat color="white">
          <v-toolbar-title class="tab-title">My CRUD</v-toolbar-title>
          <v-spacer></v-spacer>
          <!-- Barre de recherche -->
          <v-text-field
            v-model="search"
            label="Search by name"
            single-line
            hide-details
            class="mx-4"
          ></v-text-field>
          <!-- Bouton pour ajouter un nouvel élément -->
          <v-dialog v-model="dialog">
            <template v-slot:activator="{ props }">
              <v-btn class="mx-4 rounded-lg my-1" color="primary" v-bind="props" prepend-icon="mdi-plus" active>
                Add
              </v-btn>
            </template>
            <!-- Formulaire -->
            <v-card>
              <v-card-title>
                <span class="text-h6 font-semibold">{{ formTitle }}</span>
              </v-card-title>
              <v-card-text>
                <v-container>
                  <v-row>
                    <!-- Champ pour l'ID -->
                    <v-col cols="12" md="4" sm="6">
                      <v-text-field v-model="editedItem.id" label="ID"></v-text-field>
                    </v-col>
                    <!-- Champ pour le nom -->
                    <v-col cols="12" md="4" sm="6">
                      <v-text-field v-model="editedItem.name" label="Name"></v-text-field>
                    </v-col>
                    <!-- Champ pour sélectionner une icône -->
                    <v-col cols="12" md="4" sm="6">
                      <v-file-input
                        v-model="editedItem.iconFile"
                        label="Select Icon"
                        accept="image/*"
                        @change="handleIconUpload"
                      ></v-file-input>
                    </v-col>
                  </v-row>
                </v-container>
              </v-card-text>
              <v-card-actions>
                <v-spacer></v-spacer>
                <v-btn color="blue-darken-1" variant="text" @click="close"> Cancel </v-btn>
                <v-btn color="blue-darken-1" variant="text" @click="save"> Save </v-btn>
              </v-card-actions>
            </v-card>
          </v-dialog>
        </v-toolbar>
      </template>
      <!-- Actions pour chaque ligne (éditer et supprimer) -->
      <template v-slot:item.actions="{ item }"><!-- eslint-disable-line vue/valid-v-slot -->
        <v-icon class="me-2" size="small" color="warning" @click="editItem(item)"> mdi-pencil </v-icon>
        <v-icon size="small" class="delete-icon bg-transparent" color="primary" @click="deleteItem(item)">
          mdi-delete
        </v-icon>
      </template>
      <!-- Message si aucune donnée n'est disponible -->
      <template v-slot:no-data>
        <v-btn color="primary" @click="initialize"> Reset </v-btn>
      </template>
    </v-data-table>
  </div>
</template>

<style scoped>
.title {
  color: "info";
  font-size: 4rem;
}

.tab-title {
  font-size: 2rem;
}
</style>
