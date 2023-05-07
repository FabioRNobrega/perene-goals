<template>
  <TopNavbar iconNameLeft="user" iconNameRight="learning" />
  <main class="base-container">
    <BaseCard>
      <template v-slot:header>
        <h3 class="title"> Perene Goals</h3>
      </template>
      <template v-slot:row>
          <BaseInput v-model="name" type="text" placeholder="name" />
          <BaseInput v-model="email" type="email" name="email" id="" placeholder="email" />
          <BaseInput v-model="password" type="password" name="password" id="" placeholder="password" />
          <BaseButton @click="handleCreateAccount" :light="true" icon="next" content="Sign Up" />
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

import { createAccount } from '../api/account'

export default {
  name: "HomeView",
  components: {
    BaseCard,
    TopNavbar,
    BottomNavbar,
    BaseInput,
    BaseButton
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
      console.log("entrou aqui")
      try {
        const { data } = await createAccount(
          {
            email: this.email,
            password: this.password, 
            password_confirmation: this.password,
            name: this.name
          }
        )
        console.log(data)
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
