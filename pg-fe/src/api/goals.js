import request from '../utils/request'

  export function createGoal(goals_list_id, data, access_token, client, uid ) {
    return request({
      url: `/goals-list/${goals_list_id}/goals`,
      method: 'post',
      data: data,
      headers: {
          'access-token': access_token,
          'uid': uid,
          'client': client
      }
    })
  }

  export function updateGoal(goals_id, data, access_token, client, uid ) {
    return request({
      url: `/goals/${goals_id}`,
      method: 'patch',
      data: data,
      headers: {
          'access-token': access_token,
          'uid': uid,
          'client': client
      }
    })
  }


  export function fetchGoalsWithSteps(goals_id, access_token, client, uid ) {
    return request({
      url: `/goals/${goals_id}/steps`,
      method: 'get',
      headers: {
          'access-token': access_token,
          'uid': uid,
          'client': client
      }
    })
  }

  export function deleteGoal (id, access_token, client, uid ) {
    return request({
      url: `/goals/${id}`,
      method: 'delete',
      headers: {
          'access-token': access_token,
          'uid': uid,
          'client': client
      }
    })
  }
  
  
  
export default {
    createGoal,
    updateGoal,
    deleteGoal,
    fetchGoalsWithSteps
  }