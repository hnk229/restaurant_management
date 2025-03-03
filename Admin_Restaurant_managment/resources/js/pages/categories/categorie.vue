<template>
    <div class="my-3 mx-3 px-1 py-1 d-flex flex-column flex-grow-1">
        <!-- Snackbar pour les notifications -->
        <v-snackbar
         v-model="snackbar"
         :color="snackbarColor"
         top
         right
         class="custom-snackbar"
        >
            {{ snackbarMessage }}
        </v-snackbar>

        <!-- Breadcrumb -->
        <v-breadcrumbs :items="links" color="info" style="padding: 0; margin: 0;"></v-breadcrumbs>

        <!-- Titre -->
        <h1 class="title">Catégories</h1>

        <!-- Tableau des catégories -->
        <CategoryTable
            :categories="filteredCategories"
            :search="search"
            @update:search="(newValue) => search = newValue"
            @edit="openUpdateDialog"
            @delete="openDeleteDialog"
            @save="handleCreate"
        />

        <!-- Bouton pour ouvrir la boîte de dialogue de création -->
        <!-- <v-btn class="mx-4 rounded-lg my-1" color="primary" @click="openCreateDialog" prepend-icon="mdi-plus">
            Ajouter
        </v-btn> -->

        <!-- Boîtes de dialogue -->
        <CategoryCreateDialog v-model="createDialog" @save="handleCreate" />
        <CategoryUpdateDialog v-model="updateDialog" :item="editedItem" @save="handleUpdate" />
        <CategoryDeleteDialog v-model="deleteDialog" :item="editedItem" @confirm="handleDelete" />
    </div>
</template>

<script setup>

    import { ref, computed, onMounted, watch } from 'vue';
    import useApi from '@/composables/useApi';
    import CategoryTable from './components/CategoryTable.vue';
    import CategoryCreateDialog from './components/CategoryCreateDialog.vue';
    import CategoryUpdateDialog from './components/CategoryUpdateDialog.vue';
    import CategoryDeleteDialog from './components/CategoryDeleteDialog.vue';


// États réactifs
const snackbar = ref(false);
const snackbarMessage = ref('');
const snackbarColor = ref('success');
const search = ref('');
const categories = ref([]);
const createDialog = ref(false);
const updateDialog = ref(false);
const deleteDialog = ref(false);
const editedItem = ref({ id: '', name: '', image: '' });

// Liens pour le breadcrumb
const links = ref([
    { title: 'Dashboard', icon: 'mdi-view-dashboard', to: 'dashboard' },
    { title: 'Catégories', icon: 'mdi-shape', to: 'categories' },
]);

// Propriété calculée pour filtrer les catégories
const filteredCategories = computed(() => {
    if (!search.value) return categories.value;
    return categories.value.filter(cat =>
        cat.name.toLowerCase().includes(search.value.toLowerCase())
    );
});

watch(search, () => {
    console.log('Recherche :', search.value);
});

// Charger les catégories au montage
onMounted(async () => {
  try {
    const response = await useApi().$get('categories');
    console.log('Réponse de l\'API lors du chargement :', response); // Log pour déboguer

    if (Array.isArray(response)) {
      categories.value = response.map(cat => ({
        id: cat.id,
        name: cat.name,
        image: cat.image || '', // Valeur par défaut si image est undefined
      })).filter(cat => cat); // Filtrer les éléments undefined
    } else {
      throw new Error('Réponse invalide de l\'API');
    }
  } catch (error) {
    console.error('Erreur lors de la récupération des catégories :', error); // Log pour déboguer
  }
});

// Ouvrir la boîte de dialogue de création
function openCreateDialog() {
    editedItem.value = { id: '', name: '', image: '' };
    createDialog.value = true;
}

// Ouvrir la boîte de dialogue de mise à jour
function openUpdateDialog(item) {
    editedItem.value = { ...item };
    updateDialog.value = true;
}

// Ouvrir la boîte de dialogue de suppression
function openDeleteDialog(item) {
    editedItem.value = { ...item };
    deleteDialog.value = true;
}

// Gérer la création d'une catégorie
async function handleCreate(newItem) {
  try {
    const formData = new FormData();
    formData.append('name', newItem.name);
    if (newItem.iconFile instanceof File) {
      formData.append('image', newItem.iconFile);
    }

    // Ajout de l'appel API qui était manquant
    const response = await useApi().$post('categories', formData);

    console.log('Réponse de l\'API après création :', response); // Log pour déboguer

    if (response) {
      categories.value.push(response);
      snackbarMessage.value = 'Catégorie créée !';
      snackbarColor.value = 'success';
      snackbar.value = true;
    } else {
      throw new Error('Réponse invalide de l\'API');
    }
  } catch (error) {
    console.error('Erreur lors de la création de la catégorie :', error);
    snackbarMessage.value = error.response?.data?.message || 'Erreur lors de la création.';
    snackbarColor.value = 'error';
    snackbar.value = true;
  }
}


// Gérer la mise à jour d'une catégorie
async function handleUpdate(updatedItem) {
  try {
    console.log("Début de handleUpdate avec :", updatedItem);

    const formData = new FormData();
    formData.append('name', updatedItem.name);

    if (updatedItem.iconFile instanceof File) { // Vérification correcte
        formData.append('image', updatedItem.iconFile);
    }

    // Ajout du _method pour simuler un PUT
    formData.append('_method', 'PUT');

    console.log("Données envoyées :", formData);

    // Correction ici : utilisation de `formData` au lieu de `fromData`
    const response = await useApi().$post(`categories/${updatedItem.id}`, formData);

    console.log('Réponse de l\'API après mise à jour :', response);

    if (response && response.id) {
      const index = categories.value.findIndex(cat => cat.id === updatedItem.id);
      if (index !== -1) {
        categories.value.splice(index, 1, response);
        snackbarMessage.value = 'Catégorie mise à jour !';
        snackbarColor.value = 'success';
        snackbar.value = true;
      }
    } else {
      throw new Error('Réponse invalide de l\'API');
    }
  } catch (error) {
    console.error("Détails de l'erreur :", error);
    snackbarMessage.value = error.response?.data?.message || 'Erreur lors de la mise à jour.';
    snackbarColor.value = 'error';
    snackbar.value = true;
  }
}

// Gérer la suppression d'une catégorie
async function handleDelete() {
  try {
    await useApi().$delete(`categories/${editedItem.value.id}`);
    categories.value = categories.value.filter(cat => cat && cat.id !== editedItem.value.id);
    snackbarMessage.value = 'Catégorie supprimée !';
    snackbarColor.value = 'success';
    snackbar.value = true;
  } catch (error) {
    snackbarMessage.value = error.response?.data?.message || 'Erreur lors de la suppression.';
    snackbarColor.value = 'error';
    snackbar.value = true;
  }
}


</script>

<style scoped>
.title {
    color: "info";
    font-size: 4rem;
}
.custom-snackbar .v-snackbar__content {
  color: white !important; /* Change la couleur du texte */
}
</style>
