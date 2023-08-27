local QBCore = exports['qb-core']:GetCoreObject()
local nuiMsg = false

local function whenStarted()
    if Config.Blip.showBlip then
        local blip = AddBlipForCoord(Config.Location)
        SetBlipSprite(blip, Config.Blip.id)
        SetBlipColour(blip, Config.Blip.color)
        SetBlipScale(blip, Config.Blip.scale)
        SetBlipDisplay(blip, 4)
        SetBlipAsShortRange(blip, true)

        BeginTextCommandSetBlipName("STRING")
        AddTextComponentSubstringPlayerName(Config.Blip.label)
        EndTextCommandSetBlipName(blip)
    end

    if pedSpawned then return end
    local current = 'a_m_m_business_01'
    current = type(current) == 'string' and GetHashKey(current) or current
    RequestModel(current)

    while not HasModelLoaded(current) do Wait(1) end 
    GalleryPed = CreatePed(0, 'a_m_m_business_01', -56.9, -1098.74, 25.42, 27.93, false, false)
    TaskStartScenarioInPlace(GalleryPed, 'WORLD_HUMAN_COP_IDLES', true)
    FreezeEntityPosition(GalleryPed, true)
    SetEntityInvincible(GalleryPed, true)
    SetBlockingOfNonTemporaryEvents(GalleryPed, true)

    exports['qb-target']:AddTargetModel(`a_m_m_business_01`, {
        options = {
            {
                type = "client",
                event = "rn-vehicleshop:target",
                icon = "fas fa-car",
                label = "Michaels Gallery",
            }
        },
        distance = 3.0
    })
    pedSpawned = true
end


RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    whenStarted()
    PlayerData = QBCore.Functions.GetPlayerData()
end)




RegisterNetEvent('rn-vehicleshop:target')
AddEventHandler('rn-vehicleshop:target', function()
    SendNUIMessage({action = "undraw"})
    changeCam()
    TriggerServerEvent("vehicles:server:openUI")
    TriggerEvent("change:time", true)
end)

RegisterNetEvent("vehicles:client:openUI",function(data,daily,buyer)
    SetNuiFocus(true, true)
	if #data ~= 0 then
		for k,v in next,data do
			for m,j in next,Config.Vehicles do
				for i=1,#j.buttons do
					local btn = j.buttons[i]
					if btn.model == v.model then
						if v.stock then
							btn.maxStock = v.stock
						end
					end
				end
			end
		end
	else
		for m,j in next,Config.Vehicles do
			for i=1,#j.buttons do
				j.buttons[i].maxStock = "unlimited"
			end
		end
	end
    SendNUIMessage({
        action = "open",
        vehicles = Config.Vehicles,
        buttons = data,
        daily = daily,
        colors = Config.Colors,
        buyer = buyer,
        testDrive = Config.TestDrive
    })
end)

local vehicleSpawned = false
local newVehicle
local loadVeh = true
RegisterNUICallback("spawnVehicle", function(data,cb)
    if not loadVeh then return end
    if not spawnVehicle then
        loadVeh = false
        spawnVehicle = true 
        local hash = GetHashKey(data.model)
        RequestModel(hash) 
        while not HasModelLoaded(hash) do Wait(250) end
        loadVeh = true 
        newVehicle = CreateVehicle(hash, -39.8, -1053.85, -43.72, 249.9, false, false)
        SetVehicleCustomPrimaryColour(newVehicle, 255, 255, 255)
        SetVehicleCustomSecondaryColour(newVehicle, 255, 255, 255)
        local vehicleInfo = {
            speed = string.format("%.0f",GetVehicleMaxSpeed(newVehicle) * 3.6),
            acceleration = string.format("%.1f",GetVehicleModelAcceleration(hash) * 10),
            braking = string.format("%.1f",GetVehicleModelMaxBraking(hash) * 10),
            traction = string.format("%.1f",GetVehicleModelMaxTraction(hash) * 10)
        }
        SendNUIMessage({action = "updateInfo", vehicleInfo = vehicleInfo})
    else
        loadVeh = false 
        DeleteEntity(newVehicle)
        local hash = GetHashKey(data.model)
        RequestModel(hash)
        while not HasModelLoaded(hash) do Wait(250) end
        loadVeh = true
        newVehicle = CreateVehicle(hash, -39.8, -1053.85, -43.72, 249.9, false, false)
        SetVehicleCustomPrimaryColour(newVehicle, 255, 255, 255)
        SetVehicleCustomSecondaryColour(newVehicle, 255, 255, 255)
        local vehicleInfo = {
            speed = string.format("%.0f",GetVehicleMaxSpeed(newVehicle) * 3.6),
            acceleration = string.format("%.1f",GetVehicleModelAcceleration(hash) * 10),
            braking = string.format("%.1f",GetVehicleModelMaxBraking(hash) * 10),
            traction = string.format("%.1f",GetVehicleModelMaxTraction(hash) * 10)
        }
        SendNUIMessage({action = "updateInfo", vehicleInfo = vehicleInfo})
    end
end)

