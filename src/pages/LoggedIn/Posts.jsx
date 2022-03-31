import React from "react";
import { useState, useEffect } from "react";
import axios from "axios";
import * as css from "../../css/Posts.css";
import { Check } from "@material-ui/icons";
import DeleteRoundedIcon from '@mui/icons-material/DeleteRounded';
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
  if(isLoading){
  return (
  <div className="wrapperr">
  <div className="header">Pharma Connect Solved Posts</div>
  <div className="cards_wrap">
      {posts.map((singlePost) => {
        return (
            
          // <div id="posts-div">
              
          //   <div className="post">
          //     <div className="post-top">
          //       <div className="dp">
          //         <img src={require("../../assets/profiles/"+singlePost.profile_pic)} alt />
          //       </div>
          //       <div className="post-info">
          //         <a href="#">
          //           <p className="name">{singlePost.name}</p>
          //         </a>
          //         <span className="time">{singlePost.updated_at}</span>
          //       </div>
          //       <div className="delete">
          //         <DeleteRoundedIcon/>
          //       </div>
          //     </div>
          //     <div className="post-content">
          //     {singlePost.post_text}
          //     {/* <img src={require("../../assets/posts/"+singlePost.post_pic)}
          //       alt="" /> */}
              
          //     </div>
          //     <div className="post-bottom">
          //       <div className="action">
          //         <Check/>
          //         <span>Solved </span>
          //       </div>
          //       {/* <div className="action">
          //         <i className="far fa-heart" />
          //         <span>Love</span>
          //       </div> */}
          //     </div>
          //   </div>
          // </div>
<div className="card_item">
  <div className="card_inner">
    <img src="post" />
    <div className="name">test</div>
    <div className="date">test</div>
    <div className="post-text">Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod
      tempor incididunt ut labore et dolore magna aliqua.</div>
  </div>
</div>



        );
      })}
        </div>
</div>
  );
    }else{
      return(
        <div>
          <h1>Loading</h1>
        </div>
      )
    }
};

export default Posts;
