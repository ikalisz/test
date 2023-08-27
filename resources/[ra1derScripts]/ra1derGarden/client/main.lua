local QBCore = exports['qb-core']:GetCoreObject()
local inJob = false
local paycheck = 0
local girdim = false 
RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    PlayerData = QBCore.Functions.GetPlayerData()
    paycheck = 0
    inJob = false
    girdim = true
end)
local pedkanka = vector3(-540.42, -205.34, 36.65)
local pedkankah = 209.7

CreateThread(function()
    exports["elixir-base"]:pedcreate("garden", `s_m_m_gardener_01`, pedkanka.x, pedkanka.y, pedkanka.z,  pedkankah)
end)

RegisterNetEvent('QBCore:Client:OnPlayerUnload', function()
    paycheck = 0
    inJob = false
    girdim = false
end)

RegisterNetEvent('ra1derGarden:client:setState', function(curShrub)
    Shrubs[curShrub]["isBusy"] = true
    Wait(Config.Cooldown * 1000)  
    Shrubs[curShrub]["isBusy"] = false
    inJob = false
    Wait(7)
    inJob = true
    TriggerEvent('ra1derGarden:client:drawMarkers')
end)

RegisterNetEvent('ra1derGarden:client:drawMarkers', function()
    for k, v in pairs(Shrubs) do
        CreateThread(function()
            while inJob == true and Shrubs[k]["isBusy"] == false do
                local pos = GetEntityCoords(PlayerPedId())
                local dist = #(pos - v.coords)
                local sleep = 2000

                if dist < 5.0 then
                    sleep = 7

                    if dist < 3.0 then
                        DrawMarker(21 , v.coords.x, v.coords.y, v.coords.z - 0.4, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.15, 0.15, 0.15, 4, 205, 0, 222, true, false, false, false, false, false, false)
                    end
                end
                Wait(sleep)
            end
        end)	
    end
end)

RegisterNetEvent('ra1derGarden:client:pruneShrub', function(curShrub)
    TriggerServerEvent('ra1derGarden:server:checkStatus', curShrub)
end)

function loadAnimDict(dict)
    while (not HasAnimDictLoaded(dict)) do
        RequestAnimDict(dict)
        Wait(5)
    end
end

RegisterNetEvent('ra1derGarden:client:pruningShrub', function(curShrub)
    loadAnimDict("amb@world_human_bum_wash@male@low@idle_a")
    TaskPlayAnim(PlayerPedId(), 'amb@world_human_bum_wash@male@low@idle_a', 'idle_a' , 3.0, 3.0, -1, 1, 0, false, false, false)
    QBCore.Functions.Progressbar("prune_shrub", "Otlar Kesiliyor", 10000, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {}, {}, {}, function()
        StopAnimTask(PlayerPedId(), "amb@world_human_bum_wash@male@low@idle_a", "idle_a", 1.0)
        TriggerServerEvent('ra1derGarden:server:setState', curShrub)
        TriggerEvent('ra1derGarden:client:setState', curShrub)
        paycheck = paycheck + Config.Paycheck
        if Config.CurrentPaycheck then
            exports["elix1rBase"]:SendAlert("you have completed a job!", "inform")
            exports["elix1rBase"]:SendAlert("Your current salary: $".. paycheck, "success")
        end
        end, function()
    end)
end)



RegisterNetEvent('ra1derGarden:client:joinJob', function()
    if not inJob then
        QBCore.Functions.Progressbar("policeFixBody", "You are signing the contract!", 9000, true, true, {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        }, {
            animDict = "missheistdockssetup1clipboard@base",
            anim = "base",
            flags = 16,
        }, {}, {}, function() -- Done
            inJob = true
            TriggerEvent('ra1derGarden:client:drawMarkers')
            exports["elix1rBase"]:SendAlert("You started working ", "success")
        end, function()
        end)
    end
end)

RegisterNetEvent('ra1derGarden:client:leaveJob', function()
    if paycheck > 0 then
        exports["elix1rBase"]:SendAlert("Take your money before you do your job! ", "error")
    else
        exports["elix1rBase"]:SendAlert("You are not working here now!", "success")
        inJob = false
    end
end)
 
RegisterNetEvent('ra1derGarden:client:paycheck', function()
    TriggerServerEvent('ra1derGarden:server:paycheck', paycheck)
    paycheck = 0
end)

Citizen.CreateThread(function()
    local blip = AddBlipForCoord(-541.0993041992188, -207.0705718994141, 37.64981460571289)
	SetBlipSprite(blip, 285) 
	SetBlipDisplay(blip, 4)
	SetBlipScale(blip, 0.6)
	SetBlipAsShortRange(blip, true)
	SetBlipColour(blip, 60)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentSubstringPlayerName("Horticultural Area") 
    EndTextCommandSetBlipName(blip)
end)

CreateThread(function()
    for k, v in pairs(Shrubs) do
        exports['qb-target']:AddBoxZone(k, vector3(v.coords), v.lenght, v.width, {
        name = k, 
        heading = v.heading, 
        debugPoly = false, 
        minZ = 36.7, 
        maxZ = 37.9, 
        }, {
            options = {
                {
                    icon = 'fas fa-cut',
                    label = 'Who',
                    canInteract = function()
                        if Shrubs[k]["isBusy"] and not inJob then
                            return false
                        elseif not Shrubs[k]["isBusy"] and inJob then
                            return true
                        end
                    end,
                    action = function()
                        TriggerEvent('ra1derGarden:client:pruneShrub', k)
                    end,
                }
            },
            distance = 1.5,
        })
    end
end)


exports['qb-target']:AddTargetModel(`s_m_m_gardener_01`, {
    options = {
        {
            type = "server",
            event = "ra1derGarden:server:work",
            icon = 'fas fa-angle-double-right',
            label = 'Take your gardener profession',
            canInteract = function()
                if inJob then
                    return false
                else
                    return true
                end
            end,
        },
        {
            type = "server",
            event = "ra1derGarden:server:leave",
            icon = 'fas fa-angle-double-left',
            label = 'Quitting',
            canInteract = function()
                if not inJob then
                    return false
                else
                    return true
                end
            end,
        },
        {
            type = "client",
            event = "ra1derGarden:client:paycheck",
            icon = 'fas fa-hand-holding-usd',
            label = 'Take your money',
            canInteract = function()
                if paycheck <= 0 then
                    return false
                else
                    return true
                end
            end,
        }
    },
	distance = 2,
})




