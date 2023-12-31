local cam = nil
local charPed = nil
local QBCore = exports['qb-core']:GetCoreObject()
isTrainMoving = false 

-- Main Thread

CreateThread(function()
	while true do
		Wait(0)
		if NetworkIsSessionStarted() then
			TriggerEvent('qb-multicharacter:client:chooseChar')
            TriggerEvent("shutdownloadscreen")
			return
		end
	end
end)

RegisterNUICallback('Notify', function(data, cb)
    QBCore.Functions.Notify(data.message, data.type)
end)


-- Functions

local function skyCam(bool)
    TriggerEvent('qb-weathersync:client:DisableSync')
    if bool then
        DoScreenFadeIn(1000)
        SetTimecycleModifier('hud_def_blur')
        SetTimecycleModifierStrength(1.0)
        FreezeEntityPosition(PlayerPedId(), false)
        cam = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", Config.CamCoords.x, Config.CamCoords.y, Config.CamCoords.z, 0.0 ,0.0, Config.CamCoords.w, 60.00, false, 0)
        SetCamActive(cam, true)
        RenderScriptCams(true, false, 1, true, true)
    else
        SetTimecycleModifier('default')
        SetCamActive(cam, false)
        DestroyCam(cam, true)
        RenderScriptCams(false, false, 1, true, true)
        FreezeEntityPosition(PlayerPedId(), false)
        deleteTrain()
    end
end

local function openCharMenu(bool)
    SetNuiFocus(bool, bool)
    SendNUIMessage({
        action = "ui",
        toggle = bool,
    })
    skyCam(bool)
end

-- Events

RegisterNetEvent('qb-multicharacter:client:closeNUIdefault', function(gender) -- This event is only for no starting apartments
    local src = source
    deleteTrain()
    DeleteEntity(charPed)
    SetNuiFocus(false, false)
    DoScreenFadeOut(500)
    Wait(2000)
    SetEntityCoords(PlayerPedId(), Config.DefaultSpawn.x, Config.DefaultSpawn.y, Config.DefaultSpawn.z)
    Wait(500)
    openCharMenu()
    SetEntityVisible(PlayerPedId(), true)
    Wait(500)
    DoScreenFadeIn(250)
    TriggerEvent('qb-weathersync:client:EnableSync')
    Wait(2000)
    TriggerServerEvent('QBCore:Server:OnPlayerLoaded')
    TriggerEvent('QBCore:Client:OnPlayerLoaded')
end)



RegisterNetEvent('qb-multicharacter:client:closeNUI', function(gender)
    deleteTrain()
    DeleteEntity(charPed)
    SetNuiFocus(false, false)
    TriggerEvent('raidClothing:CreateFirstCharacter', gender)
end)



local function DisableHudIcons()
    TriggerEvent('qb-hud:client:ToggleBugMode', false)
    TriggerEvent('qb-hud:client:ToggleDevMode', false) 
    TriggerEvent('qb-hud:client:ToggleWeaponMode', false) 
    TriggerEvent('qb-hud:client:ToggleDrunkMode', false) 
end

RegisterNetEvent('qb-multicharacter:client:chooseChar', function()
    local ped = PlayerPedId()
    DisableHudIcons() 
    SetNuiFocus(false, false)
    DoScreenFadeOut(10)
    SetEntityCoords(ped, Config.HiddenCoords.x, Config.HiddenCoords.y, Config.HiddenCoords.z)
    FreezeEntityPosition(ped, true)
    Wait(1000)
    while not HasCollisionLoadedAroundEntity(ped) do
        Wait(0)
    end
    while not HasCollisionForModelLoaded(GetHashKey("sp_01_station")) do
        Wait(0)
    end
    while not HasModelLoaded(GetHashKey("sp_01_station")) do
        Wait(100)
    end
    Wait(1500)
    ShutdownLoadingScreen() 
    ShutdownLoadingScreenNui()
    spawnTrain()
    openCharMenu(true)
end)

-- NUI Callbacks

RegisterNUICallback('closeUI', function()
    openCharMenu(false)
end)

RegisterNUICallback('disconnectButton', function()
    SetEntityAsMissionEntity(charPed, true, true)
    DeleteEntity(charPed)
    deleteTrain()
    TriggerServerEvent('qb-multicharacter:server:disconnect')
end)

