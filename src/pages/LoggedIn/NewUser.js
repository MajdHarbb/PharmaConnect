import "../../css/NewUser.css";
import { useState } from "react";
import axios from "axios";

export default function NewUser() {


  //use State to update variables according to user input
  const [name, setName] = useState("");
  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");
  const [phone, setPhone] = useState("");
  const [password_confirmation, setPasswordRepeat] = useState("");


  //email and password regex: email-> example@example.example, password->letters and numbers > 6 characters
  var emailRegex =/^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$/;
  var passRegex = /^[a-zA-Z0-9]{6,}$/;
  var phoneRegex = /^[0-9]{8}$/;

  let axiosConfig = {
    headers: {
      "Content-Type": "application/json;charset=UTF-8",
    },
  };
  const create = (e)=>{
    e.preventDefault();
    //if input is valid fetch register api
    if(email.match(emailRegex) && password.match(passRegex) &&phone.match(phoneRegex) && name!="" && password===password_confirmation){
      axios
      .post(
        `http://127.0.0.1:8000/api/auth/register`,
        { name: name, email: email, phone:phone,
          password: password, password_confirmation:password_confirmation,
          user_type:'patient', profile_pic:'defualt_profile_picture_pharmaConnect.png',
          },
        axiosConfig
      )
      .then((res) => {
        console.log(res.data)
        alert("registered")
        
      });
    }else{
      alert("invalid")
    }
  }
  return (
    <div className="newUser">
      <h1 className="newUserTitle">New User</h1>
      <form className="newUserForm">
        
        <div className="newUserItem">
          <label>Full Name</label>
          <input type="text" placeholder="John Smith" onChange={(e) => setName(e.target.value)}/>
        </div>
        
        <div className="newUserItem">
          <label>Email</label>
          <input type="email" placeholder="john@gmail.com" onChange={(e) => setEmail(e.target.value)}/>
        </div>
        <div className="newUserItem">
          <label>Phone</label>
          <input type="text" placeholder="8 digits ex: 03123456" onChange={(e) => setPhone(e.target.value)}/>
        </div>
        <div className="newUserItem">
          <label>Password</label>
          <input type="password" placeholder="password" onChange={(e) => setPassword(e.target.value)}/>
        </div>

        <div className="newUserItem">
          <label>Password</label>
          <input type="password" placeholder="confirm password" onChange={(e) => setPasswordRepeat(e.target.value)}/>
        </div>


        <button className="newUserButton" onClick={create}>Create</button>
      </form>
    </div>
  );
}
