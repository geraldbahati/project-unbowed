import React from "react";
import { FaEllipsisH, FaPlus, FaSearch } from "react-icons/all";

import "../../styles/Chat/Sidebar.css";
import Conversation from "./Conversation";

const SidebarChat = () => {
    return (
        <div className="sidebar">
            <button className="sidebar__button">
                <FaPlus />
                <span>New Conversation</span>
            </button>

            <div className="sidebar__heading">
                <h2>Chats</h2>
                <button className="sidebar__headingBtn">
                    <FaEllipsisH />
                </button>
            </div>

            <div className="sidebar__search">
                <div className="sidebar__searchWrap">
                    <input type="text" placeholder="Search Here" />
                    <button className="sidebar__searchWrapBtn">
                        <FaSearch />
                    </button>
                </div>
            </div>

            <div className="sidebar__conversations">
                {[1, 2, 3, 4, 5].map((item, key) => (
                    <Conversation key={key} />
                ))}
            </div>
        </div>
    );
};

export default SidebarChat;
