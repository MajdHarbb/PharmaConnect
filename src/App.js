
import React from "react";
import LandingPage from "./pages/LoggedIn/LandingPage.js";
import LoginPage from "./pages/LoginPage.jsx";
import {BrowserRouter, Route,Routes} from "react-router-dom";
import ProtectedRoutes from "./pages/ProtectedRoutes.jsx";
import UserList from "./pages/LoggedIn/UserList.js";
import Home from "./pages/LoggedIn/Home.js";
import './css/LandingPage.css'
import Topbar from "./components/topbar/Topbar.js";
import User from "./pages/LoggedIn/User.js";


function App() {
  return (
    <div className="App">
      
      <BrowserRouter>
      <Routes>
            
            <Route exact path='/' element={ <LoginPage/>}/>

            <Route element={<ProtectedRoutes/>}>
              
              <Route exact path='/home' element={<LandingPage/>}>
                  <Route path='' element={<Home/>}/>
                  <Route path='users' element={<UserList/>}/>
                  <Route path='users/:userId' element={<User/>}/>
                  <Route path='newUser' element={<User/>}/>
              </Route>
              
              
            </Route>
            {/* Nested Routes: when the user is logged in  */}
            
                
                
            {/* </Route> */}
            
            
        </Routes>
      </BrowserRouter>
     
    </div>
  );
}

export default App;
