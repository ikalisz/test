PlayerData = {}
QBCore = nil

playerId = PlayerId()
playerPed = PlayerPedId()
playerPedCoords = GetEntityCoords(playerPed)
inVehicle = IsPedInAnyVehicle(playerPed)
veh = GetVehiclePedIsIn(playerPed)
playerLoaded = false
eventOn = false

local isDead = false
local lastMovementClipset = nil
local crouched = false
local FPSkullan = false

Citizen.CreateThread(function() 
    while QBCore == nil do
        TriggerEvent("QBCore:GetObject", function(obj) QBCore = obj end)    
        Citizen.Wait(200)
    end
end)

Citizen.CreateThread(function() 
    while true do
        playerId = PlayerId()
        playerPed = PlayerPedId()
        playerPedCoords = GetEntityCoords(playerPed)
        inVehicle = IsPedInAnyVehicle(playerPed)
        veh = GetVehiclePedIsIn(playerPed)
        Citizen.Wait(500)
    end
end)

--[[ local bozukPeds = {
    [`a_m_y_business_02`] = true,
    [`a_m_m_business_01`] = true
}

AddEventHandler('populationPedCreating', function(x, y, z, model, setters)
    if bozukPeds[model] then
        CancelEvent()
    end
end) ]]

RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    firstlogin()
    TriggerEvent("backitems:start")
end)


RegisterNetEvent('QBCore:Player:SetPlayerData')
AddEventHandler('QBCore:Player:SetPlayerData', function(data)
	PlayerData = data
end)

local playerPerm = "user"
function firstlogin()
    TriggerServerEvent("elixir-base:ana-siken")
    PlayerData = QBCore.Functions.GetPlayerData()
    if PlayerData.job.onduty and (PlayerData.job.name == "police" or PlayerData.job.name == "ambulance" or PlayerData.job.name == "mechanic" or PlayerData.job.name == "mechanic_bennys" or PlayerData.job.name == "mechanic_hayes" or PlayerData.job.name == "mechanic_gabz" or PlayerData.job.name == "cardealer") then
        TriggerServerEvent("elixir-base:meslekKisiEkle", PlayerData.job.name)
    end

    QBCore.Functions.TriggerCallback('tgiann-hackkoruma:GetPermissions', function(UserGroup)
        playerPerm = UserGroup
    end)
    
    -- enable PVP
    SetCanAttackFriendly(playerPed, true, false)
    NetworkSetFriendlyFireOption(true)

    -- disable wanted level
    ClearPlayerWantedLevel(playerId)
    SetMaxWantedLevel(0)

    resetWalkingPed()
    SetPlayerTalkingOverride(playerId, false)
    playerLoaded = true
end

function RequestWalking(ad)
    RequestAnimSet(ad)
    while (not HasAnimSetLoaded(ad)) do 
        Citizen.Wait(100)
    end 
end 

function resetWalkingPed()
    if lastMovementClipset == nil then
        if IsPedMale(playerPed) then
            lastMovementClipset = "MOVE_P_M_ONE"
        else
            lastMovementClipset = "move_f@multiplayer"
        end
    end
    ResetPedWeaponMovementClipset(playerPed)
    ResetPedStrafeClipset(playerPed)
    RequestWalking(lastMovementClipset)
    ResetPedMovementClipset(playerPed, 0.0)
    SetPedMovementClipset(playerPed, lastMovementClipset, 0.5)
    RemoveAnimSet(lastMovementClipset)  
end


AddEventHandler('tgiann:playerdead', function(dead) 
    isDead = dead
end)

RegisterNetEvent('QBCore:Client:OnJobUpdate')
AddEventHandler('QBCore:Client:OnJobUpdate', function(job)
    PlayerData.job = job
end)





AddEventHandler("onClientResourceStop", function(scriptAdi)
    if scriptAdi == "tgiann-hackkoruma" then
        TriggerServerEvent('elixir-base:mesaj')
    end
end)




local soygun = false
RegisterNetEvent('elixir-base:soygun-engel')
AddEventHandler('elixir-base:soygun-engel', function()
    if not soygun and PlayerData.job.name ~= "police" and PlayerData.job.name ~= "ambulance" then
        soygun = true
        Citizen.Wait(2700000) --45 dakika
        soygun = false
    end
end) 

--exports["elixir-base"]:soygun()
exports('soygun', function()
    return false
end)
local minisoygun = false 
RegisterNetEvent('elixir-base:minisoygun-engel')
AddEventHandler('elixir-base:minisoygun-engel', function()
    if not minisoygun and PlayerData.job.name ~= "police" and PlayerData.job.name ~= "ambulance" then
        minisoygun = true
        Citizen.Wait(180000) -- 3 dakika
        minisoygun = false
    end
end) 

