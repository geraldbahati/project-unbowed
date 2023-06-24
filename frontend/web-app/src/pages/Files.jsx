import React, { useState, useEffect } from "react";
import { Button, IconButton, Avatar } from "@mui/material";
import { styled } from "@mui/material/styles";
import { useNavigate } from "react-router-dom";
import {
    FiSearch,
    FiHelpCircle,
    FiFilter,
    MdFeedback,
    BsChevronDown,
    BsListUl,
    BsGrid3X3Gap,
    BiDownArrowAlt,
} from "react-icons/all";

import "../styles/Files.css";
import { imageData, filterButton } from "../assets/data";
import { sidebarIcons } from "../assets/constants";
import { FilePreview, File } from "../components/File Page";

const UploadButton = styled(Button)(({ theme }) => ({
    color: "#fff",
    backgroundColor: "#636DE7",
    "&:hover": {
        backgroundColor: "#636DE7",
    },
    width: "6.563rem",
    textDecoration: "none",
    textTransform: "none",
    padding: "0.188rem",
    borderRadius: "0.5rem",
    fontSize: "0.875rem",
}));

const MoreButton = styled(Button)(({ theme }) => ({
    color: "#000",
    backgroundColor: "#F4F5FC",
    "&:hover": {
        backgroundColor: "#F4F5FC",
    },
    width: "6.563rem",
    textDecoration: "none",
    textTransform: "none",
    padding: "0.188rem",
    borderRadius: "0.5rem",
    fontSize: "0.875rem",
}));

const Files = () => {
    const navigate = useNavigate();
    const [viewFolders, setViewFolders] = useState(false);
    const [viewFiles, setViewFiles] = useState(false);

    const handleFileUpload = (event) => {
        const file = event.target.files[0];
        // Handle the file upload logic
    };

    return (
        <div className="files_main">
            <div className="files_sidebar">
                <div className="files__sidebar_logo">
                    <Avatar src={imageData[5].img} />
                </div>
                <div className="files__sidebar_icons">
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
            <div className="files_body">
                <section className="files__main_nav">
                    <div className="files__search_section">
                        <div className="files__search_icon" onClick={() => {}}>
                            <FiSearch className="files__icon" />
                        </div>
                        <input
                            className="files__search_input"
                            type="text"
                            placeholder="Search"
                        />
                        <div className="files__filter_icon" onClick={() => {}}>
                            <FiFilter className="files__icon" />
                        </div>
                    </div>
                    <div className="files__icons_section">
                        <IconButton onClick={() => {}}>
                            <FiHelpCircle className="files__icon" />
                        </IconButton>
                        <IconButton onClick={() => {}}>
                            <MdFeedback className="files__icon" />
                        </IconButton>
                        <Avatar
                            src={imageData[4].img}
                            style={{ height: "2rem" }}
                        />
                    </div>
                </section>
                <section className="files__filter_nav">
                    <div className="files__filter_title">
                        <div className="files__filter_text">
                            <p>Documents</p>
                            <IconButton
                                onClick={() => {}}
                                // disableRipple
                                disableFocusRipple
                            >
                                <BsChevronDown className="files__icon" />
                            </IconButton>
                        </div>
                        <div className="files__filter_icons">
                            <IconButton onClick={() => {}}>
                                <BsListUl className="files__icon" />
                            </IconButton>
                            <IconButton onClick={() => {}}>
                                <BsGrid3X3Gap className="files__icon" />
                            </IconButton>
                        </div>
                    </div>
                    <div className="files__filter_buttons">
                        {filterButton.map((item, i) => (
                            <div className="files__filter_button">
                                <p>{item}</p>
                                <IconButton
                                    onClick={() => {}}
                                    disableRipple
                                    disableFocusRipple
                                >
                                    <BsChevronDown className="files__icon" />
                                </IconButton>
                            </div>
                        ))}
                    </div>
                </section>
                <section className="files__suggested">
                    <p>Suggested</p>
                    <div className="files__suggested_container">
                        {[1, 2, 3].map((item, i) => (
                            <FilePreview />
                        ))}
                    </div>
                </section>
                <section className="files__file_nav">
                    <div className="files__file_nav_title">
                        <div className="files__title_name">
                            <p>Name</p>
                            <IconButton onClick={() => {}}>
                                <BiDownArrowAlt />
                            </IconButton>
                        </div>
                        <div className="files__title_owner">Owner</div>
                        <div className="files__title_modified">
                            <p>Last Modified</p>
                            <IconButton onClick={() => {}}>
                                <BiDownArrowAlt />
                            </IconButton>
                        </div>
                        <div className="files__title_size">File size</div>
                    </div>
                    <p>Today</p>
                    <div className="files_file_nav_container">
                        {[1, 2, 3, 4, 5, 6].map((item, i) => (
                            <File />
                        ))}
                    </div>
                </section>
            </div>
        </div>
    );
};

export default Files;
