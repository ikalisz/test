local QBCore = exports['qb-core']:GetCoreObject()

SpectateData = {}

-- [ Code ] --

-- [ Commands ] --



QBCore.Commands.Add('godmenu', 'Open Admin menu', {}, false, function(source)
    TriggerClientEvent('mc-admin/client/try-open-menu', source,  true)
end, 'admin')

-- Console

RegisterCommand('AdminPanelKick', function(source, args, rawCommand)
    if source == 0 then
        local ServerId = tonumber(args[1])
        table.remove(args, 1)
        local Msg = table.concat(args, " ")
        DropPlayer(ServerId, "\n🛑 You got kicked from the server! \nReason: "..Msg)
    end
end, false)

RegisterCommand('AdminPanelAddItem', function(source, args, rawCommand)
    if source == 0 then
        local ServerId, ItemName, ItemAmount = tonumber(args[1]), tostring(args[2]), tonumber(args[3])
        local Player = QBCore.Functions.GetPlayer(ServerId)
        if Player ~= nil then
            Player.Functions.AddItem(ItemName, ItemAmount, false, false)
        end
    end
end, false)

RegisterCommand('AdminPanelAddMoney', function(source, args, rawCommand)
    if source == 0 then
        local ServerId, Amount = tonumber(args[1]), tonumber(args[2])
        local Player = QBCore.Functions.GetPlayer(ServerId)
        if Player ~= nil then
            Player.Functions.AddMoney('cash', Amount)
        end
    end
end, false)

RegisterCommand('AdminPanelSetJob', function(source, args, rawCommand)
    if source == 0 then
        local ServerId, JobName, Grade = tonumber(args[1]), tostring(args[2]), tonumber(args[3])
        local Player = QBCore.Functions.GetPlayer(ServerId)
        if Player ~= nil then
            Player.Functions.SetJob(JobName, Grade)
        end
    end
end, false)

RegisterCommand('AdminPanelRevive', function(source, args, rawCommand)
    if source == 0 then
        local ServerId = tonumber(args[1])
        TriggerClientEvent('hospital:client:Revive', ServerId, true)
    end
end, false)

-- [ Callbacks ] --

QBCore.Functions.CreateCallback('mc-adminmenu/server/get-permission', function(source, cb)
    if AdminCheck(source) then
        cb(true)
    else
        cb(false)
    end
end)

QBCore.Functions.CreateCallback('mc-admin/server/get-active-players-in-radius', function(Source, Cb, Coords, Radius)
	local Coords, Radius = Coords ~= nil and vector3(Coords.x, Coords.y, Coords.z) or GetEntityCoords(GetPlayerPed(Source)), Radius ~= nil and Radius or 5.0
    local ActivePlayers = {}
	for k, v in pairs(QBCore.Functions.GetPlayers()) do
        local TargetCoords = GetEntityCoords(GetPlayerPed(v))
        local TargetDistance = #(TargetCoords - Coords)
        if TargetDistance <= Radius then
            local ReturnData = {
                ['ServerId'] = v,
                ['Name'] = GetPlayerName(v)
            }
            table.insert(ActivePlayers, ReturnData)
        end
	end
	Cb(ActivePlayers)
end)
 
 QBCore.Functions.CreateCallback('mc-admin/server/get-players', function(source, Cb)
    local PlayerList = {}
    for k, v in pairs(QBCore.Functions.GetPlayers()) do
        local NewPlayer = {
            ServerId = v,
            Name = GetPlayerName(v),
            Steam = QBCore.Functions.GetIdentifier(v, "steam"),
            License = QBCore.Functions.GetIdentifier(v, "license")
        }
        table.insert(PlayerList, NewPlayer)
    end
    Cb(PlayerList)
 end)

 QBCore.Functions.CreateCallback('mc-admin/server/get-player-data', function(source, Cb, License)
    for LicenseId, _ in pairs(License) do
        local TPlayer = QBCore.Functions.GetPlayerIdentifiers(LicenseId)
        local PlayerCharInfo = {
            Name = TPlayer.PlayerData.name,
            Steam = QBCore.Functions.GetIdentifier(TPlayer.PlayerData.source, "steam"),
            CharName = TPlayer.PlayerData.charinfo.firstname..' '..TPlayer.PlayerData.charinfo.lastname,
            Source = TPlayer.PlayerData.source,
            CitizenId = TPlayer.PlayerData.citizenid
        }
        Cb(PlayerCharInfo)
    end
end)

