import React from 'react'
import "../../css/Topbar.css";
import "../../assets/profile_pictures/test.jpg"
import { NotificationsNone , Language, Settings} from "@material-ui/icons";

export default function Topbar() {
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
            <Settings />
          </div>
          <img src={require('../../assets/profile_pictures/test.jpg')} alt="" className="topAvatar" />
        </div>
      </div>
    </div>
  )
}
