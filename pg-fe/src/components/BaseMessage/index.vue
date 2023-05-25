<template>   
  <div
    role="alert"
    v-if="visibility"
    :class="['message', {
      'message__error': error,
      'message__success': success,
      'message__warning': warning,
      'message__info': info,
      'show': visibility
    }]"
  >
  <div class="message__content">
    <div class="message__content--context">
      <SVGIcon :icon-name="icon" />
      <p>
        {{ content }}
      </p>
    </div> 
    <div @click="handleMessageVisibility" class="message__content--action">
      <SVGIcon icon-name="close" :small="true" />
    </div>
  </div>
</div>
</template>
  
<script>
import SVGIcon from '../SVGIcon/index.vue'
  export default {
    name: "BaseMessage",
    components: {
      SVGIcon
    },
    props: {
      content: {
        type: String,
        required: false
      },
      visibility: {
        type: Boolean,
        required: false,
        default: false
      },
      error: {
        type: Boolean,
        required: false,
        default: false
      },
      success: {
        type: Boolean,
        required: false,
        default: false
      },
      warning: {
        type: Boolean,
        required: false,
        default: false
      },
      info: {
        type: Boolean,
        required: false,
        default: false
      },
      icon: {
        type: String,
        default: 'warning',
        require: false
      }
    },
    methods: {
      handleMessageVisibility() {
        this.$emit('hide')
      }
    }
  }
</script>
  
<style lang="sass" scoped>
@import "../../assets/_variables"
@import "../../assets/_mixins"

.message
  font-family:  var(--font-family-base)
  background-color: var(--neutral-color-light)
  border-radius: 5px
  font-size: 15px
  font-weight: lighter
  margin: 12px auto
  padding: 5px
  

  &__content 
    @include display-row
    align-items: center
    justify-content: space-between

    &--context
      display: flex
      align-items: center

      & p 
        margin: 0 0 0 20px

    &--action
      cursor: pointer
      color: var(--secondary)
      &:hover
        color: var(--primary)
    
  &__error 
    color: var(--feedback-error)
    border: solid 1px var(--feedback-error)

  &__success 
    color: var(--feedback-success)
    border: solid 1px var(--feedback-success)

.show
  animation: show_slide 1s ease forwards

@keyframes show_slide
  0%
    transform: translateY(-100%)
  40%
    transform: translateY(10%)
  80%
    transform: translateY(0%)
  100%
    transform: translateY(0px)



</style>