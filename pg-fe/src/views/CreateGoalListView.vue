<template>
  <TopNavbar >
    <template v-slot:iconLeft>
      <SVGIcon icon-name="user"  @click="this.$router.push('/profile')"/>
    </template>
    <template v-slot:iconRight>
      <SVGIcon icon-name="home" @click="this.$router.push('/')"/>
    </template>
  </TopNavbar>

  <main class="base-container">
    <BaseMessage  
      icon="warning" 
      :content="errorMessage" 
      :error="true" 
      :visibility="failsToCreateGoalList" 
      @hide="failsToCreateGoalList = false"
    />
    <h1 class="base-title"> Create Goals List</h1>
    <BaseInfo >
      <template v-slot:content>
        <p>
          A goals list is an effective tool to help you set 
          and achieve your goals. For instance, if you want 
          to read more books, create a list of specific goals, 
          such as the number of books to read per month or year. 
          This will help you organize your ideas and keep track 
          of the books you want to read, making it easier to 
          accomplish your goal.
        </p>
      </template>
    </BaseInfo>
    <div>      
      <BaseInput 
        :value="listName" 
        @update:value="listName = $event" 
        type="text"
        placeholder="List Name"
        :error="listNameError"
        :error-message="listNameErrorMessage"
      />
      <BaseInput 
        :value="listDescription" 
        @update:value="listDescription = $event" 
        type="text"
        placeholder="List description"
        :error="listDescriptionError"
        :error-message="listDescriptionErrorMessage"
      />
      <BaseInput 
        :value="`${isPublic}`" 
        :checked="isPublic"
        id="checkbox-1"
        @update:value="isPublic = $event" 
        type="checkbox"
        label="Is Public"
      />  
    </div>
  </main>
  <BottomNavbar iconName="next" @click="handleCreateGoalsList" :disabled="!nextStep"/>
</template>

<script>
import TopNavbar from '../components/TopNavBar/index.vue'
import BottomNavbar from '../components/BottomNavBar/index.vue'
import BaseInfo from '../components/BaseInfo/index.vue'
import BaseInput from '../components/BaseInput/index.vue'
import BaseMessage from '../components/BaseMessage/index.vue'
import SVGIcon from '../components/SVGIcon/index.vue'

import { createGoalsList } from '../api/goals-list'

export default {
  name: "CreateGoalsListView",
  components: {
    SVGIcon,
    TopNavbar,
    BottomNavbar,
    BaseInfo,
    BaseInput,
    BaseMessage
  },
  data () {
    return {
      listName: "",
      listDescription: "",
      isPublic: false,
      userAuth: {},
      failsToCreateGoalList: false,
      errorMessage: "",
      listDescriptionErrorMessage: "",
      listDescriptionError: false,
      listNameErrorMessage: "",
      listNameError: false
    }
  },
  created() {
    this.setData()
  },
  computed: {
    nextStep() {  
      return this.listName != "" && this.listDescription != ""
    }
  },
  methods: {
    async setData () {
      this.userAuth = JSON.parse(localStorage.getItem('user-auth'))
    },
    async handleCreateGoalsList() {
      if(this.nextStep) {
        try {
          this.failsToCreateGoalList = false
          this.successUpdated = false
          const { data } = await createGoalsList(
            {
              title: this.listName,
              description: this.listDescription,
              is_public: this.isPublic
            },
            this.userAuth['access-token'],
            this.userAuth['client'],
            this.userAuth['uid']
          )
          this.$router.push(`/create-goal/${data.id}`)
        } catch(error) {
          this.failsToCreateGoalList = true
          this.errorMessage =  this.errorMessage = `${error}`
        }
      } else {
        this.listDescriptionErrorMessage = "Can't be blank",
        this.listDescriptionError = true,
        this.listNameErrorMessage = "Can't be blank",
        this.listNameError = true
      }
    }
  }
}

</script>

<style lang="sass">
@import "../assets/main"
@import "../assets/_variables"

</style>
