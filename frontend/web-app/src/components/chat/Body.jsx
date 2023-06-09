import React from "react";
import { IconButton, Avatar, Paper, InputBase, Divider } from "@mui/material";
import { motion } from "framer-motion";
import {
    BsPencilSquare,
    BsFolderFill,
    AiFillHome,
    FiSearch,
    BsSendFill,
    BiConversation,
    BsMicFill,
    BsCameraVideo,
    IoAttach,
    MdCall,
    BsFillEmojiSmileFill,
    FaRobot,
    IoSettings,
    BsImage,
} from "react-icons/all";

import "../../styles/Chat/Body.css";
import Conversation from "./Conversation";
import Message from "./Message";
import { imageData } from "../../assets/data";

const Body = () => {
    const items = [];
    for (let i = 0; i < 20; i++) {
        items.push(i);
    }
    const iconStyling = { margin: "0.5rem" };
    const iconButton = { p: "0.625rem" };
    const iconSize = { fontSize: "1.5rem", marginBottom: "2.65rem" };

    return (
        <div className="chats_body__main">
            <div className="chats_body__sidebar">
                <div className="body__sidebar_logo">
                    <Avatar src={imageData[5].img} />
                </div>
                <div className="body__sidebar_icons">
                    <AiFillHome style={iconSize} />
                    <BsFolderFill style={iconSize} />
                    <BiConversation style={iconSize} />
                    <FaRobot style={iconSize} />
                    <IoSettings style={iconSize} />
                </div>
                <div className="body__sidebar_avatar">
                    <Avatar src={imageData[4].img} />
                </div>
            </div>

            <div className="chats_body__content">
                <section className="section__conversation">
                    <div className="conversation__title">
                        <p>Messages</p>
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
                        {items.map((item) => (
                            <Conversation className="conversation__container" />
                        ))}
                    </div>
                </section>

                <section className="section__messages">
                    <div className="messages__header">
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
                    </div>
                    <div className="messages__footer">
                        <div>
                            <IconButton sx={iconButton} aria-label="menu">
                                <BsFillEmojiSmileFill />
                            </IconButton>
                            <IconButton sx={iconButton} aria-label="menu">
                                <BsImage />
                            </IconButton>
                        </div>
                        <Paper component="form" className="footer__paper">
                            <InputBase
                                sx={{ ml: 1, flex: 1 }}
                                placeholder="Aa."
                                multiline
                            />
                            <IconButton type="button" sx={iconButton}>
                                <BsMicFill />
                            </IconButton>

                            <Divider
                                sx={{ height: 28, m: 0.5 }}
                                orientation="vertical"
                            />
                            <IconButton sx={(iconButton, { color: "#1e224a" })}>
                                <BsSendFill />
                            </IconButton>
                        </Paper>
                    </div>
                </section>
            </div>
        </div>
    );
};

export default Body;
