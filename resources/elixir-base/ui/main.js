window.addEventListener('message', (event) => {
    if (event.data.type === 'crosshairOpen') {
        const element = document.getElementById("crosshair")
        element.classList.add("display");
    } else if (event.data.type === 'crosshairClose') {
        const element = document.getElementById("crosshair")
        element.classList.remove("display");
    }  else if (event.data.type === 'notifOpen') {
        const element = document.getElementById("notif")
        element.classList.add("display");
        element.innerHTML = event.data.text;
    } else if (event.data.type === 'notifClose') {
        const element = document.getElementById("notif")
        element.classList.remove("display");
    }
});