QBCore = nil
local coreLoaded = false
Citizen.CreateThread(function()
    while QBCore == nil do
        TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)
        Citizen.Wait(200)
    end
    coreLoaded = true
end)

local place = 0
local started = false
local grade = 0.5
local disabledControl = false
local nearTableId = 0
local table = 0

local keys = {
    {
        key = 22,
        name = "SPACE"
    },
    {
        key = 38,
        name = "E"
    },
    {
        key = 45,
        name = "R"
    },
    {
        key = 74,
        name = "H"
    },
    {
        key = 145,
        name = "F"
    },
    {
        key = 147,
        name = "A"
    },
    {
        key = 148,
        name = "D"
    },
    {
        key = 149,
        name = "S"
    },
    {
        key = 150,
        name = "W"
    },
    {
        key = 172,
        name = "UP ARROW"
    },
    {
        key = 173,
        name = "DOWN ARROW"
    },
    {
        key = 174,
        name = "LEFT ARROW"
    },
    {
        key = 175,
        name = "RIGHT ARROW"
    },
    {
        key = 182,
        name = "L"
    },
}

local selectedKey = ""

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000)
        for i, modelConfig in pairs(props) do
            local playerCoord = GetEntityCoords(PlayerPedId())
            if #(playerCoord - vector3(modelConfig.x, modelConfig.y, modelConfig.z)) < 50 then
                if modelConfig.prop == 0 then
                    modelConfig.prop = CreateObject(modelConfig.model, modelConfig.x, modelConfig.y, modelConfig.z, false, false, false)
                    SetEntityHeading(modelConfig.prop, modelConfig.h or modelConfig.prop)
                    PlaceObjectOnGroundProperly(modelConfig.prop)
                end
            elseif #(playerCoord - vector3(modelConfig.x, modelConfig.y, modelConfig.z)) >= 50 then
                if modelConfig.prop ~= 0 then
                    if DoesEntityExist(modelConfig.prop) then
                        DeleteEntity(modelConfig.prop)
                        modelConfig.prop = 0
                    end
                end
            end
        end		
    end
end)

Citizen.CreateThread(function()
    while true do
        local time = 500
        if coreLoaded then
            if not started then
                for i=1, #props do
                    local tableCoord = vector3(props[i].x, props[i].y, props[i].z)
                    local distance = #(GetEntityCoords(PlayerPedId()) - tableCoord)
                    if distance < 3 then
                        time = 1
                        if IsControlJustPressed(0, 38) and place == 0 then
                            nearTableId = i
                            table = props[i].prop
                            TriggerServerEvent('evy_arm:check_sv', nearTableId)
                        end
                        if disabledControl then
                            QBCore.Functions.DrawText3D(props[i].x, props[i].y, props[i].z, "[X] Cancel")
                        else
                            QBCore.Functions.DrawText3D(props[i].x, props[i].y, props[i].z, "[E] Arm Wrestling")
                        end
                    end
                end
            end
        
            if disabledControl then
                time = 1
                DisableControlAction(2, 71, true)
                DisableControlAction(2, 72, true)
                DisableControlAction(2, 63, true)
                DisableControlAction(2, 64, true)
                DisableControlAction(2, 73, true)
                DisableControlAction(2, 75, true)
                DisableControlAction(2, 32, true)
                DisableControlAction(2, 33, true)
                DisableControlAction(2, 34, true)
                DisableControlAction(2, 35, true)
                DisableControlAction(2, 37, true)
                DisableControlAction(2, 23, true)
                DisableControlAction(2, 38, true)
                DisableControlAction(2, 246, true)
                DisableControlAction(2, 22, true)
                DisableControlAction(2, 45, true)
                DisableControlAction(2, 74, true)
                DisableControlAction(2, 145, true)
                DisableControlAction(2, 147, true)
                DisableControlAction(2, 148, true)
                DisableControlAction(2, 149, true)
                DisableControlAction(2, 150, true)
                DisableControlAction(2, 172, true)
                DisableControlAction(2, 173, true)
                DisableControlAction(2, 174, true)
                DisableControlAction(2, 175, true)
                DisableControlAction(2, 182, true)
            end
        end
        Citizen.Wait(time)
    end
end)

