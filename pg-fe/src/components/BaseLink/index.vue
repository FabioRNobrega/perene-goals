<template>
    <RouterLink  :to="pathName" class="link">
      {{ content  }}
    </RouterLink>
</template>

<script>
import { RouterLink } from 'vue-router';

export default {
    name: "BaseLink",
    components: {
      RouterLink
    },
    props: {
        content: {
            type: String,
            require: false,
            default: ""
        },
        pathName: {
            type: String,
            require: false,
            default: "/"
        }
    }

}
</script>

<style lang="sass">
@import "../../assets/_mixins"
@import "../../assets/_variables"


.link 
  font-family: var(--font-family-title)
  font-weight: bold
  color: var(--primary)
  
  &:hover
    color: var(--primary-light)

</style>