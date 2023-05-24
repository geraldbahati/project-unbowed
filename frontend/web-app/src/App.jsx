import React from "react";
import { useSelector } from "react-redux";
import { BrowserRouter as Router, Routes, Route } from "react-router-dom";

import {
    Chats,
    Conversation,
    Home,
    Landing,
    Login,
    Register,
    Settings,
    Verify,
} from "./pages";
import { Carousel, Loading, Success } from "./components";

const App = () => {
    return (
        <div className="App">
            <Router>
                <Routes>
                    <Route path="/" element={<Landing />} />
                    <Route exact path="/login" element={<Login />} />
                    <Route exact path="/register" element={<Register />} />
                    <Route exact path="/verification" element={<Verify />} />
                    <Route exact path="/home" element={<Home />} />
                    <Route exact path="/chats" element={<Chats />} />
                    <Route
                        exact
                        path="/conversation"
                        element={<Conversation />}
                    />
                    <Route exact path="/settings" element={<Settings />} />
                    <Route exact path="/success" element={<Success />} />
                    <Route exact path="/test" element={<Loading />} />
                </Routes>
            </Router>
        </div>
    );
};

export default App;
