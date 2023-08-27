var ownerdNotepad;
var notepadreader;
var notepadid;

document.onkeyup = function (data) {
    if (data.which == 27) { // Escape key
        $.post('https://tgiann-notepad/escape', JSON.stringify({}));
        ownerdNotepad = document.getElementById("p1").value;
        notepadreader = false;
        document.getElementById("p1").value = "";
        $("#main").fadeOut();
        $("#main").css('display', 'none');
    }
};

function dropNotepad() {
    var x = document.getElementById("p1").value;
    if (x == ""){
        $.post('https://tgiann-notepad/droppingEmpty', JSON.stringify({}));
    } else if (notepadreader == true) {
        var x = document.getElementById("p1").value;
        $.post('https://tgiann-notepad/updating', JSON.stringify({ text: x, id: notepadid}));
        $("#main").fadeOut();
        $("#main").css('display', 'none');
        notepadreader = false;
        document.getElementById("p1").value = "";
    } else {
        $.post('https://tgiann-notepad/dropping', JSON.stringify({ text: x }));
        $("#main").fadeOut();
        document.getElementById("p1").value = "";
        $("#main").css('display', 'none');
    }   
}

window.addEventListener('message', function(e) {
    switch(event.data.action) {
        case 'openNotepad':
            if (ownerdNotepad === undefined){
                document.getElementById("p1").value = "";
                $("#main").fadeIn();
            } else {
                $("textarea").removeAttr('disabled','disabled');
                $("button").fadeIn();
                document.getElementById("p1").value = ownerdNotepad;
                $("#main").fadeIn();
            }
            break;
        case 'openNotepadRead':
            notepadreader = true;
            notepadid = event.data.Id
            $("textarea").removeAttr('disabled','disabled');
            $("button").fadeIn();
            $("#main").fadeIn();
            document.getElementById("p1").value = event.data.TextRead;
            break;
        case 'closeNotepad':
            $("#main").fadeOut();
            $("#main").css('display', 'none');
            break;
        case 'cleanNotepad':
            document.getElementById("p1").value = "";
            break;
    }
});




