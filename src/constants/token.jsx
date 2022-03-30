const access_token=localStorage.getItem("access_token");
const AuthStr = 'Bearer '.concat(access_token); 

export {
    access_token,
    AuthStr,
}