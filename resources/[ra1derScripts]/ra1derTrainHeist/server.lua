QBCore = nil 
local lastrob = 0
local start = false
discord = {
    ['webhook'] = 'WEBHOOKLINK',
    ['name'] = 'rm_trainheist',
    ['image'] = ''
}

TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)

QBCore.Functions.CreateCallback('trainheist:server:checkTime', function(source, cb)
    local src = source
    local player = QBCore.Functions.GetPlayer(src)
    
    if (os.time() - lastrob) < Config['TrainHeist']['nextRob'] and lastrob ~= 0 then
        local seconds = Config['TrainHeist']['nextRob'] - (os.time() - lastrob)
        -- TriggerClientEvent('trainheist:client:showNotification', src, Strings['wait_nextrob'] .. ' ' .. math.floor(seconds / 60) .. ' ' .. Strings['minute'])
        TriggerClientEvent("QBCore:Notify", src, "To Restart the Train Robbery " .. " " .. math.floor(seconds / 60) .. ' ' .. "You Have to Wait Minutes", "error")
        cb(false)
    else
        lastrob = os.time()
        start = true
        -- discordLog(player.getName() ..  ' - ' .. player.getIdentifier(), ' started the Train Heist!')
        cb(true)
    end
end)

QBCore.Functions.CreateCallback('trainheist:server:hasItem', function(source, cb, item)
    local src = source
    local player = QBCore.Functions.GetPlayer(src)
    local playerItem = player.Functions.GetItemByName(item)

    if player and playerItem ~= nil then
        if playerItem.amount >= 1 then
            cb(true, playerItem.label)
        else
            cb(false, playerItem.label)
        end
    end
end)

RegisterServerEvent("kart:sil", function()
    local src = source 
    local Player = QBCore.Functions.GetPlayer(source)
    local amount = player.Functions.GetItemByName(Config.KartName).amount
    if amount > 0 then
        Player.Functions.RemoveItem(Config.KartName, 1)
    end
end)

RegisterServerEvent('trainheist:server:rewardItems')
AddEventHandler('trainheist:server:rewardItems', function()
    local src = source
    local player = QBCore.Functions.GetPlayer(src)
    local randomdeger = math.random(8, 15)

    if player then
        player.Functions.AddItem("goldbar", randomdeger)
        if math.random(1, 100) < 6 then
            player.Functions.AddItem("guvenlik_karti_f", 1)
        end
    end
end)

RegisterServerEvent('trainheist:server:sellRewardItems')
AddEventHandler('trainheist:server:sellRewardItems', function()
    local src = source
    local player = QBCore.Functions.GetPlayer(src)
    local cashamount = 1500

    if player then
        local amount = player.Functions.GetItemByName("goldbar").amount
        if amount > 0 then
            player.Functions.RemoveItem ("goldbar", amount)
            -- player.addMoney(Config['TrainHeist']['reward']['sellPrice'] * amount)
            player.Functions.AddMoney("cash", cashamount * amount)

            -- discordLog(player.getName() ..  ' - ' .. player.getIdentifier(), ' Gain $' .. math.floor(Config['TrainHeist']['reward']['sellPrice'] * amount) .. ' on the Train Heist Buyer!')
            TriggerClientEvent("QBCore:Notify", src, "You Gave Gold Bars, In Return " ..cashamount * amount.. " $", "success")
        end
    end
end)


RegisterServerEvent('trainheist:server:containerSync')
AddEventHandler('trainheist:server:containerSync', function(coords, rotation)
    TriggerClientEvent('trainheist:client:containerSync', -1, coords, rotation)
end)

RegisterServerEvent('trainheist:server:objectSync')
AddEventHandler('trainheist:server:objectSync', function(e)
    TriggerClientEvent('trainheist:client:objectSync', -1, e)
end)

RegisterServerEvent('trainheist:server:trainLoop')
AddEventHandler('trainheist:server:trainLoop', function()
    TriggerClientEvent('trainheist:client:trainLoop', -1)
end)

RegisterServerEvent('trainheist:server:lockSync')
AddEventHandler('trainheist:server:lockSync', function(index)
    TriggerClientEvent('trainheist:client:lockSync', -1, index)
end)

RegisterServerEvent('trainheist:server:grabSync')
AddEventHandler('trainheist:server:grabSync', function(index, index2)
    TriggerClientEvent('trainheist:client:grabSync', -1, index, index2)
end)

RegisterServerEvent('trainheist:server:resetHeist')
AddEventHandler('trainheist:server:resetHeist', function()
    if not start then return end
    start = false
    TriggerClientEvent('trainheist:client:resetHeist', -1)
end)

QBCore.Functions.CreateCallback('tren:item-kontrol', function(source, cb)
    local src = source
    local player = QBCore.Functions.GetPlayer(src)
    
    if player.Functions.GetItemByName('guvenlik_karti_e').amount >= 1 then
        if player.Functions.RemoveItem('guvenlik_karti_e', 1) then
            cb(true)
        else
            cb(false)
        end
    else
        cb(false)
    end
end)