RegisterNUICallback("buyVehicle", function(data,cb)
	if type(data.details.stock) ~= "string" then if data.details.stock <= 0 then return cb("nomoney") end end
	QBCore.Functions.TriggerCallback("vehicleshop:getMoney",function(bool)
		if bool then
            SendNUIMessage({action = "buyvehicle"})
			TriggerServerEvent("rn-vehicleshop:removeStock",data.details.model)
			DeleteEntity(newVehicle)
			closeVehicleShopAfterBuy()
			inShop = false
			local vehDetails = data.details
			local modelHash = GetHashKey(vehDetails.model)
			RequestModel(modelHash) 
			while not HasModelLoaded(modelHash) do Wait(250) end 
			local boughtVeh = CreateVehicle(modelHash, Config.BoughtVehicleSpawnLocation.coords,Config.BoughtVehicleSpawnLocation.heading, true, true)
			SetVehicleColours(boughtVeh, vehDetails.gtaColor, vehDetails.gtaColor)
            SetPedIntoVehicle(GetPlayerPed(-1), boughtVeh,-1) -- put player inside
			Config.BuyVehicleFunc(QBCore,boughtVeh,vehDetails.model)
            TriggerEvent("x-hotwire:give-keys", boughtVeh, QBCore.Shared.Trim(GetVehicleNumberPlateText(boughtVeh)))
        else
            QBCore.Functions.Notify('You Dont Have Enough Money!', 'error', 7500)
		end
	end, data.details.numberprice)
end)

