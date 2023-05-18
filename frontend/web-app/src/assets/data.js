import car1 from "./images/1.jpg";
import car2 from "./images/2.jpg";
import car3 from "./images/3.jpg";
import car4 from "./images/4.jpg";
import car5 from "./images/5.jpg";
import car6 from "./images/6.jpg";

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
        img: car1,
        title: "Image",
        author: "author",
    },
    {
        id: 2,
        img: car2,
        title: "Image",
        author: "author",
    },
    {
        id: 3,
        img: car3,
        title: "Image",
        author: "author",
    },
    {
        id: 4,
        img: car4,
        title: "Image",
        author: "author",
    },
    {
        id: 5,
        img: car5,
        title: "Image",
        author: "author",
    },
    {
        id: 6,
        img: car6,
        title: "Image",
        author: "author",
    },
];
