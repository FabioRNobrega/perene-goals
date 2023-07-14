<template>
 
  <TopNavbar >
    <template v-slot:iconLeft>
      <SVGIcon icon-name="back"  @click="this.$router.push('/learning')"/>
    </template>
    <template v-slot:iconRight>
      <SVGIcon icon-name="home" @click="this.$router.push('/')"/>
    </template>
  </TopNavbar>
  
  <main class="base-container">
    <div class="post__header"> 
      <div>
        <h3 class="base-title">{{ post.title }} </h3>
        <h5 class="post__header--author"> by {{ post.author }}</h5>
        <div class="post__header--description" v-html="post.description" />
      </div>
      <div>
        <a :href="post.reference_link">
          <img class="post__header--image" :src="post.image_link" :alt="`Click and buy ${post.title}`" />
        </a>
        <BaseButton :light="true" icon="amazon" :small="true" content="Buy the book" @click="handleBuyBook(post.reference_link)"/>
      </div> 
    </div>
  </main>
</template>

<script>
import TopNavbar from '../components/TopNavBar/index.vue'
import SVGIcon from '../components/SVGIcon/index.vue'
import BaseButton from '../components/BaseButton/index.vue'
import { fetchLearningPost } from '../api/learning'

export default {
  name: "LearningPostView",
  components: {
    TopNavbar,
    SVGIcon,
    BaseButton
  },
  data() {
    return {
      post: {}
    }
  },
  created() {
    this.setData()
  },
  methods: {
    async setData() {
      this.routeId = this.$route.params.id;
      try {
        const { data } = await fetchLearningPost(this.routeId)
        this.post = data
      } catch (error) {
        console.log(error)
      }
    },
    handleBuyBook(amazon_link) {
      window.open(amazon_link, "_blank")
    }
  }
}

</script>

<style lang="sass">
@import "../assets/main"
@import "../assets/_variables"
@import "../assets/_mixins"

.post
  &__header 
    @include display-col

    @include tablets-and-up 
      @include display-row
    
    &--description
      font-family: var(--font-family-base)
      color: var(--secondary)

      p 
        margin: 20px 30px 20px 5px 
        line-height: 1.5em
        font-size: 14px 
        font-weight: lighter

      h3
        font-family: var(--font-family-title)

    &--image 
      width: 100%
      margin-bottom: 20px
      border-radius: 5px
      border: 2px solid var(--secondary)
      
      @include tablets-and-up 
        height: 250px
        width: 150px

    &--author
      font-family: var(--font-family-base)
      font-style: italic
      font-weight: lighter
      margin: 10px 0

</style>
