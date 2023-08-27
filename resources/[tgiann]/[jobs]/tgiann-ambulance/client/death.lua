local thecount = 0
imDead = 0
local inwater = false
local playerVehicle, inVeh, seat = 0, false, 0

myanim = "dead_a"
deathAnims = {"dead_a", "dead_b", "dead_c", "dead_d", "dead_e", "dead_f", "dead_g", "dead_h"}

RegisterNetEvent('tgiann-ambulance:check-death')
AddEventHandler('tgiann-ambulance:check-death', function()
    while QBCore == nil do
        Citizen.Wait(0)
    end
    local model = GetEntityModel(PlayerPedId())
    while not HasModelLoaded(model) do
        Citizen.Wait(0)
    end
    local PlayerData = QBCore.Functions.GetPlayerData()
    if PlayerData.metadata["isdead"] then
        SetEntityCoords(PlayerPedId(), PlayerData.position.x, PlayerData.position.y, PlayerData.position.z)
        SetEntityHealth(PlayerPedId(), 0.0)
    end
end)

local bekleaq = 30000
Citizen.CreateThread(function()
    imDead = 0
    while true do
        Wait(bekleaq)
        local playerPed = PlayerPedId()
        if PlayerLoaded then
            bekleaq = 100
            if IsEntityDead(PlayerPedId()) and imDead == 0 then 
                imDead = 1

                inVeh = IsPedInAnyVehicle(playerPed)
                if inVeh then
                    playerVehicle = GetVehiclePedIsIn(playerPed) 
                    for i=1, GetVehicleModelNumberOfSeats(GetEntityModel(playerVehicle)) do
                        if GetPedInVehicleSeat(playerVehicle, i-2) == playerPed then
                            seat = i-2
                            break
                        end
                    end
                end
                
                SetEntityInvincible(playerPed, true)
                SetEntityMaxHealth(playerPed, 200)
                SetEntityHealth(playerPed, 200)
                TriggerEvent("tgiann:playerdead", true)
                TriggerServerEvent('esx_ambulancejob:setDeathStatus', true)
                --if not exports["tgiann-fightclub"]:inArenaExports() then
                    exports["gamz-skillsystem"]:UpdateSkillRemove("Kondisyon", 0.5)
                --end
                Citizen.Wait(2000)
                myanim = deathAnims[math.random(1, #deathAnims)]
                deathTimer()
            end
        end
    end
end)

local hold = 0
RegisterNetEvent('tgiann-ambulance:timer-text')
AddEventHandler('tgiann-ambulance:timer-text', function()
    while imDead == 1 do
        Citizen.Wait(0)
		if thecount > 0 then
			drawTxt(0.88, 1.44, 1.0,1.0,0.6, "TO REVIEW ~r~" ..  math.ceil(thecount) .. "~w~ SECONDS LEFT", 255, 255, 255, 255)
            -- drawTxt(0.88, 1.44, 1.0,1.0,0.6, "Yeniden dogmana: ~r~" .. math.ceil(earlySpawnTimer) .. "~w~ saniye kaldı", 255, 255, 255, 255)
        else
			drawTxt(0.80, 1.44, 1.0,1.0,0.6, "WAIT DOCTOR TO BE BORN OR REVIEW WITH [~r~H~w~] ~g~$".. Config.EarlyRespawnFineAmount .."~s~", 255, 255, 255, 255)
        end
    end
end)

        





RegisterNetEvent('disableAllActions')
AddEventHandler('disableAllActions', function()
    if not disablingloop then
        local ped = PlayerPedId()
        disablingloop = true
        Citizen.Wait(100)
        while GetEntitySpeed(ped) > 0.5 do
            Citizen.Wait(1)
        end 
        Citizen.Wait(100)	

		local plyPos = GetEntityCoords(PlayerPedId(),  true)
		NetworkResurrectLocalPlayer(plyPos, true, true, false)
        Citizen.Wait(100)
        if GetEntityHealth(ped) < 200 then SetEntityHealth(ped, 200) end
        TriggerEvent("deathAnim")

        if inVeh == 1 then
            SetPedIntoVehicle(ped, playerVehicle, seat)
        end
        
        while imDead == 1 do
            disableControl()
            local ped = PlayerPedId()
            if GetEntityHealth(ped) < 200 then SetEntityHealth(ped, 200) end

            if IsEntityInWater(ped) then
                inwater = true
            else
                inwater = false
            end
            SetEntityInvincible(ped, true)
            Citizen.Wait(1) 
            if IsPedSittingInAnyVehicle(ped) then
				loadAnimDict("veh@low@front_ps@idle_duck") 
	            TaskPlayAnim(PlayerPedId(), "veh@low@front_ps@idle_duck", "sit", 8.0, -8, -1, 1, 0, 0, 0, 0)
            elseif not IsPedSittingInAnyVehicle(ped) and GetEntityHeightAboveGround(ped) < 2.0 or IsPedSittingInAnyVehicle(ped) and GetEntityHeightAboveGround(ped) < 2.0 then
                TriggerEvent("deathAnim")
            elseif not IsPedSittingInAnyVehicle(ped) then
                if (GetEntitySpeed(ped) > 0.3  and not inwater) or (not IsEntityPlayingAnim(ped, "dead", myanim, 1) and not inwater) then
                    TriggerEvent("deathAnim")
                elseif (not IsEntityPlayingAnim(ped, "dam_ko", "drown", 1) and inwater) then
                    TriggerEvent("deathAnim")
                end 
            end
        end
        SetEntityInvincible(PlayerPedId(), false)
        disablingloop = false
    end
end)

RegisterNetEvent('deathAnim')
AddEventHandler('deathAnim', function()
    if not tryingAnim and not IsPedSittingInAnyVehicle(PlayerPedId()) and imDead == 1 then
        tryingAnim = true
        while GetEntitySpeed(PlayerPedId()) > 0.5 and not inwater do
            Citizen.Wait(1)
        end        

        if inwater then
            SetEntityCoords(GetEntityCoords(PlayerPedId()))
            SetPedToRagdoll(PlayerPedId(), 26000, 26000, 3, 0, 0, 0) 
            Citizen.Wait(2500)
        else
            if not IsEntityPlayingAnim(PlayerPedId(), "dead", myanim, 1) then
                loadAnimDict("dead") 
                SetEntityCoords(PlayerPedId(),GetEntityCoords(PlayerPedId()))
                ClearPedTasksImmediately(PlayerPedId())
                TaskPlayAnim(PlayerPedId(), "dead", myanim, 1.0, 1.0, -1, 1, 0, 0, 0, 0)
            end
        end

        Citizen.Wait(500)
        tryingAnim = false
    end
end)

function deathTimer()
    thecount = 300
    TriggerEvent("tgiann-ambulance:timer-text")
    TriggerEvent("disableAllActions")
    while imDead == 1 do
		Citizen.Wait(1000)
		if thecount >= 0 then
            thecount = thecount - 1
        else
            if IsControlPressed(0, 74) and hold > 1 then
                hold = 0
                thecount = 300
				QBCore.Functions.TriggerCallback('elixir-base:ems-police-sayi', function(AktifEMSPD)
					if AktifEMSPD >= 1 then
                        TriggerServerEvent('esx_ambulancejob:payFine', true)
					else
						TriggerServerEvent('esx_ambulancejob:payFine', false)
					end
					TriggerEvent("tgiann-npcdoktor:yatakKontrol")
                end)
                Citizen.Wait(5000)
            end

			if IsControlPressed(0, 74) then
                hold = hold + 1
            end
        
		end
    end
end

function getup()
	local playerPed = PlayerPedId()
	ClearPedSecondaryTask(playerPed)
	loadAnimDict("get_up@directional@movement@from_knees@action") 
	TaskPlayAnim(playerPed, 'get_up@directional@movement@from_knees@action', 'getup_r_0', 8.0, -8.0, -1, 0, 0, 0, 0, 0)
    SetCurrentPedWeapon(playerPed, 2725352035, true)
    Citizen.Wait(3000)
end

-- function DrawTxt(x, y, width, height, scale, text, r, g, b, a, outline)
--     SetTextFont(4)
--     SetTextProportional(0)
--     SetTextScale(scale, scale)
--     SetTextColour(r, g, b, a)
--     SetTextDropShadow(0, 0, 0, 0,255)
--     SetTextEdge(2, 0, 0, 0, 255)
--     SetTextDropShadow()
--     SetTextOutline()
--     SetTextEntry("STRING")
--     AddTextComponentString(text)
--     DrawText(x - width/2, y - height/2 + 0.005)
-- end

function drawTxt(x, y, width, height, scale, text, r, g, b, a, outline)
    SetTextFont(4)
    SetTextProportional(0)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(2, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x - width/2, y - height/2 + 0.005)
end

function disableControl()

    
	DisableAllControlActions(0)
	EnableControlAction(0, 1, true)
	EnableControlAction(0, 2, true)
	EnableControlAction(0, 3, true)
	EnableControlAction(0, 4, true)
	EnableControlAction(0, 5, true)
	EnableControlAction(0, 6, true)
	EnableControlAction(0, 7, true)
	EnableControlAction(0, 172, true) -- yukarı ok
	EnableControlAction(0, 173, true) -- aşağı ok
	EnableControlAction(0, 177, true) -- backspace
	EnableControlAction(0, 303, true) -- U
	EnableControlAction(0, 101, true) -- H
	EnableControlAction(0, 48, true) -- Z
	EnableControlAction(0, 38, true) -- E
	EnableControlAction(0, 249, true) -- N
	EnableControlAction(0, 20, true) -- Z
	EnableControlAction(0, 245, true) -- T
	EnableControlAction(0, 18, true) -- enter
	EnableControlAction(0, 170, true) -- enter
	EnableControlAction(0, 311, true) -- K
	EnableControlAction(0, 207, true) -- page up
	EnableControlAction(0, 208, true) -- page down
	EnableControlAction(0, 178, true) -- dal
	EnableControlAction(0, 74, true)
    EnableControlAction(0, 199, true)
    EnableControlAction(0, 200, true)
end

function revivePlayer(health)
	local player = PlayerPedId()
	kullanilanMed = 0

	if imDead == 1 then
        imDead = 0
		TriggerServerEvent('esx_ambulancejob:setDeathStatus', false)
		TriggerEvent("tgiann:playerdead", false)

		if health then 
			SetEntityMaxHealth(player, 200)
			SetEntityHealth(player, health)	
		end
		
		SetEntityInvincible(PlayerPedId(), false)
        ClearPedBloodDamage(PlayerPedId())        
        local plyPos = GetEntityCoords(PlayerPedId(),  true)
   	 	NetworkResurrectLocalPlayer(plyPos, true, true, false)
        ClearPedTasksImmediately(PlayerPedId())
    
        Citizen.Wait(100)
        getup()
	else
		SetEntityMaxHealth(player, 200)
		SetEntityHealth(player, 200)
		ClearPedBloodDamage(player)
	end
end 

function loadAnimDict(dict)
	while not HasAnimDictLoaded(dict) do
		RequestAnimDict(dict)
		Citizen.Wait(1)
	end
end