import request from '../utils/request'

export function validateSession ( access_token, client, uid ) {
  return request({
    url: `/auth/validate_token`,
    method: 'get',
    headers: {
        'access-token': access_token,
        'uid': uid,
        'client': client
    }
  })
}


export default {
    validateSession
  }