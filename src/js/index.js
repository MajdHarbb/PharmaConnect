import loginn from "../pages/LoginPage";

window.addEventListener('load', function () {
    const form = document.getElementById("form");
    var eField = document.getElementById("field-email");
    var eInput = document.getElementById("input-email");
    var pField = document.getElementById("field-password");
    var pInput = document.getElementById("input-password");

     function checkEmail(email) {
        //checkEmail function
        let pattern = /^[^ ]+@[^ ]+\.[a-z]{2,3}$/; //pattern for validate email
        if (!email.match(pattern)) {
          //if pattern not matched then add error and remove valid class
          eField.classList.add("error");
          eField.classList.remove("valid");
          let errorTxt = eField.querySelector(".error-txt");
          //if email value is not empty then show please enter valid email else show Email can't be blank
          email != ""
            ? (errorTxt.innerText = "Enter a valid email address")
            : (errorTxt.innerText = "Email can't be blank");
        } else {
          //if pattern matched then remove error and add valid class
          eField.classList.remove("error");
          eField.classList.add("valid");
        }
        
      }
      
      
  }
  );
  
   
