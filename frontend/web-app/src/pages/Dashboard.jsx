import React, { useState, useEffect } from "react";
import { Button, IconButton, Avatar } from "@mui/material";
import { styled } from "@mui/material/styles";
import { useNavigate } from "react-router-dom";
import { motion } from "framer-motion";
import { AiOutlineClockCircle } from "react-icons/ai";
import { CiSettings, CiMenuKebab } from "react-icons/ci";
import { CgMenuGridO } from "react-icons/cg";
import { FiSearch } from "react-icons/fi";
import { BsChevronRight, BsChevronDown } from "react-icons/bs";
import { TfiMenuAlt } from "react-icons/tfi";
import { BiCloudUpload } from "react-icons/bi";
import { IoIosNotificationsOutline } from "react-icons/io";

import "../styles/Dashboard.css";
import { sidebarIcons } from "../assets/constants";
import { imageData } from "../assets/data";
import {
    Folder,
    File,
    Chart,
    Calendar,
    Sidebar,
} from "../components/Dashboard";

const UploadButton = styled(Button)(({ theme }) => ({
    color: "#fff",
    backgroundColor: "#5AA2FC",
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

const Dashboard = () => {
    const navigate = useNavigate();
    const [viewFolders, setViewFolders] = useState(false);
    const [viewFiles, setViewFiles] = useState(false);

    const handleFileUpload = (event) => {
        const file = event.target.files[0];
        // Handle the file upload logic
    };

    return (
        <div className="dashboard_main">
            <div className="dashboard_sidebar">
                <div className="dashboard__sidebar_logo">
                    <Avatar src={imageData[5].img} />
                </div>
                <div className="dashboard__sidebar_icons">
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
            <div className="dashboard_body">
                <section className="dashboard__primary">
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
                                onClick={(e) => handleFileUpload(e)}
                            >
                                Upload
                            </UploadButton>
                        </div>
                    </div>
                    {!viewFiles && !viewFolders && (
                        <div className="greeting_section">
                            Welcome Back Wizzoh
                        </div>
                    )}

                    {/* Folder Section */}
                    {!viewFiles && (
                        <>
                            <div className="nav_section">
                                <div className="nav_text">Folders</div>
                                <div className="nav_icons">
                                    <MoreButton
                                        variant="contained"
                                        endIcon={<BsChevronDown />}
                                        onClick={() =>
                                            setViewFolders(!viewFolders)
                                        }
                                    >
                                        {!viewFolders ? "View All" : "Minimise"}
                                    </MoreButton>
                                </div>
                            </div>
                            <div
                                className="folder_container"
                                style={{
                                    maxHeight: !viewFolders
                                        ? "16rem"
                                        : "40.5rem",
                                }}
                            >
                                {[1, 2, 3, 4, 5, 6].map((folder, i) => (
                                    <Folder key={i} />
                                ))}
                            </div>
                        </>
                    )}

                    {/* File Section */}
                    {!viewFolders && (
                        <>
                            <div className="nav_section">
                                <div className="nav_text">Recent Files</div>
                                <div className="nav_icons">
                                    <MoreButton
                                        variant="contained"
                                        endIcon={<BsChevronDown />}
                                        onClick={() => setViewFiles(!viewFiles)}
                                    >
                                        {!viewFiles ? "View All" : "Minimise"}
                                    </MoreButton>
                                </div>
                            </div>
                            <div
                                className="file_container"
                                style={{
                                    maxHeight: !viewFiles ? "10rem" : "40.5rem",
                                }}
                            >
                                {[1, 2, 3, 4, 5, 6, 7, 8, 9, 10].map(
                                    (folder, i) => (
                                        <File key={i} />
                                    )
                                )}
                            </div>
                        </>
                    )}
                </section>
                <section className="dashboard__secondary">
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

export default Dashboard;
