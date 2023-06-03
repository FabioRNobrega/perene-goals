import request from '../utils/request'

export function goalsListPublic (page) {
  return request({
    url: `/all-goals-list?page=${page}&per_page=10&sort=created_at&dir=desc`,
    method: 'get'
  })
}

export function fetchGoalsList (id, access_token, client, uid ) {
  return request({
    url: `goals-list/${id}`,
    method: 'get',
    headers: {
        'access-token': access_token,
        'uid': uid,
        'client': client
    }
  })
}

export function goalsListPrivate (access_token, client, uid ) {
    return request({
      url: `/my-goals-list?page=1&per_page=5&sort=created_at&dir=desc`,
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