local QBCore = exports['qb-core']:GetCoreObject()

QBCore.Functions.CreateCallback('raidBanking:GetPlayerData', function(source,cb)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local pData = {
        job = Player.PlayerData.job.name,
        moneycash = Player.PlayerData.money["cash"],
        moneybank = Player.PlayerData.money["bank"],
        firstname = Player.PlayerData.charinfo.firstname,
        lastname = Player.PlayerData.charinfo.lastname,
        iban = Player.PlayerData.charinfo.iban,
        image = Player.PlayerData.charinfo.photo,
    }
    local transactions = {}
    exports['oxmysql']:execute("SELECT * FROM marp_bank_logs WHERE geleniban=@account OR gondereniban=@account ORDER BY created_at DESC LIMIT 4", {
        ["@account"] = Player.PlayerData.charinfo.iban
    }, function(result)
        if result[1] ~= nil then
            cb(pData, result)
        end
    end)
    cb(pData)
end)

QBCore.Commands.Add('banklog', 'Help Text', {}, false, function(source, args)
    exports['oxmysql']:execute("INSERT INTO marp_bank_logs (alici, gonderen, geleniban, gondereniban, amount) VALUES (@alici, @gonderen, @geleniban, @gondereniban, @amount)", {
        ["@alici"] = "ra1der test ",
        ["@gonderen"] = "ra1der test",
        ["@geleniban"] = "JT3131",
        ["@gondereniban"] = "JT1270",
        ["@amount"] = "1234"
    })
end)

RegisterServerEvent('raidBanking:OpenBank')
AddEventHandler('raidBanking:OpenBank', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local PlayerJob = QBCore.Functions.GetPlayer(src).PlayerData.job
    -- local job = string.format('Meslek: %s |  Rütbe: %s | Mesai Durumu: %s', PlayerJob.label, PlayerJob.gradelabel, Gorev)
    local pData = {
        job = string.format('Meslek: %s - Rütbe: %s', PlayerJob.label, PlayerJob.gradelabel),
        moneycash = Player.PlayerData.money["cash"],
        moneybank = Player.PlayerData.money["bank"],
        firstname = Player.PlayerData.charinfo.firstname,
        lastname = Player.PlayerData.charinfo.lastname,
        iban = Player.PlayerData.charinfo.iban,
        image = Player.PlayerData.charinfo.photo,
    }
    local transactions = {}
    exports['oxmysql']:execute("SELECT * FROM marp_bank_logs WHERE geleniban=@account OR gondereniban=@account ORDER BY created_at DESC LIMIT 4", {
        ["@account"] = Player.PlayerData.charinfo.iban
    }, function(result)
        if result[1] ~= nil then
            TriggerClientEvent('raidBanking:client:OpenBank', src, pData, result)
        else
            TriggerClientEvent('raidBanking:client:OpenBank', src, pData, {})
        end
    end)
end)

RegisterServerEvent('raidBanking:UpdateBank')
AddEventHandler('raidBanking:UpdateBank', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local pData = {
        moneycash = Player.PlayerData.money["cash"],
        moneybank = Player.PlayerData.money["bank"],
    }
    TriggerClientEvent('raidBanking:client:UpdateBank', src, pData)
end)


function update(source)
    exports['oxmysql']:execute("SELECT * FROM marp_bank_logs WHERE geleniban=@account OR gondereniban=@account ORDER BY created_at DESC LIMIT 4", {
        ["@account"] = source.PlayerData.iban
    }, function(result)
        if result[1] ~= nil then
            TriggerClientEvent("raidBanking:update", source.PlayerData.source, result)
        else
            TriggerClientEvent("raidBanking:update", source.PlayerData.source, {})
        end
    end)
end



