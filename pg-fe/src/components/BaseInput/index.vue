<template>
  <div class="input-container">
    <input
      :id="name"
      :name="name"
      :type="showPassword ? 'text' : type"
      class="input-text"
            :class="['input-text', {
        'input-text__error': error,
      }]"
      :placeholder="placeholder"
      :value="value"
      :disabled="disabled"
      @input="inputHandler"
    >
    <button  
      v-if="type == 'password'" 
      :class="['show-password', {
        'show-password__dark': passwordDark,
        'show-password__light': passwordLight
      }]"
      @click="handlePasswordVisibility"
    >
        <SVGIcon icon-name="details"/>
    </button>
  </div>
  <div class="input-error">
    <div v-if="error">
      {{ errorMessage }}
    </div>
  </div>
</template>

<script>
import SVGIcon from '../SVGIcon/index.vue' 

export default {
  name: "BaseInput",
  components: {
    SVGIcon
  },
  props: {
    type: {
      type: String,
      required: false,
      default: "text"
    },
    name: {
      type: String,
      required: false
    },
    value: {
      type: String,
      default: '',
      required: false
    },
    disabled: {
      type: Boolean,
      default: false
    },
    placeholder: {
      type: String,
      default: ''
    },
    passwordDark: {
      type: Boolean,
      required: false,
      default: false
    },
    passwordLight: {
      type: Boolean,
      required: false,
      default: false
    },
    error: {
      type: Boolean,
      required: false,
      default: false
    },
    errorMessage: {
      type: String,
      required: false,
      default: ""
    },
  },
  data() {
    return {
      showPassword: false
    }
  },
  methods: {
    inputHandler(event) {
      this.$emit('update:value', event.target.value)
    },
    handlePasswordVisibility() {
      this.showPassword = !this.showPassword
    }
  }
}
</script>

<style lang="sass">
@import "../../assets/_variables"
@import "../../assets/_mixins"

.input-container
  @include display-row
  align-items: center

.input-error
  font-family: var(--font-family-base)
  color: var(--feedback-error) 
  font-size: 12px
  text-transform: capitalize
  margin-top: -6px

.input-text
  width: 100%
  border: 3px solid var(--secondary)
  border-radius: 5px
  padding: 12px 20px
  margin: 8px 0
  display: inline-block
  box-sizing: border-box

  &__error 
    border: 3px solid var(--feedback-error)

.show-password
  border: 1px solid var(--neutral-color-lighter)
  border-radius: 3px
  width: 40px
  height: 40px
  background: transparent
  cursor: pointer

  &__dark
    color: var(--secondary)
    &:hover
     color: var(--primary-light) 
  
  &__light
    border: 1px solid var(--neutral-color-lighter)
    color: var(--neutral-color-light)

    &:hover
      color: var(--primary)
      border-color: var(--primary)

</style>
