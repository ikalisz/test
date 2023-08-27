QBCore = nil
Citizen.CreateThread(function()
    while QBCore == nil do
        TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)
        Citizen.Wait(200)
    end
end)

PlayerData = {}
isDead = false
job = "unemployed"
onDuty = true
prop, yatak, animYatak = false, false, false

rootMenuConfig =  {
    {
        id = "genel",
        displayName = "General",
        icon = "#globe-europe",
        enableMenu = function()
            return not isDead
        end,
        subMenus = {"genel:anahtarver", "genel:bgir", "genel:yarali", "genel:normal", "genel:anim"}
    },
    -- {
    --     id = "ehliyet",
    --     displayName = "Ehliyet",
    --     icon = "#fa-id-card",
    --     enableMenu = function()
    --         return not isDead
    --     end,
    --     subMenus = {"ehliyet:kimlik", "ehliyet:kimlikver", "ehliyet:silahruhsat", "ehliyet:silahruhsativer"}
    -- },
    -- {
    --     id = "kimlikislemleri",
    --     displayName = "Kimlik İşlemleri",
    --     icon = "#cuzdan",
    --     functionName = "kimlikislemleri",
    --     enableMenu = function()
    --         return not isDead
    --     end,
    -- },
    -- {
    --     id = "kiyafetislemleri",
    --     displayName = "Kıyafet Eylemleri",
    --     icon = "#fa-tshirt",
    --     functionName = "kiyafetislemleri",
    --     enableMenu = function()
    --         return true
    --     end,
    -- },
    {
        id = "kiyafet",
        displayName = "Dress Actions",
        icon = "#fa-tshirt",
        enableMenu = function()
            return true
        end,
        subMenus = {"kiyafet:sapka","kiyafet:gozluk","kiyafet:maske","kiyafet:tisort","kiyafet:pantalon","kiyafet:canta","kiyafet:eldiven","kiyafet:ayakkabi", "kiyafet:zirh"}
    },
    {
        id = "mekan",
        displayName = "Places",
        icon = "#fa-map-marked-alt",
        enableMenu = function()
            return not isDead
        end,
        subMenus = {"mekan:garaj", "mekan:kiyafet","mekan:dovme","mekan:gazist","mekan:bank","mekan:kuafor", "mekan:market"}
    },
    {
        id = "aracislemleri",
        displayName = "Vehicle Transactions",
        icon = "#araba",
        functionName = "aracislemleri",
        enableMenu = function()
            return IsPedInAnyVehicle(PlayerPedId()) and not isDead
        end
    },
    {
        id = "araccevir",
        displayName = "Flip Tool",
        icon = "#fa-car-crash",
        functionName = "tersduz",
        enableMenu = function()
            return not IsPedInAnyVehicle(PlayerPedId()) and ClosestVehicle(3) and not isDead
        end
    },

    {
        id = "oyuncu",
        displayName = "Player Actions",
        icon = "#fa-user-circle",
        enableMenu = function()
            return (not isDead and not IsPedInAnyVehicle(PlayerPedId()) and ClosestPlayer(3) )
        end,
        subMenus = {"oyuncu:kucakla","oyuncu:rehinal","oyuncu:ktasi", "tasi", "sirtla", "oyuncu:kbindir","oyuncu:ybindir"}
    },
    {
        id = "ems",
        displayName = "EMS Transactions",
        icon = "#fa-star-of-life",
        enableMenu = function()
            return (not isDead and not IsPedInAnyVehicle(PlayerPedId()) and job == "ambulance" and onDuty)
        end,
        subMenus = {"ems:fatura", "ems:iyilestir","ems:tedavi","ems:igne","ems:tsandalye"}
    },
    {
        id = "inaktifems",
        displayName = "EMS Transactions",
        icon = "#fa-star-of-life",
        enableMenu = function()
            return (not isDead and not IsPedInAnyVehicle(PlayerPedId()) and job == "ambulance" and not onDuty)
        end,
        subMenus = {"ems:iyilestir","ems:igne"}
    },
    {
        id = "mekanik",
        displayName = "Mechanical Operations",
        icon = "#fa-wrench",
        enableMenu = function()
            return (not isDead and not IsPedInAnyVehicle(PlayerPedId()) and (job == "mechanic_bennys" or job == "mechanic_tunner" or job == "mechanic_hayes" or job == "mechanic_otto"))
        end,
        subMenus = {"mekanik:tamir","mekanik:tamir2","mekanik:temizle","mekanik:yukleyici","mekanik:fatura","polisarac:aracicek",}
    },
    {
        id = "polis",
        displayName = "Police Actions",
        icon = "#fa-user",
        enableMenu = function()
            return (not isDead and not IsPedInAnyVehicle(PlayerPedId()) and job == "police" )
        end,
        subMenus = {"polis:hapiscikar", "polis:cezakes", "polis:kamu", "polis:hapisat", "polis:cezalarinabak", "polis:iyilestirPolis", "polis:lisanskontrol", "polis:obje"}
    },
    {
        id = "polisarac",
        displayName = "Police Vehicle Transactions",
        icon = "#fa-taxi",
        enableMenu = function()
            return (not isDead and ClosestVehicle(3) and job == "police" )
        end,
        subMenus = {"polisarac:imodifiye", "polisarac:tunner", "polisarac:aracicek", "camfilmarastir",  "camfilm", "polisarac:plakabak", "polisarac:kilitac", "polisarac:neonsok"}
    },
    -- {
    --     id = "polisaracici",
    --     displayName = "Polis İşlemleri",
    --     icon = "#fa-user",
    --     enableMenu = function()
    --         return (not isDead and IsPedInAnyVehicle(PlayerPedId()) and onDuty and job == "police")
    --     end,
    --     subMenus = {"gpssac","gpskapa"}
    -- },
    -- {
    --     id = "emsaracici",
    --     displayName = "EMS İşlemleri",
    --     icon = "#fa-star-of-life",
    --     enableMenu = function()
    --         return (not isDead and IsPedInAnyVehicle(PlayerPedId()) and onDuty and job == "ambulance")
    --     end,
    --     subMenus = {"gpssac","gpskapa"}
    -- },
    {
        id = "olu",
        displayName = "Send EMS Notification",
        icon = "#fa-satellite-dish",
        functionName = "emsbildirim",
        enableMenu = function()
            return isDead
        end
    },
    {
        id = "olu2",
        displayName = "Notify the Police",
        icon = "#fa-satellite-dish",
        functionName = "polisbildirim",
        enableMenu = function()
            return isDead
        end
    },
    {
        id = "yatak1",
        displayName = "Lay on your back",
        icon = "#fa-bed",
        functionName = "yatak1",
        enableMenu = function()
            return prop and yatak and not isDead
        end
    },
    {
        id = "yatak2",
        displayName = "Lie face down",
        icon = "#fa-bed",
        functionName = "yatak2",
        enableMenu = function()
            return prop and yatak and not isDead
        end
    },
    {
        id = "yatak3",
        displayName = "Sit on the bed",
        icon = "#fa-bed",
        functionName = "yatak3",
        enableMenu = function()
            return prop and yatak and not isDead
        end
    },
    {
        id = "koltuk",
        displayName = "Sit on the chair",
        icon = "#fa-chair",
        functionName = "koltuk",
        enableMenu = function()
            return prop and not yatak and not isDead
        end
    },
    {
        id = "garaj",
        displayName = "Garage",
        icon = "#fa-warehouse",
        functionName = "garajOpen",
        enableMenu = function()
            return not IsPedInAnyVehicle(PlayerPedId()) and exports["tgiann-garajv2"]:checkgarage() and not isDead
        end
    },
    -- {
    --     id = "direk-dansi",
    --     displayName = "Direk Dansı",
    --     icon = "#fa-disease",
    --     functionName = "poleDance",
    --     enableMenu = function()
    --         return exports["esx_nightclub"]:nightClubPole() and not isDead
    --     end
    -- },
    {
        id = "garaj-park",
        displayName = "Park",
        icon = "#fa-parking",
        functionName = "garajOpen",
        enableMenu = function()
            return IsPedInAnyVehicle(PlayerPedId()) and exports["tgiann-garajv2"]:checkgarage() and not isDead
        end
    },
    {
        id = "giysi-dukkan",
        displayName = "Clothes shop",
        icon = "#fa-socks",
        functionName = "clotheOpen",
        enableMenu = function()
            local data = exports["fivem-appearance"]:checkclothe()
            local clot, ber = data[1], data[2]
            return not IsPedInAnyVehicle(PlayerPedId()) and clot and not isDead
        end
    },
    {
        id = "berber-dukkan",
        displayName = "Barber Shop",
        icon = "#fa-cut",
        functionName = "barberOpen",
        enableMenu = function()
            local data = exports["fivem-appearance"]:checkclothe()
            local clot, ber = data[1], data[2]
            return not IsPedInAnyVehicle(PlayerPedId()) and ber and not isDead
        end
    },
    {
        id = "dovme-dukkan",
        displayName = "Tattoo Artist",
        icon = "#fa-cut",
        functionName = "dovmeOpen",
        enableMenu = function()
            local data = exports["fivem-appearance"]:checkclothe()
            local clot, ber, dov = data[1], data[2], data[3]
            return not IsPedInAnyVehicle(PlayerPedId()) and dov and not isDead
        end
    },
}

