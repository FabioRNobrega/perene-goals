import { createApp } from 'vue'
import { createPinia } from 'pinia'

import App from './App.vue'
import router from './router'

if ('serviceWorker' in navigator) {
    navigator.serviceWorker.register(
      import.meta.env.MODE === 'production' ? '/service-worker.js' : '/dev-sw.js?dev-sw'
    )
  }

const app = createApp(App)

app.use(createPinia())
app.use(router)

app.mount('#app')
