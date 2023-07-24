import React, { useState, useEffect } from "react";
import axios from "axios";
import { IconButton, Avatar, Divider } from "@mui/material";
import { useNavigate } from "react-router-dom";
import {
    BsFillEmojiSmileFill,
    BsImage,
    BsSendFill,
    BsMicFill,
    BsCameraVideo,
} from "react-icons/bs";
import { FiSearch } from "react-icons/fi";
import { MdCall } from "react-icons/md";

import "../../styles/Chat/ChatArea.css";
import { imageData } from "../../assets/data";
import Message from "./Message";
import { BASEURL } from "../../assets/urls";

const iconStyling = { margin: "0.5rem" };
const textboxIcon = { color: "white", fontSize: "1.25rem" };

const ChatArea = ({ room }) => {
    let previousSender = null;
    let currentSender = null;
    const {
        id,
        owner,
        name,
        last_message,
        updated,
        participants,
        description,
    } = room;
    const [roomData, setRoomData] = useState(null);
    useEffect(() => {
        const fetchRoomData = () => {
            axios
                .get(BASEURL + `chat/chatroom/${id}`)
                .then((response) => {
                    const data = response.data.results;
                    const reversed = data.reverse();
                    setRoomData(reversed);
                })
                .catch((error) => {
                    console.error("Error:", error.message);
                    setRoomData(null);
                });
        };

        fetchRoomData();
    }, [room]);
    return (
        <div className="chatArea">
            <div className="chatArea__header">
                <div className="chatArea_headerAvatar">
                    <Avatar
                        alt="Remy Sharp"
                        src={imageData[4].img}
                        sx={{ height: "3.5rem" }}
                    />
                </div>
                <div className="chatArea_headerText">
                    <h3>{name}</h3>
                    <p>
                        {participants[0]},{participants[1]},{participants[2]}{" "}
                        and {participants.length - 3} other members online
                    </p>
                </div>
                <div className="chatArea_headerIcons">
                    <IconButton onClick={() => {}}>
                        <BsCameraVideo style={iconStyling} />
                    </IconButton>
                    <IconButton onClick={() => {}}>
                        <MdCall style={iconStyling} />
                    </IconButton>
                    <IconButton onClick={() => {}}>
                        <FiSearch style={iconStyling} />
                    </IconButton>
                </div>
            </div>
            <div className="chatArea__body">
                <Divider>Today</Divider>
                {roomData?.map((message, index) => {
                    const { id, sender, description } = message;
                    currentSender = sender.username;

                    const component = (
                        <Message
                            key={id}
                            data={message}
                            prev={previousSender}
                        />
                    );
                    previousSender = currentSender;

                    return component;
                })}
            </div>
            <div className="chatArea__footer">
                <div className="chatArea_icon_group">
                    <IconButton>
                        <BsFillEmojiSmileFill
                            style={{ transform: "rotate(-16deg)" }}
                        />
                    </IconButton>
                    <IconButton>
                        <BsImage />
                    </IconButton>
                </div>

                <div className="message__textbox">
                    <input
                        className="message__textbox_input"
                        type="text"
                        placeholder="Search"
                    />
                    <div className="message__textbox_icon">
                        <BsMicFill style={textboxIcon} />
                    </div>
                </div>
            </div>
        </div>
    );
};

export default ChatArea;
