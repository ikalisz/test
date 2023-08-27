$(function() {
    window.addEventListener('message', function(event) {
        if (event.data.enable ) {
            SlideUp()
        } else if (event.data.volume == "updatevolume") {
            $('#volumeLevel').html(event.data.level);
        } else {
            SlideDown()
        }
    });

    document.onkeyup = function (data) {
        if (data.which == 27) { // Escape key
            $.post('http://ra1derRadio/escape', JSON.stringify({}));
            SlideDown()
        } else if (data.which == 13) { // Escape key
            $.post('http://ra1derRadio/joinRadio', JSON.stringify({
                channel: $("#channel").val()
            }));
        }
    };
});

$(document).on('click', '#submit', function(e){
    e.preventDefault();

    $.post('http://ra1derRadio/joinRadio', JSON.stringify({
        channel: $("#channel").val()
    }));
});

$(document).on('click', '#disconnect', function(e){
    e.preventDefault();

    $.post('http://ra1derRadio/leaveRadio');
});

$(document).on('click', '#disconnect', function(e){
    e.preventDefault();

    $.post('http://ra1derRadio/leaveRadio');
});

$(document).on('click', '#volumeUp', function(e){
    e.preventDefault();

    $.post('http://ra1derRadio/sesac');
});

$(document).on('click', '#volumeDown', function(e){
    e.preventDefault();

    $.post('http://ra1derRadio/seskis');
});

SlideUp = function() {
    $(".container").css("display", "block");
    $(".radio-container").animate({bottom: "6vh",}, 700);
}

SlideDown = function() {
    $(".radio-container").animate({bottom: "-110vh",}, 400, function(){
        $(".container").css("display", "none");
    });
}