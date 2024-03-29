import request from '../utils/request'

export function createAccount (data) {
  return request({
    url: `/auth`,
    method: 'post',
    data: data
  })
}

export function signIn (data) {
  return request({
    url: `/auth/sign_in`,
    method: 'post',
    data: data
  })
}

export function signOut ( access_token, client, uid ) {
  return request({
    url: `/auth/sign_out`,
    method: 'delete',
    headers: {
        'access-token': access_token,
        'uid': uid,
        'client': client
    }
  })
}

export function updateAccount (data, access_token, client, uid) {

  return request({
    url: '/auth',
    method: 'put',
    data: data,
    headers: {
      'access-token': access_token,
      'uid': uid,
      'client': client
  }
  })
}

export function forgetPassword (data) {
  return request({
    url: `/auth/password`,
    method: 'post',
    data: data
  })
}

export function resetPassword (data, access_token, client, uid) {
  return request({
    url: `/auth/password`,
    method: 'put',
    data: data,
    headers: {
      'access-token': access_token,
      'uid': uid,
      'client': client
  }
  })
}


export default {
    signIn,
    createAccount,
    updateAccount,
    forgetPassword,
    signOut,
    resetPassword
  }