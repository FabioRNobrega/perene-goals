<template>
 
  <TopNavbar >
    <template v-slot:iconLeft>
      <SVGIcon icon-name="user"  @click="this.$router.push('/profile')"/>
    </template>
    <template v-slot:iconRight>
      <SVGIcon icon-name="home" @click="this.$router.push('/')"/>
    </template>
  </TopNavbar>
  
  <main class="base-container">
    <h1 class="base-title"> Learning</h1>

    <BaseCard v-for="post in posts" :key="post.id" >
        <template v-slot:header>
          <div class="post-list__header"> 
            <div>
              <h3 >{{ post.title }} </h3>
              <h5 class="post-list__header--author"> by {{ post.author }}</h5>
              <div class="post-list__header--description" v-html="post.description" />
            </div>
            <div>
              <a :href="post.reference_link">
                <img class="post-list__header--image" :src="post.image_link" :alt="`Click and buy ${post.title}`" />
              </a>
            </div> 
          </div>
        </template>
        <template v-slot:row>
          <BaseButton :light="true" icon="details" content="Read Post" @click="handleSeeLearningPost(post.id)"/>
        </template>
      </BaseCard>
  </main>
</template>

<script>
import TopNavbar from '../components/TopNavBar/index.vue'
import SVGIcon from '../components/SVGIcon/index.vue'
import BaseButton from '../components/BaseButton/index.vue'
import BaseCard from '../components/BaseCard/index.vue'
import { fetchLearningAllPost } from '../api/learning'

export default {
  name: "LearningView",
  components: {
    TopNavbar,
    SVGIcon,
    BaseCard,
    BaseButton
  },
  data() {
    return {
      posts: []
    }
  },
  created() {
    this.setData()
  },
  methods: {
    async setData() {
      try {
        const { data } = await fetchLearningAllPost(1)
        this.posts = data
      } catch (error) {
        console.log(error)
      }
    },
    handleSeeLearningPost(post_id) {
      this.$router.push(`/learning/post/${post_id}`)
    }

  }
}

</script>

<style lang="sass">
@import "../assets/main"
@import "../assets/_variables"
@import "../assets/_mixins"

.post-list
  &__header
    @include display-col

    @include tablets-and-up 
      @include display-row
    
    &--description
      font-family: var(--font-family-base)
      color: var(--neutral-color-light)

      p 
        margin: 20px 30px 20px 5px 
        line-height: 1.5em
        font-size: 14px 
        font-weight: lighter

      p:not(:first-child) 
        display: none

      h3
        font-family: var(--font-family-title)
        display: none
    &--image 
      width: 100%
      border-radius: 5px
      
      @include tablets-and-up 
        height: 250px
        width: 150px

    &--author
      font-family: var(--font-family-base)
      font-style: italic
      font-weight: lighter
      margin: 10px 0

</style>
