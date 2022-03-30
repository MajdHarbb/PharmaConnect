import {CalendarToday,LocationSearching,MailOutline,PermIdentity,PhoneAndroid,Publish,} from "@material-ui/icons";
import "../../css/User.css";
import { useState ,useEffect } from "react";
import { useNavigate, useParams } from "react-router-dom";
import axios from "axios";

export default function User() {
  const navigate = useNavigate();
  //params to get user id
  const params = useParams();
  //get token from local storage
  var access_token=localStorage.getItem("access_token");
  const AuthStr = 'Bearer '.concat(access_token); 
  var user_info = [];

  const [email, setEmail] = useState("");
  const [name, setname] = useState("");
  const [phone, setPhone] = useState("");

  var [data, setData] = useState([]);
  var [profile_pic, setProfile] = useState("defualt_profile_picture_pharmaConnect.png");
  const [p,setP] = useState("defualt_profile_picture_pharmaConnect.png");
  //state that is to be set to true when api is fetched
  const [isLoading, setLoading] = useState(false);
  
  function update(e) {
    e.preventDefault();
    console.log('You clicked submit.');
    console.log(typeof(params.userId))
    const id = params.userId;
    axios.get(`http://127.0.0.1:8000/api/admin/update-patient-info?user_id=${id}`,
     { headers: { Authorization: AuthStr } })
   .then(response => {
       console.log("response",response.data)
    })
   .catch((error) => {
       console.log('error ' + error);
    });
  }
  function navigateNewUser() {
    navigate(`newUser`);
  }

  useEffect(() => {
    axios.get(`http://127.0.0.1:8000/api/admin/patient-info?user_id=${params.userId}`, { headers: { Authorization: AuthStr } })
   .then(response => {
       
       console.log("response",response.data)
       user_info = response.data;
       console.log("info" ,user_info)
       setData(user_info[0]);
      console.log("data",data)
      //  console.log("to strin")
      //  console.log(data["profile_pic"])
      //  setProfile(data["profile_pic"])
      //  //console.log(typeof(profile_pic))
      //  console.log(profile_pic)
       setLoading(true);
      
    })
   .catch((error) => {
       console.log('error ' + error);
    });
  },[]);
  if(isLoading){
    return (
      <div className="user">
        <div className="userTitleContainer">
          <h1 className="userTitle">Edit User</h1>
  
          <button className="userAddButton" onClick={navigateNewUser}>
            Create
          </button>
        </div>
        <div className="userContainer">
          <div className="userShow">
            <div className="userShowTop">
              <img
                src={require("../../assets/profiles/"+data["profile_pic"])}
                alt=""
                className="userShowImg"
              />
              <div className="userShowTopTitle">
                <span className="userShowUsername">{data["name"]}</span>
                <span className="userShowUserTitle">Software Engineer</span>
              </div>
            </div>
            <div className="userShowBottom">
              <span className="userShowTitle">Account Details</span>
              <div className="userShowInfo">
                <PermIdentity className="userShowIcon" />
                <span className="userShowInfoTitle">{data["name"]}</span>
              </div>
              <div className="userShowInfo">
                <CalendarToday className="userShowIcon" />
                <span className="userShowInfoTitle">{data["updated_at"]}</span>
              </div>
              <span className="userShowTitle">Contact Details</span>
              <div className="userShowInfo">
                <PhoneAndroid className="userShowIcon" />
                <span className="userShowInfoTitle">{data["phone"]}</span>
              </div>
              <div className="userShowInfo">
                <MailOutline className="userShowIcon" />
                <span className="userShowInfoTitle">{data["email"]}]</span>
              </div>
              <div className="userShowInfo">
                <LocationSearching className="userShowIcon" />
                <span className="userShowInfoTitle">New York | USA</span>
              </div>
            </div>
          </div>
          <div className="userUpdate">
            <span className="userUpdateTitle">Edit</span>
            <form className="userUpdateForm">
              <div className="userUpdateLeft">

                <div className="userUpdateItem">
                  <label>Full Name</label>
                  <input
                    type="text"
                    placeholder={data["name"]}
                    className="userUpdateInput"
                    onChange={(e) => setname(e.target.value)}
                  />
                </div>
                <div className="userUpdateItem">
                  <label>Email</label>
                  <input
                    type="text"
                    placeholder={data["email"]}
                    className="userUpdateInput"
                    onChange={(e) => setEmail(e.target.value)}
                  />
                </div>
                <div className="userUpdateItem">
                  <label>Phone</label>
                  <input
                    type="text"
                    placeholder={data["phone"]}
                    className="userUpdateInput"
                    onChange={(e) => setPhone(e.target.value)}
                  />
                </div>

              </div>
              <div className="userUpdateRight">
                <div className="userUpdateUpload">
                  <img
                    className="userUpdateImg"
                    src={require("../../assets/profiles/"+data["profile_pic"])}
                    alt=""
                  />
                  <label htmlFor="file">
                    <Publish className="userUpdateIcon" />
                  </label>
                  <input type="file" id="file" style={{ display: "none" }} />
                </div>
                <button className="userUpdateButton" onClick={update}>Update</button>
              </div>
            </form>
          </div>
        </div>
      </div>
    );
  }else{
    return(
      <div>
        <h1>Loading...</h1>
      </div>
    );
  }

}