--  [ Functions ] --

function AdminCheck(ServerId)
    local Player = QBCore.Functions.GetPlayer(ServerId)
    local Promise = promise:new()
    if Player ~= nil then
        if QBCore.Functions.HasPermission(ServerId, "admin") then
            Promise:resolve(true)
        else
            Promise:resolve(false)
        end
    end
    return Promise
end


function GetBanTime(Expires)
    local Time = os.time()
    local Expiring = nil
    local ExpireDate = nil
    if Expires == '1 Hour' then
        Expiring = os.date("*t", Time + 3600)
        ExpireDate = tonumber(Time + 3600)
    elseif Expires == '6 Hours' then
        Expiring = os.date("*t", Time + 21600)
        ExpireDate = tonumber(Time + 21600)
    elseif Expires == '12 Hours' then
        Expiring = os.date("*t", Time + 43200)
        ExpireDate = tonumber(Time + 43200)
    elseif Expires == '1 Day' then
        Expiring = os.date("*t", Time + 86400)
        ExpireDate = tonumber(Time + 86400)
    elseif Expires == '3 Days' then
        Expiring = os.date("*t", Time + 259200)
        ExpireDate = tonumber(Time + 259200)
    elseif Expires == '1 Week' then
        Expiring = os.date("*t", Time + 604800)
        ExpireDate = tonumber(Time + 604800)
    elseif Expires == 'Permanent' then
        Expiring = os.date("*t", Time + 315360000) -- 10 Years
        ExpireDate = tonumber(Time + 315360000)
    end
    return Expiring, ExpireData
end

-- [ Events ] --

-- User Actions

RegisterNetEvent("mc-admin/server/ban-player", function(ServerId, Expires, Reason)
    local src = source
    if not AdminCheck(src) then return end

    local Expiring, ExpireDate = GetBanTime(Expires)
    exports.oxmysql:execute('INSERT INTO bans (name, license, discord, ip, reason, expire, bannedby) VALUES (?, ?, ?, ?, ?, ?, ?)', {
        GetPlayerName(ServerId),
        QBCore.Functions.GetIdentifier(ServerId, 'license'),
        QBCore.Functions.GetIdentifier(ServerId, 'discord'),
        QBCore.Functions.GetIdentifier(ServerId, 'ip'),
        Reason,
        ExpireDate,
        GetPlayerName(src)
    })
    local ExpireHours = tonumber(Expiring['hour']) < 10 and "0"..Expiring['hour'] or Expiring['hour']
    local ExpireMinutes = tonumber(Expiring['min']) < 10 and "0"..Expiring['min'] or Expiring['min']
    if Expires == "Permanent" then
        DropPlayer(ServerId, '\n🔰 You are permanently banned.'..'\n🛑 Reason:'..Reason)
    else
        DropPlayer(ServerId, '\n🔰 You are banned.' .. '\n🛑 Reason: ' .. Reason .. "\n\n⏰Ban expires on " .. Expiring['day'] .. '/' .. Expiring['month'] .. '/' .. Expiring['year'] .. ' '..ExpireHours..':'..ExpireMinutes..'.')
    end
    TriggerClientEvent('torpak:notify', src, 'The player was successfully banned '..GetPlayerName(ServerId)..' for '..Reason, 'success')
end)

RegisterNetEvent("mc-admin/server/kick-player", function(ServerId, Reason)
    local src = source
    if not AdminCheck(src) then return end

    DropPlayer(ServerId, Reason)
    TriggerClientEvent('torpak:notify', src, 'The player was successfully thrown out!', 'success')
end)

RegisterNetEvent("mc-admin/server/give-item", function(ServerId, ItemName, ItemAmount)
    local src = source
    if not AdminCheck(src) then return end

    local TPlayer = QBCore.Functions.GetPlayer(ServerId)
    TPlayer.Functions.AddItem(ItemName, ItemAmount, 'Admin-Menu-Give')
    TriggerClientEvent('torpak:notify', src, 'Given to the player :'..ItemAmount..' of '..ItemName..'.', 'success')
end)

