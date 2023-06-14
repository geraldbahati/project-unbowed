import React from "react";
import { useNavigate } from "react-router-dom";
import { Avatar } from "@mui/material";

import "../../styles/File Page/Sidebar.css";
import { sidebarIcons } from "../../assets/constants";
import { imageData } from "../../assets/data";

const Sidebar = () => {
    const navigate = useNavigate();
    return (
        <div className="file_sidebar">
            <div className="file_sidebar__logo">
                <Avatar src={imageData[2].img} />
                <p>Unbowed</p>
            </div>
            <div className="file_sidebar__icons">
                {sidebarIcons.map((icon) => (
                    <div
                        key={icon.name}
                        className="file_sidebar__iconHolder"
                        onClick={() => navigate(icon.path)}
                    >
                        <div className="file_sidebar__iconJsx">{icon.jsx}</div>
                        <p>{icon.name}</p>
                    </div>
                ))}
            </div>
            <div className="file_sidebar__avatar">
                <Avatar src={imageData[4].img} />
                <p>Wizzoh</p>
            </div>
        </div>
    );
};

export default Sidebar;
