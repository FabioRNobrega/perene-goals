<template>
  <TopNavbar iconNameLeft="back" iconNameRight="remove" :pathNameLeft="`/goals-list/${goal.goals_list_id}`" />
  <main class="base-container">
    <h1 class="base-title">  {{ goal.title }} </h1>
    <p class="base-text">  {{ goal.description }} </p>

    <div  class="base-list-display">
      <BaseCard v-for="steps in goal.goals_step" :key="steps.id" >
        <template v-slot:header>
          <div class="goal-header">
            <h3 >{{ steps.title }}</h3>
            <div class="goal-header__actions">
              <SVGIcon icon-name="details" /> 
              <SVGIcon icon-name="edit" /> 
            </div> 
          </div> 

        </template>
        <template v-slot:row>
          <p>  {{ steps.description }} </p>
          <BaseProgressBar />
          <BaseButton :light="true" icon="finish" content="achieve goal" />
        </template>
      </BaseCard>
    </div> 


    <BaseButton :light="true" icon="plus" content="Add Another step on this goal"  @click="handleCreateGoal(goal.id)"/>

  </main>
</template>

<script>
import TopNavbar from '../components/TopNavBar/index.vue'
import BaseButton from '../components/BaseButton/index.vue'
import BaseCard from '../components/BaseCard/index.vue'
import SVGIcon from '../components/SVGIcon/index.vue'
import BaseProgressBar from '../components/BaseProgressBar/index.vue'

import { fetchGoalsWithSteps } from '../api/goals';

export default {
  name: "GoalStepListView",
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
      goal: {}
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
        const { data } = await fetchGoalsWithSteps(
          this.routeId,
          this.userAuth['access-token'],
          this.userAuth['client'],
          this.userAuth['uid']
        )

        this.goal = data
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
