import { createRouter, createWebHistory } from 'vue-router'
import { isAuthenticated } from '../utils/validateSession';


const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes: [
    {
      path: '/',
      name: 'home',
      component: () => import('../views/HomeView.vue'),
      meta: { requiresAuth: false } 
    },
    {
      path: '/learning',
      name: 'learning',
      component: () => import('../views/LearningView.vue'),
      meta: { requiresAuth: false } 
    },
    {
      path: '/create-account',
      name: 'create-account',
      component: () => import('../views/CreateAccountView.vue'),
      meta: { requiresAuth: false } 
    },
    {
      path: '/login',
      name: 'sign-in',
      component: () => import('../views/SignInView.vue'),
      meta: { requiresAuth: false } 
    },
    {
      path: '/confirm',
      name: 'confirm-account',
      component: () => import('../views/ConfirmAccountView.vue'),
      meta: { requiresAuth: false } 
    },
    {
      path: '/profile',
      name: 'profile',
      component: () => import('../views/UserProfileView.vue'),
      meta: { requiresAuth: true } 
    },
    {
      path: '/create-goals-list',
      name: 'create-goals-list',
      component: () => import ('../views/CreateGoalsListView.vue'),
      meta: { requiresAuth: true } 
    },
    {
      path: '/create-goal/:id',
      name: 'create-goal',
      component: () => import ('../views/CreateGoalView.vue'),
      meta: { requiresAuth: true } 
    }
  ]
})

router.beforeEach(async (to, from, next) => {
  if (to.meta.requiresAuth) {
    const authenticated = await isAuthenticated();
    if (!authenticated) {
      next('/login')
    } else {
      next();
    }
  } else  {
    next();
  }
});

export default router
