local aracPara = {arac = nil, para = 0}
local npcAraclar = {}
local hour = math.random(20,23)

QBCore = nil
TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)

QBCore.Functions.CreateCallback('ozelGuvenlik:time-control', function(source, cb)
	local clock = os.date("*t")
	if clock.hour == hour and clock.min < 20 then
		cb(true)
	else
		local xPlayer = QBCore.Functions.GetPlayer(source)
		TriggerClientEvent("QBCore:Notify", xPlayer.PlayerData.source, "You Can Make Delivery Today Evening Between ".. hour .. ":00 and " .. hour .. ":20!", "error")
		cb(false)
	end
end)

RegisterServerEvent('ozelGuvenlik:aracaParaKoy')
AddEventHandler('ozelGuvenlik:aracaParaKoy', function(para, GorevAraci, key)
	if QBCore.Functions.kickHacKer(source, key) then -- QBCore.Key
		aracPara.arac = GorevAraci
		if para > 0 then
			aracPara.para = aracPara.para + para
		else
			aracPara.para = 0
		end
	end
end)

RegisterServerEvent('tgiann-merryweather:server:soygun-engel')
AddEventHandler('tgiann-merryweather:server:soygun-engel', function(coords)
	TriggerClientEvent("tgiann-merryweather:client:soygun-engel", -1, coords)
end)

QBCore.Functions.CreateCallback('ozelGuvenlik:aractakiPara', function(source, cb)
	cb(aracPara)
end)

RegisterServerEvent('esx_guvenlik:item-ve-para')
AddEventHandler('esx_guvenlik:item-ve-para', function(arac, key)
	if QBCore.Functions.kickHacKer(source, key) then -- QBCore.Key
		local xPlayer = QBCore.Functions.GetPlayer(source)
		if xPlayer then
			npcAraclar[arac] = true
			local para = math.random(25000,35000)
			xPlayer.Functions.AddMoney("cash", para)
			if math.random(1, 100) < 25 then
				xPlayer.Functions.AddItem("siyah_kart", 1)
				TriggerClientEvent("QBCore:Notify", xPlayer.PlayerData.source, "Black Card Issued from Bank Vehicle")
				TriggerEvent('DiscordBot:ToDiscord', 'eventpara', 'Bank Car Robbery Black Card Released', source)
			end
			TriggerClientEvent("QBCore:Notify", xPlayer.PlayerData.source, "Output " .. para .. "$ from bank tool")
			TriggerEvent('DiscordBot:ToDiscord', 'eventpara', 'Bank Broker Robbery Give Money' .. para .. '$', source)
		end
	end
end)

QBCore.Functions.CreateCallback('ozelGuvenlik:npc-soyuldumu', function(source, cb, arac, control)
	if npcAraclar[arac] then
		cb(false)
	else
		if control then
			if not exports["elixir-base"]:soygunKontrol(source) then 
				return 
			end
			local xPlayer = QBCore.Functions.GetPlayer(source)
			xPlayer.Functions.RemoveItem("sari_kart", 1)
		end
		cb(true)
	end
end)

QBCore.Functions.CreateUseableItem("sari_kart", function(source, item)
	local xPlayer = QBCore.Functions.GetPlayer(source)
	if xPlayer.PlayerData.job.name == "police" or xPlayer.PlayerData.job.name == "ambulance" or xPlayer.PlayerData.job.name == "mafia" then
		TriggerClientEvent("QBCore:Notify", source, "Look What You Used Now!", "error")
	else
		if xPlayer.Functions.GetItemByName("sari_kart").amount > 0 then
			TriggerClientEvent("tgiann-merryweather:para-araci", source)
		else
			TriggerClientEvent("QBCore:Notify", source, "Need 1 One Yellow Card", "error")
		end
	end
end)

