<template>
    <div v-if="showModal" class="modal-container">
        <div class="modal">
            <div  class="modal__title">
              <h3> {{ title }}</h3>
            </div>
            <div class="modal__content">
              <p>
                 {{ content }}
              </p>
            </div>
            <div class="modal__footer">
              <slot name="footer"> </slot>
            </div>
        </div>
    </div>
  </template>
  
  <script>
  export default {
      name: "BaseModal",
      props: {
        showModal: {
            type: Boolean,
            default: false
        },
        title: {
            type: String,
            default: 'Please confirm your action',
            require: false
        },
        content: {
            type: String,
            default: 'You have shore that want to do that?',
            require: false
        }
      }
  }
  </script>
  
  <style lang="sass" scoped>
  @import "../../assets/_mixins"
  @import "../../assets/_variables"

  .modal-container 
    position: fixed
    @include display-col
    align-items: center
    justify-content: center
    top: 0
    width: 100vw
    height: 100vh
    background: rgba(0,0,0,0.4)
    z-index: 4
  
  .modal
    background-color: var(--secondary)
    border-style: hidden
    text-align: left
    overflow: hidden
    padding: 25px
    border-radius: 5px
    word-wrap: break-word
    white-space: normal
    word-break: normal
    text-overflow: ellipsis
    box-shadow: 0px 0px 10px var(--secondary)
    margin: 0 10px
    animation: show_slide 1s ease forwards
    @include display-col
  
    &__title, h3
        font-size: 20px
        font-family: var(--font-family-title)
        font-weight: 700
        color: var(--neutral-color-light)
        margin: 0 5px 5px 5px
    
    &__content, p
        font-size: 16px
        font-family: var(--font-family-base)
        font-weight: 400
        color: var(--neutral-color-light)
        margin-top: 5px
        max-width: 300px
        margin: 0 5px

    &__footer
        @include display-row
        justify-content: center
        margin-top: 30px

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