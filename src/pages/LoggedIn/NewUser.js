import "../../css/NewUser.css";
import { useState } from "react";

export default function NewUser() {
  //use State to update variables according to user input
  const [name, setName] = useState("");
  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");
  const [phone, setPhone] = useState("");
  const [password_confirmation, setPasswordRepeat] = useState("");

  const create = ()=>{
    console.log("test")
  }
  return (
    <div className="newUser">
      <h1 className="newUserTitle">New User</h1>
      <form className="newUserForm">
        <div className="newUserItem">
          <label>Username</label>
          <input type="text" placeholder="john" />
        </div>
        <div className="newUserItem">
          <label>Full Name</label>
          <input type="text" placeholder="John Smith" onChange={(e) => setName(e.target.value)}/>
        </div>
        <div className="newUserItem">
          <label>Email</label>
          <input type="email" placeholder="john@gmail.com" onChange={(e) => setEmail(e.target.value)}/>
        </div>
        <div className="newUserItem">
          <label>Password</label>
          <input type="password" placeholder="password" onChange={(e) => setPassword(e.target.value)}/>
        </div>

        <div className="newUserItem">
          <label>Password</label>
          <input type="password" placeholder="confirm password" onChange={(e) => setPasswordRepeat(e.target.value)}/>
        </div>

        <div className="newUserItem">
          <label>Phone</label>
          <input type="text" placeholder="8 digits ex: 03123456" onChange={(e) => setEmail(e.target.value)}/>
        </div>
        <div className="newUserItem">
          <label>Address</label>
          <input type="text" placeholder="New York | USA" />
        </div>

        <button className="newUserButton" onClick={create()}>Create</button>
      </form>
    </div>
  );
}
