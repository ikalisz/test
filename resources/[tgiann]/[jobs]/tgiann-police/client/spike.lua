local spikeCoords = {}
local spikeobject = 0
local spikeobject2 = 0
local spikeobject3 = 0
local spikesBlip = nil
local placedSpikes = true
local loadspikes = true

function SetSpikesOnGround(amount)
	TriggerEvent("esx_policejob:play-spike-anim")
	Citizen.Wait(1000)
	local heading = GetEntityHeading(PlayerPedId())

	for i=1,amount do
		local pos = GetOffsetFromEntityInWorldCoords(GetPlayerPed(PlayerId()), 0.0, -1.5+(3.5*i), 0.15)
		TriggerServerEvent("esx_policejob:spikesLocation",pos["x"],pos["y"],pos["z"],heading, i)
	end

    if spikesBlip ~= nil then
    	RemoveBlip(spikesBlip)
    end
    local pos = GetOffsetFromEntityInWorldCoords(GetPlayerPed(PlayerId()), 0.0, 2.5, 0.15)
    spikesBlip = AddBlipForCoord(pos["x"],pos["y"],pos["z"])

    SetBlipSprite(spikesBlip, 238)
	SetBlipScale(spikesBlip, 1.2)
	SetBlipAsShortRange(spikesBlip, true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("Spiked Road")
	EndTextCommandSetBlipName(spikesBlip)
	QBCore.Functions.Notify("You Put Spike on the Ground")
end

RegisterNetEvent("esx_policejob:play-spike-anim")
AddEventHandler("esx_policejob:play-spike-anim", function(vehicleData)
	local ped = PlayerPedId()
	local testdic = "weapons@first_person@aim_rng@generic@projectile@thermal_charge@"
	local testanim = "plant_floor"

	if IsPedArmed(ped, 7) then
		TriggerEvent("disc-inventoryhud:remove-weapon")
	end

	RequestAnimDict(testdic)

	while not HasAnimDictLoaded(testdic) do
		Citizen.Wait(0)
	end

	if IsEntityPlayingAnim(ped, testdic, testanim, 3) then
		ClearPedSecondaryTask(ped)
	else
		local animLength = GetAnimDuration(testdic, testanim)
		TaskPlayAnim(ped, testdic, testanim, 1.0, 1.0, -1, 48, -1, 0, 0, 0)
	end
end)
	
Citizen.CreateThread(function()
  	while true do
   		local time = 1000
	    local ped = PlayerPedId()

		if IsPedInAnyVehicle(ped, false) then
			if GetPedInVehicleSeat(GetVehiclePedIsIn(ped, false), -1) == PlayerPedId() then
				for k,v in pairs(spikeCoords) do
					local curDst = #(vector3(v["x"],v["y"],v["z"]) - GetEntityCoords(PlayerPedId()))
					if curDst < 35.0 and not v["watching"] then
						time = 1
						v["watching"] = true
						TriggerEvent("spikes:watchtarget", k)
					end
				end
			end		
		end
		Citizen.Wait(time)
    end
end)

Citizen.CreateThread(function()
  	while true do
   		Citizen.Wait(2000)
	    for k,v in pairs(spikeCoords) do
	    	local curDst = #(vector3(v["x"],v["y"],v["z"]) - GetEntityCoords(PlayerPedId()))
	    	if curDst < 85.0 then
		    	if v["placed"] == false or not DoesEntityExist(v["object"]) then
		    		deRenderSpikes(k)
					RenderSpikes(k)
				end
			else
				if v["placed"] == true or v["object"] ~= nil then
					deRenderSpikes(k)
				end
			end
			Wait(100)
	    end
    end
end)

function RenderSpikes(k)
	if not loadspikes then return end
	if spikeCoords[k].placed == true or spikeCoords[k].object ~= nil then return end
	spikeCoords[k].placed = true
	local spike = `P_ld_stinger_s`

    RequestModel(spike)
    while not HasModelLoaded(spike) do
      Citizen.Wait(1)
    end

	local SpikeObject = CreateObject(spike, spikeCoords[k].x,spikeCoords[k].y,spikeCoords[k].z, 0, 1, 1) -- x+1
    PlaceObjectOnGroundProperly(SpikeObject)
	SetEntityHeading(SpikeObject,spikeCoords[k].h)
	FreezeEntityPosition(SpikeObject,true)
	SetModelAsNoLongerNeeded(spike)
	spikeCoords[k].object = SpikeObject
end

function deRenderSpikes(k)
	local spike = spikeCoords[k].object
	DeleteObject(spike)
  	if DoesEntityExist(spike) then
      	SetEntityAsNoLongerNeeded(spike)
      	DeleteObject(spike)
  	end
  	if not DoesEntityExist(spike) then
	  	spikeCoords[k].placed = false
		spikeCoords[k].object = nil
	end
end

RegisterNetEvent('addSpikes')
AddEventHandler('addSpikes', function(newspikelist,spikeID)
	spikeCoords[spikeID] = newspikelist
end)

RegisterNetEvent('removeSpikes')
AddEventHandler('removeSpikes', function(spikeID)
	local found = false
	local src = GetPlayerServerId(PlayerId())
	if spikeCoords[spikeID].id == src then
		found = true
	end

	deRenderSpikes(spikeID)

	if found and DoesBlipExist(spikesBlip) then 
		QBCore.Functions.Notify("You Collected Spike Strip Wire") 
		RemoveBlip(spikesBlip) 
	end

	if spikeCoords[spikeID] then
		spikeCoords[spikeID] = nil
	end
end)

RegisterNetEvent('c_setSpike')
AddEventHandler('c_setSpike', function()
    local src = GetPlayerServerId(PlayerId())
	local found = false
	for k,v in pairs(spikeCoords) do
		if v.id == src then
			found = true
		end
	end
	if found then 
		QBCore.Functions.Notify("You Already Have One Spike Strip!") 
		return 
	end
    SetSpikesOnGround(3)
end)

RegisterNetEvent('police:spikesup')
AddEventHandler('police:spikesup', function()
	if not loadspikes then
		QBCore.Functions.Notify("You Already Collect Spike Strip.")
		return
	end
	loadspikes = false
	local removing = true
	local attempt = 0
	TriggerEvent("esx_policejob:play-spike-anim")

	while removing do
		removeSpikeStanding()
		Citizen.Wait(1000)
		attempt = attempt + 1
		if attempt > 4 then removing = false end
	end

	QBCore.Functions.Notify("You Collected Spike Strip!")
	Wait(1000)
	loadspikes = true
end)

function removeSpikeStanding()
	for k,v in pairs(spikeCoords) do
		local curDst = #(vector3(v["x"],v["y"],v["z"]) - GetEntityCoords(PlayerPedId()))
		if curDst < 15.0 then
			local spike = v.object
	      	
	      	--SetEntityCoords(PlayerPedId(),GetEntityCoords(spike))
		  	spikeRemoved = false
		  	TriggerServerEvent("esx_policejob:removespikes",k, {x = v["x"], y = v["y"], z = v["z"]})
		  	return
		end
	end
end

RegisterNetEvent('spikes:watchtarget')
AddEventHandler('spikes:watchtarget', function(watchsent)
	local watching = watchsent
	while true do 
		Citizen.Wait(0)
		local ped = PlayerPedId()
		local veh = GetVehiclePedIsIn(ped, false)
		local d1,d2 = GetModelDimensions(GetEntityModel(veh))
		if not IsPedInAnyVehicle(ped, false) then
			spikeCoords[watching]["watching"] = false
			return
		end

		if GetPedInVehicleSeat(veh, -1) ~= PlayerPedId() then 
			spikeCoords[watching]["watching"] = false
			return
		end

		if spikeCoords[watching] == nil then
			spikeCoords[watching]["watching"] = false
			return
		end
		
		if #(vector3(spikeCoords[watching]["x"],spikeCoords[watching]["y"],spikeCoords[watching]["z"]) - GetEntityCoords(PlayerPedId())) > 40.0 then
			spikeCoords[watching]["watching"] = false
			return
		end

		if not spikeCoords[watching]["watching"] then
			return
		end
		
		local spikeC = {["x"] = spikeCoords[watching]["x"],["y"] = spikeCoords[watching]["y"],["z"] = spikeCoords[watching]["z"]}
		local leftfront = GetOffsetFromEntityInWorldCoords(veh, d1["x"]-0.25,0.25,0.0)
		local rightfront = GetOffsetFromEntityInWorldCoords(veh, d2["x"]+0.25,0.25,0.0)
		local leftback = GetOffsetFromEntityInWorldCoords(veh, d1["x"]-0.25,-0.85,0.0)
		local rightback = GetOffsetFromEntityInWorldCoords(veh, d2["x"]+0.25,-0.85,0.0)

		if #(vector3(spikeC["x"],spikeC["y"],spikeC["z"]) - leftfront) < 2.5 and not IsVehicleTyreBurst(veh, 0) then
			SetVehicleTyreBurst(veh, 0, true, 1000.0)
			SetVehicleTyreBurst(veh, 1, false, 1000.0)
			SetVehicleTyreBurst(veh, 2, false, 1000.0)
		end

		if #(vector3(spikeC["x"],spikeC["y"],spikeC["z"]) - rightfront) < 2.5 and not IsVehicleTyreBurst(veh, 1) then
			SetVehicleTyreBurst(veh, 1, true, 1000.0)
			SetVehicleTyreBurst(veh, 0, false, 1000.0)
			SetVehicleTyreBurst(veh, 2, false, 1000.0)
			SetVehicleTyreBurst(veh, 3, false, 1000.0)
		end

		if #(vector3(spikeC["x"],spikeC["y"],spikeC["z"]) - leftback) < 2.5 and not IsVehicleTyreBurst(veh, 2) then
			SetVehicleTyreBurst(veh, 2, true, 1000.0)
			SetVehicleTyreBurst(veh, 1, false, 1000.0)
			SetVehicleTyreBurst(veh, 0, false, 1000.0)
			SetVehicleTyreBurst(veh, 3, false, 1000.0)			      		
		end

		if #(vector3(spikeC["x"],spikeC["y"],spikeC["z"]) - rightback) < 2.5 and not IsVehicleTyreBurst(veh, 3) then
			SetVehicleTyreBurst(veh, 3, true, 1000.0)
			SetVehicleTyreBurst(veh, 4, false, 1000.0)
			SetVehicleTyreBurst(veh, 5, false, 1000.0)
			SetVehicleTyreBurst(veh, 6, false, 1000.0)
			SetVehicleTyreBurst(veh, 7, false, 1000.0)      		
		end
	end
end)