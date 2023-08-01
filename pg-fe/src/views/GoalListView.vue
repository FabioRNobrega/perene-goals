<template>
  <TopNavbar >
    <template v-slot:iconLeft>
      <SVGIcon icon-name="home"  @click="this.$router.push('/')"/>
    </template>
    <template v-slot:iconRight>
      <SVGIcon icon-name="remove" @click="handleDeleteGoalListModal()"/>
    </template>
  </TopNavbar>


  <main class="base-container">
    <BaseMessage  
      icon="success" 
      content="Congratulations! Your new goals list is ready. Customize it to match your dreams, and let the journey to success begin!" 
      :success="true" 
      :visibility="successCloned" 
      @hide="successCloned = false"
    />
    
    <h1 class="base-title">  {{ goalList.title }} </h1>
    <p class="base-text">  {{ goalList.description }} </p>

    <BarChart :progress="listProgress"/>

    <BaseButton :light="true" icon="plus" content="Add Another goal on this list"  @click="handleCreateGoal(goalList.id)"/>
    <BaseButton :dark="true" icon="remove" content="Delete the entire list"  @click="handleDeleteGoalListModal()"/>

    <div  class="base-list-display">
      <BaseCard v-for="goal in goalList.goals " :key="goal.title" >
        <template v-slot:header>
          <div class="goal-header">
            <h3 >{{ goal.title }}</h3>
            <div class="goal-header__actions">
              <BaseButton :solidLight="true" :isIcon="true" icon="details" @click="handleGoalDetails(goal.id)"/>
              <BaseButton :solidLight="true" :isIcon="true" icon="remove" @click="handleDeleteGoalModal(goal.id)"/>
              <BaseButton :solidLight="true" :isIcon="true" icon="edit" @click="handleEditGoal(goal.id)" />
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

  <BaseModal 
    :showModal="showDeleteListModal"
    content="When you proceed with this action, all the goals associated with this goal list, along with their steps, will be deleted. Are you completely certain about this choice? We encourage you to delete them and make way for new exciting goals in your journey. Keep up the great work!"
  >
    <template v-slot:footer>
      <BaseButton :light="true" :small="true" icon="close" content="cancel" @click="handleDeleteGoalListModal()"/>
      <BaseButton :light="true" :small="true" icon="remove" content="confirm" @click="handleDeleteGoalList()"/>
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
import SVGIcon from '../components/SVGIcon/index.vue'
import BaseProgressBar from '../components/BaseProgressBar/index.vue'
import ConfettiEffect from '../components/ConfettiEffect/index.vue'
import BaseModal from '../components/BaseModal/index.vue'
import BarChart from '../components/BarChart/index.vue'
import BaseMessage from '../components/BaseMessage/index.vue'


import soundMP3 from '../assets/sounds/sound.mp3'

import { fetchGoalsList, deleteGoalsList } from '../api/goals-list'
import { updateGoal, deleteGoal } from '../api/goals'
import { fetchGoalsListMetrics } from   '../api/metrics'

export default {
  name: "GoalListView",
  components: {
    TopNavbar,
    BaseCard,
    BaseButton,
    SVGIcon,
    BaseProgressBar,
    ConfettiEffect,
    BaseModal,
    BarChart,
    BaseMessage
  },
  data () {
    return {
      routeId: "",
      userAuth: {},
      goalList: {},
      showConfetti: false,
      showModal: false,
      showDeleteListModal: false,
      showDeleteGoalModal: false,
      goal_id: "",
      listProgress: {},
      successCloned: false
    }
  },
  created() {
    this.setData()
  },
  methods: {
    async setData() {
      this.routeId = this.$route.params.id;
      this.successCloned = this.$route.query.success
      this.userAuth = JSON.parse(localStorage.getItem('user-auth'))
      try {
        const { data } = await fetchGoalsList(
          this.routeId,
          this.userAuth['access-token'],
          this.userAuth['client'],
          this.userAuth['uid']
        )
        this.fetchMetrics(this.routeId)
        this.goalList = data
      } catch(error) {
        console.error(error)
      }
    },
    async fetchMetrics(goal_list_id) {
      try {
        const { data } = await fetchGoalsListMetrics(
            goal_list_id,
            this.userAuth['access-token'],
            this.userAuth['client'],
            this.userAuth['uid']
          )
          this.listProgress =  data
      } catch (error) {
        console.log(error)
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
    handleEditGoal(goal_id) {
      this.$router.push(`/update-goal/${goal_id}`)
    },
    handleAchieveGoalModal(goal_id) {
      this.showModal = !this.showModal
      this.goal_id = goal_id
    },
    handleDeleteGoalModal(goal_id) {
      this.showDeleteGoalModal = !this.showDeleteGoalModal
      this.goal_id = goal_id
    },
    handleDeleteGoalListModal() {
      this.showDeleteListModal = !this.showDeleteListModal
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
    },
    async handleDeleteGoal() {
      try {
        await deleteGoal(
          this.goal_id,
          this.userAuth['access-token'],
          this.userAuth['client'],
          this.userAuth['uid']
        )
      this.setData()
      this.showDeleteGoalModal = false
      } catch(error) {
        console.error(error)
      }
    },
    async handleDeleteGoalList() {
      try {
        await deleteGoalsList(
          this.routeId,
          this.userAuth['access-token'],
          this.userAuth['client'],
          this.userAuth['uid']
        )
        this.showDeleteListModal = false
        this.$router.push("/")
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
    width: 60%
    @include tablets-and-up
      width: 70%

  &__actions 
    @include display-row
    justify-content: space-around
    color: var(--primary)
    width: 40%
    @include tablets-and-up
      width: 30%
</style>
