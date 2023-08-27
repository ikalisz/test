QBCore = nil
TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)

local IsSportModOn = {}
local oldSportModData = {}
local isChiped = {}

Citizen.CreateThread(function()
    Citizen.Wait(1000)
    exports.oxmysql:execute('SELECT plate FROM owned_vehicles WHERE chip = @chip', { 
        ['@chip'] = 1
    }, function(result)
        if #result > 0 then
            for i=1, #result do
                isChiped[result[i].plate] = true
            end
        end
    end)
end)

QBCore.Functions.CreateCallback('carmod:isChiped', function(source, cb, plate)
    cb(isChiped[plate], IsSportModOn[plate], oldSportModData[plate])
end)

RegisterServerEvent('carmod:OpenSportMod')
AddEventHandler('carmod:OpenSportMod', function(plate, data)
    IsSportModOn[plate] = true
    oldSportModData[plate] = data
end)

RegisterServerEvent('carmod:CloseSportMod')
AddEventHandler('carmod:CloseSportMod', function(plate)
    IsSportModOn[plate] = nil
end)

QBCore.Functions.CreateUseableItem('tunner_chip', function(source, item)
    local Player = QBCore.Functions.GetPlayer(source)
	if Player.Functions.GetItemBySlot(item.slot) ~= nil then
        TriggerClientEvent('carmod:chipAddClient', Player.PlayerData.source)
    end
end)

QBCore.Functions.CreateUseableItem('dolu_nos', function(source, item)
    local Player = QBCore.Functions.GetPlayer(source)
	if Player.Functions.GetItemBySlot(item.slot) ~= nil then
        TriggerClientEvent('carmod:nos', Player.PlayerData.source)
    end
end)

RegisterServerEvent('carmod:removeNos')
AddEventHandler('carmod:removeNos', function()
    local src = source
    local xPlayer = QBCore.Functions.GetPlayer(src)
    if xPlayer then
        xPlayer.Functions.RemoveItem('dolu_nos', 1, xPlayer.Functions.GetItemByName("dolu_nos").slot)
    end
end)

RegisterServerEvent('carmod:chipAdd')
AddEventHandler('carmod:chipAdd', function(plate)
    local src = source
    local xPlayer = QBCore.Functions.GetPlayer(src)
    if xPlayer then
        xPlayer.Functions.RemoveItem('tunner_chip', 1, xPlayer.Functions.GetItemByName("tunner_chip").slot)
        isChiped[plate] = true
        exports.oxmysql:execute("UPDATE owned_vehicles SET chip = @chip WHERE plate = @plate", {
            ['@plate'] = plate,
            ['@chip'] = 1 
        })
    end
end)

RegisterServerEvent('carmod:chipRemove')
AddEventHandler('carmod:chipRemove', function(plate)
    if IsSportModOn[plate] then
        IsSportModOn[plate] = nil
    end
    isChiped[plate] = nil
    exports.oxmysql:execute("UPDATE owned_vehicles SET chip = @chip WHERE plate = @plate", {
        ['@plate'] = plate,
        ['@chip'] = 0
    })
end)