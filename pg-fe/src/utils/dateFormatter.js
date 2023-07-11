export async function formatDate(date) {
    const new_date = new Date(date)
    const formattedDate = new_date.toISOString().split("T")[0]

   return formattedDate       
  }
  
