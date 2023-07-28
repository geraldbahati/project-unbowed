import React, { useState, useEffect } from "react";
import axios from "axios";
import { useSelector, useDispatch } from "react-redux";
import { Link, Navigate, useNavigate } from "react-router-dom";
import QRCode, { QRCodeSVG } from "qrcode.react";
import { HashLoader } from "react-spinners";

import { userLogin } from "../features/auth/loginSlice";
import { userLoginStatus } from "../features/auth/loginSlice";
import { userLoginError } from "../features/auth/loginSlice";

import "../styles/Login.css";
import { BASEURL } from "../assets/urls";

const Login = () => {
    const dispatch = useDispatch();
    const navigate = useNavigate();

    const [sessionToken, setSessionToken] = useState(null);
    const [user, setUser] = useState(null);

    // Get the login status and error from the Redux store
    const loginStatus = useSelector((state) => state.login.status);
    const loginError = useSelector((state) => state.login.error);

    useEffect(() => {
        const fetchAcessToken = () => {
            axios
                .get(BASEURL + "user/request-session/")
                .then((response) => {
                    setSessionToken(response.data?.session_id);
                })
                .catch((error) => {
                    console.log("Error fetching data: " + error);
                });
        };

        const checkTokenValidity = () => {
            if (sessionToken) {
                axios
                    .get(BASEURL + `user/check-session/${sessionToken}`)
                    .then((response) => {
                        setUser(response.data);

                        dispatch(userLogin(response.data));
                        if (!user) {
                            navigate("/login");
                        }
                    })
                    .catch((error) => {
                        console.log("Error fetching data: " + error);
                        throw error;
                    });
            }
        };

        fetchAcessToken();
        const intervalId = setInterval(checkTokenValidity, 5000);
        return () => clearInterval(intervalId);
    }, []);

    return (
        <div className="login_main">
            <div className="code_card">
                {sessionToken ? (
                    <QRCodeSVG
                        value={sessionToken}
                        size={256}
                        imageSettings={{
                            src: "https://thumbnail.imgbin.com/11/21/14/imgbin-react-javascript-library-github-backbone-qQ1Kftyd2FDCwKGQfN0e48FyC_t.jpg",
                            x: undefined,
                            y: undefined,
                            height: 24,
                            width: 24,
                            excavate: true,
                        }}
                    />
                ) : (
                    <HashLoader color="#3888eb" />
                )}
            </div>
            <div className="description_card">
                <p className="description_title">
                    Log in to Unbowed by QR Code
                </p>
                {/* <div className="description_steps">
                        <div className="steps_shape">1</div>
                        <div className="steps_text">
                            Open Unbowed on your phone.
                        </div>
                    </div>
                    <div className="description_steps">
                        <div className="steps_shape">2</div>
                        <div className="steps_text">
                            Go to Settings, Devices, Link Desktop Device.
                        </div>
                    </div>
                    <div className="description_steps">
                        <div className="steps_shape">3</div>
                        <div className="steps_text">
                            Point your phone at this screen to confirm login.
                        </div>
                    </div> */}
                <ol>
                    <li>Open Unbowed App on your phone.</li>
                    <li>Go to Settings, Devices, Link Desktop Device.</li>
                    <li>Point your phone at this screen to confirm login.</li>
                </ol>
            </div>
        </div>
    );
};

export default Login;
// {sessionToken ? (
//     <div>
//         <QRCode value={sessionToken} />
//     </div>
// ) : (
//     <div>
//         <h1>Loading Session</h1>
//         <HashLoader />
//     </div>
// )}
