QBCore = nil
TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)

local basicBeklemeCd = 3600 -- Saniye Cinsinden basit kasa için bekleme
local hardBeklemeCd = 5000 -- Saniye Cinsinden zor kasa için bekleme

local marketler = {
    [1] = {
		["son_basic_cd"] = 0,
        ["son_advanced_cd"] = 0,
    },
    [2] = {
		["son_basic_cd"] = 0,
        ["son_advanced_cd"] = 0,
    },
    [3] = {
		["son_basic_cd"] = 0,
        ["son_advanced_cd"] = 0,
    },
    [4] = {
		["son_basic_cd"] = 0,
        ["son_advanced_cd"] = 0,
    },
    [5] = {
		["son_basic_cd"] = 0,
        ["son_advanced_cd"] = 0,
    },
    [6] = {
		["son_basic_cd"] = 0,
        ["son_advanced_cd"] = 0,
    },
    [7] = {
		["son_basic_cd"] = 0,
        ["son_advanced_cd"] = 0,
    },
    [8] = {
		["son_basic_cd"] = 0,
        ["son_advanced_cd"] = 0,
    },
    [9] = {
		["son_basic_cd"] = 0,
        ["son_advanced_cd"] = 0,
    },
    [10] = {
		["son_basic_cd"] = 0,
        ["son_advanced_cd"] = 0,
    },
    [11] = {
		["son_basic_cd"] = 0,
        ["son_advanced_cd"] = 0,
    },
    [12] = {
		["son_basic_cd"] = 0,
        ["son_advanced_cd"] = 0,
    },
	[13] = {
		["son_basic_cd"] = 0,
        ["son_advanced_cd"] = 0,
    },
	[14] = {
		["son_basic_cd"] = 0,
        ["son_advanced_cd"] = 0,
    },
    [15] = {
		["son_basic_cd"] = 0,
        ["son_advanced_cd"] = 0,
    },
	[16] = {
		["son_basic_cd"] = 0,
        ["son_advanced_cd"] = 0,
    },
    [17] = {
		["son_basic_cd"] = 0,
        ["son_advanced_cd"] = 0,
    },
	[18] = {
		["son_basic_cd"] = 0,
        ["son_advanced_cd"] = 0,
    },
	[19] = {
		["son_basic_cd"] = 0,
        ["son_advanced_cd"] = 0,
    },
}

QBCore.Functions.CreateCallback('edrp-marketsoygunu:item-ve-sure-kontrol', function(source, cb, marketNo, tip, item1, item2)
    local xPlayer = QBCore.Functions.GetPlayer(source)
    local src = source
    if xPlayer then
        if tip == "basic" and (os.time() - marketler[marketNo]["son_basic_cd"]) > basicBeklemeCd then
            local gerekenItem1 = xPlayer.Functions.GetItemByName(item1)
            if gerekenItem1.amount >= 1 then
                cb(true)
                marketler[marketNo]["son_basic_cd"] = os.time()
            else
                TriggerClientEvent("QBCore:Notify", xPlayer.PlayerData.source, "You do not have the necessary items to open this safe!", "error")
                cb(false)
            end
        elseif tip == "hard" and (os.time() - marketler[marketNo]["son_advanced_cd"]) > hardBeklemeCd then
            local gerekenItem1 = xPlayer.Functions.GetItemByName(item1)
            if gerekenItem1.amount >= 1 then
                local gerekenItem2 = xPlayer.Functions.GetItemByName(item2)
                if gerekenItem2.amount >= 1 then
                    TriggerClientEvent('havefun-kasa:sendDispatch', src)
                    marketler[marketNo]["son_advanced_cd"] = os.time()
                    cb(true)
                else
                    TriggerClientEvent("QBCore:Notify", xPlayer.PlayerData.source, "On " .. QBCore.Shared.Items[item2].label .. " None", "error")
                    cb(false)
                end
            else
                TriggerClientEvent("QBCore:Notify", xPlayer.PlayerData.source, "You do not have the necessary item to open this safe!", "error")
                cb(false)
            end
        else
            TriggerClientEvent("QBCore:Notify", xPlayer.PlayerData.source, "Case Empty!", "error")
            cb(false)
        end   
    end
end)

RegisterServerEvent("edrp-marketsoygun:soygun-yapildi")
AddEventHandler("edrp-marketsoygun:soygun-yapildi", function(kasaNo, durum, tip)
    if durum then
        marketler[kasaNo][tip] = os.time()
    else
        marketler[kasaNo][tip] = 0
    end
end)

RegisterServerEvent("edrp-marketsoygun:item-sil")
AddEventHandler("edrp-marketsoygun:item-sil", function(key, tip, kasaNo)
    local src = source
    if QBCore.Functions.kickHacKer(src, key) then -- QBCore.Key
        local xPlayer = QBCore.Functions.GetPlayer(src)
        if xPlayer then
            if tip == "basic" then
                if xPlayer.Functions.RemoveItem("lockpick2", 1, xPlayer.Functions.GetItemByName("lockpick2").slot) then
                    if math.random(0,100) < 15 then
                        xPlayer.Functions.AddItem("guvenlik_karti_b", 1)
                        TriggerEvent('DiscordBot:ToDiscord', 'yazarkasa', "İsimli Oyuncu : Kasiyer Soydu ve Ekstra Olarak Guvenlik Kartı A Çıkarttı", xPlayer.PlayerData.source)
                    end
                    local para = math.random(650, 850)
                    xPlayer.Functions.AddMoney('cash', para)
                    TriggerClientEvent("QBCore:Notify", xPlayer.PlayerData.source, "From the cash register you got " .. para .. "$ ")
                    TriggerEvent('DiscordBot:ToDiscord', 'yazarkasa', "İsimli Oyuncu: Yazarkasa Soydu " ..para.. " $ Çıktı", xPlayer.PlayerData.source)
                end
            elseif tip == "hard" then
                if xPlayer.Functions.RemoveItem("matkap", 1, xPlayer.Functions.GetItemByName("matkap").slot) then
                    if xPlayer.Functions.RemoveItem("guvenlik_karti_a", 1, xPlayer.Functions.GetItemByName("guvenlik_karti_a").slot) then
                        if math.random(0,100) > 70 then
                            xPlayer.Functions.AddItem("guvenlik_karti_b", 1)
                            TriggerEvent('DiscordBot:ToDiscord', 'hardkasa', "İsimli Oyuncu : Kasiyer Soydu ve Ekstra Olarak Guvenlik Kartı B Çıkarttı", xPlayer.PlayerData.source)
                        end
                        local para = math.random(5000, 10000)
                        xPlayer.Functions.AddMoney('cash', para)
                        TriggerEvent('DiscordBot:ToDiscord', 'hardkasa', "İsimli Oyuncu: Market Arka Kasasını Soydu " ..para.. "$ Çıktı", xPlayer.PlayerData.source)
                        TriggerClientEvent("QBCore:Notify", xPlayer.PlayerData.source, "From the cash register you got " .. para .. " $")
                    end
                end
            else
                xPlayer.Functions.RemoveItem("matkap", 1, xPlayer.Functions.GetItemByName("matkap").slot)
                xPlayer.Functions.RemoveItem("guvenlik_karti_a", 1, xPlayer.Functions.GetItemByName("guvenlik_karti_a").slot)
                marketler[kasaNo]["son_advanced_cd"] = 0
            end
        end
    end
end)



