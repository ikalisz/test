let playerData = []
let bildirimAcik = false

let polisIsim = "Osman Tekatar"
let zanliIsim = "Mehmet Arlanmaz"

let secilenCitizenid = ""

let indirim = 100
let toplamPara = 0

$("#sorgula").click(function() {
    const isimInput = $("#isim-input").val()
    if (isimInput != "") {
        $.post('http://tgiann-emstab/sorgula', JSON.stringify({data: isimInput}), function(cbData) {
            playerData = cbData
            if (playerData.length) {
                $("#isim-input").val("")
                $("#sorgu2").html("")
                let htmlSorgu = ""
                for (let index = 0; index < playerData.length; index++) {
                    const element = playerData[index];
                    let name = element.firstname + " " + element.lastname
                    htmlSorgu = htmlSorgu + `
                        <div class="kullanici" data-id="${index}">
                            <div class="kullanici-sol"><i class="fas fa-user-tag fa-xs"></i></div>
                            <div class="kullanici-orta">${name}</div>
                            <div class="kullanici-sag"><i class="fas fa-angle-right"></i></div>
                        </div>
                    `
                }
                $("#sorgu2").append(htmlSorgu)
                hideUi("#sorgu1");
                showUi("#sorgu2", "block");
                showUi('#sorgu2-button', "block")
            } else {
                bildirim("No Data Found for the Name You Searched for!", "hata")
            }
        });
    }
});

$(document).on("click",".kullanici",function() {
    const userData = playerData[$(this).attr("data-id")]
    let userPhoto = JSON.parse(userData.charinfo).photo
    let userGender = JSON.parse(userData.charinfo).gender
    zanliIsim = userData.firstname + " " + userData.lastname
    secilenCitizenid = userData.citizenid
    if (userPhoto == "resimsiz") { userPhoto = "img/avatar.png" }
    if (userGender == "1") {
        userGender = "Woman"
    } else {
        userGender = "Man"
    }

    $("#kullaniciBilgi").html(`
        <div class="sorgu-sag-alt-sol">
            <div class="bilgi"><div class="bilgi-sol">Gender</div><div class="bilgi-sag">${userGender}</div></div>
            <div class="bilgi"><div class="bilgi-sol">Name</div><div class="bilgi-sag">${userData.firstname}</div></div>
            <div class="bilgi"><div class="bilgi-sol">Last name</div><div class="bilgi-sag">${userData.lastname}</div></div>
            <div class="bilgi"><div class="bilgi-sol">Citizen Number</div><div class="bilgi-sag">${userData.citizenid}</div></div>
        </div>

        <div class="sorgu-sag-alt-sag">
            <div class="bilgi"><div class="bilgi-sol">Phone Number</div><div class="bilgi-sag">${userData.number}</div></div>
            <div class="bilgi"><div class="bilgi-sol">Nationality</div><div class="bilgi-sag">${JSON.parse(userData.charinfo).nationality}</div></div>
            <div class="bilgi"><div class="bilgi-sol">Date of birth</div><div class="bilgi-sag">${JSON.parse(userData.charinfo).birthdate}</div></div>
        </div>

        <div class="userAvatarBox">
            <div class="resim"><img src=${userPhoto}></div>
        </div>
    `)

    $(".sorgu-buttons").html(`
        <button class="sorgu-button-2" id="sabika-gir">View Patient History</button>
        <button class="sorgu-button-2" id="olay-gir">Cut Recipe</button>
    `)
});

$(document).on("click","#sorgu-geri",function() {
    hideUi("#sorgu2");
    hideUi('#sorgu2-button')
    showUi("#sorgu1", "block");
});

function hideUi(cssData) {
    $(cssData).css("display", "none");
}

function showUi(cssData, type) {
    if (type == null) { type = "flex" };
    $(cssData).css("display", type);
}

function bildirim(text, type) {
    if (!bildirimAcik) {
        bildirimAcik = true
        let renk = "#333"
        if (type == "hata") {
            renk = "#333"
        } else if (type == "basari") {
            renk = "#689f38"
        }
        $(".bildirim").html(text)
        $(".bildirim").css("background", renk);
        $(".bildirim").animate({right: "0"}, 500, function() {
            setTimeout(() => {
                $( ".bildirim" ).animate({right: "-20%"}, 500, function() {
                    bildirimAcik = false
                });
            }, 3500);
        });
    }
}

$(document).on("click",".bildirim", function() {
    $( ".bildirim" ).animate({right: "-20%"}, 500, function() {
        bildirimAcik = false
    });
});

$(document).on("click","#olay-close", function() {
    hideUi("#olaygir-menu")
});

