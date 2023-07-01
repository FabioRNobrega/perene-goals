import request from '../utils/request'

  export function createGoalStep(goals_id, data, access_token, client, uid ) {
    return request({
      url: `/goals/${goals_id}/steps`,
      method: 'post',
      data: data,
      headers: {
          'access-token': access_token,
          'uid': uid,
          'client': client
      }
    })
  }

  export function updateGoalStep(step_id, data, access_token, client, uid ) {
    return request({
      url: `/goals-step/${step_id}`,
      method: 'patch',
      data: data,
      headers: {
          'access-token': access_token,
          'uid': uid,
          'client': client
      }
    })
  }  
  

  export function deleteGoalsSteps (id, access_token, client, uid ) {
    return request({
      url: `/goals-step/${id}`,
      method: 'delete',
      headers: {
          'access-token': access_token,
          'uid': uid,
          'client': client
      }
    })
  }

export default {
    createGoalStep,
    updateGoalStep,
    deleteGoalsSteps
}