import React from "react";
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

import "../styles/Files.css";
import { imageData } from "../assets/data";
import { sidebarIcons } from "../assets/constants";
import {
    Folder,
    File,
    Chart,
    Calendar,
    Sidebar,
} from "../components/File Page";

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
            <div className="body">
                <section className="primary">
                    {/* Search Section */}
                    <div className="search_section">
                        <div className="search_icon">
                            <FiSearch />
                        </div>
                        <input
                            className="search_input"
                            type="text"
                            placeholder="Search"
                        />
                    </div>

                    {/* Nav Section */}
                    <div className="nav_section">
                        <div className="nav_text">Dashboard</div>
                        <div className="nav_icons">
                            <IconButton sx={{ color: "#231F20" }}>
                                <CgMenuGridO />
                            </IconButton>
                            <IconButton sx={{ color: "#231F20" }}>
                                <TfiMenuAlt />
                            </IconButton>

                            <UploadButton
                                variant="contained"
                                endIcon={<BiCloudUpload />}
                            >
                                Upload
                            </UploadButton>
                        </div>
                    </div>

                    {/* Greeting Section */}
                    <div className="greeting_section">Welcome Back Wizzoh</div>

                    {/* Folder Section */}
                    <div className="nav_section">
                        <div className="nav_text">Folders</div>
                        <div className="nav_icons">
                            <MoreButton
                                variant="contained"
                                endIcon={<BsChevronRight />}
                            >
                                View All
                            </MoreButton>
                        </div>
                    </div>
                    <div className="folder_container">
                        {[1, 2, 3].map((folder, i) => (
                            <Folder key={i} />
                        ))}
                    </div>

                    {/* File Section */}
                    <div className="nav_section">
                        <div className="nav_text">Recent Files</div>
                        <div className="nav_icons">
                            <MoreButton
                                variant="contained"
                                endIcon={<BsChevronRight />}
                            >
                                View All
                            </MoreButton>
                        </div>
                    </div>
                    <div className="file_container">
                        {[1, 2, 3].map((folder, i) => (
                            <File key={i} />
                        ))}
                    </div>
                </section>
                <section className="secondary">
                    {/* Nav Section */}
                    <div className="secondary_nav">
                        <div className="secondary_nav_icons">
                            <IconButton sx={{ color: "#231F20" }}>
                                <CiSettings />
                            </IconButton>
                            <IconButton sx={{ color: "#231F20" }}>
                                <IoIosNotificationsOutline />
                            </IconButton>
                            <Avatar alt="User" src={imageData[3].img} />
                            <div className="user_info">
                                <p>Wizzoh</p>
                                <IconButton sx={{ color: "#231F20" }}>
                                    <BsChevronDown />
                                </IconButton>
                            </div>
                        </div>
                    </div>

                    {/* Calendar section */}
                    <div className="calendar">
                        <div className="calendar_header">
                            <p>Calendar</p>
                            <IconButton sx={{ color: "#231F20" }}>
                                <BsChevronDown />
                            </IconButton>
                        </div>
                        <div className="calendar_data">
                            <Calendar />
                        </div>
                    </div>

                    {/* Tasks section */}
                    <div className="task">
                        <div className="nav_section">
                            <div className="nav_text">Your Tasks</div>
                            <div className="nav_icons">
                                <MoreButton
                                    variant="contained"
                                    endIcon={<BsChevronRight />}
                                >
                                    View All
                                </MoreButton>
                            </div>
                        </div>

                        <div className="task_card">
                            <div className="card_control">
                                <p>Submit Assignments</p>
                                <IconButton sx={{ color: "#000" }}>
                                    <CiMenuKebab />
                                </IconButton>
                            </div>

                            <div className="card_time">
                                <AiOutlineClockCircle
                                    style={{ color: "#000" }}
                                />
                                <p>Created on Dec 13, 2023</p>
                            </div>
                        </div>
                    </div>

                    {/* Storage section */}
                    <div className="storage">
                        <div className="nav_section">
                            <div className="nav_text">Storage</div>
                            <div className="nav_icons">
                                <MoreButton
                                    variant="contained"
                                    endIcon={<BsChevronRight />}
                                >
                                    View All
                                </MoreButton>
                            </div>
                        </div>

                        <div className="storage_card">
                            <Chart />
                        </div>
                    </div>
                </section>
            </div>
        </div>
    );
};

export default Files;
