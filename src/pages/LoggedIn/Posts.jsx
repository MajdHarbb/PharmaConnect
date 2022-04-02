import React from "react";
import { useState, useEffect } from "react";
import axios from "axios";
import * as css from "../../css/Posts.css";
import { Check } from "@material-ui/icons";
import DeleteRoundedIcon from "@mui/icons-material/DeleteRounded";
const Posts = () => {
  var access_token = localStorage.getItem("access_token");
  const AuthStr = "Bearer ".concat(access_token);

  const [posts, setPosts] = useState([]);

  const [isLoading, setLoading] = useState(false);

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
        setLoading(true);
      })
      .catch((error) => {
        console.log("error " + error);
      });
  }, []);

  if (isLoading) {
    return (
      <div>
        <div className="main__body">
          <div className="feed">
            {posts.map((singlePost) => {
              return (
                <div className="post">
                  <div className="post__top">
                    <img
                      className="user__avatar post__avatar"
                      src={`http://127.0.0.1:8000/profiles/${
                        singlePost.profile_pic
                      }?v=${Math.round(Date.now() / 1000)}`}
                    />
                    <div className="post__topInfo">
                      <h3>{singlePost.name}</h3>
                      <p>{singlePost.updated_at.split("T")[0]}</p>
                    </div>
                  </div>
                  <div className="post__bottom">
                    <p>{singlePost.post_text}</p>
                  </div>
                  <div className="post__image">
                    <img
                      src={`http://127.0.0.1:8000/posts/${
                        singlePost.post_pic
                      }?v=${Math.round(Date.now() / 1000)}`}
                    />
                  </div>
                </div>
              );
            })}
            ;
          </div>
          {/* feed ends */}
        </div>
      </div>
    );
  } else {
    return (
      <div>
        <h1>Loading</h1>
      </div>
    );
  }
  
};

export default Posts;
