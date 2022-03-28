import React from 'react';
import Chart from '../../components/topbar/Chart';
import FeaturedInfo from '../../components/topbar/FeaturedInfo';
import { userData } from '../../Data/DummyData';
const Home = () => {
    return (
        <div className='home'>
            <FeaturedInfo/>
            <Chart data={userData} title="User Analytics" grid dataKey="Active User"/>
        </div>
    );
};

export default Home;