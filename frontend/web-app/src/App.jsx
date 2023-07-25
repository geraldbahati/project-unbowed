import React, { useEffect } from "react";
import { useSelector } from "react-redux";
import { createBrowserHistory } from "history";
import {
    BrowserRouter as Router,
    Routes,
    Route,
    Navigate,
} from "react-router-dom";

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
    Test,
} from "./pages";
import { Carousel, Loading, Success } from "./components";

const App = () => {
    const user = useSelector((state) => state.login.user);
    const history = createBrowserHistory();

    // useEffect hook to run the redirect logic when the component mounts
    useEffect(() => {
        // Check if user is logged in, and redirect accordingly
        if (user) {
            history.replace("/home"); // Redirect to /home if user is logged in
        } else {
            history.replace("/"); // Redirect to / (landing page) if user is not logged in
        }
    }, [user, history]);

    return (
        <div className="app">
            <Router>
                <Routes>
                    <Route path="/" element={<Landing />} />
                    <Route exact path="/login" element={<Login />} />
                    <Route exact path="/register" element={<Register />} />
                    <Route exact path="/verification" element={<Verify />} />

                    {/* Protected Routes */}
                    {user ? (
                        <>
                            <Route exact path="/home" element={<Dashboard />} />
                            <Route exact path="/files" element={<Files />} />
                            <Route exact path="/chats" element={<Chats />} />
                            <Route
                                exact
                                path="/conversation"
                                element={<Conversation />}
                            />
                            <Route
                                exact
                                path="/settings"
                                element={<Settings />}
                            />
                            <Route
                                exact
                                path="/success"
                                element={<Success />}
                            />
                            <Route exact path="/scan" element={<Scan />} />
                        </>
                    ) : (
                        <Navigate to="/login" />
                    )}

                    <Route exact path="/temp" element={<Temp />} />
                    <Route exact path="/test" element={<Test />} />
                    <Route exact path="/bot" element={<Bot />} />
                </Routes>
            </Router>
        </div>
    );
};

export default App;
