local PlayerData = {}

local zone = PolyZone:Create({
    vector2(157.13529968262, -1267.1528320312),
    vector2(160.1668548584, -1253.7159423828),
    vector2(174.1605682373, -1256.8126220703),
    vector2(171.18365478516, -1270.2531738281)
  }, {
    name="fightclub",
    minZ = 8.909282684326,
    maxZ = 13.043732643127
})

QBCore = nil
Citizen.CreateThread(function()
    while QBCore == nil do
        TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)
        Citizen.Wait(200)
    end
end)

AddEventHandler('tgiann:playerdead', function(dead)
    if dead then
        local playerCoords = GetEntityCoords(PlayerPedId())
        if zone:isPointInside(playerCoords) then
            QBCore.Functions.Notify("After 20 Seconds You Will Be Healed!", "primary", 10000)
            Citizen.Wait(20000)
            TriggerServerEvent("tgiann-fightclub:server:revive-players")
        end
    end
end)

RegisterNetEvent('tgiann-fightclub:client:revive-players')
AddEventHandler('tgiann-fightclub:client:revive-players', function(job)
    local playerCoords = GetEntityCoords(PlayerPedId())
    if zone:isPointInside(playerCoords) then
        TriggerEvent("esx_ambulancejob:revive")
        TriggerEvent("tgiann-stres:set-stres", 0)
    end
end)

Citizen.CreateThread(function()
   local blip = AddBlipForCoord(vector3(187.88835144043, -1273.2868652344, 29.198139190674))
   SetBlipSprite(blip, 378)
   SetBlipDisplay(blip, 2)
   SetBlipScale(blip, 0.5)
   SetBlipColour(blip, 1)
   SetBlipAsShortRange(blip, true)
   BeginTextCommandSetBlipName("STRING")
   AddTextComponentString("Underground Fight Club")
   EndTextCommandSetBlipName(blip)
end)