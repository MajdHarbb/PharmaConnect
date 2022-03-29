
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
import NewUser from "./pages/LoggedIn/NewUser.js";
import ProductList from "./pages/LoggedIn/ProductList.js";
import Product from "./pages/LoggedIn/Products.js";


function App() {
  return (
    <div className="App">
      
      <BrowserRouter>
      <Routes>
            
            <Route exact path='/' element={ <LoginPage/>}/>

            <Route element={<ProtectedRoutes/>}>
              
              <Route exact path='/home' element={<LandingPage/>}>
                  <Route path='pharmaconnect' element={<Home/>}/>

                  <Route path='users' element={<UserList/>}/>
                  <Route path='users/:userId' element={<User/>}/>
                  {/* needs fixing */}
                  <Route path='newUser' element={<NewUser/>}/>

                  <Route path='products' element={<ProductList/>}/>
                  <Route path='products/:productId' element={<Product/>}/>
                  {/* needs fixing */}
                  <Route path='newproduct' element={<NewUser/>}/>
                  
                  
                  
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
