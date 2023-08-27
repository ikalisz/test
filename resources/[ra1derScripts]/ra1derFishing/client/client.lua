
local QBCore = exports['qb-core']:GetCoreObject()
local fishing = false
local pause = false
local pausetimer = 0
local correct = 0
local genderNum = 0
local peds = {} 



local iskele = PolyZone:Create({
    vector2(-1825.8962402344, -1269.7790527344),
    vector2(-1865.5457763672, -1237.5599365234),
    vector2(-1865.5457763672, -1237.5599365234),
    vector2(-1859.1672363281, -1230.5557861328),
    vector2(-1878.9327392578, -1213.9964599609),
    vector2(-1832.1881103516, -1156.966796875),
    vector2(-1828.5258789063, -1160.1437988281),
    vector2(-1865.1180419922, -1211.2890625),
    vector2(-1825.3265380859, -1246.4106445313),
    vector2(-1788.9942626953, -1202.0679931641),
    vector2(-1830.6961669922, -1164.1791992188),
    vector2(-1828.3243408203, -1160.0938720703),
    vector2(-1782.4283447266, -1199.2137451172)
},{
    name = "Iskele",
    minZ = 1.0,
    maxZ = 20.0,
    debugPoly = false,
})

local iskele2 = PolyZone:Create({
    vector2(-3429.94, 947.344),
    vector2(-3428.72, 988.2315),
    vector2(-3407.44, 991.6101),
    vector2(-3406.75, 951.3004),
},{
    name = "Iskele2",
    minZ = 1.0,
    maxZ = 20.0,
    debugPoly = false,
})
local iskele3 = PolyZone:Create({
    vector2(1298.193, 4278.140),
    vector2(1349.331, 4266.685),
    vector2(1334.584, 4202.110),
	vector2(1292.802, 4214.118),
},{
    name = "Iskele3",
    minZ = 30.0,
    maxZ = 45.0,
    debugPoly = false,
})

