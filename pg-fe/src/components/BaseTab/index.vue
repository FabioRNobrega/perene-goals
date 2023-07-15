<template>
  <div class="tab">
    <div :class="['tab__button', {'active': enable}]" @click="enable = true">
        {{ buttonRight }}
    </div>
    <div :class="['tab__button', {'active': !enable}]" @click="enable = false">
        {{ buttonLeft }}
    </div>
  </div>
  <div>
    <slot v-if="enable" name="contentRight"> </slot>
    <slot v-if="!enable" name="contentLeft"> </slot>

  </div>
</template>

<script>
export default {
    name: "BaseTab",
    props: {
        buttonRight: {
            type: String,
            required: false,
            default: ""
        },
        buttonLeft: {
            type: String,
            required: false,
            default: ""
        }
    },
    data() {
        return {
            enable: true
        }
    },
    methods: {

    }
}
</script>

<style lang="sass" scoped>
@import "../../assets/_variables"
@import "../../assets/_mixins"

.tab
    @include display-col
    justify-content: space-between
    align-items: center
    margin: 30px 0
    
    @include tablets-and-up
        @include display-row

    &__button
        border-radius: 5px
        border: none
        font-size: 15px
        text-transform: uppercase
        font-weight: 700
        padding: 12px
        margin: 10px 0
        width: 100%
        background-color: var(--primary)
        color: var(--primary-light)
        box-shadow: inset 0px 0px 7px 3px var(--primary-light)
        font-family:  var(--font-family-title)
        transition: all .15s linear
        cursor: pointer
        width: 100%
        @include tablets-and-up
            width: 46%    

        &:hover 
          color: var(--secondary)


.active
    background-color: var(--primary)
    color: var(--secondary)
    box-shadow: inset 0px 0px 7px 3px var(--primary-light)

        

</style>