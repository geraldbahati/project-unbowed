import React, { useState, useEffect } from "react";
import axios from "axios";
import { IconButton, Avatar, Paper, InputBase, Divider } from "@mui/material";
import { useNavigate } from "react-router-dom";
import { motion } from "framer-motion";
import { BiConversation } from "react-icons/bi";
import {
    BsFillEmojiSmileFill,
    BsImage,
    BsSendFill,
    BsMicFill,
    BsCameraVideo,
    BsPencilSquare,
} from "react-icons/bs";
import { FiSearch } from "react-icons/fi";
import { MdCall } from "react-icons/md";

import "../../styles/Chat/Body.css";
import { Conversation, ChatArea } from "./";
import { BASEURL } from "../../assets/urls";
import { imageData } from "../../assets/data";
import { sidebarIcons } from "../../assets/constants";

const Body = () => {
    const [chatRooms, setChatRooms] = useState([]);
    const [currentRoom, setCurrentRoom] = useState(null);

    useEffect(() => {
        const fetchChatRooms = () => {
            axios
                .get(BASEURL + "chat/chatrooms/")
                .then((response) => {
                    setChatRooms(response.data.results);
                })
                .catch((error) => {
                    console.error("Error:", error.message);
                    setChatRooms([]);
                });
        };

        setCurrentRoom(null);

        fetchChatRooms();
    }, []);
    const navigate = useNavigate();

    return (
        <div className="chats_body__main">
            <div className="chats_body__sidebar">
                <div className="body__sidebar_logo">
                    <Avatar src={imageData[5].img} />
                </div>
                <div className="body__sidebar_icons">
                    {/* <IconLinks /> */}
                    {sidebarIcons.map((icon, i) => (
                        <IconButton
                            key={i}
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

            <div className="chats_body__content">
                <section className="section__conversation">
                    <div className="conversation__title">
                        <p>Chats</p>
                        <IconButton>
                            <BsPencilSquare style={{ color: "#000" }} />
                        </IconButton>
                    </div>

                    <div className="conversation__search">
                        <div className="conversation_search_icon">
                            <FiSearch />
                        </div>
                        <input
                            className="conversation_search_input"
                            type="text"
                            placeholder="Search"
                        />
                    </div>

                    <div className="conversation__header">
                        <BiConversation style={{ color: "#757575" }} />
                        <p>MESSAGES</p>
                    </div>

                    <div className="conversation__component">
                        {chatRooms.map((room) => (
                            <div
                                key={room.id}
                                onClick={() => setCurrentRoom(room)}
                            >
                                <Conversation
                                    chatRoom={room}
                                    className="conversation__container"
                                />
                            </div>
                        ))}
                    </div>
                </section>

                <section className="section__messages">
                    {/* <div className="messages__header">
                        <div className="messages_headerAvatar">
                            <Avatar
                                alt="Remy Sharp"
                                src={imageData[4].img}
                                sx={{ height: "3.5rem" }}
                            />
                        </div>
                        <div className="messages_headerText">
                            <h3>Wizzoh</h3>
                            <p>Last seen at 6.27 pm</p>
                        </div>
                        <div className="messages_headerIcons">
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
                    <div className="messages__body">
                        <Divider>Today</Divider>
                        <Message user={false} username="Wizzoh" />
                        <Message user={true} />
                        <Message user={false} username="Wizzoh" />
                        <Message user={true} username="Wizzoh" />
                        <Message user={true} />
                        <Message user={true} />
                        <Message user={true} />
                        <Message user={false} username="Wizzoh" />
                        <Message user={true} username="Wizzoh" />
                        <Message user={true} />
                        <Message user={true} />
                        <Message user={true} />
                    </div>
                    <div className="messages__footer">
                        <div className="messages_icon_group">
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
                    </div> */}
                    {currentRoom ? (
                        <ChatArea room={currentRoom} />
                    ) : (
                        <div className="unloaded_messages">
                            <h2 className="unloaded__header">Web Unbowed</h2>
                            <p className="unloaded__text">
                                Send and receive messages that are at sync with
                                your mobile device.
                            </p>
                            <p className="unloaded__small">
                                End to end encrypted.
                            </p>
                        </div>
                    )}
                </section>
            </div>
        </div>
    );
};

export default Body;
