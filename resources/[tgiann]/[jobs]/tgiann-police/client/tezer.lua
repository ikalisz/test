-- Teazer
local isTaz = false

Citizen.CreateThread(function()
	while true do
		local time = 1000
		if IsPedBeingStunned(PlayerPedId()) then
			time = 1
			SetPedToRagdoll(PlayerPedId(), 15000, 15000, 0, 0, 0, 0)
		end
		Citizen.Wait(time)
	end
end)

maxTaserAmmo = 5 -- Bir kişinin sahip olabileceği tazer kapsüllerinin miktarı.
longerTazeTime = true -- Daha Uzun Süre İstiyorsanız True
longerTazeSecTime = 20 -- Süreyi Uzatmak İsteyenler İçin
local muhittin = false
local taserModel = GetHashKey("WEAPON_STUNGUN")
local taserAmmoLeft = maxTaserAmmo
local tirrek = false

--- Kod ---
RegisterNetEvent('taserreload')
AddEventHandler('taserreload', function()
  local ped = PlayerPedId()
  TaskReloadWeapon(ped)
  muhittin = true
  taserAmmoLeft = 5
    QBCore.Functions.Progressbar("taserdold", "Cartridge Charging", 2000, false, true, {
      disableMovement = false,
      disableCarMovement = false,
      disableMouse = false,
      disableCombat = true,
    }, {
    }, {}, {}, function() -- Done
  end)
end)


CreateThread(function()
  while true do
    Wait(5)
    local ped = PlayerPedId()
    local player =PlayerId()
   
    if HasPedGotWeapon(ped, taserModel, false) and not muhittin then
      DisablePlayerFiring(ped, true)
      if IsPlayerFreeAiming(player) and IsControlPressed(0,18) then
            
        DisablePlayerFiring(ped, true)
            
        tirrek = true      
      end
               
    elseif  muhittin then
      if GetSelectedPedWeapon(ped) == taserModel then
        if IsPedShooting(ped) then
          taserAmmoLeft = taserAmmoLeft - 1
          QBCore.Functions.Notify("Number of cartridges: "..taserAmmoLeft)
        end
      end
    
      if taserAmmoLeft <= 0 then
        if GetSelectedPedWeapon(ped) == taserModel then
          SetPlayerCanDoDriveBy(ped, false)
          DisablePlayerFiring(ped, true)
          QBCore.Functions.Notify("Out of Cartridge!", "error")
          muhittin = false   
        end
      end

        if longerTazeTime then
          SetPedMinGroundTimeForStungun(ped, longerTazeSecTime * 1000)
        end
      end
       
  end
end)