

QBCore = nil
local onlinePlayers = {}
Citizen.CreateThread(function()
    while QBCore == nil do
        TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)
        Citizen.Wait(200)
    end
end)

-- RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    PlayerData = QBCore.Functions.GetPlayerData()
    TriggerServerEvent("disc-showid:add-id")
end)

RegisterCommand("idloaded", function()
    PlayerData = QBCore.Functions.GetPlayerData()
    TriggerServerEvent("disc-showid:add-id")
end, true)

RegisterNetEvent('disc-showid:client:add-id')
AddEventHandler('disc-showid:client:add-id', function(identifier, playerSource)
    if playerSource then
        onlinePlayers[playerSource] = identifier
    else
        onlinePlayers = identifier
    end
end)

local forceDraw = false
local shouldDraw = false
local shouldOpenMenu = false
local admin = false
RegisterNetEvent('disc-showid:client:admin')
AddEventHandler('disc-showid:client:admin', function(bool)
    admin = bool
    forceDraw = bool
end)

RegisterNetEvent('disc-showid:id')
AddEventHandler('disc-showid:id', function()
    if not admin then
        forceDraw = not forceDraw
        Citizen.Wait(5000)
        forceDraw = false
    end
end)

RegisterNetEvent('disc-showid:kapat')
AddEventHandler('disc-showid:kapat', function()
    if not admin then
        forceDraw = false
    end
end)

RegisterNetEvent('idgosterla')
AddEventHandler('idgosterla', function()
    forceDraw = true 
    TriggerEvent("idgostermenlazim")
end)


RegisterNetEvent('idkapatla')
AddEventHandler('idkapatla', function()
    forceDraw = false
end)

--Draw Things
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
    
        if IsControlPressed(0, 121) or forceDraw then
            local playerPed = PlayerPedId()
            if IsPedArmed(playerPed, 4) == 1 then
                QBCore.Functions.Notify("You can't look for an id with a gun bro.", "error")
                Citizen.Wait(1000)
            else
                for k, v in pairs(GetNeareastPlayers()) do
                    local x, y, z = table.unpack(v.coords)
                    Draw3DText(x, y, z + 1.0, v.playerId, 1.6)
                    Draw3DText(x, y, z + 1.16,  v.cid, 1.6)
                end
            end
        end
    end
end)


function Draw3DText(x, y, z, text, newScale)
    -- Check if coords are visible and get 2D screen coords
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    if onScreen then
        -- Calculate text scale to use
        local dist = GetDistanceBetweenCoords(GetGameplayCamCoords(), x, y, z, 1)
        local scale = newScale * (0.6 / dist) * (1 / GetGameplayCamFov()) * 150

        -- Draw text on screen
        SetTextScale(scale, scale)
        SetTextFont(4)
        SetTextProportional(1)
        SetTextColour(255, 255, 255, 255)
        SetTextDropShadow(0, 0, 0, 0, 255)
        SetTextDropShadow()
        SetTextEdge(4, 0, 0, 0, 255)
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x, _y)
    end
end

function GetNeareastPlayers()
    local playerPed = PlayerPedId()
    local players_clean = {}
    if IsPedInAnyVehicle(PlayerPedId(), false) then
        local playersId = tostring(GetPlayerServerId(PlayerId()))
        table.insert(players_clean, {cid = onlinePlayers[playersId], playerId = playersId, coords = GetEntityCoords(playerPed)} )
    else
        local distance = 4
        if admin then distance = 40 end
        local players, _ = QBCore.Functions.GetPlayersInArea(GetEntityCoords(playerPed), distance)
        for i = 1, #players, 1 do
            local player = GetPlayerFromServerId(GetPlayerServerId(players[i]))
            local ped = GetPlayerPed(player)
            local model = GetEntityModel(ped)
            if IsEntityVisible(ped) then
                for x, identifier in pairs(onlinePlayers) do 
                    if x == tostring(GetPlayerServerId(players[i])) then
                        table.insert(players_clean, {cid = identifier:upper(), playerId = GetPlayerServerId(players[i]), coords = GetEntityCoords(GetPlayerPed(players[i])) })
                    end
                end
            end
        end
    end
   
    return players_clean
end


RegisterCommand('id', function()
    TriggerServerEvent("idbakla")
    if not forceDraw then
        forceDraw = not forceDraw
        Citizen.Wait(10000)
        forceDraw = false
    end
end)

RegisterNetEvent("idgostermenlazim", function()
    TriggerServerEvent("idbakla")
end)