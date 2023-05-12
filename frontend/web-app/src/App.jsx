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
} from "./pages";

const App = () => {
    return (
        <div className="App">
            <Router>
                <Routes>
                    <Route path="/" element={<Landing />} />
                    <Route path="/login" element={<Login />} />
                    <Route path="/register" element={<Register />} />
                    <Route path="/home" element={<Home />} />
                    <Route path="/chats" element={<Chats />} />
                    <Route path="/conversation" element={<Conversation />} />
                    <Route path="/settings" element={<Settings />} />
                </Routes>
            </Router>
        </div>
    );
};

export default App;
