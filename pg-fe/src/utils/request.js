import axios from 'axios'

const service = axios.create({
  baseURL: import.meta.env.VITE_PG_CORE,
  timeout: 50000
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
