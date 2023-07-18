import React, { useState } from "react";
import { Link, useNavigate } from "react-router-dom";
import { useDispatch } from "react-redux";
import { useTheme } from "@mui/material/styles";
import useMediaQuery from "@mui/material/useMediaQuery";
import HowToRegIcon from "@mui/icons-material/HowToReg";
import LockOpenIcon from "@mui/icons-material/LockOpen";
import { CgMenu, CgProfile, CgOptions, CgNotifications } from "react-icons/cg";
import {
    Button,
    Drawer,
    List,
    ListItemButton,
    ListItemText,
} from "@mui/material";

import "../styles/Menu.css";

const arrOptions = [
    { name: "Profile", icon: <CgProfile />, link: "profile/" },
    { name: "Settings", icon: <CgOptions />, link: "options/" },
    {
        name: "notifications",
        icon: <CgNotifications />,
        link: "music/",
    },
];

const allOptions = [
    { name: "Feed", link: "feed/" },
    { name: "Tracks", link: "tracks/" },
    { name: "Distribution", link: "distribution/" },
    { name: "Publishing", link: "publishing/" },
    { name: "Beat ID", link: "beat-id/" },
    { name: "Gift Cards", link: "gift-cards/" },
];

const authOptions = [
    { name: "Sign in", icon: <LockOpenIcon />, link: "login/" },
    { name: "Sign up", icon: <HowToRegIcon />, link: "register/" },
];

const Sidebar = (props) => {
    const navigate = useNavigate();
    const dispatch = useDispatch();
    const [open, setOpen] = useState(false);

    const theme = useTheme();
    const isLargeScreen = useMediaQuery(theme.breakpoints.up("lg"));
    return (
        <div className="sidebar">
            <Button
                startIcon={<CgMenu />}
                onClick={() => {
                    setOpen(true);
                }}
            />
            <Drawer
                open={open}
                onClose={() => setOpen(false)}
                className="sidebar__drawer"
                PaperProps={{
                    style: {
                        width: isLargeScreen ? "25%" : "66.67%",
                    },
                }}
            >
                <List>
                    {allOptions.map((item) => (
                        <ListItemButton
                            onClick={() => {
                                setOpen(false);
                                navigate(item.link);
                            }}
                        >
                            <ListItemText
                                primary={item.name}
                                style={{ marginLeft: 5, marginRight: 5 }}
                            />
                        </ListItemButton>
                    ))}
                    <hr />
                    {arrOptions.map((item) => (
                        <ListItemButton
                            onClick={() => {
                                setOpen(false);
                                navigate(item.link);
                            }}
                        >
                            {item.icon}
                            <ListItemText
                                primary={item.name}
                                style={{ marginLeft: 15 }}
                            />
                        </ListItemButton>
                    ))}
                    <hr />
                    {authOptions.map((item) => (
                        <ListItemButton
                            onClick={() => {
                                setOpen(false);
                                navigate(item.link);
                            }}
                        >
                            {item.icon}
                            <ListItemText
                                primary={item.name}
                                style={{ marginLeft: 15 }}
                            />
                        </ListItemButton>
                    ))}
                </List>
            </Drawer>
        </div>
    );
};

export default Sidebar;
