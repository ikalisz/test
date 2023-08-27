local QBCore = exports['qb-core']:GetCoreObject()
PlayerData = {}
robbingHouseid = nil
robstarted = false
casesearched = false
blipstarted = false
notified = false
robberyped = nil
local kilitac = false
local duzKontakSes = false
local isLockpicking = false

local robbableItems = {
	[1] = {x = 1.90339700, y = -3.80026800, z = 1.29917900, isSearched = false},
	[2] = {x = -3.50363200, y = -6.55289400, z = 1.30625800, isSearched = false},
	[3] = {x = -3.50712600, y = -4.13621600, z = 1.29625800, isSearched = false},
	[4] = {x = 8.47819500, y = -2.50979300, z = 1.19712300, isSearched = false},
	[5] = {x = 9.75982700, y = -1.35874100, z = 1.29625800, isSearched = false},
	[6] = {x = 8.46626300, y = 4.53223600, z = 1.19425800, isSearched = false},
	[7] = {x = 5.84416200, y = 2.57377400, z = 1.22089100, isSearched = false},
	[8] = {x = 2.03442400, y = -5.61585100, z = 1.75, isSearched = false},
	[9] = {x = 2.91325400, y = -4.2783510, z = 1.82746400, isSearched = false},
	[10] = {x = -1.51325400, y = 1.2783510, z = 1.72746400, isSearched = false},
}

Citizen.CreateThread(function ()
  while QBCore == nil do
  TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)
  Citizen.Wait(1)
 end

 while QBCore.Functions.GetPlayerData() == nil do
  Citizen.Wait(10)
 end

 PlayerData = QBCore.Functions.GetPlayerData()
end)

RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    PlayerData = QBCore.Functions.GetPlayerData()
end)


RegisterNetEvent('QBCore:Client:OnJobUpdate')
AddEventHandler('QBCore:Client:OnJobUpdate', function(job)
    PlayerData.job = job
end)


RegisterCommand('raid', function()
	if not robstarted then
		local pPed = PlayerPedId()
		local pCoords = GetEntityCoords(pPed)
		for i = 1, #Config.Houses, 1 do
			if isCops() then
				local distance = #(pCoords - Config.Houses[i].door)
				if distance < 15 then
					enterRaid(i)
				end
			end
		end
	end
end)



AddEventHandler('lockpickAnimation', function()
	isLockpicking = true
	loadAnimDict('veh@break_in@0h@p_m_one@')
	while isLockpicking do
	 if not IsEntityPlayingAnim(PlayerPedId(), "veh@break_in@0h@p_m_one@", "low_force_entry_ds", 3) then
	  TaskPlayAnim(PlayerPedId(), "veh@break_in@0h@p_m_one@", "low_force_entry_ds", 1.0, 1.0, 1.0, 1, 0.0, 0, 0, 0)
	  Citizen.Wait(1500)
	  ClearPedTasks(PlayerPedId())
	 end
	 Citizen.Wait(1)
	end
	ClearPedTasks(PlayerPedId())
end)

RegisterNetEvent('x-hotwire:duzKontakSes')
AddEventHandler('x-hotwire:duzKontakSes', function()
    while duzKontakSes do
      TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 3.0, 'duzkontak', 0.4)
      Citizen.Wait(3000)
    end
end)





RegisterNetEvent('ra1derHouseRob:useLockpick')
AddEventHandler('ra1derHouseRob:useLockpick', function()
    if not robstarted then
        local pPed = PlayerPedId()
        local pCoords = GetEntityCoords(pPed)
        for i = 1, #Config.Houses, 1 do
            local distance = #(pCoords - Config.Houses[i].door)
            if distance < 1.5 then
                    if isNight() then
						duzKontakSes = true
						isLockpicking = true
						TriggerEvent("lockpickAnimation")
						TriggerEvent("x-hotwire:duzKontakSes")
						FreezeEntityPosition(PlayerPedId(), true)
						TriggerEvent('lsrp-lockpick:StartLockpickfo', function(result)
							kilitac = true
							if result then
							  ClearPedTasks(PlayerPedId())
							  useLever(i)
							  TriggerServerEvent('lockpicksil')
							elseif result == false then
								TriggerServerEvent('lockpicksil')
							end
							ClearPedTasks(playerPed)
							duzKontakSes = false
							isLockpicking = false
							FreezeEntityPosition(PlayerPedId(), false)
						end)
                    else
						QBCore.Functions.Notify('you cant do this right now!', 5000, "error")
						FreezeEntityPosition(PlayerPedId(), false)
                    end
					break
            end
        end
    end
end)

function isNight()
	local hour = GetClockHours()
	if hour > 21 or hour < 8 then
		return true
	end
end

