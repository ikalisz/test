QBCore = nil
TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)

QBCore.Functions.CreateCallback('tgiann-ikinciel:player-car', function(source, cb)
    local src = source
    local xPlayer = QBCore.Functions.GetPlayer(src)
    if xPlayer then
        exports.oxmysql:execute("SELECT * FROM owned_vehicles WHERE citizenid = @citizenid AND ikinciel = 0 AND type = @type", {
            ['@citizenid'] = xPlayer.PlayerData.citizenid,
            ["@type"] = "car"
        }, function(result)
            if result[1] then
                cb(result)
            else
                cb(nil)
            end
        end)
    end
end)

QBCore.Functions.CreateCallback('tgiann-ikinciel:car-list', function(source, cb)
    exports.oxmysql:execute("SELECT * FROM tgiann_ikinciel", {
    }, function(result)
        if result[1] then
            cb(result)
        else
            cb(nil)
        end
    end)
end)

QBCore.Functions.CreateCallback('tgiann-ikinciel:my-sell-car', function(source, cb)
    local src = source
    local xPlayer = QBCore.Functions.GetPlayer(src)
    if xPlayer then
        exports.oxmysql:execute("SELECT * FROM tgiann_ikinciel WHERE citizenid = @citizenid", {
            ["@citizenid"] = xPlayer.PlayerData.citizenid
        }, function(result)
            if result[1] then
                cb(result)
            else
                cb(nil)
            end
        end)
    end
end)

RegisterServerEvent('tgiann-ikinciel:delete-list')
AddEventHandler('tgiann-ikinciel:delete-list', function(plate)
    local src = source
    local xPlayer = QBCore.Functions.GetPlayer(src)
    if xPlayer then
        exports.oxmysql:scalar("DELETE FROM tgiann_ikinciel WHERE plate = @plate", {
            ['@plate'] = plate
        }, function()
            exports.oxmysql:execute("UPDATE owned_vehicles SET ikinciel = 0 WHERE plate = @plate", {
                ['@plate'] = plate,
            })
            TriggerClientEvent("QBCore:Notify", xPlayer.PlayerData.source, "Vehicle has been discontinued")
        end)
    end
end)

RegisterServerEvent('tgiann-ikinciel:sell-car')
AddEventHandler('tgiann-ikinciel:sell-car', function(sellPrice, plate, prop)
    local src = source
    local xPlayer = QBCore.Functions.GetPlayer(src)
    if xPlayer then
        exports.oxmysql:scalar("INSERT INTO tgiann_ikinciel (citizenid, plate, prop, price) VALUES (@citizenid, @plate, @prop, @price)", {
            ["citizenid"] = xPlayer.PlayerData.citizenid,
            ["plate"] = plate, 
            ["prop"] = prop,
            ["price"] = sellPrice
        })
        exports.oxmysql:execute("UPDATE owned_vehicles SET ikinciel = 1 WHERE plate = @plate", {
            ['@plate'] = plate,
        })
        TriggerClientEvent("QBCore:Notify", xPlayer.PlayerData.source, "The vehicle has been added to the for sale list")
    end
end)

