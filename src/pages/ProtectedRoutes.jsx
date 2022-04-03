import React from 'react';
import { Navigate, Outlet } from 'react-router-dom';
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
const ProtectedRoutes = () => {
    const isAuth = useAuth();
    return isAuth?<Outlet/> : <Navigate to="/"/>;
};

export default ProtectedRoutes;