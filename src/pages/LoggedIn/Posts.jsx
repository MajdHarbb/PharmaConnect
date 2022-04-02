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
      <div className="wrapperr">
        <div className="header">
          <h1>Pharma Connect Solved Posts</h1>
        </div>
        <div className="cards_wrap">
          {posts.map((singlePost) => {
            return (
              <div className="card_item">
                <div className="card_inner">
                  <div className="topbaruser">
                    <div>
                      <div className="userdiv">
                        <div>
                        
                  <img className="profile" src={`http://127.0.0.1:8000/profiles/${singlePost.profile_pic}?v=${Math.round(Date.now() / 1000)}`} />

                        </div>

                        <div>
                          <div className="name">{singlePost.name}</div>
                          <div className="date">
                            {singlePost.updated_at.split("T")[0]}
                          </div>
                        </div>
                      </div>
                    </div>
                    <div>
                      <div className="delete"></div>
                    </div>
                  </div>

                  <div className="text">{singlePost.post_text}</div>
                  <div className="postimg">
                    
              <img src={`http://127.0.0.1:8000/posts/${singlePost.post_pic}?v=${Math.round(Date.now() / 1000)}`} />

                  </div>
                </div>
              </div>
            );
          })}
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
