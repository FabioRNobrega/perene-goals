<template>
    <TopNavbar iconNameLeft="user" iconNameRight="home" pathNameRight="/"/>
    <main class="base-container">
      <h1 class="base-title"> Create Goal</h1>
      <BaseInfo >
        <template v-slot:content>
          <p>
            A goals list is made up of specific goals that you can name, 
            describe, and set a deadline for in terms of days, hours, or 
            minutes. Breaking down a larger goal into smaller steps can 
            help make it easier to achieve and give you a sense of 
            accomplishment along the way. For more information, 
            visit our <a href="/learning"> learning section </a>.
          </p>
        </template>
      </BaseInfo>

      <BaseMessage  
        icon="warning" 
        :content="errorMessage" 
        :error="true" 
        :visibility="failsToCreateGoal" 
        @hide="failsToCreateGoal = false"
      />
      
      <div> 
        <BaseInput 
          :value="goalTitle" 
          @update:value="goalTitle = $event" 
          type="text"
          placeholder="Goal title"
          :error="goalTitleError"
          :error-message="goalTitleErrorMessage"
        />
        <BaseInput 
          :value="goalDescription" 
          @update:value="goalDescription = $event" 
          type="text"
          placeholder="Goal description"
          :error="goalDescriptionError"
          :error-message="goalDescriptionErrorMessage"
        />
        <BaseInput 
          :value="goalTimeToReachInDays" 
          @update:value="goalTimeToReachInDays = $event" 
          type="number"
          min="0"
          max="365"
          label="Time to Achieve in days"
        />
        <BaseInput 
          :value="goalTimeToReachInHours" 
          @update:value="goalTimeToReachInHours = $event" 
          type="number"
          min="0"
          max="24"
          label="Time to Achieve in hours"
        />
        <BaseInput 
          :value="goalTimeToReachInMinutes" 
          @update:value="goalTimeToReachInMinutes = $event" 
          type="number"
          min="0"
          max="60"
          label="Time to Achieve in minutes"
        />
        <BaseButton :light="true" icon="next" content="Add one step for achieve your goal" @click="handleCreateStepOnThisGoal"/>
        <BaseButton :light="true" icon="plus" content="Add Another goal on this list" @click="handleCreateAnotherGoal"/>
        <BaseButton :dark="true" icon="save" content="Save Goal" :disabled="!nextStep" @click="handleCreateGoal"/>
      </div> 
        
    </main>
    <BottomNavbar iconName="save" @click="handleCreateGoal" :disabled="!nextStep"/>
  </template>
  
  <script>
  import TopNavbar from '../components/TopNavBar/index.vue'
  import BottomNavbar from '../components/BottomNavBar/index.vue'
  import BaseInfo from '../components/BaseInfo/index.vue'
  import BaseInput from '../components/BaseInput/index.vue'
  import BaseButton from '../components/BaseButton/index.vue'
  import BaseMessage from '../components/BaseMessage/index.vue'
  
  import { createGoal } from '../api/goals'

  export default {
    name: "CreateGoalView",
    components: {
      TopNavbar,
      BottomNavbar,
      BaseInfo,
      BaseInput,
      BaseButton,
      BaseMessage
    },
    data () {
      return {
        goalTitle: "",
        goalDescription: "",
        goalTimeToReachInDays: "0",
        goalTimeToReachInHours: "0",
        goalTimeToReachInMinutes: "0",
        userAuth: {},
        routeId: "",
        failsToCreateGoal: false,
        errorMessage: "",
        goalTitleError: false,
        goalTitleErrorMessage: "",
        goalDescriptionError: false,
        goalDescriptionErrorMessage: ""
      }
    },
    created() {
      this.setData()
    },
    computed: {
      nextStep() {  
        return this.goalTitle != "" && this.goalDescription != ""
      }
    },
    methods: {
      async setData () {
      this.userAuth = JSON.parse(localStorage.getItem('user-auth'))
      this.routeId = this.$route.params.id;
    },
    async handleCreateStepOnThisGoal() {
      try {
        this.failsToCreateGoal = false
        const { data } = await createGoal(
          this.routeId,
          {
            title: this.goalTitle,
            description: this.goalDescription,
            time_to_reach_in_days: this.goalTimeToReachInDays,
            time_to_reach_in_hours: this.goalTimeToReachInHours,
            time_to_reach_in_minutes: this.goalTimeToReachInMinutes
          },
          this.userAuth['access-token'],
          this.userAuth['client'],
          this.userAuth['uid']
        )
        this.$router.push(`/create-goal-step/${data.id}`)
      } catch(error) {
        this.failsToCreateGoal = true
        this.errorMessage =  this.errorMessage = `${error}`
      }
    },
    async handleCreateGoal() {
      try {
        this.failsToCreateGoal = false
        await createGoal(
          this.routeId,
          {
            title: this.goalTitle,
            description: this.goalDescription,
            time_to_reach_in_days: this.goalTimeToReachInDays,
            time_to_reach_in_hours: this.goalTimeToReachInHours,
            time_to_reach_in_minutes: this.goalTimeToReachInMinutes
          },
          this.userAuth['access-token'],
          this.userAuth['client'],
          this.userAuth['uid']
        )
        this.$router.push(`/goals-list/${this.routeId}`)
      } catch(error) {
        console.log(error)
        this.failsToCreateGoal = true
        this.errorMessage =  this.errorMessage = `${error}`
      }
    },
     async handleCreateAnotherGoal() {
      try {
        this.failsToCreateGoal = false
        this.successUpdated = false
        await createGoal(
          this.routeId,
          {
            title: this.goalTitle,
            description: this.goalDescription,
            time_to_reach_in_days: this.goalTimeToReachInDays,
            time_to_reach_in_hours: this.goalTimeToReachInHours,
            time_to_reach_in_minutes: this.goalTimeToReachInMinutes
          },
          this.userAuth['access-token'],
          this.userAuth['client'],
          this.userAuth['uid']
        )

        this.goalTitle = ""
        this.goalDescription = ""
        this.goalTimeToReachInDays = 0
        this.goalTimeToReachInHours = 0 
        this.goalTimeToReachInMinutes = 0 
        
      } catch(error) {
        this.failsToCreateGoal = true
        this.errorMessage =  this.errorMessage = `${error}`
      }
     }
    }
  }
  
  </script>
  
  <style lang="sass">
  @import "../assets/main"
  @import "../assets/_variables"
  
  .title
    font-weight: bold
    text-align: center
    font-family: var(--font-family-title)
    font-size: 35px
    color: var(--neutral-color-lighter) 
  </style>
  