import { createMemoryHistory, createRouter, createWebHistory, RouteRecordRaw } from 'vue-router'
import { useAuthStore } from '../../composables/authStore'
import Dashboard from '../../pages/dashboard/dashboard.vue'
import User from '../../pages/users/user.vue'
import AppLayout from '../../layouts/appLayout.vue'
import Categorie from '../../pages/categories/categorie.vue'
import Login from '../../pages/auth/login.vue'
import AuthLayout from '../../layouts/authLayout.vue'

const routes: Array<RouteRecordRaw> = [
    {
        path: '/:pathMatch(.*)*',
        redirect: { name: 'dashboard' }
    },
    {
        path: '/',
        name: 'admin',
        component: AppLayout,
        redirect: { name: 'dashboard' },
        meta:  { requiresAuth: true, requiresAdmin: true },
        children: [
            {
               name: 'dashboard',
               path: 'dashboard',
               component: Dashboard,
            },
            {
                name: 'categories',
                path: 'categories',
                component: Categorie,
            },
            {
                name: 'user',
                path: 'user',
                component: User,
            },

        ]
    },
    {
        path: '/auth',
        component: AuthLayout,
        children: [
            {
                name: 'login',
                path: 'login',
                component: Login,
            },
            {
                path: '',
                redirect: { name: 'login' }
            }
        ]
    }

]


const router = createRouter({
    history: createWebHistory(),
    routes
}
)
// Middleware de protection des routes
router.beforeEach(async (to, from, next) => {
    const authStore = useAuthStore();

    if (authStore.token && !authStore.user) {
      await authStore.fetchUser();
    }
    //
    if (to.meta.requiresAuth && !authStore.isAuthenticated) {
      next('/auth/login'); // Redirige si non connecté
    } else if (to.meta.requiresAdmin && !authStore.isAdmin) {
      next('/'); // Redirige si pas admin
    } else {
      next();
    }
  });

export default router
