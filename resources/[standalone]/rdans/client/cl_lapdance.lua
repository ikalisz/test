local isInLapdance = false
local isThisTrue = false
local pedSpawn = vector3(116.52180480957, -1297.8509521484, 29.26935005188)

local alanlar = {
    {
        pressE = vector3(115.18124389648, -1304.4938964844, 28.892659759521),
        koltuk = vector3(115.40135955811, -1305.0166015625, 27.818408584595),
        dans = vector3(115.05450439453, -1304.4162597656, 28.292654037476)
    },
    {
        pressE = vector3(112.9259185791, -1300.8929443359, 28.892659759521),
        koltuk = vector3(112.85548400879, -1300.3359375, 27.818408584595),
        dans = vector3(113.01573944092, -1301.0103759766, 28.292654037476),
        h = 203.0
    },
}

QBCore = nil
coreLoaded = false
Citizen.CreateThread(function()
    while QBCore == nil do
        TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)
        Citizen.Wait(200)
    end
    coreLoaded = true
end)

local secilenAlan = 1
local cam = false
Citizen.CreateThread(function()
    while true do
        local time = 1000
        local coords = GetEntityCoords(PlayerPedId())
        for i=1, #alanlar do
            local pressECoords = alanlar[i].pressE
            local distance = #(coords - pressECoords)
            if distance < 3 and not isInLapdance and coreLoaded then
                time = 1
                local text = ""
                if distance < 0.6 then
                    text = "[E] "
                    if IsControlPressed(0, 38) then
                        secilenAlan = alanlar[i]
                        local closestPlayers = QBCore.Functions.GetPlayersFromCoords(secilenAlan.koltuk, 1)
                        if #closestPlayers == 0 then
                            TriggerServerEvent('esx_lapdance:Buy')
                        else
                            QBCore.Functions.Notify("Cabin Full!", "error") 
                        end
                        Citizen.Wait(3000)
                    end
                end
                QBCore.Functions.DrawText3D(pressECoords.x,pressECoords.y,pressECoords.z, text.."Lap Dance 500$")
            end
        end

        if #(vector3(114.0,-1301.0, 29.0) - coords) < 7 then
            time = 1
            DisableControlAction(2, 24, true) -- Attack
            DisableControlAction(2, 25, true) -- Aim
            DisableControlAction(2, 263, true) -- Melee Attack 1
            DisableControlAction(2, 36, true) -- Disable going stealth
            DisableControlAction(0, 47, true)  				-- Disable weapon
			DisableControlAction(0, 264, true) 				-- Disable melee
			DisableControlAction(0, 257, true) 				-- Disable melee
			DisableControlAction(0, 140, true) 				-- Disable melee
			DisableControlAction(0, 141, true) 				-- Disable melee
			DisableControlAction(0, 142, true) 				-- Disable melee
            DisableControlAction(0, 143, true) 				-- Disable melee
        end

        Citizen.Wait(time)
    end
end) 

local stripper = {
    695248020,
    1381498905,
    -521758348,
    -566941131,
    -1661836925,
    42647445,
    -1244692252,
    2014052797,
}

