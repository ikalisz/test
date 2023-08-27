let playerData = []
let playerVehicleData = []
let bildirimAcik = false

let polisler = [];
let zanlilar = [];
let esyalar = [];

let polisIsim = ""
let zanliIsim = ""

let ekliPolisler = []
let ekliZanlilar = []
let ekliEsyalar = []

let secilenCitizenid = ""

let indirim = 100

let illegal = false

let toplamTrafikCeza = 0

let toplamPara = 0
let toplamHapis = 0
let toplamKamu = 0

$("#isim-input").click(function() {
    $("#plaka-input").val("")
    $("#numara-input").val("")
});

$("#numara-input").click(function() {
    $("#isim-input").val("")
    $("#plaka-input").val("")
});

$("#plaka-input").click(function() {
    $("#isim-input").val("")
    $("#numara-input").val("")
});

$("#sorgula").click(function() {
    const isimInput = $("#isim-input").val()
    const numaraInput = $("#numara-input").val()
    const plakaInput = $("#plaka-input").val()
    if (isimInput != "") {
        setPlayerData("isim", isimInput);
    } else if (numaraInput != "") {
        setPlayerData("numara", numaraInput);
    } else if (plakaInput != "") {
        setPlayerData("plaka", plakaInput);
    }
});

function setPlayerData(type, data) {
    let tip = type
    $.post('http://tgiann-mdtv2/sorgula', JSON.stringify({data: data, tip: tip}), function(cbData) {
        playerData = cbData
        if (playerData.length) {
            $("#isim-input").val("")
            $("#sorgu2").html("")
            let htmlSorgu = ""
            for (let index = 0; index < playerData.length; index++) {
                const element = playerData[index];
                let name = element.firstname + " " + element.lastname
                if (tip == "plaka") { 
                    name = name + " (" + element.plate + ")" 
                } else if (tip == "numara") { 
                    name = name + " (" + element.number + ")" 
                }
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
            if (tip == "numara") {
                bildirim("No Data Found for the Number You Called!", "hata")
            } else if (tip == "plaka") {
                bildirim("No Data Found for the Plate You Are Looking For!", "hata")
            } else {
                bildirim("No Data Found for the Name You Searched for!", "hata")
            }
        }
    });
};

var gunler = new Array("Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday");
function tarih(date) {
    var now = new Date(date)
    var yil = now.getFullYear();
    var ay = (now.getMonth() + 1);
    var gun = now.getDate();
    var haftagun = now.getDay();       
    var saat = now.getHours();
    var dakika = now.getMinutes();
    saat = sifirekle(saat);
    dakika = sifirekle(dakika);
    return gun + "." + ay + "." + yil + " " + gunler[haftagun] + " " + saat + ":" + dakika;
}

function sifirekle(sayi) {
    if (sayi < 10) {
        return "0" + sayi.toString();
    } else {
        return sayi.toString();
    }
}

$(document).on("click",".kullanici",function() {
    const userData = playerData[$(this).attr("data-id")]
    let userPhoto = (userData.charinfo).photo
    let userGender = (userData.charinfo).gender
    let aranma = (userData.aranma)
    zanliIsim = (userData.charinfo).firstname + " " + (userData.charinfo).lastname
    secilenCitizenid = userData.citizenid
    if (userPhoto == "resimsiz") { userPhoto = "img/avatar.png" }
    if (userGender == "1") {
        userGender = "Woman"
    } else {
        userGender = "Man"
    }
    let aranmaButton = '<button class="sorgu-button-2-araniyor" id="araniyor">Arananlara Ekle</button>'
    if (aranma.durum) {
        showUi(".aranma-kutu", "flex")
        $(".aranma-kutu").html(`
            <div class="aranma-neden"><i class="fas fa-exclamation-triangle fa-lg"></i>${aranma.sebep}</div>
            <div class="aranma-sag">
                <div class="aranma-baslangic"><i class="fas fa-clock fa-lg"></i>${tarih(aranma.suansaat * 1000)}</div>
                <div class="aranma-saat"><i class="fas fa-unlock-alt fa-lg"></i>${tarih(aranma.saat * 1000)}</div>
            </div>
        `)
        aranmaButton = '<button class="sorgu-button-2-araniyor" id="aranmakaldir">Remove Search!</button>'
    } else {
        hideUi(".aranma-kutu")
    }
    
    hideUi("#arac-bilgi")
    hideUi(".arac-bilgi-kutu")
    $("#kullaniciBilgi").html(`
        <div class="sorgu-sag-alt-sol">
            <div class="bilgi"><div class="bilgi-sol">Gender</div><div class="bilgi-sag">${userGender}</div></div>
            <div class="bilgi"><div class="bilgi-sol">Name</div><div class="bilgi-sag">${(userData.charinfo).firstname}</div></div>
            <div class="bilgi"><div class="bilgi-sol">L. Name</div><div class="bilgi-sag">${(userData.charinfo).lastname}</div></div>
            <div class="bilgi"><div class="bilgi-sol">Citizen No</div><div class="bilgi-sag">${(userData.citizenid)}</div></div>
            <div class="bilgi"><div class="bilgi-sol">Job</div><div class="bilgi-sag">${(userData.job.label + " " + userData.job.gradelabel)}</div></div>
        </div>

        <div class="sorgu-sag-alt-sag">
            <div class="bilgi"><div class="bilgi-sol">Phone Number</div><div class="bilgi-sag">${userData.charinfo.phone}</div></div>
            <div class="bilgi"><div class="bilgi-sol">Bank</div><div class="bilgi-sag">${Intl.NumberFormat('en-US').format(userData.money.bank)}$</div></div>
            <div class="bilgi"><div class="bilgi-sol">Nationality</div><div class="bilgi-sag">${(userData.charinfo).nationality}</div></div>
            <div class="bilgi"><div class="bilgi-sol">DOB</div><div class="bilgi-sag">${(userData.charinfo).birthdate}</div></div>
        </div>

        <div class="userAvatarBox">
            <div class="resim"><img src=${userPhoto}></div>
            <button class="sorgu-button" id="resimyukle">Upload a picture</button>
            <input type="text" id="resimurl" placeholder="Image URL">
        </div>
    `)

    $.post('http://tgiann-mdtv2/ev', JSON.stringify({id: secilenCitizenid}), function(cbData) {
        let raidButton = ""
        if (cbData == "No Home Information") {
            raidButton = `
                <button class="sorgu-button-2-mini" id="motel-r">Motel Raid</button>
            `
            $("#ev").html(cbData)
        } else {
            raidButton = `
                <button class="sorgu-button-2-mini" style="margin-left: 25px;" id="motel-r">Motel Raid</button>
            `
            $("#ev").html(cbData+" Numara")
        }

        $(".sorgu-buttons").html(`
            <button class="sorgu-button-2" id="sabika-gir">View Record</button>
            <button class="sorgu-button-2" id="olay-gir">Enter Event</button>
            ${aranmaButton}
        `)
    });

        $.post('http://tgiann-mdtv2/sorgula', JSON.stringify({data: secilenCitizenid, tip: "arac"}), function(cbData) {
        playerVehicleData = cbData
        $(".arac-bilgi-kutu").html("")
        if (playerVehicleData.length > 0) {
            for (let index = 0; index < playerVehicleData.length; index++) {
                const element = playerVehicleData[index];

                if (!JSON.parse(element.vehicle).carName) {
                    element.vehicle.carName = "Unknown..."
                }
                $(".arac-bilgi-kutu").append(`
                    <div class="arac-bilgi" data-id="${index}">
                        <div class="arac-bilgi-plaka">${JSON.parse(element.vehicle).plate}</div> 
                        <div class="arac-bilgi-isim">${JSON.parse(element.vehicle).carName}</div>
                    </div>
                `)
            }
            showUi("#arac-bilgi")
            showUi(".arac-bilgi-kutu")
        }
    });
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
            renk = "#A52A2A"
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
    $(".ceza-hapis").html('<i class="fas fa-exclamation-triangle"></i>0')
    $(".ceza-kamu").html('<i class="fas fa-broom"></i>0')
    $(".ceza-tceza").html('<i class="fas fa-car-crash"></i>0')
    $(".polisIsimleri").html(`<span href="#" class="badge badge-primary">${polisIsim}</span>`)
    $(".zanliIsimleri").html(`<span href="#" class="badge badge-warning">${zanliIsim}</span>`)
    toplamPara = 0
    toplamHapis = 0
    toplamKamu = 0
    toplamTrafikCeza = 0
    ekliPolisler = []
    ekliZanlilar = []
    ekliPolisler.push(polisIsim);
    ekliZanlilar.push(zanliIsim);
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
        if (ilk) { element.active = false }
        color = !color
        let newClass = "list-group-item d-flex justify-content-between align-items-center"
        if (element.active) {
            newClass = "list-group-item d-flex justify-content-between align-items-center active"
        }

        htmlCezalar = htmlCezalar + `
            <li style="background:${backgroundColor}" class="${newClass}" id="ceza-bilgi" data-isim="${element.isim}">
                <span style="width:70%; text-transform: capitalize;">${element.isim}</span>
                <span class="badge badge-primary badge-pill">${Intl.NumberFormat('en-US').format(element.para)}$ <i class="fas fa-money-bill"></i></span>
                <span class="badge badge-danger badge-pill">${element.hapis} <i class="fas fa-exclamation-triangle"></i></span>
                <span class="badge badge-warning badge-pill">${element.kamu} <i class="fas fa-broom"></i></span>
            </li>
        `
    }
    $(".list-group").append(htmlCezalar)
}

$(document).on("click","#ceza-bilgi",function() {
    const cezaIsim = $(this).attr("data-isim")
    const cezaData = cezalar.find(ceza => ceza.isim == cezaIsim)
    const lastClass = $(this).attr('class').split(' ').pop();
    if (lastClass == "active") {
        $(this).removeClass("active");
        cezaData.active = false
        toplamPara = toplamPara - cezaData.para
        toplamHapis = toplamHapis - cezaData.hapis
        toplamKamu = toplamKamu - cezaData.kamu
        toplamTrafikCeza = toplamTrafikCeza - cezaData.tceza
    } else {
        $(this).addClass("active");
        cezaData.active = true
        toplamPara = toplamPara + cezaData.para
        toplamHapis = toplamHapis + cezaData.hapis
        toplamKamu = toplamKamu + cezaData.kamu
        toplamTrafikCeza = toplamTrafikCeza + cezaData.tceza
    }
    $(".ceza-para").html('<i class="fas fa-money-bill"></i>' + Intl.NumberFormat('en-US').format(Math.round(toplamPara / 100 * indirim)) + '$')
    $(".ceza-hapis").html('<i class="fas fa-exclamation-triangle"></i>' + Math.round(toplamHapis / 100 * indirim))
    $(".ceza-kamu").html('<i class="fas fa-broom"></i>' + Math.round(toplamKamu / 100 * indirim))
    $(".ceza-tceza").html('<i class="fas fa-car-crash"></i>' + toplamTrafikCeza)
});

// Make the DIV element draggable:
dragElement(document.getElementById("olaygir-menu"));
dragElement(document.getElementById("sabika-menu"));
dragElement(document.getElementById("aranma-menu"));
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

//$('#search-ceza').change(function(){
$('#search-ceza').on('input', function(val) {
    const value = $(this).val();
    if (value != "") {
        const ceza = cezalar.filter(item => item.isim.toLowerCase().indexOf(value) >= 0)
        cezaListesiSet(ceza, false)
    } else if (value == "") {
        cezaListesiSet(cezalar, false)
    }
});

function autocomplete(inp, arr) {
    var currentFocus;
    inp.addEventListener("input", function(e) {
        var a, b, i, val = this.value;
        closeAllLists();
        if (!val) { return false;}
        currentFocus = -1;
        a = document.createElement("DIV");
        let menuName = this.id
        a.setAttribute("id", menuName + "autocomplete-list");
        a.setAttribute("class", "autocomplete-items");
        this.parentNode.appendChild(a);
        for (i = 0; i < arr.length; i++) {
          if (arr[i].substr(0, val.length).toUpperCase() == val.toUpperCase()) {
            b = document.createElement("DIV");
            b.innerHTML = "<strong>" + arr[i].substr(0, val.length) + "</strong>";
            b.innerHTML += arr[i].substr(val.length);
            b.innerHTML += "<input type='hidden' value='" + arr[i] + "'>";
                b.addEventListener("click", function(e) {
                inp.value = this.getElementsByTagName("input")[0].value;
                if (menuName == "esyaSecInput") {
                    $(".eleGecirilen").append(`<a class="badge badge-info" id="ekliIsimEsya" data-id="${inp.value}">${inp.value} <i class="fas fa-times-circle fa-xs"></i></a>`)
                    ekliEsyalar.push(inp.value);
                } else if (menuName == "polisSecInput") {
                    $(".polisIsimleri").append(`<a class="badge badge-primary" id="ekliIsimPolis" data-id="${inp.value}">${inp.value} <i class="fas fa-times-circle fa-xs"></i></a>`)
                    ekliPolisler.push(inp.value);
                } else {
                    $(".zanliIsimleri").append(`<a class="badge badge-warning" id="ekliIsimZanli" data-id="${inp.value}">${inp.value} <i class="fas fa-times-circle fa-xs"></i></a>`)
                    ekliZanlilar.push(inp.value);
                }
                $("#"+menuName).val("")
                closeAllLists();
            });
            a.appendChild(b);
          }
        }
    });
    inp.addEventListener("keydown", function(e) {
        var x = document.getElementById(this.id + "autocomplete-list");
        if (x) x = x.getElementsByTagName("div");
        if (e.keyCode == 40) {
          currentFocus++;
          addActive(x);
        } else if (e.keyCode == 38) { //up
          currentFocus--;
          addActive(x);
        } else if (e.keyCode == 13) {
          e.preventDefault();
          if (currentFocus > -1) {
            if (x) x[currentFocus].click();

          }
        }
    });
    function addActive(x) {
      if (!x) return false;
      removeActive(x);
      if (currentFocus >= x.length) currentFocus = 0;
      if (currentFocus < 0) currentFocus = (x.length - 1);
      x[currentFocus].classList.add("autocomplete-active");

    }
    function removeActive(x) {
      for (var i = 0; i < x.length; i++) {
        x[i].classList.remove("autocomplete-active");
      }
    }
    function closeAllLists(elmnt) {
        var x = document.getElementsByClassName("autocomplete-items");
        for (var i = 0; i < x.length; i++) {
            if (elmnt != x[i] && elmnt != inp) {
                x[i].parentNode.removeChild(x[i]);
            }
        }
    }
    document.addEventListener("click", function (e) {
        closeAllLists(e.target);
    });
}

$(document).on("click", "#ekliIsimPolis" ,function() {
    for (let index = 0; index < ekliPolisler.length; index++) {
        if (ekliPolisler[index] == $(this).attr("data-id")) {
            ekliPolisler.splice(index, 1); 
            break
        }
    }
    $($(this)).remove("#ekliIsimPolis");
});

$(document).on("click", "#ekliIsimZanli" ,function() {
    for (let index = 0; index < ekliZanlilar.length; index++) {
        if (ekliZanlilar[index] == $(this).attr("data-id")) {
            ekliZanlilar.splice(index, 1); 
            break
        }
    }
    $($(this)).remove("#ekliIsimZanli");
});

$(document).on("click", "#ekliIsimEsya" ,function() {
    for (let index = 0; index < ekliEsyalar.length; index++) {
        if (ekliEsyalar[index] == $(this).attr("data-id")) {
            ekliEsyalar.splice(index, 1); 
            break
        }
    }
    $($(this)).remove("#ekliIsimEsya");
});

$(document).on("click",".ceza-kayit", function() {
    let cezaKayit = {}
    illegal = false
    cezaKayit.aciklama = $(".olay-textarea").val()
    cezaKayit.polis = ekliPolisler
    cezaKayit.zanli = ekliZanlilar
    cezaKayit.esyalar = ekliEsyalar
    cezaKayit.ceza = {para:Math.round(toplamPara/ 100 * indirim), hapis: Math.round(toplamHapis/ 100 * indirim), kamu: Math.round(toplamKamu/ 100 * indirim), tceza: toplamTrafikCeza}
    let cezalarIsimleri = ""
    let first = true
    for (let index = 0; index < cezalar.length; index++) {
        const element = cezalar[index];
        if (element.active) {
            if (first) {
                first = false
                cezalarIsimleri = element.isim
            } else {
                cezalarIsimleri = cezalarIsimleri + ", " + element.isim
            }
            if (element.illegal) { illegal = true }
        }  
    }
    
    cezaKayit.cezaisim = cezalarIsimleri
    cezaKayit.illegal = illegal
    if (cezaKayit.aciklama == "" ) {
        Swal.fire({icon: 'error', text: 'You did not enter the description of the event!'});
    } else if (first) {
        Swal.fire({icon: 'error', text: 'You have not chosen any punishment!'});
    } else {
        $.post('http://tgiann-mdtv2/cezakaydetclient', JSON.stringify({data: cezaKayit}));
        hideUi("#olaygir-menu");
        bildirim("Event Recorded!", "basari");
    }
});

$(document).on("click","#sorgu-tab-menu", function() {
    showUi("#sorgu-tab", "flex");
    hideUi("#olay-tab");
    hideUi("#arananlar-tab");
    hideUi("#cezalart-tab");
});

$(document).on("click","#cezalart-tab-menu", function() {
    showUi("#cezalart-tab", "flex");
    hideUi("#olay-tab");
    hideUi("#arananlar-tab");
    hideUi("#sorgu-tab");
});

$(document).on("click","#carbodycam", function() {
    $.post('http://tgiann-mdtv2/carbodycam', JSON.stringify({}));
});

$(document).on("click","#bodycam", function() {
    $.post('http://tgiann-mdtv2/bodycam', JSON.stringify({}));
});

$(document).on("click","#pkam", function() {
    $.post('http://tgiann-mdtv2/pkam', JSON.stringify({}));
});

$(document).on("click","#arananlar-tab-menu", function() {
    showUi("#arananlar-tab", "flex");
    hideUi("#olay-tab");
    hideUi("#sorgu-tab");
    hideUi("#cezalart-tab");

    $.post('http://tgiann-mdtv2/arananlar', JSON.stringify({}), function(cbData) {
        let htmlArananlar = ""
        for (let index = 0; index < cbData.length; index++) {
            const element = cbData[index];
            htmlArananlar = htmlArananlar + `
                <div class="aranan-kutu" id="aranma-${element.citizenid}">
                    <div class="aranan-kutu-sol">
                    <div class="aranan-kutu-isim"><i class="fas fa-user"></i>${element.isim}</div>
                    <div class="aranan-kutu-neden"><i class="fas fa-search"></i>${element.sebep}</div>
                    </div>
                    <div class="aranan-kutu-sag">
                        <div class="aranan-kutu-baslangic"><i class="fas fa-clock"></i>${tarih(element.baslangic * 1000)}</div>
                        <div class="aranan-kutu-bitis"><i class="fas fa-unlock-alt"></i>${tarih(element.bitis* 1000)}</div>
                        <div class="aranan-kutu-kapat" data-id="${element.citizenid}"><i class="fas fa-times"></i></div>
                    </div>
                </div>
            `
        }
        $("#aranankisiler").html(htmlArananlar)
    });
});

$(document).on("click",".aranan-kutu-kapat", function() {
    const citizenid = $(this).attr("data-id")
    $.post('http://tgiann-mdtv2/aranmakaldir', JSON.stringify({id: citizenid}));
    bildirim("Wanted Removed!", "basari");
    $("#aranma-"+citizenid).remove();
    if (citizenid == secilenCitizenid) {
        hideUi(".aranma-kutu")
        $(".sorgu-buttons").html(`
            <button class="sorgu-button-2" id="sabika-gir">View Record</button>
            <button class="sorgu-button-2" id="olay-gir">Enter Event</button>
            <button class="sorgu-button-2-araniyor" id="araniyor">Add to Wanted!</button>
        `)
    }
});  

$(document).on("click","#olay-tab-menu", function() {
    showUi("#olay-tab", "flex");
    hideUi("#sorgu-tab");
    hideUi("#arananlar-tab");
    hideUi("#cezalart-tab");

    $.post('http://tgiann-mdtv2/olaylardata', JSON.stringify({}), function(cbData) {
        olayAraData(cbData)
    });
});

function olayAraData(cbData) {
    let htmlOlaylar = `
        <div class="inputlar-olay-search">
            <input type="text" id="search-olayno" placeholder="Event No..."> 
            <button type="button" id="search-olayno-button">Search</button>
        </div>
    `
    for (let index = 0; index < (cbData).length; index++) {
        const element = cbData[index];
        let polisler = ""
        let zanlilar = ""
        let olayEsyalar = ""
        if (element.esyalar) {
            element.esyalar = element.esyalar
        } else {
            element.esyalar = []
        }
        
        let yazar = null
        
        for (let polisIndex = 0; polisIndex < (element.polis).length; polisIndex++) {
            const elementPolis = element.polis[polisIndex];
            polisler = polisler + `<span class="badge badge-primary">${elementPolis}</span>`
            if (!yazar) {
                yazar = elementPolis
            }
        }
        for (let zanliIndex = 0; zanliIndex < (element.zanli).length; zanliIndex++) {
            const elementzanli = element.zanli[zanliIndex];
            zanlilar = zanlilar + `<span class="badge badge-warning">${elementzanli}</span>`
        }

        for (let esyalarIndex = 0; esyalarIndex < (element.esyalar).length; esyalarIndex++) {
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
            
                <div class="olay-bilgi">
                    <div class="olay-bilgi-sol">
                        ${polisler}
                    </div>
                    <div class="olay-bilgi-sag">
                        ${zanlilar}
                    </div>
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
    $.post('http://tgiann-mdtv2/sabikadata', JSON.stringify({id: secilenCitizenid}), function(cbData) {
        let sabikaHtml = ""
        if (cbData && cbData.length > 0) {
            for (let index = 0; index < cbData.length; index++) {
                const element = cbData[index];
                const cezabilgi = element.ceza
                sabikaHtml = sabikaHtml +  `
                    <div id="sabikaid-${index}">
                        <div class="sabika-aciklama">
                        <div class="sabika-aciklama-ceza">${element.cezalar}</div><div class="sabika-aciklama-close" data-cezid="${element.id}" data-id="sabikaid-${index}"><i class="fas fa-times"></i></div>
                        </div>
                        <div class="sabika-bilgi">
                            <div class="sabika-id"><i class="fas fa-sticky-note fa-lg"></i>${element.olayid}</div>
                            <div class="sabika-para"><i class="fas fa-money-bill fa-lg"></i>${Intl.NumberFormat('en-US').format(cezabilgi.para)}$</div>
                            <div class="sabika-hapis"><i class="fas fa-exclamation-triangle fa-lg"></i>${cezabilgi.hapis}</div>
                            <div class="sabika-kamu"><i class="fas fa-broom fa-lg"></i>${cezabilgi.kamu}</div>
                        </div>
                    </div>
                `
            }
    
            $(".sabika-row").html(sabikaHtml)
            showUi("#sabika-menu", "flex")
        } else {
            bildirim("Person's Criminal Record is Clean!", "hata");
        }
    });
});

$(document).on("click","#search-olayno-button", function() {
    let value = $("#search-olayno").val()
    if (value.length > 0) {
        $.post('http://tgiann-mdtv2/olayara', JSON.stringify({id: value}), function(cbData) {
            if (cbData.length > 0) {
                olayAraData(cbData)
            } else {
                bildirim(value+" Event Numbered Not Found!", "hata");
            }
        });
    } else {
        bildirim("You Didn't Enter an Event Number!", "hata");
    }
});

$(document).on("click","#sabika-close", function() {
    hideUi("#sabika-menu")
});

$(document).on("click","#aranma-close", function() {
    hideUi("#aranma-menu")
});

$(document).on("click",".sabika-aciklama-close", function() {
    $("#"+$(this).attr("data-id")).remove();
    $.post('http://tgiann-mdtv2/sabikasil', JSON.stringify({id: $(this).attr("data-cezid")}));
    bildirim("Criminal Cleared!", "basari");
});

$(document).on("click","#resimyukle", function() {
    if ($("#resimurl").val().length > 0) {
        bildirim("Image Uploaded!", "basari");
        $(".resim img").attr("src", $("#resimurl").val());
        $.post('http://tgiann-mdtv2/resim', JSON.stringify({id: secilenCitizenid, url:$("#resimurl").val()}));
        $("#resimurl").val("")
    } else {
        $.post('http://tgiann-mdtv2/resim', JSON.stringify({id: secilenCitizenid, url: false}));
    }
});

$(document).on("click","#araniyor", function() {
    showUi("#aranma-menu")
});

$(document).on("click",".aranmabutton", function() {
    let neden = $("#aranmaneden").val()
    let saat = $("#aranmasaat").val()
    let tip = $("#aranmatip").val()
    if (neden == "" ) {
        Swal.fire({icon: 'error', text: 'You did not write the reason for the call.!'});
    } else if (saat == "") {
        Swal.fire({icon: 'error', text: 'You did not write the call time!'});
    } else {
        if (tip == "saat") { saat = saat / 24 }

        $.post('http://tgiann-mdtv2/aranma', JSON.stringify({id: secilenCitizenid, saat: saat, neden: neden, isim:zanliIsim}));
        hideUi("#aranma-menu")
        bildirim("Call Record Created!", "basari");

        showUi(".aranma-kutu", "flex")

        $(".aranma-kutu").html(`
            <div class="aranma-neden"><i class="fas fa-exclamation-triangle fa-lg"></i>${neden}</div>
            <div class="aranma-sag">
                <div class="aranma-baslangic"><i class="fas fa-clock fa-lg"></i>${tarih(new Date())}</div>
                <div class="aranma-saat"><i class="fas fa-unlock-alt fa-lg"></i>${tarih(Math.round((new Date()).getTime()) + saat * 86400000)}</div>
            </div>
        `)

        $(".sorgu-buttons").html(`
            <button class="sorgu-button-2" id="sabika-gir">View Record</button>
            <button class="sorgu-button-2" id="olay-gir">Enter Event</button>
            <button class="sorgu-button-2-araniyor" id="aranmakaldir">Remove Search!</button>
        `)
    }
});

$(document).on("click","#aranmakaldir", function() {
    $.post('http://tgiann-mdtv2/aranmakaldir', JSON.stringify({id: secilenCitizenid}));
    bildirim("Wanted Removed!", "basari");
    hideUi(".aranma-kutu")
    $(".sorgu-buttons").html(`
        <button class="sorgu-button-2" id="sabika-gir">View Record</button>
        <button class="sorgu-button-2" id="olay-gir">Enter Event</button>
        <button class="sorgu-button-2-araniyor" id="araniyor">Add to Wanted!</button>
    `)
});

$('#indirim-ceza').on('input', function() {
    indirim = $(this).val();
    if (!indirim) {
        indirim = 100
    } else {
        indirim = 100 - indirim
    }
    $(".ceza-para").html('<i class="fas fa-money-bill"></i>' + Intl.NumberFormat('en-US').format(Math.round(toplamPara / 100 * indirim)) + '$')
    $(".ceza-hapis").html('<i class="fas fa-exclamation-triangle"></i>' + Math.round(toplamHapis / 100 * indirim))
    $(".ceza-kamu").html('<i class="fas fa-broom"></i>' + Math.round(toplamKamu / 100 * indirim))
});

$(document).on("click",".pd-close", function() {
    $.post('http://tgiann-mdtv2/kapat', JSON.stringify({}));
});

$(document).on("click",".olay-sil", function() {
    const olayId = $(this).attr("data-id")
    $("#olayno-"+olayId).html("");
    $.post('http://tgiann-mdtv2/olaysil', JSON.stringify({id:olayId}));
    bildirim("Incidents and Records Deleted!", "basari");
});

window.addEventListener('message', (event) => {
    if (event.data.type === 'ilk-bilgi') {
        $("#kullanici-ismi").html('<i class="fas fa-user fa-sm"></i>' + event.data.data.name)
        $("#kullanici-rank").html('<i class="fas fa-check-double fa-sm"></i>' + event.data.data.rank)
        polisIsim = event.data.data.name
        polisler = event.data.data.players.police;
        zanlilar = event.data.data.players.user;
        esyalar = event.data.data.items;
        autocomplete(document.getElementById("polisSecInput"), polisler);
        autocomplete(document.getElementById("zanliSecInput"), zanlilar);
        autocomplete(document.getElementById("esyaSecInput"), esyalar);
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
$( document ).ready(function() {
    cezaListesiTabSet(cezalar)
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
                <div class="cezalart-hapis">${element.hapis} <i class="fas fa-exclamation-triangle cezalart-icon"></i></div>
                <div class="cezalart-kamu">${element.kamu} <i class="fas fa-broom cezalart-icon"></i></div>
            </div>
        `
    }
    $("#cezalart-listesi").append(htmlCezalar)
}

// Raid
$(document).on("click","#cadir-r",function() {
    $.post('http://tgiann-mdtv2/cadir-r', JSON.stringify({id: secilenCitizenid}));
})

$(document).on("click","#motel-r",function() {
    $.post('http://tgiann-mdtv2/motel-r', JSON.stringify({id: secilenCitizenid}));
})

$(document).on("click","#ev-r",function() {
    $.post('http://tgiann-mdtv2/ev-r', JSON.stringify({ev: $(this).attr("data-ev")}));
})