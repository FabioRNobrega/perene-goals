<template>
  <TopNavbar iconNameLeft="back" iconNameRight="remove" :pathNameLeft="`/goals-list/${goal.goals_list_id}`" />
  <main class="base-container">
    <h1 class="base-title">  {{ goal.title }} </h1>
    <p class="base-text">  {{ goal.description }} </p>
    <BaseButton :light="true" icon="plus" content="Add Another step on this goal"  @click="handleCreateGoalStep(goal.id)"/>

    <div  class="base-list-display">
      <BaseCard v-for="steps in goal.goals_step" :key="steps.id" >
        <template v-slot:header>
          <div class="goal-header">
            <h3 >{{ steps.title }}</h3>
            <div class="goal-header__actions">
              <SVGIcon icon-name="edit" /> 
              <BaseButton :solidLight="true" :isIcon="true" icon="remove" @click="handleDeleteGoalStepModal(steps.id)"/>
            </div> 
          </div> 

        </template>
        <template v-slot:row>
          <p>  {{ steps.description }} </p>
          <BaseProgressBar v-if="steps.started" :process="steps" />
          <BaseButton  v-else :light="true" icon="start" content="Start goal step"  @click="handleDeleteGoalStepModal(steps.id)"/>
          <BaseButton :light="true" icon="finish" content="achieve goal step" />
        </template>
      </BaseCard>
    </div> 
  </main>

  <BaseModal 
    :showModal="showDeleteStepModal"
    content="Deleting this step means it will be gone forever. Are you ready to take this action? Embrace the opportunity to remove this step and make way for new ones. Keep advancing towards your goals!"
  >
    <template v-slot:footer>
      <BaseButton :light="true" :small="true" icon="close" content="cancel" @click="this.showDeleteStepModal = !this.showDeleteStepModal"/>
      <BaseButton :light="true" :small="true" icon="remove" content="confirm" @click="handleDeleteGoalStep()"/>
    </template>
  </BaseModal>

</template>

<script>
import TopNavbar from '../components/TopNavBar/index.vue'
import BaseButton from '../components/BaseButton/index.vue'
import BaseCard from '../components/BaseCard/index.vue'
import BaseModal from '../components/BaseModal/index.vue'
import SVGIcon from '../components/SVGIcon/index.vue'
import BaseProgressBar from '../components/BaseProgressBar/index.vue'

import { fetchGoalsWithSteps } from '../api/goals'
import { deleteGoalsSteps, updateGoalStep } from '../api/goals-steps'

export default {
  name: "GoalStepListView",
  components: {
    TopNavbar,
    BaseCard,
    BaseModal,
    BaseButton,
    SVGIcon,
    BaseProgressBar
  },
  data () {
    return {
      routeId: "",
      userAuth: {},
      showDeleteStepModal: false,
      step_id: "",
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
    async handleStartGoalStep(step_id) {
      const timeNow = new Date()
      try {
       await updateGoalStep(
          step_id,
          {
            started: true,
            start_at: timeNow
          },
          this.userAuth['access-token'],
          this.userAuth['client'],
          this.userAuth['uid']
        )
        this.setData()
      } catch(error) {
        console.error(error)
      }
    },
    async handleDeleteGoalStep() {
      try {
        await deleteGoalsSteps(
          this.step_id,
          this.userAuth['access-token'],
          this.userAuth['client'],
          this.userAuth['uid']
        )
      this.showDeleteStepModal = false
      this.setData()
      } catch(error) {
        console.error(error)
      }
    },
    handleDeleteGoalStepModal(step_id) {
      this.step_id = step_id
      this.showDeleteStepModal = !this.showDeleteStepModal
    },
    handleBottomNavbarClick() {
      this.$router.push("/")
    },
    handleCreateGoalStep(goal_id) {
      this.$router.push(`/create-goal-step/${goal_id}`)
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
  align-items: center

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
