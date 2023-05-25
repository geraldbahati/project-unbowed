import React, { useEffect, useState } from "react";

import "../styles/Chats.css";
import { Sidebar, Body } from "../components/chat";

const Chats = () => {
    return (
        <div className="chats">
            <Sidebar />
            <Body />
        </div>
    );
};

export default Chats;
