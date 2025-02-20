import { createMemoryHistory, createRouter, RouteRecordRaw } from 'vue-router'
import Dashboard from '../../pages/dashboard/dashboard.vue'
import User from '../../pages/users/user.vue'
import AppLayout from '../../layouts/appLayout.vue'

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
        children: [
            {
               name: 'dashboard',
               path: 'dashboard',
               component: Dashboard,
            },
            {
                name: 'user',
                path: 'user',
                component: User,
            }
        ]
    },

]


const router = createRouter({
    history: createMemoryHistory(),
    routes
}
)

export default router
