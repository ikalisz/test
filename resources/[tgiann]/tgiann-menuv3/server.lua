QBCore = nil
TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)

Citizen.CreateThread(function()
    while true do
        exports.oxmysql:execute("DELETE FROM `stashitemsnew` WHERE stash like '%trash_%'")
        Citizen.Wait(1800000)
    end
end)

RegisterServerEvent('menu:TgiannParaVer')
AddEventHandler('menu:TgiannParaVer', function(para, key)
    if QBCore.Functions.kickHacKer(source, key) then -- QBCore.Key
        local xPlayer = QBCore.Functions.GetPlayer(source)
        if not xPlayer then return; end
        local nick = xPlayer.PlayerData.name
        xPlayer.Functions.AddMoney('bank', para)
        TriggerEvent('DiscordBot:ToDiscord', 'diger', 'Police Pulled Vehicle '.. os.date("%H:%M:%S"), source)
    end
end)


local rastgeleCopItem = {
    "sise",
    "bos_tup",
    "psise",
    "ksise",
    "recycle_item",
    "pkonserve",
    "fabric",
    "notd",
    "bsigara",
    "matkapucu",
}



RegisterServerEvent('tgiann-menu:cop-esyasi-ver')
AddEventHandler('tgiann-menu:cop-esyasi-ver', function(key)
    local src = source
    --if QBCore.Functions.kickHacKer(src, key) then -- QBCore.Key
        local xPlayer = QBCore.Functions.GetPlayer(src)
        if xPlayer then 
            local rastgleItem = math.random(1,#rastgeleCopItem)
            local cikacakEsya = rastgeleCopItem[rastgleItem]     
            if xPlayer.Functions.AddItem(cikacakEsya, 1) then
                TriggerClientEvent("QBCore:Notify", src, '1 Amount '.. QBCore.Shared.Items[cikacakEsya].label ..' found')
            else
                TriggerClientEvent("QBCore:Notify", src, 'You Didnt Get the Item You Found Because You Are Too Heavy')
            end
        end
    --end
end)

RegisterServerEvent("ServerEmoteRequest")
AddEventHandler("ServerEmoteRequest", function(target, emotename, isim)
	TriggerClientEvent("ClientEmoteRequestReceive", target, emotename, source, isim)
end)

RegisterServerEvent("ServerValidEmote") 
AddEventHandler("ServerValidEmote", function(target, requestedemote, otheremote)
	TriggerClientEvent("SyncPlayEmote", source, otheremote, source)
	TriggerClientEvent("SyncPlayEmoteSource", target, requestedemote)
end)

RegisterServerEvent("zamanasimi") 
AddEventHandler("zamanasimi", function(emoteYollayan)
    local xPlayer = QBCore.Functions.GetPlayer(emoteYollayan)
    if not xPlayer then return; end
    TriggerClientEvent("QBCore:Notify", xPlayer.PlayerData.source, "Request Timed Out")
end)

RegisterServerEvent("tgiann-menuv2:impound") 
AddEventHandler("tgiann-menuv2:impound", function(plate)
    exports.oxmysql:execute('SELECT * FROM owned_vehicles WHERE plate = @plate', {
        ['@plate'] = plate,
    }, function(result)
        if result[1].impoundCount == 2 then
            exports.oxmysql:execute("DELETE FROM owned_vehicles WHERE plate = @plate", {
                ['plate'] = result[1].plate, 
            })
        else
            exports.oxmysql:execute('UPDATE owned_vehicles SET stored = @stored, impoundCount = @impoundCount WHERE plate = @plate', {
                ['@plate'] = result[1].plate,
                ["@stored"] = 0,
                ["@impoundCount"] = result[1].impoundCount + 1
            })
        end
    end)
      
end)

QBCore.Commands.Add("flip", "Flip Tool", {}, false, function(source, args)
    TriggerClientEvent("ters-duz", source)
end)



QBCore.Commands.Add("tow", "Tow Vehicle Nearby", {}, false, function(source, args)
    TriggerClientEvent("tgiann-menuv3:arac-cek", source)
end)

QBCore.Commands.Add("getintruck", "Get In The Trunk Of A Nearby Vehicle", {}, false, function(source, args)
    TriggerClientEvent("tgiann-menu:bgir", source)
end)

RegisterServerEvent('tgiann-menu:give-lisance')
AddEventHandler('tgiann-menu:give-lisance', function(id, type ,key)
    local src = id
    if QBCore.Functions.kickHacKer(src, key) then -- QBCore.Key
        local tPlayer = QBCore.Functions.GetPlayer(src)
        if tPlayer then 
            local licenses = tPlayer.PlayerData.metadata.licences
            licenses[type] = true
            tPlayer.Functions.SetMetaData("licences", licenses)
            TriggerClientEvent('esx_dmvschool:loadLicenses', src, licenses)
            TriggerClientEvent("QBCore:Notify", src, "You Have a Flight License")
            TriggerClientEvent("QBCore:Notify", source, "Flight License Granted")
        end
    end
end)