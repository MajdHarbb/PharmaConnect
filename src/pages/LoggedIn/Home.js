import React from "react";
import Chart from "../../components/topbar/Chart";
import FeaturedInfo from "../../components/topbar/FeaturedInfo";
import WidgetLg from "../../components/topbar/WidgetLg";
import WidgetSm from "../../components/topbar/WidgetSm";
import "../../css/Home.css"
const Home = () => {

  return (
    <div className="home">
      {/* //display components  */}
      <FeaturedInfo />
      <Chart
        title="Medicine Availability Accoding to Governates"
        grid
        
      />
      
    </div>
  );
};

export default Home;
