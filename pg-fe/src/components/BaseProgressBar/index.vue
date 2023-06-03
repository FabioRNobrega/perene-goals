<template>
    <div class="progressbar"> 
        <div v-for="progress in processSize" :key="progress.index" class="percentage" />
    </div>
    <h6 class="base-text-light"> {{ bottomText }} </h6>
</template>

<script>

export default {
    name: "BaseProgressBar",
    props: {
        processSize: {
          type: Array,
          required: false,
          default: () => [{ default: "10%"}]
        },
        bottomText: {
            type: String,
            required: false,
            default: "Almost there..."
        }
    }

}
</script>

<style lang="sass" scoped>
@import "../../assets/main"
@import "../../assets/_mixins"
@import "../../assets/_variables"


.progressbar
  width: 100%
  height: 20px
  margin-top: 20px
  margin-bottom: 5px
  border-radius: 5px
  overflow: hidden
  background-color: var(--neutral-color-lighter)
  @include display-row
  align-items: center
  justify-content: flex-start
  

.percentage
  width: 10%
  height: 20px
  background-color: var(--primary)


</style>