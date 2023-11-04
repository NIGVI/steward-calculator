<script setup lang="ts">
import { computed } from 'vue'

const PERCENTS = ['0.95', '0.90']

const props = defineProps<{
  number: number,
  modelValue: number,
  average?: number,
  deviation: number,
  deviationInSquare: number,
  deviationsInSquareAverage?: number,
  trustLevel?: string,
  tpn?: number | string,
  studentCoefficient?: number | string
}>()

const emit = defineEmits<{
  'update:modelValue': [number]
  'update:trustLevel': [string]
}>()

const modelValue = computed({
  get: () => props.modelValue,
  set: value => emit('update:modelValue', value)
})
const trustLevel = computed<string | null>({
  get: () => props.trustLevel ?? null,
  set: value => value && emit('update:trustLevel', value)
})

function protectedPrint(value: number | string | undefined) {
  return (value === undefined || typeof value === 'number' && isNaN(value)) ? '---' : value
}
</script>


<template>
  <tr>
    <td class="table-column _number-column">
      {{ number }}
    </td>

    <td class="table-column _input-column">
      <input class="table-input" v-model="modelValue" type="number">
    </td>

    <td class="table-column">
      {{ average ?? '---' }}
    </td>

    <td class="table-column">
      {{ deviation }}
    </td>

    <td class="table-column">
      {{ deviationInSquare }}
    </td>

    <td class="table-column">
      {{ protectedPrint(deviationsInSquareAverage) }}
    </td>

    <td class="table-column _select-column">
      <template v-if="trustLevel">
        <select class="table-select" v-model="trustLevel">
          <option
            v-for="percent in PERCENTS"
            :value="percent"
          >
            {{ percent }}
          </option>
        </select>
      </template>

      <template v-else>
        ---
      </template>
    </td>

    <td class="table-column _120">
      {{ protectedPrint(tpn) }}
    </td>

    <td class="table-column _90">
      {{ protectedPrint(studentCoefficient) }}
    </td>
  </tr>
</template>


<style lang="scss" scoped>
.table-column {
  min-width: 90px;
  padding: 5px;
  &._number-column {
    text-align: center;
    min-width: 20px;
    width: 20px;
  }
  &._input-column, &._select-column {
    position: relative;
    min-width: 100px;
    padding: 0 0;
    .table-input {
      position: absolute;
      left: 0;
      top: 0;
      height: calc(100% - 3px);
      border: none;
      width: calc(100% - 5px);
    }
    .table-select {
      border: none;
      width: 100%;
    }
  }
  &._120 {
    min-width: 120px;
  }
}
</style>