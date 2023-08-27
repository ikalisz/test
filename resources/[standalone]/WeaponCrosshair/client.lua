
QBCore = nil 
PlayerData = {}
Citizen.CreateThread(function()
    while QBCore == nil do
		TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)
        Citizen.Wait(0)
    end
    while QBCore.Functions.GetPlayerData().job == nil do
        Citizen.Wait(10)
    end
    PlayerData = QBCore.Functions.GetPlayerData()
end)


local crosshair = true

local crosshair2 = false

Citizen.CreateThread(function()
    while true do
        local time = 1500
        HideHudComponentThisFrame(14)
        local playerPed = PlayerPedId()
        if IsPedArmed(playerPed, 6) then
            time = 5
            DisableControlAction(1, 141, true)
            DisableControlAction(1, 142, true)
            if crosshair then
                time = 5
                if IsPlayerFreeAiming(PlayerId()) then
                    time = 5
                    if not crosshair2 then
                        time = 5
                        crosshair2 = true
                        SendNUIMessage({ show = true })
                    end
                elseif GetPedConfigFlag(playerPed, 78, true) then
                    time = 5
                    if not crosshair2 then
                        time = 5
                        crosshair2 = true
                        SendNUIMessage({ show = true })
                    end
                else
                    if crosshair2 then
                        time = 5
                        crosshair2 = false
                        SendNUIMessage({ show = false })
                    end
                end
            end
        else
            if crosshair then
                time = 5
                if crosshair2 then
                    time = 5
                    crosshair2 = false
                    SendNUIMessage({ show = false })
                end
            end
        end
        Wait(time)
    end
end)

