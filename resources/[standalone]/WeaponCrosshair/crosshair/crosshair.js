window.addEventListener("message", function(event) {
    if (event.data.show) {
        document.getElementById('container').style.display = "block"
    } else {
        document.getElementById('container').style.display = "none"
    }
})