QBCore.Functions.CreateCallback('raidBanking:server:TransferMoney',function(source, cb, iban, amount)
    local src = source
    local xPlayer = QBCore.Functions.GetPlayer(src)
    local retval = false
    amount = tonumber(amount)
    if xPlayer ~= nil and amount ~= nil and amount > 0 and iban ~= nil then
        local zPlayer = QBCore.GetPlayerByIban(iban)
        local bankMoney = xPlayer.PlayerData.money["bank"]
        if bankMoney >= amount then
            if zPlayer ~= nil and type(zPlayer) == table then
                if zPlayer.PlayerData.iban == xPlayer.PlayerData.iban then
                    TriggerClientEvent("QBCore:Notify", src, "Kendi kendinize para yollayamazsınız")
                else
                    if zPlayer ~= nil then
                        if xPlayer.Functions.RemoveMoney('bank', amount, "bank-transfered-to-"..zPlayer.PlayerData.citizenid) then
                            zPlayer.Functions.AddMoney('bank', amount, "Money transferred to there bank, Sender: "..xPlayer.PlayerData.charinfo.firstname.." "..zPlayer.PlayerData.charinfo.lastname)
                            TriggerClientEvent('QBCore:Notify', zPlayer.PlayerData.source, 'Money transferred to your account: $' .. amount .. ', From IBAN: ' .. xPlayer.PlayerData.iban .. '')
                            TriggerClientEvent('QBCore:Notify', xPlayer.PlayerData.source, iban.. " to account no. $" ..amount..  " has been sent.")
                            TriggerClientEvent('gct-banking:client:Notify', src,amount.."$ your transaction is successful!")
                            exports['oxmysql']:execute("INSERT INTO marp_bank_logs (alici, gonderen, geleniban, gondereniban, amount) VALUES (@alici, @gonderen, @geleniban, @gondereniban, @amount)", {
                                ["@alici"] = zPlayer.PlayerData.charinfo.firstname.." "..xPlayer.PlayerData.charinfo.lastname,
                                ["@gonderen"] = xPlayer.PlayerData.charinfo.firstname.." "..zPlayer.PlayerData.charinfo.lastname,
                                ["@geleniban"] = zPlayer.PlayerData.iban,
                                ["@gondereniban"] = xPlayer.PlayerData.iban,
                                ["@amount"] = amount
                            })
        
                            Citizen.Wait(200)
                            update(xPlayer)
                            update(zPlayer)
                            retval = true
                        end
                    end
                end
            elseif zPlayer ~= nil then
                if iban == xPlayer.PlayerData.iban then
                    TriggerClientEvent("QBCore:Notify", src, "You cannot send money yourself")
                else
                    if xPlayer.Functions.RemoveMoney('bank', amount, "bank-transfered-to-"..iban) then
                        exports['oxmysql']:execute("SELECT * FROM players WHERE iban = @iban", {
                            ["@iban"] = iban
                        }, function(result)
                            if result[1] then
                                result[1].money = json.decode(result[1].money)
                                result[1].charinfo = json.decode(result[1].charinfo)
                                result[1].money.bank = result[1].money.bank + amount
                                TriggerClientEvent('QBCore:Notify', xPlayer.PlayerData.source, iban.. " to account no. $" ..amount..  " has been sent.")
                                TriggerClientEvent('gct-banking:client:Notify', src,amount.."$ your transaction is successful!")
                                exports['oxmysql']:execute("INSERT INTO marp_bank_logs (alici, gonderen, geleniban, gondereniban, amount) VALUES (@alici, @gonderen, @geleniban, @gondereniban, @amount)", {
                                    ["@alici"] = result[1].charinfo.firstname.." "..result[1].charinfo.lastname,
                                    ["@gonderen"] = xPlayer.PlayerData.charinfo.firstname.." "..xPlayer.PlayerData.charinfo.lastname,
                                    ["@geleniban"] = result[1].iban,
                                    ["@gondereniban"] = xPlayer.PlayerData.iban,
                                    ["@amount"] = amount
                                })
                                exports['oxmysql']:execute("UPDATE players SET money = @money WHERE iban = @iban", {
                                    ["@money"] = json.encode(result[1].money),
                                    ["@iban"] = iban
                                })
                                Citizen.Wait(200)
                                update(xPlayer)
                                retval = true
                            end
                        end)
                    end
                end
            else
                retval = false    
            end
        else
            retval = false
        end
    else
        retval = false
    end
    Citizen.Wait(350)
    cb(retval)
end)


