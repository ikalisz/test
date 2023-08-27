QBCore = nil
Citizen.CreateThread(function() 
    while true do
        Citizen.Wait(10)
        if QBCore == nil then
            TriggerEvent("QBCore:GetObject", function(obj) QBCore = obj end)    
            Citizen.Wait(200)
        end
    end
end)

local weapons = {
	[-1569615261] = 'weapon_unarmed',
	[-1716189206] = 'weapon_knife',
	[1737195953] = 'weapon_nightstick',
	[1317494643] = 'weapon_hammer',
	[-1786099057] = 'weapon_bat',
	[-2067956739] = 'weapon_crowbar',
	[GetHashKey("weapon_glock")] = "weapon_glock",
	[GetHashKey("weapon_ltl")] = "weapon_ltl",
	[GetHashKey("weapon_m4")] = "weapon_m4",
	[1141786504] = 'weapon_golfclub',
	[-102323637] = 'weapon_bottle',
	[-1834847097] = 'weapon_dagger',
	[-102973651] = 'weapon_hatchet',
	[940833800] = 'weapon_stone_hatchet',
	[-656458692] = 'weapon_knuckle',
	[-581044007] = 'weapon_machete',
	[-1951375401] = 'weapon_flashlight',
	[-538741184] = 'weapon_switchblade',
	[-1810795771] = 'weapon_poolcue',
	[419712736] = 'weapon_wrench',
	[-853065399] = 'weapon_battleaxe',
	[453432689] = 'weapon_pistol',
	[-1075685676] = 'weapon_pistol_mk2',
	[1593441988] = 'weapon_combatpistol',
	[-1716589765] = 'weapon_pistol50',
	[-1076751822] = 'weapon_snspistol',
	[-2009644972] = 'weapon_snspistol_mk2',
	[-771403250] = 'weapon_heavypistol',
	[137902532] = 'weapon_vintagepistol',
	[-598887786] = 'weapon_marksmanpistol',
	[-1045183535] = 'weapon_revolver',
	[-879347409] = 'weapon_revolver_mk2',
	[-1746263880] = 'weapon_doubleaction',
	[584646201] = 'weapon_appistol',
	[911657153] = 'weapon_stungun',
	[1198879012] = 'weapon_flaregun',
	[324215364] = 'weapon_microsmg',
	[-619010992] = 'weapon_machinepistol',
	[736523883] = 'weapon_smg',
	[2024373456] = 'weapon_smg_mk2',
	[-270015777] = 'weapon_assaultsmg',
	[171789620] = 'weapon_combatpdw',
	[-1660422300] = 'weapon_mg',
	[2144741730] = 'weapon_combatmg',
	[-608341376] = 'weapon_combatmg_mk2',
	[1627465347] = 'weapon_gusenberg',
	[-1121678507] = 'weapon_minismg',
	[-1074790547] = 'weapon_assaultrifle',
	[961495388] = 'weapon_assaultrifle_mk2',
	[-2084633992] = 'weapon_carbinerifle',
	[-86904375] = 'weapon_carbinerifle_mk2',
	[-1357824103] = 'weapon_advancedrifle',
	[-1063057011] = 'weapon_specialcarbine',
	[-1768145561] = 'weapon_specialcarbine_mk2',
	[2132975508] = 'weapon_bullpuprifle',
	[-2066285827] = 'weapon_bullpuprifle_mk2',
	[1649403952] = 'weapon_compactrifle',
	[100416529] = 'weapon_sniperrifle',
	[205991906] = 'weapon_heavysniper',
	[177293209] = 'weapon_heavysniper_mk2',
	[-952879014] = 'weapon_marksmanrifle',
	[1785463520] = 'weapon_marksmanrifle_mk2',
	[487013001] = 'weapon_pumpshotgun',
	[1432025498] = 'weapon_pumpshotgun_mk2',
	[2017895192] = 'weapon_sawnoffshotgun',
	[-1654528753] = 'weapon_bullpupshotgun',
	[-494615257] = 'weapon_assaultshotgun',
	[-1466123874] = 'weapon_musket',
	[984333226] = 'weapon_heavyshotgun',
	[-275439685] = 'weapon_dbshotgun',
	[317205821] = 'weapon_autoshotgun',
	[-1568386805] = 'weapon_grenadelauncher',
	[-1312131151] = 'weapon_rpg',
	[1119849093] = 'weapon_minigun',
	[2138347493] = 'weapon_firework',
	[1834241177] = 'weapon_railgun',
	[1672152130] = 'weapon_hominglauncher',
	[1305664598] = 'weapon_grenadelauncher_smoke',
	[125959754] = 'weapon_compactlauncher',
	[-1813897027] = 'weapon_grenade',
	[741814745] = 'weapon_stickybomb',
	[-1420407917] = 'weapon_proxmine',
	[-1600701090] = 'weapon_bzgas',
	[615608432] = 'weapon_molotov',
	[101631238] = 'weapon_fireextinguisher',
	[883325847] = 'weapon_petrolcan',
	[-544306709] = 'weapon_petrolcan',
	[1233104067] = 'weapon_flare',
	[600439132] = 'weapon_ball',
	[126349499] = 'weapon_snowball',
	[-37975472] = 'weapon_smokegrenade',
	[-1169823560] = 'weapon_pipebomb',
	[-72657034] = 'weapon_parachute',
	[-1238556825] = 'weapon_rayminigun',
	[-1355376991] = 'weapon_raypistol',
	[1198256469] = 'weapon_raycarbine',
}


RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
end)



local ab = false
Citizen.CreateThread(function()
    while true do
		local killed = GetPlayerPed(PlayerId())
		local killedCoords = GetEntityCoords(killed)
		if IsEntityDead(killed) and not ab then
            local killer = GetPedKiller(killed)
            if killer ~= 0 then
                if killer == killed then
					TriggerServerEvent('DiscordBot:playerDied', false, false, killedCoords, "Suicide")
				else
					local KillerNetwork = NetworkGetPlayerIndexFromPed(killer)
					if KillerNetwork == "**Invalid**" or KillerNetwork == -1 then
						TriggerServerEvent('DiscordBot:playerDied', false, false, killedCoords, "Unknown")
					else
						DeathCauseHash = GetPedCauseOfDeath(killed)
						DeathReason =  hashToWeapon(DeathCauseHash)
						
						TriggerServerEvent('DiscordBot:playerDied', GetPlayerServerId(KillerNetwork), DeathReason, killedCoords)
					end
                end
            else
				TriggerServerEvent('DiscordBot:playerDied', false, false, killedCoords, "Died or Suicide from Falling from Height")
            end
            ab = true
        end
		if not IsEntityDead(killed) then
			ab = false
		end
        Citizen.Wait(0)
    end
end)


function IsMelee(Weapon)
	local Weapons = {'WEAPON_UNARMED', 'WEAPON_CROWBAR', 'WEAPON_BAT', 'WEAPON_GOLFCLUB', 'WEAPON_HAMMER', 'WEAPON_NIGHTSTICK'}
	for i, CurrentWeapon in ipairs(Weapons) do
		if GetHashKey(CurrentWeapon) == Weapon then
			return true
		end
	end
	return false
end

function IsTorch(Weapon)
	local Weapons = {'WEAPON_MOLOTOV'}
	for i, CurrentWeapon in ipairs(Weapons) do
		if GetHashKey(CurrentWeapon) == Weapon then
			return true
		end
	end
	return false
end

function IsKnife(Weapon)
	local Weapons = {'WEAPON_DAGGER', 'WEAPON_KNIFE', 'WEAPON_SWITCHBLADE', 'WEAPON_HATCHET', 'WEAPON_BOTTLE'}
	for i, CurrentWeapon in ipairs(Weapons) do
		if GetHashKey(CurrentWeapon) == Weapon then
			return true
		end
	end
	return false
end

function IsPistol(Weapon)
	local Weapons = {'WEAPON_SNSPISTOL', 'WEAPON_HEAVYPISTOL', 'WEAPON_VINTAGEPISTOL', 'WEAPON_PISTOL', 'WEAPON_APPISTOL', 'WEAPON_COMBATPISTOL', "weapon_glock"}
	for i, CurrentWeapon in ipairs(Weapons) do
		if GetHashKey(CurrentWeapon) == Weapon then
			return true
		end
	end
	return false
