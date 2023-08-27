local QBCore = exports['qb-core']:GetCoreObject()

local text = {
    ["noClosestPlayer"] = "No One Near",
    ["noClosestCar"] = "No Vehicles Nearby",
}

-- Menu state
local showMenu = false
local MAX_MENU_ITEMS = 7

-- Main thread
Citizen.CreateThread(function()
    RegisterKeyMapping('+radialMenu', 'F3 Menu', 'keyboard', 'f3')
end)

RegisterCommand('+radialMenu', function()
    if not showMenu then
        local yatakData = exports["ChairBedSystem"]:yatakVarmi()
        prop, yatak, animYatak = yatakData[1], yatakData[2], yatakData[3]
        showMenu = true
        local enabledMenus = {}
        for _, menuConfig in ipairs(rootMenuConfig) do
            if menuConfig:enableMenu() then
                local dataElements = {}
                local hasSubMenus = false
                if menuConfig.subMenus ~= nil and #menuConfig.subMenus > 0 then
                    hasSubMenus = true
                    local previousMenu = dataElements
                    local currentElement = {}
                    for i = 1, #menuConfig.subMenus do
                        -- if newSubMenus[menuConfig.subMenus[i]] ~= nil and newSubMenus[menuConfig.subMenus[i]].enableMenu ~= nil and not newSubMenus[menuConfig.subMenus[i]]:enableMenu() then
                        --     goto continue
                        -- end
                        currentElement[#currentElement+1] = newSubMenus[menuConfig.subMenus[i]]
                        currentElement[#currentElement].id = menuConfig.subMenus[i]
                        currentElement[#currentElement].enableMenu = nil

                        if i % MAX_MENU_ITEMS == 0 and i < (#menuConfig.subMenus - 1) then
                            previousMenu[MAX_MENU_ITEMS + 1] = {
                                id = "_more",
                                title = "More",
                                icon = "#more",
                                items = currentElement
                            }
                            previousMenu = currentElement
                            currentElement = {}
                        end
                        --::continue::
                    end
                    if #currentElement > 0 then
                        previousMenu[MAX_MENU_ITEMS + 1] = {
                            id = "_more",
                            title = "More",
                            icon = "#more",
                            items = currentElement
                        }
                    end
                    dataElements = dataElements[MAX_MENU_ITEMS + 1].items

                end
                enabledMenus[#enabledMenus+1] = {
                    id = menuConfig.id,
                    title = menuConfig.displayName,
                    functionName = menuConfig.functionName,
                    icon = menuConfig.icon,
                }
                if hasSubMenus then
                    enabledMenus[#enabledMenus].items = dataElements
                end
            end
        end
        
        SendNUIMessage({
            state = "show",
            resourceName = GetCurrentResourceName(),
            data = enabledMenus,
            menuKeyBind = "F3"
        })

        SetCursorLocation(0.5, 0.5)
        SetCustomNuiFocus(true, true)

        PlaySoundFrontend(-1, "NAV", "HUD_AMMO_SHOP_SOUNDSET", 1)
    end
end, false)

RegisterNUICallback('closemenu', function(data)
    showMenu = false
    SetCustomNuiFocus(false, false)
    SendNUIMessage({state = 'destroy'})
    PlaySoundFrontend(-1, "NAV", "HUD_AMMO_SHOP_SOUNDSET", 1)
end)

RegisterNUICallback('triggerAction', function(data)
    showMenu = false
    SetCustomNuiFocus(false, false)
    SendNUIMessage({state = 'destroy'})
    PlaySoundFrontend(-1, "NAV", "HUD_AMMO_SHOP_SOUNDSET", 1)

    eventTrigger(data.action)
end)

RegisterCommand("f3fix", function()
    showMenu = false
    SetCustomNuiFocus(false, false)
    SendNUIMessage({state = 'destroy'})
    PlaySoundFrontend(-1, "NAV", "HUD_AMMO_SHOP_SOUNDSET", 1)
end)

function SetCustomNuiFocus(hasKeyboard, hasMouse)
    local HasNuiFocus = hasKeyboard or hasMouse
    SetNuiFocus(hasKeyboard, hasMouse)
    SetNuiFocusKeepInput(HasNuiFocus)
    TriggerEvent("tgiann-menuv3:nui-focus", HasNuiFocus, hasKeyboard, hasMouse)
end

local HasNuiFocus, IsFocusThreadRunning = false, false
RegisterNetEvent('tgiann-menuv3:nui-focus')
AddEventHandler('tgiann-menuv3:nui-focus', function(hasFocus, hasKeyboard, hasMouse, allControl)
    HasNuiFocus = hasFocus
    TriggerEvent("elixir-base:focus", HasNuiFocus)
	if HasNuiFocus and not IsFocusThreadRunning then
		Citizen.CreateThread(function ()
            while HasNuiFocus do
                if hasKeyboard and not allControl then
                    DisableAllControlActions(0)
                    EnableControlAction(0, 249, true)
                elseif hasKeyboard and allControl then
                    DisableControlAction(0, 24, true) -- disable attack
                    DisableControlAction(0, 25, true) -- disable aim
                    DisableControlAction(0, 1, true) -- LookLeftRight
                    DisableControlAction(0, 2, true) -- LookUpDown
                end

                if not hasKeyboard and hasMouse then
                    DisableControlAction(0, 1, true)
                    DisableControlAction(0, 2, true)
                elseif hasKeyboard and not hasMouse then
                    EnableControlAction(0, 1, true)
                    EnableControlAction(0, 2, true)
                end

                Citizen.Wait(0)
			end
        end)
    end
end)

local kilitac = false
local IsBusy = false
local windowup = true
local copKaristirCD = false
local inTrunk = false
local emsBildirimCd = 0
local pdBildirimCd = 0
local isInRagdoll = false
local mechanicLocation = {
	{ x = -341.96, y = -131.52, z = 38.7 },
	{ x = -197.43, y = -1317.73, z = 31.09 },
    { x = 950.71, y = -968.42, z = 39.40 },
    { x = 1179.0, y = 2647.0, z = 37.0 },
    { x = 810.41, y = -2322.26, z = 30.46 },
    { x = 546.47, y = -182.38, z = 54.49 },
    { x = -1415.78, y = -446.37, z = 35.91 },
    { x = -35.34, y = -1052.93, z = 28.4 },
}

function eventTrigger(data)
    local playerPed = PlayerPedId()
	local coords = GetEntityCoords(playerPed)
    local found, player = GetClosestPlayerMenu()
    local inVehicle = IsPedInAnyVehicle(playerPed, false)
    local inVhicleId = 0
    local vehicle, mesafe = 0, 999
    if inVehicle then
        inVhicleId =  GetVehiclePedIsIn(playerPed, false)
    else
        vehicle, mesafe = QBCore.Functions.GetClosestVehicle(coords)
    end
    
    if data == "imodifiye" then
        TriggerEvent("tunnerchip:arastir")
    elseif data == "tunnerchipremove" then
        TriggerEvent("tunnerchip:soru")
    elseif data == "aracicek" then
        TriggerEvent("arac:cek")
    elseif data == "camfilmarastir" then 
        TriggerEvent("camfilm:arastir")
    elseif data == "camfilm" then 
        TriggerEvent("WindowFilm:soru")
    elseif data == "neonsok" then
        if not inVehicle then -- Sürücü Koldutuğunda İken
            QBCore.Functions.Notify('You have to be in the vehicle')
        else
            QBCore.Functions.Progressbar('name', 'Neon Dismantling', 25000, false, true, { -- Name | Label | Time | useWhileDead | canCancel
                disableMovement = true,
                disableCarMovement = true,
                disableMouse = false,
                disableCombat = true,
            }, {
                animDict = "mini@repair",
                anim = "fixing_a_player",
                flags = 49,
            }, {}, {}, function() -- Play When Done
                QBCore.Functions.Notify('The Neons of the Vehicle Are Dismantled')
                if DoesEntityExist(inVhicleId) then
                    SetVehicleNeonLightEnabled(inVhicleId, 0, false)
                    SetVehicleNeonLightEnabled(inVhicleId, 1, false)
                    SetVehicleNeonLightEnabled(inVhicleId, 2, false)
                    SetVehicleNeonLightEnabled(inVhicleId, 3, false)
                end
                QBCore.Functions.Notify('Vehicle Neon Removed') 
            end, function() -- Play When Cancel
                QBCore.Functions.Notify('The Neon of the Vehicle Could Not Be Removed') 
            end)
        end
    elseif data == "plakabak" then 
        if mesafe < 3 then
            if DoesEntityExist(vehicle) then
                local vehicleData = QBCore.Functions.GetVehicleProperties(vehicle)
                TriggerEvent('esx_policejob:plakabak', vehicleData)
            end
        end
    elseif data == "kilitac" then
        if mesafe < 4 and not kilitac then
            local playerPed = PlayerPedId()
            local lock = GetVehicleDoorLockStatus(vehicle)
            kilitac = true
            TriggerEvent("tgiann-menu:kilitacma")
            Citizen.Wait(16000)
            kilitac = false
            SetVehicleDoorsLocked(vehicle, 1)
            SetVehicleDoorsLockedForAllPlayers(vehicle, false)
            QBCore.Functions.Notify('Vehicle Unlocked')
        end 
    elseif data == "pilot" then
        if PlayerData.job.grade >= 12 then 
            if not found then return end
            TriggerServerEvent("tgiann-menu:give-lisance", player, "aircraft", QBCore.Key)
        else
            QBCore.Functions.Notify('Your Rank Is Not Enough!', 'error')
        end
    elseif data == "silah" then
        if PlayerData.job.grade >= 12 then 
            if not found then return end
            TriggerServerEvent("tgiann-menu:give-lisance", player, "weapon", QBCore.Key)
        else
            QBCore.Functions.Notify('Your Rank Is Not Enough!', 'error')
        end
    elseif data == "polisrozet" then
        if PlayerData.job.name >= "police" then 
            local model = `prop_fib_badge`
            while not HasModelLoaded(model) do RequestModel(model) Citizen.Wait(100) end
            local prop = CreateObject(`prop_fib_badge`, 1.0, 1.0, 1.0, 1, 1, 0)
            AttachEntityToEntity(prop, playerPed, GetPedBoneIndex(playerPed, 57005), 0.10, 0.01, -0.045, 110.0, 120.0, -15.0, 1, 0, 0, 0, 2, 1)
            SetModelAsNoLongerNeeded(model)
            while (not HasAnimDictLoaded("paper_1_rcm_alt1-9")) do RequestAnimDict("paper_1_rcm_alt1-9")  Citizen.Wait(100) end
            TaskPlayAnim(playerPed, "paper_1_rcm_alt1-9", "player_one_dual-9", 1.0, 1.0, 5500, 33, 1, false, false, false)
            Citizen.Wait(3100)
            DeleteEntity(prop)
        end
    elseif data == "poliskimlik" then
        if PlayerData.job.name >= "police" then 
            if not found then 
                QBCore.Functions.Notify("No One Near", "error")
                return 
            end
            local model = `prop_police_phone`
            while not HasModelLoaded(model) do print("model") RequestModel(model) Citizen.Wait(100) end
            local prop = CreateObject(`prop_police_phone`, 1.0, 1.0, 1.0, 1, 1, 0)
            AttachEntityToEntity(prop, playerPed, GetPedBoneIndex(playerPed, 57005), 0.12, 0.01, -0.045, 110.0, 120.0, -15.0, 1, 0, 0, 0, 2, 1)
            SetModelAsNoLongerNeeded(model)
            while (not HasAnimDictLoaded("paper_1_rcm_alt1-9")) do RequestAnimDict("paper_1_rcm_alt1-9") Citizen.Wait(100) end
            TaskPlayAnim(playerPed, "paper_1_rcm_alt1-9", "player_one_dual-9", 1.0, 1.0, 5500, 33, 1, false, false, false)
            TriggerServerEvent("jsfour-idcard:server:open-pd", player)
            Citizen.Wait(3100)
            DeleteEntity(prop)
        end
    elseif data == "hapiscikar" then
        TriggerEvent('esx-qalle-jail:hapiscikar')
    elseif data == "cezakes" then
        TriggerEvent('esx_policejob:cezakes')
    elseif data == "kamu" then
        if not found then return end
        TriggerEvent('esx_policejob:kamu', player)
    elseif data == "hapisat" then
        TriggerEvent('esx-qalle-jail:hapisat')
    elseif data == "cezalarinabak" then
        if not found then return end
        TriggerEvent('esx_policejob:cezalarinabak', player)
    elseif data == "iyilestirPolis" then
        if PlayerData.job.grade >= 6 then 
            if not found then return end
            TriggerEvent("esx_ambulancejob:TgiannCanlandir", player)
        else
            QBCore.Functions.Notify('Unfortunately You Didnt Get The Training To Do This Operation', 'error')
        end
    elseif data == "iyilestirPolis" then
        if not found then return end
	    TriggerEvent('esx_policejob:lisanskontrol', player)
    elseif data == "iyilestirPolis" then
        local forward = GetEntityForwardVector(playerPed)
        local x, y, z = table.unpack(coords + forward * 1.0)

        QBCore.Functions.SpawnObject('prop_roadcone02a', {x = x, y = y, z = z- 2.0}, function(obj)
            SetEntityHeading(obj, GetEntityHeading(playerPed))
            PlaceObjectOnGroundProperly(obj)
        end)
    elseif data == "obje" then 
        TriggerEvent("tgiann-police:obje-menu-ac")
    elseif data == "diken" then
        TriggerEvent("c_setSpike")
    elseif data == "spikeTopla" then
        TriggerEvent("c_deleteSpike")
    elseif data == "fatura" then
        if not found then return end
	    TriggerEvent("tgiann-meslekmekanik:TgiannFatura", player)
    elseif data == "tamir" then
        if not IsBusy then
            if inVehicle then
                QBCore.Functions.Notify("You Can't Repair the Engine From Inside the Vehicle")
                return
            end
    
            local kaput = GetEntityBoneIndexByName(vehicle, 'engine')
            local kaputkordinat = GetWorldPositionOfEntityBone(vehicle, kaput)
            
            if #(coords - kaputkordinat) <= 2.3 then
                if DoesEntityExist(vehicle) then
    
                    local time = 40000
                    for i=1, #mechanicLocation do
                        if #(GetEntityCoords(playerPed) - vector3(mechanicLocation[i].x, mechanicLocation[i].y, mechanicLocation[i].z)) < 150 then
                            time = 10000
                            break
                        end
                    end
                    
                    SetVehicleDoorOpen(vehicle, 4, 0, 0)
                    TaskStartScenarioInPlace(playerPed, "PROP_HUMAN_BUM_BIN", 0, true)
                    QBCore.Functions.Progressbar("vehicle_repair", "Vehicle is being repaired", time, false, true, { -- p1: menu name, p2: yazı, p3: ölü iken kullan, p4:iptal edilebilir
                        disableMovement = true,
                        disableCarMovement = true,
                        disableMouse = false,
                        disableCombat = true,
                    }, {}, {}, {}, function() -- Done
                        SetVehicleFixed(vehicle)
                        SetVehicleDeformationFixed(vehicle)
                        SetVehicleUndriveable(vehicle, false)
                        ClearPedTasksImmediately(playerPed)
                        QBCore.Functions.Notify("Repair Completed")
                        SetVehicleDoorShut(vehicle, 4, 0)
                        IsBusy = false
                    end, function() -- Cancel
                        IsBusy = false
                    end)
                
                end
            else
                QBCore.Functions.Notify("You Need To Be Close To The Engine For Repair")
            end
        end
    elseif data == "tamir2" then
        if not IsBusy then
            if inVehicle then
                QBCore.Functions.Notify("You Can't Repair the Vehicle From Inside the Vehicle")
                return
            end

            local veh = QBCore.Functions.GetVehicleInDirection()
            if veh == nil then QBCore.Functions.Notify("No Vehicle in Front!", "error") return end
            IsBusy = true

            local time = 74000
            for i=1, #mechanicLocation do
                if #(GetEntityCoords(playerPed) - vector3(mechanicLocation[i].x, mechanicLocation[i].y, mechanicLocation[i].z)) < 150 then
                    time = 11000
                    break
                end
            end
            
            SetEntityAsMissionEntity(veh, true, true)
            FreezeEntityPosition(veh, true)
            TaskTurnPedToFaceEntity(playerPed, veh, 1000)
            Citizen.Wait(1200)

            local offset = GetOffsetFromEntityInWorldCoords(playerPed, 0.0, -2.0, 0.0)
            local headin = GetEntityHeading(playerPed)
            local vehpos = GetEntityCoords(veh)
            local dict = 'mp_car_bomb'
            local model = 'prop_carjack'

            RequestAnimDict(dict)
            while not HasAnimDictLoaded(dict) or not HasModelLoaded(model) do
                RequestModel(model)
                Citizen.Wait(1)
            end
            
            local vehjack = CreateObject(GetHashKey(model), vehpos.x, vehpos.y, vehpos.z - 0.5, true, true, true)
            asycProgressbar(9250, "Vehicle Upgrade") -- TRANSLATE THIS, THAT SAY WHEN YOU PUT THE CRIC

            AttachEntityToEntity(vehjack, veh, 0, 0.0, 0.0, -1.0, 0.0, 0.0, 0.0, false, false, false, false, 0, true)
            TaskPlayAnimAdvanced(playerPed, dict, 'car_bomb_mechanic', coords, 0.0, 0.0, headin, 1.0, 0.5, 1250, 1, 0.0, 1, 1)
            Citizen.Wait(1250)
            SetEntityCoordsNoOffset(veh, vehpos.x, vehpos.y, vehpos.z + 0.01, true, true, true)
            TaskPlayAnimAdvanced(playerPed, dict, 'car_bomb_mechanic', coords, 0.0, 0.0, headin, 1.0, 0.5, 1000, 1, 0.25, 1, 1)
            Citizen.Wait(1000)
            SetEntityCoordsNoOffset(veh, vehpos.x, vehpos.y, vehpos.z + 0.025, true, true, true)
            TaskPlayAnimAdvanced(playerPed, dict, 'car_bomb_mechanic', coords, 0.0, 0.0, headin, 1.0, 0.5, 1000, 1, 0.25, 1, 1)
            Citizen.Wait(1000)
            SetEntityCoordsNoOffset(veh, vehpos.x, vehpos.y, vehpos.z + 0.05, true, true, true)
            TaskPlayAnimAdvanced(playerPed, dict, 'car_bomb_mechanic', coords, 0.0, 0.0, headin, 1.0, 0.5, 1000, 1, 0.25, 1, 1)
            Citizen.Wait(1000)
            SetEntityCoordsNoOffset(veh, vehpos.x, vehpos.y, vehpos.z + 0.1, true, true, true)
            TaskPlayAnimAdvanced(playerPed, dict, 'car_bomb_mechanic', coords, 0.0, 0.0, headin, 1.0, 0.5, 1000, 1, 0.25, 1, 1)
            Citizen.Wait(1000)
            SetEntityCoordsNoOffset(veh, vehpos.x, vehpos.y, vehpos.z + 0.15, true, true, true)
            TaskPlayAnimAdvanced(playerPed, dict, 'car_bomb_mechanic', coords, 0.0, 0.0, headin, 1.0, 0.5, 1000, 1, 0.25, 1, 1)
            Citizen.Wait(1000)
            SetEntityCoordsNoOffset(veh, vehpos.x, vehpos.y, vehpos.z + 0.2, true, true, true)
            TaskPlayAnimAdvanced(playerPed, dict, 'car_bomb_mechanic', coords, 0.0, 0.0, headin, 1.0, 0.5, 1000, 1, 0.25, 1, 1)
            Citizen.Wait(1000)
            SetEntityCoordsNoOffset(veh, vehpos.x, vehpos.y, vehpos.z + 0.3, true, true, true)
            TaskPlayAnimAdvanced(playerPed, dict, 'car_bomb_mechanic', coords, 0.0, 0.0, headin, 1.0, 0.5, 1000, 1, 0.25, 1, 1)
            local dict = 'move_crawl'
            Citizen.Wait(1000)
            SetEntityCoordsNoOffset(veh, vehpos.x, vehpos.y, vehpos.z + 0.4, true, true, true)
            TaskPlayAnimAdvanced(playerPed, dict, 'car_bomb_mechanic', coords, 0.0, 0.0, headin, 1.0, 0.5, 1000, 1, 0.25, 1, 1)
            SetEntityCoordsNoOffset(veh, vehpos.x, vehpos.y, vehpos.z + 0.5, true, true, true)
            SetEntityCollision(veh, false, false)
            TaskPedSlideToCoord(playerPed, offset, headin, 1000)
            Citizen.Wait(1500)
            while not HasAnimDictLoaded(dict) do
                RequestAnimDict(dict)
                Citizen.Wait(100)
            end
            asycProgressbar(time, "Araç Tamir Ediliyor") -- TRANSLATE THIS - THAT SAY WHEN YOU REPAIR THE VEHICLE
            TaskPlayAnimAdvanced(playerPed, dict, 'onback_bwd', coords, 0.0, 0.0, headin - 180, 1.0, 0.5, 3000, 1, 0.0, 1, 1)
            local dict = 'amb@world_human_vehicle_mechanic@male@base'
            Citizen.Wait(3000)
            RequestAnimDict(dict)
            while not HasAnimDictLoaded(dict) do
                Citizen.Wait(1)
            end
            TaskPlayAnim(playerPed, dict, 'base', 8.0, -8.0, time, 1, 0, false, false, false)
            dict = 'move_crawl'
            Citizen.Wait(time)
            local coords2 = GetEntityCoords(playerPed)
            RequestAnimDict(dict)
            while not HasAnimDictLoaded(dict) do
                Citizen.Wait(1)
            end
            TaskPlayAnimAdvanced(playerPed, dict, 'onback_fwd', coords2, 0.0, 0.0, headin - 180, 1.0, 0.5, 2000, 1, 0.0, 1, 1)
            Citizen.Wait(3000)
            local dict = 'mp_car_bomb'
            RequestAnimDict(dict)
            while not HasAnimDictLoaded(dict) do
                Citizen.Wait(1)
            end
            SetVehicleFixed(veh)
            SetVehicleDeformationFixed(veh)
            SetVehicleUndriveable(veh, false)
            SetVehicleEngineOn(veh, true, true)
            ClearPedTasksImmediately(playerPed)
            Citizen.Wait(500)
            asycProgressbar(8250, "Araç İndiriliyor") -- TLANSTALE THIS - THAT SAY WHEN YOU LEAVE THE CRIC
            TaskPlayAnimAdvanced(playerPed, dict, 'car_bomb_mechanic', coords, 0.0, 0.0, headin, 1.0, 0.5, 1250, 1, 0.0, 1, 1)
            Citizen.Wait(1250)
            SetEntityCoordsNoOffset(veh, vehpos.x, vehpos.y, vehpos.z + 0.4, true, true, true)
            TaskPlayAnimAdvanced(playerPed, dict, 'car_bomb_mechanic', coords, 0.0, 0.0, headin, 1.0, 0.5, 1000, 1, 0.25, 1, 1)
            Citizen.Wait(1000)
            SetEntityCoordsNoOffset(veh, vehpos.x, vehpos.y, vehpos.z + 0.3, true, true, true)
            TaskPlayAnimAdvanced(playerPed, dict, 'car_bomb_mechanic', coords, 0.0, 0.0, headin, 1.0, 0.5, 1000, 1, 0.25, 1, 1)
            Citizen.Wait(1000)
            SetEntityCoordsNoOffset(veh, vehpos.x, vehpos.y, vehpos.z + 0.2, true, true, true)
            TaskPlayAnimAdvanced(playerPed, dict, 'car_bomb_mechanic', coords, 0.0, 0.0, headin, 1.0, 0.5, 1000, 1, 0.25, 1, 1)
            Citizen.Wait(1000)
            SetEntityCoordsNoOffset(veh, vehpos.x, vehpos.y, vehpos.z + 0.15, true, true, true)
            TaskPlayAnimAdvanced(playerPed, dict, 'car_bomb_mechanic', coords, 0.0, 0.0, headin, 1.0, 0.5, 1000, 1, 0.25, 1, 1)
            Citizen.Wait(1000)
            SetEntityCoordsNoOffset(veh, vehpos.x, vehpos.y, vehpos.z + 0.1, true, true, true)
            TaskPlayAnimAdvanced(playerPed, dict, 'car_bomb_mechanic', coords, 0.0, 0.0, headin, 1.0, 0.5, 1000, 1, 0.25, 1, 1)
            Citizen.Wait(1000)
            SetEntityCoordsNoOffset(veh, vehpos.x, vehpos.y, vehpos.z + 0.05, true, true, true)
            TaskPlayAnimAdvanced(playerPed, dict, 'car_bomb_mechanic', coords, 0.0, 0.0, headin, 1.0, 0.5, 1000, 1, 0.25, 1, 1)
            Citizen.Wait(1000)
            SetEntityCoordsNoOffset(veh, vehpos.x, vehpos.y, vehpos.z + 0.025, true, true, true)
            TaskPlayAnimAdvanced(playerPed, dict, 'car_bomb_mechanic', coords, 0.0, 0.0, headin, 1.0, 0.5, 1000, 1, 0.25, 1, 1)
            local dict = 'move_crawl'
            Citizen.Wait(1000)
            SetEntityCoordsNoOffset(veh, vehpos.x, vehpos.y, vehpos.z + 0.01, true, true, true)
            TaskPlayAnimAdvanced(playerPed, dict, 'car_bomb_mechanic', coords, 0.0, 0.0, headin, 1.0, 0.5, 1000, 1, 0.25, 1, 1)
            SetEntityCoordsNoOffset(veh, vehpos.x, vehpos.y, vehpos.z, true, true, true)
            FreezeEntityPosition(veh, false)
            DeleteObject(vehjack)
            SetEntityCollision(veh, true, true)
            IsBusy = false
        end
    elseif data == "temizle" then
        if DoesEntityExist(vehicle) and mesafe < 2 then
            TaskStartScenarioInPlace(playerPed, 'WORLD_HUMAN_MAID_CLEAN', 0, true)
            Citizen.Wait(10000)
            SetVehicleDirtLevel(vehicle, 0)
            ClearPedTasksImmediately(playerPed)
            QBCore.Functions.Notify('Vehicle Cleaned!')
        else
            QBCore.Functions.Notify('No Vehicles Nearby')
        end	
    elseif data == "yukleyici" then
        if mesafe < 4.0 then
            TriggerEvent("tgiann-meslekmekanik:yukleyici", vehicle)
        else
            QBCore.Functions.Notify('No Vehicles Nearby')
        end
    elseif data == "iyilestir" then
        if not found then 
            QBCore.Functions.Notify(text["noClosestPlayer"], "error")
            return 
        end
	    TriggerEvent("esx_ambulancejob:TgiannCanlandir", player)
    elseif data == "emsFatura" then
        TriggerEvent("emsFatura:Kes")
        if not found then 
            QBCore.Functions.Notify(text["noClosestPlayer"], "error")
            return 
        end
	    TriggerEvent("tgiann-ambulance:billing", player)
    elseif data == "tedavi" then
        if not found then 
            QBCore.Functions.Notify(text["noClosestPlayer"], "error")
            return 
        end
	    TriggerEvent("tgiann-ambulance:openBodyDamageMenu", player)
    elseif data == "igne" then
        if not found then 
            QBCore.Functions.Notify(text["noClosestPlayer"], "error")
            return 
        end
        TriggerEvent("esx_ambulancejob:TgiannIgne", player)
    elseif data == "kucakla" then
        ExecuteCommand("kucakla")
    elseif data == "sirtla" then
        ExecuteCommand("sirtla")
    elseif data == "tasi" then
        ExecuteCommand("taşı")
    elseif data == "rehinal" then
        TriggerEvent("esx_barbie_lyftupp:TgiannRehinAl")
    elseif data == "ktasi" then
        TriggerEvent("tgiann-kelepce:tasi")
    elseif data == "kbindir" then
        TriggerEvent("tgiann-kelepce:arac")
    elseif data == "ybindir" then
        TriggerEvent("tgiann-kelepce:client:ybindir")
    elseif data == "garaj" then
        TriggerEvent("tgiann-garaj:blipAcKapa")
    elseif data == "tgiannjob" then
        TriggerEvent("kfzeu-meat-farm:blipAcKapa")
        TriggerEvent("kfzeu-meat-farm:blipAcKapa2")
    elseif data == "kiyafet" then
        TriggerEvent("esx_eden_clotheshop:blipAcKapa")
    elseif data == "dovme" then
        TriggerEvent("tattoo:blipAcKapa")
    elseif data == "kuafor" then
        TriggerEvent("esx_barbershop:blipAcKapa")
    elseif data == "gazist" then
        TriggerEvent("LegacyFuel:blipAcKapa")
    elseif data == "bank" then
        TriggerEvent("new_banking:blipAcKapa")
    elseif data == "market" then
        TriggerEvent("market:blipAcKapa")
    elseif data == "aracislemleri" then
        TriggerEvent("tgiann-carcontrol:open")
    elseif data == "kiyafetislemleri" then
        TriggerEvent("kiyafetislemleri")
    elseif data == "clotheOpen" then
        TriggerEvent("raidClothing:clothingShop")
    elseif data == "barberOpen" then
        TriggerEvent("raidClothing:barberMenu")   
    elseif data == "dovmeOpen" then
        TriggerEvent("raidClothing:tattoMenu")   
 elseif data == "sapka" then
        TriggerEvent("qb-clothing:client:adjustfacewear", 3)
    elseif data == "maske" then
        TriggerEvent("qb-clothing:client:adjustfacewear", 2)
    elseif data == "eldiven" then
        TriggerEvent("qb-clothing:client:adjustfacewear", 1)
    elseif data == "gozluk" then
        TriggerEvent("qb-clothing:client:adjustfacewear", 4)
    elseif data == "tisort" then
        TriggerEvent("qb-clothing:client:adjustfacewear", 5)
    elseif data == "canta" then
        TriggerEvent("qb-clothing:client:adjustfacewear", 6)
    elseif data == "pantalon" then
        TriggerEvent("qb-clothing:client:adjustfacewear", 7)
    elseif data == "ayakkabi" then
        TriggerEvent("qb-clothing:client:adjustfacewear", 8)
    elseif data == "zirh" then
        TriggerEvent("qb-clothing:client:adjustfacewear", 9)
    elseif data == "kimlikislemleri" then
        TriggerEvent("kimlikislemleri")
    elseif data == "anahtarver" then
        TriggerEvent("x-hotwire:tgiannf3inahtar")
    elseif data == "bgir" then
        bagajgir()
    elseif data == "copicibak" then
        local nearGarbage = checkNearGarbage()
        if nearGarbage then
            TriggerEvent("inventory:openInventoryAnim")
            local id = ObjToNet(nearGarbage)
            Wait(600)
            TriggerEvent("inventory:client:SetCurrentStash", "trash_"..id, QBCore.Key)
            TriggerServerEvent("inventory:server:OpenInventory", "stash", "trash_"..id, {maxweight = 20000,slots = 5})
        end
    elseif data == "copkaristir" then
        if not copKaristirCD then
            copKaristirCD = true
            QBCore.Functions.Progressbar("cop_kariştir", "You're Mixing the Trash", 10000, false, true, { -- p1: menu name, p2: yazı, p3: ölü iken kullan, p4:iptal edilebilir
                disableMovement = false,
                disableCarMovement = false,
                disableMouse = false,
                disableCombat = true,
            }, {
                animDict = "amb@prop_human_bum_bin@base",
                anim = "base",
                flags = 33,
            }, {}, {}, function() -- Done
                TriggerServerEvent("tgiann-menu:cop-esyasi-ver", QBCore.Key)
            end, function() -- Cancel
            end)
        else
            QBCore.Functions.Notify('You Can Mix a Trash Every 30 Seconds!')
        end
     elseif data == "gpsac" then
        TriggerEvent("tgiann-menuv2:gpsac")
     elseif data == "gpskapa" then
         TriggerEvent("tgiann-menuv2:gpskapat")
    elseif data == "tersduz" then
        TriggerEvent("ters-duz")
    elseif data == "anim" then
        TriggerEvent("dpemotes:animation-menu")
    elseif data == "yuruyus" then
        TriggerEvent("yuruyus")
    -- elseif data == "yarali" then
    --     TriggerEvent("dpemotes:set-walk", "Yaralı")
    elseif data == "emsbildirim" then
        TriggerEvent("emsbildirimgonder")
    elseif data == "polisbildirim" then
        TriggerEvent("polisyarali")
    elseif data == "lisanskontrol" then
        if not found then return end
        TriggerEvent("esx_policejob:lisanskontrol", player)
    elseif data == "yatak1" then
        TriggerEvent("ChairBedSystem:Client:yatak-yatir", "back", animYatak)
    elseif data == "yatak2" then
        TriggerEvent("ChairBedSystem:Client:yatak-yatir", "stomach", animYatak)
    elseif data == "yatak3" then
        TriggerEvent("ChairBedSystem:Client:yatak-yatir", "sit", animYatak)
    elseif data == "koltuk" then
        TriggerEvent("ChairBedSystem:Client:yatak-yatir", false, false)
    elseif data == "garajOpen" then
        TriggerEvent("tgiann-garaj:open")
    elseif data == "poleDance" then
        TriggerEvent("esx_lapdance:nightClubPoleDance")
    elseif data == "clotheOpen" then
        TriggerEvent("qb-clothing:open")
    elseif data == "interactionTriggered" then
        TriggerEvent("housing:interactionTriggered")
    elseif data == "toggleClosestLock" then
        TriggerEvent("housing:toggleClosestLock")
    elseif data == "triggerbuyhouse" then
        TriggerEvent("triggerbuy-house")
    end
end

function ObjectInFront(ped, pos)
	local entityWorld = GetOffsetFromEntityInWorldCoords(ped, 0.0, 1.5, 0.0)
	local car = CastRayPointToPoint(pos.x, pos.y, pos.z, entityWorld.x, entityWorld.y, entityWorld.z, 30, ped, 0)
	local _, _, _, _, result = GetRaycastResult(car)
	return result
end

function asycProgressbar(time, text)
    Citizen.CreateThread(function()
        QBCore.Functions.Progressbar("ozel_name", text, time, false, false, { -- p1: menu name, p2: yazı, p3: ölü iken kullan, p4:iptal edilebilir
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        }, {}, {}, {}, function() -- Done
        end, function() -- Cancel
        end)
    end)
end

local hashBin = {
    1437508529,
    -819563011,
    -289082718,
    1437508529,
    1614656839,
    -289082718,
    1437508529,
    1614656839,
    -130812911,
    -93819890,
    1329570871,
    1143474856,
    -228596739,
    -468629664,
    -1426008804,
    -1187286639,
    -1096777189,
    -413198204,
    437765445,
    122303831,
    1748268526,
    998415499,
    234941195,
    -2096124444,
    1792999139,
    -341442425,
    -329415894,
    -1830793175,
    -654874323,
    1010534896,
    651101403,
    909943734,
    1919238784,
    274859350,
    751349707,
    1627301588,
    1388415578,
    1813879595,
    1098827230,
    1388308576,
    600967813,
    1948359883,
    -1681329307,
    -96647174,
    811169045,
    -14708062,
    354692929,
    673826957,
    375956747,
    1233216915,
    -85604259,
    -115771139,
    -1998455445,
    577432224,
    684586828,
    218085040,
    666561306,
    -58485588,
    -206690185,
    1511880420,
    682791951,
    -1587184881
}

RegisterCommand("copicibak", function()
    local nearGarbage = checkNearGarbage()
    if nearGarbage then
        local id = ObjToNet(nearGarbage)
        TriggerEvent("inventory:client:SetCurrentStash", "trash_"..id, QBCore.Key)
        TriggerServerEvent("inventory:server:OpenInventory", "stash", "trash_"..id, {maxweight = 20000,slots = 5})
    end
end)

RegisterNetEvent("copebakla", function()
    local nearGarbage = checkNearGarbage()
    if nearGarbage then
        local id = ObjToNet(nearGarbage)
        TriggerEvent("inventory:client:SetCurrentStash", "trash_"..id, QBCore.Key)
        TriggerServerEvent("inventory:server:OpenInventory", "stash", "trash_"..id, {maxweight = 20000,slots = 5})
    end
end)

function checkNearGarbage()
    local found = false
    local Ped = PlayerPedId()
    local Entity, Dist = QBCore.Functions.GetClosestObject()
    if Dist < 2 then
        for i=1, #hashBin do
            if GetEntityModel(Entity) == hashBin[i] then
                found = Entity
                break
            end
        end
    end
    return found
end


RegisterNetEvent('ters-duz')
AddEventHandler('ters-duz', function()
    local playerped = PlayerPedId()
    if not IsPedInAnyVehicle(playerped) then
        local PlayerCoords = GetEntityCoords(playerped)
        local arac, mesafe = QBCore.Functions.GetClosestVehicle(PlayerCoords)
        if mesafe < 5 then
            QBCore.Functions.Progressbar("ters-duz", "Vehicle is Flipping", 5000, false, true, { -- p1: menu name, p2: yazı, p3: ölü iken kullan, p4:iptal edilebilir
                disableMovement = true,
                disableCarMovement = true,
                disableMouse = false,
                disableCombat = true,
            }, {}, {}, {}, function() -- Done
                SetVehicleOnGroundProperly(arac)
            end, function() -- Cancel
            end)
        else
            QBCore.Functions.Notify(text["noClosestCar"]) 
        end
	else
		QBCore.Functions.Notify("You cannot perform this operation while in the vehicle.") 
	end
end)

RegisterNetEvent("tgiann-menuv2:gpskapat")
AddEventHandler("tgiann-menuv2:gpskapat", function()
	QBCore.Functions.TriggerCallback('elixir-base:item-kontrol', function(qtty)
		if qtty > 0 then
			TriggerServerEvent('tgiann-gps:acikgps-kapat', false)
		else
			QBCore.Functions.Notify('No GPS On!')	
		end
	end, 'gps')	
end)

Citizen.CreateThread(function ()
	while true do
		Citizen.Wait(1000)
		if copKaristirCD then
			Citizen.Wait(120000) -- 2 dakika
			copKaristirCD = false
		end 
	end
end)

local offsets = {
	[1] = { ["name"] = "taxi", ["yoffset"] = 0.0, ["zoffset"] = -0.5 },
    [2] = { ["name"] = "buccaneer", ["yoffset"] = 0.5, ["zoffset"] = 0.0 },
    [3] = { ["name"] = "peyote", ["yoffset"] = 0.35, ["zoffset"] = -0.15 },
    [4] = { ["name"] = "regina", ["yoffset"] = 0.2, ["zoffset"] = -0.35 },
    [5] = { ["name"] = "pigalle", ["yoffset"] = 0.2, ["zoffset"] = -0.15 },
    [6] = { ["name"] = "glendale", ["yoffset"] = 0.0, ["zoffset"] = -0.35 },
}

RegisterNetEvent('tgiann-menu:bgir')
AddEventHandler('tgiann-menu:bgir', function()
    bagajgir()
end)

function bagajgir()
	local vehicle, mesafe = QBCore.Functions.GetClosestVehicle(GetEntityCoords(PlayerPedId()))
	if mesafe < 3 then
		local trunk = GetEntityBoneIndexByName(vehicle, 'boot')
		if trunk ~= -1 then
			if GetVehicleDoorAngleRatio(vehicle, 5) > 0 then
				local coords = GetWorldPositionOfEntityBone(vehicle, trunk)
				if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), coords, true) <= 2.5 then
					local d1,d2 = GetModelDimensions(GetEntityModel(vehicle))
					local OffSet = TrunkOffset(vehicle)
					if OffSet > 0 then
						AttachEntityToEntity(PlayerPedId(), vehicle, 0, -0.1,(d1["y"]+0.85) + offsets[OffSet]["yoffset"],(d2["z"]-0.87) + offsets[OffSet]["zoffset"], 0, 0, 40.0, 1, 1, 1, 1, 1, 1)
					else
						AttachEntityToEntity(PlayerPedId(), vehicle, 0, -0.1,d1["y"]+0.85,d2["z"]-0.87, 0, 0, 40.0, 1, 1, 1, 1, 1, 1)
					end

					loadAnimDict('fin_ext_p1-7')
					TaskPlayAnim(PlayerPedId(), 'fin_ext_p1-7', 'cs_devin_dual-7', 8.0, -8.0, -1, 1, 0, false, false, false)
					inTrunk = true

                    while inTrunk do
                        Citizen.Wait(0)
                        disableInTrunkControl()
                        local vehicle = GetEntityAttachedTo(PlayerPedId())
                        exports['qb-ui']:showInteraction("[F] Exit Luggage", nil, "bagaj")
                        if DoesEntityExist(vehicle) or not IsPedDeadOrDying(PlayerPedId()) or not IsPedFatallyInjured(PlayerPedId()) then
                            local coords = GetWorldPositionOfEntityBone(vehicle, GetEntityBoneIndexByName(vehicle, 'boot'))
                            if GetVehicleDoorAngleRatio(vehicle, 5) > 0.0 then
                                if not IsEntityPlayingAnim(PlayerPedId(), 'fin_ext_p1-7', 3) then
                                    loadAnimDict('fin_ext_p1-7')
                                    TaskPlayAnim(PlayerPedId(), 'fin_ext_p1-7', 'cs_devin_dual-7', 8.0, -8.0, -1, 1, 0, false, false, false)
                                    SetEntityVisible(PlayerPedId(), true)
                                end
                            else
                                SetEntityVisible(PlayerPedId(), false)
                            end
                            if IsControlJustReleased(0, 49) and inTrunk then
                                if GetVehicleDoorAngleRatio(vehicle, 5) > 0 then
                                    inTrunk = false
                                    exports['qb-ui']:hideInteraction("bagaj")
                                    DetachEntity(PlayerPedId(), true, true)
                                    while not IsEntityVisible(PlayerPedId()) do
                                        Wait(1)
                                        SetEntityVisible(PlayerPedId(), true)
                                    end
                                    ClearPedTasks(PlayerPedId())
                                    SetEntityCoords(PlayerPedId(), GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, -0.5, -0.75))
                                    SetFollowPedCamViewMode(1)
                                    SetFollowVehicleCamViewMode(14)
                                else
                                    QBCore.Functions.Notify('Tailgate Not Open!')
                                end
                            end
                        else
                            exports['qb-ui']:hideInteraction("bgir")
                            DetachEntity(PlayerPedId(), true, true)
                            SetEntityVisible(PlayerPedId(), false, 0)
                            ClearPedTasks(PlayerPedId())
                            SetEntityCoords(PlayerPedId(), GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, -0.5, -0.75))
                        end
                    end
				else
					QBCore.Functions.Notify('Youre Too Far From The Luggage To Get In The Luggage!')		
				end
			else
				QBCore.Functions.Notify('Trunk Lid Not Open!')
			end
		end
	else
		QBCore.Functions.Notify('No Vehicles Nearby!')		
	end
end

Citizen.CreateThread(function()
    RegisterKeyMapping('+ragdoll', 'Ragdoll', 'keyboard', 'u')
end)

RegisterCommand("+ragdoll", function()
    if not exports["high_phone"]:phoneIsOpen() then 
        if not IsPedInAnyVehicle(PlayerPedId()) and not IsEntityPlayingAnim(PlayerPedId(), "re@construction", "out_of_breath", 1) then
            exports['qb-ui']:hideInteraction("kalk")
            isInRagdoll = not isInRagdoll
            while isInRagdoll and not isDead do

                exports['qb-ui']:showInteraction("[U] Stand UP", nil, "kalk")
                Citizen.Wait(1)
                SetPedToRagdoll(PlayerPedId(), 1000, 1000, 0, 0, 0, 0)
            end
        end
    end
end)

function TrunkOffset(veh)
    for i=1,#offsets do
        if GetEntityModel(veh) == GetHashKey(offsets[i]["name"]) then
            return i
        end
    end
    return 0
end

function deleteVeh(veh)
	SetVehicleHasBeenOwnedByPlayer(veh, true)
	NetworkRequestControlOfEntity(veh)
	TaskStartScenarioInPlace(PlayerPedId(), 'CODE_HUMAN_MEDIC_TEND_TO_DEAD', 0, true)

	-- QBCore.Functions.Progressbar("arac_cek", "Araç Çekiliyor...", 3000, false, false, { -- p1: menu name, p2: yazı, p3: ölü iken kullan, p4:iptal edilebilir
	-- 	disableMovement = true,
	-- 	disableCarMovement = true,
	-- 	disableMouse = false,
	-- 	disableCombat = true,
	-- }, {}, {}, {}, function() -- Done
	-- 	Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(veh))
	-- 	DeleteEntity(veh)
	-- 	DeleteVehicle(veh)
	-- 	SetEntityAsNoLongerNeeded(veh)
    --     ClearPedTasksImmediately(PlayerPedId()) 
	-- end, function() -- Cancel
	-- 	ClearPedTasksImmediately(PlayerPedId()) 
	-- end)
