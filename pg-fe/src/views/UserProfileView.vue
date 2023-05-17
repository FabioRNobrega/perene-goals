 <template>
    <TopNavbar iconNameLeft="user" iconNameRight="learning" />
    <main class="base-container">
      <div class="title">
          <h1> Profile</h1>
          <BaseButton icon="edit" :isIcon="true" :solid="true" @click="handleEditName"/>
      </div>
      <div> 
        <div v-if="edit">
          <BaseInput :value="name" @update:value="name = $event" type="text" name="name" placeholder="Name" />
          <BaseButton icon="next" :light="true" content="Save Change" @click="handleUpdateName"/>
        </div>
        <div v-else >
          <h4 class="content"> <strong> Name: </strong> {{ name  }}</h4>
          <h4 class="content"><strong> Email: </strong>  {{ email }} </h4>
        </div>
      </div>
      <div class="title">
          <h1> Change Password</h1>
      </div>
      <div> 
        <BaseInput :value="password" @update:value="password = $event" type="password" placeholder="New Password" />
        <BaseInput :value="confirm_password" @update:value="confirm_password = $event" type="password" placeholder="Confirm New Password" />
        <BaseButton icon="next" :light="true" content="Save Change" @click="handleUpdatePassword"/>
      </div>
    </main>
    <BottomNavbar />
  </template>
  
  <script>
  import TopNavbar from '../components/TopNavBar/index.vue'
  import BottomNavbar from '../components/BottomNavBar/index.vue'
  import BaseButton from '../components/BaseButton/index.vue'
  import BaseInput from '../components/BaseInput/index.vue'
  
  import { createAccount, signIn} from '../api/account'
  
  export default {
    name: "UserProfileView",
    components: {
      TopNavbar,
      BottomNavbar,
      BaseButton,
      BaseInput
    },
    data () {
      return {
        name: "",
        email: "",
        password: "",
        confirm_password: "",
        edit: false
      }
    },
    created() {
        this.setData()
    },

    methods: {
      handleEditName() {
        return this.edit = !this.edit
      },
      async setData () {
        const userProfile = JSON.parse(localStorage.getItem('user-profile'));
        this.name = userProfile.name
        this.email = userProfile.email
      },
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
  
  <style lang="sass" scoped>
  @import "../assets/main"
  @import "../assets/_variables"
  @import "../assets/_mixins"
  
  .title
    font-weight: bold
    font-family: var(--font-family-title)
    font-size: 20px
    color: var(--secondary) 
    @include display-row
    align-items: center
    justify-content: space-between
  
  .content
    margin: 10px 0
    font-size: 14px
    font-family: var(--font-family-base)
    & strong
      font-size: 18px
      font-family: var(--font-family-title)
     
    

  </style>
  