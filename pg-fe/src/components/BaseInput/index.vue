<template>
  <div class="input-container">
    <input
      :id="value"
      :name="value"
      :value="value"
      :type="showPassword ? 'text' : type"
      class="input-text"
      :class="['input-text', {
        'input-text__error': error,
        'input-text__checkbox': type == 'checkbox'
      }]"
      :placeholder="placeholder"
      :disabled="disabled"
      @change="inputHandler"
      @input="inputHandler"
    >
    <label v-if="type == 'checkbox'" :for="value == true">
      {{ label }}
    </label>
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
    label: {
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
      if (this.type === 'checkbox') {
        this.$emit('update:value', event.target.checked);
      } else {
        this.$emit('update:value', event.target.value);
      }
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

  input[type="checkbox"]
    padding: 0
    height: initial
    width: initial
    margin-bottom: 0
    display: none
    cursor: pointer

  label
    margin: 8px 0
    position: relative
    cursor: pointer
    font-family: var(--font-family-base)
    color: var(--secondary)

    &:before
      content: ''
      -webkit-appearance: none
      background-color: transparent
      border: 3px solid var(--secondary)
      border-radius: 3px
      box-shadow: 0 1px 2px rgba(0, 0, 0, 0.05), inset 0px -15px 10px -12px rgba(0, 0, 0, 0.05)
      padding: 10px
      display: inline-block
      position: relative
      vertical-align: middle
      cursor: pointer
      margin-right: 5px

  input:checked + label:after
    content: ''
    display: block
    position: absolute
    top: 2px
    left: 9px
    width: 6px
    height: 14px
    border: solid var(--secondary)
    border-width: 0 2px 2px 0
    transform: rotate(45deg)

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

  &__checkbox
    width: max-content

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