end

function loadAnimDict(dict)
	RequestAnimDict(dict)
	while not HasAnimDictLoaded(dict) do
		Citizen.Wait(500)
	end
end

function GetClosestPlayerMenu()
	local player, distance = QBCore.Functions.GetClosestPlayer()
	if distance ~= -1 and distance <= 3.0 then
		return true, GetPlayerServerId(player)
	else
		return false
	end
end

RegisterNetEvent('tgiann-menu:kilitacma')
AddEventHandler('tgiann-menu:kilitacma', function()
	local Ped = PlayerPedId()
	RequestAnimDict("veh@break_in@0h@p_m_one@")
	while not HasAnimDictLoaded("veh@break_in@0h@p_m_one@") do
		Citizen.Wait(0)
	end
	while kilitac do
		TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 3.0, 'lockpick', 0.4)
		TaskPlayAnim(Ped, "veh@break_in@0h@p_m_one@", "low_force_entry_ds", 1.0, 1.0, 1.0, 16, 0.0, 0, 0, 0)
		Citizen.Wait(2000)
		ClearPedTasks(Ped)
		TaskPlayAnim(Ped, "veh@break_in@0h@p_m_one@", "low_force_entry_ds", 1.0, 1.0, 1.0, 16, 0.0, 0, 0, 0)
		Citizen.Wait(2000)
		ClearPedTasks(Ped)
		TaskPlayAnim(Ped, "veh@break_in@0h@p_m_one@", "low_force_entry_ds", 1.0, 1.0, 1.0, 16, 0.0, 0, 0, 0)
		Citizen.Wait(2000)
		ClearPedTasks(Ped)
		TaskPlayAnim(Ped, "veh@break_in@0h@p_m_one@", "low_force_entry_ds", 1.0, 1.0, 1.0, 16, 0.0, 0, 0, 0)
		Citizen.Wait(2000)
	end
	ClearPedTasks(Ped)
