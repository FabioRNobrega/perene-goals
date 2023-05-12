<template>
  <input
    :id="name"
    :name="name"
    :type="type"
    class="input-text"
    :placeholder="placeholder"
    :value="value"
    :disabled="disabled"
    @input="inputHandler"
  />
</template>

<script>
export default {
  name: "BaseInput",
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
  methods: {
    inputHandler(event) {
      this.$emit('update:value', event.target.value)
    }
  }
}
</script>

<style lang="sass">
@import "../../assets/_variables"

.input-text
  border: 3px solid var(--secondary)
  border-radius: 5px
  box-shadow: 0px 0px 10px var(--secondary)
  padding: 12px 20px
  margin: 8px 0
  display: inline-block
  box-sizing: border-box
</style>
