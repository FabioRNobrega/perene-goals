<template>
  <TopNavbar iconNameLeft="user" iconNameRight="learning" />
  <main class="base-container">
    <h4> Create Goals List</h4>
  </main>
  <BottomNavbar iconName="plus" />
</template>

<script>
import TopNavbar from '../components/TopNavBar/index.vue'
import BottomNavbar from '../components/BottomNavBar/index.vue'

import { createAccount, signIn} from '../api/account'

export default {
  name: "CreateGoalsListView",
  components: {
    TopNavbar,
    BottomNavbar,
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

        console.log(response)
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
