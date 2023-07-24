import React, { useState, useEffect } from "react";
import moment from "moment";
import { Avatar } from "@mui/material";

import "../../styles/Chat/Message.css";
import { imageData } from "../../assets/data";

const Message = ({ data, prev }) => {
    const { id, created, sender, description } = data;
    const [showSenderTime, setShowSenderTime] = useState(false);
    const [showUserTime, setShowUserTime] = useState(false);

    const currentUser = "+254790329620";
    const user = currentUser === sender.username;
    const isSameSender = prev === sender.username;

    const formattedTime = moment(created).calendar(null, {
        lastDay: "[Yesterday], h:mm A",
        sameDay: "h:mm A",
        lastWeek: "DD/MM/YYYY, h:mm A",
        sameElse: "DD/MM/YYYY, h:mm A",
    });

    return (
        <>
            {user ? (
                <div className="user_message">
                    <div
                        className="user_message__content"
                        onClick={() => {
                            setShowUserTime(!showUserTime);
                        }}
                    >
                        {description}
                    </div>
                    <div className="user_message__info">
                        <p className="user_placeholder">{"  "}</p>
                        {showUserTime && (
                            <div className="user_message__time">
                                {formattedTime}
                            </div>
                        )}
                    </div>
                </div>
            ) : (
                <div className="other_message">
                    {isSameSender ? null : (
                        // <h5 className="message__sender">{sender.username}</h5>
                        <div className="message__avatar">
                            <Avatar src={imageData[3].img} />
                        </div>
                    )}

                    <div
                        className="message__content"
                        onClick={() => {
                            setShowSenderTime(!showSenderTime);
                        }}
                    >
                        {description}
                    </div>

                    <div className="message__info">
                        {/* {isSameSender ? null : (
                            // <div className="message__avatar">
                            //     <Avatar src={imageData[3].img} />
                            // </div>

                        )} */}
                        {showSenderTime && (
                            <div className="message__time">{formattedTime}</div>
                        )}
                    </div>
                </div>
            )}
        </>
    );
};

export default Message;
