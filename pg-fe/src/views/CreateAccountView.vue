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
    <BaseMessage  icon="warning" :content="errorMessage" :error="true" :visibility="failsToCreateAccount" @hide="failsToCreateAccount = false"/>
    <BaseCard>
      <template v-slot:header>
        <h3 class="title"> Create Account </h3>
      </template>
      <template v-slot:row>
        <div v-if="success" style="text-align: center;"> 
          <p >
            Thanks for the subscription, access your email <strong class="link"> {{ email }} </strong> and confirm account.
          </p>
          <p>
            To start achieving your goals today.
          </p>
        </div>
        <div v-else> 
          <BaseInput :value="name" @update:value="name = $event" type="text" name="name" placeholder="Name" />
          <BaseInput :value="email" @update:value="email = $event" type="email" name="email" placeholder="Email" />
          <BaseInput :value="password" @update:value="password = $event" type="password" name="password" placeholder="Password" :password-light="true"/>
          <BaseButton @click="handleCreateAccount" :light="true" icon="next" content="Create Account" />
          <p style="text-align: center;">
            Our just <BaseLink pathName="/login" content="Sign In"/> to start achieving your goals.
          </p> 
        </div>
      </template>
    </BaseCard>
  </main>
  <BottomNavbar @click="handleBottomNavbarClick"/>
</template>

<script>
import BaseCard from '../components/BaseCard/index.vue'
import TopNavbar from '../components/TopNavBar/index.vue'
import BottomNavbar from '../components/BottomNavBar/index.vue'
import BaseInput from '../components/BaseInput/index.vue'
import BaseButton from '../components/BaseButton/index.vue'
import BaseLink from '../components/BaseLink/index.vue'
import SVGIcon from '../components/SVGIcon/index.vue'
import BaseMessage from '../components/BaseMessage/index.vue'


import { createAccount } from '../api/account'

export default {
  name: "CreateAccountView",
  components: {
    SVGIcon,
    BaseCard,
    TopNavbar,
    BottomNavbar,
    BaseInput,
    BaseButton,
    BaseLink,
    BaseMessage,
  },
  data () {
    return {
      success: false,
      name: "",
      email: "",
      password: "",
      failsToSignIn: false,
      errorMessage: ""
    }
  },
  methods: {
    async handleCreateAccount() {
      try {
        const { data } = await createAccount(
          {
            name: this.name,
            email: this.email,
            password: this.password,
            password_confirmation: this.password
          }
        )
        if (data.status == 'success') {
          this.failsToCreateAccount = false
          return this.success = true
        }
      } catch (error) {
        console.log(error.response.data)
        if (error.response && error.response.data && error.response.data.errors) {
          this.errorMessage = error.response.data.errors.full_messages[0]
          this.failsToCreateAccount = true
        } else {
          this.errorMessage = error
          this.failsToCreateAccount = true
        }
      }
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

.title
  font-weight: bold
  text-align: center
  font-family: var(--font-family-title)
  font-size: 35px
  color: var(--neutral-color-lighter) 

.link 
  font-family: var(--font-family-title)
  font-weight: bold
  color: var(--primary)
</style>
