import React, { useEffect, useState, useRef } from "react";

import "../styles/Chats.css";
import { Conversations, Body } from "../components/chat";

const Chats = () => {
    const largeScreen = true;
    // const elementRef = useRef(null);
    // let defaultFontSize = 0;

    // useEffect(() => {
    //     if (elementRef.current) {
    //         const computedStyle = window.getComputedStyle(elementRef.current);
    //         defaultFontSize = parseFloat(computedStyle.fontSize);
    //         console.log("Default font size:", defaultFontSize);
    //     }
    // }, []);

    // const screenSize = {
    //     width: window.innerWidth / defaultFontSize,
    //     height: window.innerHeight / defaultFontSize,
    // };

    // console.log(screenSize);
    // console.log(defaultFontSize);

    return (
        <>
            {largeScreen ? (
                <div className="chats">
                    <Body />
                </div>
            ) : (
                <div className="chats">
                    <Conversations />
                </div>
            )}
        </>
    );
};

export default Chats;
