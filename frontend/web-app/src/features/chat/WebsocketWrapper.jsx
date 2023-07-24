import { useState, useEffect } from "react";

const WebSocketWrapper = ({ url, onMessage }) => {
    const [socket, setSocket] = useState(null);

    useEffect(() => {
        const newSocket = new WebSocket(url);

        newSocket.onopen = () => {
            console.log("WebSocket connected");
        };

        newSocket.onmessage = (event) => {
            const message = JSON.parse(event.data);
            onMessage(message);
        };

        newSocket.onclose = () => {
            console.log("WebSocket disconnected");
        };

        setSocket(newSocket);

        return () => {
            newSocket.close();
        };
    }, [url, onMessage]);

    const sendMessage = (message) => {
        if (socket) {
            socket.send(JSON.stringify(message));
        }
    };

    return null;
};

export default WebSocketWrapper;