$(document).on("click","#olay-gir", function() {
    $(".ceza-para").html('<i class="fas fa-money-bill"></i>0')
    toplamPara = 0
    $(".olay-textarea").val("")
    showUi("#olaygir-menu", "flex")
    cezaListesiSet(cezalar, true)
});

function cezaListesiSet(arr, ilk) {
    $(".list-group").html("")
    let color = true
    let htmlCezalar = ""
    for (let index = 0; index < arr.length; index++) {
        const element = arr[index];
        if (color) {
            backgroundColor = "#2c2d2f"
        } else {
            backgroundColor = "#272829"
        }
        if (ilk) { element.active = false; element.adet = 1 }
        color = !color
        let newClass = "list-group-item d-flex justify-content-between align-items-center"
        if (element.active) {
            newClass = "list-group-item d-flex justify-content-between align-items-center active"
        }

        htmlCezalar = htmlCezalar + `
            <li style="background:${backgroundColor}" class="${newClass}" id="ceza-bilgi" data-isim="${element.isim}">
                <span style="width:80%; text-transform: capitalize;">${element.isim}</span>
                <span class="badge badge-primary badge-pill">${Intl.NumberFormat('en-US').format(element.para)}$ <i class="fas fa-money-bill"></i></span>
                <span class="badge badge-danger badge-pill" id="${(element.isim).replace(/\s+/g, '')}">${element.adet} <i class="fas fa-flag"></i></span>
            </li>
        `
    }
    $(".list-group").append(htmlCezalar)
}

$(document).on("click","#ceza-bilgi",function(e) {
    const cezaIsim = $(this).attr("data-isim")
    const cezaIsimId = cezaIsim.replace(/\s+/g, '')
    console.log(cezaIsimId)
    let cezaData = []
    let index = 0
    for (let i = 0; i < cezalar.length; i++) {
        cezaData = cezalar[i];
        if (cezaData.isim == cezaIsim) {
            index = i
            break
        }
    }
    
    const lastClass = $(this).attr('class').split(' ').pop();
    if (lastClass == "active") {
        if (e.shiftKey) {
            cezalar[index].adet = cezalar[index].adet + 1
            $("#"+cezaIsimId).html(cezalar[index].adet + ' <i class="fas fa-flag"></i>')
        } else if (e.ctrlKey) {
            cezalar[index].adet = cezalar[index].adet - 1
            if (cezalar[index].adet < 2) { 
                cezalar[index].adet = 1 
            }
            $("#"+cezaIsimId).html(cezalar[index].adet + ' <i class="fas fa-flag"></i>')
        } else {
            $(this).removeClass("active");
            cezaData.active = false
            cezaData.adet = 1
            $("#"+cezaIsimId).html(cezalar[index].adet + ' <i class="fas fa-flag"></i>')
        }
    } else {
        cezaData.adet = 1
        $(this).addClass("active");
        cezaData.active = true
        $("#"+cezaIsimId).html(cezalar[index].adet + ' <i class="fas fa-flag"></i>')
    }

    toplamPara = 0
    for (let i = 0; i < cezalar.length; i++) {
        const cezaData = cezalar[i];
        if (cezaData.active) {
            toplamPara = toplamPara + (cezaData.para * cezaData.adet)
        }
    }
    $(".ceza-para").html('<i class="fas fa-money-bill"></i>' + Intl.NumberFormat('en-US').format(Math.round((toplamPara) / 100 * indirim)) + '$')
});

// Make the DIV element draggable:
dragElement(document.getElementById("olaygir-menu"));
dragElement(document.getElementById("sabika-menu"));
function dragElement(elmnt) {
    var pos1 = 0, pos2 = 0, pos3 = 0, pos4 = 0;
    if (document.getElementById(elmnt.id + "-drag-menu")) {
        document.getElementById(elmnt.id + "-drag-menu").onmousedown = dragMouseDown;
    } else {
        //elmnt.onmousedown = dragMouseDown;
    }

    function dragMouseDown(e) {
        e = e || window.event;
        e.preventDefault();
        pos3 = e.clientX;
        pos4 = e.clientY;
        document.onmouseup = closeDragElement;
        document.onmousemove = elementDrag;
    }

    function elementDrag(e) {
        e = e || window.event;
        e.preventDefault();
        pos1 = pos3 - e.clientX;
        pos2 = pos4 - e.clientY;
        pos3 = e.clientX;
        pos4 = e.clientY;
        elmnt.style.top = (elmnt.offsetTop - pos2) + "px";
        elmnt.style.left = (elmnt.offsetLeft - pos1) + "px";
    }

    function closeDragElement() {
        document.onmouseup = null;
        document.onmousemove = null;
    }
}

