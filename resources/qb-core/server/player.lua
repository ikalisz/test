QBCore.Players = {}
QBCore.Player = {}

local jobCdPlayer = {}

QBCore.Player.Login = function(source, citizenid, newData)
	if source ~= nil then
		if citizenid then
			QBCore.Functions.ExecuteSql(true, "SELECT * FROM `players` WHERE `citizenid` = '"..citizenid.."'", function(result)
				local PlayerData = result[1]
				if PlayerData ~= nil then
					PlayerData.money = json.decode(PlayerData.money)
					PlayerData.job = json.decode(PlayerData.job)
					PlayerData.position = json.decode(PlayerData.position)
					PlayerData.metadata = json.decode(PlayerData.metadata)
					PlayerData.charinfo = json.decode(PlayerData.charinfo)
					PlayerData.tattoo = json.decode(PlayerData.tattoo)
					PlayerData.jobcd = json.decode(PlayerData.jobcd)
					PlayerData.aranma = json.decode(PlayerData.aranma)
					PlayerData.obje = json.decode(PlayerData.obje)
				end
				QBCore.Player.CheckPlayerData(source, PlayerData)
			end)
		else
			QBCore.Player.CheckPlayerData(source, newData)
		end
		return true
	else
		QBCore.ShowError(GetCurrentResourceName(), "ERROR QBCORE.PLAYER.LOGIN - NO SOURCE GIVEN!")
		return false
	end
end

QBCore.GetPlayerByIban = function(number)
	for src, player in pairs(QBCore.Players) do
		if QBCore.Players[src].PlayerData.charinfo.iban == number then
			return QBCore.Players[src]
		end
	end

	QBCore.Functions.ExecuteSql(false, "SELECT * FROM players WHERE iban = '"..number .."'", function(result)
		if result[1] then
			return result[1].iban
		else
			return nil
		end
	end)
end

-- QBCore.Functions.GetPlayerByPhone = function(number)
--     for src, player in pairs(QBCore.Players) do
--         local cid = citizenid
--         if QBCore.Players[src].PlayerData.charinfo.phone == number then
--             return QBCore.Players[src]
--         end
--     end
--     return nil
-- end

