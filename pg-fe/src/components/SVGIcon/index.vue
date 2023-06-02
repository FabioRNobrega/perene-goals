<template>
  <div :style="styleIcon" :class="['svg-icon', { 'big': big, 'small': small }]" />
</template>

<script>
export default {
  name: 'SVGIcon',
  props: {
    iconName: {
      type: String,
      required: true
    },
    big: {
      type: Boolean,
      required: false,
      default: false
    },
    small: {
      type: Boolean,
      required: false,
      default: false
    }
  },
  computed: {
    styleIcon() {
      const baseURL = import.meta.env.VITE_PG_FE
      const svgUrl = `${baseURL}/src/icons/svg/${this.iconName}.svg`;

      return {
        mask: `url(${svgUrl}) no-repeat 50% 50%`,
        '-webkit-mask': `url(${svgUrl}) no-repeat 50% 50%`
      };
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

  .big 
    width: 40px
    height: 40px

  .small 
    width: 18px
    height: 18px


</style>
