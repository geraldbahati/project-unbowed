import React from "react";
import { IconButton } from "@mui/material";
import {
    GrAdd,
    CiMenuKebab,
    GrDocumentExcel,
    FaFileWord,
    FaFileExcel,
} from "react-icons/all";

import "../../styles/File Page/FilePreview.css";

const customStyle = {
    fontSize: "0.75rem",
    fontWeight: "400",
};

const FilePreview = () => {
    return (
        <div className="filePreview_main">
            <div className="filePreview_container">
                <div className="filePreviewTitle">
                    <FaFileWord className="perview_icon" />
                    <p>Sample Word document</p>
                </div>
            </div>
            <p>You opened last week</p>
        </div>
    );
};

export default FilePreview;
