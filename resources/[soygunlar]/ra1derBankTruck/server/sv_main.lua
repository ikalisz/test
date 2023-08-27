local QBCore = exports['qb-core']:GetCoreObject()



QBCore.Functions.CreateUseableItem("thermite", function(source, item)
    local Player = QBCore.Functions.GetPlayer(source)
	if Player.Functions.GetItemBySlot(item.slot) then
        TriggerClientEvent("thermite:UseThermite", source)
    end
end)

QBCore.Functions.CreateCallback('qb-truckrobbery:server:getCops', function(source, cb)
	local amount = 0
    for k, v in pairs(QBCore.Functions.GetQBPlayers()) do
        if v.PlayerData.job.name == "police" and v.PlayerData.job.onduty then
            amount = amount + 1
        end
    end
    cb(amount)
end)

RegisterServerEvent("qb-truckrobbery:server:removeItem", function() 
	local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["guvenlik_karti_g"], "remove")  
    Player.Functions.RemoveItem("guvenlik_karti_g", 1) 
end)

RegisterServerEvent('qb-truckrobbery:server:UpdatePlates', function(plate)
    Config.RobbedPlates[plate] = true
    TriggerClientEvent('qb-truckrobbery:client:UpdatePlates', -1, plate)
end)

RegisterServerEvent('qb-truckrobbery:server:RemoveDoors', function(truck)
    TriggerClientEvent('qb-truckrobbery:client:RemoveDoors', -1, truck)
end)

RegisterServerEvent('qb-truckrobbery:server:ThermitePtfx', function(coords)
    TriggerClientEvent('qb-truckrobbery:client:ThermitePtfx', -1, coords)
end)

RegisterServerEvent('qb-truckrobbery:server:addItem', function()
	local src = source
    local Player = QBCore.Functions.GetPlayer(source)
    local amount = math.random(35000,50000)
    Player.Functions.AddMoney("cash", amount)
    TriggerEvent('DiscordBot:ToDiscord', 'banktruck', "**".. GetPlayerName(src) .. "** (citizenid: *"..Player.PlayerData.citizenid.."* | id: *"..src.."*)"..' Bank Truck Aracını soydu ve ****: '..amount.. ' x '.. "$ Para Aldı")
    if math.random(1, 100) > 60 then 
    Player.Functions.AddItem("guvenlik_karti_h", 1)
    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["guvenlik_karti_g"], "add") 
    TriggerClientEvent("QBCore:Notify", src, "You Found a Security Card")
    end
end)