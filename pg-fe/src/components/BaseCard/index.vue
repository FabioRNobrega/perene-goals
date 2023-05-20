<template>
  <div class="card">
    <slot name="header"> </slot>
    <slot name="row"> </slot>
  </div>
</template>

<script>
export default {
    name: "BaseCard"
}
</script>

<style lang="sass">
@import "../../assets/_mixins"
@import "../../assets/_variables"

.card
  background-color: var(--secondary)
  border-style: hidden
  height: 380px
  text-align: left
  overflow: hidden
  padding: 25px
  border-radius: 5px
  margin: auto
  word-wrap: break-word
  white-space: normal
  word-break: normal
  text-overflow: ellipsis
  box-shadow: 0px 0px 10px var(--secondary)
  cursor: pointer
  position: relative
  @include display-col
  @include tablets-and-down
    min-height: 300px
</style>