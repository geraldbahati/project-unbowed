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
                </Routes>
            </Router>
        </div>
    );
};

export default App;
