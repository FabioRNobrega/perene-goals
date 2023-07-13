<template>
  <TopNavbar >
    <template v-slot:iconLeft>
      <SVGIcon icon-name="user"  @click="this.$router.push('/profile')"/>
    </template>
    <template v-slot:iconRight>
      <SVGIcon icon-name="learning" @click="this.$router.push('/learning')"/>
    </template>
  </TopNavbar>
  
  <main class="base-container">
    <div class="hero">
      <img class="hero__logo" src="src/assets/logo/perene-goals.png"/>
      <BaseHero />
    </div>

    <h1 class="base-title title-space" style="margin-bottom: 0;"> My Goals List</h1>  
    <BaseButton v-if="myGoalsList == []" @click="handleCreateGoalList" :light="true" icon="plus" content="SET YOUR FIRST GOAL LIST" />
    <div class="base-list-display"> 
      <BaseCard v-for="goalList in myGoalsList" :key="goalList.title" >
        <template v-slot:header>
          <div class="goals-list__header"> 
            <h3 >{{ goalList.title }}</h3>
            <div class="goals-list__header--actions">
              <BaseButton :solidLight="true" :isIcon="true" icon="edit" @click="handleEditGoalList(goalList.id)"/>
              <BaseButton :solidLight="true" :isIcon="true" icon="remove" @click="handleDeleteGoalListModal(goalList.id)"/>
            </div> 
          </div>
        </template>
        <template v-slot:row>
          <p class="base-text-light">  {{ goalList.description }} </p>
          <BaseButton :light="true" icon="details" content="See goals list" @click="handleSeeGoalsList(goalList.id)"/>
        </template>
      </BaseCard>
    </div>
    <BaseButton v-if="myGoalsList != []" :light="true" icon="plus" content="set more goals" />


    <h1 id="publicLists" class="base-title title-space"> Public Goals List</h1>  
    <div v-for="goal in publicGoalsList" :key="goal.title" class="goals-list">
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
    <BaseButton v-if="end" @click="backToTop('publicLists')" :light="true" icon="next" content="back to the top" />
    <BaseButton v-else @click="setData" :light="true" icon="next" content="load more goals list" />
  </main>
  <BottomNavbar iconName="plus"  @click="handleBottomNavbarClick" />
</template>

<script>
import TopNavbar from '../components/TopNavBar/index.vue'
import BottomNavbar from '../components/BottomNavBar/index.vue'
import BaseButton from '../components/BaseButton/index.vue'
import BaseCard from '../components/BaseCard/index.vue'
import SVGIcon from '../components/SVGIcon/index.vue'
import BaseHero from '../components/BaseHero/index.vue'

import { goalsListPublic, goalsListPrivate } from '../api/goals-list'

export default {
  name: "HomeView",
  components: {
    TopNavbar,
    BaseCard,
    BaseHero,
    BottomNavbar,
    BaseButton,
    SVGIcon
  },
  data () {
    return {
      publicGoalsList: [],
      myGoalsList: [],
      page: 1,
      end: false,
      userAuth: {},
    }
  },
  created() {
    this.setData()
  },
  methods: {
    async setData() {
      this.userAuth = JSON.parse(localStorage.getItem('user-auth'))

      if(this.userAuth != null) {
        this.getMyGoalsLists()
      }

      try {
        const { data } = await goalsListPublic(this.page)
        if(data.meta) {
          this.end = true
          return
        } else {
          this.publicGoalsList = this.publicGoalsList.concat(data)
          this.page = this.page + 1
        }
      } catch(error) {
        console.error(error)
      }
    },
    async getMyGoalsLists() {
      try {
        const { data } = await goalsListPrivate(
          this.userAuth['access-token'],
          this.userAuth['client'],
          this.userAuth['uid']
        )
        this.myGoalsList = data
      } catch(error) {
        console.error(error)
      }
    },
    backToTop(id) {
      const element = document.getElementById(id);
      if (element) {
        element.scrollIntoView({ behavior: 'smooth' });
      }
    },
    handleCreateGoalList() {
      this.$router.push('/create-goals-list')
    },
    handleBottomNavbarClick() {
      this.$router.push('/create-goals-list')
    },
    handleSeeGoalsList(id) {
      this.$router.push(`/goals-list/${id}`)
    },
    handleEditGoalList(goal_list_id) {
      this.$router.push(`/update-goals-list/${goal_list_id}`)
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

  &__header
    @include display-row
    justify-content: space-between
    align-items: center

    & h3
      width: 70%

    &--actions 
      @include display-row
      justify-content: space-around
      color: var(--primary)
      width: 30%
      @include tablets-and-up
        width: 20%

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
