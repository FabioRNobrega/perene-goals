<template>
 
  <TopNavbar >
    <template v-slot:iconLeft>
      <SVGIcon icon-name="user"  @click="this.$router.push('/profile')"/>
    </template>
    <template v-slot:iconRight>
      <SVGIcon icon-name="home" @click="this.$router.push('/')"/>
    </template>
  </TopNavbar>
  
  <main class="base-container">
    <h1 class="base-title"> Learning</h1>
  </main>
</template>

<script>
import TopNavbar from '../components/TopNavBar/index.vue'
import SVGIcon from '../components/SVGIcon/index.vue'


export default {
  name: "LearningView",
  components: {
    TopNavbar,
    SVGIcon
  }
}

</script>

<style lang="sass" scoped>
@import "../assets/main"
@import "../assets/_variables"
</style>
