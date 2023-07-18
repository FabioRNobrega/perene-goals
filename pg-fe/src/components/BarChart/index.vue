<template>
    <div class="chart">
        <div class="chart__container"  v-for="(value, key) in progress" :key="key">
            <div :style="{ width: (value / progress.total) * 100 + '%' }" :class="`chart__bar ${key}`">  
               <h2>
                   {{ key }}
               </h2>
               <SVGIcon v-if="progress.total == progress.completed" icon-name="finish" style="margin-right: 10px;"  :small="small"/>
            </div>
            <h2  class="chart__count">
              {{ value }}
            </h2>
        </div>
        <div class="chart__info">
            <h4  v-if="progress.total == progress.completed" class="chart__info--text" > 
                {{ this.commemorativeText }}
            </h4>
            <h4  v-else class="chart__info--text" > 
                {{ this.motivationalPhrase }}
            </h4>
        </div>
    </div>
</template>

<script>
import SVGIcon from '../SVGIcon/index.vue'
import { data } from '../../data/support_text.json'


export default {
    name: "BarChart",
    components: {
      SVGIcon
    },
    props: {
        progress: {
          type: Object,
          required: false,
          default: () => ({   
            total: 10,
            completed: 10
          })
      },
    },
    data () {
        return {
            commemorativeText: "",
            motivationalPhrase: ""
        }
    },
    mounted() {
      this.setSupportText()
    },
    methods: {
        setSupportText() {
          this.commemorativeText = data.goal_list[Math.floor(Math.random() *  data.goal_list.length)]
          this.motivationalPhrase = data.motivational_phrase[Math.floor(Math.random() *  data.motivational_phrase.length)]
        }
    }
}
</script>

<style lang="sass" scoped>
@import "../../assets/_mixins"
@import "../../assets/_variables"

.chart
    @include display-col
    width: 100%

    &__container
        @include display-row
        justify-content: space-between
        
    &__bar 
        font-family: var(--font-family-title)
        color: var(--neutral-color-lighter)
        font-size: 20px
        padding: 5px
        margin: 2px
        border-radius: 5px
        animation: progressbar-slide-in 2s ease-in-out
        @include display-row
        justify-content: space-between
        align-items: center

        & h2 
          margin: 0
          font-size: 20px

    &__count
        font-family: var(--font-family-title)
        color:  var(--secondary)
        font-size: 20px
        font-weight: bold
        text-align: end
        min-width: 25px

    &__info 
        background-color: var(--neutral-color-dark)
        padding: 25px
        border-radius: 5px
        margin: 10px auto

        &--text
            font-family: var(--font-family-title)
            color:  var(--secondary)
            font-size: 16px
            font-weight: bold
            text-align: center

.completed 
    background-color: var(--primary)
    text-transform: capitalize
    color: var(--secondary)

.total 
    text-transform: capitalize
    background-color: var(--secondary)

    
@keyframes progressbar-slide-in
  0%
    width: 0

</style>