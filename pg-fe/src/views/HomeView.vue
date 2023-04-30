<template>
  <main class="base-container">
    <BaseCard>
      <template v-slot:header>
        <h3 class="title"> Perene Goals</h3>
      </template>
      <template v-slot:row>
          <input v-model="name" type="text" name="name" id="" placeholder="name">
          <input v-model="email" type="email" name="email" id="" placeholder="email">
          <input v-model="password" type="password" name="password" id="" placeholder="password">
          <button @click="handleCreateAccount">Sign Up</button>
      </template>
    </BaseCard>
  </main>
</template>

<script>
import BaseCard from '../components/BaseCard/index.vue'
import { createAccount } from '../api/account'

export default {
  name: "HomeView",
  components: {
    BaseCard
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
  color: var(--light-text-color) 
</style>
