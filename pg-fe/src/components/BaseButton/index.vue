<template>
    <button
      :class="['base-button', {
        'base-button__dark': dark,
        'base-button__light': light,
        'base-button__disabled': disabled,
      }]"
    >
    <div class="base-button__content">
      {{ content }}
      <SVGIcon
          :icon-name="icon"
        />
    </div>
    </button>
</template>
  
<script>
import SVGIcon from '../SVGIcon/index.vue'
  export default {
    name: "BaseButton",
    components: {
      SVGIcon
    },
    props: {
      content: {
        type: String,
        required: true
      },
      disabled: {
        type: Boolean,
        required: false,
        default: false
      },
      dark: {
        type: Boolean,
        required: false,
        default: false
      },
      light: {
        type: Boolean,
        required: false,
        default: false
      },
      icon: {
        type: String,
        default: 'plus',
        require: false
      }
    }
  }
</script>
  
<style lang="sass">
@import "../../assets/_variables"
@import "../../assets/_mixins"

.base-button
  border-radius: 5px
  border: none
  font-size: 15px
  text-transform: uppercase
  font-weight: 700
  font-family:  var(--font-family-title)
  margin: 12px 0
  padding: 12px
  transition: all .15s linear
  width: 100%
  cursor: pointer

  &__content 
    @include display-row
    justify-content: space-between
    align-items: center
  
  &__dark 
    background-color: var(--secondary-dark)
    color: var(--primary)
    box-shadow: inset 0px 0px 7px 3px var(--secondary)

    &:hover 
      background-color: var(--secondary)
  

  &__light 
    background-color: var(--primary)
    color: var(--secondary)
    box-shadow: inset 0px 0px 7px 3px var(--primary-light)

    &:hover 
      background-color: var(--primary-light)
  

  &__disabled 
    width: 100%
    text-align: center
    background-color: var(--neutral-color-dark)
    color: var(--neutral-color-lighter)
    pointer-events: none
    cursor: default

    &:focus 
      outline-color: transparent
    
  

</style>