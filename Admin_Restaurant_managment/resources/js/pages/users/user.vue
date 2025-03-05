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
        <h1 class="title">Utilisateurs</h1>

        <!-- Tableau des catégories -->
        <UserTable
            :users="filteredUsers"
            :search="search"
            @update:search="(newValue) => search = newValue"
            @edit="openUpdateDialog"
            @delete="openDeleteDialog"
            @save="handleCreate"
        />
    </div>
</template>

<script setup>
    import { ref, computed, onMounted, watch } from 'vue';
    import useApi from '../../composables/useApi';
import UserTable from './components/userTable.vue';

    // États réactifs
    const snackbar = ref(false);
    const snackbarMessage = ref('');
    const snackbarColor = ref('success');
    const search = ref('');
    const users = ref([]);
    const createDialog = ref(false);
    const updateDialog = ref(false);
    const deleteDialog = ref(false);
    const editedItem = ref({
        id: '',
        nom: '',
        prenom: '',
        email:'',
        password: '',
        role: '',
        username: '',
    });

    // Liens pour le breadcrumb
    const links = ref([
        { title: 'Dashboard', icon: 'mdi-view-dashboard', to: 'dashboard' },
        { title: 'Users', icon: 'mdi-account-group', to: 'user' },
    ]);

    // Propriété calculée pour filtrer les catégories
    const filteredUsers = computed(() => {
        if (!search.value) return users.value;
        return users.value.filter(cat =>
            cat.nom.toLowerCase().includes(search.value.toLowerCase())
        );
    });

    watch(search, () => {
        console.log('Recherche :', search.value);
    });

    // Charger users au montage
    onMounted(async () => {
        try {
            const response = await useApi().$get('user/all');
            console.log('Réponse de l\'API lors du chargement :', response); // Log pour déboguer

            if (Array.isArray(response)) {
            users.value = response.map(user => ({
                id: user.id,
                nom: user.nom + '' + user.prenom,
                prenom: user.prenom,
                email: user.email,
                password: user.password,
                role: user.role,
                username: user.username || ''
            })).filter(user => user); // Filtrer les éléments undefined
            console.log('Users get: ', users.value)
            } else {
            throw new Error('Réponse invalide de l\'API');
            }
        } catch (error) {
            console.error('Erreur lors de la récupération des Users :', error); // Log pour déboguer
        }
    });

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
            formData.append('nom', newItem.nom);
            formData.append('prenom', newItem.prenom);
            formData.append('email', newItem.email);
            formData.append('password', newItem.password);
            formData.append('role', newItem.role);
            formData.append('username', newItem.username);

            // Ajout de l'appel API qui était manquant
            const response = await useApi().$post('auth/register', formData);

            console.log('Réponse de l\'API après création :', response); // Log pour déboguer

            if (response) {
            users.value.push(response.user);
            snackbarMessage.value = response.message;
            // snackbarColor.value = 'success';
            snackbar.value = true;
            } else {
            throw new Error('Réponse invalide de l\'API');
            }
        } catch (error) {
            console.error('Erreur lors de la création de la catégorie :', error);
            snackbarMessage.value = response?.message || 'Erreur lors de la création.';
            snackbarColor.value = 'error';
            snackbar.value = true;
        }
    }

    // Gérer la mise à jour d'une catégorie
    async function handleUpdate(updatedItem) {
        try {
            console.log("Début de handleUpdate avec :", updatedItem);

            const formData = new FormData();
            formData.append('nom', updatedItem.nom);
            formData.append('prenom', updatedItem.prenom);
            formData.append('email', updatedItem.email);
            formData.append('password', updatedItem.password);
            formData.append('role', updatedItem.role);
            formData.append('username', updatedItem.username);

            // Ajout du _method pour simuler un PUT
            formData.append('_method', 'PUT');

            console.log("Données envoyées :", formData);

            const response = await useApi().$post(`auth/update/${updatedItem.id}`, formData);

            console.log('Réponse de l\'API après mise à jour :', response);

            if (response && response.user.id) {
                const index = users.value.findIndex(user => user.id === updatedItem.id);
            if (index !== -1) {
                users.value.splice(index, 1, response.user);
                snackbarMessage.value = response?.message ;
                snackbar.value = true;
            }
            } else {
                throw new Error('Réponse invalide de l\'API');
            }
        } catch (error) {
            console.error("Détails de l'erreur :", error);
            snackbarMessage.value = response?.message || 'Erreur lors de la mise à jour.';
            snackbarColor.value = 'error';
            snackbar.value = true;
        }
    }

    // Gérer la suppression d'une catégorie
    async function handleDelete() {
        try {
            await useApi().$delete(`auth/destroy/${editedItem.value.id}`);
            users.value = users.value.filter(user => user && user.id !== editedItem.value.id);
            snackbarMessage.value = response?.message;

            snackbar.value = true;
        } catch (error) {
            snackbarMessage.value = response?.message || 'Erreur lors de la suppression.';
            snackbarColor.value = 'error';
            snackbar.value = true;
        }
    }


</script>

<style scope>
    .title {
        color: "info";
        font-size: 4rem;
    }
</style>
