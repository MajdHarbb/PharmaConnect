import React from "react";
import { useState, useEffect } from "react";
import axios from "axios";
import * as css from "../../css/Posts.css";
import { Check } from "@material-ui/icons";
const Posts = () => {
  var access_token = localStorage.getItem("access_token");
  const AuthStr = "Bearer ".concat(access_token);

  const [posts, setPosts] = useState([]);
  useEffect(() => {
    axios
      .get("http://127.0.0.1:8000/api/admin/solved", {
        headers: { Authorization: AuthStr },
      })
      .then((response) => {
        // If request is good...
        console.log(response.data);
        setPosts(response.data);
        console.log(posts);
      })
      .catch((error) => {
        console.log("error " + error);
      });
  }, []);

  return (
    <div className="main-div">
        <h2>Solved Posts:</h2>
      {posts.map((singlePost) => {
        return (
            
          <div id="posts-div">
              
            <div className="post">
              <div className="post-top">
                <div className="dp">
                  <img src={require("../../assets/profiles/"+singlePost.profile_pic)} alt />
                </div>
                <div className="post-info">
                  <a href="#">
                    <p className="name">{singlePost.name}</p>
                  </a>
                  <span className="time">{singlePost.updated_at}</span>
                </div>
              </div>
              <div className="post-content">
              {singlePost.post_text}
              <img src={require("../../assets/posts/"+singlePost.post_pic)}
                alt="" />
              
              </div>
              <div className="post-bottom">
                <div className="action">
                  <Check/>
                  <span>Solved </span>
                </div>
                {/* <div className="action">
                  <i className="far fa-heart" />
                  <span>Love</span>
                </div> */}
              </div>
            </div>
          </div>
        );
      })}
    </div>
  );
};

export default Posts;
