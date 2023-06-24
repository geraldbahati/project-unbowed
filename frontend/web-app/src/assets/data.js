import React from "react";
import image1 from "./images/gameboy.png";
import image2 from "./images/hiring.png";
import image3 from "./images/question.png";
import image4 from "./images/robot.png";
import image5 from "./images/speaking.png";
import image6 from "./images/sci-fi.png";

export const add = (id, name) => {
    let len = roomData.push({
        id: id,
        name: name,
    });
};

export const arrOptions = [
    { name: "Profile", link: "profile/" },
    { name: "Settings", link: "options/" },
    {
        name: "notifications",
        link: "music/",
    },
];

export const allOptions = [
    { name: "Feed", link: "feed/" },
    { name: "Tracks", link: "tracks/" },
    { name: "Distribution", link: "distribution/" },
    { name: "Publishing", link: "publishing/" },
    { name: "Beat ID", link: "beat-id/" },
    { name: "Gift Cards", link: "gift-cards/" },
];

export const authOptions = [
    { name: "Sign in", link: "login/" },
    { name: "Sign up", link: "register/" },
];

export let roomData = [
    {
        id: 1,
        name: "Dance Room",
    },
    {
        id: 2,
        name: "Gaming Room",
    },
];

export const imageData = [
    {
        id: 1,
        img: image1,
        title: "Image",
        author: "author",
    },
    {
        id: 2,
        img: image2,
        title: "Image",
        author: "author",
    },
    {
        id: 3,
        img: image3,
        title: "Image",
        author: "author",
    },
    {
        id: 4,
        img: image4,
        title: "Image",
        author: "author",
    },
    {
        id: 5,
        img: image5,
        title: "Image",
        author: "author",
    },
    {
        id: 6,
        img: image6,
        title: "Image",
        author: "author",
    },
];

export const chartData = [
    {
        name: "Page A",
        uv: 4000,
        pv: 2400,
        amt: 2400,
    },
    {
        name: "Page B",
        uv: 3000,
        pv: 1398,
        amt: 2210,
    },
    {
        name: "Page C",
        uv: 2000,
        pv: 9800,
        amt: 2290,
    },
    {
        name: "Page D",
        uv: 2780,
        pv: 3908,
        amt: 2000,
    },
    {
        name: "Page E",
        uv: 1890,
        pv: 4800,
        amt: 2181,
    },
    {
        name: "Page F",
        uv: 2390,
        pv: 3800,
        amt: 2500,
    },
    {
        name: "Page G",
        uv: 3490,
        pv: 4300,
        amt: 2100,
    },
];

export const filterButton = ["File Type", "People", "Last Modified"];