QBCore.Player.CheckPlayerData = function(source, PlayerData)
	PlayerData = PlayerData ~= nil and PlayerData or {}

	PlayerData.source = source
	PlayerData.citizenid = PlayerData.citizenid ~= nil and PlayerData.citizenid or QBCore.Player.CreateCitizenId()
	PlayerData.steam = PlayerData.steam ~= nil and PlayerData.steam or QBCore.Functions.GetIdentifier(source, "steam")
	PlayerData.license = PlayerData.license ~= nil and PlayerData.license or QBCore.Functions.GetIdentifier(source, "license")

	PlayerData.name = GetPlayerName(source)
	PlayerData.cid = PlayerData.cid ~= nil and PlayerData.cid or 1

	PlayerData.money = PlayerData.money ~= nil and PlayerData.money or {}
	for moneytype, startamount in pairs(QBCore.Config.Money.MoneyTypes) do
		PlayerData.money[moneytype] = PlayerData.money[moneytype] ~= nil and PlayerData.money[moneytype] or startamount
	end

	PlayerData.tattoo = PlayerData.tattoo ~= nil and PlayerData.tattoo or {}

	PlayerData.charinfo = PlayerData.charinfo ~= nil and PlayerData.charinfo or {}
	PlayerData.charinfo.firstname = PlayerData.charinfo.firstname ~= nil and PlayerData.charinfo.firstname or "Ad"
	PlayerData.charinfo.lastname = PlayerData.charinfo.lastname ~= nil and PlayerData.charinfo.lastname or "Soyad"
	PlayerData.charinfo.birthdate = PlayerData.charinfo.birthdate ~= nil and PlayerData.charinfo.birthdate or "00-00-0000"
	PlayerData.charinfo.gender = PlayerData.charinfo.gender ~= nil and PlayerData.charinfo.gender or "Female"
	PlayerData.charinfo.nationality = PlayerData.charinfo.nationality ~= nil and PlayerData.charinfo.nationality or "Belirsiz"
	PlayerData.charinfo.photo = PlayerData.charinfo.photo ~= nil and PlayerData.charinfo.photo or "Resim Bulunamadı"
	local phone = "1"..math.random(111111, 999999)
	-- PlayerData.charinfo.phone = PlayerData.charinfo.phone ~= nil and PlayerData.charinfo.phone or phone
	PlayerData.charinfo.phone = PlayerData.charinfo.phone or QBCore.Functions.CreatePhoneNumber()
	PlayerData.phone = PlayerData.phone ~= nil and PlayerData.phone or phone
	PlayerData.charinfo.account = PlayerData.charinfo.account ~= nil and PlayerData.charinfo.account or "JT0"..math.random(1,9)..""..math.random(1111,9999)..math.random(1111,9999)..math.random(11,99)
	local iban = PlayerData.charinfo.iban ~= nil and PlayerData.charinfo.iban or "JT"..math.random(1,9)..""..math.random(100, 555)
	PlayerData.charinfo.iban = iban
	PlayerData.iban = iban
	-- PlayerData.metadata["background"] = PlayerData.metadata["background"] ~= nil and PlayerData.metadata["background"] or 'default'
	
	PlayerData.metadata = PlayerData.metadata ~= nil and PlayerData.metadata or {}

	PlayerData.metadata["number"] = PlayerData.metadata["number"] ~= nil and PlayerData["number"] or generateNumber()
	PlayerData.metadata["heal"] = PlayerData.metadata["heal"] ~= nil and PlayerData.metadata["heal"] or 200
	PlayerData.metadata["communityservice"] = PlayerData.metadata["communityservice"] ~= nil and PlayerData.metadata["communityservice"] or 0
	PlayerData.metadata["crypto"] = PlayerData.metadata["crypto"] ~= nil and PlayerData.metadata["crypto"] or {
		["bitcoin"] = 0, 
		["ethereum"] = 0, 
		["bitcoin-cash"] = 0, 
		["bitcoin-sv"] = 0, 
		["litecoin"] = 0, 
		["binance-coin"] = 0,
		["monero"] = 0, 
		["dash"] = 0, 
		["zcash"] = 0, 
		["maker"] = 0
	}
	PlayerData.metadata["hunger"] = PlayerData.metadata["hunger"] ~= nil and PlayerData.metadata["hunger"] or 100
	PlayerData.metadata["thirst"] = PlayerData.metadata["thirst"] ~= nil and PlayerData.metadata["thirst"] or 100
	PlayerData.metadata['stress'] = PlayerData.metadata['stress'] or 0
	PlayerData.metadata["armor"]  = PlayerData.metadata["armor"]  ~= nil and PlayerData.metadata["armor"] or 0
	PlayerData.metadata["drunk"]  = PlayerData.metadata["drunk"]  ~= nil and PlayerData.metadata["drunk"] or 0
	PlayerData.metadata["skill"]  = PlayerData.metadata["skill"]  ~= nil and PlayerData.metadata["skill"] or {
		["Kondisyon"] = {["Current"] = 15.0, ["Stat"] = "MP0_STAMINA", ["RemoveAmount"] = 0}, 
		["Güç"] = {["Current"] = 5.0, ["Stat"] = "MP0_STRENGTH", ["RemoveAmount"] = 0 }
	}
	PlayerData.metadata["prestij"] = PlayerData.metadata["prestij"] ~= nil and PlayerData.metadata["prestij"] or {level = 0, exp = 0}
	PlayerData.metadata["isdead"] = PlayerData.metadata["isdead"] ~= nil and PlayerData.metadata["isdead"] or false
	PlayerData.metadata["ishandcuffed"] = PlayerData.metadata["ishandcuffed"] ~= nil and PlayerData.metadata["ishandcuffed"] or false	
	PlayerData.metadata["injail"] = PlayerData.metadata["injail"] ~= nil and PlayerData.metadata["injail"] or false
	PlayerData.metadata["jailtime"] = PlayerData.metadata["jailtime"] ~= nil and PlayerData.metadata["jailtime"] or 0
	PlayerData.metadata["commandbinds"] = PlayerData.metadata["commandbinds"] ~= nil and PlayerData.metadata["commandbinds"] or {}
	PlayerData.metadata["craftingrep"] = PlayerData.metadata["craftingrep"] ~= nil and PlayerData.metadata["craftingrep"] or 0

	PlayerData.metadata['inside'] = PlayerData.metadata['inside'] or {
        house = nil,
        apartment = {
            apartmentType = nil,
            apartmentId = nil,
        }
    }

	PlayerData.metadata["illegal"] = PlayerData.metadata["illegal"] ~= nil and PlayerData.metadata["illegal"] or false
	PlayerData.metadata["race"] = PlayerData.metadata["race"] ~= nil and PlayerData.metadata["race"] or false

	PlayerData.metadata["sure"] = PlayerData.metadata["sure"] ~= nil and PlayerData.metadata["sure"] or 0
	PlayerData.metadata["surefull"] = PlayerData.metadata["surefull"] ~= nil and PlayerData.metadata["surefull"] or 0

	PlayerData.metadata["dutytime"] = PlayerData.metadata["dutytime"] ~= nil and PlayerData.metadata["dutytime"] or 0


	PlayerData.metadata["gang"] = PlayerData.metadata["gang"] ~= nil and PlayerData.metadata["gang"] or "normal"
	PlayerData.metadata["hackcount"] = PlayerData.metadata["hackcount"] ~= nil and PlayerData.metadata["hackcount"] or 0
	PlayerData.metadata["uzum"] = PlayerData.metadata["uzum"] ~= nil and PlayerData.metadata["uzum"] or 0
	PlayerData.metadata["fallouthacktime"] = PlayerData.metadata["fallouthacktime"] ~= nil and PlayerData.metadata["fallouthacktime"] or os.time()
	PlayerData.metadata["kelepce"] = PlayerData.metadata["kelepce"] ~= nil and PlayerData.metadata["kelepce"] or false
	PlayerData.metadata["pkelepce"] = PlayerData.metadata["pkelepce"] ~= nil and PlayerData.metadata["pkelepce"] or false
	PlayerData.metadata["motelroom"] = PlayerData.metadata["motelroom"] ~= nil and PlayerData.metadata["motelroom"] or 0
	PlayerData.metadata['walkstyle'] = PlayerData.metadata['walkstyle'] or 'default'

	PlayerData.metadata['licences'] = PlayerData.metadata['licences'] or {
        ['driver'] = false,
        ['business'] = false,
        ['weapon'] = false,
		['hunting'] = false
    }
	
	PlayerData.metadata["phonedata"] = PlayerData.metadata["phonedata"] ~= nil and PlayerData.metadata["phonedata"] or {
        SerialNumber = QBCore.Player.CreateSerialNumber(),
        InstalledApps = {},
    }

	PlayerData.metadata["phone"] = PlayerData.metadata["phone"] ~= nil and PlayerData.metadata["phone"] or {}
	
	PlayerData.metadata["ehliyetceza"] = PlayerData.metadata["ehliyetceza"] ~= nil and PlayerData.metadata["ehliyetceza"] or 0
	PlayerData.metadata["yarisci"] = PlayerData.metadata["yarisci"] ~= nil and PlayerData.metadata["yarisci"] or false
	PlayerData.jobcd = PlayerData.jobcd ~= nil and PlayerData.jobcd or {
		["ticaret"] = {
			["cd"] = false,
			["count"] = 0,
		},
		["shark"] = {
			["cd"] = false,
			["count"] = 0,
		},
	}	
	PlayerData.evjob = PlayerData.evjob ~= nil and PlayerData.evjob or 0

	PlayerData.job = PlayerData.job ~= nil and PlayerData.job or {}
	PlayerData.job.name = PlayerData.job.name ~= nil and PlayerData.job.name or "unemployed"
	PlayerData.job.label = PlayerData.job.label ~= nil and PlayerData.job.label or "Unemployed"
	PlayerData.job.grade = PlayerData.job.grade ~= nil and PlayerData.job.grade or 1
	PlayerData.job.payment = QBCore.Shared.Jobs[PlayerData.job.name].grade[PlayerData.job.grade].payment
	PlayerData.job.gradelabel = PlayerData.job.gradelabel ~= nil and PlayerData.job.gradelabel or "Unemployed"
	PlayerData.job.paySafe = QBCore.Shared.Jobs[PlayerData.job.name].paySafe

	if QBCore.Shared.Jobs[PlayerData.job.name].grade[PlayerData.job.grade].boss then
		PlayerData.job.boss = true
	else
		PlayerData.job.boss = false
	end

	PlayerData.obje = PlayerData.obje ~= nil and PlayerData.obje or {}	

	PlayerData.aranma = PlayerData.aranma ~= nil and PlayerData.aranma or {}
	PlayerData.aranma.durum = PlayerData.aranma.durum ~= nil and PlayerData.aranma.durum or false
	PlayerData.aranma.sebep = PlayerData.aranma.sebep ~= nil and PlayerData.aranma.sebep or ""
	PlayerData.aranma.saat = PlayerData.aranma.saat ~= nil and PlayerData.aranma.saat or ""
	PlayerData.aranma.suansaat = PlayerData.aranma.suansaat ~= nil and PlayerData.aranma.suansaat or os.time()

	PlayerData.position = PlayerData.position ~= nil and PlayerData.position or QBConfig.DefaultSpawn
	PlayerData = QBCore.Player.LoadInventory(PlayerData)
	QBCore.Player.CreatePlayer(PlayerData)
