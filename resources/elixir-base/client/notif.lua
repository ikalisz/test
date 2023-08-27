local notif = {}
local show3DText = false

--  exports["elixir-base"]:addNotif("E", "Menü", 5, 1, vector3(320.80703735352, -677.16772460938, 29.298458099365))
exports("addNotif", function(button, text, maxDistance, pressDistance, coord, car, job, duty, boss, grade)
    table.insert(notif, {button = button, text = text, maxDistance = maxDistance, pressDistance = pressDistance, car = car, coord = coord, job = job, duty = duty, boss = boss, grade = grade})
end)

RegisterCommand("show", function() show3DText = not show3DText end)

Citizen.CreateThread(function()
    RegisterKeyMapping('+general', 'General [E]', 'keyboard', 'e')
    RegisterKeyMapping('+generalDelete', 'General [Delete]', 'keyboard', 'delete')
	RegisterKeyMapping('+generalX', 'General [X]', 'keyboard', 'x')
	RegisterKeyMapping('+generalTab', 'General [Tab]', 'keyboard', 'tab')

    while true do
        local time = 100
        if playerLoaded then
            local playerPed = PlayerPedId()
            local coord = GetEntityCoords(playerPed)
            if PlayerData.job == nil then PlayerData = QBCore.Functions.GetPlayerData() end

            local found = false
            local text = ""
            for i=1, #notif do
                local distance = #(vector3(notif[i].coord.x, notif[i].coord.y, notif[i].coord.z) - coord)
                local distanceCheck = distance < notif[i].maxDistance
                if distanceCheck or show3DText and distance < 20 then
                    local job = true
                    local grade = true
                    local duty = true
                    local car = true
                    local boss = true
                    if notif[i].job then if notif[i].job ~= PlayerData.job.name then job = false end end
                    if notif[i].grade then if notif[i].grade < PlayerData.job.grade then grade = false end end
                    if notif[i].duty then duty = PlayerData.job.onduty end
                    if notif[i].car then car = IsPedInAnyVehicle(playerPed) end
                    if notif[i].boss then boss = PlayerData.job.boss end

                    if job and grade and duty and car and boss then

                        if show3DText then
                            if distance < 8 then
                                time = 1
                                QBCore.Functions.DrawText3D(notif[i].coord.x, notif[i].coord.y, notif[i].coord.z, notif[i].text )
                            end
                        end

                        if distanceCheck then
                            text = notif[i].text .." ("..QBCore.Shared.Round(distance)..")"
                            found = true
                            if distance < notif[i].pressDistance then
                                text = "<b>["..notif[i].button .. "]</b> &nbsp" .. notif[i].text 
                            end
                            if not show3DText then
                                break
                            end
                        end
                    end

                end
            end

            if text ~= lastText then
                if found then
                    -- SendNUIMessage({type = "notifOpen", text = text})
                    exports['qb-ui']:showInteraction(text)
                else
                    -- SendNUIMessage({type = "notifClose"})
                    exports['qb-ui']:hideInteraction()
                end
            end
            lastText = text
        end
        Citizen.Wait(time)
    end
end)

RegisterCommand('+general', function()
    if PlayerData.job then
        if PlayerData.job.name == "police" then 
            TriggerEvent("policeKeybindGeneral") 
            TriggerEvent("polisBildirimKeybindGeneral") 
            TriggerEvent("dnaKeybindGeneral") 
        end
        if PlayerData.job.name == "ambulance" then 
            TriggerEvent("emsKeybindGeneral") 
            TriggerEvent("dnaKeybindGeneral") 
        end
        if string.find(PlayerData.job.name, "mechanic") then TriggerEvent("mechanicKeybindGeneral", PlayerData.job.name) end
        TriggerEvent("mechanicMenu")
        TriggerEvent("npcdoktorKeybindGeneral")
        TriggerEvent("mk2carKeybindGeneral")
        TriggerEvent("elevatorKeybindGeneral")
        TriggerEvent("teleportKeybindGeneral")
        TriggerEvent("qbshopsKeybindGeneral")
        TriggerEvent("carwashKeybindGeneral")
        TriggerEvent("huntingKeybindGeneral")
        TriggerEvent("vehicleShopKeybindGeneral")
        TriggerEvent("craftNPCKeybindGeneral")
        TriggerEvent("dmvschollKeybindGeneral")
        TriggerEvent("tattooShopKeybindGeneral")
        TriggerEvent("trackKeybindGeneral")
        TriggerEvent("companyJobsKeybindGeneral", PlayerData.job.name)
    end
end, false)

