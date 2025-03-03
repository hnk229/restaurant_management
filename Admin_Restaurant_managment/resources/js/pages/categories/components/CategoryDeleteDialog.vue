<template>
    <v-dialog :model-value="modelValue" @update:model-value="$emit('update:modelValue', $event)" max-width="25rem">
      <v-card>
        <v-card-title class="text-h4"
        color="info">Attention ! </v-card-title>
        <v-divider></v-divider>
        <v-card-text>Êtes-vous sûr de vouloir supprimer cette catégorie ?</v-card-text>
        <v-card-actions class="justify-center">
          <v-btn color="warning" variant="text" @click="confirm" active>Supprimer</v-btn>
          <v-btn color="error" variant="text" @click="close">Annuler</v-btn>
        </v-card-actions>
      </v-card>
    </v-dialog>
  </template>

  <script setup>
  defineProps({
    modelValue: Boolean,
    item: Object,
  });

  const emit = defineEmits(['update:modelValue', 'confirm']);

  function confirm() {
    emit('confirm');
    close();
  }

  function close() {
    emit('update:modelValue', false);
  }
  </script>