end

function QBCore.Functions.CreatePhoneNumber()
    local UniqueFound = false
    local PhoneNumber = nil
    while not UniqueFound do
        PhoneNumber = math.random(1,9) .. math.random(1000,9999)
        local query = '%' .. PhoneNumber .. '%'
        local result = MySQL.prepare.await('SELECT COUNT(*) as count FROM players WHERE charinfo LIKE ?', { query })
        if result == 0 then
            UniqueFound = true
        end
    end
    return PhoneNumber
end


QBCore.Player.CreatePlayer = function(PlayerData)
	local self = {}
	self.Functions = {}
	self.PlayerData = PlayerData

	self.Functions.UpdatePlayerData = function()
		--if os.time() - self.lasUpdateTime > 3 or self.lasUpdateTime == 0 then
			--self.lasUpdateTime = os.time()
			TriggerClientEvent("QBCore:Player:SetPlayerData", self.PlayerData.source, self.PlayerData)
		--end
	end

	self.Functions.SetJob = function(job, grade)
		local job = job:lower()
		local grade = tonumber(grade)
		if QBCore.Shared.Jobs[job] ~= nil and QBCore.Shared.Jobs[job].grade[grade] then
			local oldJob = self.PlayerData.job.name
			local oldDuty = self.PlayerData.job.onduty
			if oldDuty and oldJob ~= job then
				TriggerEvent("elixir-base:meslekKisiSil", self.PlayerData.job.name, self.PlayerData.source)
				TriggerEvent("elixir-base:meslekKisiEkle", job, self.PlayerData.source)
			end
			self.PlayerData.job.name = job
			self.PlayerData.job.label = QBCore.Shared.Jobs[job].label
			self.PlayerData.job.grade = grade
			self.PlayerData.job.payment = QBCore.Shared.Jobs[job].grade[grade].payment
			self.PlayerData.job.gradelabel = QBCore.Shared.Jobs[job].grade[grade].label
			self.PlayerData.job.onduty = true

			if QBCore.Shared.Jobs[PlayerData.job.name].grade[PlayerData.job.grade].boss then
				self.PlayerData.job.boss = true
			else
				self.PlayerData.job.boss = false
			end

			self.Functions.UpdatePlayerData()
			
			TriggerClientEvent("QBCore:Client:OnJobUpdate", self.PlayerData.source, self.PlayerData.job)
			
			--TriggerEvent("QBCore:Server:OnJobUpdate", self.PlayerData.job)
			return true
		else
			return false
		end
	end

	self.Functions.SetJobDuty = function(onDuty)
		self.PlayerData.job.onduty = onDuty
		self.Functions.UpdatePlayerData()
		if self.PlayerData.job.onduty then
			TriggerEvent("elixir-base:meslekKisiEkle", self.PlayerData.job.name, self.PlayerData.source)
		else
			TriggerEvent("elixir-base:meslekKisiSil", self.PlayerData.job.name, self.PlayerData.source)
		end
		TriggerClientEvent("QBCore:Client:OnJobUpdate", self.PlayerData.source, self.PlayerData.job)
	end

	self.Functions.SetSure = function(time)
		PlayerData.metadata["sure"] = time
	end

	self.Functions.SetMetaData = function(meta, val)
		local meta = meta:lower()
		if val ~= nil then
			self.PlayerData.metadata[meta] = val
			self.Functions.UpdatePlayerData()
		end
	end

	self.Functions.SetIllegalJobData = function(val)
		if val ~= nil then
			self.PlayerData.evjob = val
			self.Functions.UpdatePlayerData()
		end
	end

	self.Functions.SetAranma = function(durum, sebep, saat)
		self.PlayerData.aranma.durum = durum
		if sebep then
			self.PlayerData.aranma.sebep = sebep
			self.PlayerData.aranma.saat = saat
			self.PlayerData.aranma.suansaat = os.time()
		end
	end

	self.Functions.objeData = function(val)
		if val ~= nil then
			self.PlayerData.obje = val
			self.Functions.UpdatePlayerData()
		end
	end

	self.Functions.Reset = function()
		self.PlayerData.jobcd = {}
		self.PlayerData.evjob = 0
	end

	self.Functions.SetJobCd = function(job, count)
		if self.PlayerData.jobcd[job] == nil then
			self.PlayerData.jobcd[job] = {}
			self.PlayerData.jobcd[job]["count"] = 0
			self.PlayerData.jobcd[job]["cd"] = false
		end

		if count == nil then count = 0 end

		self.PlayerData.jobcd[job]["count"] = self.PlayerData.jobcd[job]["count"] + count

		if QBConfig.JobCD[job] >= self.PlayerData.jobcd[job]["count"] then
			self.PlayerData.jobcd[job]["cd"] = true
		end
		self.Functions.UpdatePlayerData()
	end

	self.Functions.CheckJobCd = function(job)
		if self.PlayerData.jobcd[job] then
			if self.PlayerData.jobcd[job]["cd"] then
				--TriggerClientEvent('QBCore:Notify', self.PlayerData.source, "Bu iş için günlük limitin doldu!", "error") 
				return true
			end
			return not self.PlayerData.jobcd[job]["cd"]
		else
			return true
		end
	end

	self.Functions.SetTattoo = function(val)
		if val ~= nil then
			self.PlayerData.tattoo = val
			self.Functions.UpdatePlayerData()
		end
	end

	self.Functions.SetCharInfo = function(info, val)
		local info = info:lower()
		if val ~= nil then
			self.PlayerData.charinfo[info] = val
			self.Functions.UpdatePlayerData()
		end
	end

	self.Functions.AddJobReputation = function(amount)
		local amount = tonumber(amount)
		self.PlayerData.metadata["jobrep"][self.PlayerData.job.name] = self.PlayerData.metadata["jobrep"][self.PlayerData.job.name] + amount
		self.Functions.UpdatePlayerData()
	end

	self.Functions.AddMoney = function(moneytype, amount, reason)
		reason = reason ~= nil and reason or "unkown"
		local moneytype = moneytype:lower()
		local amount = tonumber(amount)
		if amount < 0 then return end
		if self.PlayerData.money[moneytype] ~= nil then
			self.PlayerData.money[moneytype] = self.PlayerData.money[moneytype]+amount
			self.Functions.UpdatePlayerData()
			TriggerClientEvent("hud:client:OnMoneyChange", self.PlayerData.source, moneytype, amount, false)
			return true
		end
		return false
	end

	self.Functions.RemoveMoney = function(moneytype, amount, reason)
		reason = reason ~= nil and reason or "unkown"
		local moneytype = moneytype:lower()
		local amount = tonumber(amount)
		if amount < 0 then return end
		if self.PlayerData.money[moneytype] ~= nil then
			for i=1, #QBCore.Config.Money.DontAllowMinus do
				if QBCore.Config.Money.DontAllowMinus[i] == moneytype then
					if self.PlayerData.money[moneytype] - amount < 0 then return false end
				end
			end                                       

			self.PlayerData.money[moneytype] = self.PlayerData.money[moneytype] - amount
			self.Functions.UpdatePlayerData()
			TriggerClientEvent("hud:client:OnMoneyChange", self.PlayerData.source, moneytype, amount, true)
			return true
		end
		return false
	end

	self.Functions.SetMoney = function(moneytype, amount, reason)
		reason = reason ~= nil and reason or "unkown"
		local moneytype = moneytype:lower()
		local amount = tonumber(amount)
		if amount < 0 then return end
		if self.PlayerData.money[moneytype] ~= nil then
			self.PlayerData.money[moneytype] = amount
			self.Functions.UpdatePlayerData()
			TriggerClientEvent("hud:client:OnMoneyChange", self.PlayerData.source, moneytype, amount, true)
			return true
		end
		return false
	end

	self.Functions.GetMoney = function(moneytype)
        if moneytype then
            local moneytype = moneytype:lower()
            return self.PlayerData.money[moneytype]
        end
        return false
    end

	self.Functions.AddItem = function(item, amount, slot, info)

		local totalWeight = QBCore.Player.GetTotalWeight(self.PlayerData.items)
		local itemInfo = QBCore.Shared.Items[item:lower()]
		if itemInfo == nil then 
			TriggerClientEvent('QBCore:Notify', src, "Item Not Found :"..item) 
			return 
		end
		local amount = tonumber(amount)
		local slot = tonumber(slot) ~= nil and tonumber(slot) or QBCore.Player.GetFirstSlotByItem(self.PlayerData.items, item)
		if itemInfo["type"] == "weapon" and info == nil then
			info = {
				serie = tostring("JT" ..QBCore.Shared.RandomInt(2) .. QBCore.Shared.RandomInt(5)),
				--  serie = tostring(QBCore.Shared.RandomInt(2) .. QBCore.Shared.RandomStr(3) .. QBCore.Shared.RandomInt(1) .. QBCore.Shared.RandomStr(2) .. QBCore.Shared.RandomInt(3) .. QBCore.Shared.RandomStr(4)),
				durubality = os.time()
			}
		end
		if item:lower() == "bag" and (info.created == nil or info.created == false)  then
			info = {
				created = true,
				stashName = tostring(QBCore.Shared.RandomInt(2) .. QBCore.Shared.RandomStr(3) .. QBCore.Shared.RandomInt(3) .. QBCore.Shared.RandomInt(4))
			}
		end
		if (totalWeight + (itemInfo["weight"] * amount)) <= QBCore.Config.Player.MaxWeight then
			if (slot ~= nil and self.PlayerData.items[slot] ~= nil) and (self.PlayerData.items[slot].name:lower() == item:lower()) and (itemInfo["type"] == "item" and not itemInfo["unique"]) then
				self.PlayerData.items[slot].amount = self.PlayerData.items[slot].amount + amount
				self.Functions.UpdatePlayerData()			
				--TriggerClientEvent('QBCore:Notify', self.PlayerData.source, itemInfo["label"].. " toegevoegd!", "success")
				--TriggerClientEvent('inventory:client:ItemBox', self.PlayerData.source, itemInfo, "add")
				return true
			elseif (not itemInfo["unique"] and slot or slot ~= nil and self.PlayerData.items[slot] == nil) then
				self.PlayerData.items[slot] = {name = itemInfo["name"], amount = amount, info = info ~= nil and info or "", label = itemInfo["label"], description = itemInfo["description"] ~= nil and itemInfo["description"] or "", weight = itemInfo["weight"], type = itemInfo["type"], unique = itemInfo["unique"], useable = itemInfo["useable"], image = itemInfo["name"]..".png", shouldClose = itemInfo["shouldClose"], slot = slot, combinable = itemInfo["combinable"]}
				self.Functions.UpdatePlayerData()
				--TriggerClientEvent('QBCore:Notify', self.PlayerData.source, itemInfo["label"].. " toegevoegd!", "success")
				--TriggerClientEvent('inventory:client:ItemBox', self.PlayerData.source, itemInfo, "add")
				return true
			elseif (itemInfo["unique"]) or (not slot or slot == nil) or (itemInfo["type"] == "weapon") then
				for i = 1, QBConfig.Player.MaxInvSlots, 1 do
					if self.PlayerData.items[i] == nil then
						self.PlayerData.items[i] = {name = itemInfo["name"], amount = amount, info = info ~= nil and info or "", label = itemInfo["label"], description = itemInfo["description"] ~= nil and itemInfo["description"] or "", weight = itemInfo["weight"], type = itemInfo["type"], unique = itemInfo["unique"], useable = itemInfo["useable"], image = itemInfo["name"]..".png", shouldClose = itemInfo["shouldClose"], slot = i, combinable = itemInfo["combinable"]}
						self.Functions.UpdatePlayerData()						
						--TriggerClientEvent('QBCore:Notify', self.PlayerData.source, itemInfo["label"].. " toegevoegd!", "success")
						--TriggerClientEvent('inventory:client:ItemBox', self.PlayerData.source, itemInfo, "add")
						return true
					end
				end
			end
		end
		return false
	end

	self.Functions.RemoveItem = function(item, amount, slot)
		local itemInfo = QBCore.Shared.Items[item:lower()]
		local amount = tonumber(amount)
		local slot = tonumber(slot)
		if slot ~= nil then
			if self.PlayerData.items[slot].amount > amount then
				self.PlayerData.items[slot].amount = self.PlayerData.items[slot].amount - amount
				self.Functions.UpdatePlayerData()
				--TriggerClientEvent('QBCore:Notify', self.PlayerData.source, itemInfo["label"].. " verwijderd!", "error")
				--TriggerClientEvent('inventory:client:ItemBox', self.PlayerData.source, itemInfo, "remove")
				return true
			elseif self.PlayerData.items[slot].amount == amount then
				self.PlayerData.items[slot] = nil
				self.Functions.UpdatePlayerData()
				--TriggerClientEvent('QBCore:Notify', self.PlayerData.source, itemInfo["label"].. " verwijderd!", "error")
				--TriggerClientEvent('inventory:client:ItemBox', self.PlayerData.source, itemInfo, "remove")
				return true
			else
				return false
			end
		else
			local slots = QBCore.Player.GetSlotsByItem(self.PlayerData.items, item)
			local amountToRemove = amount
			if slots ~= nil then
				for _, slot in pairs(slots) do
					if self.PlayerData.items[slot].amount > amountToRemove then
						self.PlayerData.items[slot].amount = self.PlayerData.items[slot].amount - amountToRemove
						self.Functions.UpdatePlayerData()
						
						--TriggerClientEvent('QBCore:Notify', self.PlayerData.source, itemInfo["label"].. " verwijderd!", "error")
						--TriggerClientEvent('inventory:client:ItemBox', self.PlayerData.source, itemInfo, "remove")
						return true
					elseif self.PlayerData.items[slot].amount == amountToRemove then
						self.PlayerData.items[slot] = nil
						self.Functions.UpdatePlayerData()
						--TriggerClientEvent('QBCore:Notify', self.PlayerData.source, itemInfo["label"].. " verwijderd!", "error")

						--TriggerClientEvent('inventory:client:ItemBox', self.PlayerData.source, itemInfo, "remove")
						return true
					else
						return false
					end
				end
			end
		end
		return false
	end

	self.Functions.SetInventory = function(items)
		self.PlayerData.items = items
		self.Functions.UpdatePlayerData()
	end

	self.Functions.ClearInventory = function()
		self.PlayerData.items = {}
		self.Functions.UpdatePlayerData()
	end

	self.Functions.GetItemByName = function(item)
		local item = tostring(item):lower()
		local slot = QBCore.Player.GetFirstSlotByItem(self.PlayerData.items, item)
		if slot ~= nil then
			return self.PlayerData.items[slot]
		end
		return {amount = 0}
	end

	self.Functions.GetItemsByName = function(item)
        local item = tostring(item):lower()
        local items = {}
        local slots = QBCore.Player.GetSlotsByItem(self.PlayerData.items, item)
        for _, slot in pairs(slots) do
            if slot then
                items[#items+1] = self.PlayerData.items[slot]
            end
        end
        return items
    end

    self.Functions.SetCreditCard = function(cardNumber)
        self.PlayerData.charinfo.card = cardNumber
        self.Functions.UpdatePlayerData()
    end

    self.Functions.GetCardSlot = function(cardNumber, cardType)
        local item = tostring(cardType):lower()
        local slots = QBCore.Player.GetSlotsByItem(self.PlayerData.items, item)
        for _, slot in pairs(slots) do
            if slot then
                if self.PlayerData.items[slot].info.cardNumber == cardNumber then
                    return slot
                end
            end
        end
        return nil
    end

	self.Functions.GetItemBySlot = function(slot)
		local slot = tonumber(slot)
		if self.PlayerData.items[slot] ~= nil then
			return self.PlayerData.items[slot]
		end
		return nil
	end

	self.Functions.Save = function()
		QBCore.Player.Save(self.PlayerData.source)
	end
	
	QBCore.Players[self.PlayerData.source] = self
	QBCore.Player.Save(self.PlayerData.source)
	self.Functions.UpdatePlayerData()
end

QBCore.Player.Save = function(source)
	local PlayerData = QBCore.Players[source].PlayerData
	if PlayerData ~= nil then
		QBCore.Functions.ExecuteSql(true, "SELECT * FROM `players` WHERE `citizenid` = '"..PlayerData.citizenid.."'", function(result)
			if result[1] == nil then
				QBCore.Functions.ExecuteSql(true, "INSERT INTO `players` (`citizenid`, `firstname`, `lastname`, `number`, `cid`, `steam`, `license`, `name`, `money`, `charinfo`, `job`, `position`, `metadata`, `jobname`, `tattoo`, `jobcd`, `aranma`, `obje`, `evjob`, `phone`) VALUES ('"..PlayerData.citizenid.."', '"..PlayerData.charinfo.firstname.."', '"..PlayerData.charinfo.lastname.."', '"..PlayerData.metadata["number"].."', '"..tonumber(PlayerData.cid).."', '"..PlayerData.steam.."', '"..PlayerData.license.."', '"..PlayerData.name.."', '"..json.encode(PlayerData.money).."', '"..json.encode(PlayerData.charinfo).."', '"..json.encode(PlayerData.job).."', '"..json.encode(PlayerData.position).."', '"..json.encode(PlayerData.metadata).."', '"..PlayerData.job.name.."', '"..json.encode(PlayerData.tattoo).."', '"..json.encode(PlayerData.jobcd).."', '"..json.encode(PlayerData.aranma).."', '"..json.encode(PlayerData.obje).."', '"..PlayerData.evjob.."', '"..PlayerData.phone.."')")
			else
				exports.oxmysql:execute("UPDATE players SET steam = @steam, firstname = @firstname, lastname= @lastname, number = @number, license = @license, name = @name, money = @money, charinfo = @charinfo, job = @job, position = @position, metadata = @metadata, jobname = @jobname, tattoo = @tattoo, jobcd = @jobcd, aranma = @aranma, obje = @obje, evjob = @evjob , phone = @phone WHERE citizenid = @citizenid", {
					["@steam"] = PlayerData.steam,
					["@firstname"] = PlayerData.charinfo.firstname,
					["@lastname"] = PlayerData.charinfo.lastname,
					["@number"] = PlayerData.metadata["number"],
					["@license"] = PlayerData.license,
					["@name"] = PlayerData.name,
					["@money"] = json.encode(PlayerData.money),
					["@charinfo"] = json.encode(PlayerData.charinfo),
					["@job"] = json.encode(PlayerData.job),
					["@position"] = json.encode(PlayerData.position),
					["@metadata"] = json.encode(PlayerData.metadata),
					["@jobname"] = PlayerData.job.name,
					["@tattoo"] = json.encode(PlayerData.tattoo),
					["@jobcd"] = json.encode(PlayerData.jobcd),
					["@aranma"] = json.encode(PlayerData.aranma),
					["@obje"] = json.encode(PlayerData.obje),
					["@evjob"] = PlayerData.evjob,
					["@citizenid"] = PlayerData.citizenid,
					["@phone"] = PlayerData.phone,
				})
			end
			QBCore.Player.SaveInventory(source)
		end)
		QBCore.ShowSuccess(GetCurrentResourceName(), PlayerData.name .." PLAYER SAVED!")
	else
		QBCore.ShowError(GetCurrentResourceName(), "ERROR QBCORE.PLAYER.SAVE - PLAYERDATA IS EMPTY!")
	end
end

QBCore.Player.Logout = function(source)
	TriggerClientEvent('QBCore:Client:OnPlayerUnload', source)
	TriggerClientEvent("QBCore:Player:UpdatePlayerData", source)
	Citizen.Wait(200)
	-- TriggerEvent('QBCore:Server:OnPlayerUnload')
	--QBCore.Players[source].Functions.Save()
	QBCore.Players[source] = nil
end

local playertables = {
    {table = "players"},
    {table = "apartments"},
    {table = "bank_accounts"},
    {table = "crypto_transactions"},
    {table = "phone_invoices"},
    {table = "phone_messages"},
    {table = "playerskins"},
    {table = "player_boats"},
    {table = "player_contacts"},
    {table = "player_houses"},
    {table = "player_mails"},
    {table = "player_outfits"},
    {table = "owned_vehicles"}
}

QBCore.Player.DeleteCharacter = function(source, citizenid)
	local cid = citizenid
	QBCore.Functions.ExecuteSql(true, "SELECT * FROM `players` WHERE `citizenid` = '"..cid.."'", function(data)
		local data = data[1]
		if data then
			TriggerEvent('DiscordBot:ToDiscord', 'karakterlog', cid..''..data.steam..' '..data.firstname..' '..data.lastname..' **Character Deleted**')
			QBCore.Functions.ExecuteSql(true, "DELETE FROM `players` WHERE `citizenid` = '"..cid.."'")
		end
	end)
end

QBCore.Player.LoadInventory = function(PlayerData)
	PlayerData.items = {}
	QBCore.Functions.ExecuteSql(true, "SELECT * FROM `playeritems` WHERE `citizenid` = '"..PlayerData.citizenid.."'", function(oldInventory)
		if oldInventory[1] ~= nil then
			for _, item in pairs(oldInventory) do
				if item ~= nil then
					local itemInfo = QBCore.Shared.Items[item.name:lower()]
					PlayerData.items[item.slot] = {name = itemInfo["name"], amount = item.amount, info = json.decode(item.info) ~= nil and json.decode(item.info) or "", label = itemInfo["label"], description = itemInfo["description"] ~= nil and itemInfo["description"] or "", weight = itemInfo["weight"], type = itemInfo["type"], unique = itemInfo["unique"], useable = itemInfo["useable"], image = itemInfo["name"]..".png", shouldClose = itemInfo["shouldClose"], slot = item.slot, combinable = itemInfo["combinable"]}
				end
				Citizen.Wait(1)
			end
			QBCore.Functions.ExecuteSql(true, "DELETE FROM `playeritems` WHERE `citizenid` = '"..PlayerData.citizenid.."'")
		else
			QBCore.Functions.ExecuteSql(true, "SELECT * FROM `players` WHERE `citizenid` = '"..PlayerData.citizenid.."'", function(result)
				if result[1] ~= nil then 
					if result[1].inventory ~= nil then
						plyInventory = json.decode(result[1].inventory)
						if next(plyInventory) ~= nil then 
							for _, item in pairs(plyInventory) do
								if item ~= nil then
									local itemInfo = QBCore.Shared.Items[item.name:lower()]
									PlayerData.items[item.slot] = {
										name = itemInfo["name"], 
										amount = item.amount, 
										info = item.info ~= nil and item.info or "", 
										label = itemInfo["label"], 
										description = itemInfo["description"] ~= nil and itemInfo["description"] or "", 
										weight = itemInfo["weight"], 
										type = itemInfo["type"], 
										unique = itemInfo["unique"], 
										useable = itemInfo["useable"], 
										image = itemInfo["name"]..".png", 
										shouldClose = itemInfo["shouldClose"], 
										slot = item.slot, 
										combinable = itemInfo["combinable"]
									}
								end
							end
						end
					end
				end
			end)
		end
	end)
	return PlayerData
end

QBCore.Player.SaveInventory = function(source)
	if QBCore.Players[source] ~= nil then 
		local PlayerData = QBCore.Players[source].PlayerData
		local items = PlayerData.items
		local ItemsJson = {}
		if items ~= nil and next(items) ~= nil then
			for slot, item in pairs(items) do
				if items[slot] ~= nil then
					table.insert(ItemsJson, {
						name = item.name,
						amount = item.amount,
						info = item.info,
						type = item.type,
						slot = slot,
					})
				end
			end
			QBCore.Functions.ExecuteSql(true, "UPDATE `players` SET `inventory` = '"..QBCore.EscapeSqli(json.encode(ItemsJson)).."' WHERE `citizenid` = '"..PlayerData.citizenid.."'")
		else
			QBCore.Functions.ExecuteSql(true, "UPDATE `players` SET `inventory` = '"..json.encode({}).."' WHERE `citizenid` = '"..PlayerData.citizenid.."'")
		end
	end
end

QBCore.Player.GetTotalWeight = function(items)
	local weight = 0
	if items ~= nil then
		for slot, item in pairs(items) do
			weight = weight + (item.weight * item.amount)
		end
	end
	return tonumber(weight)
end

QBCore.Player.GetSlotsByItem = function(items, itemName)
	local slotsFound = {}
	if items ~= nil then
		for slot, item in pairs(items) do
			if item.name:lower() == itemName:lower() then
				table.insert(slotsFound, slot)
			end
		end
	end
	return slotsFound
end

QBCore.Player.GetFirstSlotByItem = function(items, itemName)
	if items ~= nil then
		for slot, item in pairs(items) do
			if item.name:lower() == itemName:lower() then
				return tonumber(slot)
			end
		end
	end
	return nil
end

QBCore.Player.CreateCitizenId = function()
	local UniqueFound = false
	local CitizenId = nil

	while not UniqueFound do
		CitizenId = tostring("P".. QBCore.Shared.RandomStr(2) .. QBCore.Shared.RandomInt(5)):upper()
		QBCore.Functions.ExecuteSql(true, "SELECT COUNT(*) as count FROM `players` WHERE `citizenid` = '"..CitizenId.."'", function(result)
			if result[1].count == 0 then
				UniqueFound = true
			end
		end)
	end
	return CitizenId
end

QBCore.Player.CreateFingerId = function()
	local UniqueFound = false
	local FingerId = nil
	while not UniqueFound do
		FingerId = tostring(QBCore.Shared.RandomStr(2) .. QBCore.Shared.RandomInt(3) .. QBCore.Shared.RandomStr(1) .. QBCore.Shared.RandomInt(2) .. QBCore.Shared.RandomStr(3) .. QBCore.Shared.RandomInt(4))
		QBCore.Functions.ExecuteSql(true, "SELECT COUNT(*) as count FROM `players` WHERE `metadata` LIKE '%"..FingerId.."%'", function(result)
			if result[1].count == 0 then
				UniqueFound = true
			end
		end)
	end
	return FingerId
end

QBCore.Player.CreateSerialNumber = function()
    local UniqueFound = false
    local SerialNumber = nil

    while not UniqueFound do
        SerialNumber = math.random(11111111, 99999999)
        QBCore.Functions.ExecuteSql(true, "SELECT COUNT(*) as count FROM `players` WHERE `metadata` LIKE '%"..SerialNumber.."%'", function(result)
            if result[1].count == 0 then
                UniqueFound = true
            end
        end)
    end
    return SerialNumber
end

QBCore.EscapeSqli = function(str)
    local replacements = { ['"'] = '\\"', ["'"] = "\\'" }
    return str:gsub( "['\"]", replacements ) -- or string.gsub( source, "['\"]", replacements )
end