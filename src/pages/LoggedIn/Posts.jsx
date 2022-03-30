import React from "react";
import { useState, useEffect } from "react";
import axios from "axios";
const Posts = () => {


    var access_token = localStorage.getItem("access_token");
    const AuthStr = "Bearer ".concat(access_token);

    const [posts,setPosts]=useState([]);
    useEffect(() => {
        axios
            .get("http://127.0.0.1:8000/api/admin/solved", {
                headers: { Authorization: AuthStr },
            })
            .then((response) => {
                // If request is good...
                console.log(response.data);
                setPosts(response.data)
                console.log(posts)
                
            })
            .catch((error) => {
                console.log("error " + error);
            });
    }, []);

    return (
    <div>
        {posts.map(singlePost => {
            return (
                <div className="newsfeed">
                <div className="newsfeed_header">
                  <div className="newsfeed_header__left">
                    <h1>News</h1>
                    <span>All</span>
                    <input id="dropdown" type="checkbox" />
                    <label htmlFor="dropdown">
                      <img src="https://s3-us-west-2.amazonaws.com/s.cdpn.io/343086/arrowDown.png" />
                      <ul>
                        <li>All</li>
                        <li>Web Design</li>
                        <li>Web Development</li>
                      </ul>
                    </label>
                  </div>
                  <div className="newsfeed_header__right">
                    <h1>Posts</h1>
                    <span>14.2 K</span>
                  </div>
                </div>
                <div className="newsfeed_articlecontainer">
                  <div className="newsfeed_articlecontainer__article" id="first">
                    <div className="article_published">
                      <p>Published in</p>
                      <a href="#">Sideblog</a>
                    </div>
                    <div className="article_title">
                      <h1>Web Development Reading List #100</h1>
                    </div>
                    <div className="article_content">
                      <p>
                        What's happening in the industry? What important techniques have
                        emerged recently? What about new case studies, insights,
                        techniques and tools?
                      </p>
                    </div>
                    <div className="article_profile">
                      <img src="https://s3-us-west-2.amazonaws.com/s.cdpn.io/343086/profile_icon.png" />
                      <a href="https://codepen.io/CubiDesigns" target="_blank">
                        Reece McDonald
                      </a>
                      <p>3hrs ago</p>
                    </div>
                  </div>
                  <div className="newsfeed_articlecontainer__article" id="second">
                    <div className="article_published">
                      <p>Published in</p>
                      <a href="#">Sideblog</a>
                    </div>
                    <div className="article_title">
                      <h1>Web Development Reading List #101</h1>
                    </div>
                    <div className="article_content">
                      <p>
                        What's happening in the industry? What important techniques have
                        emerged recently? What about new case studies, insights,
                        techniques and tools?
                      </p>
                    </div>
                    <div className="article_profile">
                      <img src="https://s3-us-west-2.amazonaws.com/s.cdpn.io/343086/profile_icon.png" />
                      <a href="https://codepen.io/CubiDesigns" target="_blank">
                        Reece McDonald
                      </a>
                      <p>3hrs ago</p>
                    </div>
                  </div>
                </div>
                <div className="newsfeed_navigation">
                  <div className="newsfeed_navigation__titlecontainer">
                    <h1>Web Development Reading List #100</h1>
                    <h1>Web Development Reading List #101</h1>
                  </div>
                  <p>Next: Web Design Conferences Are Booming</p>
                  <div className="newsfeed_navigation__timerbar" />
                </div>
              </div>
            )
        })}
    </div>
    );
};

export default Posts;
