-- local secure, QBCore = false, nil

-- Citizen.CreateThread(function()
-- 	while QBCore == nil do
-- 		TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)
-- 		Citizen.Wait(0)
-- 	end
-- end)

-- RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
-- AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
--     QBCore.Functions.TriggerCallback('tgiann:check:secure', function(status)
--         secure = status
--     end)
-- end)

-- RegisterNetEvent('tgiann:secure:client:setSecureStatus')
-- AddEventHandler('tgiann:secure:client:setSecureStatus', function(status)
--     secure = status
-- end)

-- -- if not exports['elixir-base]:GetSecureStatus() then
-- function GetSecureStatus(toggleNotif)
--     if secure then
--         if toggleNotif ~= false then
--             QBCore.Functions.Notify("Güvenlik sistemleri devrede.", "error")
--         end
--     end
--     return secure
-- end

-- RegisterCommand("securetest", function()
--     if not exports['elixir-base']:GetSecureStatus() then
--         QBCore.Functions.Notify("Marketi Başarıyla Soydun", "success")
--     else
--         QBCore.Functions.Notify("Güvenlik Sistemleri Devrede", "error")
--     end 
-- end)

local secure, QBCore = false, nil

Citizen.CreateThread(function()
	while QBCore == nil do
		TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)
		Citizen.Wait(0)
	end
end)

RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    QBCore.Functions.TriggerCallback('tqcore:check:secure', function(status)
        secure = status
    end)
end)

RegisterNetEvent('tqcore:secure:client:setSecureStatus')
AddEventHandler('tqcore:secure:client:setSecureStatus', function(status)
    secure = status
end)

function GetSecureStatus(toggleNotif)
    if secure then
        if toggleNotif ~= false then
            QBCore.Functions.Notify("Security systems are on.", "error", 3000)
        end
    end
    return secure
end

local FireRateTypes = {
	{ label = "Single Shot", name = "SINGLE_FIRE", delay = 30 },
	{ label = "Semi automatic", name = "BURST_FIRE", delay = 400 },
	{ label = "Fully Automatic", name = "FULL_AUTO_FIRE", delay = 1 }
}

local AllowedModes = {
	-- MPX (PD Issued)
	["736523883"] = {
		["SINGLE_FIRE"] = true,
		["BURST_FIRE"] = true,
		["FULL_AUTO_FIRE"] = true
	},

	-- PD M4
	["1192676223"] = {
		["SINGLE_FIRE"] = true,
		["BURST_FIRE"] = true,
		["FULL_AUTO_FIRE"] = true
	},

	["-1719357158"] = {
		["SINGLE_FIRE"] = true,
		["BURST_FIRE"] = false,
		["FULL_AUTO_FIRE"] = false
	},

	-- AK47
	["-1074790547"] = {
		["SINGLE_FIRE"] = true,
		["BURST_FIRE"] = true,
		["FULL_AUTO_FIRE"] = true
	},

	-- M70
	["497969164"] = {
		["SINGLE_FIRE"] = false,
		["BURST_FIRE"] = false,
		["FULL_AUTO_FIRE"] = true
	},

	-- Groza
	["-1357824103"] = {
		["SINGLE_FIRE"] = true,
		["BURST_FIRE"] = false,
		["FULL_AUTO_FIRE"] = true
	},

	["-1768145561"] = {
		["SINGLE_FIRE"] = true,
		["BURST_FIRE"] = true,
		["FULL_AUTO_FIRE"] = true
	},

	-- Airsoft
	["-2084633992"] = {
		["SINGLE_FIRE"] = true,
		["BURST_FIRE"] = true,
		["FULL_AUTO_FIRE"] = true
	},
}

local ForceWeaponMode = {
	["-1719357158"] = 1 -- PD M14
}

local running = false
local PREVIOUS_WEAPON_MODES = {}
local SELECTED_FIRE_RATE = 3

Citizen.CreateThread(function()

    -- Register Keybinds
    RegisterKeyMapping('+switchWeaponMode', '(Weapon) Changes the shooting mode.', 'keyboard', '')
    RegisterCommand("+switchWeaponMode", SwitchWeaponMode, false)
    RegisterCommand("-switchWeaponMode", function() end, false) 
end)


local function runWeaponLoop()
  running = true
  Citizen.CreateThread(function()
      while running do
		if IsDisabledControlPressed(0, 24) then
			Wait(FireRateTypes[SELECTED_FIRE_RATE].delay)
			if FireRateTypes[SELECTED_FIRE_RATE].name ~= "FULL_AUTO_FIRE" then
				while IsDisabledControlPressed(0, 24) do
					DisablePlayerFiring(PlayerPedId(), true)
					Wait(0)
				end
			end
		end
		Wait(0)
      end
  end)
