local PlayerData = {}

QBCore = nil
Citizen.CreateThread(function()
    while QBCore == nil do
        TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)
        Citizen.Wait(200)
    end
end)

local elevator = {
    ["hastane-1"] = {
        ["coords"] = vector3(332.34042358398, -595.7744140625, 43.284019470215),
        ["floors"] = {
            {
                ["name"] = "Penthouse",
                ["coords"] = vector3(338.55160522461, -583.70056152344, 74.164405822754),
            },
            {
                ["name"] = "Lobby",
                ["coords"] = vector3(332.34042358398, -595.7744140625, 43.284019470215),
            },
            {
                ["name"] = "Downstairs",
                ["coords"] = vector3(344.37326049805, -586.1748046875, 28.796850204468),
            },
        },
    },

    ["hastane-2"] = {
        ["coords"] = vector3(332.34042358398, -595.7744140625, 43.284019470215),
        ["floors"] = {
            {
                ["name"] = "Lobby",
                ["coords"] = vector3(327.04806518555, -603.75311279297, 43.284057617188),
            },
            {
                ["name"] = "Lower Floor (Parking)",
                ["coords"] = vector3(340.10131835938, -584.78796386719, 28.796848297119),
            },
        },
    },

}

Citizen.CreateThread(function()
    for x,y in pairs(elevator) do
        for xx,yy in pairs(y) do
            for xx,yy in pairs(y["floors"]) do
                exports["elixir-base"]:addNotif("E", "Lift", 3, 2, yy["coords"])
            end
        end
    end
end)

RegisterNetEvent('elevatorKeybindGeneral')
AddEventHandler('elevatorKeybindGeneral', function()
    for x,y in pairs(elevator) do
        for xx,yy in pairs(y) do
            for xx,yy in pairs(y["floors"]) do
                local distance = #(yy["coords"] - GetEntityCoords(PlayerPedId()))
                if distance < 2  then
                    local elements = {}
                    for xx,yy in pairs(y["floors"]) do
                        table.insert(elements, {label =  yy["name"], value = yy["coords"]})
                    end
                    QBCore.UI.Menu.Open('default', GetCurrentResourceName(), 'elevator_menu', {
                        title    = 'Lift',
                        align    = 'left',
                        elements = elements
                    },function(data, menu)
                        QBCore.UI.Menu.CloseAll()
                        if data.current.value then
                            Wait(250)
                                DoScreenFadeIn(300)
                            SetEntityCoords(PlayerPedId(), data.current.value.x, data.current.value.y, data.current.value.z-1)
                            DoScreenFadeOut(200)
                                Wait(250)
                                DoScreenFadeIn(200)
                        end
                    end,function(data, menu)
                        menu.close()
                    end)
                end
            end
        end
    end
end)