Citizen.CreateThread(function()
	while true do
		local sleepThread = 1000
		if robstarted and robbingHouseid ~= nil then

			local pCoords = GetEntityCoords(PlayerPedId())
			local hCoords = vector3(Config.Houses[robbingHouseid].door.x+3.6, Config.Houses[robbingHouseid].door.y-15, Config.Houses[robbingHouseid].door.z-20)
			local distance = #(pCoords - hCoords)
			if distance < 3 then
				DrawMarker(2, Config.Houses[robbingHouseid].door.x+3.6, Config.Houses[robbingHouseid].door.y-15, Config.Houses[robbingHouseid].door.z-17.8, 0, 0, 0, 0, 0, 0, 0.2, 0.2, 0.2, 0, 157, 0, 155, 0, 0, 2, 1, 0, 0, 0)
				if distance < 2.5 then
					 QBCore.Functions.DrawText3D(Config.Houses[robbingHouseid].door.x+3.6, Config.Houses[robbingHouseid].door.y-15, Config.Houses[robbingHouseid].door.z-17.6, '~g~[F]~w~ - Evden Ayrıl')
					-- exports['qb-ui']:showInteraction("[F] Evden Arıl")
				-- else
				-- 	-- exports['qb-ui']:hideInteraction()
					if IsControlJustPressed(0, 23) then --f
						leaveHouse(robbingHouseid)
						-- exports['qb-ui']:hideInteraction()
					end
				end
			end
			if not isCops() then
				if GetPlayerCurrentStealthNoise(PlayerId()) < 5 then
					drawTxt(0.280, 0.965, 0.45, 'Volume :~g~ ' .. math.ceil(GetPlayerCurrentStealthNoise(PlayerId())), 188, 185, 185, 255)
				elseif GetPlayerCurrentStealthNoise(PlayerId()) > 5 then
					drawTxt(0.280, 0.965, 0.45, 'Volume :~r~ ' .. math.ceil(GetPlayerCurrentStealthNoise(PlayerId())), 188, 185, 185, 255)

					if CanPedHearPlayer(PlayerId(), robberyped) then
						FreezeEntityPosition(robberyped, false)
						SetPedDropsWeaponsWhenDead(robberyped, false)
						TaskCombatPed(robberyped, PlayerPedId(), 0, 16)
						SetPedKeepTask(robberyped, true)
						if not notified then
							notified = true
							notifyCops()
						end
					end
				end

				for i=1, #robbableItems, 1 do
					if robbingHouseid ~= nil then
						local lCoords = vector3(Config.Houses[robbingHouseid].door.x + robbableItems[i].x, Config.Houses[robbingHouseid].door.y + robbableItems[i].y, (Config.Houses[robbingHouseid].door.z - 20) + robbableItems[i].z)
						local ldistance = #(pCoords - lCoords)
						if ldistance < 1.5 and not robbableItems[i].isSearched then
							QBCore.Functions.DrawText3D(Config.Houses[robbingHouseid].door.x + robbableItems[i].x, Config.Houses[robbingHouseid].door.y  + robbableItems[i].y, (Config.Houses[robbingHouseid].door.z - 20) + robbableItems[i].z, '[E] - Ara ')
							if IsControlJustPressed(0, 38) then --e
								search(i)
							end
						end
					end
				end

				if not casesearched then
					if robbingHouseid ~= nil then
						local sCoords = vector3(Config.Houses[robbingHouseid].door.x+6.2, Config.Houses[robbingHouseid].door.y+4.52972300, (Config.Houses[robbingHouseid].door.z - 20)+1.32609800)
						local idistance = #(pCoords - sCoords)
						if idistance < 1.5 then
							QBCore.Functions.DrawText3D(sCoords.x, sCoords.y, sCoords.z + 1.3, '[E] Open Safe')
							if IsControlJustPressed(0, 38) then --e
								SafeRewards = math.random(1500, 2500)
								StartMinigame(SafeRewards)
							end
						end
					end
				end
			end
			sleepThread = 5
		else
			sleepThread = 500
		end
		Citizen.Wait(sleepThread)
	end
end)


function isCops()
	while PlayerData.job == nil do
		Citizen.Wait(1)
	end

	  if PlayerData.job.name == "police" then
		return true
	elseif PlayerData.job.name == 'sheriff' then
		return true
	elseif PlayerData.job.name == 'ambulance' then
		return true
	else
		return false
	end
end

function leaveHouse(id)
	DoScreenFadeOut(800)
	while not IsScreenFadedOut() do
		Citizen.Wait(0)
	end

	SetArtificialLightsState(false)
	SetEntityCoords(PlayerPedId(), Config.Houses[id].door.x, Config.Houses[id].door.y, Config.Houses[id].door.z)

	if DoesEntityExist(robberyped) then
		SetEntityCollision(robberyped, false, false)
		SetEntityAlpha(robberyped, 0.0, true)
		SetEntityAsMissionEntity(robberyped, false, true)
		DeleteEntity(robberyped)
	end

	deleteSpawnedHouse(id)

	for i = 1, #robbableItems, 1 do
		robbableItems[i].isSearched = false
	end

	DoScreenFadeIn(800)
	
	robbingHouseid = nil
	robstarted = false
	casesearched = false
	blipstarted = false
	notified = false
	robberyped = nil
end

function lockFinished()
	casesearched = true
	TriggerServerEvent('ra1derHouseRob:kasaiptal')
	-- exports["tq-level"]:addExp(15)
	-- TriggerEvent('mythic_notify:client:SendAlert', { type = 'inform', text = 'Saygınlığın arttı'})
end



function enterRaid(id)
	createHouse(Config.Houses[id].door, id, true)
	robstarted = true
	robbingHouseid = id

	repeat
		Citizen.Wait(10)
	until IsControlJustPressed(0, 32)
end


function useLever(id)
	QBCore.Functions.TriggerCallback('elixir-base:polis-sayi', function(result)
		if result then --3
			duzKontakSes = true
			isLockpicking = true
			notifyCops()
			FreezeEntityPosition(PlayerPedId(), true)
			QBCore.Functions.Progressbar("search", "Picking UP...", 10000, false, true, { -- p1: menu name, p2: yazı, p3: ölü iken kullan, p4:iptal edilebilir
				disableMovement = true,
				disableCarMovement = true,
				disableMouse = false,
				disableCombat = true,
			}, {}, {}, {}, function() -- Done
				createHouse(Config.Houses[id].door, id, false)
				createSafe(Config.Houses[id].door)
				duzKontakSes = false
				robstarted = true
				isLockpicking = false
				robbingHouseid = id
				QBCore.Functions.Notify("You managed to open the door")
				FreezeEntityPosition(PlayerPedId(), false)
				TriggerServerEvent('ra1derHouseRob:updateRobTime')
				duzKontakSes = false
				isLockpicking = false

				repeat
					Citizen.Wait(10)
				until IsControlJustPressed(0, 32)

				FreezeEntityPosition(PlayerPedId(),false)
				FreezeEntityPosition(robberyped, false)
			end, function() -- Cancel
				QBCore.Functions.Notify('Transaction Canceled')
				FreezeEntityPosition(PlayerPedId(), true)
			end)
		end
	end)
