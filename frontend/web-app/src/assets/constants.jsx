import {
    AiFillHome,
    BsFolderFill,
    BiConversation,
    FaRobot,
    BiScan,
    IoSettings,
} from "react-icons/all";

const iconSize = {
    fontSize: "1.5rem",
    marginBottom: "2.65rem",
    color: "#fff",
};

export const sidebarIcons = [
    { jsx: <AiFillHome style={iconSize} />, name: "Home", path: "/home" },
    { jsx: <BsFolderFill style={iconSize} />, name: "Files", path: "/files" },
    { jsx: <BiConversation style={iconSize} />, name: "Chats", path: "/chats" },
    { jsx: <FaRobot style={iconSize} />, name: "Bot", path: "/bot" },
    { jsx: <BiScan style={iconSize} />, name: "Scan", path: "/scan" },
    {
        jsx: <IoSettings style={iconSize} />,
        name: "Settings",
        path: "/settings",
    },
];
