import React from "react";
import { FaEllipsisH, FaPlus, FaSearch, FaEdit } from "react-icons/all";
import { TextField, InputAdornment, IconButton } from "@mui/material";
import { Edit, More, MoreRounded } from "@mui/icons-material";

import "../../styles/Chat/Sidebar.css";
import Conversation from "./Conversation";

const SidebarChat = () => {
    return (
        <div className="sidebar">
            <div className="sidebar__heading">
                <h2>Chats</h2>
                <div className="sidebar__headingBtn">
                    <IconButton>
                        <FaEdit />
                    </IconButton>
                    <IconButton>
                        <FaEllipsisH />
                    </IconButton>
                </div>
            </div>

            <TextField
                id="search"
                placeholder="Search or start a new chat"
                name="search"
                type="text"
                margin="normal"
                size="small"
                variant="filled"
                InputProps={{
                    startAdornment: (
                        <InputAdornment position="start">
                            <FaSearch />
                        </InputAdornment>
                    ),
                }}
            />

            <div className="sidebar__conversations">
                {[1, 2, 3, 4, 5].map((item, key) => (
                    <Conversation key={key} />
                ))}
            </div>
        </div>
    );
};

export default SidebarChat;
