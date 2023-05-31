import request from '../utils/request'

export function goalsListPublic () {
  return request({
    url: `/all-goals-list`,
    method: 'get'
  })
}

export function goalsListPrivate (access_token, client, uid ) {
    return request({
      url: `/my-goals-list`,
      method: 'get',
      headers: {
          'access-token': access_token,
          'uid': uid,
          'client': client
      }
    })
  }
  
  export function createGoalsList (data, access_token, client, uid ) {
    return request({
      url: `/goals-list`,
      method: 'post',
      data: data,
      headers: {
          'access-token': access_token,
          'uid': uid,
          'client': client
      }
    })
  }
  
  
export default {
    createGoalsList,
    goalsListPublic,
    goalsListPrivate
  }