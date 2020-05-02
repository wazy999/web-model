import Vue from 'vue'
import VueRouter from 'vue-router'
import login from '../views/login.vue'
import home from "../views/homePage.vue"
import equipment from "../views/equipment.vue"
import detail from "../views/detail.vue"
import myechart from "../views/echart.vue"

Vue.use(VueRouter)

const routes = [
  {
    path: '/',
    redirect:"/login"
  },
  {
    path: '/login',
    name: 'login',
    component: login,
  },
  {
    path: '/about',
    name: 'About',
    // route level code-splitting
    // this generates a separate chunk (about.[hash].js) for this route
    // which is lazy-loaded when the route is visited.
    component: () => import(/* webpackChunkName: "about" */ '../views/About.vue')
  },
  {
    path: '/home',
    name: 'home',
    component: home
  },
  {
    path: '/equipment',
    name: 'equipment',
    component: equipment
  },
  {
    path: '/detail',
    name: 'detail',
    component: detail
  },
]

const router = new VueRouter({
  routes
})

export default router
