<template>
  <TopNavbar iconNameLeft="user" iconNameRight="learning" />
  <main class="base-container">
    <BaseCard>
      <template v-slot:header>
        <h3 class="title"> Sign In</h3>
      </template>
      <template v-slot:row>
        <div v-if="forgotPassword">   
          <div v-if="successSendForgetPassword"> 
            <div class="footer" style="justify-content: center;">
              <p>
                A email was send to <strong> {{ this.email }} </strong> with instruction to reset password.
              </p>
            </div>
          </div>
          <div v-else>
            <BaseInput :value="email" @update:value="email = $event" type="email" name="email" placeholder="email" />
            <BaseButton @click="handleForgotPassword" :light="true" icon="next" content="Recover Password" />
            <p class="footer">
              <a @click="toggleForgetPassword" >Sign In?</a>
            </p>
          </div>
        </div>
        <div v-else> 
          <BaseInput :value="email" @update:value="email = $event" type="email" name="email" placeholder="email" />
          <BaseInput :value="password" @update:value="password = $event" type="password" name="password" placeholder="password" :password-light="true"/>
          <BaseButton @click="handleSignIn" :light="true" icon="next" content="Sign In" />
          <div class="footer">
            <p>
              Our <BaseLink pathName="/create-account" content="Create Account"/> to start achieving your goals.
            </p>
            <a @click="toggleForgetPassword" >Forget password?</a>
          </div>
        </div>
      </template>
    </BaseCard>
  </main>
  <BottomNavbar  @click="handleBottomNavbarClick"/>
</template>

<script>
import BaseCard from '../components/BaseCard/index.vue'
import TopNavbar from '../components/TopNavBar/index.vue'
import BottomNavbar from '../components/BottomNavBar/index.vue'
import BaseInput from '../components/BaseInput/index.vue'
import BaseButton from '../components/BaseButton/index.vue'
import BaseLink from '../components/BaseLink/index.vue'

import { signIn, forgetPassword } from '../api/account'

export default {
  name: "SignInView",
  components: {
    BaseCard,
    TopNavbar,
    BottomNavbar,
    BaseInput,
    BaseButton,
    BaseLink
  },
  data () {
    return {
      email: "",
      password: "",
      forgotPassword: false,
      successSendForgetPassword: false
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
        const { 'access-token': access_token, client, uid } = response.headers
        const { name, email, first_login} = response.data.data

        localStorage.setItem('user-auth', JSON.stringify({ 'access-token': access_token, 'client': client, 'uid': uid }))
        localStorage.setItem('user-profile', JSON.stringify({ 'name': name, 'email': email, 'first_login': first_login }))
        this.$router.push('/')
      } catch (error) {
        console.error(error)
      }
    },
    async handleForgotPassword() {
      try {
        forgetPassword({ email: this.email})
        this.successSendForgetPassword = true
      } catch(error) {
        console.error(error)
      }
    },
    toggleForgetPassword() {
      return this.forgotPassword = !this.forgotPassword
    },
    handleBottomNavbarClick() {
      this.$router.push('/')
    }
  }
}

</script>

<style lang="sass">
@import "../assets/main"
@import "../assets/_variables"
@import "../assets/_mixins"

.title
  font-weight: bold
  text-align: center
  font-family: var(--font-family-title)
  font-size: 35px
  color: var(--neutral-color-lighter) 

.footer
  color: var(--neutral-color-light)
  font-family: var(--font-family-base)
  @include display-row
  justify-content: space-between
  align-items: center

  & strong, a
   font-family: var(--font-family-title)
   color: var(--primary)

  & a:hover
    color: var(--primary-light)

</style>