end

function createSafe(coords)
	local x, y, z = table.unpack(coords)
	local generator = {x = x, y = y, z = z - 20}

	local safe = CreateObject(-1251197000, generator.x+6.2, generator.y+4.52972300, generator.z+1.32609800, 0, 0, 0)
	FreezeEntityPosition(safe, true)
end

function createHouse(coords, id, isCop)
	local x, y, z = table.unpack(coords)
	local generator = {x = x, y = y, z = z - 20}

	DoScreenFadeOut(100)
	Citizen.Wait(100)
	SetArtificialLightsState(true)
	SetEntityCoords(PlayerPedId(), 347.04724121094, -1000.2844848633, -99.194671630859)
	FreezeEntityPosition(PlayerPedId(), true)
	Citizen.Wait(2000)
	local building = CreateObject(GetHashKey("shell_v16mid"), generator.x+2.25, generator.y-1.32, generator.z+1.18, false, false, false)
	FreezeEntityPosition(building, true)
	Citizen.Wait(500)
	SetEntityCoords(PlayerPedId(), generator.x+3.6, generator.y-14.8, generator.z+1.5)
	SetEntityHeading(PlayerPedId(), 358.106)

	-- local dt = CreateObject(GetHashKey("V_16_DT"), generator.x-1.21854400, generator.y-1.04389600, generator.z+1.39068600, false, false, false)
	-- local mpmid01 = CreateObject(GetHashKey("V_16_mpmidapart01"), generator.x+0.52447510, generator.y-5.04953700, generator.z+1.32, false, false, false)
	local mpmid09 = CreateObject(GetHashKey("V_16_mpmidapart09"), generator.x+0.82202150, generator.y+2.29612000, generator.z+1.88, false, false, false)
	-- local mpmid07 = CreateObject(GetHashKey("V_16_mpmidapart07"), generator.x-1.91445900, generator.y-6.61911300, generator.z+1.45, false, false, false)
	-- local mpmid03 = CreateObject(GetHashKey("V_16_mpmidapart03"), generator.x-4.82565300, generator.y-6.86803900, generator.z+1.14, false, false, false)
	-- local midData = CreateObject(GetHashKey("V_16_midapartdeta"), generator.x+2.28558400, generator.y-1.94082100, generator.z+1.32, false, false, false)
	-- local glow = CreateObject(GetHashKey("V_16_treeglow"), generator.x-1.37408500, generator.y-0.95420070, generator.z+1.135, false, false, false)
	-- local curtins = CreateObject(GetHashKey("V_16_midapt_curts"), generator.x-1.96423300, generator.y-0.95958710, generator.z+1.280, false, false, false)
	-- local mpmid13 = CreateObject(GetHashKey("V_16_mpmidapart13"), generator.x-4.65580700, generator.y-6.61684000, generator.z+1.259, false, false, false)
	-- local mpcab = CreateObject(GetHashKey("V_16_midapt_cabinet"), generator.x-1.16177400, generator.y-0.97333810, generator.z+1.27, false, false, false)
	-- local mpdecal = CreateObject(GetHashKey("V_16_midapt_deca"), generator.x+2.311386000, generator.y-2.05385900, generator.z+1.297, false, false, false)
	-- local mpdelta = CreateObject(GetHashKey("V_16_mid_hall_mesh_delta"), generator.x+3.69693000, generator.y-5.80020100, generator.z+1.293, false, false, false)
	-- local beddelta = CreateObject(GetHashKey("V_16_mid_bed_delta"), generator.x+7.95187400, generator.y+1.04246500, generator.z+1.28402300, false, false, false)
	local bed = CreateObject(GetHashKey("v_res_msonbed_s"), generator.x+6.86376900, generator.y+1.20651200, generator.z+1.33589100, false, false, false) --V_16_mid_bed_bed
	-- local beddecal = CreateObject(GetHashKey("V_16_MID_bed_over_decal"), generator.x+7.82861300, generator.y+1.04696700, generator.z+1.34753700, false, false, false)
	-- local bathDelta = CreateObject(GetHashKey("V_16_mid_bath_mesh_delta"), generator.x+4.45460500, generator.y+3.21322800, generator.z+1.21116100, false, false, false)
	-- local bathmirror = CreateObject(GetHashKey("V_16_mid_bath_mesh_mirror"), generator.x+3.57740800, generator.y+3.25032000, generator.z+1.48871300, false, false, false)
	local beerbot = CreateObject(GetHashKey("Prop_CS_Beer_Bot_01"), generator.x+1.73134600, generator.y-4.88520200, generator.z+1.91083000, false, false, false)
	local couch = CreateObject(GetHashKey("v_res_mp_sofa"), generator.x-1.48765600, generator.y+1.68100600, generator.z+1.33640500, false, false, false)
	local chair = CreateObject(GetHashKey("v_res_mp_stripchair"), generator.x-4.44770800, generator.y-1.78048800, generator.z+1.21640500, false, false, false)
	local chair2 = CreateObject(GetHashKey("v_res_tre_chair"), generator.x+2.91325400, generator.y-5.27835100, generator.z+1.22746400, false, false, false)
	local plant = CreateObject(GetHashKey("Prop_Plant_Int_04a"), generator.x+2.78941300, generator.y-4.39133900, generator.z+2.12746400, false, false, false)
	local lamp = CreateObject(GetHashKey("v_res_d_lampa"), generator.x-3.61473100, generator.y-6.61465100, generator.z+2.09373700, false, false, false)
	local fridge = CreateObject(GetHashKey("v_res_fridgemodsml"), generator.x+1.90339700, generator.y-3.80026800, generator.z+1.29917900, false, false, false)
	local micro = CreateObject(GetHashKey("prop_micro_01"), generator.x+2.03442400, generator.y-4.64585100, generator.z+2.28995600, false, false, false)
	local sideBoard = CreateObject(GetHashKey("V_Res_Tre_SideBoard"), generator.x+2.84053000, generator.y-4.30947100, generator.z+1.24577300, false, false, false)
	local bedSide = CreateObject(GetHashKey("V_Res_Tre_BedSideTable"), generator.x-3.50363200, generator.y-6.55289400, generator.z+1.30625800, false, false, false)
	local lamp2 = CreateObject(GetHashKey("v_res_d_lampa"), generator.x+2.69674700, generator.y-3.83123500, generator.z+2.09373700, false, false, false)
	local plant2 = CreateObject(GetHashKey("v_res_tre_tree"), generator.x-4.96064800, generator.y-6.09898500, generator.z+1.31631400, false, false, false)
	local table = CreateObject(GetHashKey("V_Res_M_DineTble_replace"), generator.x-3.50712600, generator.y-4.13621600, generator.z+1.29625800, false, false, false)
	local tv = CreateObject(GetHashKey("Prop_TV_Flat_01"), generator.x-5.53120400, generator.y+0.76299670, generator.z+2.17236000, false, false, false)
	local plant3 = CreateObject(GetHashKey("v_res_tre_plant"), generator.x-5.14112800, generator.y-2.78951000, generator.z+1.25950800, false, false, false)
	local chair3 = CreateObject(GetHashKey("v_res_m_dinechair"), generator.x-3.04652400, generator.y-4.95971200, generator.z+1.19625800, false, false, false)
	local lampStand = CreateObject(GetHashKey("v_res_m_lampstand"), generator.x+1.26588400, generator.y+3.68883900, generator.z+1.35556700, false, false, false)
	local stool = CreateObject(GetHashKey("V_Res_M_Stool_REPLACED"), generator.x-3.23216300, generator.y+2.06159000, generator.z+1.20556700, false, false, false)
	local chair4 = CreateObject(GetHashKey("v_res_m_dinechair"), generator.x-2.82237200, generator.y-3.59831300, generator.z+1.25950800, false, false, false)
	local chair5 = CreateObject(GetHashKey("v_res_m_dinechair"), generator.x-4.14955100, generator.y-4.71316600, generator.z+1.19625800, false, false, false)
	local chair6 = CreateObject(GetHashKey("v_res_m_dinechair"), generator.x-3.80622900, generator.y-3.37648300, generator.z+1.19625800, false, false, false)
	local plant4 = CreateObject(GetHashKey("v_res_fa_plant01"), generator.x+2.97859200, generator.y+2.55307400, generator.z+1.85796300, false, false, false)
	local storage = CreateObject(GetHashKey("v_res_tre_storageunit"), generator.x+8.47819500, generator.y-2.50979300, generator.z+1.19712300, false, false, false)
	local storage2 = CreateObject(GetHashKey("v_res_tre_storagebox"), generator.x+9.75982700, generator.y-1.35874100, generator.z+1.29625800, false, false, false)
	local basketmess = CreateObject(GetHashKey("v_res_tre_basketmess"), generator.x+8.70730600, generator.y-2.55503600, generator.z+1.94059590, false, false, false)
	local lampStand2 = CreateObject(GetHashKey("v_res_m_lampstand"), generator.x+9.54306000, generator.y-2.50427700, generator.z+1.30556700, false, false, false)
	local plant4 = CreateObject(GetHashKey("Prop_Plant_Int_03a"), generator.x+9.87521400, generator.y+3.90917400, generator.z+1.20829700, false, false, false)
	local basket = CreateObject(GetHashKey("v_res_tre_washbasket"), generator.x+9.39091500, generator.y+4.49676300, generator.z+1.19625800, false, false, false)
	local wardrobe = CreateObject(GetHashKey("V_Res_Tre_Wardrobe"), generator.x+8.46626300, generator.y+4.53223600, generator.z+1.19425800, false, false, false)
	local basket2 = CreateObject(GetHashKey("v_res_tre_flatbasket"), generator.x+8.51593000, generator.y+4.55647300, generator.z+3.46737300, false, false, false)
	local basket3 = CreateObject(GetHashKey("v_res_tre_basketmess"), generator.x+7.57797200, generator.y+4.55198800, generator.z+3.46737300, false, false, false)
	local basket4 = CreateObject(GetHashKey("v_res_tre_flatbasket"), generator.x+7.12286400, generator.y+4.54689200, generator.z+3.46737300, false, false, false)
	local wardrobe2 = CreateObject(GetHashKey("V_Res_Tre_Wardrobe"), generator.x+7.24382000, generator.y+4.53423500, generator.z+1.19625800, false, false, false)
	local basket5 = CreateObject(GetHashKey("v_res_tre_flatbasket"), generator.x+8.03364600, generator.y+4.54835500, generator.z+3.46737300, false, false, false)
	local switch = CreateObject(GetHashKey("v_serv_switch_2"), generator.x+6.28086900, generator.y-0.68169880, generator.z+2.30326000, false, false, false)
	local table2 = CreateObject(GetHashKey("V_Res_Tre_BedSideTable"), generator.x+5.84416200, generator.y+2.57377400, generator.z+1.22089100, false, false, false)
	local lamp3 = CreateObject(GetHashKey("v_res_d_lampa"), generator.x+5.84912100, generator.y+2.58001100, generator.z+1.95311890, false, false, false)
	local ashtray = CreateObject(GetHashKey("Prop_ashtray_01"), generator.x-1.24716200, generator.y+1.07820500, generator.z+1.87089300, false, false, false)
	local candle1 = CreateObject(GetHashKey("v_res_fa_candle03"), generator.x-2.89289900, generator.y-4.35329700, generator.z+2.02881310, false, false, false)
	local candle2 = CreateObject(GetHashKey("v_res_fa_candle02"), generator.x-3.99865700, generator.y-4.06048500, generator.z+2.02530190, false, false, false)
	local candle3 = CreateObject(GetHashKey("v_res_fa_candle01"), generator.x-3.37733400, generator.y-3.66639800, generator.z+2.02526200, false, false, false)
	local woodbowl = CreateObject(GetHashKey("v_res_m_woodbowl"), generator.x-3.50787400, generator.y-4.11983000, generator.z+2.02589900, false, false, false)
	local tablod = CreateObject(GetHashKey("V_Res_TabloidsA"), generator.x-0.80513000, generator.y+0.51389600, generator.z+1.18418800, false, false, false)
	local tapeplayer = CreateObject(GetHashKey("Prop_Tapeplayer_01"), generator.x-1.26010100, generator.y-3.62966400, generator.z+2.37883200, false, false, false)
	local woodbowl2 = CreateObject(GetHashKey("v_res_tre_fruitbowl"), generator.x+2.77764900, generator.y-4.138297000, generator.z+2.10340100, false, false, false)
	local sculpt = CreateObject(GetHashKey("v_res_sculpt_dec"), generator.x+3.03932200, generator.y+1.62726400, generator.z+3.58363900, false, false, false)
	local jewlry = CreateObject(GetHashKey("v_res_jewelbox"), generator.x+3.04164100, generator.y+0.31671810, generator.z+3.58363900, false, false, false)
	local basket6 = CreateObject(GetHashKey("v_res_tre_basketmess"), generator.x-1.64906300, generator.y+1.62675900, generator.z+1.39038500, false, false, false)
	local basket7 = CreateObject(GetHashKey("v_res_tre_flatbasket"), generator.x-1.63938900, generator.y+0.91133310, generator.z+1.39038500, false, false, false)
	local basket8 = CreateObject(GetHashKey("v_res_tre_flatbasket"), generator.x-1.19923400, generator.y+1.69598600, generator.z+1.39038500, false, false, false)
	local basket9 = CreateObject(GetHashKey("v_res_tre_basketmess"), generator.x-1.18293800, generator.y+0.91436380, generator.z+1.39038500, false, false, false)
	local bowl = CreateObject(GetHashKey("v_res_r_sugarbowl"), generator.x-0.26029210, generator.y-6.66716800, generator.z+3.77324900, false, false, false)
	local breadbin = CreateObject(GetHashKey("Prop_Breadbin_01"), generator.x+2.09788500, generator.y-6.57634000, generator.z+2.24041900, false, false, false)
	local knifeblock = CreateObject(GetHashKey("v_res_mknifeblock"), generator.x+1.82084700, generator.y-6.58438500, generator.z+2.27399500, false, false, false)
	local toaster = CreateObject(GetHashKey("prop_toaster_01"), generator.x-1.05790700, generator.y-6.59017400, generator.z+2.26793200, false, false, false)
	-- local wok = CreateObject(GetHashKey("prop_wok"), generator.x+2.01728800, generator.y-5.57091500, generator.z+2.31793200, false, false, false)
	local plant5 = CreateObject(GetHashKey("Prop_Plant_Int_03a"), generator.x+2.55015600, generator.y+4.60183900, generator.z+1.20829700, false, false, false)
	local tumbler = CreateObject(GetHashKey("p_tumbler_cs2_s"), generator.x-0.90916440, generator.y-4.24099100, generator.z+2.24693200, false, false, false)
	local wisky = CreateObject(GetHashKey("p_whiskey_bottle_s"), generator.x-0.92809300, generator.y-3.99099100, generator.z+2.24693200, false, false, false)
	local tissue = CreateObject(GetHashKey("v_res_tissues"), generator.x+7.95889300, generator.y-2.54847100, generator.z+1.94013400, false, false, false)
	local pants = CreateObject(GetHashKey("V_16_Ap_Mid_Pants4"), generator.x+7.55366500, generator.y-0.25457100, generator.z+1.33009200, false, false, false)
	local pants2 = CreateObject(GetHashKey("V_16_Ap_Mid_Pants5"), generator.x+7.76753200, generator.y+3.00476500, generator.z+1.33052800, false, false, false)
	local hairdryer = CreateObject(GetHashKey("v_club_vuhairdryer"), generator.x+8.12616000, generator.y-2.50562000, generator.z+1.96009390, false, false, false)

	-- FreezeEntityPosition(dt,true)
	-- FreezeEntityPosition(mpmid01,true)
	-- FreezeEntityPosition(mpmid09,true)
	-- FreezeEntityPosition(mpmid07,true)
	-- FreezeEntityPosition(mpmid03,true)
	-- FreezeEntityPosition(midData,true)
	-- FreezeEntityPosition(glow,true)
	-- FreezeEntityPosition(curtins,true)
	-- FreezeEntityPosition(mpmid13,true)
	-- FreezeEntityPosition(mpcab,true)
	-- FreezeEntityPosition(mpdecal,true)
	-- FreezeEntityPosition(mpdelta,true)
	FreezeEntityPosition(couch,true)
	FreezeEntityPosition(chair,true)
	FreezeEntityPosition(chair2,true)
	FreezeEntityPosition(plant,true)
	FreezeEntityPosition(lamp,true)
	FreezeEntityPosition(fridge,true)
	FreezeEntityPosition(micro,true)
	FreezeEntityPosition(sideBoard,true)
	FreezeEntityPosition(bedSide,true)
	FreezeEntityPosition(plant2,true)
	FreezeEntityPosition(table,true)
	FreezeEntityPosition(tv,true)
	FreezeEntityPosition(plant3,true)
	FreezeEntityPosition(chair3,true)
	FreezeEntityPosition(lampStand,true)
	FreezeEntityPosition(chair4,true)
	FreezeEntityPosition(chair5,true)
	FreezeEntityPosition(chair6,true)
	FreezeEntityPosition(plant4,true)
	FreezeEntityPosition(storage2,true)
	FreezeEntityPosition(basket,true)
	FreezeEntityPosition(wardrobe,true)
	FreezeEntityPosition(wardrobe2,true)
	FreezeEntityPosition(table2,true)
	FreezeEntityPosition(lamp3,true)
	FreezeEntityPosition(beddelta,true)
	FreezeEntityPosition(bed,true)
	FreezeEntityPosition(beddecal,true)
	FreezeEntityPosition(tapeplayer,true)
	FreezeEntityPosition(basket7,true)
	FreezeEntityPosition(basket6,true)
	FreezeEntityPosition(basket8,true)
	FreezeEntityPosition(basket9,true)
	FreezeEntityPosition(hairdryer,true)
	FreezeEntityPosition(basketmess,true)
	FreezeEntityPosition(storage,true) 
	FreezeEntityPosition(tissue,true)

	SetEntityHeading(beerbot,GetEntityHeading(beerbot)+90)
	SetEntityHeading(couch,GetEntityHeading(couch)-90)
	SetEntityHeading(chair,GetEntityHeading(chair)+getRotation(0.28045480))
	SetEntityHeading(chair2,GetEntityHeading(chair2)+getRotation(0.3276100))
	SetEntityHeading(fridge,GetEntityHeading(chair2)+160)
	SetEntityHeading(micro,GetEntityHeading(micro)-90)
	SetEntityHeading(sideBoard,GetEntityHeading(sideBoard)+90)
	SetEntityHeading(bed,GetEntityHeading(bed)+90)
	SetEntityHeading(bedSide,GetEntityHeading(bedSide)+180)
	SetEntityHeading(tv,GetEntityHeading(tv)+90)
	SetEntityHeading(plant3,GetEntityHeading(plant3)+90)
	SetEntityHeading(chair3,GetEntityHeading(chair3)+200)
	SetEntityHeading(chair4,GetEntityHeading(chair3)+100)
	SetEntityHeading(chair5,GetEntityHeading(chair5)+135)
	SetEntityHeading(chair6,GetEntityHeading(chair6)+10)
	SetEntityHeading(storage,GetEntityHeading(storage)+180)
	SetEntityHeading(storage2,GetEntityHeading(storage2)-90)
	SetEntityHeading(table2,GetEntityHeading(table2)+90)
	SetEntityHeading(tapeplayer,GetEntityHeading(tapeplayer)+90)
	SetEntityHeading(knifeblock,GetEntityHeading(knifeblock)+180)

	if not isCop then
		local gunluck = math.random(1, 100)
		if gunluck <= Config.NpcHaveGunChance then
			spawnNPC(Config.Houses[id].door, true)
		else
			spawnNPC(Config.Houses[id].door, false)
		end
	end

	DoScreenFadeIn(100)
