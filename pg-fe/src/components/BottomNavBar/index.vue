<template>
  <div class="bottom-navbar">
    <div :class="['bottom-navbar__button', {
      'bottom-navbar__button--disabled': disabled
    }]">
      <SVGIcon :icon-name="iconName"/>
    </div>
  </div>
</template>

<script>
import SVGIcon from '../SVGIcon/index.vue' 

export default {
  name: "BottomNavbar",
  components: {
    SVGIcon
  },
  props: {
    iconName: {
      type: String,
      require: false,
      default: "home"
    },
    disabled: {
      type: Boolean,
      require: false,
      default: false
    }
  }
}
</script>

<style lang="sass">
@import "../../assets/_mixins"
@import "../../assets/_variables"


.bottom-navbar 
  width: 100%
  position: fixed
  bottom: 0px
  height: 57px
  background: var(--secondary-dark)
  box-shadow: 0px 0px 10px var(--secondary)
  @include display-row
  justify-content: center
  @include desktop-and-up
    justify-content: right
  
  &__button
    width: 90px
    height: 90px
    margin-top: -45px
    border-radius: 100%
    background: var(--primary)
    box-shadow: inset 0px 0px 7px 3px var(--primary-light), 0px 0px 10px var(--secondary)
    @include display-row
    justify-content: center
    align-items: center
    cursor: pointer
    transition: 0.5s
    color: var(--secondary)
    @include desktop-and-up
      margin-right: 50px

    &:hover
      width: 100px
      height: 100px

    & .svg-icon
      width: 45px
      height: 45px

    &--disabled
      color: var(--primary-light)
      pointer-events: none
      cursor: not-allowed

</style>
