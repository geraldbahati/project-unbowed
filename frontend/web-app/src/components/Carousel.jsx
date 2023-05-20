import React, { useState, useEffect } from "react";
import { AnimatePresence, motion } from "framer-motion";

const Carousel = ({ children }) => {
    const [currentIndex, setCurrentIndex] = useState(0);
    const carouselItems = React.Children.toArray(children);

    useEffect(() => {
        const interval = setInterval(() => {
            handleScroll("next");
        }, 10000);

        return () => {
            clearInterval(interval);
        };
    }, []);

    const handleScroll = (direction) => {
        let nextIndex;
        if (direction === "next") {
            nextIndex = (currentIndex + 1) % carouselItems.length;
        } else {
            nextIndex =
                (currentIndex - 1 + carouselItems.length) %
                carouselItems.length;
        }
        setCurrentIndex(nextIndex);
    };

    return (
        <div>
            <AnimatePresence initial={false} custom={currentIndex} wait>
                <motion.div
                    key={currentIndex}
                    initial={{ opacity: 0, x: "100vw", y: 0 }}
                    animate={{ opacity: 1, x: 0, y: 0 }}
                    exit={{ opacity: 0, x: "-100vw", y: 0 }}
                    transition={{ duration: 2, type: "tween" }}
                >
                    {carouselItems[currentIndex]}
                </motion.div>
            </AnimatePresence>

            <div style={{ display: "flex", justifyContent: "center" }}>
                {carouselItems.map((_, index) => (
                    <div
                        key={index}
                        style={{
                            width: "10px",
                            height: "10px",
                            borderRadius: "50%",
                            background: index === currentIndex ? "red" : "gray",
                            margin: "5px",
                            cursor: "pointer",
                        }}
                        onClick={() => setCurrentIndex(index)}
                    />
                ))}
            </div>
        </div>
    );
};

export default Carousel;
