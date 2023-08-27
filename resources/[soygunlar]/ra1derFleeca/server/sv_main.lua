local QBCore = exports['qb-core']:GetCoreObject()

Doors = {
    ["F1"] = {{loc = vector3(310.93, -284.44, 54.16), txtloc = vector3(310.93, -284.44, 54.16), state = nil, locked = true}},
    ["F2"] = {{loc = vector3(146.61, -1046.02, 29.37), txtloc = vector3(146.61, -1046.02, 29.37), state = nil, locked = true}},
    ["F3"] = {{loc = vector3(-1211.07, -336.68, 37.78), txtloc = vector3(-1211.07, -336.68, 37.78), state = nil, locked = true}},
    ["F4"] = {{loc = vector3(-2956.68, 481.34, 15.70), txtloc = vector3(-2956.68, 481.34, 15.7), state = nil, locked = true}},
    ["F5"] = {{loc = vector3(-354.15, -55.11, 49.04), txtloc = vector3(-354.15, -55.11, 49.04), state = nil, locked = true}},
    ["F6"] = {{loc = vector3(1176.40, 2712.75, 38.09), txtloc = vector3(1176.40, 2712.75, 38.09), state = nil, locked = true}},
}

QBCore.Functions.CreateCallback("ra1derFleeca:startcheck", function(src,cb,bank)
    local Player = QBCore.Functions.GetPlayer(src)
    if not Fleeca.Banks[bank].onaction == true then
        if (os.time() - Fleeca.cooldown) > Fleeca.Banks[bank].lastrobbed then
            cb(true)
        else
            cb(false,"you are late!, This bank was recently robbed, you should wait for.! "..math.floor((Fleeca.cooldown - (os.time() - Fleeca.Banks[bank].lastrobbed)) / 60)..":"..math.fmod((Fleeca.cooldown - (os.time() - Fleeca.Banks[bank].lastrobbed)), 60))
        end
    else
        cb(false,"This bank is already being robbed right now?")
    end
end)
RegisterServerEvent("ra1derFleeca:start")
AddEventHandler("ra1derFleeca:start", function(bank)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Fleeca.Banks[bank].onaction == true then
        if (os.time() - Fleeca.cooldown) > Fleeca.Banks[bank].lastrobbed then
            Fleeca.Banks[bank].onaction = true
            Fleeca.Banks[bank].lastrobbed = os.time()
            TriggerClientEvent("ra1derFleeca:outcome", src, true, bank)
        else
            TriggerClientEvent("ra1derFleeca:outcome", src, false, "you are late!, This bank was recently robbed, you should wait for.! "..math.floor((Fleeca.cooldown - (os.time() - Fleeca.Banks[bank].lastrobbed)) / 60)..":"..math.fmod((Fleeca.cooldown - (os.time() - Fleeca.Banks[bank].lastrobbed)), 60))
        end
    else
        TriggerClientEvent("ra1derFleeca:outcome", src, false, "This bank is already being robbed right now?")
    end
end)

RegisterServerEvent("ra1derFleeca:lootup")
AddEventHandler("ra1derFleeca:lootup", function(var, var2)
    TriggerClientEvent("ra1derFleeca:lootup_c", -1, var, var2)
end)

RegisterServerEvent("ra1derFleeca:toggleVault")
AddEventHandler("ra1derFleeca:toggleVault", function(key, state)
    Doors[key][1].locked = state
    TriggerClientEvent("ra1derFleeca:toggleVault", -1, key, state)
end)

RegisterServerEvent("ra1derFleeca:updateVaultState")
AddEventHandler("ra1derFleeca:updateVaultState", function(key, state)
    Doors[key][1].state = state
end)

RegisterServerEvent("ra1derFleeca:startLoot")
AddEventHandler("ra1derFleeca:startLoot", function(data, name, players)
    local src = source

    for i = 1, #players, 1 do
        TriggerClientEvent("ra1derFleeca:startLoot_c", players[i], data, name)
    end
    TriggerClientEvent("ra1derFleeca:startLoot_c", src, data, name)
end)

RegisterServerEvent("ra1derFleeca:stopHeist")
AddEventHandler("ra1derFleeca:stopHeist", function(name)
    TriggerClientEvent("ra1derFleeca:stopHeist_c", -1, name)
end)

RegisterServerEvent("ra1derFleeca:rewardCash")
AddEventHandler("ra1derFleeca:rewardCash", function()
-- QBCore.Commands.Add('parakanka', 'Help Text', {}, false, function(source, args)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    -- if QBCore.Functions.kickHacKer(source, key) then -- QBCore.Key
        local reward = math.random(200, 400)
        Player.Functions.AddMoney("cash", reward)
    -- end
end)

RegisterServerEvent("ra1derFleeca:giveCard")
AddEventHandler("ra1derFleeca:giveCard", function()
    local src = source 
    local Player = QBCore.Functions.GetPlayer(src)
    local random = math.random(0, 100)
    if random > 60 then 
        Player.Functions.AddItem("guvenlik_karti_e", 1)
        TriggerClientEvent("QBCore:Notify", src, "You found a security card among the piles of money.")
    end
end)

QBCore.Functions.CreateCallback("ra1derFleeca:getBanks", function(source, cb)
    cb(Fleeca.Banks, Doors)
end)


QBCore.Functions.CreateCallback('ra1derFleeca:server:HasItem', function(source, cb, ItemName)
    local Player = QBCore.Functions.GetPlayer(source)
    local Item = Player.Functions.GetItemByName(ItemName)
    if Player ~= nil then
       if Item ~= nil then
         cb(true)
       else
         cb(false)
       end
    end
end)



QBCore.Functions.CreateUseableItem("laptop", function(source, item)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
	if Player.Functions.GetItemBySlot(item.slot) ~= nil then
        TriggerClientEvent('ra1derFleeca:UseGreenLapTop', source, item)
    end
end)

RegisterServerEvent('rick:removeLaptop')
AddEventHandler('rick:removeLaptop', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    Player.Functions.RemoveItem('guvenlik_karti_d', 1)
end)