end)

RegisterNetEvent('tgiann-menuv3:arac-cek')
AddEventHandler('tgiann-menuv3:arac-cek', function()
    if PlayerData.job.name == "police" or string.find(PlayerData.job.name, "mechanic") then
        local playerPed = PlayerPedId()
        local coords = GetEntityCoords(playerPed)
        local vehicle, mesafe = QBCore.Functions.GetClosestVehicle(coords)
        if mesafe < 5 then
            if not inVehicle then
                if DoesEntityExist(vehicle) then
                    deleteVeh(vehicle)
                    TriggerServerEvent("menu:TgiannParaVer")
                end
            end
        end
    else
        QBCore.Functions.Notify("You Are Not a Police")
    end
end)

function disableInTrunkControl()
	local playerPed = PlayerPedId()
	DisablePlayerFiring(playerPed, true)

	SetFollowPedCamViewMode(0)
	SetFollowVehicleCamViewMode(0)
	DisableControlAction(2, 244, true) -- M
	DisableControlAction(0, 24, true) -- Attack
	DisableControlAction(0, 257, true) -- Attack 2
	DisableControlAction(0, 25, true) -- Aim
	DisableControlAction(0, 263, true) -- Melee Attack 1
	DisableControlAction(0, 37, true) -- Select Weapon

	DisableControlAction(0, 56, true) -- F9
	DisableControlAction(0, 45, true) -- Reload
	DisableControlAction(0, 22, true) -- Jump
	DisableControlAction(0, 44, true) -- Cover

	DisableControlAction(0, 289, true) -- F2
	DisableControlAction(0, 170, true) -- F3
	DisableControlAction(0, 167, true) -- F6

	DisableControlAction(0, 0, true) -- Disable changing view
	DisableControlAction(0, 26, true) -- Disable looking behind
	DisableControlAction(0, 73, true) -- Disable clearing animation

	DisableControlAction(0, 59, true) -- Disable steering in vehicle
	DisableControlAction(0, 71, true) -- Disable driving forward in vehicle
	DisableControlAction(0, 72, true) -- Disable reversing in vehicle

	DisableControlAction(0, 47, true)  -- Disable weapon
	DisableControlAction(0, 264, true) -- Disable melee
	DisableControlAction(0, 257, true) -- Disable melee
	DisableControlAction(0, 140, true) -- Disable melee
	DisableControlAction(0, 141, true) -- Disable melee
	DisableControlAction(0, 142, true) -- Disable melee
	DisableControlAction(0, 143, true) -- Disable melee
	DisableControlAction(0, 75, true)  -- Disable exit vehicle
	DisableControlAction(0, 301, true)  -- Disable exit vehicle
	DisableControlAction(27, 75, true) -- Disable exit vehicle