RegisterNetEvent("mc-admin/server/request-job", function(ServerId, JobName)
    local src = source
    if not AdminCheck(src) then return end

    local TPlayer = QBCore.Functions.GetPlayer(ServerId)
    TPlayer.Functions.SetJob(JobName, 1, 'Admin-Menu-Give-Job')
    TriggerClientEvent('torpak:notify', src, 'JOB was given to the player :'..JobName..'.', 'success')
end)

RegisterNetEvent('mc-admin/server/start-spectate', function(ServerId)
    local src = source
    if not AdminCheck(src) then return end

    -- Check if Person exists
    local Target = GetPlayerPed(ServerId)
    if not Target then
        return TriggerClientEvent('torpak:notify', src, 'The player not found, the spectate process ended', 'error')
    end

    -- Make Check for Spectating
    local SteamIdentifier = QBCore.Functions.GetIdentifier(src, "steam")
    if SpectateData[SteamIdentifier] ~= nil then
        SpectateData[SteamIdentifier]['Spectating'] = true
    else
        SpectateData[SteamIdentifier] = {}
        SpectateData[SteamIdentifier]['Spectating'] = true
    end

    local tgtCoords = GetEntityCoords(Target)
    TriggerClientEvent('QBCore/client/specPlayer', src, ServerId, tgtCoords)
end)

RegisterNetEvent('mc-admin/server/stop-spectate', function()
    local src = source
    if not AdminCheck(src) then return end

    local SteamIdentifier = QBCore.Functions.GetIdentifier(src, "steam")
    if SpectateData[SteamIdentifier] ~= nil and SpectateData[SteamIdentifier]['Spectating'] then
        SpectateData[SteamIdentifier]['Spectating'] = false
    end
end)

RegisterNetEvent("mc-admin/server/drunk", function(ServerId)
    local src = source
    if not AdminCheck(src) then return end

    TriggerClientEvent('mc-admin/client/drunk', ServerId)
end)

RegisterNetEvent("mc-admin/server/animal-attack", function(ServerId)
    local src = source
    if not AdminCheck(src) then return end

    TriggerClientEvent('mc-admin/client/animal-attack', ServerId)
end)

RegisterNetEvent("mc-admin/server/set-fire", function(ServerId)
    local src = source
    if not AdminCheck(src) then return end

    TriggerClientEvent('mc-admin/client/set-fire', ServerId)
end)

RegisterNetEvent("mc-admin/server/fling-player", function(ServerId)
    local src = source
    if not AdminCheck(src) then return end

    TriggerClientEvent('mc-admin/client/fling-player', ServerId)
end)

RegisterNetEvent("mc-admin/server/play-sound", function(ServerId, SoundId)
    local src = source
    if not AdminCheck(src) then return end

    TriggerClientEvent('mc-admin/client/play-sound', ServerId, SoundId)
end)

-- Utility Actions

RegisterNetEvent("mc-admin/server/toggle-blips", function()
    local src = source
    if not AdminCheck(src) then return end

    local BlipData = {}
    for k, v in pairs(QBCore.Functions.GetPlayers()) do
        local NewPlayer = {
            ServerId = v,
            Name = GetPlayerName(v),
            Coords = GetEntityCoords(GetPlayerPed(v)),
        }
        table.insert(BlipData, NewPlayer)
    end
    TriggerClientEvent('mc-admin/client/UpdatePlayerBlips', -1, BlipData)
end)


RegisterNetEvent("mc-admin/server/teleport-player", function(ServerId, Type)
    local src = source
    if not AdminCheck(src) then return end

    local Msg = ""
    if Type == 'Goto' then
        Msg = 'teleported to'
        local TCoords = GetEntityCoords(GetPlayerPed(ServerId))
        TriggerClientEvent('mc-admin/client/teleport-player', src, TCoords)
    elseif Type == 'Bring' then
        Msg = 'brought'
        local Coords = GetEntityCoords(GetPlayerPed(src))
        TriggerClientEvent('mc-admin/client/teleport-player', ServerId, Coords)
    end
    TriggerClientEvent('torpak:notify', src, 'Teleport Successfull '..Msg..'', 'success')
end)

