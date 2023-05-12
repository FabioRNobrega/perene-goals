// auth.js

import { validateSession } from "../api/session";

export async function isAuthenticated() {
    const userAuth = JSON.parse(localStorage.getItem('user-auth'));

    try {
        const { success } = await validateSession(userAuth['access-token'], userAuth['client'],userAuth['uid'])
        return success
    } catch (error) {
        console.error(error)
    }
}