RegisterNUICallback('selectCharacter', function(data)
    local cData = data.cData
    DoScreenFadeOut(10)
    TriggerServerEvent('qb-multicharacter:server:loadUserData', cData)
    openCharMenu(false)
    SetEntityAsMissionEntity(charPed, true, true)
    DeleteEntity(charPed)
end)

RegisterNUICallback('cDataPed', function(data)
    local cData = data.cData  
    SetEntityAsMissionEntity(charPed, true, true)
    DeleteEntity(charPed)
    if cData ~= nil then
        QBCore.Functions.TriggerCallback('qb-multicharacter:server:getSkin', function(model, data)
            model = model ~= nil and tonumber(model) or false
            if model ~= nil then
                CreateThread(function()
                    RequestModel(model)
                    while not HasModelLoaded(model) do
                        Wait(0)
                    end
                    charPed = CreatePed(2, model, Config.PedCoords.x, Config.PedCoords.y, Config.PedCoords.z - 0.98, Config.PedCoords.w, false, true)
                    local  RandomAnimins = {     
                        "WORLD_HUMAN_HANG_OUT_STREET",
                        "WORLD_HUMAN_STAND_IMPATIENT",
                        "WORLD_HUMAN_STAND_MOBILE",
                        "WORLD_HUMAN_SMOKING_POT",
                        "WORLD_HUMAN_LEANING",
                        "WORLD_HUMAN_DRUG_DEALER_HARD"
                    }
                    local PlayAnimin = RandomAnimins[math.random(#RandomAnimins)] 
                    SetPedCanPlayAmbientAnims(charPed, true)
                    TaskStartScenarioInPlace(charPed, PlayAnimin, 0, true)
                    SetPedComponentVariation(charPed, 0, 0, 0, 2)
                    FreezeEntityPosition(charPed, false)
                    SetEntityInvincible(charPed, true)
                    PlaceObjectOnGroundProperly(charPed)
                    SetBlockingOfNonTemporaryEvents(charPed, true)
                    data = json.decode(data)
                    exports['fivem-appearance']:setPedAppearance(charPed, data, true)
                    --qb-clothing
                    --TriggerEvent('qb-clothing:client:loadPlayerClothing', data, charPed, 200, 200, true)
                end)
            else
                CreateThread(function()
                    local randommodels = {
                        "np_m_character_select",
                        "np_f_character_select",
                    }
                    local model = GetHashKey(randommodels[math.random(1, #randommodels)])
                    RequestModel(model)
                    while not HasModelLoaded(model) do
                        Wait(0)
                    end
                    charPed = CreatePed(2, model, Config.PedCoords.x, Config.PedCoords.y, Config.PedCoords.z - 0.98, Config.PedCoords.w, false, true)
                    SetPedComponentVariation(charPed, 0, 0, 0, 2)
                    FreezeEntityPosition(charPed, false)
                    SetEntityInvincible(charPed, true)
                    PlaceObjectOnGroundProperly(charPed)
                    SetBlockingOfNonTemporaryEvents(charPed, true)
                    exports['fivem-appearance']:setPedAppearance(charPed, data, true)
                end)
            end
        end, cData.citizenid)
    else
        CreateThread(function()
            local randommodels = {
                "np_m_character_select",
                "np_f_character_select",
            }
            local model = GetHashKey(randommodels[math.random(1, #randommodels)])
            RequestModel(model)
            while not HasModelLoaded(model) do
                Wait(0)
            end
            charPed = CreatePed(2, model, Config.PedCoords.x, Config.PedCoords.y, Config.PedCoords.z - 0.98, Config.PedCoords.w, false, true)
            SetPedComponentVariation(charPed, 0, 0, 0, 2)
            FreezeEntityPosition(charPed, false)
            SetEntityInvincible(charPed, true)
            PlaceObjectOnGroundProperly(charPed)
            SetBlockingOfNonTemporaryEvents(charPed, true)
            exports['fivem-appearance']:setPedAppearance(charPed, data, true)
        end)
    end
end)


RegisterNUICallback('setupCharacters', function()
    QBCore.Functions.TriggerCallback("qb-multicharacter:server:setupCharacters", function(result)
        SendNUIMessage({
            action = "setupCharacters",
            characters = result
        })
    end)
end)

RegisterNUICallback('removeBlur', function()
    SetTimecycleModifier('default')
end)

RegisterNUICallback('createNewCharacter', function(data)
    local karaktersayitemel = 0
    QBCore.Functions.TriggerCallback("qb-multicharacter:server:GetUserCharacters", function(results)
        for k,v in pairs(results) do
            for i=1, #results do
                if results ~= nil then
                    karaktersayitemel = karaktersayitemel + 1
                    gereklisayi = 3
                end
            end
            for i=2, #results do
                karaktersayitemel = karaktersayitemel + 1
                gereklisayi = 6
            end
            for i=3, #results do
                karaktersayitemel = karaktersayitemel + 1
                gereklisayi = 18
            end
            for i=4, #results do
                karaktersayitemel = karaktersayitemel + 1
                gereklisayi = 40
            end
            for i=5, #results do
                karaktersayitemel = karaktersayitemel + 1
                gereklisayi = 75
            end
            if karaktersayitemel == 0 then
                karaktersayi = 0
            elseif gereklisayi == 3 then
                karaktersayi = 1
            elseif gereklisayi == 6 then
                karaktersayi = 2
            elseif gereklisayi == 18 then
                karaktersayi = 3
            elseif gereklisayi == 40 then
                karaktersayi = 4
            elseif gereklisayi == 75 then
                karaktersayi = 5
            end
        end
        QBCore.Functions.TriggerCallback("ra1derLastCharacter", function(izinlikarakter)
            if karaktersayi == nil then
                karaktersayi = 0
            end
            if karaktersayi < izinlikarakter then
                local cData = data
                DoScreenFadeOut(150)
                TriggerServerEvent('qb-multicharacter:server:createCharacter', cData)
                Citizen.Wait(500)
            else
                TriggerEvent('qb-multicharacter:client:chooseChar')
                QBCore.Functions.Notify("You are not allowed to unlock more characters", "error")
                QBCore.Functions.Notify("Number of characters you can unlock: ".. karaktersayi, "primary", 10000)
                QBCore.Functions.Notify("Total Character Count: ".. izinlikarakter, "primary", 10000)
            end
        end)
    end)
end)

RegisterNUICallback('removeCharacter', function(data)
    TriggerServerEvent('qb-multicharacter:server:deleteCharacter', data.citizenid)
    TriggerEvent('qb-multicharacter:client:chooseChar')
    DeleteEntity(charPed)
end)

function spawnTrain()
	local tempmodel = GetHashKey("metrotrain")
	RequestModel(tempmodel)
	while not HasModelLoaded(tempmodel) do
		RequestModel(tempmodel)
		Wait(0)
	end
    local coords = vector3(-3948.49,2036.35,499.1)
    vehicle = CreateVehicle(tempmodel, coords, 160.0, false, false)
    FreezeEntityPosition(vehicle, true)
    local heading = GetEntityHeading(vehicle)
    local coords = GetOffsetFromEntityInWorldCoords(vehicle, 0.0, -11.0, 0.0)
    vehicleBack = CreateVehicle(tempmodel, coords, 158.0, false, false)
    FreezeEntityPosition(vehicleBack, true)
    AttachEntityToEntity(vehicleBack , vehicle , 51 , 0.0, -11.0, 0.0, 180.0, 180.0, 0.0, false, false, false, false, 0, true)
    CreateThread(function()
    	isTrainMoving = true
	    for i=1,100 do
	    	local posoffset = GetOffsetFromEntityInWorldCoords(vehicle, 0.0, 0.0, 0.0)
	    	local setpos = VecLerp(-3948.49,2036.35,499.1, -3957.58,2008.75, 499.1, i/100, true)
	    	SetEntityCoords(vehicle,setpos)
	  		Wait(15)
	    end
	    isTrainMoving = false
	end)
end

function deleteTrain()
	if vehicle ~= nil then
		DeleteEntity(vehicle)
		DeleteEntity(vehicleBack)
	end
end

function VecLerp(x1, y1, z1, x2, y2, z2, l, clamp)
    if clamp then
        if l < 0.0 then l = 0.0 end
        if l > 1.0 then l = 1.0 end
    end
    local x = Lerp(x1, x2, l)
    local y = Lerp(y1, y2, l)
    local z = Lerp(z1, z2, l)
    return vector3(x, y, z)
end

function Lerp(a, b, t)
    return a + (b - a) * t
end
