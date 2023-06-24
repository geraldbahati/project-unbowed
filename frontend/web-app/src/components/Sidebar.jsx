import React, { useState, useEffect } from "react";
import { Avatar, IconButton } from "@mui/material";
import {
    MdDonutLarge,
    BsChat,
    FiMoreVertical,
    IoSearchOutline,
} from "react-icons/all";

import { roomData } from "../assets/data";
import "../styles/Sidebar.css";

const Sidebar = () => {
    const [rooms, setRooms] = useState([]);

    useEffect(() => {
        setRooms(
            roomData.map((data) => ({
                id: data.id,
                name: data.name,
            }))
        );
    }, [roomData]);

    return (
        <div className="sidebar">
            <div className="sidebar__header">
                <Avatar />
                <div className="sidebar__headerRight">
                    <IconButton>
                        <MdDonutLarge />
                    </IconButton>
                    <IconButton>
                        <BsChat />
                    </IconButton>
                    <IconButton>
                        <FiMoreVertical />
                    </IconButton>
                </div>
            </div>
            <div className="sidebar__search">
                <div className="sidebar__searchContainer">
                    <IoSearchOutline className="sidebar__searchIcon" />
                    <input type="text" placeholder="Search or start new chat" />
                </div>
            </div>
            <div className="sidebar__chat">
                <SidebarChat addNewChat={true} />
                {rooms.map((room) => (
                    <SidebarChat key={room.id} id={room.id} name={room.name} />
                ))}
            </div>
        </div>
    );
};

export default Sidebar;