end

-- Camera's coords
function GetCoordsFromCam(distance)
	local rot = GetGameplayCamRot(2)
	local coord = GetGameplayCamCoord()

	local tZ = rot.z * 0.0174532924
	local tX = rot.x * 0.0174532924
	local num = math.abs(math.cos(tX))

	newCoordX = coord.x + (-math.sin(tZ)) * (num + distance)
	newCoordY = coord.y + (math.cos(tZ)) * (num + distance)
	newCoordZ = coord.z + (math.sin(tX) * 8.0)
	return newCoordX, newCoordY, newCoordZ
end

RegisterNetEvent('kiyafetislemleri')
AddEventHandler('kiyafetislemleri', function()       
    exports['qb-menu']:openMenu({
		{
            header = "Clothing Transactions",
			icon = "fas fa-user-circle",
            isMenuHeader = true
        },
        {
            header = " T-shirt Wear/Take Off",
			icon = "fas fa-tshirt",
            -- txt = "" .. PlayerData.charinfo.firstname .. " " .. PlayerData.charinfo.lastname .. " İsimli Kimliğini İncele",
			isServer = false,
            params = {
                event = "tshirt",
            }
        },
        {
            header = "Put on/Take off your pants",
			icon = "fas fa-columns",
        --    txt = "" .. PlayerData.charinfo.firstname .. " " .. PlayerData.charinfo.lastname .. " İsimli Kimliği Yakınındakine Ver",
			isServer = false,
            params = {
                event = "pants",
            }
        },
        {
            header = "Put on/Take off your shoes",
			icon = "fas fa-shoe-prints",
			isServer = false,
            params = {
				event = "shoe",
            }
        },
		{
            header = "Put On/Remove Your Glasses",
			icon = "fas fa-glasses",
          --  txt = "" .. PlayerData.charinfo.firstname .. " " .. PlayerData.charinfo.lastname .. " İsimli Ehliyeti Yakınıdaki Kişiye Ver",
			isServer = false,
            params = {
				event = "glasses",
            }
        },
		{
            header = "Put On/Take Off Your Mask",
			icon = "fas fa-mask",
          --  txt = "" .. PlayerData.charinfo.firstname .. " " .. PlayerData.charinfo.lastname .. " İsimli Ehliyeti Yakınıdaki Kişiye Ver",
			isServer = false,
            params = {
				event = "mask",
            }
        },
		{
            header = "Put on/Take off your hat",
			icon = "fas fa-graduation-cap",
          --  txt = "" .. PlayerData.charinfo.firstname .. " " .. PlayerData.charinfo.lastname .. " İsimli Ehliyeti Yakınıdaki Kişiye Ver",
			isServer = false,
            params = {
				event = "hat",
            }
        },
		{
            header = "Put On/Take Off Your Gloves",
          --  txt = "" .. PlayerData.charinfo.firstname .. " " .. PlayerData.charinfo.lastname .. " İsimli Ehliyeti Yakınıdaki Kişiye Ver",
		  	icon = "fas fa-mitten",
			isServer = false,
            params = {
				event = "glove",
            }
        },
		{
            header = "Wear/Remove Your Bag",
			icon = "fas fa-briefcase",
          --  txt = "" .. PlayerData.charinfo.firstname .. " " .. PlayerData.charinfo.lastname .. " İsimli Ehliyeti Yakınıdaki Kişiye Ver",
			isServer = false,
            params = {
				event = "bag",
            }
        },
		{
            header = "Wear/Remove Armor Accessory",
			icon = "fas fa-user-shield",
          --  txt = "" .. PlayerData.charinfo.firstname .. " " .. PlayerData.charinfo.lastname .. " İsimli Ehliyeti Yakınıdaki Kişiye Ver",
			isServer = false,
            params = {
				event = "armor",
            }
        },
    })
end)

