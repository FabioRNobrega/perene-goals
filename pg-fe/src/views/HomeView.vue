<template>
  <TopNavbar iconNameLeft="user"  iconNameRight="learning"/>
  <main class="base-container">
    <div class="hero">
      <img class="hero__logo" src="src/assets/logo/perene-goals.png"/>
      <img class="hero__banner" src="src/assets/banners/banner.png"/>
    </div>


    <h1 class="base-title" style="margin-bottom: 0;"> My Goals List</h1>  
    <BaseButton @click="handleCreateGoalList" :light="true" icon="plus" content="SET YOUR FIRST GOAL LIST" />

    <BaseCard>
      <template v-slot:header>
        <h3 class="title"> Read More</h3>
      </template>
      <template v-slot:row>
      </template>
    </BaseCard>
  </main>
  <BottomNavbar iconName="plus" pathName="/create-goals-list" />
</template>

<script>
import BaseCard from '../components/BaseCard/index.vue'
import TopNavbar from '../components/TopNavBar/index.vue'
import BottomNavbar from '../components/BottomNavBar/index.vue'
import BaseButton from '../components/BaseButton/index.vue'

export default {
  name: "HomeView",
  components: {
    BaseCard,
    TopNavbar,
    BottomNavbar,
    BaseButton
  },
  methods: {
    handleCreateGoalList() {
      this.$router.push('/create-goals-list')
    }
  }
}

</script>

<style lang="sass">
@import "../assets/main"
@import "../assets/_variables"
@import "../assets/_mixins"

.hero 
 @include display-col 
 justify-content: center

 &__logo
  width: 112px
  margin: -50px auto 10px auto

 &__banner
  border-radius: 5px
  width: 100%
  margin: 0px auto 10px auto
  @include tablets-and-up
    height: 300px
    object-fit: cover


</style>
