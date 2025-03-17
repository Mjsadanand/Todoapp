<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Todo Maker</title>
    <link rel="stylesheet" >
    <style>* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
    font-family: Arial, sans-serif;
}

body {
    height: 100vh;
    display: flex;
    justify-content: center;
    align-items: center;
    position: relative;
    overflow: hidden;
}

#bg-video {
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    object-fit: cover;
    z-index: -1;
}

.overlay {
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background-color: rgba(0, 0, 0, 0.5);
    z-index: 1;
}

.container {
    text-align: center;
    z-index: 2;
    color: white;
}

h1 {
    font-size: 3rem;
    margin-bottom: 1rem;
    text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.5);
}

p {
    font-size: 1.2rem;
    margin-bottom: 2rem;
    text-shadow: 1px 1px 2px rgba(0, 0, 0, 0.5);
}

.buttons {
    display: flex;
    gap: 20px;
    justify-content: center;
}

.btn {
    display: inline-block;
    padding: 12px 30px;
    border: none;
    border-radius: 5px;
    font-size: 1rem;
    font-weight: bold;
    text-transform: uppercase;
    cursor: pointer;
    transition: all 0.3s ease;
}

.btn-register {
    background-color: #4CAF50;
    color: white;
}

.btn-login {
    background-color: transparent;
    color: white;
    border: 2px solid white;
}

.btn-register:hover {
    background-color: #45a049;
    transform: translateY(-3px);
    box-shadow: 0 5px 15px rgba(0, 0, 0, 0.3);
}

.btn-login:hover {
    background-color: rgba(255, 255, 255, 0.1);
    transform: translateY(-3px);
    box-shadow: 0 5px 15px rgba(0, 0, 0, 0.3);
}
    </style>
</head>
<body>
    <video autoplay muted loop id="bg-video">
        <source src="background-video.mp4" type="video/mp4">
    </video>

    <div class="overlay"></div>

    <div class="container">
        <h1>Welcome to Todo Application</h1>
        <p>Make your plans for the future</p>
        <div class="buttons">
            <button class="btn btn-register" onclick="window.location.href = 'register.jsp';">Register</button>
            <button class="btn btn-login" onclick="window.location.href = 'login.jsp';">Login</button>
        </div>
    </div>
</body>
</html>