end

function getRotation(input)
	return 360/(10*input)
end

function deleteSpawnedHouse(id)
	local housePosition = Config.Houses[id].door
	local handle, ObjectFound = FindFirstObject()
	local success
	repeat
		local pos = GetEntityCoords(ObjectFound)
		local distance = GetDistanceBetweenCoords(housePosition.x, housePosition.y, (housePosition.z - 24.0), pos, true)
		if distance < 35.0 and ObjectFound ~= PlayerPedId() then
			if IsEntityAPed(ObjectFound) then
				if not IsPedAPlayer(ObjectFound) then
					DeleteObject(ObjectFound)
				end
			else
				DeleteObject(ObjectFound)
			end
		end
		success, ObjectFound = FindNextObject(handle)
	until not success
	EndFindObject(handle)
end



RegisterNetEvent('ra1derHouseRob:copsBlipC')
AddEventHandler('ra1derHouseRob:copsBlipC', function(coord)
	local transT = 250
	local Blip = AddBlipForCoord(coord.x, coord.y, coord.z)
	SetBlipSprite(Blip,  162)
	SetBlipColour(Blip,  51)
	SetBlipAlpha(Blip,  transT)
	SetBlipScale(Blip, 1.5)
	SetBlipAsShortRange(Blip,  false)
	while transT ~= 0 do
		Wait(4)
		transT = transT - 1
		SetBlipAlpha(Blip,  transT)
		if transT == 0 then
			SetBlipSprite(Blip,  2)
			return
		end
	end
end)

