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
      <h1 class="base-title"> Update Goal Step</h1>

      <BaseMessage  
        icon="warning" 
        :content="errorMessage" 
        :error="true" 
        :visibility="failsToUpdateGoal" 
        @hide="failsToUpdateGoal = false"
      />
      
      <div> 
        <BaseInput 
          :value="goalStepTitle" 
          @update:value="goalStepTitle = $event" 
          type="text"
          placeholder="Goal step title"
          :error="goalStepTitleError"
          :error-message="goalStepTitleErrorMessage"
        />
        <BaseInput 
          :value="goalStepDescription" 
          @update:value="goalStepDescription = $event" 
          type="text"
          placeholder="Goal step description"
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
        />
        <BaseInput 
          :value="goalStepTimeToReachInHours" 
          @update:value="goalStepTimeToReachInHours = $event" 
          type="number"
          min="0"
          max="24"
          label="Time to Achieve in hours"
        />

        <BaseInput 
          :value="goalStepTimeToReachInMinutes" 
          @update:value="goalStepTimeToReachInMinutes = $event" 
          type="number"
          min="0"
          max="60"
          label="Time to Achieve in minutes"
        />
        
        <BaseInput 
          :value="`${goalStepStarted}`" 
          :checked="goalStepStarted"
          id="checkbox-1"
          @update:value="goalStepStarted = $event" 
          type="checkbox"
          label="Already Started"
        />  

        <BaseInput 
          v-if="goalStepStarted"
          :value="goalStepStartAt" 
          @update:value="goalStepStartAt = $event" 
          type="date"
          label="Goal step started at"
        />

        <BaseInfo v-else>
          <template v-slot:content>
            <p>
              This Goal step was not started yet, but remember, 
              every journey begins with a single step. 
              Stay focused, keep pushing forward, 
              and you'll soon accomplish great things!
            </p>
          </template>
        </BaseInfo>

        <BaseInput 
          :value="`${goalStepCompleted}`" 
          :checked="goalStepCompleted"
          id="checkbox-2"
          @update:value="goalStepCompleted = $event" 
          type="checkbox"
          label="Already Completed"
        />

        <BaseInput 
          v-if="goalStepCompleted"
          :value="goalStepCompletedAt" 
          @update:value="goalStepCompletedAt = $event" 
          type="date"
          label="Goal step completed at"
        />

        <BaseInfo v-else>
          <template v-slot:content>
            <p>
              This Goal step has not been completed yet. 
              Don't give up! Stay committed, embrace challenges, 
              and keep working towards it. Remember, 
              success is just around the corner!
            </p>
          </template>
        </BaseInfo>

        <BaseButton :dark="true" icon="save" content="Update Goal Step" :disabled="!nextStep" @click="handleUpdateGoalStep"/>
      </div> 
        
    </main>
    <BottomNavbar iconName="save" @click="handleUpdateGoalStep" :disabled="!nextStep"/>
  </template>
  
  <script>
  import TopNavbar from '../components/TopNavBar/index.vue'
  import BottomNavbar from '../components/BottomNavBar/index.vue'
  import BaseInput from '../components/BaseInput/index.vue'
  import BaseButton from '../components/BaseButton/index.vue'
  import BaseMessage from '../components/BaseMessage/index.vue'
  import SVGIcon from '../components/SVGIcon/index.vue'
  import BaseInfo from '../components/BaseInfo/index.vue'
  
  import { updateGoalStep, fetchGoalStep } from '../api/goals-steps'

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
        goalStepTitle: "",
        goalStepDescription: "",
        goalStepStarted: false,
        goalStepStartAt: "",
        goalStepCompleted: false,
        goalStepCompletedAt: "",
        goalStepTimeToReachInDays: "0",
        goalStepTimeToReachInHours: "0",
        goalStepTimeToReachInMinutes: "0",
        userAuth: {},
        routeId: "",
        failsToUpdateGoal: false,
        errorMessage: "",
        goalStepTitleError: false,
        goalStepTitleErrorMessage: "",
        goalStepDescriptionError: false,
        goalStepDescriptionErrorMessage: ""
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

      try {
        const { data } = await fetchGoalStep(
          this.routeId,
          this.userAuth['access-token'],
          this.userAuth['client'],
          this.userAuth['uid']
        )

        this.goalStepTitle = data.title
        this.goalStepDescription =  data.description
        this.goalStepTimeToReachInDays = `${data.time_to_reach_in_days}` || "0"
        this.goalStepTimeToReachInHours = `${data.time_to_reach_in_hours}` || "0"
        this.goalStepTimeToReachInMinutes = `${data.time_to_reach_in_minutes}` || "0"
        this.goalStepStarted = data.started
        this.goalStepStartAt = data.start_at ? await formatDate(data.start_at) : false
        this.goalStepCompleted = data.completed
        this.goalStepCompletedAt = data.completed_at ? await formatDate(data.completed_at) : false

      } catch(error) {
        console.error(error)
      }
    },
    async handleUpdateGoalStep() {
      try {
        this.failsToUpdateGoal = false
        await updateGoalStep(
          this.routeId,
          {
            title: this.goalStepTitle,
            description: this.goalStepDescription,
            time_to_reach_in_days: this.goalStepTimeToReachInDays,
            time_to_reach_in_hours: this.goalStepTimeToReachInHours,
            time_to_reach_in_minutes: this.goalStepTimeToReachInMinutes,
            start_at: this.goalStepStarted ? this.goalStepStartAt : null,
            started: this.goalStepStarted,
            completed_at: this.goalStepCompleted ? this.goalStepCompletedAt : null,
            completed: this.goalStepCompleted
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
  