$('#search-ceza').on('input', function(val) {
    const value = $(this).val();
    if (value != "") {
        const ceza = cezalar.filter(item => item.isim.toLowerCase().indexOf(value) >= 0)
        cezaListesiSet(ceza, false)
    } else if (value == "") {
        cezaListesiSet(cezalar, false)
    }
});

$(document).on("click",".ceza-kayit", function() {
    let cezaKayit = {}
    cezaKayit.aciklama = $(".olay-textarea").val()
    cezaKayit.polis = polisIsim
    cezaKayit.zanli = zanliIsim
    cezaKayit.ceza = {para:Math.round(toplamPara/ 100 * indirim)}
    cezaKayit.cezalarTable = []

    let cezalarIsimleri = ""
    let first = true
    for (let index = 0; index < cezalar.length; index++) {
        const element = cezalar[index];
        if (element.active) {
            let name = element.isim + " (" + element.adet + "x)"
            if (first) {
                first = false
                cezalarIsimleri = name
            } else {
                cezalarIsimleri = cezalarIsimleri + ", " + name
            }
            cezaKayit.cezalarTable.push(name)
        }  
    }
    
    cezaKayit.cezaisim = cezalarIsimleri
    if (cezaKayit.aciklama == "" ) {
        Swal.fire({icon: 'error', text: 'You did not enter the description of the event!'});
    } else if (first) {
        Swal.fire({icon: 'error', text: 'You have not chosen any medicine!'});
    } else {
        $.post('http://tgiann-emstab/cezakaydetclient', JSON.stringify({data: cezaKayit}));
        hideUi("#olaygir-menu");
        bildirim("Prescription Registered in Patient Registration System!", "basari");
    }
});

$(document).on("click","#sorgu-tab-menu", function() {
    showUi("#sorgu-tab", "flex");
    hideUi("#olay-tab");
    hideUi("#cezalart-tab");
});

$(document).on("click","#cezalart-tab-menu", function() {
    showUi("#cezalart-tab", "flex");
    hideUi("#olay-tab");
    hideUi("#sorgu-tab");
});

$(document).on("click","#olay-tab-menu", function() {
    showUi("#olay-tab", "flex");
    hideUi("#sorgu-tab");
    hideUi("#cezalart-tab");

    $.post('http://tgiann-emstab/olaylardata', JSON.stringify({}), function(cbData) {
        olayAraData(cbData)
    });
});

function olayAraData(cbData) {
    let htmlOlaylar = `
        <div class="inputlar-olay-search">
            <input type="text" id="search-olayno" placeholder="Record No..."> 
            <button type="button" id="search-olayno-button">Search</button>
        </div>
    `
    for (let index = 0; index < cbData.length; index++) {
        const element = cbData[index];
        let olayEsyalar = ""
        if (element.esyalar) {
            element.esyalar = JSON.parse(element.esyalar)
        } else {
            element.esyalar = []
        }
        
        let yazar = element.polis

        for (let esyalarIndex = 0; esyalarIndex < element.esyalar.length; esyalarIndex++) {
            const elementesyalar = element.esyalar[esyalarIndex];
            olayEsyalar = olayEsyalar + `<span class="badge badge-dark">${elementesyalar}</span>`
        }

        htmlOlaylar = htmlOlaylar + `
            <div class="olay" id="olayno-${element.id}">
                <div class="olay-top">
                    <div class="olay-top-sol">
                        <div class="olay-no"><i class="fas fa-sticky-note fa-lg"></i>${element.id}</div>
                        <div class="olay-yazar"><i class="fas fa-pen-square fa-lg"></i>${yazar}</div>
                    </div>
                    <div class="olay-top-sag">
                        <div class="olay-saat"><i class="fas fa-clock fa-lg"></i> ${element.zaman}</div>
                        <div class="olay-sil" data-id="${element.id}"><i class="fas fa-times"></i></div>
                    </div>
                </div>
                <div class="olay-aciklama">
                    ${element.aciklama}
                </div>
            
                <div class="olay-bilgi" style="padding-top: 10px;">
                    <span class="badge badge-warning">${element.zanli}</span>
                </div>

                <div class="olay-bilgi">
                    ${olayEsyalar}
                </div>
            </div>
        `
    }
    $(".olaylar").html(htmlOlaylar);
}

