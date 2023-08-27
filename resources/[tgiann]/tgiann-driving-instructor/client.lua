QBCore = nil
Citizen.CreateThread(function()
    while QBCore == nil do
        TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)
        Citizen.Wait(200)
    end
end)

local isInstructorMode = false
local checkPlayerJobData = false
local isInVehicle = false
local usingClipboard = false
local isDead = false
local curTest = {
    cid = -1,
    instructor = '',
    points = 10,
    passed = true,
    results = {},
}

local actions = {
    vehicle = 0,
    isBraking = false
}

local drivingSchools = {
    vector3(-569.65, -197.81, 38.22),
}

RegisterCommand("scriptloaded",function(job)
    checkPlayerJob()
end)

AddEventHandler('tgiann:playerdead', function(dead)
    isDead = dead
end)

RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    checkPlayerJob()
end)

RegisterNetEvent('QBCore:Client:OnJobUpdate')
AddEventHandler('QBCore:Client:OnJobUpdate', function(job)
    checkPlayerJob()
end)

function checkPlayerJob()
    PlayerData = QBCore.Functions.GetPlayerData()
    if not checkPlayerJobData then
        if PlayerData.job.name == "police" then checkForDrivingSchool() end
    end
end

--[[ Functions --]]
function updateNUI(tempData)
    tempData = tempData or false
    if isDead then
        if not usingClipboard then
            SetNuiFocus(false,false)
            SendNUIMessage({show = false})
            TriggerEvent("drivingInstructor:clipboard")
            end
        return
    end
    if usingClipboard then
        if (not tempData) then
            SetNuiFocus(true,true)
            SendNUIMessage({show = true, data = curTest})
        else
            SetNuiFocus(true,true)
            SendNUIMessage({show = true, data = tempData, readonly = true})

            Citizen.CreateThread(function()
                while usingClipboard do
                    Citizen.Wait(1)
                    if IsControlJustPressed(1, 322) then
                        SendNUIMessage({close = true})
                    end
                end
            end)
        end
    else
        SetNuiFocus(false,false)
        SendNUIMessage({show = false})
    end
    TriggerEvent("drivingInstructor:clipboard", (not tempData))
end

function isVehicleAllowed(vehhicle) -- Check if the vehicle is one we allow instructor controls for
    local vehicleClass = GetVehicleClass(vehhicle)
    return (vehicleClass ~= 8 and vehicleClass ~= 13 and vehicleClass ~= 15 and vehicleClass ~= 16 and vehicleClass ~= 17 and vehicleClass ~= 18 and vehicleClass ~= 19 and vehicleClass ~= 21)
end

function checkForVehicle()
    isInVehicle = false -- Reset value until we check for new status
    Citizen.CreateThread(function()
        local playerPed = PlayerPedId()
        while isInstructorMode do
            local playerVeh = GetVehiclePedIsIn(playerPed, false)
            if isInVehicle then
                if playerVeh == 0 then
                    isInVehicle = false
                end
            else
                if playerVeh ~= 0 and isVehicleAllowed(playerVeh) then -- Check if we weren't in a vehicle before but now are
                    isInVehicle = true
                    instructorControls(playerPed, playerVeh) -- Got in vehicle, start checking for instructor actions
                end
            end
            Wait(1000)
        end
    end)
end

function instructorControls(playerPed, veh)
    Citizen.CreateThread(function()
        local isBraking = false
        -- These functions are checked on tick so only check when we in Instructor Mode and in a vehicle
        while (isInstructorMode and isInVehicle) do
            if GetPedInVehicleSeat(veh, 0) == playerPed then -- Check if we are in the passenger seat
                if not isBraking and IsControlJustPressed(0, 22) then -- Braking ("SPACE")
                    isBraking = true
                    sendActionToDriver(veh, 1)
                elseif isBraking and IsControlJustReleased(0, 22) then -- Unbrake ("SPACE")
                    isBraking = false
                    sendActionToDriver(veh, 2)
                elseif IsControlJustPressed(0, 38) then -- Vehicle kill switch toggle ("E")
                    sendActionToDriver(veh, 3) -- Engine toggle
                end
            end
            Wait(1)
        end
        sendActionToDriver(veh, 4) -- Clear any remaining actions
    end)
