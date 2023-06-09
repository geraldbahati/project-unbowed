import React, { useState, useEffect } from "react";
import { Avatar } from "@mui/material";

import "../../styles/Chat/Message.css";
import { imageData } from "../../assets/data";

const Message = ({ user, username }) => {
    const currentUser = "Wizzoh";
    let isSender = false;
    const [showSenderTime, setShowSenderTime] = useState(false);
    const [showUserTime, setShowUserTime] = useState(false);

    if (username != currentUser) {
        isSender = !isSender;
    }

    return (
        <>
            {user ? (
                <div className="user_message">
                    <div
                        className="user_message__content"
                        onMouseOver={() => {
                            setShowUserTime(!showUserTime);
                        }}
                    >
                        To put it mildly, the systems approach makes it easy to
                        see perspectives of The Accomplishment of Draft
                        Exchange.
                    </div>
                    <div className="user_message__info">
                        <p className="user_placeholder">{"  "}</p>
                        {showUserTime && (
                            <div className="user_message__time">4.20 pm</div>
                        )}
                    </div>
                </div>
            ) : isSender ? (
                <div className="other_message">
                    <h5 className="message__sender">Wizzoh</h5>

                    <div
                        className="message__content"
                        onMouseOver={() => {
                            setShowSenderTime(!showSenderTime);
                        }}
                    >
                        To put it mildly, the systems approach makes it easy to
                        see perspectives of The Accomplishment of Draft
                        Exchange.
                    </div>
                    <div className="message__info">
                        {showSenderTime && (
                            <div className="message__time">4.20 pm</div>
                        )}
                    </div>
                </div>
            ) : (
                <div className="other_message">
                    <h5 className="message__sender">Wizzoh</h5>

                    <div
                        className="message__content"
                        onMouseOver={() => {
                            setShowSenderTime(!showSenderTime);
                        }}
                    >
                        To put it mildly, the systems approach makes it easy to
                        see perspectives of The Accomplishment of Draft
                        Exchange.
                    </div>

                    <div className="message__info">
                        <div className="message__avatar">
                            <Avatar src={imageData[3].img} />
                        </div>
                        {showSenderTime && (
                            <div className="message__time">4.20 pm</div>
                        )}
                    </div>
                </div>
            )}
        </>
    );
};

export default Message;
