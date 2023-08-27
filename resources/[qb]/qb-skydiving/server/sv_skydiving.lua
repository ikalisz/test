local QBCore = exports['qb-core']:GetCoreObject()

local flightinprogress = false

function flightCooldown()
    SetTimeout(300000, function()
        flightinprogress = false
    end)
end


RegisterServerEvent('qb-skydiving:flightcooldown', function()
    flightinprogress = true
    flightCooldown()
end)

RegisterServerEvent("qb-skydiving:server:payforgroup")
AddEventHandler("qb-skydiving:server:payforgroup", function()
    local source = source
    local Player = QBCore.Functions.GetPlayer(source)
    local groupfee = 750
    local balance = Player.Functions.GetMoney('bank')

    if not flightinprogress then
        if balance >= groupfee then
            Player.Functions.RemoveMoney("bank", groupfee, "skydive")
            TriggerClientEvent('QBCore:Notify', source, " You paid money to parachute as a group", 'success')
            TriggerClientEvent('qb-skydiving:client:skydivetime', source)
        else
            TriggerClientEvent('QBCore:Notify', source, " You don't have enough money in the bank.", 'error')
        end
    else
        TriggerClientEvent('QBCore:Notify', source, "The flight is already going on.", 'error')
    end
end)

RegisterServerEvent("qb-skydiving:server:solojump")
AddEventHandler("qb-skydiving:server:solojump", function()
    local source = source
    local Player = QBCore.Functions.GetPlayer(source)
    local solofee = 250
    local balance = Player.Functions.GetMoney('bank')

    if not flightinprogress then

        if balance >= solofee then
            TriggerClientEvent('qb-skydiving:client:skydivesolo', source)
            Player.Functions.RemoveMoney("bank", solofee, "skydive-solo")
            TriggerClientEvent('QBCore:Notify', source, " You paid money for one -man jump", 'success')
        else
            TriggerClientEvent('QBCore:Notify', source, " You don't have enough money in the bank.", 'error')
        end
    else
        TriggerClientEvent('QBCore:Notify', source, "The flight is already going on.", 'error')
    end
end)