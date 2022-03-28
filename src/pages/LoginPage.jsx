import React, { useState, useEffect } from "react";
import "../css/login.css";
import "../js/index.js";
const LoginPage = () => {
  useEffect(() => {
    const form = document.getElementById("form");
    var eField = document.getElementById("field-email");
    var eInput = document.getElementById("input-email");
    var pField = document.getElementById("field-password");
    var pInput = document.getElementById("input-password");
    console.log(eField);
    form.onsubmit = (e) => {
      e.preventDefault(); //preventing from form submitting
      //if email and password is blank then add shake class in it else call specified function
      eInput.value == ""
        ? eField.classList.add("shake", "error")
        : checkEmail();
      pInput.value == "" ? pField.classList.add("shake", "error") : checkPass();

      setTimeout(() => {
        //remove shake class after 500ms
        eField.classList.remove("shake");
        pField.classList.remove("shake");
      }, 500);

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
  function fetchLoginApi() {
    console.log("loggedin");
  }
  return (
    <div>
      <div className="wrapper">
        <header>Login Form</header>
        <form id="form">
          <div className="field email" id="field-email">
            <div className="input-area">
              <input type="text" placeholder="Email Address" id="input-email" />
              <i className="icon fas fa-envelope" />
              <i className="error error-icon fas fa-exclamation-circle" />
            </div>
            <div className="error error-txt">Email can't be blank</div>
          </div>
          <div className="field password" id="field-password">
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
