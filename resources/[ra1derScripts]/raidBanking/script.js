var UserIban = "";

$(document).ready(function(){
    var tarih = new Date();
    var kacinciGun = tarih.getDate();
    var hours = tarih.getHours()
    var minutes = tarih.getMinutes();
    if (hours <= 9) hours = "0" + hours;
    if (minutes <= 9) minutes = "0" + minutes;
    var time = hours + ":" + minutes;
    $("#hour-minute").text(time);//

    // $("#player-name").text(UserFirstName + " " + UserLastName);//
    // $("#player-name-card").text(UserFirstName + " " + UserLastName);//
    // $("#player-name-on-top").text(UserFirstName + " " + UserLastName.charAt(0)+".");//
    // $("#player-job").text(UserJob);//
    // $("#player-cash").text(UserCash + ",00$");//
    // $("#player-iban").text(UserIban); //
    // $("#activity-card").text($("#activity-card").text() + " " + UserFirstName + " " + UserLastName);//
    $(".item").each(function() {
        if ($(this).text() == kacinciGun) $(this).addClass("is-active");
    });
});

$(".offer-button").click(function() {
    var IBAN = $("#iban-input").val();
    var Miktar = $("#miktar-input").val();
    if (IBAN != "" || Miktar != "") {
        $.post('http://raidBanking/TransferMoney', JSON.stringify({
            amount: Miktar,
            iban: IBAN,
        }), function(data){
            $("#iban-input").val("");
            $("#miktar-input").val("");
        })

    };
});

$("#deposit-button").click(function() {
    var Miktar = $("#parayatir-input").val();
    if (Miktar != "") {
        $.post('http://raidBanking/TakeMoney', JSON.stringify({
            amount: Miktar,
            type: "deposit",
        }), function(data){
            if (data) {
                $("#parayatir-input").val("");
            }
        })
    }
});

$("#withdraw-button").click(function() {
    var Miktar = $("#paracek-input").val();
    if (Miktar != "") {
        $.post('http://raidBanking/TakeMoney', JSON.stringify({
            amount: Miktar,
            type: "withdraw",
        }), function(data){
            if (data) {
                $("#paracek-input").val("");
            }
        })
    }
});

$(document).on("keydown", function() {
    switch(event.keyCode) {
        case 27:
            $("body").css("display", "none");
            $.post('http://raidBanking/close', JSON.stringify({}))
        break;
    }
});

$("#close").click(function(){
    $("body").css("display", "none");
    $.post('http://raidBanking/close', JSON.stringify({}))
});

$(document).ready(function () {
    window.addEventListener("message", function (event) {
        if (event.data.action == 'open') {
            UserIban = event.data.data.iban;
            $("body").css("display", "block");
            $("#player-name").text(event.data.data.firstname + " " + event.data.data.lastname);
            $("#player-name-card").text(event.data.data.firstname + " " + event.data.data.lastname);
            $("#player-name-on-top").text(event.data.data.firstname + " " + event.data.data.lastname.charAt(0)+".");
            $("#player-job").text(event.data.data.job);
            $("#player-cash").text(Math.round(event.data.data.moneybank) + ",00$");
            $("#player-cash-money").text("Money on You: " + event.data.data.moneycash + "$");
            $("#player-iban").text("IBAN: " + event.data.data.iban);
            $("#activity-card").text("Welcome, " + event.data.data.firstname + " " + event.data.data.lastname)

            if (event.data.data.image != "resimsiz") {
                document.getElementById("account-profile-img").src = event.data.data.image
            }
            
        };
        if (event.data.action == 'notify'){
            Swal.fire("", event.data.message, event.data.type);
        }
        if (event.data.action == 'close') {
            $("body").css("display", "none");
            $.post('http://raidBanking/close', JSON.stringify({}),)
        };
        if (event.data.action == 'updatePlayerData') {
            $("#player-cash").text(event.data.data.moneybank + ",00$");
            $("#player-cash-money").text("Üzerinizdeki Para: " + event.data.data.moneycash + "$");
        }
        if (event.data.action == 'updateActivity') {
            $("#table-clients > tbody").empty();
            $(".transection").empty();
            $.each(event.data.results, function(i, section) {
                if (section.geleniban == UserIban) {
                    var element = '<div class="credit-wrapper"><div class="credit-name"><div class="credit-type">+ '+section.gonderen+'</div><div class="credit-status">with his person</div></div><div class="credit-money is-active">+$'+section.amount+'</div></div>'
                } else {
                    var element = '<div class="credit-wrapper"><div class="credit-name"><div class="credit-type">- '+section.alici+'</div><div class="credit-status">with his person</div></div><div class="credit-money is-cancel">-$'+section.amount+'</div></div>'
                }
                $(".transection").append(element);
            });
            $.each(event.data.results, function(i, section) {
                if (section.geleniban == UserIban) {
                    var elem = '<tr><td>'+section.gonderen+'</td><td>'+section.gondereniban+'</td><td>+'+section.amount+'$</td>' +
                    `<td>
                    <div class="status is-green"><svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                    <path d="M20 6L9 17l-5-5" />
                    </svg>
                    Approved
                    </div>
                    </td>
                    </tr>`;
                } else {
                    var elem = '<tr><td>'+section.alici+'</td><td>'+section.geleniban+'</td><td>-'+section.amount+'$</td>' +
                    `<td>
                        <div class="status is-green"><svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                        <path d="M20 6L9 17l-5-5" />
                        </svg>
                        Approved
                        </div>
                    </td>
                    </tr>`;
                }
                $("#table-clients > tbody").append(elem);
            });
        }
    });
});