QBCore = nil
Dispatchs = {}

TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)

QBCore.Functions.CreateCallback('jtDispatch:get-dispatchs', function(source, cb)
    cb(Dispatchs)
end)

QBCore.Functions.CreateCallback('jtDispatch:set-radio-code', function(source, cb, code)
    player = QBCore.Functions.GetPlayer(source)

    exports.oxmysql:execute("SELECT * FROM players WHERE `metadata` LIKE '%"..code.."%'", {
    }, function(result)
        if result[1] == nil then
            player.Functions.SetMetaData("radiocode", code)
            cb(true)
        else
            cb(false)
        end
    end)
end)

local ihbarid = 100

RegisterServerEvent("jtDispatch:add-notification")
AddEventHandler("jtDispatch:add-notification", function(data, job)
    local src = source
    players = QBCore.Functions.GetPlayers()
    ihbarid = ihbarid + 1
    data.ihbarid =  ihbarid
    if data.code == "0" then
        data.code = "KOD 0"
    elseif data.code == "99" then
        data.code = "KOD 99"
    elseif data.code == "66" then
        data.code = "KOD 66"
    elseif data.code == "50" then
        data.code = "KOD 50"
    elseif data.code == "1" then
        data.code = "KOD 1"
    elseif data.code == "2" then
        data.code = "KOD 2"
    elseif data.code == "3" then
        data.code = "KOD 3"
    elseif data.code == 911 then
        data.code = "911"
    elseif data.code == 311 then
        data.code = "311"
    else
        data.code = "10-32"
    end
    local arac = GetVehiclePedIsIn(GetPlayerPed(src),false)
    if arac ~= 0 or data.vehicleModel then
        if math.random(1, 100) >= 50 then 
            data.plate = data.plate or GetVehicleNumberPlateText(arac)
        else
            data.plate = "Bilinmiyor"
        end
        local aracModel = data.vehicleModel or GetEntityModel(arac)
        for k,v in pairs(QBCore.Shared.Vehicles) do
            for key,value in pairs(v) do
                if value.hash == aracModel then
                    data.vehicle = value.name
                    break
                end
            end
            if data.vehicle then 
                break
            end 
        end
        if not data.vehicle then 
            for k,v in pairs(exports["rn-vehicleshop"]:araclar()) do
                for key,value in pairs(v.buttons) do
                    if value.hash == aracModel then
                        data.vehicle = value.name
                        break
                    end
                end
                if data.vehicle then 
                    break
                end 
            end
            if not data.vehicle then 
                data.vehicle = "Unknown" 
            end
        end
    end
    if job == nil or job == "all" then
        TriggerClientEvent("jtDispatch:send-notification", -1, data)
    end

   

    for k,v in pairs(players) do
        player = QBCore.Functions.GetPlayer(v)
        if player.PlayerData.job.name == job or player.PlayerData.job.name == 'police' then
            TriggerClientEvent("jtDispatch:send-notification", v, data)
            if data.sprite == nil then data.sprite = 433 end
            TriggerClientEvent("jtDispatchAddBlip", v, data.coords.x, data.coords.y, data.sprite, data.description, arac, plaka, renk, cinsiyet, os.date("%H:%M"))
        end
    end
end)

RegisterServerEvent("jtDispatch:add-dispatch")
AddEventHandler("jtDispatch:add-dispatch", function(data, refresh)
    table.insert(Dispatchs, data)

    if refresh then
        TriggerClientEvent("jtDispatch:refresh-dispatchs", Dispatchs)
    end
end)

RegisterServerEvent("jtDispatch:add-active-units")
AddEventHandler("jtDispatch:add-active-units", function(data)
    TriggerClientEvent("jtDispatch:add-active-units", -1, data)
end)

RegisterServerEvent("jtDispatch:remove-active-units")
AddEventHandler("jtDispatch:remove-active-units", function(data)
    TriggerClientEvent("jtDispatch:remove-active-units", -1, data)
end)