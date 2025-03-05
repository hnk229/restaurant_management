
<template>
    <v-dialog :model-value="modelValue" @update:model-value="$emit('update:modelValue', $event)" max-width="32rem">
        <v-form ref="form" lazy-validation>

            <v-card class="py-4 rounded-lg">
                <v-card-title
                    class="text-h5 "
                    color="info"
                    ><span class="font-bold  ">Ajouter Utilisateur</span></v-card-title>
                <v-divider></v-divider>
                <v-card-text>
                    <div class="justify-center">

                        <div class="d-flex flex-row align-center">
                            <div class="d-flex flex-col w-1/2  mx-2 my-2">
                                <v-label color="blue">Nom</v-label>
                                <v-text-field

                                    class=""
                                    color="info"
                                    v-model="item.nom"
                                    :rules="[rules.required, rules.min, rules.max]"
                                    density="compact"
                                    variant="outlined"
                                    clearable
                                    >
                                </v-text-field>
                            </div>
                            <v-text-field
                                class="w-1/2 mx-2 my-2"
                                color="info"
                                v-model="item.prenom"
                                :rules="[rules.required, rules.min, rules.max]"
                                label="Prénom"
                                density="compact"
                                variant="outlined"
                                clearable
                                >
                            </v-text-field>
                       </div>
                       <div class="d-flex flex-row align-center">
                            <v-text-field
                                class="w-1/2 mx-2 my-2"
                                color="info"
                                v-model="item.email"
                                :rules="[rules.required, rules.email]"
                                label="Email"
                                density="compact"
                                variant="outlined"
                                clearable
                                >
                            </v-text-field>
                                <v-text-field
                                class="w-1/2 mx-2 my-2"
                                color="info"
                                v-model="item.username"
                                :rules="[rules.min, rules.max]"
                                label="UserName"
                                density="compact"
                                variant="outlined"
                                clearable
                                >
                            </v-text-field>
                       </div>
                       <div>
                        <v-select
                            class="mx-2 my-2"
                            v-model="item.role"
                            label="Rôle"
                            :items="roles"
                            item-title="label"
                            item-value="value"
                            density="compact"
                            :rules="[validateRole]"
                            variant="outlined"
                        ></v-select>
                       </div>
                       <div class="d-flex flex-row align-center ">
                            <v-text-field
                                class="w-1/2 mx-2 my-2"
                                color="info"
                                v-model="item.password"
                                :rules="[rules.required, rules.password, rules.containsNumber]"
                                label="Mot de passe"
                                density="compact"
                                variant="outlined"
                                clearable
                                >
                            </v-text-field>
                                <v-text-field
                                class="w-1/2 mx-2 my-2"
                                color="info"
                                :rules="[rules.required, rules.password, rules.containsNumber]"
                                label="Confimez Mot de passe"
                                density="compact"
                                variant="outlined"
                                clearable
                                >
                            </v-text-field>
                       </div>
                    </div>
                </v-card-text>
                <v-card-actions class="justify-center">
                    <v-btn
                        class="transition delay-150 duration-150 ease-in-out hover:-translate-y-1 hover:scale-110"
                        color="warning"
                        variant="text"
                        @click="validateAndSave"
                        active
                        >Ajouter</v-btn>
                    <v-btn
                        class="transition delay-150 duration-150 ease-in-out hover:-translate-y-1 hover:scale-110 "
                        color="error"
                        variant="text"
                        @click="close"

                    >Annuler</v-btn>
                </v-card-actions>
            </v-card>
        </v-form>
    </v-dialog>
</template>

<script setup>
    import { ref } from 'vue';

    const props = defineProps({
        modelValue: Boolean,
    });

    const emit = defineEmits(['update:modelValue', 'save']);

    const item = ref({
        nom: '',
        prenom: '',
        email:'',
        password: '',
        role: '',
        username: '',
    });
    const form = ref(null);


    function save() {
        emit('save', item.value); // Émettre les données du formulaire
        close();
    }

    function close() {
        emit('update:modelValue', false);
    }

    // Les roles possible
    const roles = ref([
        { label: "Serveur", value: "serveur" },
        { label: "Cuisinier", value: "cuisinier" },
        { label: "Admin", value: "admin" },
    ]);

    // Validation Roles :
    const validateRole = (value) => {
        return value ? true : "Le rôle est requis.";
    };

    //email
    const rules = {
        required: v => !!v || 'Ce champ est requis.',
        email: v => /.+@.+\..+/.test(v) || 'L’email n’est pas valide.',
        min: v => (v && v.length <= 2) || 'Trop court.',
        max: v => (v && v.length > 150) || 'Trop long',
        password: v => (v && v.length >= 8) || 'Le mot de passe doit contenir au moins 6 caractères.',
        containsNumber: v => /\d/.test(v) || 'Le mot de passe doit contenir au moins un chiffre.',

    };

    const validateAndSave = async () => {
    if (!form.value) {
        console.error("Le formulaire n'est pas encore initialisé.");
        return;
    }

    const { valid } = await form.value.validate(); // Vérification correcte de la validation
    if (valid) {
        save();
    }
};



</script>
