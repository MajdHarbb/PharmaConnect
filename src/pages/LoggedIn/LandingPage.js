import React from "react";
import { Outlet } from "react-router-dom";
import SideBar from "../../components/topbar/SideBar";
import Topbar from "../../components/topbar/Topbar";
import "../../css/LandingPage.css";
import Home from "./Home";
const LandingPage = () => {
  return (
    <div>
      <Topbar />
      <div className="container">
        <SideBar />
        <Outlet />
      </div>
    </div>
  );
};

export default LandingPage;
