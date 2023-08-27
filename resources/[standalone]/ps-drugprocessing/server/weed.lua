local QBCore = exports['qb-core']:GetCoreObject()

RegisterServerEvent('ps-drugprocessing:pickedUpCannabis', function()
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)

	if Player.Functions.AddItem("cannabis", 1) then
		TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["cannabis"], "add")
		TriggerClientEvent('QBCore:Notify', src, Lang:t("success.cannabis"), "success")
	end
end)

RegisterServerEvent('ps-drugprocessing:processCannabis', function()
	local src = source
    local Player = QBCore.Functions.GetPlayer(src)

	if Player.Functions.RemoveItem('ot', 1) then
		if Player.Functions.AddItem('sarma_ot', 1) then
			TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['ot'], "remove")
			TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['sarma_ot'], "add")
			TriggerClientEvent('QBCore:Notify', src, Lang:t("success.marijuana"), "success")
		else
			Player.Functions.AddItem('ot', 1)
		end
	else
		TriggerClientEvent('QBCore:Notify', src, Lang:t("error.no_cannabis"), "error")
	end
end)

RegisterServerEvent('ps-drugprocessing:rollJoint', function()
	local src = source
    local Player = QBCore.Functions.GetPlayer(src)

	if Player.Functions.RemoveItem('sarma_ot', 1) then
		if Player.Functions.RemoveItem('rolling_paper', 1) then
			if Player.Functions.AddItem('sarma_ot', 1) then
				TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['sarma_ot'], "remove")
				TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['rolling_paper'], "remove")
				TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['joint'], "add")
				TriggerClientEvent('QBCore:Notify', src, Lang:t("success.joint"), "success")
			else
				Player.Functions.AddItem('sarma_ot', 1)
				Player.Functions.AddItem('rolling_paper', 1)
			end
		else
			Player.Functions.AddItem('sarma_ot', 1)
		end
	else
		TriggerClientEvent('QBCore:Notify', src, Lang:t("error.no_marijuhana"), "error")
	end
end)