local weaponType = {
	["pistol"] = {
		[1] = {
			["item"] = "islenmis_demir",
			["count"] = 45
		},
	},

	["smg"] = {
		[1] = {
			["item"] = "islenmis_demir",
			["count"] = 100
		},
	},

	["taarruz"] = {
		[1] = {
			["item"] = "islenmis_demir",
			["count"] = 150
		},
	},

	["pomba"] = {
		[1] = {
			["item"] = "petrol_raffin",
			["count"] = 5
		},
		[2] = {
			["item"] = "islenmis_demir",
			["count"] = 200
		},
		[3] = {
			["item"] = "islenmis_altin",
			["count"] = 200
		},
		[4] = {
			["item"] = "plastik",
			["count"] = 10
		}
	},
	
	["diger"] = {
		[1] = {
			["item"] = "islenmis_demir",
			["count"] = 20
		}
	}
}

local weapons = {
	["pistol"] = {
		"weapon_pistol", "weapon_glock", "weapon_pistol_mk2", "weapon_combatpistol", "weapon_pistol50", "weapon_snspistol", "weapon_heavypistol", "weapon_vintagepistol", "weapon_appistol", "weapon_stungun", "weapon_revolver", "weapon_doubleaction"
	},
	["smg"] = {
		"weapon_microsmg", "weapon_smg", "weapon_smg_mk2", "weapon_combatpdw", "weapon_machinepistol", "weapon_minismg", "weapon_assaultsmg"
	},
	["taarruz"] = {
		"weapon_assaultrifle", "weapon_assaultrifle_mk2", "weapon_carbinerifle", "weapon_carbinerifle_mk2", "weapon_advancedrifle", "weapon_specialcarbine", "weapon_compactrifle"
	},
	["pomba"] = {
		"weapon_pumpshotgun", "weapon_sawnoffshotgun", "weapon_assaultshotgun", "weapon_bullpupshotgun", "weapon_heavyshotgun", "weapon_dbshotgun", "weapon_autoshotgun"
	},
	["diger"] = {
		"weapon_dagger", "weapon_bat", "weapon_bottle", "weapon_crowbar", "weapon_flashlight", "weapon_hammer", "weapon_hatchet0", "weapon_knuckle", "weapon_knife", "weapon_machete", "weapon_switchblade", "weapon_nightstick", "weapon_wrench", "weapon_battleaxe"
	},
}

RegisterServerEvent('tgiann-merrtweather:repair-weapon')
AddEventHandler('tgiann-merrtweather:repair-weapon', function(type, police)
	--if QBCore.Functions.kickHacKer(source, key) then
		local xPlayer = QBCore.Functions.GetPlayer(source)
		if not police then
			local requestItem = ""
			local requestItemCount = 7
			for type, item in pairs(weaponType[type]) do
				requestItemCount = xPlayer.Functions.GetItemByName(item["item"]).amount
				requestItem = requestItem .. " ".. item["count"] .. " Tane " .. QBCore.Shared.Items[item["item"]].label
			end

			if type == "pistol" then
				gerekenmiktar = 45
			elseif type == "smg" then
				gerekenmiktar = 100
			elseif type == "taarruz" then
				gerekenmiktar = 150
			elseif type == "diger" then
				gerekenmiktar = 20
			end

			if requestItemCount < gerekenmiktar then 
				TriggerClientEvent("QBCore:Notify", xPlayer.PlayerData.source, "I Need To Repair This Weapon ".. requestItem , "error", 20000)
			else
				local found = false
				for i=1, #weapons[type] do
					local weapon = xPlayer.Functions.GetItemByName(weapons[type][i])
					--if weapon.amount > 500 then
						weapon.info.durubality = os.time()
						if xPlayer.Functions.RemoveItem(weapon.name, 1, weapon.slot, xPlayer.Functions.GetItemByName(weapon.name).slot) then
							xPlayer.Functions.AddItem(weapon.name, 1, weapon.slot, weapon.info)
							for type, item in pairs(weaponType[type]) do
								xPlayer.Functions.RemoveItem(item["item"], item["count"], xPlayer.Functions.GetItemByName(item["item"]).slot)
							end

							found = true
						end
						TriggerClientEvent("QBCore:Notify", xPlayer.PlayerData.source, weapon.slot.. ". The Gun in the Slot Has Been Repaired!", "success")
						
						break
					--end
				end

				if not found then
					TriggerClientEvent("QBCore:Notify", xPlayer.PlayerData.source, "There Is No Weapon On It That Can Repair", "error")
				end
			end
		elseif police then 
			for i=1, #weapons[type] do
				local weapon = xPlayer.Functions.GetItemByName(weapons[type][i])
				if weapon.amount > 0 then
					weapon.info.durubality = os.time()
					if xPlayer.Functions.RemoveItem(weapon.name, 1, weapon.slot) then
						xPlayer.Functions.AddItem(weapon.name, 1, weapon.slot, weapon.info)
					end
					TriggerClientEvent("QBCore:Notify", xPlayer.PlayerData.source, weapon.slot.. ". Weapon in Slot Repaired!", "success")
					break
				end
			end
		end
	
	--end
end)

