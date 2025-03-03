import { defineConfig } from 'vite';
import laravel from 'laravel-vite-plugin';
import tailwindcss from '@tailwindcss/vite'
import vue from '@vitejs/plugin-vue';

export default defineConfig({
    plugins: [
        vue(),
        tailwindcss(),
        laravel({
            input: ['resources/css/app.css', 'resources/js/app.js'],
            refresh: true,
        }),
    ],
    build: {
        manifest: true, // Ajoute cette ligne pour générer le fichier manifest.json
        outDir: 'public/build', // Définit le dossier de sortie pour les fichiers compilés
    },
});
