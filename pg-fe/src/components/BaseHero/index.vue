<template>
    <div class="banner">
    <img class="banner__image" src="/banners/banner.png">
    <div class="banner__overlay">
        <div class="banner__overlay--text">
        <h2 class="banner__overlay--text-quote">
            “{{ quote.quote}}”
        </h2>
        <div class="banner__divider"></div>
        <h4 class="banner__overlay--text-author">
            {{ quote.author}}
        </h4>
        </div>
    </div>
    </div>
</template>

<script>
export default {
    name: "BaseHero",
    data() {
        return {
            quote_list: [
                {
                    quote: "We can only see a little bit of the future, but enough to know there is much to do",
                    author: "Alan Mathison Turing"
                },
                {
                    quote: "Setting goals is the first step in turning the invisible into the visible",
                    author: "Tony Robbins"
                },
                {
                    quote: "Goals are like magnets. They attract the things that you need and help determine what you want to become",
                    author: "Zig Ziglar"
                },
                {
                    quote: "Dreams can become a reality when we possess the courage to pursue them",
                    author: "Walt Disney"
                },
                {
                    quote: "Success is the sum of small efforts repeated day in and day out",
                    author: "Robert Collier"
                },
                {
                    quote: "Set a goal that makes you want to jump out of bed in the morning",
                    author: "Unknown"
                },
                {
                    quote: "The only limit to your dreams is your imagination and determination",
                    author: "Unknown"
                },
                {
                    quote: "If you can dream it, you can achieve it",
                    author: "Zig Ziglar"
                },
                {
                    quote: "A goal without a plan is just a wish",
                    author: "Antoine de Saint-Exupéry"
                },
                {
                    quote: "Success is the sum of small efforts repeated day in and day out",
                    author: "Leo Tolstoy"
                },
                {
                    quote: "If you want something you've never had, you must be willing to do something you've never done",
                    author: "Unknown"
                },
                {
                    quote: "Great achievements are possible when we give importance to small beginnings",
                    author: "Lao Tzu"
                },
                {
                    quote: "Don't wait for opportunity. Create it",
                    author: "Unknown"
                },
                {
                    quote: "The future belongs to those who believe in the beauty of their dreams",
                    author: "Eleanor Roosevelt"
                },
                {
                    quote: "The only way to achieve the impossible is to believe it is possible",
                    author: "Charles Kingsleigh"
                },
                {
                    quote: "Don't let the fear of falling stop you from flying",
                    author: "Unknown"
                },
                {
                    quote: "If you're not willing to risk, you cannot grow",
                    author: "Unknown"
                },
                {
                    quote: "Success is the sum of small efforts repeated day in and day out",
                    author: "Robert Collier"
                },
                {
                    quote: "Dreams are postponed only to be realized",
                    author: "Unknown"
                },
                {
                    quote: "The way to get started is to stop talking and start doing",
                    author: "Walt Disney"
                }
            ],
            timer: false,
            quote: {
                    quote: "A goal without a plan is just a wish",
                    author: "Antoine de Saint-Exupéry"
                }
        }
    },
    mounted() {
        setInterval(() => {
            this.quote = this.quote_list[Math.floor(Math.random() * this.quote_list.length)]
        }, 5000);
    }
}
</script>

<style lang="sass" scoped>
@import "../../assets/_variables"
@import "../../assets/_mixins"


.banner 
  position: relative
  border-radius: 5px
  overflow: hidden
  height: 600px
  @include display-col
  align-items: center
  justify-content: center
  @include tablets-and-up
    height: 400px
  
  &__image 
    display: block
    min-width: 100%
    min-height: 100%
    object-fit: cover


  &__overlay
    position: absolute
    top: 0
    bottom: 0
    left: 0
    right: 0
    background-color: rgba(0,0,0,0.8 )
    @include display-col
    align-items: center
    justify-content: center
    
    &--text 
      color: #f2f2f2
      text-align: center
      padding: 15px

      &-quote 
        font-weight: normal
        font-size: 28px
        font-family: var(--font-family-base)
        
      &-author
        font-size: 20
        text-transform: uppercase
        color: var(--primary)
        font-family: var(--font-family-title)


  
  &__divider
    width: 100%
    height: 3px
    margin: 10px 0
    background: var(--primary)


</style>