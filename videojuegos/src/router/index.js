import { createRouter, createWebHistory } from 'vue-router'
import HomeView from '../views/HomeView.vue'
import NoticiasView from '../views/NoticiasView.vue'
import MiEspacioView from '../views/MiEspacioView.vue'
import BuscadorView from '../views/BuscadorView.vue'
import LoginView from '../views/LoginView.vue'
import VideojuegosView from '../views/VideojuegosView.vue'

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes: [

    {
      path: '/',
      name: 'home',
      component: HomeView
    },
    {
      path: '/noticias',
      name: 'noticias',
      component: NoticiasView
    },
    {
      path: '/mi_espacio',
      name: 'mi_espacio',
      component: MiEspacioView
    },
    {
      path: '/buscador',
      name: 'buscador',
      component: BuscadorView
    },
    {
      path: '/login',
      name: 'login',
      component: LoginView
    },
    {
      path: '/videojuegos',
      name: 'videojuegos',
      component: VideojuegosView
    },
    

    
  ]
})

export default router
