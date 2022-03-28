
import React from "react";
import LandingPage from "./pages/landing";
import LoginPage from "./pages/LoginPage";
import {BrowserRouter, Route, Switch} from "react-router-dom";


function App() {
  return (
    <div className="App">
      <h1>Protected React Router</h1>
      {/* <Route component = {LandingPage}/> */}
      <LandingPage/>
      <LoginPage/>
    </div>
  );
}

export default App;
