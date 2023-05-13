import React, { useEffect, useState } from "react";
import { nanoid } from "@reduxjs/toolkit";
import { Avatar } from "@mui/material";
import { Link } from "react-router-dom";

import { add } from "../assets/data";
import logo from "../assets/images/logo_3.jpg";

import "../styles/SidebarChat.css";

const SidebarChat = ({ id, name, addNewChat }) => {
    const [seed, setSeed] = useState(11);

    useEffect(() => {
        setSeed(Math.floor(Math.random() * 21));
    }, []);

    const createChat = () => {
        const roomName = prompt("PLease enter name for the chat");
        if (roomName) {
            add(nanoid(2), roomName);
        }
    };

    return !addNewChat ? (
        <Link to={`/rooms/${id}`}>
            <div className="sidebarChat">
                <Avatar src={logo} />
                <div className="sidebarChat__info">
                    <h2>{name}</h2>
                    <p>Last Message</p>
                </div>
            </div>
        </Link>
    ) : (
        <div onClick={createChat} className="sidebarChat">
            <h2>Add new Chat</h2>
        </div>
    );
};

export default SidebarChat;
