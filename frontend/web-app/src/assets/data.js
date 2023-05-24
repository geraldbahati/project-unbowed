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
