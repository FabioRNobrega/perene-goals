<template>
    <TopNavbar iconNameLeft="user" iconNameRight="home" pathNameRight="/"/>
    <main class="base-container">
      <h1 class="base-title"> Create Goal Step</h1>
      <BaseInfo >
        <template v-slot:content>
          <p>
            A goals list is made up of specific goals that you can name, 
            describe, and set a deadline for in terms of days, hours, or 
            minutes. Breaking down a larger goal into smaller steps can 
            help make it easier to achieve and give you a sense of 
            accomplishment along the way. For more information, 
            visit our <a href="/learning"> learning section </a>.
          </p>
        </template>
      </BaseInfo>
    </main>
    <BottomNavbar iconName="save"/>
  </template>
  
  <script>
  import TopNavbar from '../components/TopNavBar/index.vue'
  import BottomNavbar from '../components/BottomNavBar/index.vue'
  import BaseInfo from '../components/BaseInfo/index.vue'
  
  import { createAccount, signIn} from '../api/account'
  
  export default {
    name: "CreateGoalStepView",
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
  