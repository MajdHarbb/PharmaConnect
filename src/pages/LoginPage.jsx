import React, { useState, useEffect } from "react";
import { Navigate } from "react-router-dom";
import "../css/login.css";
import "../js/index.js";
import axios from "axios";
import {Link} from "react-router-dom";
import { useNavigate } from "react-router-dom";
const LoginPage = () => {
  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");

  const [redirect, setRedirect] = useState(false);
  const navigate = useNavigate();

  // useEffect(() => {
    
    
  //   const form = document.getElementById("form");
  //   var eField = document.getElementById("field-email");
  //   var eInput = document.getElementById("input-email");
  //   var pField = document.getElementById("field-password");
  //   var pInput = document.getElementById("input-password");

  //   form.onsubmit = (e) => {
  //     e.preventDefault(); //preventing from form submitting
  //     eInput.value == "" ? eField.classList.add("error") : checkEmail();
  //     pInput.value == "" ? pField.classList.add("error") : checkPass();

  //     setTimeout(() => {
  //       //remove error class after 500ms
  //       eField.classList.remove("error");
  //       pField.classList.remove("error");
  //     }, 2000);

  //     function checkEmail() {
  //       //checkEmail function
  //       let pattern = /^[^ ]+@[^ ]+\.[a-z]{2,3}$/; //pattern for validate email
  //       if (!eInput.value.match(pattern)) {
  //         //if pattern not matched then add error and remove valid class
  //         eField.classList.add("error");
  //         eField.classList.remove("valid");
  //         let errorTxt = eField.querySelector(".error-txt");
  //         //if email value is not empty then show please enter valid email else show Email can't be blank
  //         eInput.value != ""
  //           ? (errorTxt.innerText = "Enter a valid email address")
  //           : (errorTxt.innerText = "Email can't be blank");
  //       } else {
  //         //if pattern matched then remove error and add valid class
  //         eField.classList.remove("error");
  //         eField.classList.add("valid");
  //       }
  //     }

  //     function checkPass() {
  //       //checkPass function
  //       if (pInput.value == "") {
  //         //if pass is empty then add error and remove valid class
  //         pField.classList.add("error");
  //         pField.classList.remove("valid");
  //       } else {
  //         //if pass is empty then remove error and add valid class
  //         pField.classList.remove("error");
  //         pField.classList.add("valid");
  //       }
  //     }

  //     //if eField and pField doesn't contains error class that mean user filled details properly
  //     if (
  //       !eField.classList.contains("error") &&
  //       !pField.classList.contains("error")
  //     ) {
  //       fetchLoginApi();
  //     }
  //   };
  // });

  let axiosConfig = {
    headers: {
      "Content-Type": "application/json;charset=UTF-8",
    },
  };
  async function fetchLoginApi() {
    axios
      .post(
        `http://127.0.0.1:8000/api/auth/login-admin`,
        { email: email, password: password },
        axiosConfig
      )
      .then((res) => {
        console.log(res);
        console.log(res.data["user"]["id"]);

        localStorage.setItem("access_token", res.data["access_token"]);
        localStorage.setItem("id", res.data["user"]["id"]);
        localStorage.setItem("email", res.data["user"]["email"]);
        
      });
      setRedirect(true);
      // navigate("/home");
    //redirect to user home page on success
    
  }
  if (redirect) {
   return <Navigate to="/home" />;
 }
 

    
 function test(){
   console.log("hi");
   
   
 }
 test();
  return (
    
    <div>
     <div className="body-alt">
      <div className="wrapper">
        <header>Admin Panel</header>
        
        <form id="form">
          <div className="field email" id="field-email">
            <div className="input-area">
              <input
                type="text"
                placeholder="Email Address"
                id="input-email"
                onChange={(e) => setEmail(e.target.value)}
              />
              <i className="icon fas fa-envelope" />
              <i className="error error-icon fas fa-exclamation-circle" />
            </div>
            <div className="error error-txt">Email can't be blank</div>
          </div>
          <div
            className="field password"
            id="field-password"
            onChange={(e) => setPassword(e.target.value)}
          >
            <div className="input-area">
              <input
                type="password"
                placeholder="Password"
                id="input-password"
              />
              <i className="icon fas fa-lock" />
              <i className="error error-icon fas fa-exclamation-circle" />
            </div>
            <div className="error error-txt">Password can't be blank</div>
          </div>

          <input type="button" onClick={fetchLoginApi} value="Login" />
        </form>
      </div>
    </div>
    </div>
  );
};

export default LoginPage;
