<script setup lang="ts">
import { ref, computed, watch } from 'vue'
import StudentPanel from './StudentPanel.vue'
import TableHeader from './StudentTableHeader.vue'
import TableLine from './StudentTableLine.vue'

const tpnValues = {
  '0.95': [12.7, 4.3, 3.2, 2.8, 2.6, 2.4, 2.4, 2.3, 2.3],
  '0.90': [6.3, 2.9, 2.4, 2.1, 2, 1.9, 1.9, 1.9, 1.8]
}

const columnCount = ref(1)
const correctness = ref(5)
const userInputs = ref<number[]>([])
const average = computed(() => fixedNumber(userInputs.value.reduce((acc, el) => el + acc, 0) / userInputs.value.length))
const deviations = computed(() => userInputs.value.map(el => fixedNumber(Math.abs(el - average.value))))
const deviationsInSquare = computed(() => deviations.value.map(el => fixedNumber(el * el)))
const deviationsInSquareAverage = computed(
  () => fixedNumber(Math.sqrt(deviationsInSquare.value.reduce((acc, el) => el + acc, 0) / (columnCount.value * (columnCount.value - 1))))
)
const trustLevel = ref<keyof typeof tpnValues>('0.95')
const tpn = computed<number | string>(() => tpnValues[trustLevel.value]?.[columnCount.value - 2] ?? 'нет данных')
const studentCoefficient = computed<number | string>(
  () => typeof tpn.value === 'string' ? 'НЕ КОР' : fixedNumber(tpn.value * deviationsInSquareAverage.value)
)

watch(columnCount, () => {
  while (userInputs.value.length !== columnCount.value) {
    if (userInputs.value.length < columnCount.value) {
      userInputs.value.push(0)
    } else {
      userInputs.value.pop()
    }
  }
}, { immediate: true })

function reset() {
  userInputs.value = userInputs.value.map(() => 0)
}

function fixedNumber(number: number) {
  const x = Math.pow(10, correctness.value)
  return Math.round(number * x) / x
}
</script>

<template>
  <div>
    <h1>Калькулятор Стьюдента</h1>

    <StudentPanel
      class="student-table-panel"
      v-model:column-count="columnCount"
      v-model:correctness="correctness"
    />
    <table class="table" border="1">
      <TableHeader />

      <template v-for="(_, index) in userInputs">
        <TableLine
          v-if="index === 0"
          :number="index + 1"
          v-model="userInputs[index]"
          :deviation="deviations[index]"
          :deviation-in-square="deviationsInSquare[index]"
          :average="average"
          :deviations-in-square-average="deviationsInSquareAverage"
          :student-coefficient="studentCoefficient"
          :tpn="tpn"
          v-model:trust-level="trustLevel"
        />
        <TableLine
          v-else
          :number="index + 1"
          v-model="userInputs[index]"
          :deviation="deviations[index]"
          :deviation-in-square="deviationsInSquare[index]"
        />
      </template>
    </table>

    <button class="reset-button" @click="reset">
      Сбросить значения
    </button>
  </div>
</template>

<style lang="scss" scoped>
.student-table-panel {
  margin-bottom: 10px;
}
.table {
  min-width: 850px;
  margin-bottom: 15px;
}
.reset-button {
  padding: 4px 13px;
  color: #fff;
  font-size: 18px;
  border: none;
  border-radius: 3px;
  background-color: #0053a0;
  box-shadow: rgba(0, 0, 0, 0.288) 2px 2px 5px;
}
</style>