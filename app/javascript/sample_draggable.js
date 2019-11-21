import Vue from 'vue'
import Draggable from './sample_draggable.vue'

document.addEventListener('DOMContentLoaded', () => {
  new Vue({
    render: h => h(Draggable, {})
  }).$mount('#js-sample-draggable')
})
