<template lang="pug">
  .row
    .col-3
      h3 Draggable 1
      draggable(class="list-group" :list="list1" group="people" @change="log")
        .list-group-item(v-for="(element, index) in list1" :key="element.name")
          | {{ element.name }} {{ index }}

    .col-3
      h3 Draggable 2
      draggable(class="list-group" :list="list2" group="people" @change="log")
        .list-group-item(v-for="(element, index) in list2" :key="element.name")
          | {{ element.name }} {{ index }}

    rawDisplayer(class="col-3" :value="list1" title="List 1")
    rawDisplayer(class="col-3" :value="list2" title="List 2")
  </div>
</template>
<script>
import draggable from 'vuedraggable'
import rawDisplayer from 'raw-displayer'

export default {
  components: {
    'draggable': draggable,
    'rawDisplayer': rawDisplayer
  },
  data() {
    return {
      list1: [
        { name: "John", id: 1 },
        { name: "Joao", id: 2 },
        { name: "Jean", id: 3 },
        { name: "Gerard", id: 4 }
      ],
      list2: [
        { name: "Juan", id: 5 },
        { name: "Edgard", id: 6 },
        { name: "Johnson", id: 7 }
      ]
    };
  },
  methods: {
    add: function() {
      this.list.push({ name: "Juan" });
    },
    replace: function() {
      this.list = [{ name: "Edgard" }];
    },
    clone: function(el) {
      return {
        name: el.name + " cloned"
      };
    },
    log: function(evt) {
      window.console.log(evt);
    }
  }
};
</script>