end

function IsSub(Weapon)
	local Weapons = {'WEAPON_MICROSMG', 'WEAPON_SMG'}
	for i, CurrentWeapon in ipairs(Weapons) do
		if GetHashKey(CurrentWeapon) == Weapon then
			return true
		end
	end
	return false
end

function IsRifle(Weapon)
	local Weapons = {'WEAPON_CARBINERIFLE', 'WEAPON_MUSKET', 'WEAPON_ADVANCEDRIFLE', 'WEAPON_ASSAULTRIFLE', 'WEAPON_SPECIALCARBINE', 'WEAPON_COMPACTRIFLE', 'WEAPON_BULLPUPRIFLE', "weapon_specialcarbine_mk2", "weapon_m4"}
	for i, CurrentWeapon in ipairs(Weapons) do
		if GetHashKey(CurrentWeapon) == Weapon then
			return true
		end
	end
	return false
end

function IsLight(Weapon)
	local Weapons = {'WEAPON_MG', 'WEAPON_COMBATMG'}
	for i, CurrentWeapon in ipairs(Weapons) do
		if GetHashKey(CurrentWeapon) == Weapon then
			return true
		end
	end
	return false
end

function IsShotgun(Weapon)
	local Weapons = {'WEAPON_BULLPUPSHOTGUN', 'WEAPON_ASSAULTSHOTGUN', 'WEAPON_DBSHOTGUN', 'WEAPON_PUMPSHOTGUN', 'WEAPON_HEAVYSHOTGUN', 'WEAPON_SAWNOFFSHOTGUN'}
	for i, CurrentWeapon in ipairs(Weapons) do
		if GetHashKey(CurrentWeapon) == Weapon then
			return true
		end
	end
	return false
end

function IsSniper(Weapon)
	local Weapons = {'WEAPON_MARKSMANRIFLE', 'WEAPON_SNIPERRIFLE', 'WEAPON_HEAVYSNIPER', 'WEAPON_ASSAULTSNIPER', 'WEAPON_REMOTESNIPER'}
	for i, CurrentWeapon in ipairs(Weapons) do
		if GetHashKey(CurrentWeapon) == Weapon then
			return true
		end
	end
	return false
end

function IsHeavy(Weapon)
	local Weapons = {'WEAPON_GRENADELAUNCHER', 'WEAPON_RPG', 'WEAPON_FLAREGUN', 'WEAPON_HOMINGLAUNCHER', 'WEAPON_FIREWORK', 'VEHICLE_WEAPON_TANK'}
	for i, CurrentWeapon in ipairs(Weapons) do
		if GetHashKey(CurrentWeapon) == Weapon then
			return true
		end
	end
	return false
end

function IsMinigun(Weapon)
	local Weapons = {'WEAPON_MINIGUN'}
	for i, CurrentWeapon in ipairs(Weapons) do
		if GetHashKey(CurrentWeapon) == Weapon then
			return true
		end
	end
	return false
end

function IsBomb(Weapon)
	local Weapons = {'WEAPON_GRENADE', 'WEAPON_PROXMINE', 'WEAPON_EXPLOSION', 'WEAPON_STICKYBOMB'}
	for i, CurrentWeapon in ipairs(Weapons) do
		if GetHashKey(CurrentWeapon) == Weapon then
			return true
		end
	end
	return false
end

function IsVeh(Weapon)
	local Weapons = {'VEHICLE_WEAPON_ROTORS'}
	for i, CurrentWeapon in ipairs(Weapons) do
		if GetHashKey(CurrentWeapon) == Weapon then
			return true
		end
	end
	return false
end

function IsVK(Weapon)
	local Weapons = {'WEAPON_RUN_OVER_BY_CAR', 'WEAPON_RAMMED_BY_CAR'}
	for i, CurrentWeapon in ipairs(Weapons) do
		if GetHashKey(CurrentWeapon) == Weapon then
			return true
		end
	end
	return false
end

function hashToWeapon(hash)
	if weapons[hash] ~= nil then
		return weapons[hash]
	else
		return 'weapon_unarmed'
	end
end
