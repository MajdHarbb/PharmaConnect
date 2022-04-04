import React from 'react';
import { Navigate, Outlet } from 'react-router-dom';
//check if token exists in local storage
const useAuth = () => {
    console.log("test"+localStorage.getItem('access_token'));
    var user = {loggedIn: false}
    if(localStorage.getItem('access_token') != null &&localStorage.getItem('id')!= null){
        user = {loggedIn: true};
        return user && user.loggedIn;
    }else{
        
    }
    
    return user && user.loggedIn;
}
//if user is authenticated allow outlet children, else nigavigate back to login page
const ProtectedRoutes = () => {
    const isAuth = useAuth();
    return isAuth?<Outlet/> : <Navigate to="/"/>;
};

export default ProtectedRoutes;