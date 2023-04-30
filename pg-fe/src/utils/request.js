import axios from 'axios'

const service = axios.create({
  baseURL: 'http://0.0.0.0:3000/api',
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
