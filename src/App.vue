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
}
.main-content {
  width: 895px;
  max-width: 100vw;
  padding: 5px calc(10px + 10 * ((100vw - 250px) / (1000 - 250)));
}
</style>