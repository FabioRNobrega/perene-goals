  <template> 
    <div  v-if="confetti" class="confetti-container">
      <div v-for="(confetti, index) in confetti_style" :key="index" class="confetti" :style="confetti.animation_format">
        <div :class="['shape', `${confetti.shape_name}`]"></div>
      </div>
    </div>
  </template>
  confetti-
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
        confetti_style: [],
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
          this.confetti_style = [];
        }
      }
    },
    methods: {
      generateConfetti() {
      const shapes = ["star", "rectangle", "circle", "square", "pentagon", "hexagon"];


        for (let i = 0; i < 200; i++) {
          const name = shapes[Math.floor(Math.random() * shapes.length)]
          const rotation = -50 + Math.random() * 100;
          const rnd = Math.random();

          this.confetti_style.push({
            shape_name: name,
            animation_format: `--rotation: ${rotation}deg; --rnd: ${rnd};`,
          });
        }
      },
    },
  };
  </script>
  
<style lang="sass" scoped>
@import "../../assets/_variables"

.confetti-container
  position: fixed
  top: 110%
  left: 50%
  transform: translate(-50%, -50%) rotate(-180deg)
  perspective: 100vh
  transform-style: preserve-3d

.confetti
  pointer-events: none
  position: absolute
  transform: rotate(var(--rotation))

.shape
  position: absolute
  animation: erupting calc(5s * var(--rnd)) infinite
  animation-delay: -10s

.circle
  border-radius: 50%
  background: var(--primary)
  width: 30px
  height: 30px

.square
  background: var(--primary-light)
  width: 25px
  height: 25px

.rectangle 
  background: var(--secondary)
  width: 30px
  height: 5px

.pentagon
  background: var(--secondary-dark)
  width: 20px
  height: 20px
  clip-path: polygon(50% 0%, 100% 38%, 82% 100%, 18% 100%, 0% 38%)

.hexagon
  background: var(--secondary)
  width: 34px
  height: 30px
  clip-path: polygon(50% 0%, 75% 0%, 100% 50%, 75% 100%, 50% 100%, 25% 100%, 0% 50%, 25% 0%)

.star
  width: 16px

  &:before
    content: ""
    position: absolute
    background: var(--primary-light)
    width: 16px
    height: 18.4px
    transform: rotate(-45deg) skewX(22.5deg) skewY(22.5deg)

  &:after
    content: ""
    position: absolute
    background: var(--primary-light)
    width: 16px
    height: 18.4px
    transform: rotate(45deg) skewX(22.5deg) skewY(22.5deg)

@keyframes erupting
  90%
    opacity: 1
  100%
    opacity: 0
    transform: translateY(calc(90vh + 50vh * var(--rnd))) rotateY(calc(3000deg * var(--rnd))) rotateX(calc(2000deg * var(--rnd))) rotateZ(calc(1060deg * var(--rnd)))

</style>