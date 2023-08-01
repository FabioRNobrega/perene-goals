<template>
  <TopNavbar >
    <template v-slot:iconLeft>
      <SVGIcon icon-name="user"  @click="this.$router.push('/profile')"/>
    </template>
    <template v-slot:iconRight>
      <SVGIcon icon-name="learning" @click="this.$router.push('/learning')"/>
    </template>
  </TopNavbar>
  
  <main class="base-container">
    <div class="hero">
      <img class="hero__logo" src="src/assets/logo/perene-goals.png"/>
      <BaseHero />
    </div>

    <h1 class="base-title title-space" style="margin-bottom: 0;"> My Goals List</h1>  
    <BaseButton v-if="myGoalsList == []" @click="handleCreateGoalList" :light="true" icon="plus" content="SET YOUR FIRST GOAL LIST" />
    <div class="base-list-display"> 
      <BaseCard v-for="goalList in myGoalsList" :key="goalList.title" >
        <template v-slot:header>
          <div class="goals-list__header"> 
            <h3 >{{ goalList.title }}</h3>
            <div class="goals-list__header--actions">
              <BaseButton :solidLight="true" :isIcon="true" icon="edit" @click="handleEditGoalList(goalList.id)"/>
              <BaseButton :solidLight="true" :isIcon="true" icon="remove" @click="handleDeleteGoalListModal(goalList.id)"/>
            </div> 
          </div>
        </template>
        <template v-slot:row>
          <p class="base-text-light">  {{ goalList.description }} </p>
          <BaseButton :light="true" icon="details" content="See goals list" @click="handleSeeGoalsList(goalList.id)"/>
        </template>
      </BaseCard>
    </div>

    <h1 id="publicLists" class="base-title title-space"> Public Goals List</h1>  
    <BaseMessage  icon="warning" :content="failsToCloneMessage" :error="true" :visibility="failsToClone" @hide="failsToClone = false"/>
    <div v-for="goalList in publicGoalsList" :key="goalList.title" class="goals-list">
      <BaseCard >
        <template v-slot:header>
          <div class="goals-list__header">
            <h3 >{{ goalList.title }}</h3>
            <BaseButton :solidLight="true" :isIcon="true" icon="copy" @click="handleClonePublicList(goalList.id)"/>
          </div>
        </template>
        <template v-slot:row>
          <p>  {{ goalList.description }} </p>
          <div class="goals-list__like">
            <div class="goals-list__like--content">
              <h5>  {{ goalList.likes || 10 }}  </h5> <SVGIcon icon-name="like" /> 
            </div> 
            <div class="goals-list__like--content">
              <h5> {{ goalList.dislikes || 0 }} </h5>  <SVGIcon icon-name="unlike" /> 
            </div> 
          </div> 
        </template>
      </BaseCard>
    </div>
    <BaseButton v-if="end" @click="backToTop('publicLists')" :light="true" icon="next" content="back to the top" />
    <BaseButton v-else @click="setData" :light="true" icon="next" content="load more goals list" />
  </main>

  <BaseModal 
    :showModal="showDeleteGoalListModal"
    content="By deleting this goal list, you'll also eliminate all its associated goals and their respective steps. Are you certain about this decision? Remember, every step forward is a step closer to your ultimate success!"
  >
    <template v-slot:footer>
      <BaseButton :light="true" :small="true" icon="close" content="cancel" @click="this.showDeleteGoalListModal = !this.showDeleteGoalListModal"/>
      <BaseButton :light="true" :small="true" icon="remove" content="confirm" @click="handleDeleteGoalList()"/>
    </template>
  </BaseModal>

  <BaseModal 
  :showModal="showClonePublicListModal"
  content="By cloning this public goals list, you'll create a new copy with all its associated goals and their respective steps. The new copy will belong to you and you can modify it freely. Cloning a public goals list allows you to use it as a starting point for your own journey towards success!"
  >
  <template v-slot:footer>
    <BaseButton :light="true" :small="true" icon="close" content="cancel" @click="this.showClonePublicListModal = !this.showClonePublicListModal"/>
    <BaseButton :light="true" :small="true" icon="remove" content="confirm" @click="clonePublicList()"/>
  </template>
  </BaseModal>

  <BottomNavbar iconName="plus"  @click="handleBottomNavbarClick" />
</template>


