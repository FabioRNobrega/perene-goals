<template>
  <TopNavbar iconNameLeft="user" iconNameRight="learning" />
  <main class="base-container">
    <BaseCard>
      <template v-slot:header>
        <h3 class="title"> Sign In</h3>
      </template>
      <template v-slot:row>
        <BaseInput :value="email" @update:value="email = $event" type="email" name="email" placeholder="email" />
        <BaseInput :value="password" @update:value="password = $event" type="password" name="password" placeholder="password" />
        <BaseButton @click="handleSignIn" :light="true" icon="next" content="Sign In" />
        <RouterLink to="/create-account">Create Account</RouterLink>
      </template>
    </BaseCard>
  </main>
  <BottomNavbar iconName="plus" />
</template>

<script>
import BaseCard from '../components/BaseCard/index.vue'
import TopNavbar from '../components/TopNavBar/index.vue'
import BottomNavbar from '../components/BottomNavBar/index.vue'
import BaseInput from '../components/BaseInput/index.vue'
import BaseButton from '../components/BaseButton/index.vue'

import { signIn} from '../api/account'

export default {
  name: "SignInView",
  components: {
    BaseCard,
    TopNavbar,
    BottomNavbar,
    BaseInput,
    BaseButton
  },
  data () {
    return {
      email: "",
      password: ""
    }
  },
  methods: {
    async handleSignIn() {
      try {
        const response = await signIn(
          {
            email: this.email,
            password: this.password
          }
        )
        console.log(response.headers)
        const { access_token, client, uid } = response.headers

        localStorage.setItem('user-auth', JSON.stringify({ 'access-token': access_token, 'client': client, 'uid': uid }))
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
