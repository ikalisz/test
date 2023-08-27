local isDead = false

local weapons = {
	'WEAPON_KNIFE',
	'WEAPON_NIGHTSTICK',
	'WEAPON_BREAD',
	'WEAPON_FLASHLIGHT',
	'WEAPON_HAMMER',
	'WEAPON_BAT',
	'WEAPON_GOLFCLUB',
	'WEAPON_CROWBAR',
	'WEAPON_BOTTLE',
	'WEAPON_DAGGER',
	'WEAPON_HATCHET',
	'WEAPON_MACHETE',
	'WEAPON_SWITCHBLADE',
	'WEAPON_BATTLEAXE',
	'WEAPON_POOLCUE',
	'WEAPON_WRENCH',
	'WEAPON_PISTOL',
	'WEAPON_PISTOL_MK2',
	'WEAPON_COMBATPISTOL',
	'WEAPON_APPISTOL',
	'WEAPON_PISTOL50',
	'WEAPON_REVOLVER',
	'WEAPON_SNSPISTOL',
	'WEAPON_HEAVYPISTOL',
	'WEAPON_VINTAGEPISTOL',
	'WEAPON_MICROSMG',
	'WEAPON_SMG',
	'WEAPON_SMG_MK2',
	'WEAPON_ASSAULTSMG',
	'WEAPON_MINISMG',
	'WEAPON_MACHINEPISTOL',
	'WEAPON_COMBATPDW',
	'WEAPON_PUMPSHOTGUN',
	'WEAPON_SAWNOFFSHOTGUN',
	'WEAPON_ASSAULTSHOTGUN',
	'WEAPON_BULLPUPSHOTGUN',
	'WEAPON_HEAVYSHOTGUN',
	'WEAPON_ASSAULTRIFLE',
	'WEAPON_ASSAULTRIFLE_MK2',
	'WEAPON_CARBINERIFLE',
	'WEAPON_CARBINERIFLE_MK2',
	'WEAPON_ADVANCEDRIFLE',
	'WEAPON_SPECIALCARBINE',
	'WEAPON_SPECIALCARBINE_MK2',
	'WEAPON_BULLPUPRIFLE',
	'WEAPON_COMPACTRIFLE',
	'WEAPON_MG',
	'WEAPON_COMBATMG',
	'WEAPON_GUSENBERG',
	'WEAPON_SNIPERRIFLE',
	'WEAPON_HEAVYSNIPER',
	'WEAPON_MARKSMANRIFLE',
	'WEAPON_GRENADELAUNCHER',
	'WEAPON_RPG',
	'WEAPON_STINGER',
	'WEAPON_MINIGUN',
	'WEAPON_GRENADE',
	'WEAPON_STICKYBOMB',
	'WEAPON_SMOKEGRENADE',
	'WEAPON_BZGAS',
	'WEAPON_MOLOTOV',
	'WEAPON_DIGISCANNER',
	'WEAPON_FIREWORK',
	'WEAPON_MUSKET',
	'WEAPON_STUNGUN',
	'WEAPON_HOMINGLAUNCHER',
	'WEAPON_PROXMINE',
	'WEAPON_FLAREGUN',
	'WEAPON_MARKSMANPISTOL',
	'WEAPON_RAILGUN',
	'WEAPON_DBSHOTGUN',
	'WEAPON_AUTOSHOTGUN',
	'WEAPON_COMPACTLAUNCHER',
	'WEAPON_PIPEBOMB',
	'WEAPON_DOUBLEACTION',
	'WEAPON_GLOCK',
	'WEAPON_M14',
}

-- Wheapons that require the Police holster animation
local holsterableWeapons = {
	--'WEAPON_STUNGUN',
	'WEAPON_GLOCK',
}

local holstered = true
local canFire = true
local currWeapon = `WEAPON_UNARMED`
local currentHoldster = nil

AddEventHandler('elixir-base:playerdead', function(dead)
	isDead = dead
end)

