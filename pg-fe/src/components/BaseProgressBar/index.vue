<template>
    <div class="progressbar"> 
      <div v-for="(progress, index) in processSize" :key="index" :class="['percentage', { 'percentage_animation': this.process.completed}]" />
    </div>
    <h6 class="base-text-light"> {{ bottomText }} </h6>
</template>

<script>
import { progressBuilder } from '../../utils/calculateProgress'

export default {
    name: "BaseProgressBar",
    props: {
        process: {
          type: Object,
          required: false,
          default: () => ({   
            time_to_reach_in_days: 30,
            time_to_reach_in_hours: 0,
            time_to_reach_in_minutes: 0,
            started_at: "2023-06-03T13:53:17.326Z",
            completed: false
          })
        }
    },
    data() {
      return {
        processSize: ["10"],
        bottomText: "Almost there...",
        completedCommemorationText: [
        "Congratulations on achieving another milestone!",
        "Way to go! You've conquered yet another goal!",
        "You did it! Another goal successfully accomplished!",
        "Bravo! Another target hit and triumphed!",
        "Hooray! Celebrating another goal fully accomplished!",
        "Well done! Another mission accomplished!",
        "Fantastic work! You've reached and surpassed another goal!",
        "Cheers to your relentless determination and another goal ticked off!",
        "Amazing job! Another goal conquered with flying colors!",
        "Woo-hoo! Another goal completely crushed! Keep up the great work!",
        "Kudos on reaching another milestone!",
        "Outstanding! You've triumphed over another goal!",
        "Mission accomplished! Another goal successfully completed!",
        "Brilliant! Another target hit and conquered!",
        "Hip, hip, hooray! Celebrating another goal fully achieved!",
        "Terrific job! Yet another mission accomplished!",
        "Incredible work! You've reached and exceeded another goal!",
        "Here's to your unwavering determination and another goal checked off!",
        "Superb effort! Another goal conquered with flying colors!",
        "Woohoo! Another goal completely smashed! Keep up the phenomenal work!",
        "Well played! Another milestone nailed with style!",
        "Amazing achievement! You're unstoppable!",
        "Hats off to you for reaching another fantastic milestone!",
        "You've done it again! Another goal conquered like a champion!",
        "Thumbs up for another remarkable goal achievement!",
        "Impressive work! You've mastered yet another goal!",
        "Congratulations! Another goal successfully completed!",
        "Victory dance time! You've reached another amazing goal!",
        "You're on fire! Another goal triumphed!",
        "Well deserved celebrations for another goal conquered!",
        "High fives all around for another outstanding achievement!",
        "Unbelievable! You've accomplished another remarkable goal!",
        "Keep it up! Another goal bites the dust!",
        "Bravo! You're on a roll with another goal knocked out!",
        "Incredible progress! Another goal unlocked!",
        "You're making it happen! Another goal ticked off the list!",
        "Spectacular job! Another goal conquered and celebrated!",
        "Three cheers for another successful goal completion!",
        "You're unstoppable! Another goal slayed with finesse!",
        "Congrats on another momentous achievement!",
        "Way to go! You've nailed another challenging goal!",
        "You've got this! Another goal mastered!",
        "Absolutely amazing! Another goal triumphed with excellence!",
        "Hurray! Another goal crushed and conquered!",
        "Great job! Another goal knocked out of the park!",
        "You're an inspiration! Another goal conquered against all odds!",
        "Marvelous work! Another goal successfully achieved!",
        "Cheers to your dedication and another goal successfully accomplished!",
        "Incredible determination! Another goal defeated!",
        "Well done! Another goal tackled and conquered!",
        "You've surpassed expectations! Another goal owned and completed!",
        "Keep shining! Another goal conquered with flying colors!",
        "Remarkable effort! Another goal surpassed and celebrated!"
        ]
      }
    },
    mounted() {
      this.setProgress()
    },
    watch: {
      process(newValue) {
        if (newValue) {
          this.setProgress();
        }
      }
    },
    methods: {
      async setProgress() {
        if(this.process.completed) {
          this.processSize = this.breakIntoTens(100)
          this.bottomText = this.completedCommemorationText[Math.floor(Math.random() * this.completedCommemorationText.length)]
        } else {
          const percentage = await progressBuilder(
            this.process.time_to_reach_in_days, 
            this.process.time_to_reach_in_hours,
            this.process.time_to_reach_in_minutes,
            this.process.start_at
          )
          this.processSize = this.breakIntoTens(percentage.progress)
          this.bottomText = this.buildBottomText(percentage.totalTimeToReachInMinutes, percentage.minutesPassed)
        }
      },
     breakIntoTens(number) {
        const result = [];
        const iterations = Math.ceil(number / 10);

        for (let i = 0; i < iterations; i++) {
          result.push("10%");
        }

        return result;
      },
      buildBottomText(totalTimeToReachInMinutes, minutesPassed) {
        if (totalTimeToReachInMinutes < 60) {
          return `${minutesPassed} complete minutes out of ${totalTimeToReachInMinutes} minutes`;
        } else if (totalTimeToReachInMinutes < 1440) {
          const totalHours = Math.floor(totalTimeToReachInMinutes / 60);
          const hoursPassed = Math.floor(minutesPassed / 60);
          const hoursText = totalHours === 1 ? 'hour' : 'hours';
          return `${hoursPassed} complete ${hoursText} out of ${totalHours} ${hoursText}`;
        } else {
          const totalDays = Math.floor(totalTimeToReachInMinutes / 1440);
          const daysPassed = Math.floor(minutesPassed / 1440);
          const daysText = totalDays === 1 ? 'day' : 'days';
          return `${daysPassed} complete ${daysText} out of ${totalDays} ${daysText}`;
        }
      }
    }

}
</script>

<style lang="sass" scoped>
@import "../../assets/main"
@import "../../assets/_mixins"
@import "../../assets/_variables"


.progressbar
  width: 100%
  height: 20px
  margin-top: 20px
  margin-bottom: 5px
  border-radius: 5px
  overflow: hidden
  background-color: var(--neutral-color-lighter)
  @include display-row
  align-items: center
  justify-content: flex-start
  

.percentage
  width: 10%
  height: 20px
  background-color: var(--primary)

  &_animation
    animation: progressbar-slide-in 5s ease-in-out


@keyframes progressbar-slide-in
  0%
    width: 0
  100%
    width: 100%


</style>