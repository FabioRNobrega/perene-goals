<template>
  <div class="input-container">
    <input
      :id="name"
      :name="name"
      :type="showPassword ? 'text' : type"
      class="input-text"
      :placeholder="placeholder"
      :value="value"
      :disabled="disabled"
      @input="inputHandler"
    >
    <button  v-if="type == 'password'" class="show-password" @click="handlePasswordVisibility">
        <SVGIcon icon-name="details"/>
    </button>
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
    }
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
  

.input-text
  width: 100%
  border: 3px solid var(--secondary)
  border-radius: 5px
  box-shadow: 0px 0px 10px var(--secondary)
  padding: 12px 20px
  margin: 8px 0
  display: inline-block
  box-sizing: border-box

.show-password
  border: 1px solid var(--neutral-color-lighter)
  border-radius: 3px
  width: 40px
  height: 40px
  background: transparent
  color: var(--neutral-color-light)
  cursor: pointer

  &:hover
    color: var(--primary)
    border-color: var(--primary)

</style>
