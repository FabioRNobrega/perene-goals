<template>
  <TopNavbar iconNameLeft="user"  iconNameRight="learning"/>
  <main class="base-container">
    <div class="hero">
      <img class="hero__logo" src="src/assets/logo/perene-goals.png"/>
      <img class="hero__banner" src="src/assets/banners/banner.png"/>
    </div>


    <h1 class="base-title title-space" style="margin-bottom: 0;"> My Goals List</h1>  
    <BaseButton @click="handleCreateGoalList" :light="true" icon="plus" content="SET YOUR FIRST GOAL LIST" />

    <h1 class="base-title title-space"> Public Goals List</h1>  
    <div v-for="goal in goalsList" :key="goal.title" class="goals-list">
      <BaseCard >
        <template v-slot:header>
          <h3 >{{ goal.title }}</h3>
        </template>
        <template v-slot:row>
          <p>  {{ goal.description }} </p>
          <div class="goals-list__like">
            <div class="goals-list__like--content">
              <h5>  {{ goal.likes || 10 }}  </h5> <SVGIcon icon-name="like" /> 
            </div> 
            <div class="goals-list__like--content">
              <h5> {{ goal.dislikes || 0 }} </h5>  <SVGIcon icon-name="unlike" /> 
            </div> 
          </div> 
        </template>
      </BaseCard>
    </div>
  </main>
  <BottomNavbar iconName="plus" pathName="/create-goals-list" />
</template>

<script>
import BaseCard from '../components/BaseCard/index.vue'
import TopNavbar from '../components/TopNavBar/index.vue'
import BottomNavbar from '../components/BottomNavBar/index.vue'
import BaseButton from '../components/BaseButton/index.vue'
import SVGIcon from '../components/SVGIcon/index.vue'

import { goalsListPublic } from '../api/goals-list'

export default {
  name: "HomeView",
  components: {
    BaseCard,
    TopNavbar,
    BottomNavbar,
    BaseButton,
    SVGIcon
  },
  data () {
    return {
      goalsList: []
    }
  },
  created() {
    this.setData()
  },
  methods: {
    async setData() {
      try {
        const { data } = await goalsListPublic()
        this.goalsList = data
      } catch(error) {
        console.error(error)
      }
    },
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

.goals-list
  margin: 20px 0

  &__like 
    @include display-row
    justify-content: end

    &--content
      @include display-row
      align-items: center
      justify-content: space-around
      margin-top: 30px

      & h5 
        font-family: var(--font-family-base)
        color: var(--neutral-color-light)
        font-weight: 700
        font-size: 17px
        margin: 5px 5px 0 10px
      
      & .svg-icon
        color: var(--primary)





</style>
