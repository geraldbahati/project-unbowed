import React from "react";
import { useNavigate } from "react-router-dom";
import { motion } from "framer-motion";
import { Avatar, IconButton, Button } from "@mui/material";
import { styled } from "@mui/material/styles";
import { BsDownload, FcImageFile, FiSearch } from "react-icons/all";

import "../styles/Scan.css";
import { imageData } from "../assets/data";
import { sidebarIcons } from "../assets/constants";
import { File } from "../components/Dashboard";

const UploadButton = styled(Button)(({ theme }) => ({
    color: "#fff",
    backgroundColor: "#0F1226",
    "&:hover": {
        backgroundColor: "#0F1226",
    },
    width: "18.75rem",
    height: "3.375rem",
    textDecoration: "none",
    textTransform: "none",
    padding: "0.188rem",
    borderRadius: "0.5rem",
    fontSize: "0.875rem",
    margin: "1.5rem 0rem",
}));

const SearchButton = styled(IconButton)(({ theme }) => ({
    backgroundColor: "#c2d0f3",
    width: "2.188rem",
    height: "2.188rem",
    borderRadius: "0.625rem",
}));

const ViewAll = styled(Button)(({ theme }) => ({
    color: "#000",
    backgroundColor: "#bdbdbd",
    "&:hover": {
        backgroundColor: "#bdbdbd",
    },
    width: "5.938rem",
    height: "2.188rem",
    textDecoration: "none",
    textTransform: "none",
    borderRadius: "0.5rem",
    fontSize: "0.875rem",
    marginLeft: "2.875rem",
}));

const Scan = () => {
    const navigate = useNavigate();
    const handleUpload = (e) => {
        console.log(e);
    };

    return (
        <div className="scan_main">
            <div className="scan_sidebar">
                <div className="scan__sidebar_logo">
                    <Avatar src={imageData[5].img} />
                </div>
                <div className="scan__sidebar_icons">
                    {sidebarIcons.map((icon) => (
                        <IconButton
                            key={icon.name}
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
                <div className="scan__sidebar_avatar">
                    <Avatar src={imageData[4].img} />
                </div>
            </div>
            <div className="scan_body">
                <section className="scan__primary">
                    <h1>Image Scanner</h1>
                    <h2>Generate PDF from an Image</h2>
                    <div className="scan__iconGroup">
                        <FcImageFile className="scan__imgIcon" />
                        <BsDownload className="scan__downloadIcon" />
                    </div>
                    <UploadButton onClick={handleUpload}>
                        Select a File
                    </UploadButton>
                    <p>Image files can range fron JPEG to PNG </p>
                </section>
                <section className="scan__secondary">
                    <h1>Scanned Documents</h1>
                    <div className="scan__secondary_nav">
                        <div className="secondary__search_section">
                            <div
                                className="secondary__search_icon"
                                onClick={{}}
                            >
                                <FiSearch />
                            </div>
                            <input
                                className="secondary__search_input"
                                type="text"
                                placeholder="Search"
                            />
                        </div>
                        <ViewAll style={{}}>See all</ViewAll>
                    </div>
                    <p>Recently generated</p>
                    <div className="scan__secondary_files">
                        {[1, 2, 3].map((item, i) => (
                            <File key={i} />
                        ))}
                    </div>
                    <h2>My Uploads</h2>
                    <div className="scan__secondary_images">
                        {imageData.map((item, i) => (
                            <div className="scan__image" key={i}>
                                <img src={item.img} alt="" />
                                <p>SCO 200</p>
                            </div>
                        ))}
                    </div>
                </section>
            </div>
        </div>
    );
};

export default Scan;
