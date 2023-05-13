import React, { useState, useEffect } from "react";
import { useParams } from "react-router";
import { Avatar, IconButton } from "@mui/material";

import {
    IoSearchOutline,
    MdAttachFile,
    CgMoreVertical,
    MdInsertEmoticon,
    BsMicFill,
} from "react-icons/all";

import { roomData } from "../assets/data";
import logo_1 from "../assets/images/logo_1.jpg";
import "../styles/Conversation.css";

const Conversation = () => {
    const [input, setInput] = useState("");
    const [roomName, setRoomName] = useState("");
    const { roomId } = useParams();

    useEffect(() => {
        if (roomId) {
            const room = roomData.find((e) => e.id === parseInt(roomId));
            setRoomName(room.name);
        }
    }, [roomId]);

    const sendMessage = (event) => {
        event.preventDefault();
        console.log(input);
        setInput("");
    };

    return (
        <div className="chat">
            <div className="chat__header">
                <Avatar src={logo_1} />
                <div className="chat__headerInfo">
                    <h3>{roomName}</h3>
                    <p>Last seen at ...</p>
                </div>
                <div className="chat__headerRight">
                    <IconButton>
                        <IoSearchOutline />
                    </IconButton>
                    <IconButton>
                        <MdAttachFile />
                    </IconButton>
                    <IconButton>
                        <CgMoreVertical />
                    </IconButton>
                </div>
            </div>
            <div className="chat__body">
                <p className={`chat__message ${true && `chat__receiver`}`}>
                    <span className="chat__name">Wizzoh</span>
                    Yooh bruh!😏
                    <span className="chat__timestamp">3:51am</span>
                </p>
            </div>
            <div className="chat__footer">
                <MdInsertEmoticon className="chat__footerIcons" />
                <form action="">
                    <input
                        type="text"
                        placeholder="Enter the message"
                        value={input}
                        onChange={(e) => setInput(e.target.value)}
                    />
                    <button onClick={sendMessage}>Send</button>
                </form>
                <BsMicFill className="chat__footerIcons" />
            </div>
        </div>
    );
};

export default Conversation;
