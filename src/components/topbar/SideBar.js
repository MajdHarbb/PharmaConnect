import React from "react";
import "../../css/SideBar.css";
import {LineStyle,PermIdentity,
Storefront,ChatBubbleOutline, Check} from "@material-ui/icons";
import { Newspaper } from "@mui/icons-material";
import PersonAddAltIcon from '@mui/icons-material/PersonAddAlt';
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
              <Link to="newUser" className="link">
              <li className="sidebarListItem">
                <PersonAddAltIcon className="sidebarIcon" />
                Create User
              </li>
              </Link>
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
              <Link to="allposts" className="link">
              <li className="sidebarListItem">
                <Newspaper className="sidebarIcon" />
                Posts
              </li>
              </Link>
              <Link to="solvedposts" className="link">
              <li className="sidebarListItem">
                <Check className="sidebarIcon" />
                Solved Posts
              </li>
              </Link>
            </ul>
          </div>
          <div className="sidebarMenu">
            <h3 className="sidebarTitle">Notifications</h3>
            <ul className="sidebarList">
              
              
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
