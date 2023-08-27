QBCore = nil
TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)

RegisterServerEvent('esx_billing:sendBill')
AddEventHandler('esx_billing:sendBill', function(playerId, sharedAccountName, label, amount)
	local src = source
	local xPlayer = QBCore.Functions.GetPlayer(src)
	local xIdentifier = xPlayer.PlayerData.citizenid
	local xTarget = QBCore.Functions.GetPlayer(playerId)
	local tIdentifier = xTarget.PlayerData.citizenid
	local amount  = QBCore.Shared.Round(amount, 2)

	if xTarget ~= nil then
		if sharedAccountName == "police" then
			TriggerEvent('DiscordBot:ToDiscord', 'pceza', 'Fines Cut! $'..amount, src, playerId)
			QBCore.Functions.addJobMoney("police", amount)
		else
			TriggerEvent('DiscordBot:ToDiscord', 'fatura', amount.." Fatura Kesti! İşletme: "..sharedAccountName, xPlayer.PlayerData.source, xTarget.PlayerData.source)
		end
		exports.oxmysql:execute('INSERT INTO billing (citizenid, sender, target, label, amount) VALUES (@citizenid, @sender, @target, @label, @amount)', {
			['@citizenid']   = tIdentifier,
			['@sender']      = xIdentifier,
			['@target']      = sharedAccountName,
			['@label']       = label,
			['@amount']      = amount
		}, function()
			TriggerClientEvent("QBCore:Notify", xTarget.PlayerData.source, 'You have a new invoice')
		end)
	end
end)

QBCore.Functions.CreateCallback('esx_billing:payBill', function(source, cb, invoiceId)
    local Player = QBCore.Functions.GetPlayer(source)
	exports.oxmysql:execute("SELECT * FROM billing WHERE `id` = '"..invoiceId.."'", {}, function(invoice)
        if invoice[1] ~= nil then
			Player.Functions.RemoveMoney("bank", invoice[1].amount, "Bill Paid!")
			TriggerClientEvent("qb-phone:client:updateInvoices", Player.PlayerData.source)
			exports.oxmysql:execute("DELETE FROM billing WHERE `id` = '"..invoiceId.."'", {}, function(rowsChanged)
				cb("ok")
			end)
		end
    end)
end)

QBCore.Commands.Add('invoice', 'Send someone a invoice', {}, false, function(source, args)
	local src = source
	local xPlayer = QBCore.Functions.GetPlayer(src)
	local xIdentifier = xPlayer.PlayerData.citizenid
	local amount  = QBCore.Shared.Round(args[1], 2)

	if xPlayer ~= nil then
		-- if sharedAccountName == "police" then
		-- 	TriggerEvent('DiscordBot:ToDiscord', 'pceza', 'Para Cezası Kesti! $'..amount, src, playerId)
		-- else
		-- 	TriggerEvent('DiscordBot:ToDiscord', 'fatura', amount.." Fatura Kesti! İşletme: "..sharedAccountName, xPlayer.PlayerData.source, xTarget.PlayerData.source)
		-- end
		exports.oxmysql:execute('INSERT INTO billing (citizenid, sender, target, label, amount) VALUES (@citizenid, @sender, @target, @label, @amount)', {
			['@citizenid']   = xIdentifier,
			['@sender']      = 0,
			['@target']      = "devlet",
			['@label']       = "Vergi",
			['@amount']      = amount
		}, function()
			TriggerClientEvent("QBCore:Notify", xPlayer.PlayerData.source, 'You have a new invoice')
		end)
	end
end, "god")

QBCore.Functions.CreateCallback('esx_billing:getBills', function(source, cb)
	local src = source
	local xPlayer = QBCore.Functions.GetPlayer(src)
	if xPlayer then
		exports.oxmysql:execute('SELECT * FROM billing WHERE citizenid = @citizenid', {
			['@citizenid'] = xPlayer.PlayerData.citizenid
		}, function(result)
			local bills = {}
			for i=1, #result, 1 do
				table.insert(bills, {
					id         = result[i].id,
					citizenid  = result[i].citizenid,
					sender     = result[i].sender,
					target     = result[i].target,
					label      = result[i].label,
					amount     = result[i].amount
				})
			end

			cb(bills)
		end)
	end
end)

QBCore.Functions.CreateCallback('esx_billing:getTargetBills', function(source, cb, target)
	local xPlayer = QBCore.Functions.GetPlayer(target)
	exports.oxmysql:execute('SELECT * FROM billing WHERE citizenid = @citizenid', {
		['@citizenid'] = xPlayer.PlayerData.citizenid
	}, function(result)
		local bills = {}
		for i=1, #result, 1 do
			table.insert(bills, {
				id         = result[i].id,
				citizenid  = result[i].citizenid,
				sender     = result[i].sender,
				target     = result[i].target,
				label      = result[i].label,
				amount     = result[i].amount
			})
		end

		cb(bills)
	end)
end)

RegisterServerEvent('esx_billing:aracvergi')
AddEventHandler('esx_billing:aracvergi', function(playerId, sharedAccountName, label, amount)
	local xPlayer = QBCore.Functions.GetPlayer(playerId)
	if xPlayer then
		local amount = QBCore.Shared.Round(amount, 2)
		exports.oxmysql:execute("UPDATE billing SET amount = amount + '"..amount.."' WHERE citizenid = @citizenid AND label = @label", {
			['@citizenid'] = xPlayer.PlayerData.citizenid,
			['@label'] = label,
		}, function(result)
			if result.affectedRows == 0 then
				exports.oxmysql:execute('INSERT INTO billing (citizenid, sender, target, label, amount) VALUES (@citizenid, @sender, @target, @label, @amount)', {
					['@citizenid']  = xPlayer.PlayerData.citizenid,
					['@sender']      = 0,
					['@target']      = sharedAccountName,
					['@label']       = label,
					['@amount']      = amount
				})
			end
		end)	
	end
end)