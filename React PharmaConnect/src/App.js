import React from "react";
import LandingPage from "./pages/LoggedIn/LandingPage.js";
import LoginPage from "./pages/LoginPage.jsx";
import { BrowserRouter, Route, Routes } from "react-router-dom";
import ProtectedRoutes from "./pages/ProtectedRoutes.jsx";
import UserList from "./pages/LoggedIn/UserList.js";
import Home from "./pages/LoggedIn/Home.js";
import "./css/LandingPage.css";
import Topbar from "./components/topbar/Topbar.js";
import User from "./pages/LoggedIn/User";
import NewUser from "./pages/LoggedIn/NewUser.js";
import Posts from "./pages/LoggedIn/Posts.jsx";
import PharmacyList from "./pages/LoggedIn/PharmacyList.js";
import Pharmacy from "./pages/LoggedIn/Pharmacies";
import AllPosts from "./pages/LoggedIn/AllPosts.jsx";
import Messages from "./pages/LoggedIn/Messages.jsx";

function App() {
  return (
    <div className="App">
      {/* Routing */}
      <BrowserRouter>
        <Routes>
          <Route exact path="/" element={<LoginPage />} />
          {/* Nested Routes: when the user is logged in  */}
          <Route element={<ProtectedRoutes />}>
            <Route exact path="/home" element={<LandingPage />}>
              <Route path="pharmaconnect" element={<Home />} />

              <Route path="users" element={<UserList />} />
              <Route path="users/:userId" element={<User />} />
              {/* needs fixing */}
              <Route path="newUser" element={<NewUser />} />

              <Route path="pharmacies" element={<PharmacyList />} />
              <Route path="pharmacies/:pharmacyId" element={<Pharmacy />} />

              <Route path="solvedposts" element={<Posts />} />
              <Route path="allposts" element={<AllPosts />} />
              <Route path="messages" element={<Messages />} />
            </Route>
          </Route>
        </Routes>
      </BrowserRouter>
    </div>
  );
}

export default App;