local blips = {
    {title="Dock", colour=21, id=68, scale=0.7 ,coords = vector3(1304.290, 4242.977, 33.907)},
    {title="Dock", colour=21, id=68, scale=0.7 ,coords = vector3(-3421.75, 967.4378, 8.3334)},
    {title="Dock", colour=21, id=68, scale=0.7 ,coords = vector3(-1822.22, -1211.46, 13.016)},
}
    
    Citizen.CreateThread(function()
      for _, info in pairs(blips) do
        info.blip = AddBlipForCoord(info.coords.x, info.coords.y, info.coords.z)
        SetBlipSprite(info.blip, info.id)
        SetBlipDisplay(info.blip, 4)
        SetBlipScale(info.blip, info.scale)
        SetBlipColour(info.blip, info.colour)
        SetBlipAsShortRange(info.blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(info.title)
        EndTextCommandSetBlipName(info.blip)
      end
    end)


--============================================================== For testing




--============================================================== Threads
CreateThread(function()
	while true do
		Wait(1200)
		if pause and fishing then
			pausetimer = pausetimer + 1
		end
	end
end)

CreateThread(function()
	while true do
		Wait(1)
		if fishing then
				if IsControlJustReleased(0, 23) then
					input = 1
			   	end

			if IsControlJustReleased(0, Config.StopFishing) then
				endFishing()
				QBCore.Functions.Notify('Fishing Stopped', 'error')
				exports['qb-ui']:hideInteraction()
				DeleteObject(rodHandle)
				ClearPedTasks(ped)
				ClearPedTasksImmediately(PlayerPedId())
				endFishing()
			end

			if fishing then
				playerPed = PlayerPedId()
				local pos = GetEntityCoords(playerPed)
				end
				if IsEntityDead(playerPed) or IsEntityInWater(playerPed) then
					endFishing()
					QBCore.Functions.Notify('Fishing Stopped', 'error')
					exports['qb-ui']:hideInteraction()
					DeleteObject(rodHandle)
					ClearPedTasksImmediately(PlayerPedId())
					ClearPedTasks(ped)
					endFishing()
				end
			end
			
			if pausetimer > 3 then
				input = 99
			end
			
			if pause and input ~= 0 then
				pause = false
				if input == correct then
					TriggerEvent('fishing:SkillBar')
				else
					QBCore.Functions.Notify('Fish escaped!', 'error')
					exports['qb-ui']:hideInteraction()
					loseBait()
				end
			--end
		end
	end
end)

CreateThread(function()
	while true do

		local wait = math.random(Config.FishingWaitTime.minTime , Config.FishingWaitTime.maxTime)
		local pos = GetEntityCoords(PlayerPedId())
		Wait(wait)
		if fishing then
			pause = true
			correct = 1
			--  QBCore.Functions.Notify('Balık oltaya geldi, yakalamak için [F] tuşuna bas ', 'primary', 7500)
			 exports['qb-ui']:showInteraction("Fish Arrived, Press [F] to Catch")
			input = 0
			pausetimer = 0
			-- exports['qb-ui']:hideInteraction("balik")
		end
	end
end)



--============================================================== Events


RegisterNetEvent('fishing:client:attemptTreasureChest', function()
	local ped = PlayerPedId()
	attemptTreasureChest()
	QBCore.Functions.Progressbar("accepted_key", "Safe Opening", 3000, false, true, {
		disableMovement = true,
		disableCarMovement = true,
		disableMouse = false,
		disableCombat = true,
	}, {
		animDict = "mini@repair",
		anim = "fixing_a_player",
		flags = 16,
	}, {}, {}, function() -- Done
		ClearPedTasks(ped)
	end, function() -- Cancel
		ClearPedTasks(ped)
		QBCore.Functions.Notify("It is cancelled!", "error")
	end)
end)


RegisterNetEvent('fishing:SkillBar', function(message)
	exports['qb-ui']:hideInteraction()
	if Config.Skillbar == "tgiann-skillbar" then
		local finished = exports["tgiann-skillbar"]:taskBar(math.random(25000,40000),math.random(2,4))
		if not finished then
			QBCore.Functions.Notify('Fish escaped!', 'error')
		loseBait()
			else
				catchAnimation()
			end
	elseif Config.Skillbar == "np-skillbar" then 
		local finished = exports["np-skillbar"]:taskBar(1000,math.random(3,5))
		if finished ~= 100 then
			QBCore.Functions.Notify('Fish escaped', 'error')
			loseBait()
		else
			catchAnimation()
		end
	elseif Config.Skillbar == "qb-skillbar" then
		local Skillbar = exports['qb-skillbar']:GetSkillbarObject()
		Skillbar.Start({
			duration = math.random(2500,5000),
			pos = math.random(10, 30),
			width = math.random(10, 20),
		}, function()
			catchAnimation()
		end, function()
			QBCore.Functions.Notify('Fish escaped', 'error')
			loseBait()
		end)
	end
end) 



RegisterNetEvent('fishing:fishstart', function()
	local playerPed = PlayerPedId()
	local pos = GetEntityCoords(playerPed) 
    local coords = GetEntityCoords(PlayerPedId())
	Iskele = iskele:isPointInside(coords)
	Iskele2 = iskele2:isPointInside(coords)
	Iskele3 = iskele3:isPointInside(coords)
    if Iskele or Iskele2 or Iskele3 then
	if IsPedSwimming(playerPed) then return QBCore.Functions.Notify("Yüzerken balık tutamazsın!.", "error") end 
	if IsPedInAnyVehicle(playerPed) then return QBCore.Functions.Notify("Araç sürerken balık tutamazsın!", "error") end 
	if GetWaterHeight(pos.x, pos.y, pos.z-2, pos.z - 3.0)  then
	-- if #(GetEntityCoords(playerPed) - vector3(-1841.19, -1221.05, 13.008)) < 75.0 then
		local time = 3500
		QBCore.Functions.Notify('Olta Denize Fırlatıldı', 'primary', time)
		Wait(time)
		exports['qb-ui']:showInteraction("[X] Balık Tutmayı Bırak")
		fishAnimation()
	else
		QBCore.Functions.Notify('Balık tutabilmek için denize bakmalısın', 'error')
	end
	    else
		    QBCore.Functions.Notify('Sadece iskelelerde balık tutabilirsin', 'error')
	    end
end)




--============================================================== Functions

loseBait = function()
	local chance = math.random(1, 15)
	if chance <= 5 then
		TriggerServerEvent("fishing:server:removeFishingBait")
		loseBaitAnimation()
	end
end

loseBaitAnimation = function()
	local ped = PlayerPedId()
	local animDict = "gestures@f@standing@casual"
	local animName = "gesture_damn"
	DeleteEntity(rodHandle)
	RequestAnimDict(animDict)
	while not HasAnimDictLoaded(animDict) do
		Wait(100)
	end
	TaskPlayAnim(ped, animDict, animName, 1.0, -1.0, 1.0, 0, 0, 0, 48, 0)
	RemoveAnimDict(animDict)
	QBCore.Functions.Notify('Oltanın ucunda ki yemi balık yuttu', 'error', 3500)
	Wait(2000)
	exports['qb-ui']:hideInteraction()
	fishAnimation()
end

RequestTheModel = function(model)
	RequestModel(model)
	while not HasModelLoaded(model) do
		Wait(0)
	end
end

catchAnimation = function()
	local ped = PlayerPedId()
	local animDict = "mini@tennis"
	local animName = "forehand_ts_md_far"
	DeleteEntity(rodHandle)
	RequestAnimDict(animDict)
	while not HasAnimDictLoaded(animDict) do
		Wait(100)
	end
	TaskPlayAnim(ped, animDict, animName, 1.0, -1.0, 1.0, 0, 0, 0, 48, 0)
	local time = 1750
	QBCore.Functions.Notify('Balık Yakalandı', 'success', time)
	Wait(time)
	TriggerServerEvent('fishing:server:catch') 
	loseBait()
	-- if math.random(1, 100) < 50 then
	-- 	-- TriggerServerEvent('hud:server:RelieveStress', 50)
	-- end
	PlaySoundFrontend(-1, "OK", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
	RemoveAnimDict(animDict)
	endFishing()
end

fishAnimation = function()
	QBCore.Functions.TriggerCallback('elixir-base:item-kontrol', function(balik)
		if balik > 0 then
			local ped = PlayerPedId()
			local animDict = "amb@world_human_stand_fishing@idle_a"
			local animName = "idle_c"
			RequestAnimDict(animDict)
			while not HasAnimDictLoaded(animDict) do
				Wait(100)
			end
			TaskPlayAnim(ped, animDict, animName, 1.0, -1.0, 1.0, 11, 0, 0, 0, 0)
			fishingRodEntity()
			fishing = true
			Wait(3700)
			exports['qb-ui']:hideInteraction()
		else
		  endFishing()
		  QBCore.Functions.Notify("Balık Yemin Yok", "error")
		end
	end, 'fishbait')
end

fishingRodEntity = function()
	local ped = PlayerPedId()
    local pedPos = GetEntityCoords(ped)
	local fishingRodHash = `prop_fishing_rod_01`
	local bone = GetPedBoneIndex(ped, 18905)
    rodHandle = CreateObject(fishingRodHash, pedPos, true)
    AttachEntityToEntity(rodHandle, ped, bone, 0.1, 0.05, 0, 80.0, 120.0, 160.0, true, true, false, true, 1, true)
end

endFishing = function() 
	local ped = PlayerPedId()
    if rodHandle ~= 0 then
		DeleteObject(rodHandle)
		ClearPedTasks(ped)
		fishing = false
		rodHandle = 0
		exports['qb-ui']:hideInteraction()
		DeleteEntity(rodHandle)
    end
end

attemptTreasureChest = function()
	local ped = PlayerPedId()
	local animDict = "veh@break_in@0h@p_m_one@"
	local animName = "low_force_entry_ds"
	RequestAnimDict(animDict)
	while not HasAnimDictLoaded(animDict) do
		Wait(100)
	end
	TaskPlayAnim(ped, animDict, animName, 1.0, 1.0, 1.0, 1, 0.0, 0, 0, 0)
	RemoveAnimDict(animDict)
	QBCore.Functions.Notify('Sandığı Açmaya Çalışıyorsun', 'primary', 1500)
	Wait(1500)
	ClearPedTasks(PlayerPedId())
end


nearPed = function(model, coords, heading, gender, animDict, animName, scenario)
	RequestModel(GetHashKey(model))
	while not HasModelLoaded(GetHashKey(model)) do
		Wait(1)
	end

	if gender == 'male' then
		genderNum = 4
	elseif gender == 'female' then 
		genderNum = 5
	else
	end	

	ped = CreatePed(genderNum, GetHashKey(v.model), coords, heading, false, true)
	SetEntityAlpha(ped, 0, false)

	FreezeEntityPosition(ped, true)
	SetEntityInvincible(ped, true)
	SetBlockingOfNonTemporaryEvents(ped, true)
	if animDict and animName then
		RequestAnimDict(animDict)
		while not HasAnimDictLoaded(animDict) do
			Wait(1)
		end
		TaskPlayAnim(ped, animDict, animName, 8.0, 0, -1, 1, 0, 0, 0)
	end
	if scenario then
		TaskStartScenarioInPlace(ped, scenario, 0, true) 
	end
	for i = 0, 255, 51 do
		Wait(50)
		SetEntityAlpha(ped, i, false)
	end

	return ped
end
