import React from "react";
import { IconButton, Avatar, TextField } from "@mui/material";
import {
    FaVideo,
    IoCall,
    FiSearch,
    MdEmojiEmotions,
    IoAttach,
    FaMicrophone,
} from "react-icons/all";

import "../../styles/Chat/Body.css";
import { imageData } from "../../assets/data";

const Chat = () => {
    return (
        <div className="body">
            <div className="body__header">
                <div className="body__headerAvatar">
                    <Avatar
                        alt="Remy Sharp"
                        src={imageData[4].img}
                        sx={{ width: 56, height: 56 }}
                    />
                </div>
                <div className="body__headerInfo">
                    <div className="body__user">Wizzoh</div>
                    <div className="body__lastSeen">14.00</div>
                </div>
                <div className="body__headerButtons">
                    <IconButton>
                        <FaVideo />
                    </IconButton>
                    <IconButton>
                        <IoCall />
                    </IconButton>
                    <IconButton>
                        <FiSearch />
                    </IconButton>
                </div>
            </div>
            <div className="body__content">Content</div>
            <div className="body__footer">
                <div className="body__footerIcons">
                    <IconButton>
                        <MdEmojiEmotions />
                    </IconButton>
                    <IconButton>
                        <IoAttach />
                    </IconButton>
                </div>
                <div className="body__footerInput">
                    <form action="">
                        <input placeholder="Type a message" />
                    </form>
                </div>
                <div className="body__footerMic">
                    <IconButton>
                        <FaMicrophone />
                    </IconButton>
                </div>
            </div>
        </div>
    );
};

export default Chat;
