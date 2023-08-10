<template>
  <div class="confirm">
    <p v-if="success" class="confirm__text">  
       Your password was changed with success. Please <RouterLink  to="/login" class="confirm__link"> login </RouterLink> with your new password and start to achieve your goals today.
     </p>
    <div v-else class="base-container">
        <BaseMessage  icon="warning" :content="errorMessage" :error="true" :visibility="failsToResetPassword" @hide="failsToResetPassword = false"/>
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
        <BaseButton icon="next" :light="true" content="Save Change" @click="handleResetPassword"/>
    </div>
 
    </div>
</template>

<script>
import BaseButton from '../components/BaseButton/index.vue'
import BaseInput from '../components/BaseInput/index.vue'
import BaseMessage from '../components/BaseMessage/index.vue'


import { resetPassword }  from '../api/account'

export default {
    name: "ResetPasswordView",
    components: {
        BaseButton,
        BaseInput,
        BaseMessage
    },
    data() {
        return {
            resetToken: "",
            success: false,
            failsToResetPassword: false,
            errorMessage: "",
            userAuth: {},
            password: "",
            password_confirmation: "",
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
        async setData () {
            this.userAuth = {
                'access-token': this.$route.query['access-token'],
                'client': this.$route.query['client'],
                'uid':this.$route.query['uid']
            }
        },
        async handleResetPassword() {
        try {
          this.failsToResetPassword = false
          this.success = false

          await resetPassword(
            {
              password: this.password,
              password_confirmation: this.password_confirmation
            },
            this.userAuth['access-token'],
            this.userAuth['client'],
            this.userAuth['uid']
          );
          this.passwordConfirmationError = false
          this.passwordConfirmationErrorMessage = ""
          this.passwordError =  false
          this.passwordErrorMessage = ""
          this.success = true

        } catch (error) {
          if (error.response && error.response.data && error.response.data.errors) {
            const {password, password_confirmation} = error.response.data.errors;

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
            this.failsToResetPassword = true
          }
        }
      },
    }

}
</script>

<style lang="sass">
@import "../assets/_variables"
@import "../assets/main"

.confirm 
  margin: auto
  font-family: var(--font-family-base)

  &__text
    text-align: center
    color: var(--secondary-dark)
    padding: 20px
    margin-top: 45vh

  &__link 
    font-family: var(--font-family-title)
    font-weight: bold
    color: var(--primary)

</style>