RegisterNetEvent('inventory:openInventoryAnim')
AddEventHandler('inventory:openInventoryAnim', function(sI)
    local playerPed = PlayerPedId()
    if not IsEntityPlayingAnim(playerPed, 'pickup_object', 'putdown_low', 3) then
        QBCore.Shared.RequestAnimDict('pickup_object', function()
            TaskPlayAnim(playerPed, 'pickup_object', 'putdown_low', 1.0, -1.0, 1000, 49, 1, false, false, false)
            Wait(1000)
            ClearPedSecondaryTask(playerPed)
        end)
    end
end)

RegisterNetEvent("tunnerchip:arastir", function()
	local playerPed = PlayerPedId()
    local coords = GetEntityCoords(playerPed)
    local vehicle = QBCore.Functions.GetClosestVehicle(coords)
	QBCore.Functions.TriggerCallback('carmod:isChiped', function(chiped)
		if chiped then
			QBCore.Functions.Notify("Tunner Chip Installed in Vehicle")
		else
			QBCore.Functions.Notify("Vehicle Clean")
		end
	end, GetVehicleNumberPlateText(vehicle))
end)

RegisterNetEvent("tunnerchip:soru", function()
    exports['qb-menu']:openMenu({
        {
            icon = "fas fa-car-alt",
            header = "Illegal Modifications",
            txt = "Remove Racing Chip",
			isServer = false,
            params = {
                event = "tunnerchip:sök",
            }
        },
        {
            header = "Close",
            icon = "fas fa-times",
			isServer = false,
            params = {
                event = "qb-menu:closeMenu",
            }
        },
    })
end)

