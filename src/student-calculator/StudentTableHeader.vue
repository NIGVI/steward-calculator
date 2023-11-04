<script setup lang="ts">
import aWithUpperLine from './a-with_upper-line.png'
</script>


<template>
  <tr class="table-head">
    <td>
      №
    </td>
    <td>
      <i>a</i>
      <sub>
        <i>i</i>
      </sub>
    </td>
    <td>
      <img :src="aWithUpperLine" width="18" height="18" />
    </td>
    <td>
      <sub>▲</sub>
      <i>a</i>
      <sub>
        <i>i</i>
      </sub>
    </td>
    <td>
      <sub>▲</sub>
      <i>a</i>
      <sub>
        <i>i</i>
      </sub>
      <sup>2</sup>
    </td>
    <td>
      G
    </td>
    <td>
      <i>P</i>
    </td>
    <td>
      <i>t</i>
      <sub>
        <i>PN</i>
      </sub>
    </td>
    <td>
      <sub>▲</sub>
      <i>a</i>
      <sub>сл</sub>
    </td>
  </tr>
</template>


<style lang="scss" scoped>
  .table-head {
  td {
    min-width: 20px;
    padding: 5px;
    text-align: center;
  }
}
</style>