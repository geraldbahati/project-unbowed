import React from "react";
import { IconButton } from "@mui/material";
import {
    FcOpenedFolder,
    CiMenuKebab,
    AiFillFile,
    AiOutlineClockCircle,
} from "react-icons/all";

import "../../styles/Dashboard/Folder.css";

const Folder = () => {
    return (
        <div className="folder_main">
            <div className="control_icons">
                <FcOpenedFolder />
                <IconButton sx={{ color: "#fff" }}>
                    <CiMenuKebab />
                </IconButton>
            </div>
            <div className="folder_title">Design Shift</div>
            <div className="folder_info">
                <AiFillFile style={{ color: "#fff" }} />
                <p clas>10 Files</p>
            </div>
            <div className="folder_time">
                <AiOutlineClockCircle style={{ color: "#fff" }} />
                <p>Created on Dec 13, 2023</p>
            </div>
        </div>
    );
};

export default Folder;
