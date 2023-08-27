CurrentWeather = 'EXTRASUNNY'
local lastWeather = CurrentWeather
local hour = 0
local min = 0
local timer = 0
local sec = 0
local blackout = false
local evici = false
QBCore = nil

Citizen.CreateThread(function() 
	while QBCore == nil do
		TriggerEvent("QBCore:GetObject", function(obj) QBCore = obj end)    
		Citizen.Wait(200)
	end
	Citizen.Wait(1000)
	SetRainFxIntensity(-1.0)
end)

RegisterNetEvent('vSync:evici')
AddEventHandler('vSync:evici', function(status)
    evici = status
    if evici then
        TriggerEvent("qb-weathersync:client:SyncTime")
    end
end)

RegisterNetEvent('qb-weathersync:client:SyncTime')
AddEventHandler('qb-weathersync:client:SyncTime', function(hourTime, minTime, NewWeather, newblackout, secTime)
	if not evici then
		hour = hourTime
		min = minTime
		sec = math.floor(secTime / 2)
    else
        timeOffset = 3
		baseTime = 0
	end

	if NewWeather then
		CurrentWeather = NewWeather
		blackout = newblackout
	end
end)

local loaded = false
local ada = false
Citizen.CreateThread(function()
	SetArtificialLightsState(false)
	ForceSnowPass(false)

	while true do
		local time = 1000
		local playerPed = PlayerPedId()
		local playerCoord = GetEntityCoords(playerPed)
		NetworkOverrideClockTime(hour, min, sec)
		if #(vector3(5113.64, -5141.78, 2.25) - playerCoord) < 2900 then
			if not ada then
				SetWeatherTypeOverTime("EXTRASUNNY", 15.0)
				Citizen.Wait(15000)
				ada = true
			end
			WaterOverrideSetStrength(1.0)
			ClearOverrideWeather()
			ClearWeatherTypePersist()
			SetWeatherTypePersist("EXTRASUNNY")
			SetWeatherTypeNow("EXTRASUNNY")
			SetWeatherTypeNowPersist("EXTRASUNNY")

			SetForceVehicleTrails(false)
			SetForcePedFootstepsTracks(false)
			if loaded then 
				RemoveNamedPtfxAsset("core_snow")
				ReleaseNamedScriptAudioBank("ICE_FOOTSTEPS")
				ReleaseNamedScriptAudioBank("SNOW_FOOTSTEPS")
				loaded = false
			end
		else
			if lastWeather ~= CurrentWeather or ada then
				lastWeather = CurrentWeather
				SetWeatherTypeOverTime(CurrentWeather, 15.0)
				Citizen.Wait(15000)
				if ada then ada = false end
			end

			ClearOverrideWeather()
			ClearWeatherTypePersist()
			SetWeatherTypePersist(lastWeather)
			SetWeatherTypeNow(lastWeather)
			SetWeatherTypeNowPersist(lastWeather)

			if lastWeather == 'XMAS' then
				WaterOverrideSetStrength(3.0)
				if not loaded then
					SetForceVehicleTrails(true)
					SetForcePedFootstepsTracks(true)
					Citizen.CreateThread(function()
						Citizen.Wait(15000)
						QBCore.Functions.Notify("With /snowball, you can pick up a snowball from the ground", "primary", 25000)
					end)
					RequestScriptAudioBank("ICE_FOOTSTEPS", false)
					RequestScriptAudioBank("SNOW_FOOTSTEPS", false)
					RequestNamedPtfxAsset("core_snow")
					while not HasNamedPtfxAssetLoaded("core_snow") do Citizen.Wait(0) end
					UseParticleFxAssetNextCall("core_snow")
					loaded  = true
				end
			else
				WaterOverrideSetStrength(0.0)
				if loaded then
					SetForceVehicleTrails(false)
					SetForcePedFootstepsTracks(false)
					ReleaseNamedScriptAudioBank("ICE_FOOTSTEPS")
					ReleaseNamedScriptAudioBank("SNOW_FOOTSTEPS")
					RemoveNamedPtfxAsset("core_snow")
					loaded = false
				end
			end
		end
		Citizen.Wait(time)
    end
end)

Citizen.CreateThread(function()
    while true do
		Citizen.Wait(30000) 
		local playerPed = PlayerPedId()
        if IsPedInAnyVehicle(playerPed, false) then
            if string.upper(CurrentWeather) == "THUNDER" or string.upper(CurrentWeather) == "CLEARING" or string.upper(CurrentWeather) == "RAIN" then
                local veh = GetVehiclePedIsIn(playerPed)
				local curDirt = GetVehicleDirtLevel(veh , false)
                if curDirt - 1 < 0 then
					SetVehicleDirtLevel(veh, 0)
                else 
                    SetVehicleDirtLevel(veh, curDirt - 1.0)
                end
            end
        end
    end
end)