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
    <BaseMessage  
      icon="warning" 
      :content="errorMessage" 
      :error="true" 
      :visibility="failsToUpdateGoalList" 
      @hide="failsToUpdateGoalList = false"
    />
    <h1 class="base-title"> Update Goals List</h1>
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

      <BaseInfo v-if="isPublic">
        <template v-slot:content>
          <p>
            This goal list is publicly available! 
            Share your achievements, inspire others, 
            and let's accomplish great things together. 
            Remember that support and collaboration 
            can drive your progress. Stay focused,
            persist, and make it happen!
          </p>
        </template>
      </BaseInfo>

      <BaseInfo v-else>
        <template v-slot:content>
          <p>
            This goal list is currently private. 
            Stay focused on your goals and work 
            diligently to achieve them. Remember 
            that every step towards your goals is 
            valuable and meaningful. Believe in 
            yourself, stay motivated, and become 
            the best version of yourself!
          </p>
        </template>
      </BaseInfo>
    </div>
  </main>
  <BottomNavbar iconName="save" @click="handleUpdateGoalsList" :disabled="!nextStep"/>
</template>

<script>
import TopNavbar from '../components/TopNavBar/index.vue'
import BottomNavbar from '../components/BottomNavBar/index.vue'
import BaseInfo from '../components/BaseInfo/index.vue'
import BaseInput from '../components/BaseInput/index.vue'
import BaseMessage from '../components/BaseMessage/index.vue'
import SVGIcon from '../components/SVGIcon/index.vue'

import { fetchGoalsList, updateGoalsList } from '../api/goals-list'

export default {
  name: "UpdateGoalsListView",
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
      routeId: "",
      failsToUpdateGoalList: false,
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
      this.routeId = this.$route.params.id;

      try {
        const { data } = await fetchGoalsList(
          this.routeId,
          this.userAuth['access-token'],
          this.userAuth['client'],
          this.userAuth['uid']
        )

        this.listName = data.title
        this.listDescription = data.description
        this.isPublic = data.is_public

      } catch (error) {
        console.error(error)
      }
    },
    async handleUpdateGoalsList() {
      if(this.nextStep) {
        try {
          this.failsToUpdateGoalList = false
          this.successUpdated = false
          await updateGoalsList(
            this.routeId,
            {
              title: this.listName,
              description: this.listDescription,
              is_public: this.isPublic
            },
            this.userAuth['access-token'],
            this.userAuth['client'],
            this.userAuth['uid']
          )
          this.$router.push(`/`)
        } catch(error) {
          this.failsToUpdateGoalList = true
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
