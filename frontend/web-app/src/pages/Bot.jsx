import React, { useState, useEffect } from "react";
import { Button, IconButton, Avatar } from "@mui/material";
import { styled } from "@mui/material/styles";
import { useNavigate } from "react-router-dom";
import {
    FiSearch,
    CgMenuGridO,
    TfiMenuAlt,
    BiCloudUpload,
    IoIosNotificationsOutline,
    BsChevronRight,
    CiSettings,
    AiOutlineClockCircle,
    BsChevronDown,
    CiMenuKebab,
} from "react-icons/all";

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
                            {icon.jsx}
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
