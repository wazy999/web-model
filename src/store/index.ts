import Vue from 'vue'
import Vuex from 'vuex'

Vue.use(Vuex)

export default new Vuex.Store({
  state: {
    airConList:[],
  },
  mutations: {
    getAllList(state,list){
      state.airConList = list
    }
  },
  actions: {
  },
  modules: {
  }
})
