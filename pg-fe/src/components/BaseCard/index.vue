<template>
  <div class="card">
    <div  class="card__title">
      <slot name="header"> </slot>
    </div>
    <div class="card__content">
      <slot name="row"> </slot>
    </div>
  </div>
</template>

<script>
export default {
    name: "BaseCard"
}
</script>

<style lang="sass" scoped>
@import "../../assets/_mixins"
@import "../../assets/_variables"

.card
  background-color: var(--secondary)
  border-style: hidden
  text-align: left
  overflow: hidden
  padding: 25px
  border-radius: 5px
  margin: 10px 0
  word-wrap: break-word
  white-space: normal
  word-break: normal
  text-overflow: ellipsis
  box-shadow: 0px 0px 10px var(--secondary)
  @include display-col
  @include tablets-and-up
   margin: 10px 
   justify-content: space-around

  &__title, h3
      font-size: 20px
      font-family: var(--font-family-title)
      font-weight: 700
      color: var(--neutral-color-light)
      margin-bottom: 10px
  
  &__content, p
      font-size: 14px
      font-family: var(--font-family-base)
      font-weight: 400
      color: var(--neutral-color-light)


</style>