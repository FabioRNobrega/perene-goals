<template>
    <TopNavbar iconNameLeft="user" iconNameRight="home" pathNameRight="/"/>
    <main class="base-container">
      <h1 class="base-title"> Create Goal Step</h1>
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
      <form> 
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
          :error="goalDescriptionError"
          :error-message="goalDescriptionErrorMessage"
        />
        <BaseInput 
          :value="goalTimeToReachInHours" 
          @update:value="goalTimeToReachInHours = $event" 
          type="number"
          min="0"
          max="24"
          label="Time to Achieve in hours"
          :error="goalDescriptionError"
          :error-message="goalDescriptionErrorMessage"
        />
        <BaseInput 
          :value="goalTimeToReachInMinutes" 
          @update:value="goalTimeToReachInMinutes = $event" 
          type="number"
          min="0"
          max="60"
          label="Time to Achieve in minutes"
          :error="goalDescriptionError"
          :error-message="goalDescriptionErrorMessage"
        />
        <BaseButton :light="true" icon="next" content="Add one step for achieve your goal" />
        <BaseButton :light="true" icon="plus" content="Add Another goal on this list" />
        <BaseButton :dark="true" icon="save" content="Save Goal" />
      </form> 
        
    </main>
    <BottomNavbar iconName="save" @click="handleCreateGoal"/>
  </template>
  
  <script>
  import TopNavbar from '../components/TopNavBar/index.vue'
  import BottomNavbar from '../components/BottomNavBar/index.vue'
  import BaseInfo from '../components/BaseInfo/index.vue'
  import BaseInput from '../components/BaseInput/index.vue'
  import BaseButton from '../components/BaseButton/index.vue'
  
  import { createGoal } from '../api/goals'

  export default {
    name: "CreateGoalView",
    components: {
      TopNavbar,
      BottomNavbar,
      BaseInfo,
      BaseInput,
      BaseButton
    },
    data () {
      return {
        goalTitle: "",
        goalDescription: "",
        goalTimeToReachInDays: 0,
        goalTimeToReachInHours: 0,
        goalTimeToReachInMinutes: 0,
        userAuth: {},
        routeId: ""
      }
    },
    created() {
    this.setData()
    },
    methods: {
      async setData () {
      this.userAuth = JSON.parse(localStorage.getItem('user-auth'))
      this.routeId = this.$route.params.id;
    },
      async handleCreateGoal() {
      try {
        this.failsToCreateGoalList = false
        this.successUpdated = false
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
        console.log(data)
        this.$router.push(`/`)
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
  