newSubMenus = {
    -- Polis Araç İşlemleri
    ['polisarac:imodifiye'] = {
        title = "Illegal Modified Control",
        icon = "#fa-car-side",
        functionName = "imodifiye"
    },
    ['polisarac:tunner'] = {
        title = "Remove Tuner Chip",
        icon = "#fa-microchip",
        functionName = "tunnerchipremove"
    },
    ['polisarac:aracicek'] = {
        title = "Tow Vehicle",
        icon = "#fa-car-crash",
        functionName = "aracicek"
    },
    ['camfilmarastir'] = {
        title = "Browse Window Film",
        icon = "#fas fa-sync-alt",
        functionName = "camfilmarastir"
    },
    ['camfilm'] = {
        title = "Remove Window Film",
        icon = "#fas fa-hammer",
        functionName = "camfilm"
    },
    ['polisarac:plakabak'] = {
        title = "Inquire Plate",
        icon = "#fa-vr-cardboard",
        functionName = "plakabak"
    },
    ['polisarac:kilitac'] = {
        title = "Break the Lock",
        icon = "#fa-plane",
        functionName = "kilitac"
    },
    ['polisarac:neonsok'] = {
        title = "Remove Neon",
        icon = "#fa-lightbulb",
        functionName = "neonsok"
    },
    -- Polis İşlemleri
    ['polis:rozet'] = {
        title = "Show Your Badge",
        icon = "#fa-certificate",
        functionName = "polisrozet"
    },
    ['polis:kimlik'] = {
        title = "Show Police ID",
        icon = "#fa-id-badge",
        functionName = "poliskimlik"
    },
    ['polis:pilot'] = {
        title = "Grant Flight License",
        icon = "#fa-plane",
        functionName = "pilot"
    },
    ['polis:silah'] = {
        title = "Weapon Carry L.Ver",
        icon = "#fa-fire-extinguisher",
        functionName = "silahduk"
    },
    ['polis:hapiscikar'] = {
        title = "Get Out of Prison",
        icon = "#fa-user-times",
        functionName = "hapiscikar"
    },
    ['polis:cezakes'] = {
        title = "Cut a Fine",
        icon = "#fa-money-bill-alt",
        functionName = "cezakes"
    },
    ['polis:kamu'] = {
        title = "Cut Public Service",
        icon = "#fa-broom",
        functionName = "kamu"
    },
    ['polis:hapisat'] = {
        title = "Throw Into Prison",
        icon = "#fa-user-lock",
        functionName = "hapisat"
    },
    ['polis:cezalarinabak'] = {
        title = "Unpaid Fines",
        icon = "#fa-money-check",
        functionName = "cezalarinabak"
    },
    ['polis:iyilestirPolis'] = {
        title = "Heal the Injured",
        icon = "#fa-first-aid",
        functionName = "iyilestirPolis"
    },
    ['polis:lisanskontrol'] = {
        title = "Check Licenses",
        icon = "#fa-digital-tachograph",
        functionName = "lisanskontrol"
    },
    ['polis:obje'] = {
        title = "Police Objects",
        icon = "#fa-exclamation-triangle",
        functionName = "obje"
    },
    -- ['polis:diken'] = {
    --     title = "Dikenli Tel",
    --     icon = "#fa-road",
    --     functionName = "diken"
    -- },
    -- ['polis:dikentopla'] = {
    --     title = "Dikenli Teli Topla",
    --     icon = "#fa-road",
    --     functionName = "c_deleteSpike"
    -- },

    -- mekanik İşlemleri
    ['mekanik:fatura'] = {
        title = "Invoice",
        icon = "#fa-file-invoice-dollar",
        functionName = "fatura"
    },
    ['mekanik:tamir'] = {
        title = "Repair Vehicle",
        icon = "#fa-tools",
        functionName = "tamir"
    },
    ['mekanik:tamir2'] = {
        title = "Jack The Vehicle",
        icon = "#fa-tools",
        functionName = "tamir2"
    },
    ['mekanik:temizle'] = {
        title = "Clean Tool",
        icon = "#fa-soap",
        functionName = "temizle"
    },
    ['mekanik:yukleyici'] = {
        title = "Embark/Download",
        icon = "#fa-truck-pickup",
        functionName = "yukleyici"
    },

    -- EMS İşlemleri
    ['ems:fatura'] = {
        title = "Invoice",
        icon = "#fa-file-invoice-dollar",
        functionName = "emsFatura"
    },
    ['ems:iyilestir'] = {
        title = "Heal the Injured",
        icon = "#fa-first-aid",
        functionName = "iyilestir"
    },
    ['ems:tedavi'] = {
        title = "Treat",
        icon = "#fa-band-aid",
        functionName = "tedavi"
    },
    ['ems:igne'] = {
        title = "Fix",
        icon = "#fa-syringe",
        functionName = "igne"
    },
    -- ['ems:tsandalye'] = {
    --     title = "Tekerlekli Sandalye",
    --     icon = "#fa-wheelchair",
    --     functionName = "tsandalye"
    -- },
    
    -- Oyuncu İşlemleri
    ['oyuncu:kucakla'] = {
        title = "Embrace/Release",
        icon = "#fa-people-carry",
        functionName = "kucakla"
    },
    ['sirtla'] = {
        title = "Back/Drop",
        icon = "#fa-people-carry",
        functionName = "sirtla"
    },
    ['tasi'] = {
        title = "Move/Drop",
        icon = "#fa-people-carry",
        functionName = "tasi"
    },
    ['oyuncu:rehinal'] = {
        title = "Take Pledge",
        icon = "#fa-users-slash",
        functionName = "rehinal"
    },
    ['oyuncu:ktasi'] = {
        title = "Move/Drop Handcuffs",
        icon = "#fa-people-carry",
        functionName = "ktasi"
    },
    ['oyuncu:kbindir'] = {
        title = "Get Handcuffed onto/Download Vehicle",
        icon = "#fa-crutch",
        functionName = "kbindir"
    },
    ['oyuncu:ybindir'] = {
        title = "Embark/Dismount the Injured",
        icon = "#fa-user-injured",
        functionName = "ybindir"
    },

    --Araç Koltuk menu
    ['mekan:garaj'] = {
        title = "Garages",
        icon = "#fa-warehouse",
        functionName = "garaj"
    },
    ['mekan:tgiannjob'] = {
        title = "Jobs",
        icon = "#fa-globe",
        functionName = "tgiannjob"
    },
    ['mekan:kiyafet'] = {
        title = "Clothing Shops",
        icon = "#fa-tshirt",
        functionName = "kiyafet"
    },
    ['mekan:kuafor'] = {
        title = "Hairdresser",
        icon = "#fa-cut",
        functionName = "kuafor"
    },
    ['mekan:dovme'] = {
        title = "Tattoo Shops",
        icon = "#fa-pen-nib",
        functionName = "dovme"
    },
    ['mekan:gazist'] = {
        title = "Gas Stations",
        icon = "#fa-gas-pump",
        functionName = "gazist"
    },
    -- -- ['mekan:silah'] = {
    -- --     title = "Silah Dukkanları",
    -- --     icon = "#fa-fire-extinguisher",
    -- --     functionName = "silahduk"
    -- -- },
    ['mekan:bank'] = {
        title = "Banks",
        icon = "#fa-university",
        functionName = "bank"
    },
    ['mekan:market'] = {
        title = "Markets",
        icon = "#fa-shopping-basket",
        functionName = "market"
    },

     ['kiyafet:sapka'] = {
    title = "Take off/Put a Hat",
    icon = "#fa-hat-cowboy-side",
    functionName = "hat"
    },
['kiyafet:zirh'] = {
    title = "Remove/Install Armor Accessory",
    icon = "#armor",
    functionName = "armor"
},
['kiyafet:gozluk'] = {
    title = "Remove/Plug Glasses",
    icon = "#fa-glasses",
    functionName = "glasses"
},
['kiyafet:maske'] = {
    title = "Mask Remove/Put",
    icon = "#fa-head-side-mask",
    functionName = "mask"
},
['kiyafet:tisort'] = {
    title = "Take off/Wear T-shirt",
    icon = "#fa-tshirt",
    functionName = "tshirt"
},
['kiyafet:pantalon'] = {
    title = "Take off/Wear Pants",
    icon = "#fa-male",
    functionName = "pants"
},
['kiyafet:canta'] = {
    title = "Remove/Insert Bag",
    icon = "#fa-shopping-bag",
    functionName = "bag"
},
['kiyafet:eldiven'] = {
    title = "Remove/Wear Gloves",
    icon = "#fa-mitten",
    functionName = "glove"
},
['kiyafet:ayakkabi'] = {
    title = "Take off/Wear Shoes",
    icon = "#fa-shoe-prints",
    functionName = "shoe"
},
   -- Kıyafet Menu

    -- -- Ehliyet Menüsü
    -- ['ehliyet:ehliyetbak'] = {
    --     title = "Ehliyet Bak",
    --     icon = "#fa-id-card",
    --     functionName = "ehliyetbak"
    -- },
    -- ['ehliyet:ehliyetver'] = {
    --     title = "Ehliyet Ver",
    --     icon = "#fa-id-card",
    --     functionName = "ehliyetver"
    -- },
    -- ['ehliyet:kimlik'] = {
    --     title = "Kimlik Bak",
    --     icon = "#fa-address-card",
    --     functionName = "kimlik"
    -- },
    -- ['ehliyet:kimlikver'] = {
    --     title = "Kimlik Ver",
    --     icon = "#fa-address-card",
    --     functionName = "kimlikver"
    -- },
    -- ['ehliyet:silahruhsat'] = {
    --     title = "Silah Ruhsatı Bak",
    --     icon = "#fa-file-contract",
    --     functionName = "silahruhsat"
    -- },
    -- ['ehliyet:silahruhsativer'] = {
    --     title = "Silah Ruhsatını Ver",
    --     icon = "#fa-file-contract",
    --     functionName = "silahruhsativer"
    -- },

    -- Genel
    ['genel:anahtarver'] = {
        title = "Give Vehicle Key",
        icon = "#fa-key",
        functionName = "anahtarver"
    },
    ['genel:bgir'] = {
        title = "Get In The Trunk",
        icon = "#fa-truck-loading",
        functionName = "bgir"
    },
    ['genel:yarali'] = {
        title = "Wounded",
        icon = "#fa-user-injured",
        functionName = "yarali"
    },
    ['genel:normal'] = {
        title = "Walking Animations",
        icon = "#fa-running",
        functionName = "yuruyus"
    },
    ['genel:anim'] = {
        title = "Animations",
        icon = "#fa-play",
        functionName = "anim"
    },
    
    -- ['gpssac'] = {
    --     title = "GPS Aç",
    --     icon = "#fa-map-marker-alt",
    --     functionName = "gpssac"
    -- },
    -- ['gpskapa'] = {
    --     title = "GPS Kapat",
    --     icon = "#fa-map-marker",
    --     functionName = "gpskapa"
    -- },
  --[[   ["expressions:dumb"] = {
        title="Dumb",
        icon="#expressions-dumb",
        functionName = "expressions",
        functionParameters =  { "pose_injured_1" }
    }, ]]
}

RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    PlayerData = QBCore.Functions.GetPlayerData()
    job = PlayerData.job.name
end)

RegisterNetEvent('QBCore:Client:OnJobUpdate')
AddEventHandler('QBCore:Client:OnJobUpdate', function(newJob)
    PlayerData.job = newJob
    job = PlayerData.job.name
end)

RegisterNetEvent('QBCore:Client:SetDuty')
AddEventHandler('QBCore:Client:SetDuty', function(duty)
    onDuty = duty
end)

AddEventHandler('tgiann:playerdead', function(dead)
    isDead = dead
end)

function ClosestVehicle(dist)
    local vehicle, distance = QBCore.Functions.GetClosestVehicle(GetEntityCoords(PlayerPedId()))
    if distance <= dist then
        return true
    end
    return false
end

function ClosestPlayer(dist)
    local closestPlayer, distance = QBCore.Functions.GetClosestPlayer()
    if distance <= dist then
        return true
    end
    return false
end