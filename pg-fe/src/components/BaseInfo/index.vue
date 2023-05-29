<template>
  <div class="info">
    <SVGIcon icon-name="warning" :big="true" />
    <div class="info__content">
      <slot name="content" class="content"> </slot>
    </div>
  </div>
</template>

<script>
import SVGIcon from '../SVGIcon/index.vue'
export default {
    name: "BaseInfo",
    components: {
      SVGIcon
    }
}
</script>

<style lang="sass">
@import "../../assets/_mixins"
@import "../../assets/_variables"

.info
  background-color: var(--neutral-color-dark)
  color: var(--neutral-color-darker)
  text-align: justify
  overflow: hidden
  padding: 25px
  border-radius: 5px
  margin: 50px auto 
  word-wrap: break-word
  white-space: normal
  word-break: normal
  text-overflow: ellipsis
  @include display-col
  align-items: center
  text-indent: 20px

  &__content
    margin: 15px 0
    & p a
      color: var(--primary)
      font-weight: 700

</style>