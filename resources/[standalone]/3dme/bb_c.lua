QBCore = nil
Citizen.CreateThread(function() 
    while QBCore == nil do
        TriggerEvent("QBCore:GetObject", function(obj) QBCore = obj end)    
        Citizen.Wait(200)
    end
end)

local pedDisplaying = {}
local displayTime = 5000
local strin = ""
local chatEmote = true

Citizen.CreateThread(function()
	while true do
		local currentTime, html = GetGameTimer(), ""
        for k, v in pairs(pedDisplaying) do
            if k ~= "npc" then
                local player = GetPlayerFromServerId(tonumber(k))
                if player ~= -1 then
                    local sourcePed, targetPed = GetPlayerPed(player), PlayerPedId()
                    local sourceCoords, targetCoords = GetEntityCoords(sourcePed), GetEntityCoords(targetPed)
                    local pedCoords = GetPedBoneCoords(sourcePed, 0x2e28, 0.0, 0.0, 0.0)
        
                    if #(sourceCoords - targetCoords) < 15 then
                        if chatEmote then
                            if not v.chat then
                                v.chat = true
                                -- local mask = GetPedDrawableVariation(GetPlayerPed(GetPlayerFromServerId(v.serverId)), 1)
                                -- if mask > 0 then
                                --     v.name = "Anonim"
                                -- end
                                TriggerEvent('chatMessage', string.upper(v.type) .. " | " .. v.name, v.type, v.msg)
                            end
                        end

                        local onScreen, xxx, yyy = GetHudScreenPositionFromWorldPosition(pedCoords.x, pedCoords.y, pedCoords.z + 0.35)
                        if v.type == "me" then
                            if not onScreen then
                            html = html .. '<p class="me" style="left: '.. xxx * 100 ..'%;top: '.. yyy * 100 ..'%;"><b">⠀'..v.msg..'⠀</b></p>'
                            end
                        elseif v.type == "do" then
                            if not onScreen then
                                html = html .. '<p class="do" style="left: '.. xxx * 100 ..'%;top: '.. yyy * 100 ..'%;"><b">⠀'..v.msg..'⠀</b></p>'
                            end
                        end
                    end
                end
            else
                local sourceCoords = GetEntityCoords(PlayerPedId())
                if #(sourceCoords - vector3(v.coords.x, v.coords.y, v.coords.z)) < 15 then
                    if chatEmote then
                        if not v.chat then
                            v.chat = true
                            TriggerEvent('chatMessage', string.upper(v.type) .. " | " .. v.type, v.msg)
                        end
                    end

                    local onScreen, xxx, yyy = GetHudScreenPositionFromWorldPosition(v.coords.x, v.coords.y, v.coords.z + 0.35)
                    if v.type == "me" then
                        if not onScreen then
                            html = html .. '<p class="me" style="left: '.. xxx * 100 ..'%;top: '.. yyy * 100 ..'%;"><b">⠀'..v.msg..'⠀</b></p>'
                        end
                    elseif v.type == "do" then
                        if not onScreen then
                            html = html .. '<p class="do" style="left: '.. xxx * 100 ..'%;top: '.. yyy * 100 ..'%;"><b">⠀'..v.msg..'⠀</b></p>'
                        end
                    end
                end
            end
        	if v.time <= currentTime then pedDisplaying[k] = nil end
        end

        if strin ~= html then
            SendNUIMessage({
                type = "txt", 
                html = html
            })
            strin = html
        end
        
		Wait(0)
    end
end)

RegisterCommand('ooc', function(source, args, raw)
    local text = string.sub(raw, 4)
    local playerPed = PlayerPedId()
    local players, nearbyPlayer = QBCore.Functions.GetPlayersFromCoords(GetEntityCoords(playerPed), 10.0)
    for i = 1, #players, 1 do
        TriggerServerEvent('3dme:shareDisplay', text, GetPlayerServerId(players[i]), '/ooc')
    end
end)

RegisterNetEvent("bb-3dme:client:triggerDisplay")
AddEventHandler("bb-3dme:client:triggerDisplay", function(playerId, message, typ, name2)
    pedDisplaying[tostring(playerId)] = {type = typ, msg = message, time = GetGameTimer() + displayTime, chat = false, name = name2}
end)

RegisterNetEvent("3dme:client:tgiann-doctor")
AddEventHandler("3dme:client:tgiann-doctor", function(text, coords)
    pedDisplaying["npc"] = {coords = coords, type = "me", msg = text, time = GetGameTimer() + 15000, chat = false}
end)

RegisterNetEvent('3dme-chat')
AddEventHandler('3dme-chat', function(bool)
    chatEmote = bool
end)

RegisterNetEvent('3dme:xp')
AddEventHandler('3dme:xp', function()
   -- exports["tgiann-levelsistemi"]:expVer("me-do", QBCore.Key)
end)