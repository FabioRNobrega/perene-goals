<template>
  <div class="top-navbar">
    <RouterLink  :to="pathNameLeft" class="circle circle__left" >
      <SVGIcon :icon-name="iconNameLeft"/>
    </RouterLink >
    <RouterLink  :to="pathNameRight" class="circle circle__right">
      <SVGIcon :icon-name="iconNameRight"/>
    </RouterLink >  
  </div>
</template>

<script>
import { RouterLink } from 'vue-router';
import SVGIcon from '../SVGIcon/index.vue' 

export default {
    name: "TopNavbar",
    components: {
      RouterLink,
      SVGIcon
    },
    props: {
        iconNameLeft: {
            type: String,
            require: false,
            default: "user"
        },
        pathNameLeft: {
            type: String,
            require: false,
            default: "/profile"
        },
        iconNameRight: {
            type: String,
            require: false,
            default: "learning"
        },
        pathNameRight: {
            type: String,
            require: false,
            default: "/learning"
        },
    },
    methods: {
      handleClick() {
        localStorage.clear()
      }
    }

}
</script>

<style lang="sass">
@import "../../assets/_mixins"
@import "../../assets/_variables"

.top-navbar  
  @include display-row
  position: fixed
  width: 100%
  top: 0px
  justify-content: space-between
  height: 80px
  margin-bottom: 10px
  z-index: 2
  
.circle
  width: 110px
  height: 110px
  cursor: pointer
  transition: 1s
  color: var(--secondary)

  &:hover
    width: 160px
    height: 160px

  &__left 
    clip-path: circle(50% at 0 1%)
    background-image: linear-gradient(to right, var(--primary-light), var(--primary))
    padding: 15px 10px

    & .svg-icon
      width: 30px
      height: 30px


  &__right 
    clip-path: circle(50% at 100% 2%)
    background-image: linear-gradient(to left,  var(--primary-light), var(--primary))
    display: flex
    padding: 15px 10px
    justify-content: end

    & .svg-icon
      width: 30px
      height: 30px

 

</style>