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

import "../styles/Settings.css";
import { sidebarIcons } from "../assets/constants";
import { imageData } from "../assets/data";

const Settings = () => {
    const navigate = useNavigate();
    return (
        <div className="settings_main">
            <div className="settings_sidebar">
                <div className="settings__sidebar_logo">
                    <Avatar src={imageData[5].img} />
                </div>
                <div className="settings__sidebar_icons">
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
            <div className="settings_body">
                <div className="settings__primary">
                    <h1>Hi, Welcome to your settings page</h1>
                </div>
                <div className="settings__secondary">
                    Here, you can modify the feel of the app to your liking.
                </div>
            </div>
        </div>
    );
};

export default Settings;
