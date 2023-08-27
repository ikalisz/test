window.addEventListener('message', (event) => {
    if (event.data.type === 'open') {
        console.log(event.data.text);
        $('.text').html(event.data.text);
        $(".ana").css({
            'display': 'block'
        }).animate({
            top: "10vh"
        }, 1e3)
    } else if (event.data.type === 'close') {
        $(".ana").css({
            'display': 'block'
        }).animate({
            top: "0vh"
        }, 1e3, function () {
            $(".ana").css({
                'display': 'none'
            })
        })
    } else if (event.data.type === 'update') {
        console.log(event.data.text);
        $('.text').html(event.data.text);
    }
});