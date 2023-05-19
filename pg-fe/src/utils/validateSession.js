import { validateSession } from "../api/session";

export async function isAuthenticated() {
    const userAuth = JSON.parse(localStorage.getItem('user-auth'));
    if (userAuth !== null && typeof userAuth !== 'undefined') {      
        if (userAuth && userAuth['access-token'] && userAuth['client'] && userAuth['uid']) {
          try {
            const { data } = await validateSession(userAuth['access-token'], userAuth['client'], userAuth['uid']);
            return data.success;
          } catch (error) {
            console.error(error);
          }
        }
    } else {
        return false
    }
}
  

  