RegisterNetEvent("tunnerchip:sök", function()
    local playerPed = PlayerPedId()
    local coords = GetEntityCoords(playerPed)
    local vehicle = QBCore.Functions.GetClosestVehicle(coords)
    QBCore.Functions.TriggerCallback('carmod:isChiped', function(chiped)
        if chiped then
            QBCore.Functions.Notify("Vehicle Clean")
        else
            QBCore.Functions.Notify("Tunner Chip Installed in Vehicle")
            Wait(100)
			QBCore.Functions.Progressbar("vehicle_repair", "Chip Removing", 16000, false, true, { -- p1: menu name, p2: yazı, p3: ölü iken kullan, p4:iptal edilebilir
			disableMovement = true,
		disableCarMovement = true,
		disableMouse = false,
		disableCombat = true,
	}, {
		animDict = "amb@prop_human_bum_bin@base",
		anim = "base",
		flags = 128,
	}, {}, {}, function() -- Done
		TriggerServerEvent("carmod:chipRemove", GetVehicleNumberPlateText(vehicle))
				QBCore.Functions.Notify("illegal Modifiye Söküldü")
		end, GetVehicleNumberPlateText(vehicle))
        end
	end, function() -- Cancel
		QBCore.Functions.Notify('Transaction Canceled', "error")
	end)
end)



