import React, { useState, useEffect } from "react";
import { Button, IconButton, Avatar } from "@mui/material";
import { styled } from "@mui/material/styles";
import { useNavigate } from "react-router-dom";
import { motion } from "framer-motion";

import "../styles/Bot.css";
import { sidebarIcons } from "../assets/constants";
import { imageData } from "../assets/data";

const Bot = () => {
    const navigate = useNavigate();
    return (
        <div className="bot_main">
            <div className="bot_sidebar">
                <div className="bot__sidebar_logo">
                    <Avatar src={imageData[5].img} />
                </div>
                <div className="bot__sidebar_icons">
                    {/* <IconLinks /> */}
                    {sidebarIcons.map((icon) => (
                        <IconButton
                            onClick={() => navigate(icon.path)}
                            disableRipple
                            disableFocusRipple
                        >
                            <motion.div
                                whileHover={{
                                    scale: 1.2,
                                    color: "#5BE4F7",
                                }}
                                whileTap={{ scale: 0.8 }}
                            >
                                {icon.jsx}
                            </motion.div>
                        </IconButton>
                    ))}
                </div>
                <div className="body__sidebar_avatar">
                    <Avatar src={imageData[4].img} />
                </div>
            </div>
            <div className="bot_body">
                <div className="bot__primary">
                    <h1>Hi, this is your campus bot</h1>
                </div>
                <div className="bot__secondary">Happy to have you around</div>
            </div>
        </div>
    );
};

export default Bot;