end

function SwitchWeaponMode()
	local pWeaponHash = tostring(GetSelectedPedWeapon(PlayerPedId()))
	if IsPedArmed(playerPed, 4) == 1 then
		if AllowedModes[pWeaponHash] == nil then
			SELECTED_FIRE_RATE = 3
			QBCore.Functions.Notify("The weapon has no other mods.", "error", 3000)
			-- TriggerEvent("DoLongHudText", "You have no modes to cycle through", 2)
			return
		end

		-- Does this weapon only allow a single mode and forced?
		if ForceWeaponMode[pWeaponHash] ~= nil then
			if SELECTED_FIRE_RATE == ForceWeaponMode[pWeaponHash] then
			else
				SELECTED_FIRE_RATE = ForceWeaponMode[pWeaponHash]
				TriggerEvent("setArmed", 33.3 * SELECTED_FIRE_RATE)
			end
			return
		end

		local newSelected = FindWeaponModeAfterIndex(SELECTED_FIRE_RATE, pWeaponHash)

		SELECTED_FIRE_RATE = newSelected
		PREVIOUS_WEAPON_MODES[pWeaponHash] = SELECTED_FIRE_RATE
		local selectedRate = FireRateTypes[SELECTED_FIRE_RATE]

		QBCore.Functions.Notify("Updated weapon mod to " ..selectedRate.label.."" , nil, 3000)

		TriggerEvent("setArmed", 33.3 * SELECTED_FIRE_RATE)
	-- else
		-- QBCore.Functions.Notify("Silahın Yok",3000)
	end
end

function FindWeaponModeAfterIndex(pIndex, pWeaponHash)
	pIndex = pIndex + 1

	-- We are at the end of weapon modes list so reset it
	if (pIndex > #FireRateTypes) then
		pIndex = 1	
	end

	if (AllowedModes[pWeaponHash] ~= nil and AllowedModes[pWeaponHash][FireRateTypes[pIndex].name] ~= nil and not AllowedModes[pWeaponHash][FireRateTypes[pIndex].name]) then
		return FindWeaponModeAfterIndex(pIndex, pWeaponHash)
	end

	return pIndex;
end

RegisterNetEvent("np-weapons:client:weaponEquiped")
AddEventHandler("np-weapons:client:weaponEquiped", function(pWeaponHash, pArmed)
	pWeaponHash = tostring(pWeaponHash)
	if ForceWeaponMode[pWeaponHash] ~= nil then
		SELECTED_FIRE_RATE = ForceWeaponMode[pWeaponHash]
		TriggerEvent("setArmed", 33.3 * SELECTED_FIRE_RATE)
	end

	if PREVIOUS_WEAPON_MODES[pWeaponHash] ~= nil then
		SELECTED_FIRE_RATE = PREVIOUS_WEAPON_MODES[pWeaponHash]
	else

		-- Does this weapon have an auto mode? if so set that default
		if AllowedModes[pWeaponHash] ~= nil and AllowedModes[pWeaponHash]["FULL_AUTO_FIRE"] then
			SELECTED_FIRE_RATE = 3
		else
			-- Will set to the first available mode if we didn't previously have a selected mode
			SELECTED_FIRE_RATE = FindWeaponModeAfterIndex(0, pWeaponHash)
		end
	end

	-- If we dont have modes we can cycle always make full auto by default
	if AllowedModes[pWeaponHash] == nil then
		SELECTED_FIRE_RATE = 3
	end

	running = pArmed
	if pArmed and AllowedModes[pWeaponHash] ~= nil then
		runWeaponLoop()
		TriggerEvent("setArmed", 33.3 * SELECTED_FIRE_RATE)
	else
		TriggerEvent("setArmed", 31)
	end
end)

AddEventHandler('tgiann:playerdead', function(dead) 
    isDead = dead

	if isDead == true then
		TriggerEvent("np-weapons:client:weaponEquiped", nil, false)
	end
end)

function checkCD()
    QBCore.Functions.TriggerCallback('tgiann-cd:getPlayerCD', function(cd)
        if GetGameTimer() >= cd then
            return true
        end
    end)

	Citizen.Wait(20)
    return false
end exports('checkCD', checkCD)

function setCD(s)
    TriggerServerEvent("tgiann-cd:setPlayerCD", GetGameTimer(), s)
end exports('setCD', setCD)