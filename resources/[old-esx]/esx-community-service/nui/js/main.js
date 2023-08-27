window.addEventListener('message', (event) => {
    if (event.data.type === 'open') {
        $('.text').html(event.data.text);
        $(".ana").css({
            'display': 'block'
        }).animate({
            right: "15px"
        }, 1e3)
    } else if (event.data.type === 'close') {
        $(".ana").css({
            'display': 'block'
        }).animate({
            right: "-335px"
        }, 1e3, function () {
            $(".ana").css({
                'display': 'none'
            })
        })
    } else if (event.data.type === 'update') {
        $('.text').html(event.data.text);
    }
});