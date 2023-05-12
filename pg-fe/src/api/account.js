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


export default {
    signIn,
    createAccount
  }