<template>
  <TopNavbar >
    <template v-slot:iconLeft>
      <SVGIcon icon-name="back"  @click="this.$router.go(-1)"/>
    </template>
    <template v-slot:iconRight>
      <SVGIcon icon-name="remove" @click="handleDeleteGoalModal(this.routeId)"/>
    </template>
  </TopNavbar>

  <main class="base-container">
    <h1 class="base-title">  {{ goal.title }} </h1>
    <p class="base-text">  {{ goal.description }} </p>
    <BaseButton :light="true" icon="plus" content="Add Another step on this goal"  @click="handleCreateGoalStep(goal.id)"/>
    <BaseButton :dark="true" icon="remove" content="Delete the entire goal"  @click="handleDeleteGoalModal(this.routeId)"/>


    <div  class="base-list-display">
      <BaseCard v-for="steps in goal.goals_step" :key="steps.id" >
        <template v-slot:header>
          <div class="goal-header">
            <h3 >{{ steps.title }}</h3>
            <div class="goal-header__actions">
              <BaseButton :solidLight="true" :isIcon="true" icon="edit" @click="handleEditGoalStep(steps.id)"/>
              <BaseButton :solidLight="true" :isIcon="true" icon="remove" @click="handleDeleteGoalStepModal(steps.id)"/>
            </div> 
          </div> 

        </template>
        <template v-slot:row>
          <p>  {{ steps.description }} </p>
          <BaseProgressBar v-if="steps.started" :process="steps" />
          <BaseButton  v-else :light="true" icon="start" content="Start goal step"  @click="handleStartGoalStep(steps.id)"/>
          <BaseButton v-if="!steps.completed" :light="true" icon="finish" content="achieve goal step" @click="handleAchieveGoalStepModal(steps.id)"/>
        </template>
      </BaseCard>
    </div> 

    <ConfettiEffect :confetti="showConfetti"/>
  </main>

  <BaseModal 
    :showModal="showAchieveGoalStepModal"
    content="When you confirm this action, this step will be marked as completed. Are you positive about this decision? We're incredibly excited to witness your determination and celebrate your achievements!"
  >
    <template v-slot:footer>
      <BaseButton :light="true" :small="true" icon="close" content="cancel" @click="this.showAchieveGoalStepModal = !this.showAchieveGoalStepModal"/>
      <BaseButton :light="true" :small="true" icon="finish" content="confirm" @click="handleAchieveGoalStep()"/>
    </template>
  </BaseModal>

  <BaseModal 
    :showModal="showDeleteStepModal"
    content="Deleting this step means it will be gone forever. Are you ready to take this action? Embrace the opportunity to remove this step and make way for new ones. Keep advancing towards your goals!"
  >
    <template v-slot:footer>
      <BaseButton :light="true" :small="true" icon="close" content="cancel" @click="this.showDeleteStepModal = !this.showDeleteStepModal"/>
      <BaseButton :light="true" :small="true" icon="remove" content="confirm" @click="handleDeleteGoalStep()"/>
    </template>
  </BaseModal>

  <BaseModal 
    :showModal="showDeleteGoalModal"
    content="By deleting this goal, you'll also eliminate all its associated steps. Are you certain about this decision? Embrace the change and create space for fresh ambitions. Keep pushing towards your dreams!"
  >
    <template v-slot:footer>
      <BaseButton :light="true" :small="true" icon="close" content="cancel" @click="this.showDeleteGoalModal = !this.showDeleteGoalModal"/>
      <BaseButton :light="true" :small="true" icon="remove" content="confirm" @click="handleDeleteGoal()"/>
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
import ConfettiEffect from '../components/ConfettiEffect/index.vue'

import soundMP3 from '../assets/sounds/sound.mp3'

import { fetchGoalsWithSteps, deleteGoal } from '../api/goals'
import { deleteGoalsSteps, updateGoalStep } from '../api/goals-steps'

export default {
  name: "GoalStepListView",
  components: {
    TopNavbar,
    BaseCard,
    BaseModal,
    BaseButton,
    SVGIcon,
    BaseProgressBar,
    ConfettiEffect
  },
  data () {
    return {
      routeId: "",
      userAuth: {},
      showDeleteStepModal: false,
      showAchieveGoalStepModal: false,
      showDeleteGoalModal: false,
      step_id: "",
      goal: {},
      showConfetti: false
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
      console.log(step_id)
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
    async handleAchieveGoalStep() {
      const timeNow = new Date()
      try {
       await updateGoalStep(
          this.step_id,
          {
            completed: true,
            completed_at: timeNow
          },
          this.userAuth['access-token'],
          this.userAuth['client'],
          this.userAuth['uid']
        )
        this.showAchieveGoalStepModal = false
        const som = new Audio(soundMP3);
        som.play();
        this.showConfetti = true 
        setTimeout(() => {
          this.showConfetti = false
        }, 1000); 
        this.setData()
      } catch(error) {
        console.error(error)
      }
    },
    async handleDeleteGoal() {
      try {
        await deleteGoal(
          this.goal_id,
          this.userAuth['access-token'],
          this.userAuth['client'],
          this.userAuth['uid']
        )
        this.showDeleteGoalModal = false
        this.$router.go(-1);
      } catch(error) {
        console.error(error)
      }
    },
    handleDeleteGoalStepModal(step_id) {
      this.step_id = step_id
      this.showDeleteStepModal = !this.showDeleteStepModal
    },
    handleAchieveGoalStepModal(step_id) {
      this.showAchieveGoalStepModal = !this.showAchieveGoalStepModal
      this.step_id = step_id
    },
    handleBottomNavbarClick() {
      this.$router.push("/")
    },
    handleCreateGoalStep(goal_id) {
      this.$router.push(`/create-goal-step/${goal_id}`)
    },
    handleDeleteGoalModal(goal_id) {
      this.showDeleteGoalModal = !this.showDeleteGoalModal
      this.goal_id = goal_id
    },
    handleEditGoalStep(goal_step_id) {
      this.$router.push(`/update-goal-step/${goal_step_id}`)
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