RegisterNUICallback("testDrive", function(data,cb)
    QBCore.Functions.TriggerCallback("vehicleshop:getMoney",function(price)
        if price then
            SendNUIMessage({action = "testdriver"})
            DeleteEntity(newVehicle)
            closeVehicleShopTestDrive()
            local vehDetails = data.details
            local modelHash = GetHashKey(vehDetails.model)
            RequestModel(modelHash) 
            while not HasModelLoaded(modelHash) do Wait(250) end 
            local boughtVeh = CreateVehicle(modelHash, Config.TestVehicleSpawnLocation.coords,Config.TestVehicleSpawnLocation.heading, true, true)
            NetworkRegisterEntityAsNetworked(boughtVeh)
            TaskWarpPedIntoVehicle(PlayerPedId(),boughtVeh,-1)
            TriggerEvent("x-hotwire:give-keys", boughtVeh, QBCore.Shared.Trim(GetVehicleNumberPlateText(boughtVeh)))
            TriggerEvent("aracfullebebek")
            local netID = NetworkGetNetworkIdFromEntity(boughtVeh)
            local time = data.timer
            while time >= 0 do
                Wait(1000)
                time = time - 1
            end
            
            SendNUIMessage({action = "hideTimer"})
            DoScreenFadeOut(1000)
            Wait(2000)
            TriggerServerEvent("vehicleshop:testdrive", netID)
            SetEntityCoords(PlayerPedId(), vector3(-31.46917, -1104.683, 26 - 0.5))
            DoScreenFadeIn(500)
        else
            QBCore.Functions.Notify('You Dont Have Enough Money!', 'error', 7500)
        end
    end, Config.TestDrive.testDriveCost)
end)
-- RegisterCommand("afulle", function()
RegisterNetEvent("aracfullebebek", function()
    QBCore.Functions.TriggerCallback('esx_vehicleshop:testCarPrice', function(sonuc)
        exports['qb-menu']:openMenu({
            {
                header = "Would you like to use the vehicle by increasing the Engine / Brake / Suspension / Turbo Features??",
                txt = "",
                icon = "fas fa-warehouse",
                isMenuHeader = true,
            },
            {
                header = "Yes, +1000$",
                txt = "",
                -- isServer = true,
                params = {
                    functions = function()
                        if sonuc then 
                           aracifulle()
                        else
                            QBCore.Functions.Notify("You Dont Have Enough Money!", 10000)
                        end
                    end
                }
            },
            {
                header = "No, I don't want",
                txt = "",
                params = {
                    event = "qb-menu:closeMenu"
                }
            },
        })
    end)
end)

RegisterNUICallback("changeColor", function(data,cb)
    SetVehicleCustomPrimaryColour(newVehicle, data.colorR, data.colorG, data.colorB)
    SetVehicleCustomSecondaryColour(newVehicle, data.colorR, data.colorG, data.colorB)
end)

RegisterNUICallback("changePos", function(data,cb)
    SetEntityHeading(newVehicle, tonumber(data.data))
end)

RegisterNUICallback("closeVehicleShop", function(data,cb)
    nuiMsg = false
    inShop = false
    DeleteEntity(newVehicle)
    closeVehicleShop()
end)

RegisterNUICallback("deletevehicle", function(data,cb)
    isRotatingMouseDown = false
    DeleteEntity(newVehicle)
end)

function DrawText3Ds(x, y, z, text)
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x,y,z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end
local inShop = false

function changeCam()
    DoScreenFadeOut(500)
    Wait(1000)
    inShop = true 
    SetEntityCoords(PlayerPedId(), vector3(-27.98, -1049.06, -44.01))
    FreezeEntityPosition(PlayerPedId(), true)
    if not DoesCamExist(cam) then
        cam = CreateCam('DEFAULT_SCRIPTED_CAMERA', true)
    end
    SetCamActive(cam, true)
    SetCamRot(cam, vector3(-15.0,0.0, 80.19), true)
    SetCamFov(cam,35.0)
    SetCamCoord(cam, vector3(-32.39, -1055.02, -42.01))
    PointCamAtCoord(cam, vector3(-32.39, -1055.02, -42.01))
    RenderScriptCams(true, false, 2500.0, true, true)
    DoScreenFadeIn(1000)
    Wait(1000)
end

RegisterNUICallback("returnCam",function(data,cb)
    local ticket = ron 
    local fov = 50.0
    local currentHeading = GetEntityHeading(newVehicle)
    if ticket < 50.0 then 
        while ticket <= fov do
            Wait(20)
            ticket = ticket + 1
            SetCamFov(cam,ticket)
        end
    elseif ticket > 50.0 then 
        while ticket >= fov do
            Wait(20)
            ticket = ticket - 1
            SetCamFov(cam,ticket)
        end
    end
    if currentHeading > 98.53339 and not (currentHeading > 261.46661) then
        while currentHeading <= 261.46661 do 
            Wait(1)
            currentHeading = currentHeading + 1
            SetEntityHeading(newVehicle, currentHeading)
        end
    elseif currentHeading >= 261.46661 then 
        while currentHeading >= 261.46661 do 
            Wait(1)
            currentHeading = currentHeading - 1
            SetEntityHeading(newVehicle, currentHeading)
        end
    else
        while currentHeading > -98.53339 do  
            Wait(1)
            currentHeading = currentHeading - 1
            SetEntityHeading(newVehicle, currentHeading)
        end

    end
    ron = 50.0
end)

local lastX
local isRotatingMouseDown = false
RegisterNUICallback("mousedown",function(data,cb)
    local found,coords,mouseon = GetEntityMouseOn(cam)
    if not found then return false end
    if spawnVehicle and mouseon  == newVehicle then
        isRotatingMouseDown = true
        local currentEntityHeading = GetEntityHeading(newVehicle)
        lastX = GetNuiCursorPosition()
        local currentX = lastX
        CreateThread(function()
            while isRotatingMouseDown do
                currentX = GetNuiCursorPosition()
                local diff = (currentX-lastX) * 0.3
                local newheading
                if diff < 0 then
                    newheading = currentEntityHeading+diff
                elseif diff > 0 then
                    newheading = currentEntityHeading+diff
                end
                if newheading and currentEntityHeading ~= newheading then
                    SetEntityHeading(newVehicle,newheading + 0.0)
                    currentEntityHeading = newheading
                end
                lastX = currentX
                Wait(0)
            end
        end)
    end
    cb("ok")
end)

RegisterNUICallback("mouseup",function(data,cb)
    isRotatingMouseDown = false
    cb("ok")
end)

RegisterNUICallback("downscroll",function(data,cb) 
    zoom(cam,"ScrollDown")
end)

RegisterNUICallback("upscroll",function(data,cb) 
    zoom(cam,"Scrollup")
end)

RegisterNUICallback("blur",function(data,cb) 
    SetTimecycleModifier('hud_def_blur')
end)

AddEventHandler("onResourceStop",function(res)
  if res ~= GetCurrentResourceName() or inShop == false then return end
  SetEntityCoords(PlayerPedId(),Config.Location)
  FreezeEntityPosition(PlayerPedId(),false)
end)


AddEventHandler('onResourceStart', function(resourceName)
    if GetCurrentResourceName() == resourceName then
        whenStarted()
    end
end)


local fov_max = 40.0
local fov_min = 80.0
local zoomspeed = 100.0
local fov = (fov_max+fov_min)*0.5
local coords = Config.Location
local toggle = false;

prop = nil
secondaryprop = nil
ron = 50.0

function zoom(cam,scrollType)
    if scrollType == "ScrollDown" then
        fov = math.max(fov - zoomspeed, fov_min)
    end
    
    if scrollType == "Scrollup" then
        fov = math.min(fov + zoomspeed, fov_max)
    end

    local current_fov = GetCamFov(cam)
    if math.abs(fov-current_fov) < 0.1 then
        fov = current_fov
    end
    SetCamFov(cam, current_fov + (fov - current_fov)*0.05)
    ron = current_fov + (fov - current_fov)*0.05
end
 
function rotationToDirection(rotation)
    local z = degToRad(rotation.z)
    local x = degToRad(rotation.x)
    local num = math.abs(math.cos(x))

    return vector3((-math.sin(z) * num),math.cos(z) * num,math.sin(x))
end
  
function w2s(position)
    local onScreen, _x, _y = GetScreenCoordFromWorldCoord(position.x, position.y, position.z)
    if not onScreen then
        return nil
    end
    return vector3((_x - 0.5) * 2,(_y - 0.5) * 2,0.0)
end

function processCoordinates(x, y)
    local screenX, screenY = GetActiveScreenResolution()
    local relativeX = 1 - (x / screenX) * 1.0 * 2
    local relativeY = 1 - (y / screenY) * 1.0 * 2

    if relativeX > 0.0 then
        relativeX = -relativeX;
    else
        relativeX = math.abs(relativeX)
    end

    if relativeY > 0.0 then
        relativeY = -relativeY
    else
        relativeY = math.abs(relativeY)
    end

    return { x = relativeX, y = relativeY }
end

function s2w(camPos, relX, relY,cam)
    local camRot = GetCamRot(cam,2)
    local camForward = rotationToDirection(camRot)
    local rotUp = ( camRot + vector3(10.0,0.0,0.0) )
    local rotDown = ( camRot + vector3(-10.0,0.0,0.0) )
    local rotLeft = ( camRot + vector3(0.0,0.0,-10.0) )
    local rotRight = ( camRot + vector3(0.0,0.0,10.0) )

    local camRight = (rotationToDirection(rotRight) - rotationToDirection(rotLeft))
    local camUp = (rotationToDirection(rotUp)- rotationToDirection(rotDown))

    local rollRad = -degToRad(camRot.y)
    local camRightRoll = ((camRight* math.cos(rollRad))- (camUp* math.sin(rollRad)))
    local camUpRoll = ((camRight* math.sin(rollRad))+ (camUp* math.cos(rollRad)))

    local point3D = (((camPos+ (camForward* 10.0))+camRightRoll)+camUpRoll)

    local point2D = w2s(point3D)

    if point2D == nil then
        return (camPos +  (camForward* 10.0))
    end

    local point3DZero = (camPos+ (camForward* 10.0))
    local point2DZero = w2s(point3DZero)

    if point2DZero == nil then
        return (camPos+ (camForward* 10.0))
    end

    local eps = 0.001
    if math.abs(point2D.x - point2DZero.x) < eps or math.abs(point2D.y - point2DZero.y) < eps then
        return (camPos + (camForward* 10.0))
    end

    local scaleX = (relX - point2DZero.x) / (point2D.x - point2DZero.x)
    local scaleY = (relY - point2DZero.y) / (point2D.y - point2DZero.y)
    local point3Dret = (((camPos+ (camForward* 10.0))+ (camRightRoll* scaleX))+ (camUpRoll* scaleY))

    return point3Dret
end

function degToRad(deg)
    return (deg * math.pi) / 180.0
end
  
function screenToWorld(flags, cam)
    local x, y = GetNuiCursorPosition()

    local absoluteX = x
    local absoluteY = y

    local camPos = GetGameplayCamCoord()
    camPos = GetCamCoord(cam)
    local processedCoords = processCoordinates(absoluteX, absoluteY)
    local target = s2w(camPos, processedCoords.x, processedCoords.y,cam)

    local dir = (target-camPos)
    local from = (camPos+(dir* 0.05))
    local to = (camPos+(dir* 300))

    local ray = StartShapeTestRay(from.x, from.y, from.z, to.x, to.y, to.z, flags, ignore, 0)
    local a, b, c, d, e = GetShapeTestResult(ray)
    return b, c, e, to
end
  
function GetEntityMouseOn(cam)
    local hit,endCoords,entityHit,_ = screenToWorld(2,cam)
    return hit,endCoords,entityHit
end

function closeVehicleShop()
    DoScreenFadeOut(500)
    FreezeEntityPosition(PlayerPedId(), false)
    Wait(1000)
    TriggerEvent("change:time", false)
    SetNuiFocus(false, false)
    SetEntityCoords(PlayerPedId(), coords.x, coords.y, coords.z)
    DoScreenFadeIn(1000)
    RenderScriptCams(false, false, 1, true, true)
    DestroyAllCams(true)
    Wait(1000)
end

function closeVehicleShopAfterBuy()
    SetNuiFocus(false, false)
    DoScreenFadeOut(500)
    FreezeEntityPosition(PlayerPedId(), false)
    Wait(2000)
    SetEntityCoords(PlayerPedId(), vector3(-31.46917, -1104.683, 26 - 0.5))
    TriggerEvent("change:time", false)
    SetEntityHeading(PlayerPedId(), 201.9698)
    TriggerEvent("vehicles:client:anim")
    SendNUIMessage({action = "vehicleBought"})
    toggle = true
    CreateThread(disable)
    DoScreenFadeIn(1000)
    RenderScriptCams(false, false, 1, true, true)
    DestroyAllCams(true)
    Wait(5000)
    toggle = false
    close()
end

function closeVehicleShopTestDrive()
    SetNuiFocus(false, false)
    FreezeEntityPosition(PlayerPedId(), false)
    DoScreenFadeOut(500)
    Wait(2000)
    SetEntityCoords(PlayerPedId(), vector3(-31.46917, -1104.683, 26 - 0.5))
    TriggerEvent("change:time", false)
    DoScreenFadeIn(1000)
    RenderScriptCams(false, false, 1, true, true)
    DestroyAllCams(true)
end

function DrawText3Ds(x, y, z, text)
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x,y,z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end

RegisterNetEvent('vehicles:client:anim')
AddEventHandler('vehicles:client:anim', function()
    local player = PlayerPedId()
    local ad = "missheistdockssetup1clipboard@base"
                
    local prop_name = 'prop_notepad_01'
    local secondaryprop_name = 'prop_pencil_01'
    
    if DoesEntityExist(player) and not IsEntityDead(player) then 
        loadAnimDict(ad)
        if IsEntityPlayingAnim( player, ad, "base", 3 ) then 
            TaskPlayAnim( player, ad, "exit", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
            Wait(100)
            ClearPedSecondaryTask(player)
            DetachEntity(prop, 1, 1)
            DeleteObject(prop)
            DetachEntity(secondaryprop, 1, 1)
            DeleteObject(secondaryprop)
        else
            local x,y,z = table.unpack(GetEntityCoords(player))
            prop = CreateObject(GetHashKey(prop_name), x, y, z+0.2,  true,  true, true)
            secondaryprop = CreateObject(GetHashKey(secondaryprop_name), x, y, z+0.2,  true,  true, true)
            AttachEntityToEntity(prop, player, GetPedBoneIndex(player, 18905), 0.1, 0.02, 0.05, 10.0, 0.0, 0.0, true, true, false, true, 1, true)
            AttachEntityToEntity(secondaryprop, player, GetPedBoneIndex(player, 58866), 0.12, 0.0, 0.001, -150.0, 0.0, 0.0, true, true, false, true, 1, true)
            TaskPlayAnim(player, ad, "base", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
        end 
    end
end)

function close()
    TaskPlayAnim(PlayerPedId(), "missheistdockssetup1clipboard@base", "exit", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
    Wait(100)
    ClearPedSecondaryTask(PlayerPedId())
    DetachEntity(prop, 1, 1)
    DeleteObject(prop)
    DetachEntity(secondaryprop, 1, 1)
    DeleteObject(secondaryprop)
    prop = nil
    secondaryprop = nil
end

function loadAnimDict(dict)
    while (not HasAnimDictLoaded(dict)) do
        RequestAnimDict(dict)
        Wait(10)
    end
end

function disable()
    while toggle do 
        Wait(0)
        DisableControlAction(0, 30, true) -- disable left/right
        DisableControlAction(0, 31, true) -- disable forward/back
        DisableControlAction(0, 36, true) -- INPUT_DUCK
        DisableControlAction(0, 21, true) -- disable sprint
    end
end

function aracifulle()
	local vehicle = GetVehiclePedIsIn(PlayerPedId())
	PerformanceUpgradeVehicle(vehicle)
	QBCore.Functions.Notify("All Features of Your Vehicle Have Been Upgraded, You Will Be able to Use Your Vehicle at the Highest Features for 120 Seconds.", 10000)
end

local performanceModIndices = { 11, 12, 13, 15, 16 }
function PerformanceUpgradeVehicle(vehicle, customWheels)
    customWheels = customWheels or false
    local max
    if DoesEntityExist(vehicle) and IsEntityAVehicle(vehicle) then
        SetVehicleModKit(vehicle, 0)
        for _, modType in ipairs(performanceModIndices) do
            max = GetNumVehicleMods(vehicle, tonumber(modType)) - 1
            SetVehicleMod(vehicle, modType, max, customWheels)
        end
        ToggleVehicleMod(vehicle, 18, true) -- Turbo
	SetVehicleFixed(vehicle)
    end
end



RegisterCommand("galleryfix", function()
    nuiMsg = false
    inShop = false
    DeleteEntity(newVehicle)
    closeVehicleShop()
end)

RegisterCommand("gallery", function()
    SendNUIMessage({action = "undraw"})
    changeCam()
    TriggerServerEvent("vehicles:server:openUI")
    TriggerEvent("change:time", true)
end, true)
