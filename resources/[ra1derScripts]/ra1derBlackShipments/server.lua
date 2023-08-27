local QBCore = exports['qb-core']:GetCoreObject()

QBCore.Functions.CreateCallback('ra1derBlackShipment:getTime', function(source, cb)
    cb(os.time())
end)

QBCore.Functions.CreateCallback('ra1derBlackShipment:getAllShipments', function(source, cb)
    local src = source
    local xPlayer = QBCore.Functions.GetPlayer(src)
    exports.oxmysql:execute('SELECT * FROM blackmarket WHERE citizenid = @citizenid', {
        ['@citizenid'] = xPlayer.PlayerData.citizenid,
    }, function(result)
        cb(result)
    end)
end)

QBCore.Functions.CreateCallback('ra1derBlackShipment:GetAllItems', function(source, cb, id)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    exports.oxmysql:execute('SELECT * FROM blackmarket WHERE id = @id', {
        ['@id'] = id
    }, function(result)
        exports.oxmysql:execute('DELETE FROM blackmarket WHERE id = @id', {
            ['@id'] = result[1].id
        })
        local rarechange = math.random(0, 100) 
        if rarechange <=  tonumber(result[1].rare) then
            if Player.Functions.AddItem(result[1].item, result[1].count) then
                TriggerClientEvent('QBCore:Notify', Player.PlayerData.source, result[1].count..'x '..result[1].label..' '..Lang:t('server.order'), 'success')
            end
            cb(true)
        else
            TriggerClientEvent('QBCore:Notify', Player.PlayerData.source, Lang:t('server.war')..' ('..result[1].label..')', 'error')
            cb(false)
        end
    end)
end)

RegisterServerEvent('ra1derBlackShipment:MakeShipment')
AddEventHandler('ra1derBlackShipment:MakeShipment', function(item, label, count, price, rare, time)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    if Player.Functions.RemoveMoney(Config.PaymentType, price) then
        TriggerClientEvent("progressbar", source)
        exports.oxmysql:execute('INSERT INTO blackmarket (sure, rare ,citizenid, label, item, price, count, time) VALUES (@sure, @rare, @citizenid, @label, @item, @price, @count, @time)',{
            ["@sure"] = time,
            ["@rare"] = rare,
            ['@citizenid'] = Player.PlayerData.citizenid,
            ['@label'] = label,
            ['@item'] = item,
            ['@price'] = price,
            ['@count'] = count,
            ['@time'] = os.time()
        })
        TriggerClientEvent('QBCore:Notify', Player.PlayerData.source, Lang:t('server.pay')..' ($'..price..') ('..count..'x) ('..label..').', 'success')
    else
        TriggerClientEvent('QBCore:Notify', Player.PlayerData.source, Lang:t('server.noMoney'), 'error')
    end
end)