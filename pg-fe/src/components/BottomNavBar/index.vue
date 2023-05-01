<template>
  <div class="bottom-navbar">
    <div class="bottom-navbar__button">
      <svg v-if="iconName == 'plus'" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 448 512"><!--! Font Awesome Pro 6.3.0 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license (Commercial License) Copyright 2023 Fonticons, Inc. --><path d="M240 80c0-17.7-14.3-32-32-32s-32 14.3-32 32V224H32c-17.7 0-32 14.3-32 32s14.3 32 32 32H176V432c0 17.7 14.3 32 32 32s32-14.3 32-32V288H384c17.7 0 32-14.3 32-32s-14.3-32-32-32H240V80z"/></svg>
    </div>
  </div>
</template>

<script>
export default {
    name: "BottomNavbar",
    props: {
        iconName: {
            type: String,
            require: false,
            default: "plus"
        },
        pathName: {
            type: String,
            require: false,
            default: "/create-list"
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
    cursor: pointer
    transition: 0.5s
    @include desktop-and-up
      margin-right: 50px

    &:hover
      width: 100px
      height: 100px

    & svg
      fill: var(--secondary)
      width: 45px

</style>