RegisterServerEvent('tgiann-ikinciel:buy-car')
AddEventHandler('tgiann-ikinciel:buy-car', function(plate, price, citizenid)
    local src = source
    local xPlayer = QBCore.Functions.GetPlayer(src)
    local tPlayer = QBCore.Functions.GetPlayerByCitizenId(citizenid)
    if xPlayer then
        if xPlayer.Functions.RemoveMoney('bank', price) then
            exports.oxmysql:scalar("DELETE FROM tgiann_ikinciel WHERE plate = @plate", {
                ['@plate'] = plate
            }, function(result)
                exports.oxmysql:execute("UPDATE owned_vehicles SET ikinciel = 0, citizenid = @citizenid WHERE plate = @plate", {
                    ['@plate'] = plate,
                    ['@citizenid'] = xPlayer.PlayerData.citizenid
                })
                TriggerClientEvent("QBCore:Notify", xPlayer.PlayerData.source, "Purchased vehicle for $" .. price .. "")
            end) 
            
            if tPlayer then
                tPlayer.Functions.AddMoney('bank', price)
                TriggerClientEvent("QBCore:Notify", tPlayer.PlayerData.source, plate .. " License Plate Vehicle $" .. price .." Sold in exchange")
                TriggerEvent('DiscordBot:ToDiscord', 'ikinciel', plate .." Bought the vehicle from used vehicle! " .. price .."$", src, tPlayer.PlayerData.source)
            else
                TriggerEvent('DiscordBot:ToDiscord', 'ikinciel', plate .." Bought the vehicle from used vehicle! Owner is not in the game(cid:"..citizenid..")" .. price .."$", src)
                exports.oxmysql:scalar("SELECT money FROM players WHERE citizenid = @citizenid", {
                    ["citizenid"] = citizenid
                }, function(result)
                    local data = json.decode(result)
                    data.bank = data.bank + price
                    exports.oxmysql:execute("UPDATE players SET money = @money WHERE citizenid = @citizenid", {
                        ['@citizenid'] = citizenid,
                        ['@money'] = json.encode(data)
                    })
                end)
            end

        else
            TriggerClientEvent("QBCore:Notify", xPlayer.PlayerData.source, "You Don't Have Enough Money", "error")
        end
    end
end)


--- İmport

QBCore.Functions.CreateCallback('tgiann-ikinciel:import-car', function(source, cb)
    exports.oxmysql:execute("SELECT * FROM tgiann_import", {
    }, function(result)
        cb(result)
    end)
end)

RegisterServerEvent('tgiann-ikinciel:buy-import')
AddEventHandler('tgiann-ikinciel:buy-import', function(carData, key)
    local src = source
    if QBCore.Functions.kickHacKer(src, key) then -- QBCore.Key
        local xPlayer = QBCore.Functions.GetPlayer(src)
        exports.oxmysql:execute("SELECT * FROM tgiann_import WHERE id = @id", {
            ["@id"] = carData.id
        }, function(result)
            if result[1].count > 0 then
                if xPlayer.Functions.RemoveMoney('bank', carData.price) then
                    exports.oxmysql:execute("UPDATE tgiann_import SET count = @count WHERE id = @id", {
                        ['@id'] = carData.id,
                        ['@count'] = carData.count - 1
                    })
                    TriggerClientEvent("tgiann-ikinciel:client:buy-import", src, carData.model, result[1].count)
                    TriggerEvent('DiscordBot:ToDiscord', 'import', carData.price .."$ in return " .. carData.model .. " bought!", src)
                else
                    TriggerClientEvent("QBCore:Notify", src, "You Don't Have Enough Money", "error")
                end
            else
                TriggerClientEvent("QBCore:Notify", src, "Out of Stock This Vehicle!", "error")
            end
        end)
    end
end)

RegisterServerEvent('tgiann-ikinciel:buy-import-car')
AddEventHandler('tgiann-ikinciel:buy-import-car', function(prop, count, key)
    local src = source
    if QBCore.Functions.kickHacKer(src, key) then -- QBCore.Key
        local xPlayer = QBCore.Functions.GetPlayer(src)
        exports.oxmysql:execute('INSERT INTO owned_vehicles (citizenid, plate, vehicle, type, stored) VALUES (@citizenid, @plate, @vehicle, @type, @stored)', {
            ['@citizenid'] = xPlayer.PlayerData.citizenid,
            ['@plate'] = prop.plate,
            ['@vehicle'] = json.encode(prop),
            ['@type'] = "car",
            ['@stored'] = 1,
        }, function()
            TriggerClientEvent("QBCore:Notify", xPlayer.PlayerData.source, 'Vehicle Purchased')
        end)
    end
end)