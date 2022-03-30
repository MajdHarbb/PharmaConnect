import React from "react";
import "../../css/SideBar.css";
import {LineStyle,Timeline,TrendingUp,PermIdentity,
Storefront,MailOutline,
DynamicFeed,ChatBubbleOutline,WorkOutline,Report, Check} from "@material-ui/icons";
import { Newspaper } from "@mui/icons-material";
import { Link } from "react-router-dom";

const SideBar = () => {
  return (
    <div>
      <div className="sidebar">
        <div className="sidebarWrapper">
          <div className="sidebarMenu">
            <h3 className="sidebarTitle">Dashboard</h3>
            <ul className="sidebarList">
              <Link to="pharmaconnect" className="link">
                <li className="sidebarListItem active">
                  <LineStyle className="sidebarIcon" />
                  Home
                </li>
              </Link>
              <li className="sidebarListItem">
                <Timeline className="sidebarIcon" />
                Analytics
              </li>
              <li className="sidebarListItem">
                <TrendingUp className="sidebarIcon" />
                Sales
              </li>
            </ul>
          </div>
          <div className="sidebarMenu">
            <h3 className="sidebarTitle">Quick Menu</h3>
            <ul className="sidebarList">
              <Link to="users" className="link">
                <li className="sidebarListItem">
                  <PermIdentity className="sidebarIcon" />
                  Users
                </li>
              </Link>
              <Link to="pharmacies" className="link">
                <li className="sidebarListItem">
                  <Storefront className="sidebarIcon" />
                  Pharmacies
                </li>
              </Link>
              <Link to="posts" className="link">
              <li className="sidebarListItem">
                <Newspaper className="sidebarIcon" />
                Posts
              </li>
              </Link>
              
              <li className="sidebarListItem">
                <Check className="sidebarIcon" />
                Solved Posts
              </li>
            </ul>
          </div>
          <div className="sidebarMenu">
            <h3 className="sidebarTitle">Notifications</h3>
            <ul className="sidebarList">
              <li className="sidebarListItem">
                <MailOutline className="sidebarIcon" />
                Mail
              </li>
              <li className="sidebarListItem">
                <DynamicFeed className="sidebarIcon" />
                Feedback
              </li>
              <li className="sidebarListItem">
                <ChatBubbleOutline className="sidebarIcon" />
                Messages
              </li>
            </ul>
          </div>
        </div>
      </div>
    </div>
  );
};

export default SideBar;
