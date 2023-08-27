QBCore = nil
TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)

RegisterServerEvent('disc-hotwire:maymuncuksil')
AddEventHandler('disc-hotwire:maymuncuksil', function()
    local src = source
	local xPlayer = QBCore.Functions.GetPlayer(src)
    xPlayer.Functions.RemoveItem("lockpick2", 1, xPlayer.Functions.GetItemByName("lockpick2").slot)
end)

RegisterServerEvent('disc-hotwire:givereward')
AddEventHandler('disc-hotwire:givereward', function(cashreward, key)
    local src = source
    if QBCore.Functions.kickHacKer(src, key) then -- QBCore.Key
        local xPlayer = QBCore.Functions.GetPlayer(src)
        xPlayer.Functions.AddMoney('cash', cashreward)
    end
end)

local carItems = {
    {"beer", 1},
    {"saat", 1},
    {"white_phone", 1},
    {"lockpick2", 1},
    {"water", 1},
    {"kraker", 1},
    {"umbrella", 1},
    {"weapon_wrench", 1},
    {"vodka", 1},
    {"kemer", 1},
}

RegisterServerEvent('disc-hotwire:aracitem')
AddEventHandler('disc-hotwire:aracitem', function(key)
    local src = source
    if QBCore.Functions.kickHacKer(src, key) then -- QBCore.Key
        local xPlayer = QBCore.Functions.GetPlayer(src)
        local carItem = math.random(1,#carItems)
        if xPlayer.Functions.AddItem(carItems[carItem][1], carItems[carItem][2]) then
            TriggerClientEvent("QBCore:Notify", src, carItems[carItem][2] .. " Tane " .. QBCore.Shared.Items[carItems[carItem][1]].label ..' Buldun')
        end
    end
end)

RegisterNetEvent('ARPF:GiveKeys')
AddEventHandler('ARPF:GiveKeys', function(closestplayer, vehicle, plate)
    local src = closestplayer
    local xPlayer = QBCore.Functions.GetPlayer(src)
    if xPlayer then
        TriggerClientEvent("x-hotwire:give-keys", xPlayer.PlayerData.source, vehicle, plate)
        TriggerClientEvent("QBCore:Notify", src,'You Got the Key of the License Plate Vehicle' .. plate .. '')
    end
end)

QBCore.Functions.CreateUseableItem('lockpick2', function(source, item)
    local Player = QBCore.Functions.GetPlayer(source)
	if Player.Functions.GetItemBySlot(item.slot) then
        TriggerClientEvent('disc-hotwire:disardanMaymuncuk', source)
        TriggerClientEvent('ra1derHouseRob:useLockpick', source)
        TriggerClientEvent("lockpicks:UseLockpick", source)
        print("ananı yicem")
    end
end)
QBCore.Commands.Add("givekey", "Give Vehicle Key to Nearby Player", {}, false, function(source, args) 
	TriggerClientEvent('x-hotwire:tgiannf3inahtar', source)
end)