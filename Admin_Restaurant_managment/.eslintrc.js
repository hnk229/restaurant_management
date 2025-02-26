module.exports = {
    root: true,
    env: {
      node: true,
    },
    extends: [
      'plugin:vue/vue3-essential', // Utilisez 'vue3-essential' pour Vue 3
      'eslint:recommended',
    ],
    parserOptions: {
      ecmaVersion: 2020,
    },
    rules: {
      // Désactivez la règle problématique
      'vue/valid-v-slot': ['error', { allowModifiers: true }],
    },
  };
