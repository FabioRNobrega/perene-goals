<template>
  <TopNavbar iconNameLeft="home" iconNameRight="remove" pathNameLeft="/"/>
  <main class="base-container">
    <h1 class="base-title">  {{ goalList.title }} </h1>
    <p class="base-text">  {{ goalList.description }} </p>

    <div  class="base-list-display">
      <BaseCard v-for="goal in goalList.goals " :key="goal.title" >
        <template v-slot:header>
          <div class="goal-header">
            <h3 >{{ goal.title }}</h3>
            <div class="goal-header__actions">
              <SVGIcon icon-name="details" /> 
              <SVGIcon icon-name="edit" /> 
            </div> 
          </div> 

        </template>
        <template v-slot:row>
          <p>  {{ goal.description }} </p>
          <BaseProgressBar />
          <BaseButton :light="true" icon="finish" content="achieve goal" />
        </template>
      </BaseCard>
    </div> 


    <BaseButton :light="true" icon="plus" content="Add Another goal on this list"  @click="handleCreateGoal(goalList.id)"/>

  </main>
</template>

<script>
import TopNavbar from '../components/TopNavBar/index.vue'
import BaseButton from '../components/BaseButton/index.vue'
import BaseCard from '../components/BaseCard/index.vue'
import SVGIcon from '../components/SVGIcon/index.vue'
import BaseProgressBar from '../components/BaseProgressBar/index.vue'

import { fetchGoalsList } from '../api/goals-list';

export default {
  name: "GoalListView",
  components: {
    TopNavbar,
    BaseCard,
    BaseButton,
    SVGIcon,
    BaseProgressBar
  },
  data () {
    return {
      routeId: "",
      userAuth: {},
      goalList: {}
    }
  },
  created() {
    this.setData()
  },
  methods: {
    async setData() {
      this.routeId = this.$route.params.id;
      this.userAuth = JSON.parse(localStorage.getItem('user-auth'))
      try {
        const { data } = await fetchGoalsList(
          this.routeId,
          this.userAuth['access-token'],
          this.userAuth['client'],
          this.userAuth['uid']
        )

        this.goalList = data
      } catch(error) {
        console.error(error)
      }
    },
    handleBottomNavbarClick() {
      this.$router.push("/")
    },
    handleCreateGoal(id) {
      this.$router.push(`/create-goal/${id}`)
    }
  }
}

</script>

<style lang="sass" scoped>
@import "../assets/main"
@import "../assets/_variables"
@import "../assets/_mixins"

.goal-header
  @include display-row
  justify-content: space-between

  & h3
    width: 70%

  &__actions 
    @include display-row
    justify-content: space-around
    color: var(--primary)
    width: 30%
    @include tablets-and-up
      width: 20%
</style>
