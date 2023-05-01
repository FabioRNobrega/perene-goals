import axios from 'axios'

const service = axios.create({
  baseURL: import.meta.env.BASE_URL,
  timeout: 5000
})

service.interceptors.request.use(
  config => {
    return config
  },
  error => {
    return Promise.reject(error)
  }
)

export default service
