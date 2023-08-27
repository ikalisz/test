Citizen.CreateThread(function()
    while true do
        local playerPed = PlayerPedId()
        local playerCoords = GetEntityCoords(playerPed)
        local time = 5000
        for x,y in pairs(eltgianntor) do
            for xx,yy in pairs(y) do
                if #(y["coords"] - playerCoords) < 300 and coreLoaded then
                    time = 1
                    for xx,yy in pairs(y["floors"]) do
                        local distance = #(yy["coords"] - playerCoords)
                        if distance < 10 then
                            DrawMarker(20, yy["coords"].x, yy["coords"].y, yy["coords"].z-0.6, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.0, 1.0, 1.0, 255, 0,0, 100, false, true, 2, false, false, false, false)
                            if distance < 2  then
                                QBCore.Functions.DrawText3D(yy["coords"].x, yy["coords"].y, yy["coords"].z, "[E] "..x.." Lift", 0.45)
                                if IsControlJustPressed(1, 38) then
                                    local elements = {}
                                    for xx,yy in pairs(y["floors"]) do
                                        table.insert(elements, {label =  yy["name"], value = yy["coords"]})
                                    end
                                    QBCore.UI.Menu.Open('default', GetCurrentResourceName(), 'eltgianntor_ev_menu', {
                                        title    = x..' Lift',
                                        align    = 'left',
                                        elements = elements
                                    },function(data, menu)
                                        QBCore.UI.Menu.CloseAll()
                                        if data.current.value then
                                            SetEntityCoords(playerPed, data.current.value.x, data.current.value.y, data.current.value.z-1.0)
                                        end
                                    end,function(data, menu)
                                        menu.close()
                                    end)
                                end
                            end
                        end
                    end
                end
            end
        end
        Citizen.Wait(time)
    end
end)