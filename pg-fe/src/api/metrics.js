import request from '../utils/request'

  export function fetchGoalsListMetrics(goal_list_id, access_token, client, uid) {
    return request({
      url: `/metrics/goal-list/${goal_list_id}`,
      method: 'get',
      headers: {
        'access-token': access_token,
        'uid': uid,
        'client': client
    }
    })
  }

  export function fetchGoalsMetrics(goal_id, access_token, client, uid) {
    return request({
      url: `/metrics/goal/${goal_id}`,
      method: 'get',
      headers: {
        'access-token': access_token,
        'uid': uid,
        'client': client
    }
    })
  }

  
export default {
  fetchGoalsMetrics,
  fetchGoalsListMetrics
}