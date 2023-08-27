window.addEventListener("message", function(event) {
    if (event.data.photo) {
        $(".zoom-image-photo").attr("src", event.data.photo)
        $(".zoom-image").fadeIn(500)
    } else if (event.data.preview) {
        $(".image-preview-photo").attr("src", "" + event.data.preview)
        console.log(JSON.stringify(event.data))
        setTimeout(() => {        
            $(".image-preview").fadeIn(500, function() {
                setTimeout(() => {        
                    $(".image-preview").animate({
                        right: "2%",
                        bottom: "2%",
                        height: "30%",
                        width: "30%"
                    }, 1000, function() {
                        setTimeout(() => {
                            $(".image-preview").fadeOut(500, function() {
                                $(".image-preview").css({
                                    "right": "20%",
                                    "bottom": "20%",
                                    "height": "60%",
                                    "width": "60%"
                                })
                            })
                        }, 2500);
                    })
                }, 1000);
            })
        }, 500);
    }
});

$(document).ready(function() {
    $('body').on('keyup', function (key) {
        if (key.which == 8 || key.which == 27) {
            closeZoom()
        }
    })
})

$(".copy-link-image").click(function() {
    var node = document.createElement('textarea');
    var selection = document.getSelection();

    node.textContent = $('.zoom-image-photo').attr('src');
    document.body.appendChild(node);

    selection.removeAllRanges();
    node.select();
    document.execCommand('copy');
    $.post('https://jtCamera/Notify', JSON.stringify({
        message: "Photo URL Copied.",
        type: "primary"
    }))

    selection.removeAllRanges();
    document.body.removeChild(node);
});

function closeZoom() {
    $(".zoom-image").fadeOut(500)
    $.post("https://jtCamera/closeZoomImage")
}