RegisterNetEvent("mc-admin/server/chat-say", function(Message)
    TriggerClientEvent('chat:addMessage', -1, {
        template = "<div class=chat-message server'><strong>Announcement | </strong> {0}</div>",
        args = {Message}
    })
end)

-- Player Actions

RegisterNetEvent("mc-admin/server/toggle-godmode", function(ServerId)
    TriggerClientEvent('mc-admin/client/toggle-godmode', ServerId)
end)

RegisterNetEvent("mc-admin/server/set-food-drink", function(ServerId)
    local src = source
    if not AdminCheck(src) then return end

    local TPlayer = QBCore.Functions.GetPlayer(ServerId)
    if TPlayer ~= nil then
        TPlayer.Functions.SetMetaData('thirst', 100)
        TPlayer.Functions.SetMetaData('hunger', 100)
        TriggerClientEvent('hud:client:UpdateNeeds', ServerId, 100, 100)
        TPlayer.Functions.Save();
        TriggerClientEvent('torpak:notify', src, 'The players food and beverage requirements were full.', 'success')
    end
end)

RegisterNetEvent("mc-admin/server/remove-stress", function(ServerId)
    local src = source
    if not AdminCheck(src) then return end

    local TPlayer = QBCore.Functions.GetPlayer(ServerId)
    if TPlayer ~= nil then
        TPlayer.Functions.SetMetaData('stress', 0)
        TPlayer.Functions.Save();
        TriggerClientEvent('torpak:notify', src, 'Stress level downloaded.', 'success')
    end
end)

RegisterNetEvent("mc-admin/server/set-armor", function(ServerId)
    local src = source
    if not AdminCheck(src) then return end

    local TPlayer = QBCore.Functions.GetPlayer(ServerId)
    if TPlayer ~= nil then
        SetPedArmour(GetPlayerPed(ServerId), 100)
        TPlayer.Functions.SetMetaData('armor', 100)
        TPlayer.Functions.Save();
        TriggerClientEvent('torpak:notify', src, 'The player was given armor', 'success')
    end
end)

RegisterNetEvent("mc-admin/server/reset-skin", function(ServerId)
    local src = source
    if not AdminCheck(src) then return end

    local TPlayer = QBCore.Functions.GetPlayer(ServerId)
    local ClothingData = exports.oxmysql:execute('SELECT * FROM playerskins WHERE citizenid = ? AND active = ?', { TPlayer.PlayerData.citizenid, 1 })
    if ClothingData[1] ~= nil then
        TriggerClientEvent("qb-clothes:loadSkin", ServerId, false, ClothingData[1].model, ClothingData[1].skin)
    else
        TriggerClientEvent("qb-clothes:loadSkin", ServerId, true)
    end
end)

RegisterNetEvent("mc-admin/server/set-model", function(ServerId, Model)
    local src = source
    if not AdminCheck(src) then return end

    TriggerClientEvent('mc-admin/client/set-model', ServerId, Model)
end)

RegisterNetEvent("mc-admin/server/revive-in-distance", function()
    local src = source
    if not AdminCheck(src) then return end

    local Coords, Radius = GetEntityCoords(GetPlayerPed(src)), 5.0
	for k, v in pairs(QBCore.Functions.GetPlayers()) do
		local Player = QBCore.Functions.GetPlayer(v)
		if Player ~= nil then
			local TargetCoords = GetEntityCoords(GetPlayerPed(v))
			local TargetDistance = #(TargetCoords - Coords)
			if TargetDistance <= Radius then
                TriggerClientEvent('hospital:client:Revive', v, true)
			end
		end
	end
end)

RegisterNetEvent("mc-admin/server/revive-target", function(ServerId)
    local src = source
    if not AdminCheck(src) then return end

    TriggerClientEvent('hospital:client:Revive', ServerId, true)
    TriggerClientEvent('torpak:notify', src, "The player successfully revive", 'success')
end)

RegisterNetEvent("mc-admin/server/open-clothing", function(ServerId)
    local src = source
    if not AdminCheck(src) then return end

    TriggerClientEvent('qb-clothing:client:openMenu', ServerId)
    TriggerClientEvent('torpak:notify', src, 'The player was successfully given a ped menu!.', 'success')
end)

