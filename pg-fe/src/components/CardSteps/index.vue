<template>
  <div class="card">
    <div class="card__circle">
      <SVGIcon class="card__circle--icon" :icon-name="icon" />
    </div>
    <h2 class="card__title"> {{ title }} </h2>
    <div class="card__description">
      <p> {{  description }} </p>
      <slot name="callToAction" > </slot>
    </div>
  </div>
</template>

<script>
import SVGIcon from '../SVGIcon/index.vue'

export default {
    name: "CardSteps",
    components: {
      SVGIcon
    },
    props: {
      icon: {
        type: String,
        default: 'plus',
        require: false
      },
      title: {
        type: String,
        default: 'Step 1',
        require: false
      },
      description: {
        type: String,
        default: '',
        require: false
      }
    }
}
</script>

<style lang="sass" scoped>
@import "../../assets/_mixins"
@import "../../assets/_variables"

.card
  border-radius: 5px
  background-color: var(--secondary)
  padding: 52px 20px 20px
  text-align: center
  position: relative
  margin-top: 60px
  @include tablets-and-up 
    flex: 1
    margin: 60px 10px 0px 10px

  &__circle
      position: absolute
      top: 0
      left: 50%
      transform: translate(-50%, -50%)
      width: 90px
      height: 90px
      background: var(--primary)
      box-shadow: inset 0px 0px 7px 3px var(--primary-light), 0px 0px 10px var(--secondary)
      border-radius: 100%
      @include display-row 
      justify-content: center
      align-items: center
      overflow: hidden

      &--icon
        color: var(--secondary)
        width: 50px
        height: 50px

  &__title
    font-family: var(--font-family-title)
    color: var(--neutral-color-light)
    font-size: 30px
    font-weight: 700
    margin: 10px 0
    text-transform: capitalize
    

  &__description
    font-family: var(--font-family-base)
    color: var(--neutral-color-light)

    & p 
      text-align: left
      margin: 20px 0
      line-height: 1.5em
      font-size: 16px
    

  

</style>