RegisterNetEvent("camfilm:arastir", function()
    local yasaktint = {
        1,2,3
    }
    local playerPed = PlayerPedId()
    local coords = GetEntityCoords(playerPed)
    local arac = GetVehiclePedIsIn(PlayerPedId(),false)
    local araba = QBCore.Functions.GetClosestVehicle(coords)
    for k,v in pairs(yasaktint) do
        if not IsPedInAnyVehicle(playerPed) then
            TaskStartScenarioInPlace(PlayerPedId(), 'CODE_HUMAN_MEDIC_TEND_TO_DEAD', 0, true)
            QBCore.Functions.Progressbar("camfilmcheck", "Checking Film Window", 16000, false, true, { -- p1: menu name, p2: yazı, p3: ölü iken kullan, p4:iptal edilebilir
                disableMovement = true,
                disableCarMovement = true,
                disableMouse = false,
                disableCombat = true,
            }, {
                animDict = "",
                anim = "",
                flags = 128,
            }, {}, {}, function() -- Done
                if v == GetVehicleWindowTint(araba) then
                    QBCore.Functions.Notify("Window film available.")
                    TriggerEvent("WindowFilm:soru")
                    ClearPedTasksImmediately(playerPed)
                else
                    QBCore.Functions.Notify("There is no window film in the vehicle.!")
                    ClearPedTasksImmediately(playerPed)
                end
            end)
        else
            ClearPedTasksImmediately(playerPed)
            QBCore.Functions.Notify("You cannot control from inside the vehicle.!")
        end
    end
end)

