let inVehicle = false
let phoneOpen = false
let updatedCashCount = 0

window.addEventListener('message', (event) => {
   
    if (event.data.type == "money") {
        $("#cash").html(setCurrency(event.data.money))
        if (event.data.show) {
            $(".money-cash").animate({opacity: "1.0"}, 100);
        } else {
            $(".money-cash").animate({opacity: "0.0"}, 100);
        }
        
    } else if (event.data.type == "moneyUpdate") {
        updatedCashCount++
        $("#cash").html(setCurrency(event.data.newCashAmount))
        if (event.data.isMinus) {plusOrMinus = "-"} else {plusOrMinus = "+"}
        $(".money-cash").animate({opacity: "1.0"}, 100);
        if (updatedCashCount == 1) {
            $("#addCashValue").html(plusOrMinus+setCurrency(event.data.money))
            $("#addCash").animate({opacity: "1.0"}, 100);
        } else {
            $("#addCash").animate({opacity: "0.0"}, 100, function(){
                $("#addCashValue").html(plusOrMinus+setCurrency(event.data.money))
                $("#addCash").animate({opacity: "1.0"}, 100);
            });
        }
        setTimeout(() => {
            updatedCashCount--
            if (updatedCashCount == 0) {
                $(".money-cash").animate({opacity: "0.0"}, 100);
                $("#addCash").animate({opacity: "0.0"}, 100);
            }
        }, 2000);

    } else if (event.data.type == "iparaUpdate") {
        updatediparaCount++
        $("#ipara").html(setCurrency(event.data.newiparaAmount))
        if (event.data.isMinus) {plusOrMinus = "-"} else {plusOrMinus = "+"}
        $(".money-ipara").animate({opacity: "1.0"}, 100);
        if (updatediparaCount == 1) {
            $("#addiparaValue").html(plusOrMinus+setCurrency(event.data.ipara))
            $("#addipara").animate({opacity: "1.0"}, 100);
        } else {
            $("#addipara").animate({opacity: "0.0"}, 100, function(){
                $("#addiparaValue").html(plusOrMinus+setCurrency(event.data.ipara))
                $("#addipara").animate({opacity: "1.0"}, 100);
            });
        }
        setTimeout(() => {
            updatediparaCount--
            if (updatediparaCount == 0) {
                $(".money-ipara").animate({opacity: "0.0"}, 100);
                $("#addipara").animate({opacity: "0.0"}, 100);
            }
        }, 2000);


    }
});


function setCurrency(price) {
    return (price).toLocaleString('tr-TR', {style: 'currency', currency: 'USD', maximumFractionDigits: 0, minimumFractionDigits: 0})
}

function carHudMiniIconOnOff(style, on) {
    if (on == "close") {
        $("#"+style).css("display", "none")
        $("#"+style+"-icon").css("display", "none")
    } else if (!on) {
        $("#"+style).css("display", "none")
        $("#"+style+"-icon").css("display", "block")
        $("#"+style+"-icon").css("opacity", "0.45")
    } else {
        $("#"+style).css("display", "block")
        $("#"+style+"-icon").css("display", "block")
        $("#"+style+"-icon").css("opacity", "1.0")
    }
}