$(document).on("click","#sabika-gir", function() {
    $.post('http://tgiann-emstab/sabikadata', JSON.stringify({id: secilenCitizenid}), function(cbData) {
        let sabikaHtml = ""
        if (cbData.length > 0) {
            for (let index = 0; index < cbData.length; index++) {
                const element = cbData[index];
                const cezabilgi = JSON.parse(element.ceza)
                sabikaHtml = sabikaHtml +  `
                    <div id="sabikaid-${index}">
                        <div class="sabika-aciklama">
                        <div class="sabika-aciklama-ceza">${element.cezalar}</div><div class="sabika-aciklama-close" data-cezid="${element.id}" data-id="sabikaid-${index}"><i class="fas fa-times"></i></div>
                        </div>
                        <div class="sabika-bilgi">
                            <div class="sabika-id"><i class="fas fa-sticky-note fa-lg"></i>${element.olayid}</div>
                            <div class="sabika-para"><i class="fas fa-money-bill fa-lg"></i>${Intl.NumberFormat('en-US').format(cezabilgi.para)}$</div>
                        </div>
                    </div>
                `
            }
    
            $(".sabika-row").html(sabikaHtml)
            showUi("#sabika-menu", "flex")
        } else {
            bildirim("The Person Does Not Have Any Patient Records!", "hata");
        }
    });
});

$(document).on("click","#search-olayno-button", function() {
    let value = $("#search-olayno").val()
    if (value.length > 0) {
        $.post('http://tgiann-emstab/olayara', JSON.stringify({id: value}), function(cbData) {
            if (cbData.length > 0) {
                olayAraData(cbData)
            } else {
                bildirim(value+" Numbered Record Not Found!", "hata");
            }
        });
    } else {
        bildirim("You Didn't Enter a Registration Number!", "hata");
    }
});

$(document).on("click","#sabika-close", function() {
    hideUi("#sabika-menu")
});

$(document).on("click",".sabika-aciklama-close", function() {
    $("#"+$(this).attr("data-id")).remove();
    $.post('http://tgiann-emstab/sabikasil', JSON.stringify({id: $(this).attr("data-cezid")}));
    bildirim("Silindi!", "basari");
});

$('#indirim-ceza').on('input', function() {
    indirim = $(this).val();
    if (!indirim) {
        indirim = 100
    } else {
        indirim = 100 - indirim
    }
    $(".ceza-para").html('<i class="fas fa-money-bill"></i>' + Intl.NumberFormat('en-US').format(Math.round(toplamPara / 100 * indirim)) + '$')
});

$(document).on("click",".pd-close", function() {
    $.post('http://tgiann-emstab/kapat', JSON.stringify({}));
});

$(document).on("click",".olay-sil", function() {
    const olayId = $(this).attr("data-id")
    $("#olayno-"+olayId).remove();
    $.post('http://tgiann-emstab/olaysil', JSON.stringify({id:olayId}));
    bildirim("Kayıt Silindi!", "basari");
});

window.addEventListener('message', (event) => {
    if (event.data.type === 'ilk-bilgi') {
        $("#kullanici-ismi").html('<i class="fas fa-user fa-sm"></i>' + event.data.data.name)
        $("#kullanici-rank").html('<i class="fas fa-check-double fa-sm"></i>' + event.data.data.rank)
        polisIsim = event.data.data.name
    } else if (event.data.type === 'user-avatar') {
        $(".resim img").attr("src", event.data.url);
    } else if (event.data.type === 'close') {
        hideUi("#tablet")
    }  else if (event.data.type === 'open') {
        showUi("#tablet", "flex")
    } else if (event.data.type === 'bildirim') {
        bildirim(event.data.msg, event.data.durum)
    } else if (event.data.type === 'zoom') {
        $("#tablet").css("zoom", event.data.val+"%")
        $("#tablet").css("width", event.data.val+"%")
    }
});

// Cezalar Tab
$(document).ready(function() {
    cezaListesiTabSet(cezalar);
});

$('#search-ceza-t').on('input', function(val) {
    const value = $(this).val();
    if (value != "") {
        const ceza = cezalar.filter(item => item.isim.toLowerCase().indexOf(value) >= 0)
        cezaListesiTabSet(ceza)
    } else if (value == "") {
        cezaListesiTabSet(cezalar)
    }
});

function cezaListesiTabSet(arr) {
    $("#cezalart-listesi").html("")
    let htmlCezalar = ""
    for (let index = 0; index < arr.length; index++) {
        const element = arr[index];
        htmlCezalar = htmlCezalar + `
            <div class="cezalart-col">
                <div class="cezalart-adi">${element.isim}</div>
                <div class="cezalart-para">${Intl.NumberFormat('en-US').format(element.para)}$<i class="fas fa-money-bill cezalart-icon"></i></div>
            </div>
        `
    }
    $("#cezalart-listesi").append(htmlCezalar)
}