--exports["elixir-base"]:soygun()
exports('minisoygun', function()
    return false
end)






local disableControl = false
exports('disableAllControl', function(bool)
    disableControl = bool
end)

Citizen.CreateThread(function()
    while true do
        local time = 100
        if disableControl then
            time = 1
            local playerPed = PlayerPedId()
            DisablePlayerFiring(playerPed, true)
            DisableControlAction(0,21,true) -- disable sprint
            DisableControlAction(0, 24, true) -- Attack
            DisableControlAction(0, 257, true) -- Attack 2
            DisableControlAction(0, 25, true) -- Aim
            DisableControlAction(0, 263, true) -- Melee Attack 1
            DisableControlAction(0, 37, true) -- Select Weapon
            DisableControlAction(0, 56, true) -- F9
            DisableControlAction(0, 45, true) -- Reload
            DisableControlAction(0, 22, true) -- Jump
            DisableControlAction(0, 44, true) -- Cover
            DisableControlAction(0, 288, true) --F1
            DisableControlAction(0, 289, true) -- F2
            DisableControlAction(0, 170, true) -- F3
            DisableControlAction(0, 167, true) -- F6
            DisableControlAction(0, 26, true) -- Disable looking behind
            DisableControlAction(0, 73, true) -- Disable clearing animation
            DisableControlAction(0, 59, true) -- Disable steering in vehicle
            DisableControlAction(0, 71, true) -- Disable driving forward in vehicle
            DisableControlAction(0, 72, true) -- Disable reversing in vehicle
            DisableControlAction(2, 21, true) -- Disable going stealth
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
            DisableControlAction(0, 23, true)
        end
        Citizen.Wait(time)
    end
end)

local screenShotCD = 0
exports('screenShot', function()
    local callbackData = nil
    screenShotCD = 0
    exports['screenshot-basic']:requestScreenshotUpload("https://discord.com/api/webhooks/961976670380769391/mX0Hstq2QC60HH1YwapVAD4AOSk8cpz40djk6op9YooUNZBkm4FBFnOtFbrMS94eFgOU", "files[]", function(data)
        callbackData = json.decode(data)
    end)
    while callbackData == nil do
        Citizen.Wait(1000)
        screenShotCD = screenShotCD + 1
        if screenShotCD > 10 then
            break
        end
    end

    if callbackData then
        if callbackData.message then
         --   print("HATA: "..callbackData.message)
            return false
        else
            return callbackData.attachments[1].proxy_url
        end
    else
      --  print("HATA: Resim Çekilemedi")
        return QBCore.Functions.Notify('Resim Çekilemedi!', 'error', 7500)
    end
end)







local FireRate = {

    [`weapon_pistol`] = 0.375, 
    [`weapon_pistol_mk2`] = 0.38, 
    [`weapon_heavypistol`] = 0.42, 
    [`weapon_combatpistol`] = 0.38,
    [`weapon_snspistol`] = 0.375,
    [`weapon_vintagepistol`] = 0.42,
    [`weapon_machinepistol`] = 0.12,
    [`weapon_appistol`] = 0.11,
}


Citizen.CreateThread(function()
	while true do
		Citizen.Wait(5)
		local ped = PlayerPedId()
		local playerPos = GetEntityCoords(ped)
        local ananizisiktim = GetWeaponTimeBetweenShots(GetSelectedPedWeapon(PlayerPedId()))
		if IsPedShooting(ped) then
			local _,wep = GetCurrentPedWeapon(ped)
                local weaponData = FireRate[wep]
				if weaponData then
					if weaponData < ananizisiktim then
					QBCore.Functions.Notify('Fire Rate Düzenlemesi yapan 3.Parti yazılım kullanmayınız.!', 5000)
                    Wait(500)
                    QBCore.Functions.Notify('Fire Rate Düzenlemesi yapan 3.Parti yazılım kullanmayınız.!', 5000)
                    Wait(500)
                    QBCore.Functions.Notify('Fire Rate Düzenlemesi yapan 3.Parti yazılım kullanmayınız.!', 5000)
                    Wait(500)
                    QBCore.Functions.Notify('Fire Rate Düzenlemesi yapan 3.Parti yazılım kullanmayınız.!', 5000)
                    Wait(500)
                    QBCore.Functions.Notify('Fire Rate Düzenlemesi yapan 3.Parti yazılım kullanmayınız.!', 5000)
                    Wait(500)
					-- TriggerEvent('m3:inventoryhud:client:removeCurrentWeapon')
					end
				end
			end
		end
	end)

 
    

