import { createRouter, createWebHistory } from 'vue-router'
import { isAuthenticated } from '../utils/validateSession';


const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes: [
    {
      path: '/',
      name: 'home',
      component: () => import('../views/HomeView.vue')
    },
    {
      path: '/create-account',
      name: 'create-account',
      component: () => import('../views/CreateAccountView.vue'),
    },
    {
      path: '/login',
      name: 'sign-in',
      component: () => import('../views/SignInView.vue')
    },
    {
      path: '/confirm',
      name: 'confirm-account',
      component: () => import('../views/ConfirmAccountView.vue')
    },
    {
      path: '/create-goals-list',
      name: 'create-goals-list',
      component: () => import ('../views/CreateGoalsListView.vue'),
      meta: { requiresAuth: true } 
    }
  ]
})

router.beforeEach((to, from, next) => {
  if (to.meta.requiresAuth && !isAuthenticated()) {
    next('/login');
  } else {
    next();
  }
});

export default router
