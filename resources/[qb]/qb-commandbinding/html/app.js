qBinding = {}

$(document).on('keydown', function() {
    switch(event.keyCode) {
        case 27:
            qBinding.Close();
            break;
    }
});

$(document).ready(function(){
    window.addEventListener('message', function(event){
        var eventData = event.data;

        if (eventData.action == "openBinding") {
            qBinding.Open(eventData);
        }
    });
});

$(document).on('click', '.save-bindings', function(e){
    e.preventDefault();

    var keyData = {}
    keyData['108'] = [$("#command-108").val(), $("#argument-108").val()]
    keyData['110'] = [$("#command-110").val(), $("#argument-110").val()]
    keyData['109'] = [$("#command-109").val(), $("#argument-109").val()]
    keyData['117'] = [$("#command-117").val(), $("#argument-117").val()]
    keyData['111'] = [$("#command-111").val(), $("#argument-111").val()]
    keyData['118'] = [$("#command-118").val(), $("#argument-118").val()]

    $.post('https://qb-commandbinding/save', JSON.stringify({
        keyData: keyData
    }));
});

qBinding.Open = function(data) {
    $(".container").fadeIn(150);

    $.each(data.keyData, function(id, keyData){
        var commandString = $(".keys").find("[data-key='" + id + "']").find('#command-'+id)
        var argumentString = $(".keys").find("[data-key='" + id + "']").find('#argument-'+id)
        
        if (keyData.command != null) {
            $(commandString).val(keyData.command) 
        }
        if (keyData.argument != null) {
            $(argumentString).val(keyData.argument)
        }
    });
}

qBinding.Close = function() {
    $(".container").fadeOut(150);
    $.post('https://qb-commandbinding/close');
}