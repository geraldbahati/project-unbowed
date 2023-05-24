import React from "react";
import { useSelector } from "react-redux";
import { motion } from "framer-motion";
import { useNavigate } from "react-router";
import { Button } from "@mui/material";

import "../styles/Success.css";
import { imageData } from "../assets/data";

const Success = () => {
    const navigate = useNavigate();
    const isSuccessful = useSelector((state) => state.verify);
    console.log(isSuccessful);

    if (isSuccessful === true) {
        return (
            <div className="success">
                <h1> "Success!" </h1>
                <img src={imageData[5].img} alt="" />
                <p>We have verified your phone number.</p>
                <Button
                    variant="contained"
                    onClick={(e) => {
                        navigate("/home");
                    }}
                >
                    Proceed
                </Button>
            </div>
        );
    } else {
        return (
            <div className="success">
                <h1> "Try Again!" </h1>
                <img src={imageData[4].img} alt="" />
                <p>The code entered was invalid</p>
                <Button
                    variant="contained"
                    onClick={(e) => {
                        navigate("/register");
                    }}
                >
                    Try again
                </Button>
            </div>
        );
    }
};

export default Success;
