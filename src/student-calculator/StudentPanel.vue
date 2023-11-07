<script setup lang="ts">
import { computed } from 'vue'

const props = defineProps<{
  columnCount: number,
  correctness: number
}>()

const emit = defineEmits<{
  'update:columnCount': [number]
  'update:correctness': [number]
}>()

const columnCount = computed({
  get: () => props.columnCount,
  set: value => {
    if (value > 0) {
      return emit('update:columnCount', +value)
    }
    emit('update:columnCount', 5)
  }
})

const correctness = computed({
  get: () => props.correctness,
  set: value => {
    if (value > 0 && value < 8) {
      return emit('update:correctness', +value)
    }
    emit('update:correctness', 5)
  }
})
</script>


<template>
  <div class="student-top-panel">
    <div class="student-top-panel__column">
      Количество замеров: <input class="top-panel-input" v-model="columnCount" type="number">
    </div>
    <div class="student-top-panel__column">
      Точность: <input class="top-panel-input" v-model="correctness" type="number">
    </div>
  </div>
</template>


<style lang="scss" scoped>
.student-top-panel {
  display: flex;
  @media (max-width: 500px) {
    display: block;
  }
}
.student-top-panel__column:last-child {
  margin-left: 15px;
  @media (max-width: 500px) {
    margin-left: 0;
  }
}
.top-panel-input {
  width: 35px;
  border: none;
  border-bottom: 2px solid #b8b8b8;
} 
</style>