import { AiFillHome } from "react-icons/ai";
import { BsFolderFill } from "react-icons/bs";
import { FaRobot } from "react-icons/fa";
import { BiConversation, BiScan } from "react-icons/bi";

const iconSize = {
    fontSize: "1.5rem",
    marginBottom: "2.65rem",
    color: "#fff",
};

export const sidebarIcons = [
    {
        jsx: <AiFillHome style={iconSize} />,
        name: "Home",
        path: "/home",
    },
    {
        jsx: <BsFolderFill style={iconSize} />,
        name: "Files",
        path: "/files",
    },
    {
        jsx: <BiConversation style={iconSize} />,
        name: "Chats",
        path: "/chats",
    },
    {
        jsx: <FaRobot style={iconSize} />,
        name: "Bot",
        path: "/bot",
    },
    {
        jsx: <BiScan style={iconSize} />,
        name: "Scan",
        path: "/scan",
    },
    // {
    //     jsx: <IoSettings style={iconSize} />,
    //     name: "Settings",
    //     path: "/settings",
    // },
];
