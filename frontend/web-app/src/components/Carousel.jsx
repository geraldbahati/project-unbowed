import React, { useState, useEffect } from "react";
import "../styles/Carousel.css"; // Import the CSS file

import { imageData } from "../assets/data";

const Carousel = () => {
    const [currentSlide, setCurrentSlide] = useState(0);

    useEffect(() => {
        const interval = setInterval(() => {
            setCurrentSlide((prevSlide) => (prevSlide + 1) % 2);
        }, 3000);

        return () => {
            clearInterval(interval);
        };
    }, []);

    return (
        <div className="carousel">
            <div className="carousel-inner">
                <div
                    className={`carousel-slide ${
                        currentSlide === 0 ? "active" : "inactive"
                    }`}
                >
                    <img src={imageData[1].img} alt="Image 1" />
                </div>
                <div
                    className={`carousel-slide ${
                        currentSlide === 1 ? "active" : "inactive"
                    }`}
                >
                    <img src={imageData[2].img} alt="Image 2" />
                </div>
            </div>
        </div>
    );
};

export default Carousel;
