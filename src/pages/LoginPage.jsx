import React, { useState, useEffect } from "react";
import "../css/login.css";
import "../js/index.js";
import axios from 'axios';
const LoginPage = () => {
  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");
  const [redirect, setRedirect] = useState(false);

  var x = "";
  var y = "";
  useEffect(() => {
    const form = document.getElementById("form");
    var eField = document.getElementById("field-email");
    var eInput = document.getElementById("input-email");
    var pField = document.getElementById("field-password");
    var pInput = document.getElementById("input-password");
    x = eInput.value;
    y=pInput.value;
    form.onsubmit = (e) => {
      e.preventDefault(); //preventing from form submitting
      eInput.value == ""
        ? eField.classList.add("error")
        : checkEmail();
      pInput.value == "" ? pField.classList.add("error") : checkPass();

      setTimeout(() => {
        //remove error class after 500ms
        eField.classList.remove("error");
        pField.classList.remove("error");
      }, 2000);

      eInput.onkeyup = () => {
        checkEmail();
      }; //calling checkEmail function on email input keyup
      pInput.onkeyup = () => {
        checkPass();
      }; //calling checkPassword function on pass input keyup

      function checkEmail() {
        //checkEmail function
        let pattern = /^[^ ]+@[^ ]+\.[a-z]{2,3}$/; //pattern for validate email
        if (!eInput.value.match(pattern)) {
          //if pattern not matched then add error and remove valid class
          eField.classList.add("error");
          eField.classList.remove("valid");
          let errorTxt = eField.querySelector(".error-txt");
          //if email value is not empty then show please enter valid email else show Email can't be blank
          eInput.value != ""
            ? (errorTxt.innerText = "Enter a valid email address")
            : (errorTxt.innerText = "Email can't be blank");
        } else {
          //if pattern matched then remove error and add valid class
          eField.classList.remove("error");
          eField.classList.add("valid");
        }
      }

      function checkPass() {
        //checkPass function
        if (pInput.value == "") {
          //if pass is empty then add error and remove valid class
          pField.classList.add("error");
          pField.classList.remove("valid");
        } else {
          //if pass is empty then remove error and add valid class
          pField.classList.remove("error");
          pField.classList.add("valid");
        }
      }

      //if eField and pField doesn't contains error class that mean user filled details properly
      if (
        !eField.classList.contains("error") &&
        !pField.classList.contains("error")
      ) {
        fetchLoginApi(); 
      }
    };
  });

  var postData = {
    email: "user@ojne.com",
    password: "user123456"
  };
  
  let axiosConfig = {
    headers: {
        'Content-Type': 'application/json;charset=UTF-8',
    }
  };
  console.log(postData)
  async function  fetchLoginApi() {
    axios.post(`http://127.0.0.1:8000/api/auth/login`,
    {email: x,password: y},axiosConfig)
      .then(res => {
        console.log(res);
        console.log(res.data);
        console.log(x,y);
        console.log(email);
      });
      //fetch login API: checks if user exists in the database and returns a JWT token
      // const response = await fetch("http://127.0.0.1:8000/api/auth/login", {

      //   method: "POST",

      //   headers: { "Content-Type": "application/json" },

      //   body: JSON.stringify({

      //     email: x,
      //     password: y,
      //   }),
      // });
      // const content = await response.json();

      // //if user is found store token in the local storage
      // if (response.status != 401) {
      //   console.log(content.access_token)
      // }
      // console.log(response);
      //   console.log(x,y);
      //   console.log(email);

  }
  return (
    <div>
      <div className="wrapper">
        <header>Login Form</header>
        <form id="form">
          <div className="field email" id="field-email">
            <div className="input-area">
              <input type="text" placeholder="Email Address" id="input-email" onChange={(e) => setEmail(e.target.value)}/>
              <i className="icon fas fa-envelope" />
              <i className="error error-icon fas fa-exclamation-circle" />
            </div>
            <div className="error error-txt">Email can't be blank</div>
          </div>
          <div className="field password" id="field-password" onChange={(e) => setPassword(e.target.value)}>
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

          <input type="submit" defaultValue="Login" />
        </form>
        <div className="sign-txt">
          Not yet member? <a href="#">Signup now</a>
        </div>
      </div>
    </div>
  );
};

export default LoginPage;
