import React from "react";
import { Button, IconButton, Avatar } from "@mui/material";
import { BsDownload } from "react-icons/bs";
import { CiMenuKebab } from "react-icons/ci";

import "../../styles/File Page/File.css";
import { imageData } from "../../assets/data";

const iconStyle = {
    color: "#231F20",
};

const File = () => {
    return (
        <div className="dashboard_file_main">
            <div className="file__title_name">
                <div className="file_title_color">
                    <p>DOC</p>
                </div>
                <p style={{ fontWeight: 600 }}>Sample Word Document</p>
            </div>
            <div className="file__title_owner">
                <Avatar
                    src={imageData[3].img}
                    alt={imageData[3].author}
                    style={{ marginRight: "0.5rem" }}
                />
                <p>Me</p>
            </div>
            <div className="file__title_modified">12th December, 2021</div>
            <div className="file__title_size">12KB</div>
            <div className="file__title_icons">
                <IconButton onClick={() => {}}>
                    <BsDownload style={iconStyle} />
                </IconButton>
                <IconButton onClick={() => {}}>
                    <CiMenuKebab style={iconStyle} />
                </IconButton>
            </div>
        </div>
    );
};

export default File;