QBCore.Functions.CreateCallback('raidBanking:server:TakeMoney',function(source, cb, amount, type)
    local src = source
    local xPlayer = QBCore.Functions.GetPlayer(src)
    local retval = false
    amount = tonumber(amount)
    if xPlayer ~= nil and amount ~= nil and amount > 0 then
        if type == "withdraw" then
            if xPlayer.Functions.RemoveMoney('bank', amount, "bank-withdraw") then
                xPlayer.Functions.AddMoney('cash', amount, "Bank Withdrawal")
                TriggerClientEvent('raidBanking:Notify', src, amount.."$ your transaction is successful!")
                retval = true
            end
        elseif type == "deposit" then
            if xPlayer.Functions.RemoveMoney('cash', amount, "bank-deposit") then
                TriggerClientEvent('raidBanking:Notify', src, amount.."$ your transaction is successful!")
                xPlayer.Functions.AddMoney('bank', amount, "Bank Deposit Transaction")
                retval = true
            end
        else
            retval = false
        end
    else
        retval = false
    end
    Citizen.Wait(350)
    cb(retval)
end)

RegisterServerEvent("target:paraal", function(id)
  local Player = QBCore.Functions.GetPlayer(source)
	local PlayerPos = GetEntityCoords(GetPlayerPed(source))
	local TargetId = id
	local Target = QBCore.Functions.GetPlayer(TargetId)
	local TargetPos = GetEntityCoords(GetPlayerPed(TargetId))

	if Target ~= nil then
		if #(PlayerPos - TargetPos) < 3 then
			if Target.PlayerData.money.cash >= 1 then
				if TargetId ~= source then
					TriggerClientEvent('tgiann-thief:SteelMoney', source, TargetId)
				else
					TriggerClientEvent('QBCore:Notify', source, "You can't undress yourself!", 'error')
				end
			else
				TriggerClientEvent('QBCore:Notify', source,  "The player has no money!", 'error')
			end
		else
			TriggerClientEvent('QBCore:Notify', source, "The player you will rob is not with you!", 'error')
		end
	else
		TriggerClientEvent('QBCore:Notify', source, "The player is not online", 'error')
	end 
end)

QBCore.Functions.CreateCallback("target:paraver", function(source,cb,id,para)
	local Player = QBCore.Functions.GetPlayer(source)
	local TargetId = id
	--local PlayerPos = GetEntityCoords(GetPlayerPed(src))
	local Target = QBCore.Functions.GetPlayer(TargetId)
	--local TargetPos = GetEntityCoords(GetPlayerPed(TargetId))
	local amount = para

	if Target and Player then
	    if amount ~= nil then
		    if amount > 0 then
		        if Player.PlayerData.money.cash >= amount and amount > 0 then
			        --if #(PlayerPos - TargetPos) < 3 then
                        if TargetId ~= source then
                            cb(true)
                            TriggerClientEvent("target:paraver:basari",source)
                            TriggerClientEvent("target:paraver:basari",TargetId)
                            Player.Functions.RemoveMoney('cash', amount, "Cash given to "..Player.PlayerData.citizenid)
                            Target.Functions.AddMoney('cash', amount, "Receives Cash Money Giver:"..Player.PlayerData.charinfo.firstname .. " " ..Player.PlayerData.charinfo.lastname)
                            TriggerClientEvent('QBCore:Notify', TargetId, Player.PlayerData.charinfo.firstname.." to you " .. amount .. "$ gave cash!", 'success')
                            TriggerClientEvent('QBCore:Notify', source, Target.PlayerData.charinfo.firstname.." to the person named " .. amount .. "$ you gave cash!", 'success')
                            -- TriggerEvent("DiscordBot:ToDiscord", "paratransfer", "Para verdi: "..amount.."$", source, TargetId)
                        else
                            cb(false)
                            TriggerClientEvent('chatMessage', source, "Sistem", "error", "You can't give yourself money!")
                        end
                    --else
                    --  TriggerClientEvent('chatMessage', source, "Sistem", "error", "Nakit vereceğin oyuncu yanında değil!")
                    --end
		        else
                    cb(false)
			        TriggerClientEvent('chatMessage', source, "Sistem", "error", "You don't have enough money!")
		        end
		    else
                cb(false)
		        TriggerClientEvent('chatMessage', source, "Sistem", "error", "The amount must be greater than zero!")
		    end
	    else
            cb(false)
		    TriggerClientEvent('chatMessage', source, "Sistem", "error", "You have to write some!")
	    end
	else
        cb(false)
	    TriggerClientEvent('chatMessage', source, "Sistem", "error", "The player is not online!")
	end
end)