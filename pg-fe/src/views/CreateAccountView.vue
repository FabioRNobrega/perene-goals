<template>
  <TopNavbar iconNameLeft="user" iconNameRight="learning" />
  <main class="base-container">
    <BaseCard>
      <template v-slot:header>
        <h3 class="title"> Create Account </h3>
      </template>
      <template v-slot:row>
        <div v-if="success"> 
          <p class="footer">
            Thanks for the subscription, access your email <strong> {{ email }} </strong> and confirm account.
          </p>
          <p class="footer">
            To start achieving your goals today.
          </p>
        </div>
        <div v-else> 
          <BaseInput :value="name" @update:value="name = $event" type="text" name="name" placeholder="Name" />
          <BaseInput :value="email" @update:value="email = $event" type="email" name="email" placeholder="Email" />
          <BaseInput :value="password" @update:value="password = $event" type="password" name="password" placeholder="Password" :password-light="true"/>
          <BaseButton @click="handleCreateAccount" :light="true" icon="next" content="Create Account" />
          <p class="footer">
            Our just <BaseLink pathName="/login" content="Sign In"/> to start achieving your goals.
          </p> 
        </div>
      </template>
    </BaseCard>
  </main>
  <BottomNavbar />
</template>

<script>
import BaseCard from '../components/BaseCard/index.vue'
import TopNavbar from '../components/TopNavBar/index.vue'
import BottomNavbar from '../components/BottomNavBar/index.vue'
import BaseInput from '../components/BaseInput/index.vue'
import BaseButton from '../components/BaseButton/index.vue'
import BaseLink from '../components/BaseLink/index.vue'

import { createAccount } from '../api/account'

export default {
  name: "CreateAccountView",
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
      success: false,
      name: "",
      email: "",
      password: ""
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
          return this.success = true
        }
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

.footer
  color: var(--neutral-color-light)
  font-family: var(--font-family-base)
  text-align: center
</style>
