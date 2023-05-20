<template>
  <TopNavbar iconNameLeft="user" iconNameRight="home" pathNameRight="/"/>
  <main class="base-container">
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
  </main>
  <BottomNavbar iconName="plus" />
</template>

<script>
import TopNavbar from '../components/TopNavBar/index.vue'
import BottomNavbar from '../components/BottomNavBar/index.vue'
import BaseInfo from '../components/BaseInfo/index.vue'

import { createAccount, signIn} from '../api/account'

export default {
  name: "CreateGoalsListView",
  components: {
    TopNavbar,
    BottomNavbar,
    BaseInfo,
  },
  data () {
    return {
      name: "",
      email: "",
      password: ""
    }
  },
  methods: {
    async handleCreateAccount() {
      try {
         await createAccount(
          {
            email: this.email,
            password: this.password, 
            password_confirmation: this.password,
            name: this.name
          }
        )

        const response = await signIn(
          {
            email: this.email,
            password: this.password
          }
        )

        const { access_token, client, uid } = response.headers;

        localStorage.setItem('user-auth', JSON.stringify({ 'access-token': access_token, 'client': client, 'uid': uid }));
      } catch (error) {
        console.error(error)
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
