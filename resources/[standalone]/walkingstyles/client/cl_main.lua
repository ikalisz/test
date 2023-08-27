local QBCore = exports['qb-core']:GetCoreObject()
local PlayerData = {}
local currentWalk = 'default'

-- Set Walk Style (Send to Server & Set Metadata) --
local function WalkStyle(walk)
	local ped = PlayerPedId()
	if walk == 'default' then
		ResetPedMovementClipset(ped)
		ResetPedWeaponMovementClipset(ped)
		ResetPedStrafeClipset(ped)
	else
		RequestAnimSet(walk)
		while not HasAnimSetLoaded(walk) do Wait(0) end
		SetPedMovementClipset(ped, walk)
		ResetPedWeaponMovementClipset(ped)
		ResetPedStrafeClipset(ped)
	end
    TriggerServerEvent('xt-walkstyles:server:SetWalkStyle', walk)
end

-- Reset Walking Style --
local function GetWalkStyle()
    TriggerServerEvent('xt-walkstyles:server:GetWalkStyle')
end
exports('GetWalkStyle', GetWalkStyle)

-- Set Walk Style --
RegisterNetEvent('xt-walkstyles:client:SetWalkStyle', function(walk)
    currentWalk = walk
	WalkStyle(walk)
end)

-- Menu Command --
RegisterNetEvent("yuruyus", function()
    TriggerEvent('xt-walkstyles:client:Menu')
end)


-- Constantly Reset Walk Style --
-- CreateThread(function()
--     while true do
--         Wait(1000)
--         local walking = GetPedMovementClipset(PlayerPedId())
--         if (walking ~= joaat(currentWalk) and walking ~= joaat('move_lester_caneup') and walking ~= joaat('move_ped_crouched')) or currentWalk == "default" then -- Gets integer value of currentWalk, compares it to current clipset
--             GetWalkStyle()
--         end
--     end
-- end)

-- Player Shit --
RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function(playerData)
	PlayerData = QBCore.Functions.GetPlayerData()
    Wait(500)
	GetWalkStyle()-- Get Walking Style on Player Load
end)