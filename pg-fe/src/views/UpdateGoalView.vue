<template>
    <TopNavbar >
      <template v-slot:iconLeft>
        <SVGIcon icon-name="back"  @click="this.$router.go(-1)"/>
      </template>
      <template v-slot:iconRight>
        <SVGIcon icon-name="home" @click="this.$router.push('/')"/>
      </template>
    </TopNavbar>

    <main class="base-container">
      <h1 class="base-title"> Update Goal</h1>

      <BaseMessage  
        icon="warning" 
        :content="errorMessage" 
        :error="true" 
        :visibility="failsToUpdateGoal" 
        @hide="failsToUpdateGoal = false"
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
        
        <BaseInput 
          :value="`${goalStarted}`" 
          :checked="goalStarted"
          id="checkbox-1"
          @update:value="goalStarted = $event" 
          type="checkbox"
          label="Already Started"
        />  

        <BaseInput 
          v-if="goalStarted"
          :value="goalStartAt" 
          @update:value="goalStartAt = $event" 
          type="date"
          label="Goal started at"
        />

        <BaseInfo v-else>
          <template v-slot:content>
            <p>
              This Goal was not started yet, but remember, 
              every journey begins with a single step. 
              Stay focused, keep pushing forward, 
              and you'll soon accomplish great things!
            </p>
          </template>
        </BaseInfo>

        <BaseInput 
          :value="`${goalCompleted}`" 
          :checked="goalCompleted"
          id="checkbox-2"
          @update:value="goalCompleted = $event" 
          type="checkbox"
          label="Already Completed"
        />

        <BaseInput 
          v-if="goalCompleted"
          :value="goalCompletedAt" 
          @update:value="goalCompletedAt = $event" 
          type="date"
          label="Goal completed at"
        />

        <BaseInfo v-else>
          <template v-slot:content>
            <p>
              This Goal has not been completed yet. 
              Don't give up! Stay committed, embrace challenges, 
              and keep working towards it. Remember, 
              success is just around the corner!
            </p>
          </template>
        </BaseInfo>

        <BaseButton :dark="true" icon="save" content="Update Goal" :disabled="!nextStep" @click="handleUpdateGoal"/>
      </div> 
        
    </main>
    <BottomNavbar iconName="save" @click="handleUpdateGoal" :disabled="!nextStep"/>
  </template>
  
  <script>
  import TopNavbar from '../components/TopNavBar/index.vue'
  import BottomNavbar from '../components/BottomNavBar/index.vue'
  import BaseInput from '../components/BaseInput/index.vue'
  import BaseButton from '../components/BaseButton/index.vue'
  import BaseMessage from '../components/BaseMessage/index.vue'
  import SVGIcon from '../components/SVGIcon/index.vue'
  import BaseInfo from '../components/BaseInfo/index.vue'
  
  import { updateGoal, fetchGoalsWithSteps } from '../api/goals'

  import { formatDate } from '../utils/dateFormatter'

  export default {
    name: "UpdateGoalView",
    components: {
      TopNavbar,
      BottomNavbar,
      BaseInput,
      BaseButton,
      BaseMessage,
      BaseInfo,
      SVGIcon
    },
    data () {
      return {
        goalTitle: "",
        goalDescription: "",
        goalStarted: false,
        goalStartAt: "",
        goalCompleted: false,
        goalCompletedAt: "",
        goalTimeToReachInDays: "0",
        goalTimeToReachInHours: "0",
        goalTimeToReachInMinutes: "0",
        userAuth: {},
        routeId: "",
        failsToUpdateGoal: false,
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

      try {
        const { data } = await fetchGoalsWithSteps(
          this.routeId,
          this.userAuth['access-token'],
          this.userAuth['client'],
          this.userAuth['uid']
        )

        this.goalTitle = data.title
        this.goalDescription =  data.description
        this.goalTimeToReachInDays = `${data.time_to_reach_in_days}` || "0"
        this.goalTimeToReachInHours = `${data.time_to_reach_in_hours}` || "0"
        this.goalTimeToReachInMinutes = `${data.time_to_reach_in_minutes}` || "0"
        this.goalStarted = data.started
        this.goalStartAt = data.start_at ? await formatDate(data.start_at) : false
        this.goalCompleted = data.completed
        this.goalCompletedAt = data.completed_at ? await formatDate(data.completed_at) : false

      } catch(error) {
        console.error(error)
      }
    },
    async handleUpdateGoal() {
      try {
        this.failsToUpdateGoal = false
        await updateGoal(
          this.routeId,
          {
            title: this.goalTitle,
            description: this.goalDescription,
            time_to_reach_in_days: this.goalTimeToReachInDays,
            time_to_reach_in_hours: this.goalTimeToReachInHours,
            time_to_reach_in_minutes: this.goalTimeToReachInMinutes,
            start_at: this.goalStarted ? this.goalStartAt : null,
            started: this.goalStarted,
            completed_at: this.goalCompleted ? this.goalCompletedAt : null,
            completed: this.goalCompleted
          },
          this.userAuth['access-token'],
          this.userAuth['client'],
          this.userAuth['uid']
        )
        this.$router.go(-1)
      } catch(error) {
        console.log(error)
        this.failsToUpdateGoal = true
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
  