Citizen.CreateThread(function()
	while true do
		if DoesEntityExist(playerPed) and not isDead then
			if currWeapon ~= GetSelectedPedWeapon(playerPed) then
				local rot = GetEntityHeading(playerPed)
				local newWeap = GetSelectedPedWeapon(playerPed)
				SetCurrentPedWeapon(playerPed, currWeapon, true)
				loadAnimDict("reaction@intimidation@1h")
				loadAnimDict("reaction@intimidation@cop@unarmed")
				loadAnimDict("rcmjosh4")
				loadAnimDict("weapons@pistol@")
				if CheckWeapon(newWeap) then
					if holstered then
						if PlayerData.job and PlayerData.job.name == "police" then
							TaskPlayAnim(ped, "rcmjosh4", "josh_leadout_cop2", 8.0, 2.0, -1, 48, 10, 0, 0, 0 )
							canFire = false
							currentHoldster = GetPedDrawableVariation(PlayerPedId(), 7)
							TaskPlayAnim(playerPed, "rcmjosh4", "josh_leadout_cop2", 3.0, 3.0, -1, 50, 0, 0, 0)
							Citizen.Wait(300)
							SetCurrentPedWeapon(playerPed, newWeap, true)

							if IsWeaponHolsterable(newWeap) then
								if currentHoldster == 8 then
									SetPedComponentVariation(PlayerPedId(), 7, 2, 0, 2)
								elseif currentHoldster == 1 then
									SetPedComponentVariation(PlayerPedId(), 7, 3, 0, 2)
								elseif currentHoldster == 6 then
									SetPedComponentVariation(PlayerPedId(), 7, 5, 0, 2)
								end
							end 
							currWeapon = newWeap
							Citizen.Wait(300)
							ClearPedTasks(playerPed)
							holstered = false
							canFire = true
						else
							canFire = false
							TaskPlayAnim(playerPed, "reaction@intimidation@1h", "intro", 8.0, 3.0, -1, 50, 0, 0, 0)
							Citizen.Wait(1000)
							SetCurrentPedWeapon(playerPed, newWeap, true)
							currWeapon = newWeap
							Citizen.Wait(1400)
							ClearPedTasks(playerPed)
							holstered = false
							canFire = true
						end
					elseif newWeap ~= currWeapon and CheckWeapon(currWeapon) then
						if PlayerData.job and PlayerData.job.name == "police" then
							canFire = false

							TaskPlayAnim(playerPed, "reaction@intimidation@cop@unarmed", "intro", 3.0, 3.0, -1, 50, 0, 0, 0)
							Citizen.Wait(500)

							if IsWeaponHolsterable(currWeapon) then
								SetPedComponentVariation(PlayerPedId(), 7, currentHoldster, 0, 2)
							end 

							SetCurrentPedWeapon(playerPed, `WEAPON_UNARMED`, true)
							currentHoldster = GetPedDrawableVariation(PlayerPedId(), 7)

							TaskPlayAnim(playerPed, "rcmjosh4", "josh_leadout_cop2", 3.0, 3.0, -1, 50, 0, 0, 0)
							Citizen.Wait(300)
							SetCurrentPedWeapon(playerPed, newWeap, true)

							if IsWeaponHolsterable(newWeap) then
								if currentHoldster == 8 then
									SetPedComponentVariation(PlayerPedId(), 7, 2, 0, 2)
								elseif currentHoldster == 1 then
									SetPedComponentVariation(PlayerPedId(), 7, 3, 0, 2)
								elseif currentHoldster == 6 then
									SetPedComponentVariation(PlayerPedId(), 7, 5, 0, 2)
								end
							end 

							Citizen.Wait(500)
							currWeapon = newWeap
							ClearPedTasks(playerPed)
							holstered = false
							canFire = true
						else
							canFire = false
							TaskPlayAnim(playerPed, "reaction@intimidation@1h", "outro", 8.0, 3.0, -1, 50, 0, 0, 0)
							Citizen.Wait(1600)
							SetCurrentPedWeapon(playerPed, `WEAPON_UNARMED`, true)
							TaskPlayAnim(playerPed, "reaction@intimidation@1h", "intro", 8.0, 3.0, -1, 50, 0, 0, 0)
							Citizen.Wait(1000)
							SetCurrentPedWeapon(playerPed, newWeap, true)
							currWeapon = newWeap
							Citizen.Wait(1400)
							ClearPedTasks(playerPed)
							holstered = false
							canFire = true
						end
					else
						if PlayerData.job and PlayerData.job.name == "police" then
							SetCurrentPedWeapon(playerPed, `WEAPON_UNARMED`, true)
							currentHoldster = GetPedDrawableVariation(PlayerPedId(), 7)
							TaskPlayAnim(playerPed, "rcmjosh4", "josh_leadout_cop2", 3.0, 3.0, -1, 50, 0, 0, 0)
							Citizen.Wait(300)
							SetCurrentPedWeapon(playerPed, newWeap, true)

							 if IsWeaponHolsterable(newWeap) then
								if currentHoldster == 8 then
									SetPedComponentVariation(PlayerPedId(), 7, 2, 0, 2)
								elseif currentHoldster == 1 then
									SetPedComponentVariation(PlayerPedId(), 7, 3, 0, 2)
								elseif currentHoldster == 6 then
									SetPedComponentVariation(PlayerPedId(), 7, 5, 0, 2)
								end
							end 

							currWeapon = newWeap
							Citizen.Wait(300)
							ClearPedTasks(playerPed)
							holstered = false
							canFire = true
						else
							SetCurrentPedWeapon(playerPed, `WEAPON_UNARMED`, true)
							TaskPlayAnim(playerPed, "reaction@intimidation@1h", "intro", 8.0, 3.0, -1, 50, 0, 0, 0)
							Citizen.Wait(1000)
							SetCurrentPedWeapon(playerPed, newWeap, true)
							currWeapon = newWeap
							Citizen.Wait(1400)
							ClearPedTasks(playerPed)
							holstered = false
							canFire = true
						end
					end
				else
					if not holstered and CheckWeapon(currWeapon) then
						if PlayerData.job and PlayerData.job.name == "police" then
							canFire = false
							TaskPlayAnim(playerPed, "reaction@intimidation@cop@unarmed", "intro", 3.0, 3.0, -1, 50, 0, 0, 0)
							Citizen.Wait(500)
							
							 if IsWeaponHolsterable(currWeapon) then
								SetPedComponentVariation(PlayerPedId(), 7, currentHoldster, 0, 2)
							end 

							SetCurrentPedWeapon(playerPed, `WEAPON_UNARMED`, true)
							ClearPedTasks(playerPed)
							SetCurrentPedWeapon(playerPed, newWeap, true)
							holstered = true
							canFire = true
							currWeapon = newWeap
						else
							canFire = false
							TaskPlayAnim(playerPed, "reaction@intimidation@1h", "outro", 8.0, 3.0, -1, 50, 0, 0, 0)
							Citizen.Wait(1400)
							SetCurrentPedWeapon(playerPed, `WEAPON_UNARMED`, true)
							ClearPedTasks(playerPed)
							SetCurrentPedWeapon(playerPed, newWeap, true)
							holstered = true
							canFire = true
							currWeapon = newWeap
						end
					else
						SetCurrentPedWeapon(playerPed, newWeap, true)
						holstered = false
						canFire = true
						currWeapon = newWeap
					end
				end
			end
		else
			Citizen.Wait(250)
		end

		Citizen.Wait(5)
	end
end)

Citizen.CreateThread(function()
	while true do
		if not canFire then
			DisableControlAction(0, 25, true)
			DisablePlayerFiring(PlayerPedId(), true)
		else
			Citizen.Wait(250)
		end

		Citizen.Wait(3)
	end
end)

function CheckWeapon(newWeap)
	for i = 1, #weapons do
		if GetHashKey(weapons[i]) == newWeap then
			return true
		end
	end
	return false
end

function IsWeaponHolsterable(weap)
	for i = 1, #holsterableWeapons do
		if GetHashKey(holsterableWeapons[i]) == weap then
			return true
		end
	end
	return false
end

function loadAnimDict(dict)
	while (not HasAnimDictLoaded(dict)) do
		RequestAnimDict(dict)
		Citizen.Wait(5)
	end
end