 <template>
    <TopNavbar iconNameLeft="user" iconNameRight="exit" pathNameRight="/" />
    <main class="base-container">
      <BaseMessage  icon="success" content="Profile updated with success" :success="true" :visibility="successUpdated" @hide="successUpdated = false"/>
      <BaseMessage  icon="warning" :content="errorMessage" :error="true" :visibility="failsToUpdate" @hide="failsToUpdate = false"/>
      <div class="title">
          <h1> Profile</h1>
          <BaseButton icon="edit" :isIcon="true" :solid="true" @click="handleEditName"/>
      </div>
      <div style="margin-bottom: 40px"> 
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
        <BaseInput 
          :value="current_password" 
          @update:value="current_password = $event" 
          type="password" placeholder="Current Password" 
          :password-dark="true"
          :error="currentPasswordError"
          :error-message="currentPasswordErrorMessage"
        />
        <BaseInput 
          :value="password" 
          @update:value="password = $event" 
          type="password"
          placeholder="New Password"
          :password-dark="true"
          :error="passwordError"
          :error-message="passwordErrorMessage"
        />
        <BaseInput 
          :value="password_confirmation"
          @update:value="password_confirmation = $event"
          type="password"
          placeholder="Confirm New Password"
          :password-dark="true"
          :error="passwordConfirmationError"
          :error-message="passwordConfirmationErrorMessage"
        />
        <BaseButton icon="next" :light="true" content="Save Change" @click="handleUpdatePassword"/>
      </div>
    </main>
    <BottomNavbar @click="handleBottomNavbarClick"/>
  </template>
  
  <script>
  import TopNavbar from '../components/TopNavBar/index.vue'
  import BottomNavbar from '../components/BottomNavBar/index.vue'
  import BaseButton from '../components/BaseButton/index.vue'
  import BaseInput from '../components/BaseInput/index.vue'
  import BaseMessage from '../components/BaseMessage/index.vue'
  
  import { updateAccount } from '../api/account'
  
  export default {
    name: "UserProfileView",
    components: {
      TopNavbar,
      BottomNavbar,
      BaseButton,
      BaseInput,
      BaseMessage
    },
    data () {
      return {
        successUpdated: false,
        failsToUpdate: false,
        errorMessage: "",
        name: "",
        email: "",
        current_password: "",
        password: "",
        password_confirmation: "",
        edit: false,
        userAuth: {},
        currentPasswordError: false,
        currentPasswordErrorMessage: "",
        passwordError: false,
        passwordErrorMessage: "",
        passwordConfirmationError: false,
        passwordConfirmationErrorMessage: ""
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
        this.userAuth = JSON.parse(localStorage.getItem('user-auth'));

        this.name = userProfile.name
        this.email = userProfile.email
      },
      async handleUpdateName() {
        try {
          this.failsToUpdate = false
          this.successUpdated = false
           const response = await updateAccount(
            {
              name: this.name
            },
            this.userAuth['access-token'],
            this.userAuth['client'],
            this.userAuth['uid']
          )
  
          const { name, email, first_login} = response.data.data

          localStorage.setItem('user-profile', JSON.stringify({ 'name': name, 'email': email, 'first_login': first_login }))
          this.edit = false
          this.successUpdated = true
        } catch (error) {
          this.errorMessage = error
          this.failsToUpdate = true
        }
      },
      async handleUpdatePassword() {
        try {
          this.failsToUpdate = false
          this.successUpdated = false

          await updateAccount(
            {
              password: this.password,
              current_password: this.current_password,
              password_confirmation: this.password_confirmation
            },
            this.userAuth['access-token'],
            this.userAuth['client'],
            this.userAuth['uid']
          );
          this.currentPasswordError = false
          this.currentPasswordErrorMessage = ""
          this.passwordConfirmationError = false
          this.passwordConfirmationErrorMessage = ""
          this.passwordError =  false
          this.passwordErrorMessage = ""
          this.successUpdated = true

        } catch (error) {
          if (error.response && error.response.data && error.response.data.errors) {
            const {current_password, password, password_confirmation} = error.response.data.errors;
            if (current_password) {
              this.currentPasswordError = true
              this.currentPasswordErrorMessage = current_password[0]
            } else {
              this.currentPasswordError = false
              this.currentPasswordErrorMessage = ""
            }

            if (password) {
              this.passwordError =  true
              this.passwordErrorMessage = password[0]
            } else {
              this.passwordError =  false
              this.passwordErrorMessage = ""
            }

            if(password_confirmation) {
              this.passwordConfirmationError = true
              this.passwordConfirmationErrorMessage = password_confirmation[0]
            } else {
              this.passwordConfirmationError = false
              this.passwordConfirmationErrorMessage = ""
            }
          } else {
            this.errorMessage = error
            this.failsToUpdate = true
          }
        }
      },
      handleBottomNavbarClick() {
        this.$router.push('/')
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
  