RegisterNetEvent("WindowFilm:soru", function()
    exports['qb-menu']:openMenu({
        {
            icon = "fas fa-car-alt",
            header = "Remove Window Film",
            txt = "Remove 3rd Degree Window Film",
			isServer = false,
            params = {
                event = "WindowFilm:sik",
            }
        },
        {
            header = "Close",
            icon = "fas fa-times",
			isServer = false,
            params = {
                event = "qb-menu:closeMenu",
            }
        },
    })
end)

-- RegisterCommand("soksene", function()
RegisterNetEvent("WindowFilm:sik", function()
    local playerPed = PlayerPedId()
    local coords = GetEntityCoords(playerPed)
    local arac = GetVehiclePedIsIn(PlayerPedId(),false)
    local araba = QBCore.Functions.GetClosestVehicle(coords)
        if not IsPedInAnyVehicle(playerPed) then
            Wait(500)
            QBCore.Functions.Progressbar("camfilmcheck", "Window Film is Removing", 16000, false, true, { -- p1: menu name, p2: yazı, p3: ölü iken kullan, p4:iptal edilebilir
                disableMovement = true,
                disableCarMovement = true,
                disableMouse = false,
                disableCombat = true,
            }, {
                animDict = "mini@repair",
                anim = "fixing_a_player",
                flags = 49,
            }, {}, {}, function() -- Done
                SetVehicleWindowTint(araba, 0)
                TriggerServerEvent('updateVehicle', QBCore.Functions.GetVehicleProperties(araba))  
                QBCore.Functions.Notify("Window Film Removed")
            end)
        else
            QBCore.Functions.Notify("You cannot do this in the vehicle.")
        end
end)





RegisterCommand("hat", function()
    TriggerEvent("qb-clothing:client:adjustfacewear", 3)
end)

RegisterCommand("mask", function()
    TriggerEvent("qb-clothing:client:adjustfacewear", 2)
end)


RegisterCommand("glove", function()
    TriggerEvent("qb-clothing:client:adjustfacewear", 1)
end)


RegisterCommand("glasses", function()
    TriggerEvent("qb-clothing:client:adjustfacewear", 4)
end)


RegisterCommand("tshirt", function()
    TriggerEvent("qb-clothing:client:adjustfacewear", 5)
end)


RegisterCommand("bag", function()
    TriggerEvent("qb-clothing:client:adjustfacewear", 6)
end)


RegisterCommand("pants", function()
    TriggerEvent("qb-clothing:client:adjustfacewear", 7)
end)

RegisterCommand("shoe", function()
    TriggerEvent("qb-clothing:client:adjustfacewear", 8)
end)

RegisterCommand("armor", function()
    TriggerEvent("qb-clothing:client:adjustfacewear", 9)
end)

CreateThread(function()
    local police = vector3(442.75, -982.01, 29.69)
    local policeH = 88.61
    exports["elixir-base"]:pedcreate("pdlobi", 0x5E3DA4A4, police.x, police.y, police.z,  policeH)
end)

RegisterNetEvent("mekanik:shop")
AddEventHandler("mekanik:shop", function()
    local PlayerData = QBCore.Functions.GetPlayerData()
    if PlayerData.job and PlayerData.job.name == "mehanic_bennys" or PlayerData.job.name == "mechanic" or PlayerData.job.name == "mechanic_hayes" or PlayerData.job.name == "mechanic_tunner" or PlayerData.job.name == "mechanic_gabz" then
        TriggerServerEvent("inventory:server:OpenInventory", "shop", "all", Config.MekanikMarket)
    else
        QBCore.Functions.Notify('You cant access here!', 'error', 7500)
    end
end)
Config = {}
Config.MekanikMarket = {
    label = "Mechanic Products",
    slots = 20,
    items = {
    {
        name = "nos",
        amount = 1,
        type = "item",
        slot = 1,
        price = 500,
    },
    {
        name = "tunner_chip",
        amount = 1,
        type = "item",
        slot = 2,
        price = 5000,
    },
    {
        name = "fixkit",
        amount = 1,
        type = "item",
        slot = 3,
        price = 50,
    },
    {
        name = "tamirkiti",
        amount = 1,
        type = "item",
        slot = 4,
        price = 300,
    }
    }
}


CreateThread(function()
    local mekanikshop = vector3(-28.39, -1049.53, 27.4)
    local mekanikH = 73.7
    exports["elixir-base"]:pedcreate("illegalmekanikmarket", 0xC4B715D2, mekanikshop.x, mekanikshop.y, mekanikshop.z,  mekanikH)
end)


CreateThread(function()
    local mekanikshop2 = vector3(-1429.4, -454.79, 34.91)
    local mekanikH2 = 45.7
    exports["elixir-base"]:pedcreate("illegalmekanikmarket", 0xC4B715D2, mekanikshop2.x, mekanikshop2.y, mekanikshop2.z,  mekanikH2)
end)


CreateThread(function()
    local mekanikshop3 = vector3(147.02, -3013.4, 6.04)
    local mekanikH3 = 185.7
    exports["elixir-base"]:pedcreate("illegalmekanikmarket", 0xC4B715D2, mekanikshop3.x, mekanikshop3.y, mekanikshop3.z,  mekanikH3)
end)

exports['qb-target']:AddBoxZone("mekanikbennys", vector3(-28.39, -1049.53, 27.4), 1.1, 1.1, {
	name = "Clothingggg",
	heading = 73.23,
	debugPoly = false,
	minZ = 27.56,
	maxZ = 29.87834,
	}, {
		options = {
			{
            	type = "client",
            	event = "mekanik:shop",
				icon = "fas fa-wrench",
				label = "Mechanic Products",
			},
		},
		distance = 2.0
})


exports['qb-target']:AddBoxZone("mekanikhayes", vector3(-1429.4, -454.79, 35.91), 1.1, 1.1, {
	name = "Clothingggg",
	heading = 45.23,
	debugPoly = false,
	minZ = 35.56,
	maxZ = 37.87834,
	}, {
		options = {
			{
            	type = "client",
            	event = "mekanik:shop",
				icon = "fas fa-wrench",
				label = "Mechanic Products",
			},
		},
		distance = 2.0
})

exports['qb-target']:AddBoxZone("mekaniktunner", vector3(147.02, -3013.4, 7.04), 1.1, 1.1, {
	name = "Clothingggg",
	heading = 185.23,
	debugPoly = false,
	minZ = 6.56,
	maxZ = 9.87834,
	}, {
		options = {
			{
            	type = "client",
            	event = "mekanik:shop",
				icon = "fas fa-wrench",
				label = "Mechanic Products",
			},
		},
		distance = 2.0
})

