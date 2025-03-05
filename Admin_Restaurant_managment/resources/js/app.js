import './bootstrap';

// install vue 3
import { createApp } from 'vue';
import App from './App.vue';
import router from './plugins/router';
import vuetify from './plugins/vuetify/vuetify';
import { createPinia } from 'pinia';

const app = createApp(App);
// Active Pinia
const pinia = createPinia();
app.use(pinia);

app.use(router);
app.use(vuetify)
app.mount('#app');
