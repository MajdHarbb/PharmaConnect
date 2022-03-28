import React from "react";
import Chart from "../../components/topbar/Chart";
import FeaturedInfo from "../../components/topbar/FeaturedInfo";
import WidgetLg from "../../components/topbar/WidgetLg";
import WidgetSm from "../../components/topbar/WidgetSm";
import { userData } from "../../Data/DummyData";
import "../../css/Home.css"
const Home = () => {
  return (
    <div className="home">
      <FeaturedInfo />
      <Chart
        data={userData}
        title="User Analytics"
        grid
        dataKey="Active User"
      />
      <div className="homeWidgets">
        <WidgetSm />
        <WidgetLg />
      </div>
    </div>
  );
};

export default Home;
