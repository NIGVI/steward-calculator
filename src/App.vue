<script setup lang="ts">
import { StudentCalculator } from './student-calculator/'
</script>

<template>
  <div class="page">
    <main class="main-content">
      <StudentCalculator />
    </main>
  </div>
</template>

<style lang="scss">
body {
  margin: 0;
}
* {
  font-family: Arial, Helvetica, sans-serif;
  box-sizing: border-box;
}
.page {
  display: flex;
  justify-content: center;
  min-height: 100vh;
  border: solid 1px;
}
.main-content {
  width: min-content;
}
</style>
./student calculator