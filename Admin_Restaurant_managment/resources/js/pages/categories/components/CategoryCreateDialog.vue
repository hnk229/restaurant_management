<template>
    <v-dialog :model-value="modelValue" @update:model-value="$emit('update:modelValue', $event)" max-width="30rem">
        <v-card>
            <v-card-title
                class="text-h4"
                color="info"
                >Créer une catégorie</v-card-title>
            <v-divider></v-divider>
            <v-card-text>
                <div class="justify-center px-6">
                    <!-- Avatar circulaire avec aperçu de l'image -->
                    <div class="d-flex flex-row align-center">
                       <v-avatar size="100">
                           <v-img v-if="previewImage" :src="previewImage" />
                           <v-icon v-else size="50">mdi-camera</v-icon>
                       </v-avatar>

                       <v-btn class="" color="primary" @click="triggerFileInput">
                           Choisir image
                       </v-btn>

                       <!-- Input file caché -->
                       <input
                           type="file"
                           ref="fileInput"
                           class="d-none"
                           @change="handleIconUpload"
                           accept="image/*"
                       />
                   </div>
                   <small class="text-center text-wrap mb-3">Formats : JPEG, PNG, JPG, GIF. Taille maximale: 2 Mo.</small>
                    <v-text-field
                        class="mt-3"
                        color="info"
                        v-model="item.name"
                        :rules="[validateCategoryName]"
                        label="Nom"
                        density="compact"
                        variant="outlined"
                        clearable
                        >
                    </v-text-field>
                </div>
            </v-card-text>
            <v-card-actions class="justify-center">
                <v-btn
                    color="warning"
                    variant="text"
                    @click="save"
                    active
                    >Ajouter</v-btn>
                <v-btn
                    color="error"
                    variant="text"
                    @click="close"

                >Annuler</v-btn>
            </v-card-actions>
        </v-card>
    </v-dialog>
</template>

<script setup>
import { ref } from 'vue';

const props = defineProps({
    modelValue: Boolean,
});

const emit = defineEmits(['update:modelValue', 'save']);

const item = ref({ name: '', iconFile: null });
const previewImage = ref(null);
const fileInput = ref(null);

// Fonction pour ouvrir l'explorateur de fichiers
const triggerFileInput = () => {
    fileInput.value.click();
};

// Fonction pour gérer le téléversement de fichiers
function handleIconUpload(event) {
    const file = event.target.files[0];
    if (file) {
        console.log('Fichier sélectionné :', file);
        previewImage.value = URL.createObjectURL(file);
        item.value.iconFile = file;
    }
}

function save() {
    emit('save', item.value); // Émettre les données du formulaire
    close();
}

function close() {
    emit('update:modelValue', false);
}

// validation du nom de la catégorie

const validateCategoryName = (value) => {
    if(!value) {
        return "Le nom de la catégorie est requis.";
    }
    if(value.trim().length < 2) {
        return "Nom catégorie trop court.";
    }
    if(value.trim().length > 50) {
        return "Nom catégorie trop long.";
    }
    return true;
};

// Règles de validation de l'image
const validateCategoryImage = (value) => {
    //validation de la taille de l'image
    if(value.size > 2000000) {
        return "La taille de l'image ne doit pas dépasser 2 Mo.";
    }
    //validation du type de l'image
    if(!['image/jpeg', 'image/png', 'image/png', 'image/gif'].includes(value.type)) {
        return "Le type de l'image doit être JPEG, PNG, JPG ou GIF.";
    }

    return true;
};
</script>
