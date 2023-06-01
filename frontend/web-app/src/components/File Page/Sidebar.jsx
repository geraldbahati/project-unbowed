import React from "react";

import HowToRegIcon from "@mui/icons-material/HowToReg";
import LockOpenIcon from "@mui/icons-material/LockOpen";
import {
    CgMenu,
    CgProfile,
    CgOptions,
    IoNotificationsOutline,
    CgHome,
} from "react-icons/all";

import "../../styles/File Page/Sidebar.css";

const Sidebar = () => {
    return (
        <div className="sidebar">
            <CgHome />
            <p>Home</p>
        </div>
    );
};

export default Sidebar;
