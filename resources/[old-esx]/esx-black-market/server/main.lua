QBCore = nil
TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)

QBCore.Functions.CreateCallback('blackmarket:getAllShipments', function(source, cb)
    local src = source
    local xPlayer = QBCore.Functions.GetPlayer(src)
    exports.oxmysql:execute('SELECT * FROM black_shipments WHERE identifier = @identifier', {
        ['@identifier'] = xPlayer.PlayerData.citizenid,
    }, function(result)
        cb(result)
    end)
end)

QBCore.Functions.CreateCallback('blackmarket:getTime', function(source, cb)
    cb(os.time())
end)

QBCore.Functions.CreateCallback('blackmarket:getOwnedShop', function(source, cb)
    local src = source
    local xPlayer = QBCore.Functions.GetPlayer(src)

    exports.oxmysql:execute('SELECT * FROM users WHERE citizenid = @citizenid',{
        ['@citizenid'] = xPlayer.PlayerData.citizenid,
    }, function(result)
        if result[1] then
            cb(result)
        else
            cb(nil)
        end
    end)
end)

QBCore.Functions.CreateCallback('blackmarkets:GetAllItems', function(source, cb)
    local src = source
    local xPlayer = QBCore.Functions.GetPlayer(src)

    exports.oxmysql:execute('SELECT * FROM black_shipments WHERE identifier = @identifier',{
        ['@identifier'] = xPlayer.PlayerData.citizenid
    }, function(result)
        exports.oxmysql:execute('DELETE FROM black_shipments WHERE identifier = @identifier',{
            ['@identifier'] = xPlayer.PlayerData.citizenid
        })
        if math.random(1,100) <= 75 then 
            local alinanEsyalar = "Items Bought: "
            for i=1, #result, 1 do
                if string.match(result[i].item, "weapon") then
                    for x=1, result[i].count do
                        if xPlayer.Functions.AddItem(result[i].item, 1) then
                            alinanEsyalar = (alinanEsyalar .. ", " .. result[i].label .. " " .. 1 .. "x ")
                        else
                            TriggerClientEvent("QBCore:Notify", xPlayer.PlayerData.source, 'Because youre too heavy '.. result[i].label .. " your stuff got burned")    
                            alinanEsyalar = (alinanEsyalar .. ", " .. result[i].label .. " " .. 1 .. "x (Too Heavy)")
                        end
                    end
                else
                    if xPlayer.Functions.AddItem(result[i].item, result[i].count) then
                        alinanEsyalar = (alinanEsyalar .. ", " .. result[i].label .. " " .. result[i].count .. "x ")
                    else
                        TriggerClientEvent("QBCore:Notify", xPlayer.PlayerData.source, 'Because youre too heavy '.. result[i].label .. " your stuff got burned")    
                        alinanEsyalar = (alinanEsyalar .. ", " .. result[i].label .. " " .. result[i].count .. "x (Too Heavy)")
                    end
                end
            end
            TriggerEvent('DiscordBot:ToDiscord', 'black', 'Black Market eşya aldı: '..alinanEsyalar, src)
            cb(true)
         else
            TriggerClientEvent("QBCore:Notify", xPlayer.PlayerData.source, 'Convoy Raided It Was In Your Orders! No Refunds!')    
            cb(false) 
        end
    end)
end)

RegisterServerEvent('blackmarket:MakeShipment')
AddEventHandler('blackmarket:MakeShipment', function(item, price, count, label)
    local src = source
    local xPlayer = QBCore.Functions.GetPlayer(src)
    if item == "weapon_heavypistol" then
        silinecekamk = "heavypistolkalip"
    elseif item == "weapon_minismg" then
        silinecekamk = "skarpionkalip"
    else
        silinecekamk = "yokamk"
    end
    if silinecekamk == "yokamk" then
        if xPlayer.Functions.RemoveMoney('cash', price) then
            exports.oxmysql:execute('INSERT INTO black_shipments (label, identifier, item, price, count, time) VALUES (@label, @identifier, @item, @price, @count, @time)',{
                ['@label'] = label,
                ['@identifier'] = xPlayer.PlayerData.citizenid,
                ['@item'] = item,
                ['@price'] = price,
                ['@count'] = count,
                ['@time'] = os.time()
            })
            TriggerClientEvent("QBCore:Notify", xPlayer.PlayerData.source,  price .. "$ by paying " .. count .. " Piece " .. label .. " was ordered!")    	
        else
            TriggerClientEvent("QBCore:Notify", xPlayer.PlayerData.source, 'You Dont Have Enough Money!')	
        end
    else
        if xPlayer.Functions.RemoveItem(silinecekamk, 1) then
            if xPlayer.Functions.RemoveMoney('cash', price) then
                exports.oxmysql:execute('INSERT INTO black_shipments (label, identifier, item, price, count, time) VALUES (@label, @identifier, @item, @price, @count, @time)',{
                    ['@label'] = label,
                    ['@identifier'] = xPlayer.PlayerData.citizenid,
                    ['@item'] = item,
                    ['@price'] = price,
                    ['@count'] = count,
                    ['@time'] = os.time()
                })
                TriggerClientEvent("QBCore:Notify", xPlayer.PlayerData.source,  price .. "$ by paying " .. count .. " Piece " .. label .. " You placed the order!")    	
            else
                xPlayer.Functions.AddItem(silinecekamk, 1)
                TriggerClientEvent("QBCore:Notify", xPlayer.PlayerData.source, 'You Dont Have Enough Money!')	
            end
        else
            TriggerClientEvent("QBCore:Notify", xPlayer.PlayerData.source, 'No required parts!', "error")	
        end
    end
end)