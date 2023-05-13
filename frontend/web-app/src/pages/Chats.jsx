import React, { useEffect, useState } from "react";
import { nanoid } from "@reduxjs/toolkit";
import { Avatar } from "@mui/material";
import { Link } from "react-router-dom";

import { Sidebar } from "../components";
import Conversation from "./Conversation";
import { add } from "../assets/data";
import logo from "../assets/images/logo_2.jpg";
import "../styles/Chats.css";

const Chats = ({ id, name, addNewChat }) => {
    return (
        <>
            <Sidebar>
                <Conversation />
            </Sidebar>
        </>
    );
};

export default Chats;
