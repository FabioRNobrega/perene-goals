<template>
  <div class="card">
    <slot name="header"> </slot>
    <slot name="row"> </slot>
  </div>
</template>

<script>
export default {
    name: "BaseCard",
    props: {

    }
}
</script>

<style lang="sass">
@import "../../assets/_mixins"
@import "../../assets/_variables"

.card
  background-color: var(--lighter-background-color)
  border-style: hidden
  height: 380px
  text-align: left
  overflow: hidden
  padding: 25px
  border-radius: 10px
  margin: auto
  word-wrap: break-word
  white-space: normal
  word-break: normal
  text-overflow: ellipsis
  border: 1px solid var(--border-color)
  box-shadow: var(--box-shadow)
  backdrop-filter: blur(15px)
  cursor: pointer
  position: relative
  @include display-col
  @include tablets-and-down
    min-height: 300px
</style>