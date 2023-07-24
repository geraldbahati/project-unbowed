import React from "react";
import { Badge, Avatar } from "@mui/material";
import { styled } from "@mui/material/styles";
import { BiCheckDouble } from "react-icons/bi";
import moment from "moment";

import "../../styles/Chat/Conversation.css";
import { imageData } from "../../assets/data";

// Styling for the online dot
// const StyledBadge = styled(Badge)(({ theme }) => ({
//     "& .MuiBadge-badge": {
//         backgroundColor: "#44b700",
//         color: "#44b700",
//         boxShadow: `0 0 0 2px ${theme.palette.background.paper}`,
//         "&::after": {
//             position: "absolute",
//             top: 0,
//             left: 0,
//             width: "100%",
//             height: "100%",
//             borderRadius: "50%",
//             animation: "ripple 1.2s infinite ease-in-out",
//             border: "1px solid currentColor",
//             content: '""',
//         },
//     },
//     "@keyframes ripple": {
//         "0%": {
//             transform: "scale(.8)",
//             opacity: 1,
//         },
//         "100%": {
//             transform: "scale(2.4)",
//             opacity: 0,
//         },
//     },
// }));

const Conversation = ({ chatRoom }) => {
    const { owner, name, last_message, updated } = chatRoom;

    const formattedTimestamp = moment(updated).calendar(null, {
        lastDay: "[Yesterday]",
        sameDay: "h:mm A",
        lastWeek: "DD/MM/YYYY",
        sameElse: "DD/MM/YYYY",
    });
    const truncatedMessage =
        last_message && last_message.length > 56
            ? last_message.slice(0, 56) + "..."
            : last_message;

    return (
        <div className="conv">
            <div className="conv__avatar">
                {/* <StyledBadge
                    overlap="circular"
                    anchorOrigin={{ vertical: "bottom", horizontal: "right" }}
                    variant="dot"
                >
                    </StyledBadge> */}
                <Avatar
                    alt={owner.username}
                    src={imageData[3].img}
                    sx={{ width: 56, height: 56 }}
                />
            </div>
            <div className="conv__summary">
                <div className="conv__user">
                    <div className="conv__userName">{name}</div>
                    <div className="conv__usertime">{formattedTimestamp}</div>
                </div>
                <div className="conv__snippet">
                    <div className="conv__snippetIcon">
                        <BiCheckDouble style={{ color: "blue" }} />
                    </div>
                    <div className="conv__snippetText">
                        {truncatedMessage || "No messages yet"}
                    </div>
                    <div className="conv_snippetRead" />
                </div>
            </div>
        </div>
    );
};

export default Conversation;
