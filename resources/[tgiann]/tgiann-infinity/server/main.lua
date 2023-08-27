-- this is the main update thread for pushing blip location updates to players
CreateThread(function()
    while true do
        Wait(300)
        local players = GetPlayers()
        local blips = {}
        for index, player in ipairs(players) do
            local playerPed = GetPlayerPed(player)
            if DoesEntityExist(playerPed) then
                local coords = GetEntityCoords(playerPed)
                blips[tostring(player)] = vector4(coords.x, coords.y, coords.z, GetEntityHeading(playerPed))

                --serverId = player, --
                --networkId = NetworkGetNetworkIdFromEntity(playerPed),
                --coords = vector3(coords.x, coords.y, coords.z), --
                --name = GetPlayerName(player), --
                --ped = playerPed --
            end
        end
        TriggerClientEvent("tgiann-infinity:update", -1, blips)
    end
end)