end

function sendActionToDriver(vehicle, action)
    local driverPed = GetPedInVehicleSeat(vehicle, -1)
    if driverPed > 0 then -- Find driver to send the action to
        TriggerServerEvent('driving:vehicleAction', GetPlayerServerId(NetworkGetPlayerIndexFromPed(driverPed)), action)
    else -- No driver found, so try the action locally
        TriggerEvent('drivingInstructor:vehicleAction', action)
    end
end

function isNearDrivingSchool()
    for i = 1, #drivingSchools do
        local drivingSchool = drivingSchools[i]
        local ply = PlayerPedId()
        local plyCoords = GetEntityCoords(ply, 0)
        local distance = #(drivingSchool - plyCoords)
        if(distance < 3.0) then
            QBCore.Functions.DrawText3D(drivingSchool["x"], drivingSchool["y"], drivingSchool["z"], "[Y] Driving Training Mode On/Off" )
        end
        if(distance < 3.0) then
            return true
        end
    end
end

function checkForDrivingSchool()   -- Check for instructor toggle
    Citizen.CreateThread(function()
        checkPlayerJobData = true
        while true do
            Citizen.Wait(0)
            if isNearDrivingSchool() then
                if IsControlJustPressed(1, 246) then -- [Y] key
                    TriggerServerEvent('driving:toggleInstructorMode', isInstructorMode)
                end
            else
                Wait(2500)
            end
        end
    end)
end

--[[ Event Handlers --]]
RegisterNUICallback('close', function(data, cb)
    -- Obly set local variables if we have a valid cid
    if isInstructorMode and (data and data.cid and data.cid ~= -1) then
        curTest.cid = data.cid
        curTest.points = data.points
        curTest.passed = data.passed
        curTest.results = data.results
    end
    usingClipboard = false
    updateNUI()
    cb('ok')
end)

RegisterNetEvent("drivingInstructor:instructorToggle") -- Server
AddEventHandler("drivingInstructor:instructorToggle", function(toggle, name)
    isInstructorMode = toggle
    if (name) then curTest.instructor = name end
    if isInstructorMode then
        checkForVehicle()
        QBCore.Functions.Notify("Driving Instructor Mode: Active")
    else
        QBCore.Functions.Notify("Driving Instructor Mode: Passive")
    end
    TriggerEvent("drivingInstructor:update", isInstructorMode)
end)

RegisterNetEvent("drivingInstructor:testToggle") -- server
AddEventHandler("drivingInstructor:testToggle", function()
    if not isInstructorMode then
        if usingClipboard then -- Close clipboard if we had it open
            usingClipboard = false
            updateNUI()
        else
            -- Only give error if they are trying to access the test when not in the proper mode
            QBCore.Functions.Notify("To Do This you must be in driving instructor mode!")
            QBCore.Functions.Notify("You can pass the location marked on the GPS to the Driving Training Mode!")
            SetNewWaypoint(drivingSchools[1].x, drivingSchools[1].y)
        end
    else
        usingClipboard = not usingClipboard
        updateNUI()
    end
end)

RegisterNetEvent("drivingInstructor:submitTest") -- server (Eğitim Sonu Eğitici Eventi)
AddEventHandler("drivingInstructor:submitTest", function()
    if not isInstructorMode then
        QBCore.Functions.Notify("To Do This you must be in driving instructor mode!")
        return
    end

    if curTest.cid <= 0 then
        QBCore.Functions.Notify("You Didn't Fill in the Contact's Driver Identification Number!")
        return
    end
    TriggerServerEvent('driving:submitTest', curTest)
end)

RegisterNetEvent("drivingInstructor:viewResults") -- server
AddEventHandler("drivingInstructor:viewResults", function(testData)
    usingClipboard = true
    updateNUI(testData)
end)