QBCore.Commands.Add("merryclock", "Set Money Tool Handling Time", {{name="hour", help="Change Time to Move"}}, false, function(source, args) -- name, help, arguments, argsrequired,  end sonuna persmission
	hour = tonumber(args[1])
end, "admin")

RegisterServerEvent('tgiann-merrtweather:repair-weapon-oil')
AddEventHandler('tgiann-merrtweather:repair-weapon-oil', function(name, key)
	if QBCore.Functions.kickHacKer(source, key) then
		local xPlayer = QBCore.Functions.GetPlayer(source)
		if xPlayer.Functions.RemoveItem("yag", 1, xPlayer.Functions.GetItemByName("yag").slot) then
			local weapon = xPlayer.Functions.GetItemByName(name)
			if weapon.amount > 0 then
				weapon.info.durubality = weapon.info.durubality + 172800
				if xPlayer.Functions.RemoveItem(weapon.name, 1, weapon.slot) then
					xPlayer.Functions.AddItem(weapon.name, 1, weapon.slot, weapon.info)
				end
				TriggerClientEvent("QBCore:Notify", xPlayer.PlayerData.source, "Weapon Enhanced", "success")
			end
		end
	end
end)

local weaponTypeForSerial = {
	-- İllegal Silahları
    ["weapon_pistol"] = {
		["name"] = "madde_x",
		["count"] = 4
	},
	["weapon_heavypistol"] = {
		["name"] = "madde_x",
		["count"] = 6
	},
	["weapon_smg_mk2"] = {
		["name"] = "madde_x",
		["count"] = 12
	},
	["weapon_assaultrifle"] = {
		["name"] = "madde_x",
		["count"] = 18
	},
}

RegisterServerEvent('tgiann-merrtweather:change-weapon-serial')
AddEventHandler('tgiann-merrtweather:change-weapon-serial', function(name, key)
	if QBCore.Functions.kickHacKer(source, key) then
		local xPlayer = QBCore.Functions.GetPlayer(source)
		local weapon = xPlayer.Functions.GetItemByName(name)
		if weapon.amount > 0 then
			local item = weaponTypeForSerial[name]
			if item then
				if xPlayer.Functions.RemoveItem(item["name"], item["count"]) then
					weapon.info.serie = math.random(1,9).."T"..math.random(10,99).."GI"..math.random(100,999).."A"..math.random(1,9).."NN"..math.random(10,50)
					if xPlayer.Functions.RemoveItem(weapon.name, 1, weapon.slot) then
						xPlayer.Functions.AddItem(weapon.name, 1, weapon.slot, weapon.info)
					end
					TriggerClientEvent("QBCore:Notify", xPlayer.PlayerData.source, "Serial Number Changed!", "success")
				else
					TriggerClientEvent("QBCore:Notify", xPlayer.PlayerData.source, "For this process ".. item["count"] .. " Need Grain Substance-X!", "error")
				end
			else
				TriggerClientEvent("QBCore:Notify", xPlayer.PlayerData.source, "The Serial Number of This Gun Cannot Be Changed!", "error")
			end
		end
	end
end)