<template>
    <div class="confirm">
     <p class="confirm__text">  
       Thanks to confirm you account. Please <RouterLink  to="/login" class="confirm__link"> login </RouterLink> and start to achieve your goals today.
     </p> 
    </div>
</template>

<script>
import { RouterLink } from 'vue-router';
export default {
    name: "ConfirmAccountView",
    components: {
      RouterLink
    }

}
</script>

<style lang="sass">
@import "../assets/_variables"

.confirm 
  text-align: center
  margin: auto
  font-family: var(--font-family-base)

  &__text
    color: var(--secondary-dark)
    padding: 20px
    margin-top: 45vh

  &__link 
    font-family: var(--font-family-title)
    font-weight: bold
    color: var(--primary)

</style>