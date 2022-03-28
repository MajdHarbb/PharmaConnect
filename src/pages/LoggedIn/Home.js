import React from 'react';
import Chart from '../../components/topbar/Chart';
import FeaturedInfo from '../../components/topbar/FeaturedInfo';

const Home = () => {
    return (
        <div className='home'>
            <FeaturedInfo/>
            <Chart/>
        </div>
    );
};

export default Home;