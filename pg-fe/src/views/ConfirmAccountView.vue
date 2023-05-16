<template>
    <div class="confirm">
     <p>  
       Thanks to confirm you account. Please <RouterLink  to="/login"> login </RouterLink> and start to achieve your goals today.
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
@import "../assets/main"
@import "../assets/_variables"

.confirm 
  text-align: center
  margin: auto
  font-family: var(--font-family-base)

  & p
    color: var(--neutral-color-dark)
    padding: 20px
    margin-top: 45vh

  & a 
    font-family: var(--font-family-title)
    font-weight: bold
    color: var(--primary)

</style>