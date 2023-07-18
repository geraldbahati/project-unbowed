import React from "react";
import { useSelector } from "react-redux";
import { BrowserRouter as Router, Routes, Route } from "react-router-dom";

import "./App.css";

import {
    Chats,
    Conversation,
    Files,
    Home,
    Bot,
    Landing,
    Login,
    Register,
    Settings,
    Verify,
    Scan,
    Dashboard,
    Temp,
} from "./pages";
import { Carousel, Loading, Success } from "./components";

const App = () => {
    return (
        <div className="app">
            <Router>
                <Routes>
                    <Route path="/" element={<Landing />} />
                    <Route exact path="/login" element={<Login />} />
                    <Route exact path="/register" element={<Register />} />
                    <Route exact path="/verification" element={<Verify />} />
                    <Route exact path="/home" element={<Dashboard />} />
                    <Route exact path="/files" element={<Files />} />
                    <Route exact path="/chats" element={<Chats />} />
                    <Route
                        exact
                        path="/conversation"
                        element={<Conversation />}
                    />
                    <Route exact path="/settings" element={<Settings />} />
                    <Route exact path="/success" element={<Success />} />
                    <Route exact path="/scan" element={<Scan />} />

                    <Route exact path="/test" element={<Temp />} />
                    <Route exact path="/bot" element={<Bot />} />
                </Routes>
            </Router>
        </div>
    );
};

export default App;
