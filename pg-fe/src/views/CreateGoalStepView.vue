<template>
    <TopNavbar iconNameLeft="user" iconNameRight="home" pathNameRight="/"/>
    <main class="base-container">
      <h1 class="base-title"> Create Goal Step</h1>
      <BaseInfo >
        <template v-slot:content>
          <p>
            A goal step is a specific stage of a larger goal that is defined, 
            described, and given a deadline in a goal. Breaking down a larger 
            goal into smaller steps can make it easier to achieve and give a
            sense of accomplishment along the way. A "goal step" can be set based 
            on the deadline established for the larger goal and can be used to 
            track progress and ensure that the larger goal is being achieved.
            For more information on how to create effective goals and steps,
            visit our <a href="/learning"> learning section </a>.
          </p>
        </template>
      </BaseInfo>
      <div> 
        <BaseInput 
          :value="goalStepTitle" 
          @update:value="goalStepTitle = $event" 
          type="text"
          placeholder="Step title"
          :error="goalStepTitleError"
          :error-message="goalStepTitleErrorMessage"
        />
        <BaseInput 
          :value="goalStepDescription" 
          @update:value="goalStepDescription = $event" 
          type="text"
          placeholder="Step description"
          :error="goalStepDescriptionError"
          :error-message="goalStepDescriptionErrorMessage"
        />
        <BaseInput 
          :value="goalStepTimeToReachInDays" 
          @update:value="goalStepTimeToReachInDays = $event" 
          type="number"
          min="0"
          max="365"
          label="Time to Achieve in days"
          :error="goalStepDescriptionError"
          :error-message="goalStepDescriptionErrorMessage"
        />
        <BaseInput 
          :value="goalStepTimeToReachInHours" 
          @update:value="goalStepTimeToReachInHours = $event" 
          type="number"
          min="0"
          max="24"
          label="Time to Achieve in hours"
          :error="goalStepDescriptionError"
          :error-message="goalStepDescriptionErrorMessage"
        />
        <BaseInput 
          :value="goalStepTimeToReachInMinutes" 
          @update:value="goalStepTimeToReachInMinutes = $event" 
          type="number"
          min="0"
          max="60"
          label="Time to Achieve in minutes"
          :error="goalStepDescriptionError"
          :error-message="goalStepDescriptionErrorMessage"
        />
        <BaseButton :light="true" icon="plus" content="Add another step on this goal" @click="handleCreateNewStep" />
        <BaseButton :dark="true" icon="save" content="Save Step" :disabled="!nextStep"  @click="handleCreateGoalStep"/>
      </div> 
        
    </main>
    <BottomNavbar iconName="save" @click="handleCreateGoalStep" :disabled="!nextStep"/>
  </template>
  
  <script>
  import TopNavbar from '../components/TopNavBar/index.vue'
  import BottomNavbar from '../components/BottomNavBar/index.vue'
  import BaseInfo from '../components/BaseInfo/index.vue'
  import BaseInput from '../components/BaseInput/index.vue'
  import BaseButton from '../components/BaseButton/index.vue'
  
  import { createGoalStep } from '../api/goals-steps'

  export default {
    name: "CreateGoalStepView",
    components: {
      TopNavbar,
      BottomNavbar,
      BaseInfo,
      BaseInput,
      BaseButton
    },
    data () {
      return {
        goalStepTitle: "",
        goalStepDescription: "",
        goalStepTimeToReachInDays: 0,
        goalStepTimeToReachInHours: 0,
        goalStepTimeToReachInMinutes: 0,
        userAuth: {},
        routeId: ""
      }
    },
    created() {
    this.setData()
    },
    computed: {
      nextStep() {  
        return this.goalStepTitle != "" && this.goalStepDescription != ""
      }
    },
    methods: {
      async setData () {
        this.userAuth = JSON.parse(localStorage.getItem('user-auth'))
        this.routeId = this.$route.params.id;
      },
      async handleCreateGoalStep() {
        try {
          this.failsToCreateGoalList = false
          this.successUpdated = false
          await createGoalStep(
            this.routeId,
            {
              title: this.goalStepTitle,
              description: this.goalStepDescription,
              time_to_reach_in_days: this.goalStepTimeToReachInDays,
              time_to_reach_in_hours: this.goalStepTimeToReachInHours,
              time_to_reach_in_minutes: this.goalStepTimeToReachInMinutes
            },
            this.userAuth['access-token'],
            this.userAuth['client'],
            this.userAuth['uid']
          )
          this.$router.push(`/goals/${this.routeId}/steps`)
        } catch(error) {
          this.failsToCreateGoalList = true
          this.errorMessage =  this.errorMessage = `${error}`
        }
      },
      async handleCreateNewStep() {
        try {
          this.failsToCreateGoalList = false
          this.successUpdated = false
          await createGoalStep(
            this.routeId,
            {
              title: this.goalStepTitle,
              description: this.goalStepDescription,
              time_to_reach_in_days: this.goalStepTimeToReachInDays,
              time_to_reach_in_hours: this.goalStepTimeToReachInHours,
              time_to_reach_in_minutes: this.goalStepTimeToReachInMinutes
            },
            this.userAuth['access-token'],
            this.userAuth['client'],
            this.userAuth['uid']
          )

          this.goalStepTitle = ""
          this.goalStepDescription = ""
          this.goalStepTimeToReachInDays = 0
          this.goalStepTimeToReachInHours = 0 
          this.goalStepTimeToReachInMinutes = 0 
          
        } catch(error) {
          this.failsToCreateGoalList = true
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
  