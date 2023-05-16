  <template>
    <div :style="styleIcon" class="svg-icon" />
  </template>
  
  <script>  
  export default {
    name: 'SVGIcon',
    props: {
      iconName: {
        type: String,
        required: true
      }
    },
    computed: {
      styleIcon() {
            return {
                mask: `url(src/icons/svg/${this.iconName}.svg) no-repeat 50% 50%`,
                '-webkit-mask': `url(src/icons/svg/${this.iconName}.svg) no-repeat 50% 50%`
            }
        }
    }
  }
  </script>
  
  <style lang="sass" scoped>
  .svg-icon
    width: 25px
    height: 25px
    vertical-align: -0.15em
    fill: currentColor
    overflow: hidden
    background-color: currentColor
    display: inline-block


  </style>
  