function timer()
    Citizen.Wait(5000)
    PlaySoundFrontend(-1, "Out_Of_Area", "DLC_Lowrider_Relay_Race_Sounds", 0)
    local T = GetGameTimer()
    while GetGameTimer() - T < 1000 do
        Wait(0)
        Draw2DText(0.5, 0.4, ("~s~3"), 3.0)
    end
    PlaySoundFrontend(-1, "Out_Of_Area", "DLC_Lowrider_Relay_Race_Sounds", 0)
    local T = GetGameTimer()
    while GetGameTimer() - T < 1000 do
        Wait(0)
        Draw2DText(0.5, 0.4, ("~s~2"), 3.0)
    end
    PlaySoundFrontend(-1, "Out_Of_Area", "DLC_Lowrider_Relay_Race_Sounds", 0)
    local T = GetGameTimer()
    while GetGameTimer() - T < 1000 do
        Wait(0)
        Draw2DText(0.5, 0.4, ("~s~1"), 3.0)
    end
    PlaySoundFrontend(-1, "CHECKPOINT_PERFECT", "HUD_MINI_GAME_SOUNDSET", 0)
    local T = GetGameTimer()
    while GetGameTimer() - T < 1000 do
        Wait(0)
        Draw2DText(0.4, 0.4, ("~s~START ~w~!"), 3.0)
    end
end

RegisterNetEvent('evy_arm:updategrade_cl')
AddEventHandler('evy_arm:updategrade_cl', function(gradeUpValue)
    grade = gradeUpValue
end)