local pedAnim = false
RegisterNetEvent('esx_lapdance:lapdance')
AddEventHandler('esx_lapdance:lapdance', function()
    TriggerEvent("esx_lapdance:disableControl")
    local playerPed = PlayerPedId()
    local randomPed = math.random(1, #stripper)
    local model = stripper[randomPed]
    pedAnim = false
    RequestModel(model)
    while not HasModelLoaded(model) do
        Citizen.Wait(0)
    end
    local stripperPed = CreatePed(4, model, pedSpawn, 302.19, true, true)
    SetBlockingOfNonTemporaryEvents(stripperPed, true)
    TaskGoToCoordAnyMeans(stripperPed, secilenAlan.dans, 1.0, 0, 0, 0, 0xbf800000)
    TaskGoToCoordAnyMeans(playerPed, secilenAlan.koltuk, 1.0, 0, 0, 786603, 1.0)
    while #(GetEntityCoords(playerPed) - secilenAlan.koltuk) >= 2 do
        Citizen.Wait(1000)
    end
    FreezeEntityPosition(playerPed, true)
    SetEntityCoords(playerPed, secilenAlan.koltuk)
    SetEntityHeading(playerPed, secilenAlan.h or 28.27)
    playAnim(playerPed, "mini@strip_club@lap_dance_2g@ld_2g_reach", "ld_2g_sit_idle", 0)
    pedAnim = true
    while #(GetEntityCoords(stripperPed) - secilenAlan.dans) >= 1.5 do
        Citizen.Wait(1000)
    end
    Citizen.Wait(2500)
    cam = true
    FreezeEntityPosition(stripperPed, true)
    SetEntityHeading(stripperPed, 216.6)
    playAnim(stripperPed, "mini@strip_club@private_dance@part2", "priv_dance_p2", 50000)
    playAnim(stripperPed, "mini@strip_club@backroom@", "stripper_b_backroom_idle_b", 10000)
    FreezeEntityPosition(stripperPed, false)
    TaskGoToCoordAnyMeans(stripperPed, pedSpawn, 1.0, 0, 0, 0, 0xbf800000)
    cam = false
    Citizen.Wait(5000)
    pedAnim = false
    SetFollowPedCamViewMode(0)
    FreezeEntityPosition(playerPed, false)
    TaskGoToCoordAnyMeans(playerPed, secilenAlan.pressE, 1.0, 0, 0, 0, 0xbf800000)
    local count = 0
    while #(GetEntityCoords(stripperPed) - pedSpawn) >= 2 do
        count = count + 1
        Citizen.Wait(1000)
        if count > 10 then break end
    end
    TriggerServerEvent("lapdance:delete-ped", NetworkGetNetworkIdFromEntity(stripperPed))
    SetModelAsNoLongerNeeded(model)
    isInLapdance = false
end)

function playAnim(ped, animDictionary, animationName, time)
    QBCore.Shared.RequestAnimDict(animDictionary, function() -- animasyon oynatma
        TaskPlayAnim(ped, animDictionary, animationName, 2.0, 2.0, 50000000, 1, 0, false, false, false)
    end)
    Citizen.Wait(time)
end

RegisterNetEvent('lapdance:client:delete-ped')
AddEventHandler('lapdance:client:delete-ped', function(netID)
    local clientId = NetworkGetEntityFromNetworkId(netID)
    if DoesEntityExist(clientId) then
        DeletePed(clientId)
    end
end)
  
RegisterNetEvent('esx_lapdance:disableControl')
AddEventHandler('esx_lapdance:disableControl', function()
    isInLapdance = true
    while isInLapdance do
        Citizen.Wait(1)
        DisableAllControlActions(0)
        EnableControlAction(0, 1, true)
        EnableControlAction(0, 2, true)

        local playerPed = PlayerPedId()
        if pedAnim then
            if not IsEntityPlayingAnim(playerPed, '"mini@strip_club@lap_dance_2g@ld_2g_reach', '"ld_2g_sit_idle', 3) then
                playAnim(playerPed, "mini@strip_club@lap_dance_2g@ld_2g_reach", "ld_2g_sit_idle", 0)
            end
        end
        if cam then
            SetFollowPedCamViewMode(4)
        end
    end
end)

local PoleDance = { 
    vector3(108.81, -1289.05, 29.25),
    vector3(104.75, -1294.18, 29.25),
    vector3(102.28, -1289.85, 29.25)
}

local PoleClosestDoor = 0

exports("nightClubPole", function()
    for i=1, #PoleDance do
        if #(GetEntityCoords(PlayerPedId()) - PoleDance[i]) <= 1.0 then
            PoleClosestDoor = PoleDance[i]
            return true
        end
    end
    return false
end)

RegisterNetEvent('esx_lapdance:nightClubPoleDance')
AddEventHandler('esx_lapdance:nightClubPoleDance', function()
    local number = math.random(1,3)
    QBCore.Shared.RequestAnimDict('mini@strip_club@pole_dance@pole_dance' .. number, function()
        local scene = NetworkCreateSynchronisedScene(PoleClosestDoor, vector3(0.0, 0.0, 0.0), 2, false, false, 1065353216, 0, 1.3)
        NetworkAddPedToSynchronisedScene(PlayerPedId(), scene, 'mini@strip_club@pole_dance@pole_dance' .. number, 'pd_dance_0' .. number, 1.5, -4.0, 1, 1, 1148846080, 0)
        NetworkStartSynchronisedScene(scene)
        QBCore.Functions.Notify("Press [X] to Cancel", "primary", 10000) 
        while true do
            Citizen.Wait(0)
            DisableControlAction(0, 73, true)
            if IsDisabledControlJustReleased(0, 73) then
                ClearPedTasksImmediately(PlayerPedId())
                break
            end
        end
    end)
end)