<script>
import TopNavbar from '../components/TopNavBar/index.vue'
import BottomNavbar from '../components/BottomNavBar/index.vue'
import BaseButton from '../components/BaseButton/index.vue'
import BaseCard from '../components/BaseCard/index.vue'
import SVGIcon from '../components/SVGIcon/index.vue'
import BaseHero from '../components/BaseHero/index.vue'
import BaseModal from '../components/BaseModal/index.vue'
import BaseMessage from '../components/BaseMessage/index.vue'



import { goalsListPublic, goalsListPrivate, deleteGoalsList, cloneGoalsList } from '../api/goals-list'

export default {
  name: "HomeView",
  components: {
    TopNavbar,
    BaseCard,
    BaseHero,
    BottomNavbar,
    BaseButton,
    SVGIcon,
    BaseModal,
    BaseMessage
  },
  data () {
    return {
      publicGoalsList: [],
      myGoalsList: [],
      page: 1,
      end: false,
      userAuth: {},
      goal_list_id: "",
      public_list_id: "",
      showDeleteGoalListModal: false,
      showClonePublicListModal: false,
      failsToClone: false,
      failsToCloneMessage: ""
    }
  },
  created() {
    this.setData()
  },
  methods: {
    async setData() {
      this.userAuth = JSON.parse(localStorage.getItem('user-auth'))

      if(this.userAuth != null) {
        this.getMyGoalsLists()
      }

      try {
        const { data } = await goalsListPublic(this.page)
        if(data.meta) {
          this.end = true
          return
        } else {
          this.publicGoalsList = this.publicGoalsList.concat(data)
          this.page = this.page + 1
        }
      } catch(error) {
        console.error(error)
      }
    },
    async getMyGoalsLists() {
      try {
        const { data } = await goalsListPrivate(
          this.userAuth['access-token'],
          this.userAuth['client'],
          this.userAuth['uid']
        )
        this.myGoalsList = data
      } catch(error) {
        console.error(error)
      }
    },
    async handleDeleteGoalList() {
      try {
        await deleteGoalsList(
          this.goal_list_id,
          this.userAuth['access-token'],
          this.userAuth['client'],
          this.userAuth['uid']
        )
        this.setData()
        this.showDeleteGoalListModal = false
      } catch(error) {
        console.error(error)
      }
    },
    backToTop(id) {
      const element = document.getElementById(id);
      if (element) {
        element.scrollIntoView({ behavior: 'smooth' });
      }
    },
    handleDeleteGoalListModal(goal_list_id) {
      this.goal_list_id = goal_list_id
      this.showDeleteGoalListModal = !this.showDeleteGoalListModal
    },
    handleCreateGoalList() {
      this.$router.push('/create-goals-list')
    },
    handleBottomNavbarClick() {
      this.$router.push('/create-goals-list')
    },
    handleSeeGoalsList(id) {
      this.$router.push(`/goals-list/${id}`)
    },
    handleEditGoalList(goal_list_id) {
      this.$router.push(`/update-goals-list/${goal_list_id}`)
    },
    handleClonePublicList(public_list_id) {
      this.public_list_id = public_list_id
      this.showClonePublicListModal = true
    },
    async clonePublicList() {
      try {
       const { data } = await cloneGoalsList(
          this.public_list_id,
          this.userAuth['access-token'],
          this.userAuth['client'],
          this.userAuth['uid']
        )
        this.showClonePublicListModal = false
        this.$router.push(`/goals-list/${data.new_list.id}?success=true`)
      } catch (error) {
        this.failsToCloneMessage = error.response.data.error
        this.failsToClone =  true
        this.showClonePublicListModal = false
      }
    }
  }
}

</script>

<style lang="sass">
@import "../assets/main"
@import "../assets/_variables"
@import "../assets/_mixins"

.hero 
 @include display-col 
 justify-content: center

 &__logo
  width: 112px
  margin: -50px auto 10px auto

 &__banner
  border-radius: 5px
  width: 100%
  margin: 0px auto 10px auto
  @include tablets-and-up
    height: 300px
    object-fit: cover

.goals-list
  margin: 20px 0

  &__header
    @include display-row
    justify-content: space-between
    align-items: center

    & h3
      width: 70%

    &--actions 
      @include display-row
      justify-content: space-around
      color: var(--primary)
      width: 30%
      @include tablets-and-up
        width: 20%

  &__like 
    @include display-row
    justify-content: end

    &--content
      @include display-row
      align-items: center
      justify-content: space-around
      margin-top: 30px

      & h5 
        font-family: var(--font-family-base)
        color: var(--neutral-color-light)
        font-weight: 700
        font-size: 17px
        margin: 5px 5px 0 10px
      
      & .svg-icon
        color: var(--primary)





</style>
