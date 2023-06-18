<template>
  <TopNavbar iconNameLeft="home" iconNameRight="remove" pathNameLeft="/"/>
  <main class="base-container">
    <h1 class="base-title">  {{ goalList.title }} </h1>
    <p class="base-text">  {{ goalList.description }} </p>
    <BaseButton :light="true" icon="plus" content="Add Another goal on this list"  @click="handleCreateGoal(goalList.id)"/>

    <div  class="base-list-display">
      <BaseCard v-for="goal in goalList.goals " :key="goal.title" >
        <template v-slot:header>
          <div class="goal-header">
            <h3 >{{ goal.title }}</h3>
            <div class="goal-header__actions">
              <BaseButton :solidLight="true" :isIcon="true" icon="details" @click="handleGoalDetails(goal.id)"/>
              <SVGIcon icon-name="edit" /> 
            </div> 
          </div> 

        </template>
        <template v-slot:row>
          <p>  {{ goal.description }} </p>
          <BaseProgressBar v-if="goal.started" :process="goal" />
          <BaseButton  v-else :light="true" icon="start" content="Start goal" @click="handleStartGoal(goal.id)"/>
          <BaseButton v-if="!goal.completed" :light="true" icon="finish" content="achieve goal" @click="handleAchieveGoalModal(goal.id)"/>
        </template>
      </BaseCard>
    </div> 

    <ConfettiEffect :confetti="showConfetti"/>
  </main>
  <BaseModal 
    :showModal="showModal"
    content="When you confirm this action, all the goal steps linked to this goal will be marked as complete. Are you positive about this decision? We're incredibly excited to witness your determination and celebrate your achievements!"
  >
    <template v-slot:footer>
      <BaseButton :light="true" :small="true" icon="close" content="cancel" @click="this.showModal = !this.showModal"/>
      <BaseButton :light="true" :small="true" icon="finish" content="confirm" @click="handleAchieveGoal()"/>
    </template>
  </BaseModal>
</template>

<script>
import TopNavbar from '../components/TopNavBar/index.vue'
import BaseButton from '../components/BaseButton/index.vue'
import BaseCard from '../components/BaseCard/index.vue'
import SVGIcon from '../components/SVGIcon/index.vue'
import BaseProgressBar from '../components/BaseProgressBar/index.vue'
import ConfettiEffect from '../components/ConfettiEffect/index.vue'
import BaseModal from '../components/BaseModal/index.vue'

import soundMP3 from '../assets/sounds/sound.mp3'

import { fetchGoalsList } from '../api/goals-list'
import { updateGoal } from '../api/goals'

export default {
  name: "GoalListView",
  components: {
    TopNavbar,
    BaseCard,
    BaseButton,
    SVGIcon,
    BaseProgressBar,
    ConfettiEffect,
    BaseModal
  },
  data () {
    return {
      routeId: "",
      userAuth: {},
      goalList: {},
      showConfetti: false,
      showModal: false,
      goal_id: ""
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
    async handleStartGoal(goal_id) {
      const timeNow = new Date()
      try {
       await updateGoal(
          goal_id,
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
    handleBottomNavbarClick() {
      this.$router.push("/")
    },
    handleCreateGoal(id) {
      this.$router.push(`/create-goal/${id}`)
    },
    handleGoalDetails(id) {
      this.$router.push(`/goals/${id}/steps`)
    },
    handleAchieveGoalModal(goal_id) {
      this.showModal = !this.showModal
      this.goal_id = goal_id
    },
    async handleAchieveGoal() {
      const timeNow = new Date()
      try {
       await updateGoal(
          this.goal_id,
          {
            completed: true,
            completed_at: timeNow
          },
          this.userAuth['access-token'],
          this.userAuth['client'],
          this.userAuth['uid']
        )
        this.showModal = false
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
