import React from "react";
import "../../css/Topbar.css";
import { NotificationsNone, ExitToAppRounded } from "@material-ui/icons";
import axios from "axios";
import { Navigate } from "react-router-dom";
import { useNavigate } from "react-router-dom";

export default function Topbar() {
  let navigate = useNavigate();
  const bearer_token = localStorage.getItem("access_token");

  var url = "http://127.0.0.1:8000/api/auth/user-profile";
  var bearer = "Bearer " + bearer_token;

  const logout = () => {
    //logout fetches logout API that clears the JWT token in server
    async function logoutapi() {
      const response = await fetch("http://127.0.0.1:8000/api/auth/logout", {
        method: "POST",

        headers: {
          Authorization: bearer,
          "Content-Type": "application/json",
        },
      });

      let content = await response.json();
      console.log(content);
    }
    logoutapi();
    //clear local storage
    localStorage.clear();
    //redirect to main page (sign in page)
    let path = `/`;
    navigate(path);
  };
  return (
    <div className="topbar">
      <div className="topbarWrapper">
        <div className="topLeft">
          <span className="logo">PharmaConnect</span>
        </div>
        <div className="topRight">
          <div className="topbarIconContainer">
            <NotificationsNone />
            <span className="topIconBadge">2</span>
          </div>

          <div className="topbarIconContainer">
            <ExitToAppRounded onClick={logout} />
          </div>
          <img
            className="topAvatar"
            src={`http://127.0.0.1:8000/profiles/defualt_profile_picture_pharmaConnect.png?v=${Math.round(
              Date.now() / 1000
            )}`}
          />
        </div>
      </div>
    </div>
  );
}
