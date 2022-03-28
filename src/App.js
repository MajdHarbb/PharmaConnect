
import React from "react";
import LandingPage from "./pages/LoggedIn/LandingPage.js";
import LoginPage from "./pages/LoginPage.jsx";
import {BrowserRouter, Route,Routes} from "react-router-dom";
import ProtectedRoutes from "./pages/ProtectedRoutes.jsx";


function App() {
  return (
    <div className="App">
      
      <BrowserRouter>
      <Routes>
            
            <Route exact path='/' element={ <LoginPage/>}/>
            
            <Route element={<ProtectedRoutes/>}>
              <Route path='/home' element={<LandingPage/>}/>
            </Route>
            {/* Nested Routes: when the user is logged in  */}
            
                
                
            {/* </Route> */}
            
            
        </Routes>
      </BrowserRouter>
     
    </div>
  );
}

export default App;
