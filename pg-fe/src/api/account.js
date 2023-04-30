import request from '../utils/request'

export function createAccount (data) {
  return request({
    url: `/auth`,
    method: 'post',
    data: data
  })
}


export default {
    createAccount
  }