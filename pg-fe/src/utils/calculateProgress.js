export async function progressBuilder(timeToReachInDays, timeToReachInHours, timeToReachInMinutes, createdAt) {
    const totalMinutes = convertDaysToMinutes(timeToReachInDays) +
    convertHoursToMinutes(timeToReachInHours) +
    timeToReachInMinutes;
    const minutesPassed = calculateMinutesPassed(createdAt);
    const progress = calculateProgressPercentage(totalMinutes, minutesPassed);
   return { progress: progress, totalTimeToReachInMinutes: totalMinutes, minutesPassed:  minutesPassed }       
  }
  

function convertDaysToMinutes(days) {
    const minutesInDay = 24 * 60; // 24 horas * 60 minutos
    const minutes = days * minutesInDay;
    return minutes;
  }
  
function convertHoursToMinutes(hours) {
    const minutes = hours * 60;
    return minutes;
}
  
function calculateMinutesPassed(creationDate) {
    const currentDate = new Date();
    const parsedCreationDate = new Date(creationDate);
    
    const timeDifferenceInMilliseconds = currentDate - parsedCreationDate;
    const minutesPassed = Math.floor(timeDifferenceInMilliseconds / 1000 / 60);
  
    return minutesPassed;
  }
  
function calculateProgressPercentage(totalMinutes, minutesPassed) {
    const percentage = (minutesPassed / totalMinutes) * 100;
    const roundedPercentage = Math.ceil(percentage / 5) * 5;

    return roundedPercentage
}
  
  