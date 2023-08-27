local isPickingUp, isProcessing = false, false
local QBCore = exports['qb-core']:GetCoreObject()

local function Processlsd()
	isProcessing = true
	local playerPed = PlayerPedId()

	TaskStartScenarioInPlace(playerPed, "PROP_HUMAN_PARKING_METER", 0, true)
	QBCore.Functions.Progressbar("search_register", Lang:t("progressbar.processing"), 15000, false, true, {
		disableMovement = true,
		disableCarMovement = true,
		disableMouse = false,
		disableCombat = true,
		disableKeyboard = true,
	}, {}, {}, {}, function()
		TriggerServerEvent('ps-drugprocessing:Processlsd')

		local timeLeft = Config.Delays.lsdProcessing / 1000
		while timeLeft > 0 do
			Wait(1000)
			timeLeft -= 1
			if #(GetEntityCoords(playerPed)-Config.CircleZones.lsdProcessing.coords) > 5 then
				QBCore.Functions.Notify(Lang:t("error.too_far"))
				TriggerServerEvent('ps-drugprocessing:cancelProcessing')
				break
			end
		end
		ClearPedTasks(playerPed)
		isProcessing = false
		ClearPedTasksImmediately(PlayerPedId())
	end, function()
		ClearPedTasks(playerPed)
		isProcessing = false
		ClearPedTasksImmediately(PlayerPedId())
	end)
end

local function Processthionylchloride()
	isProcessing = true
	local playerPed = PlayerPedId()

	TaskStartScenarioInPlace(playerPed, "PROP_HUMAN_PARKING_METER", 0, true)
	QBCore.Functions.Progressbar("search_register", Lang:t("progressbar.processing"), 15000, false, true, {
		disableMovement = true,
		disableCarMovement = true,
		disableMouse = false,
		disableCombat = true,
		disableKeyboard = true,
	}, {}, {}, {}, function()
		TriggerServerEvent('ps-drugprocessing:processThionylChloride')
		local timeLeft = Config.Delays.thionylchlorideProcessing / 1000
		while timeLeft > 0 do
			Wait(1000)
			timeLeft -= 1
			if #(GetEntityCoords(playerPed)-Config.CircleZones.thionylchlorideProcessing.coords) > 5 then
				QBCore.Functions.Notify(Lang:t("error.too_far"))
				TriggerServerEvent('ps-drugprocessing:cancelProcessing')
				break
			end
		end
		ClearPedTasks(playerPed)
		ClearPedTasksImmediately(PlayerPedId())
		isProcessing = false
	end, function()
		ClearPedTasks(playerPed)
		ClearPedTasksImmediately(PlayerPedId())
		isProcessing = false
	end)
end

CreateThread(function()
    while true do
        Wait(0)
        local playerPed = PlayerPedId()
        local coords = GetEntityCoords(playerPed)

        if #(coords-Config.CircleZones.lsdProcessing.coords) < 2 then
            if not isProcessing then
                local pos = GetEntityCoords(PlayerPedId())
				exports['qb-ui']:showInteraction(Lang:t("drawtext.process_lsd"), nil, "lsd")
            end
            if IsControlJustReleased(0, 38) and not isProcessing then
				exports['qb-ui']:hideInteraction("lsd")
				QBCore.Functions.TriggerCallback('elixir-base:item-kontrol', function(qtty1)
					if qtty1 >= 1 then
						QBCore.Functions.TriggerCallback('elixir-base:item-kontrol', function(qtty)
							if qtty >= 1 then
								Processlsd()
							else
								QBCore.Functions.Notify("LSA Yok?", 'error')
							end
						end, "lsa")
					else
						QBCore.Functions.Notify("Tiyonil Klorür Yok?", 'error')
					end
				end, "thionyl_chloride")
            end
        else
			exports['qb-ui']:hideInteraction("lsd")
            Wait(500)
        end
    end
end)

RegisterNetEvent('ps-drugprocessing:processingThiChlo', function()
	local coords = GetEntityCoords(PlayerPedId(source))
	
	if #(coords-Config.CircleZones.thionylchlorideProcessing.coords) < 5 then
		if not isProcessing then
			QBCore.Functions.TriggerCallback('ps-drugprocessing:validate_items', function(result)
				if result then
					Processthionylchloride()
				else
					QBCore.Functions.Notify(Lang:t("error.not_all_items"), 'error')
				end
			end, {lsa = 1, chemicals = 1})
		end
	end
end)
