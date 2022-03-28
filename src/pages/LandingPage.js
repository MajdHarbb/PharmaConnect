import React from 'react';
import SideBar from '../components/topbar/SideBar';
import Topbar from '../components/topbar/Topbar';
import "../css/LandingPage.css";
const LandingPage = () => {
    return (
        <div>
            <Topbar/>
            <div className='container'>
                <SideBar/>
                
                <div className='others'>
                other pages
                </div>
            </div>
            
        </div>
    );
};

export default LandingPage;