<template>
    <div class="progressbar"> 
        <div v-for="progress in processSize" :key="progress.index" class="percentage" />
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
            created_at: "2023-06-03T13:53:17.326Z"
          })
        }
    },
    data() {
      return {
        processSize: ["10"],
        bottomText: "Almost there..."
      }
    },
    created() {
      this.setProgress()
    },
    methods: {
      async setProgress() {
        const percentage = await progressBuilder(
          this.process.time_to_reach_in_days, 
          this.process.time_to_reach_in_hours,
          this.process.time_to_reach_in_minutes,
          this.process.created_at
        )
        this.processSize = this.breakIntoTens(percentage.progress)
        this.bottomText = this.buildBottomText(percentage.totalTimeToReachInMinutes, percentage.minutesPassed)
        console.log(percentage)
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


</style>