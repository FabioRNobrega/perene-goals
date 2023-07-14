import request from '../utils/request'

  export function fetchLearningPost(learning_post_id) {
    return request({
      url: `/learning/${learning_post_id}`,
      method: 'get'
    })
  }

  export function fetchLearningAllPost(page) {
    return request({
      url: `/learning?page=${page}&per_page=10&sort=created_at&dir=asc`,
      method: 'get'
    })
  }

  
  
export default {
 fetchLearningPost,
 fetchLearningAllPost
}