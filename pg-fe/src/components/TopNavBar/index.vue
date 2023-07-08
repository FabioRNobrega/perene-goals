<template>
  <div class="top-navbar">
    <div class="circle circle__left">
      <slot name="iconLeft"/>
    </div >
    <div class="circle circle__right">
      <slot name="iconRight"/>
    </div>  
  </div>
</template>

<script>
export default {
  name: "TopNavbar"
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