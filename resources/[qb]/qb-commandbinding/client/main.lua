QBCore = nil

Citizen.CreateThread(function()
    while QBCore == nil do
        TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)
        Citizen.Wait(200)
    end
end)

local canPressButton = true
local keyPressed = false
local isLoggedIn = true
local HasNuiFocus = false

RegisterNetEvent("QBCore:Client:OnPlayerUnload")
AddEventHandler("QBCore:Client:OnPlayerUnload", function()
    isLoggedIn = false
end)

RegisterNetEvent("QBCore:Client:OnPlayerLoaded")
AddEventHandler("QBCore:Client:OnPlayerLoaded", function()
    isLoggedIn = true
end)

RegisterNetEvent("elixir-base:focus")
AddEventHandler("elixir-base:focus", function(focus)
    HasNuiFocus = focus
end)

function openBindingMenu()
    local PlayerData = QBCore.Functions.GetPlayerData()
    local keyMeta = PlayerData.metadata["commandbinds"]
    SendNUIMessage({
        action = "openBinding",
        keyData = keyMeta
    })
    SetNuiFocus(true, true)
end

function closeBindingMenu()
    SetNuiFocus(false, false)
end

RegisterNUICallback('close', closeBindingMenu)

RegisterNetEvent('qb-commandbinding:client:openUI')
AddEventHandler('qb-commandbinding:client:openUI', function()
    openBindingMenu()
end)

RegisterNetEvent('esx_securitycam:freeze')
AddEventHandler('esx_securitycam:freeze', function(bool)
    canPressButton = not bool
end)

local phoneOpen = false
Citizen.CreateThread(function()
    while true do
        phoneOpen = exports["high_phone"]:phoneIsOpen()
        Citizen.Wait(1000)
    end
end)

Citizen.CreateThread(function()
    RegisterKeyMapping('+fastKey4', 'Shortcut [4]', 'keyboard', 'numpad4')
    RegisterKeyMapping('+fastKey5', 'Shortcut [5]', 'keyboard', 'numpad5')
    RegisterKeyMapping('+fastKey6', 'Shortcut [6]', 'keyboard', 'numpad6')
    RegisterKeyMapping('+fastKey7', 'Shortcut [7]', 'keyboard', 'numpad7')
    RegisterKeyMapping('+fastKey8', 'Shortcut [8]', 'keyboard', 'numpad8')
    RegisterKeyMapping('+fastKey9', 'Shortcut [9]', 'keyboard', 'numpad9')
end)

RegisterCommand('+fastKey4', function()
    fastKeyFunc("108")
end, false)

RegisterCommand('+fastKey5', function()
    fastKeyFunc("110")
end, false)

RegisterCommand('+fastKey6', function()
    fastKeyFunc("109")
end, false)

RegisterCommand('+fastKey7', function()
    fastKeyFunc("117")
end, false)

RegisterCommand('+fastKey8', function()
    fastKeyFunc("111")
end, false)

RegisterCommand('+fastKey9', function()
    fastKeyFunc("118")
end, false)

function fastKeyFunc(key)
    if isLoggedIn and canPressButton and not keyPressed then
        local inHelicopter = false
        local playerPed = PlayerPedId()
        if IsPedInAnyVehicle(playerPed) then
            if GetVehicleClass(GetVehiclePedIsIn(playerPed, false)) == 15 then 
                inHelicopter = true
            end
        end
        if not inHelicopter and not phoneOpen then
            if not HasNuiFocus then
                local keyMeta = QBCore.Functions.GetPlayerData().metadata["commandbinds"]
                local args = {[1] = nil} 
                if next(keyMeta) ~= nil then
                    if keyMeta[key]["command"] ~= "" then
                        keyPressed = true
                        if keyMeta[key]["argument"] ~= "" then 
                            args = {[1] = keyMeta[key]["argument"]} 
                        end

                        if string.lower(keyMeta[key]["command"]) == "e" and args[1] ~= "c" then
                            QBCore.Functions.Progressbar("anim_used", "Animation is used...", 1200, false, true, { -- p1: menu name, p2: yazı, p3: ölü iken kullan, p4:iptal edilebilir
                                disableMovement = false,
                                disableCarMovement = false,
                                disableMouse = false,
                                disableCombat = true,
                            }, {}, {}, {}, function()
                                TriggerServerEvent('QBCore:CallCommand', keyMeta[key]["command"], args)
                            end, function() 
                            end)
                        else
                            TriggerServerEvent('QBCore:CallCommand', keyMeta[key]["command"], args)
                        end
                        Citizen.Wait(1200)
                        keyPressed = false
                    end
                end
            end
        end
    end

end

RegisterNUICallback('save', function(data)
    local keyData = {
        ["108"]  = {["command"] = data.keyData["108"][1],  ["argument"] = data.keyData["108"][2]},
        ["110"]  = {["command"] = data.keyData["110"][1],  ["argument"] = data.keyData["110"][2]},
        ["109"]  = {["command"] = data.keyData["109"][1],  ["argument"] = data.keyData["109"][2]},
        ["117"]  = {["command"] = data.keyData["117"][1],  ["argument"] = data.keyData["117"][2]},
        ["111"]  = {["command"] = data.keyData["111"][1],  ["argument"] = data.keyData["111"][2]},
        ["118"]  = {["command"] = data.keyData["118"][1],  ["argument"] = data.keyData["118"][2]},
    }

    QBCore.Functions.Notify('Commands Saved', 'success')
    TriggerServerEvent('qb-commandbinding:server:setKeyMeta', keyData)
end)