<script setup lang="ts">
import { ref, computed } from 'vue'

const props = defineProps<{
  studentCoefficient: number | string,
  correctness: number
}>()

const systemDeviation = ref(0)
const fullDeviation = computed(() => {
  if (systemDeviation.value === 0 || typeof props.studentCoefficient === 'string') {
    return 'Не поддается расчету'
  }
  return fixedNumber(Math.sqrt(systemDeviation.value ** 2 + props.studentCoefficient ** 2))
})

function fixedNumber(number: number) {
  const x = Math.pow(10, props.correctness)
  return Math.round(number * x) / x
}
</script>


<template>
  <div>
    <div class="calculator-block input-zone">
      <sub>▲</sub><i>a</i><sub><i>сист</i></sub>
      =
      <input
        class="system-deviation-input"
        v-model="systemDeviation"
        type="number"
      />
    </div>

    <div class="calculator-block">
      √<span class="overline"><span>
        <sub>▲</sub><i>a</i><sub><i>сист</i></sub><sup>2</sup> + <sub>▲</sub><i>a</i><sub><i>случ</i></sub><sup>2</sup>
      </span></span> = <sub>▲</sub><i>a</i><sub><i>полн</i></sub>
    </div>

    <div class="calculator-block">
      √<span class="overline">
        {{ systemDeviation }}<sup>2</sup> + {{ studentCoefficient }}<sup>2</sup>
      </span> = {{ fullDeviation }}
    </div>
  </div>
</template>


<style lang="scss" scoped>
.system-deviation-input {
  border: none;
  border-bottom: solid 2px #b8b8b8;
  width: 60px;
}
.calculator-block:not(:last-child) {
  margin-bottom: 10px;
}
.overline {
  display: inline-block;
  &::before {
    content: '';
    display: block;
    width: 100%;
    height: 1px;
    background-color: #333;
  }
}
</style>