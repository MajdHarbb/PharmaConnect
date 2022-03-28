import React from 'react';
import SideBar from '../../components/topbar/SideBar';
import Topbar from '../../components/topbar/Topbar';
import "../../css/LandingPage.css";
import Home from './Home';
const LandingPage = () => {
    return (
        <div>
            <Topbar/>
            <div className='container'>
                <SideBar/>
                <Home/>
                
            </div>
            
            
        </div>
    );
};

export default LandingPage;