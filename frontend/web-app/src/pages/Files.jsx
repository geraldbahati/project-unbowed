import React from "react";
import { Button, IconButton } from "@mui/material";
import { styled } from "@mui/material/styles";
import {
    FiSearch,
    CgMenuGridO,
    TfiMenuAlt,
    BiCloudUpload,
    BsChevronRight,
} from "react-icons/all";

import "../styles/Files.css";
import { Folder, File } from "../components/File Page";

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
    const handleFileUpload = (event) => {
        const file = event.target.files[0];
        // Handle the file upload logic
    };

    return (
        <div className="files_main">
            <div className="sidebar">Sidebar</div>
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
                                See More
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
                                See More
                            </MoreButton>
                        </div>
                    </div>
                    <div className="file_container">
                        {[1, 2, 3].map((folder, i) => (
                            <File key={i} />
                        ))}
                    </div>
                </section>
                <section className="secondary">Secondary Section</section>
            </div>
        </div>
    );
};

export default Files;

{
    /* <label className="upload_button">
    <span className="text">Upload</span>
    <span className="icon">
        <BiCloudUpload />
    </span>
    <input type="file" onChange={handleFileUpload} />
</label>; */
}
