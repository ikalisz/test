local QBCore = exports['qb-core']:GetCoreObject()

grandma = {}

------------------------------------
-- ANIMATIONS / GRANDMA / TARGET --
------------------------------------

function loadAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        RequestAnimDict(dict)
        Wait(5)
    end
end

function GrandmaSit()
    loadAnimDict("timetable@reunited@ig_10")        
    TaskPlayAnim(grandma, "timetable@reunited@ig_10", "base_amanda", 8.0, 1.0, -1, 01, 0, 0, 0, 0)
end


function SpawnGrandma()

    RequestModel(GetHashKey('ig_mrs_thornhill'))
    while not HasModelLoaded(GetHashKey('ig_mrs_thornhill')) do
        Wait(0)
    end
    
    grandma = CreatePed(0, GetHashKey('ig_mrs_thornhill') , Config.Coords.x,  Config.Coords.y,  Config.Coords.z,  Config.Coords.w, false, false)
    --vector4(2435.63, 4965.12, 46.81, 8.76)

    SetEntityAsMissionEntity(grandma)
    SetPedFleeAttributes(grandma, 0, 0)
    SetBlockingOfNonTemporaryEvents(grandma, true)
    SetEntityInvincible(grandma, true)
    FreezeEntityPosition(grandma, true)
    GrandmaSit()  

    exports['qb-target']:AddTargetModel(`ig_mrs_thornhill`, {
        options = {
            { 
                type = "client",
                event = "ex-grandma:client:checks",
                icon = "fa-solid fa-house-medical",
                label = "See Grandma",
            },
        },
        distance = 2.5 
    })
end

function DeleteGrandma()
    if DoesEntityExist(grandma) then
        DeletePed(grandma)
    end
end
----------------------
-- RESOURCE START --
----------------------

AddEventHandler('onResourceStart', function(resourceName)
    if GetCurrentResourceName() == resourceName then
        SpawnGrandma()
    end
end)

AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    SpawnGrandma()
end)

------------------
-- CHECK FUNDS --
------------------

RegisterNetEvent('ex-grandma:client:checks', function()
    local ped = PlayerPedId()
    local player = PlayerId()

    if Config.CheckDead then -- Checks if true or false. If true, checks if player is downed or dead
        QBCore.Functions.GetPlayerData(function(PlayerData)
            if PlayerData.metadata["isdead"] then
                TriggerServerEvent('ex-grandma:server:checkfunds')
            else
                QBCore.Functions.Notify("You don't have any serious wounds, are you kidding me?", "error")
            end
        end)
    else -- Not checking if player is downed or dead
        TriggerServerEvent('ex-grandma:server:checkfunds')
    end
end)

----------------------------
-- Grandma Healing Event --
----------------------------

RegisterNetEvent('ex-grandma:reviveplayer', function(source)
    QBCore.Functions.TriggerCallback('random_grandma:attemptGrandmaPayment', function(hasPaid)
    if hasPaid then
        Wait(500)
    SetEntityCoords(PlayerPedId(), Config.Coords.x, Config.Coords.y, Config.Coords.z)
    TaskStartScenarioInPlace(grandma, "CODE_HUMAN_MEDIC_TEND_TO_DEAD", 0, true)
    QBCore.Functions.Progressbar("grandma", "Grandma is treating you", math.random(15000, 25900), false, false, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
     }, {}, {}, {}, function()
                QBCore.Functions.Notify("you feel better right now.", "success")
                TriggerEvent('esx_ambulancejob:revive', false)
                ClearPedTasks(PlayerPedId())
                ClearPedTasksImmediately(grandma)
                GrandmaSit()
        end)
    else
        QBCore.Functions.Notify("you are done.", "error") -- Got rid of the money after initial check IE attempted to exploit
        -- ClearPedTasks(PlayerPedId())
        -- ClearPedTasksImmediately(grandma)
        GrandmaSit()
    end
     end, function() -- Cancel
        ClearPedTasks(PlayerPedId())
        ClearPedTasksImmediately(grandma)
        GrandmaSit()
    end)
end)

--------------------
-- RESOURCE STOP --
--------------------

AddEventHandler('onResourceStop', function(resourceName) 
	if GetCurrentResourceName() == resourceName then
        DeleteGrandma()
	end 
end)

AddEventHandler('QBCore:Client:OnPlayerUnload', function()
    DeleteGrandma()
end)
