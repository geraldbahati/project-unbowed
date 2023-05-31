import React from "react";
import { IconButton } from "@mui/material";
import { GrAdd, CiMenuKebab } from "react-icons/all";

import "../../styles/File Page/File.css";

const customStyle = {
    fontSize: "0.75rem",
    fontWeight: "400",
};

const File = () => {
    return (
        <div className="file_main">
            <div className="file_color">
                <p>XLS</p>
            </div>
            <div className="file_info">
                <p style={{ fontWeight: 600, fontSize: "0.875rem" }}>
                    Deep Learning
                </p>
                <p style={customStyle}>Only You</p>
                <p style={customStyle}>March 19, 2023</p>
                <p style={customStyle}>14KB</p>
            </div>
            <div className="file_icons">
                <IconButton>
                    <GrAdd />
                </IconButton>
                <IconButton>
                    <CiMenuKebab />
                </IconButton>
            </div>
        </div>
    );
};

export default File;