RegisterNetEvent('evy_arm:start_cl')
AddEventHandler('evy_arm:start_cl', function()
    local playerPed = PlayerPedId()
    started = true
    selectedKey = math.random(1, #keys)
    local pKey = keys[selectedKey].key
    local pKeyName = keys[selectedKey].name

    disabledControl = true
    timer()

    local animName = "sweep_a"
    local gradeData = 0.015
    if place == 2 then 
        animName = "sweep_b" 
        gradeData = -0.015
    end

    PlayAnim(playerPed, "mini@arm_wrestling", animName, 1)
    SetEntityAnimSpeed(playerPed, "mini@arm_wrestling", animName, 0.0)

    while grade >= 0.10 and grade <= 0.90 do
        Wait(0)
        alert(text['tuto'] .. pKeyName)
        PlayFacialAnim(playerPed, "electrocuted_1", "facials@gen_male@base")
        SetEntityAnimSpeed(playerPed, "mini@arm_wrestling", animName, 0.0)
        SetEntityAnimCurrentTime(playerPed, "mini@arm_wrestling", animName, grade)
        if IsDisabledControlPressed(0, pKey) then
            if place == 1 then
                TriggerServerEvent('evy_arm:updategrade_sv', ((gradeData) + (math.random(1,3)/1000)), nearTableId)
            else
                TriggerServerEvent('evy_arm:updategrade_sv', ((gradeData) - (math.random(1,3)/1000)), nearTableId)
            end
            while IsDisabledControlPressed(0, pKey) do
                Wait(0)
                alert(text['tuto'] .. pKeyName)
                SetEntityAnimCurrentTime(playerPed, "mini@arm_wrestling", animName, grade)
            end
        end
    end

    winLoseNotif()
    Wait(4000)
    TriggerServerEvent('evy_arm:disband_sv', nearTableId)
end)

function winLoseNotif()
    local playerPed = PlayerPedId()
    if place == 1 then
        if grade >= 0.90 then
            PlayAnim(PlayerPedId(), "mini@arm_wrestling", "win_a_ped_a", 2)
            QBCore.Functions.Notify("You Won", "success") 
        elseif grade <= 0.10 then
            PlayAnim(PlayerPedId(), "mini@arm_wrestling", "win_a_ped_b", 2)
            QBCore.Functions.Notify("You lost", "error") 
        end
    elseif place == 2 then
        if grade <= 0.10 then
            PlayAnim(PlayerPedId(), "mini@arm_wrestling", "win_a_ped_a", 2)
            QBCore.Functions.Notify("You Won", "success") 
        elseif grade >= 0.90 then
            PlayAnim(PlayerPedId(), "mini@arm_wrestling", "win_a_ped_b", 2)
            QBCore.Functions.Notify("You lost", "error") 
        end
    end
end

RegisterNetEvent('evy_arm:check_cl')
AddEventHandler('evy_arm:check_cl', function(args)
    if args == 'noplace' then
        QBCore.Functions.Notify("Table is full!", "error") 
    else
        local PlayerPed = PlayerPedId()
        disabledControl = true
        Citizen.CreateThread(function()
            while not started do
                Wait(0)
                alert(text['wait'])
                if IsDisabledControlPressed(2, 73) or IsPedRagdoll(PlayerPed) or IsDisabledControlPressed(2, 200) or IsDisabledControlPressed(2, 214) then --x, esc, delete
                    SetEntityNoCollisionEntity(PlayerPed, table, true)
                    TriggerServerEvent('evy_arm:disband_sv', nearTableId)
                    break
                end
            end
        end)

        SetEntityNoCollisionEntity(PlayerPed, table, false)
        FreezeEntityPosition(PlayerPed, true)

        if args == 'place1' then
            place = 1

            SetEntityHeading(PlayerPed, GetEntityHeading(table))
            Wait(100)
            SetEntityCoords(PlayerPed, GetOffsetFromEntityInWorldCoords(table, -0.20, 0.0, 0.0).x, GetOffsetFromEntityInWorldCoords(table, 0.0, -0.65, 0.0).y, GetEntityCoords(PlayerPed).z-1)
            PlayAnim(PlayerPed, "mini@arm_wrestling","aw_ig_intro_alt1_a", 2)
            while (GetEntityAnimCurrentTime(PlayerPed, "mini@arm_wrestling", "aw_ig_intro_alt1_a") < 0.95 ) do
                Wait(0)
            end
            PlayAnim(PlayerPed, "mini@arm_wrestling", "nuetral_idle_a", 1)

        elseif args == 'place2' then
            place = 2

            SetEntityHeading(PlayerPed, GetEntityHeading(table)-180)
            Wait(100)
            SetEntityCoords(PlayerPed, GetOffsetFromEntityInWorldCoords(table, 0.0, 0.0, 0.0).x, GetOffsetFromEntityInWorldCoords(table, 0.0, 0.50, 0.0).y, GetEntityCoords(PlayerPed).z-1)
            PlayAnim(PlayerPed, "mini@arm_wrestling","aw_ig_intro_alt1_b", 2)
            while ( GetEntityAnimCurrentTime(PlayerPed, "mini@arm_wrestling", "aw_ig_intro_alt1_b") < 0.95 ) do
                Wait(0)
            end
            PlayAnim(PlayerPed, "mini@arm_wrestling", "nuetral_idle_b", 1)
            
        end
    end
end)

RegisterNetEvent('evy_arm:reset_cl')
AddEventHandler('evy_arm:reset_cl', function()
    local playerPed = PlayerPedId()
    if DoesEntityExist(table) then
        SetEntityNoCollisionEntity(playerPed, table, true)
    end
    ClearPedTasks(playerPed)
    place = 0
    started = false
    grade = 0.5
    disabledControl = false
    FreezeEntityPosition(playerPed, false)
end)

function PlayAnim(ped, dict, name, flag)
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        Citizen.Wait(0)
    end
    TaskPlayAnim(ped, dict, name, 1.5, 1.5, -1, flag, 0.0, false, false, false)
end

function alert(msg)
    SetTextComponentFormat("STRING")
    AddTextComponentString(msg)
    DisplayHelpTextFromStringLabel(0,0,1,-1)
end	

function Draw2DText(x, y, text, scale)
    SetTextFont(4)
    SetTextProportional(7)
    SetTextScale(scale, scale)
    SetTextColour( 198, 25, 66, 255)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextDropShadow()
    SetTextEdge(4, 0, 0, 0, 255)
    SetTextOutline()
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x, y)
end

AddEventHandler('onResourceStop', function(resourceName)
    if (GetCurrentResourceName() == resourceName) then
        for i, modelConfig in pairs(props) do
            if modelConfig.prop ~= 0 then
                if DoesEntityExist(modelConfig.prop) then
                    DeleteEntity(modelConfig.prop)
                end
            end
        end
    end
end)