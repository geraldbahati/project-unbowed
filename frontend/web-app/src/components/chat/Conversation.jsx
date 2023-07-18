import React from "react";
import { Badge, Avatar } from "@mui/material";
import { styled } from "@mui/material/styles";
import { BiCheckDouble } from "react-icons/bi";

import "../../styles/Chat/Conversation.css";
import { imageData } from "../../assets/data";

// Styling for the online dot
const StyledBadge = styled(Badge)(({ theme }) => ({
    "& .MuiBadge-badge": {
        backgroundColor: "#44b700",
        color: "#44b700",
        boxShadow: `0 0 0 2px ${theme.palette.background.paper}`,
        "&::after": {
            position: "absolute",
            top: 0,
            left: 0,
            width: "100%",
            height: "100%",
            borderRadius: "50%",
            animation: "ripple 1.2s infinite ease-in-out",
            border: "1px solid currentColor",
            content: '""',
        },
    },
    "@keyframes ripple": {
        "0%": {
            transform: "scale(.8)",
            opacity: 1,
        },
        "100%": {
            transform: "scale(2.4)",
            opacity: 0,
        },
    },
}));

const Conversation = () => {
    return (
        <div className="conv">
            <div className="conv__avatar">
                <StyledBadge
                    overlap="circular"
                    anchorOrigin={{ vertical: "bottom", horizontal: "right" }}
                    variant="dot"
                >
                    <Avatar
                        alt="Remy Sharp"
                        src={imageData[3].img}
                        sx={{ width: 56, height: 56 }}
                    />
                </StyledBadge>
            </div>
            <div className="conv__summary">
                <div className="conv__user">
                    <div className="conv__userName">Wizzoh</div>
                    <div className="conv__usertime">4.20pm</div>
                </div>
                <div className="conv__snippet">
                    <div className="conv__snippetIcon">
                        <BiCheckDouble style={{ color: "blue" }} />
                    </div>
                    <div className="conv__snippetText">
                        Hello, Welcome to my new whatsapp clone chat app
                    </div>
                    <div className="conv_snippetRead" />
                </div>
            </div>
        </div>
    );
};

export default Conversation;