RegisterNetEvent("drivingInstructor:vehicleAction")
AddEventHandler("drivingInstructor:vehicleAction", function(action)
    local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
    if vehicle == 0 then
        actions.isBraking = false
        return
    else
        actions.vehicle = vehicle
    end

    if action == 1 then -- Brake
        actions.isBraking = true
        Citizen.CreateThread(function()
            local veh = actions.vehicle -- Localize here incase vehicle changes at some point before turning brakes back off
            local ped = PlayerPedId()
            while actions.isBraking do
                TaskVehicleTempAction(ped, veh, 24, 1)
                Citizen.Wait(0)
            end
        end)
    elseif action == 2 then -- Release Brake
        actions.isBraking = false
    elseif action == 3 then -- Engine Toggle
        if GetIsVehicleEngineRunning(actions.vehicle) then -- Turn Off
            SetVehicleEngineOn(actions.vehicle,0,1,1)
            SetVehicleUndriveable(actions.vehicle, true)
        else -- Turn On
            SetVehicleEngineOn(actions.vehicle,1,1,1)
            SetVehicleUndriveable(actions.vehicle, false)
        end
        TriggerEvent("x-hotwire:motorAcKapat")
    elseif action == 4 then -- Instructor is no longer in control, clear any of their actions
        actions.isBraking = false
    end
end)

--[[ Animations --]]
local propData = nil
RegisterNetEvent("drivingInstructor:clipboard")
AddEventHandler("drivingInstructor:clipboard", function(isWriting)
    local ped = PlayerPedId()
    local anim = "amb@world_human_clipboard@male@base"
    local board = "clipboard01"
    if isWriting then
        anim = "amb@medic@standing@timeofdeath@base"
        board = "clipboard02"
    end

    RequestAnimDict(anim)
    while not HasAnimDictLoaded(anim) do
        Citizen.Wait(0)
    end

    if usingClipboard then
        TaskPlayAnim(ped, anim, "base", 2.0, 3.0, -1, 49, 0, 0, 0, 0)
        Citizen.Wait(450)
        attachProps(board)
        Citizen.Wait(150)

        while usingClipboard do
            if isDead then
                usingClipboard = false
                updateNUI()
            end
            if not IsEntityPlayingAnim(ped, anim, "base", 3) then
                TaskPlayAnim(ped, anim, "base", 2.0, 3.0, -1, 49, 0, 0, 0, 0)
            end
            Citizen.Wait(1)
        end

        ClearPedTasks(ped)
        if propData then DeleteEntity(propData) end
    else
        if propData then DeleteEntity(propData) end
        ClearPedTasks(ped)
        Citizen.Wait(400)
        TaskPlayAnim(ped, anim, "exit", 2.0, 1.0, 5.0, 49, 0, 0, 0, 0)
        Citizen.Wait(400)
        ClearPedTasks(ped)
    end
end)

local attachPropList = {
    ["clipboard01"] = {
        ["model"] = `p_amb_clipboard_01`, ["bone"] = 60309, ["x"] = -0.01, ["y"] = -0.015,["z"] = 0.005, ["xR"] = 0.0, ["yR"] = 0.0, ["zR"] = -10.0
    },
    ["clipboard02"] = {
        ["model"] = `p_amb_clipboard_01`, ["bone"] = 60309, ["x"] = 0.1, ["y"] = -0.01,["z"] = 0.005, ["xR"] = -95.0, ["yR"] = 20.0, ["zR"] = -20.0
    },
}	

function attachProps(item)
    if propData then DeleteEntity(propData) end
    propData = CreateObject(attachPropList[item]["model"], 0, 0, 0, true, true, true)
	AttachEntityToEntity(propData, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), attachPropList[item]["bone"]), attachPropList[item]["x"], attachPropList[item]["y"], attachPropList[item]["z"], attachPropList[item]["xR"], attachPropList[item]["yR"], attachPropList[item]["zR"], true, true, false, true, 1, true)
end