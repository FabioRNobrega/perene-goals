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

    <p class="base-text">
      Welcome to the Learning page of Perene Goals, where we provide valuable insights 
      and resources to help you make the most of our app. In the 'Learning How to Use 
      Perene Goals' section,<strong> we'll guide you through the process of harnessing the power 
      of breaking goals into small steps, enabling you to achieve remarkable results </strong>. 
      Our proven methodology, combined with the seamless user experience of Perene Goals, 
      will empower you to turn your dreams into reality.
    </p>
    <p class="base-text">
      But that's not all. In the 'Know More About Personal Goals' section, we take it a 
      step further. We understand that personal growth encompasses various aspects of 
      life, including books, movies, and podcasts. <strong>  We've curated a collection of inspiring 
      and thought-provoking resources that delve into the world of personal goals </strong>. As avid 
      believers in our own methodology, we've personally experienced the transformation 
      effects of breaking goals down into manageable steps. Now, we want to share with you 
      the works that have inspired us along the way.
    </p>

    <BaseTab buttonRight="Learning how to use Perene Goals" buttonLeft="Know more about Personal Goals">
      <template v-slot:contentRight>
        <h3> TUTORIAL</h3>
      </template>

      <template v-slot:contentLeft>
        <p class="base-text">
          <strong>Welcome to the 'Know More About Personal Goals' section, where we dive into 
          the transformative power of books, movies, and podcasts in conjunction with 
          the remarkable Perene Goals app </strong>. As the creator of Perene Goals and a t
          rue believer in the potential of personal growth, I've witnessed firsthand
          the profound impact that breaking goals into small steps can have on our lives. 
          But it doesn't stop there. We understand that personal growth is a multifaceted
          journey, and that's why we've curated a collection of inspiring resources
          that complement the principles of Perene Goals.  <strong> These handpicked books, 
          captivating movies, and enlightening podcasts offer a wealth of knowledge,
          motivation, and guidance. Together with the seamless experience of Perene Goals,
          they form an unstoppable force that will propel you towards your personal goals </strong>. 
          As Alan Mathison Turing once said, 'We can only see a little bit of the future, 
          but enough to know there is much to do.' Embrace the synergy between Perene Goals 
          and these invaluable resources, and embark on a journey of personal growth that 
          will forever change your life."
        </p>
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
      </template>

    </BaseTab>
  </main>
</template>

<script>
import TopNavbar from '../components/TopNavBar/index.vue'
import SVGIcon from '../components/SVGIcon/index.vue'
import BaseButton from '../components/BaseButton/index.vue'
import BaseCard from '../components/BaseCard/index.vue'
import BaseTab from '../components/BaseTab/index.vue'

import { fetchLearningAllPost } from '../api/learning'

export default {
  name: "LearningView",
  components: {
    TopNavbar,
    SVGIcon,
    BaseCard,
    BaseButton,
    BaseTab
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
        margin: 20px 0
        text-indent: 20px
        text-align: justify
        line-height: 1.5em
        font-size: 16px 
        font-weight: lighter
        @include tablets-and-up 
          margin: 20px 30px 20px 5px 
          
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
