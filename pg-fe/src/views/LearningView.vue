<template>
  <TopNavbar iconNameLeft="user" iconNameRight="home" pathNameRight="/"/>
  <main class="base-container">
    <h1 class="base-title"> Learning</h1>
  </main>
</template>

<script>
import TopNavbar from '../components/TopNavBar/index.vue'

export default {
  name: "LearningView",
  components: {
    TopNavbar,
  }
}

</script>

<style lang="sass" scoped>
@import "../assets/main"
@import "../assets/_variables"
</style>
