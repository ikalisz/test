local canHandsUp = true
local isdead = false

AddEventHandler('handsup:toggle', function(param)
	canHandsUp = param
end)

AddEventHandler('tgiann:playerdead', function(dead)
	isdead = dead
end)

RegisterNetEvent("tgiann-thieff:hands-up")
AddEventHandler("tgiann-thieff:hands-up", function()
	if canHandsUp then handsUp() end
end)

function handsUp()
	local playerPed = PlayerPedId()
	if not exports["high_phone"]:phoneIsOpen() then 
		if DoesEntityExist(playerPed) and not isdead then
			if IsEntityPlayingAnim(playerPed, "missminuteman_1ig_2", "handsup_base", 3) then
				ClearPedTasks(playerPed)
				TriggerServerEvent('esx_thief:update', false)
			else
				QBCore.Shared.RequestAnimDict('missminuteman_1ig_2', function()
					TaskPlayAnim(playerPed, 'missminuteman_1ig_2', 'handsup_base', 2.0, 2.5, -1, 49, 0, 0, 0, 0)
					TriggerServerEvent('esx_thief:update', true)
				end)
			end
		end
	else
		QBCore.Functions.Notify('You cant raise your hands when the phone is on', 'error', 7500)
	end
end