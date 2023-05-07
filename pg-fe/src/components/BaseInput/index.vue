<template>
    <input :type="type" class="input">
</template>
  
<script>
  export default {
      name: "BaseInput",
      props: {
        type: {
            type: String,
            require: false,
            default: "text"
        }
      }
  }
</script>
  
<style lang="sass">
@import "../../assets/_variables"

.input
    border: 3px solid var(--secondary)
    border-radius: 5px
    box-shadow: 0px 0px 10px var(--secondary)
    padding: 12px 20px
    margin: 8px 0
    display: inline-block
    box-sizing: border-box

</style>