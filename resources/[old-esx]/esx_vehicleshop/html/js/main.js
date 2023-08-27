let carData = {}
let lastRemove = ""
let selectedCar = {}
let inSuleyman = false
let notifActive = false

window.addEventListener('message', (event) => {
    if (event.data.type === 'open') {
        inSuleyman = event.data.suleyman
        menuOpen(event.data.carData)
    } else if (event.data.type === 'notif') { 
        if (!notifActive) {
            notifActive = true
            $("#notif").html(event.data.text)
            $( "#notif" ).animate({
                left: "0",
            }, 300, function() {
                setTimeout(() => {
                    $( "#notif" ).animate({
                        left: "-50%",
                    }, 300, function() {
                        notifActive = false
                    });
                }, 3500);
            });
        }
    }
});

document.addEventListener('mousedown', function(e) {
    if (e.button === 2) {
        $(".rightClickNone").css("opacity", "0.0")
        $.post('http://esx_vehicleshop/rightClick', JSON.stringify({}), function() {
            $(".rightClickNone").css("opacity", "1.0")
        });
    }
});

function menuOpen(newCarData) {
    carData = {}
    for(i=0;i<newCarData.length;i++){
        var element = newCarData[i];
        carData[element.sinif] = [];
        Object.keys(element.arac).forEach(function(carD) {
            const data = element.arac[carD]
            carData[element.sinif].push({carName: data.name, price: data.price, carModel: data.model, class: element.sinif, count: data.count})
        }); 
    };
    let topMenuButton = ""
    $(".car-slider").html("")
    let first = true
    Object.keys(carData).forEach(function(element) {

        if (first) {
            topMenuButton = topMenuButton + `
                <div class="top-menu-button topMenuFontSize" id="topMenu${element.replace(/\s/g, '')}">${element}</div>
            `
            lastRemove = element.replace(/\s/g, '')
            carSliderContent = `<div class="car-slider-2" id=${element.replace(/\s/g, '')}>`
            setCarInfo(carData[element][0])
        } else {
            topMenuButton = topMenuButton + `
                <div class="top-menu-button" id="topMenu${element.replace(/\s/g, '')}">${element}</div>
            `
            carSliderContent = `<div class="car-slider-2 displayNone" id=${element.replace(/\s/g, '')}>`
        }

        for (let index = 0; index < carData[element].length; index++) {
            const xelement = carData[element][index];
            if (xelement.count > 0) {
                carSliderContent = carSliderContent + `
                    <div class="car-slider-content" style="border-left-style: solid; border-color: #e40202; background-image: url(img/${xelement.carModel}.png);" data-id="${index}" data-class="${element}">
                    <div class="ra1derbaslik">${xelement.carName} </div>
                    <div class="ra1derstok"> STOK : ${xelement.count} </div>
                    </div>   
                `
            } else {
                carSliderContent = carSliderContent + `
                    <div class="car-slider-content" style="background-image: url(img/${xelement.carModel}.png);" data-id="${index}" data-class="${element}">
                    <div class = "ra1dercolor"> </div>
                    <div class="ra1derbaslik">${xelement.carName} </div>
                        <div class="ra1derstok">Stok Bulunamadı</div>
                    </div>   
                `
            }
           
            if (first) {
                first = false
                selectedCar = carData[element][index]
            }
        }

        carSliderContent = carSliderContent + "</div>"
        $( ".car-slider").append(carSliderContent);
        setSliderData(element.replace(/\s/g, ''))
    });
    $(".top-menu").html(topMenuButton)
    $(".main").css("display", "flex")
};

$(document).on("click",".top-menu-button", function(e) {
    let id = $(this).html().replace(/\s/g, '')
    if (id != lastRemove) {
        $("#"+id).removeClass("displayNone")
        $("#"+lastRemove).addClass("displayNone")

        $("#topMenu"+id).addClass("topMenuFontSize")
        $("#topMenu"+lastRemove).removeClass("topMenuFontSize")
        lastRemove = id
        selectedCar = carData[$(this).html()][$('#'+id+ ' .slick-current').attr("data-slick-index")]
        setCarInfo(selectedCar)
    }
});

function setSliderData(className) {
    $('#'+ className).slick({
        dots: false,
        infinite: false,
        variableWidth: true,
        centerMode: true,
        arrows: false,
        draggable: false,
        focusOnSelect: true,
        initialSlide: 3,
        draggable: false,
    });
}

$('.car-slider').on('afterChange', function(event, slick, currentSlide){
    selectedCar = carData[$(slick.$slides.get(currentSlide)).data("class")][$(slick.$slides.get(currentSlide)).data("id")]
    setCarInfo(selectedCar)   
});

function setCarInfo(data) {
    $(".buy-menu").css("display", "none")
    $(".test-menu").css("display", "none")
    $.post('http://esx_vehicleshop/getCarDataAndSpawnCar', JSON.stringify({model: data.carModel}), function(cbData) {
        if (inSuleyman) {
            $(".car-money").html(setCurrency(data.price))
        } else {
            $(".car-money").html("Buying: " + setCurrency(Math.round(data.price*0.75)) + " Sales: "+ setCurrency(data.price))
        }
        $("#box-speed-bar").css("width", cbData.topspeed+"%")
        $("#box-handling-bar").css("width", cbData.handling+"%")
        $("#box-braking-bar").css("width", cbData.braking+"%")
        $("#box-accel-bar").css("width", cbData.accel+"%")
    });
    if (data.count > 0) {
        $(".car-buy-button").html("$ BUY")
    } else {
        $(".car-buy-button").html("OUT OF STOCK!")
    }
}

$(document).on("click","#close", function() {
    closeMenu(false)
});

function closeMenu(buy, test) {
    $.post('http://esx_vehicleshop/closeMenu', JSON.stringify({buy: buy, test:test}));
    $(".main").fadeOut(500)
};

// Buy Button
$(document).on("click",".car-buy-button", function() {
    $(".buy-menu-money").html(setCurrency(selectedCar.price)) 
    $(".buy-menu").css("display", "flex")
});

$(document).on("click","#buy-menu-cancel", function() {
    $(".buy-menu").css("display", "none")
});

$(document).on("click","#buy-menu-accept", function() {
    $.post('http://esx_vehicleshop/buyCar', JSON.stringify({selectedCar}), function() {
        closeMenu(true)
    });
});

// Test Button
$(document).on("click",".car-test-button", function() {
    $(".test-menu").css("display", "flex")
});

$(document).on("click","#test-menu-cancel", function() {
    $(".test-menu").css("display", "none")
});

$(document).on("click","#test-menu-accept", function() {
    $.post('http://esx_vehicleshop/testCar', JSON.stringify({selectedCar}), function() {
        closeMenu(false, true)
    });
});

function setCurrency(price) {
    return (price).toLocaleString('tr-TR', {style: 'currency',currency: 'USD', maximumFractionDigits: 0, minimumFractionDigits: 0})
}