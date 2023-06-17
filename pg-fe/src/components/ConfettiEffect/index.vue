<template>
    <div class="confetti-container" v-if="confetti">
      <div
        :class="['confetti-shape', `${shape.name}`]"
        v-for="(shape, index) in shapes"
        :key="index"
        :style="shape.style"
      ></div>
    </div>
  </template>
  
  <script>
  export default {
    name: "ConfettiEffect",
    props: {
      confetti: {
        type: Boolean,
        required: true,
      },
    },
    data() {
      return {
        shapes: [],
      };
    },
    mounted() {
    this.generateConfetti();
    },
    watch: {
      confetti(newValue) {
        if (newValue) {
          this.generateConfetti();
        } else {
          this.shapes = [];
        }
      },
    },
    methods: {
    generateConfetti() {
      const shapes = ["star", "rectangle", "circle", "square", "pentagon", "hexagon"];
      const colors = [
        "var(--primary)",
        "var(--primary-light)",
        "var(--secondary)",
        "var(--secondary-dark)",
      ];

      for (let i = 0; i < 100; i++) {
        const name = shapes[Math.floor(Math.random() * shapes.length)]
        const color = colors[Math.floor(Math.random() * colors.length)]
        const zIndex = Math.floor(Math.random() * 4)
        const size = Math.floor(Math.random() * 20) + 10
        const rotation = Math.floor(Math.random() * 360)

        const style = `background-color: ${color}; width: ${size}px; height: ${size}px; transform: rotate(${rotation}deg); z-index: ${zIndex};`;

        this.shapes.push({name, style });
      }

      console.log(this.shapes)
    },
  },
};
</script>

<style lang="sass" scoped>
@import "../../assets/_variables"

.confetti-container
  width: 100vh
  height: 100vh
.confetti-shape
  position: absolute
  bottom: 0
  left: 50%
  transform: translateX(-50%)
  pointer-events: none
  animation: confetti-fall 5s linear infinite

.rectangle
  background-color: var(--primary)
.circle
  background-color: var(--primary-light)
  border-radius: 50%
.square
  background-color: var(--secondary)
.pentagon
  background-color: var(--secondary-dark)
  clip-path: polygon(50% 0%, 100% 38%, 82% 100%, 18% 100%, 0% 38%)
.hexagon
  background-color: var(--secondary)
  clip-path: polygon(50% 0%, 88% 25%, 100% 75%, 50% 100%, 0% 75%, 12% 25%)

@keyframes confetti-fall
    0%
      bottom: 10%
      bottom: unquote("#{random(100) + random(15)}%")
    10%
      bottom:  20%
      bottom: unquote("#{random(100) + random(15)}%")
    30%
      bottom:  30%
      bottom: unquote("#{random(100) + random(15)}%")
</style>