function search(id)
	local pPed = PlayerPedId()
		QBCore.Functions.Progressbar('name', 'Searching', math.random(10000, 18000), false, true, { -- Name | Label | Time | useWhileDead | canCancel
		disableMovement = true,
		disableCarMovement = true,
		disableMouse = false,
		disableCombat = true,
	}, {
		animDict = "missexile3",
		anim = "ex03_dingy_search_case_base_michael",
		flags = 49,
	}, {}, {}, function() -- Play When Done
		robbableItems[id].isSearched = true
			-- for i = 1, math.random(0, 3) do
				local randomitem = math.random(1, #Config.Items)
				if Config.Items[randomitem].chance then
					if Config.Items[randomitem].chance < math.random(1, 100) then
						TriggerServerEvent('ra1derHouseRob:giveItem', Config.Items[randomitem].name, Config.Items[randomitem].count, Config.Items[randomitem].label)
					end
				else
					TriggerServerEvent('ra1derHouseRob:giveItem', Config.Items[randomitem].name, Config.Items[randomitem].count, Config.Items[randomitem].label)
				end
			-- end
	end, function() -- Play When Cancel
		isActive = false
		QBCore.Functions.Notify('You Canceled Searching Agent!')
	end)
end


function drawTxt(x, y, scale, text, red, green, blue, alpha)
	SetTextFont(4)
	SetTextProportional(1)
	SetTextScale(scale, scale)
	SetTextColour(red, green, blue, alpha)
	SetTextDropShadow(0, 0, 0, 0, 255)
	SetTextEdge(1, 0, 0, 0, 255)
	SetTextDropShadow()
	SetTextOutline()
	SetTextEntry("STRING")
	AddTextComponentString(text)
    DrawText(x, y)
end

function spawnNPC(coords, haveweapon)
	local x, y, z = table.unpack(coords)
	local generator = {x = x, y = y, z = z - 20}

	local modelhash = GetHashKey(Config.NpcModel)
	RequestModel(modelhash)

	while not HasModelLoaded(modelhash) do
		Citizen.Wait(0)
	end
	
	robberyped = CreatePed(GetPedType(modelhash), modelhash, generator.x+6.86376900,generator.y+1.20651200,generator.z+1.36589100, 270.0, 0, 0)
	FreezeEntityPosition(robberyped, true)
  	loadAnimDict("dead")
	TaskPlayAnim(robberyped, "dead", 'dead_a', 100.0, 1.0, -1, 1, 0, 0, 0, 0)
	-- if math.random(1, 100) < Config.NpcHaveGunChance then
	-- 	GiveWeaponToPed(robberyped, GetHashKey('WEAPON_PISTOL'), 255, false, false)
	-- end
end

function loadAnimDict(dict)
	RequestAnimDict(dict)
	while not HasAnimDictLoaded(dict) do
	 	Citizen.Wait(5)
	end
end




-- jam minigame
function StartMinigame(rewards)

	local txd = CreateRuntimeTxd("JSCTextureDict")
	for i = 1, 2 do 
		CreateRuntimeTextureFromImage(txd, tostring(i), "LockPart" .. i .. ".PNG") 
	end

	MinigameOpen = true
	SoundID 	  = GetSoundId() 
	Timer 		  = GetGameTimer()

	if not RequestAmbientAudioBank("SAFE_CRACK", false) then 
		RequestAmbientAudioBank("SAFE_CRACK", false)
	end
	if not HasStreamedTextureDictLoaded("JSCTextureDict", false) then 
		RequestStreamedTextureDict("JSCTextureDict", false)
	end

	Citizen.CreateThread(function() 
		Update(rewards) 
	end)	
end

function Update(rewards)
	Citizen.CreateThread(function() 
		HandleMinigame(rewards) 
	end)
	while MinigameOpen do
		InputCheck()  
		if IsEntityDead(GetPlayerPed(PlayerId())) then 
			EndMinigame(false, false) 
		end
		Citizen.Wait(0)
	end
end

function InputCheck()
	local leftKeyPressed 	= IsControlPressed(0, 174) or 0 -- left arrow
	local rightKeyPressed 	= IsControlPressed(0, 175) or 0 -- right arrow
	if IsControlPressed(0, 113) then
		 EndMinigame(false) 
	end
	if IsControlPressed(0, 48) then -- z
		rotSpeed = 0.1 
		modifier = 33
	elseif IsControlPressed(0, 21) then --left shift
		rotSpeed = 1.0
		modifier = 50 
	else
		rotSpeed = 0.4 
		modifier = 90 
	end

    local lockRotation = math.max(modifier / rotSpeed, 0.1)

    if leftKeyPressed ~= 0 or rightKeyPressed ~= 0 then
    	LockRotation = LockRotation - (rotSpeed * tonumber(leftKeyPressed))
    	LockRotation = LockRotation + (rotSpeed * tonumber(rightKeyPressed))
    	if (GetGameTimer() - Timer) > lockRotation then 
    		PlaySoundFrontend(0, "tumbler_turn", "SAFE_CRACK_SOUNDSET", false)
    		Timer = GetGameTimer() 
    	end
    end
end

function HandleMinigame(rewards)

	local lockRot 		 = math.random(385.00, 705.00)	

	local lockNumbers 	 = {}
	local correctGuesses = {}

	lockNumbers[1] = 1
	lockNumbers[2] = math.random(				  45.0, 				359.0)
	lockNumbers[3] = math.random(lockNumbers[2] - 719.0, lockNumbers[2] - 405.0)
	lockNumbers[4] = math.random(lockNumbers[3] + 45.0, lockNumbers[3] + 359.0)

	for i = 1,4 do
	end


	QBCore.Functions.Notify("Paper Came Out From The Bottom Of The Case", "primary", 30000)
	QBCore.Functions.Notify("Once left to 0, then left again " .. (math.floor((lockNumbers[1] % 360) / 3.60)) .. '. Right ' .. (math.floor((lockNumbers[2] % 360) / 3.60)) .. ". Once left to 0, then left again " .. (math.floor((lockNumbers[3] % 360) / 3.60)) .. '. Right ' .. (math.floor((lockNumbers[4] % 360) / 3.60)) .. '.', "primary", 75000)
	Citizen.Wait(10)
	QBCore.Functions.Notify('"LeftShift" You can speed up with the key, "Z" You can slow down with the button. You can turn it off with the "G" key..', 45000)
	

    local correctCount	= 1
    local hasRandomized	= false

    LockRotation = 0.0 + lockRot
								
	while MinigameOpen do	
		DrawSprite("JSCTextureDict", "1",  0.8,  0.5,  0.15,  0.26, -LockRotation, 255, 255, 255, 255)
		DrawSprite("JSCTextureDict", "2",  0.8,  0.5, 0.176, 0.306, -0.0, 255, 255, 255, 255)	

		hasRandomized = true

		local lockVal = math.floor(LockRotation)

		if correctCount > 1 and correctCount < 5 and lockVal + (Config.LockTolerance * 3.60) < lockNumbers[correctCount - 1] and lockNumbers[correctCount - 1] < lockNumbers[correctCount] then 
			EndMinigame(false)
			MinigameOpen = false
		elseif correctCount > 1 and correctCount < 5 and lockVal - (Config.LockTolerance * 3.60) > lockNumbers[correctCount - 1] and lockNumbers[correctCount - 1] > lockNumbers[correctCount] then 
			EndMinigame(false)
			MinigameOpen = false
		elseif correctCount > 4 then
			EndMinigame(true, rewards)
		end

		for k,v in pairs(lockNumbers) do
			  if not hasRandomized then 
				LockRotation = lockRot
			end
			if lockVal == v and correctCount == k then
				local canAdd = true
				for key,val in pairs(correctGuesses) do
					if val == lockVal and key == correctCount then
						canAdd = false
					end
				end

				if canAdd then 				
					PlaySoundFrontend(-1, "tumbler_pin_fall", "SAFE_CRACK_SOUNDSET", true)
					correctGuesses[correctCount] = lockVal
					correctCount = correctCount + 1; 
				end   				  			
			end
		end
		Citizen.Wait(0)
	end
end

function EndMinigame(won, rewards)
	MinigameOpen = false
	if won then
		PlaySoundFrontend(SoundID, "tumbler_pin_fall_final", "SAFE_CRACK_SOUNDSET", true)

		Citizen.Wait(100)
		if math.random(1, 100) > 25 then
			local safeitem = math.random(1, #Config.safeItems)
			TriggerServerEvent('ra1derHouseRob:giveItem', Config.safeItems[safeitem].name, Config.safeItems[safeitem].count, Config.safeItems[safeitem].label)
		end

		PlaySoundFrontend(SoundID, "safe_door_open", "SAFE_CRACK_SOUNDSET", true)
		QBCore.Functions.Notify("Case Opened")
	else	
		PlaySoundFrontend(SoundID, "tumbler_reset", "SAFE_CRACK_SOUNDSET", true)
		QBCore.Functions.Notify("You couldn't open the safe! The house system sent a notification to the police!")
		notifyCops()
	end
	lockFinished(rewards)--
end

function notifyCops()  
    local ped = PlayerPedId()
    local playerPos = GetEntityCoords(ped)
    local id = math.random(25, 99)
    
    data = {
        id = id,
        code = 10-30,
        description = "Home Robbery",
        location = GetTheStreet(),
        coords = playerPos,
        sprite = 411
    }   
    TriggerServerEvent("jtDispatch:add-notification", data, "police")
end

function GetTheStreet()
	local ZoneNames = exports["jtDispatch"]:bolgeler()
    local x, y, z = table.unpack(GetEntityCoords(GetPlayerPed(-1), true))
    local currentStreetHash, intersectStreetHash = GetStreetNameAtCoord(x, y, z, currentStreetHash, intersectStreetHash)
    currentStreetName = GetStreetNameFromHashKey(currentStreetHash)
    intersectStreetName = GetStreetNameFromHashKey(intersectStreetHash)
    zone = tostring(GetNameOfZone(x, y, z))
    playerStreetsLocation = ZoneNames[tostring(zone)]

    if not zone then
        zone = "UNKNOWN"
        ZoneNames['UNKNOWN'] = zone
    elseif not ZoneNames[tostring(zone)] then
        local undefinedZone = zone .. " " .. x .. " " .. y .. " " .. z
        ZoneNames[tostring(zone)] = "Unknown Region"
    end

    if (intersectStreetName ~= nil and intersectStreetName ~= "") or (currentStreetName ~= nil and currentStreetName ~= "") then
        playerStreetsLocation = currentStreetName
    else
        playerStreetsLocation = ZoneNames[tostring(zone)]
    end

	return playerStreetsLocation
end

function GetStreetAndZone()
    local playerPed = PlayerPedId()
    local coords = GetEntityCoords(playerPed)
    local currentStreetHash, intersectStreetHash = GetStreetNameAtCoord(coords.x, coords.y, coords.z)
    local currentStreetName = GetStreetNameFromHashKey(currentStreetHash)
    local area = GetLabelText(tostring(GetNameOfZone(coords.x, coords.y, coords.z)))
    local playerStreetsLocation = area
    if not zone then zone = "UNKNOWN" end
    if currentStreetName ~= nil and currentStreetName ~= "" then playerStreetsLocation = currentStreetName .. ", " ..area
    else playerStreetsLocation = area end
    return playerStreetsLocation
end