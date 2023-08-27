local PlayerData = {}
local radioProp = nil
local radioMenu = false
local isDead = false
local active = false

QBCore = nil
Citizen.CreateThread(function()
    while QBCore == nil do
        TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)
        Citizen.Wait(200)
	end
end)

RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    PlayerData = QBCore.Functions.GetPlayerData()
end)

RegisterNetEvent('QBCore:Client:OnJobUpdate')
AddEventHandler('QBCore:Client:OnJobUpdate', function(job)
    PlayerData.job = job
end)


AddEventHandler('tgiann:playerdead', function(dead)
	isDead = dead
	if isDead then
		radioLeave(false)
	end
end)

RegisterNetEvent('ra1derRadio:use')
AddEventHandler('ra1derRadio:use', function()
  	enableRadio(true)
end)

RegisterNetEvent('qb-radio:onRadioDrop')
AddEventHandler('qb-radio:onRadioDrop', function()
	radioLeave(true)
end)

RegisterNetEvent("ra1derRadio:t")
AddEventHandler("ra1derRadio:t", function(args)
	joinRadioChannel(false, QBCore.Shared.Round(tonumber(args)))
end)

RegisterNetEvent("ra1derRadio:tk")
AddEventHandler("ra1derRadio:tk", function()
	radioLeave(false)
end)

RegisterNUICallback('joinRadio', function(data)
	joinRadioChannel(true, tonumber(data.channel))
	SetNuiFocus(false, false)
end)

function joinRadioChannel(walkie, channelData)
	if not active then
		if not isDead then
			local channel = channelData
			local playerInRadioChannel = exports["saltychat"]:GetRadioChannel()
			local haveItem = false
			if walkie then
				haveItem = true
			else
				if channelData == nil then
					QBCore.Functions.Notify("Lütfen Gireceğiniz Frekansını Yazınız", "error")
					return
				elseif channelData < 1 then
					QBCore.Functions.Notify("Sıfır Nolu Frekansa Bağlanamazsın!", "error")
					return
				elseif channelData > 999 then
					QBCore.Functions.Notify("Böyle Bir Frekans Yok!", "error")
					return
				end

				local waitSync = true
				QBCore.Functions.TriggerCallback('elixir-base:item-kontrol', function(qtty)
					if qtty > 0 then
						haveItem = true
					end
					waitSync = false
				end, 'radio')
				while waitSync do
					Citizen.Wait(100)
				end
			end

			if haveItem then
				if tonumber(playerInRadioChannel) == channel then
					QBCore.Functions.Notify("Zaten " ..channel.. " MHz Kanalındasın!", "error")
					enableRadio(false)
				else
					if channel <= 5 then -- Özel Kanallar
						if PlayerData.job and PlayerData.job.name == 'police' or PlayerData.job.name == 'ambulance' or PlayerData.job.name == 'doj' then
							setPlayerRadioChannel(channel, walkie)
						elseif not (PlayerData.job and PlayerData.job.name == 'police' or PlayerData.job.name == 'ambulance') then
							QBCore.Functions.Notify("Şifreli Kanala Bağlanamazsın!", "error")
						end
					else
						setPlayerRadioChannel(channel, walkie)
					end
				end
			else
				QBCore.Functions.Notify("Üzerinde Telsiz Yok!", "error")
			end
		else
			QBCore.Functions.Notify("Ölü İken Telsize Bağlanamazsın!", "error")
		end
	else
		QBCore.Functions.Notify("Şuan Telsize Bağlanamazsın!", "error")
	end
end

function setPlayerRadioChannel(channel, walkie)
	if not walkie then tAnim() end
--[[ 	local playerInRadioChannel = exports["saltychat"]:GetRadioChannel()
	if playerInRadioChannel ~= nil and tonumber(playerInRadioChannel) > 0 then 
		TriggerServerEvent("ra1derRadio:remove-channel", playerInRadioChannel)
	end ]]
	TriggerServerEvent("ra1derRadio:set-channel", channel, false)
	exports["saltychat"]:SetRadioChannel(tostring(channel), false)
	enableRadio(false)
	SetNuiFocus(false, false)
end

RegisterNUICallback('leaveRadio', function(data)
	radioLeave(true)
end)

function radioLeave(walkie)
	local channel = channelData
	local playerInRadioChannel = exports["saltychat"]:GetRadioChannel()
	local haveItem = false
	if walkie then
		haveItem = true
	else
		local waitSync = true
		QBCore.Functions.TriggerCallback('elixir-base:item-kontrol', function(qtty)
			if qtty > 0 then
				haveItem = true
			end
			waitSync = false
		end, 'radio')
		while waitSync do
			Citizen.Wait(100)
		end
	end
	if haveItem then
		PlaySound(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
		if playerInRadioChannel == nil or tonumber(playerInRadioChannel) == 0 then
			QBCore.Functions.Notify(Config.messages['not_on_radio'])
		else
			TriggerServerEvent("ra1derRadio:remove-channel", playerInRadioChannel)
		end
	else
		QBCore.Functions.Notify("Üzerinde Telsiz Yok!")
	end
end

RegisterNUICallback('escape', function(data)
	enableRadio(false)
	SetNuiFocus(false, false)
end)

function enableRadio(enable)
	PlayerData = QBCore.Functions.GetPlayerData()
	local ped = PlayerPedId()
	if enable then
		QBCore.Shared.RequestAnimDict("cellphone@", function() -- animasyon oynatma
			TaskPlayAnim(ped, "cellphone@", "cellphone_text_read_base", 3.0, 3.0, -1, 49, 0, false, false, false)
		end)
		if not HasModelLoaded("prop_cs_hand_radio") then
			loadPropDict("prop_cs_hand_radio")
		end
		radioProp = CreateObject(`prop_cs_hand_radio`, 1.0, 1.0, 1.0, 1, 1, 0)
		AttachEntityToEntity(radioProp, PlayerPedId(), GetPedBoneIndex(ped, 57005), 0.14, 0.01, -0.02, 110.0, 120.0, -15.0, 1, 0, 0, 0, 2, 1)
		SetModelAsNoLongerNeeded("prop_cs_hand_radio")
	else
		ClearPedTasks(ped)
		DeleteEntity(radioProp)
		radioProp = nil
	end

	SetNuiFocus(true, true)
	radioMenu = enable
	SendNUIMessage({enable = enable})
	TriggerEvent('phone:open', enable)

	while radioMenu do
		if not radioMenu then break end
		DisableControlAction(0, 1, guiEnabled) -- LookLeftRight
		DisableControlAction(0, 2, guiEnabled) -- LookUpDown
		DisableControlAction(0, 142, guiEnabled) -- MeleeAttackAlternate
		DisableControlAction(0, 106, guiEnabled) -- VehicleMouseControlOverride
		Citizen.Wait(0)
	end
end

function tAnim()
	local ped = PlayerPedId()
	QBCore.Shared.RequestAnimDict("cellphone@", function() -- animasyon oynatma
		TaskPlayAnim(PlayerPedId(), "cellphone@", "cellphone_text_read_base", 3.0, 3.0, -1, 49, 0, false, false, false)
	end)

	if not HasModelLoaded("prop_cs_hand_radio") then
		loadPropDict("prop_cs_hand_radio")
	end
	radioProp = CreateObject(`prop_cs_hand_radio`, 1.0, 1.0, 1.0, 1, 1, 0)
	AttachEntityToEntity(radioProp, PlayerPedId(), GetPedBoneIndex(ped, 57005), 0.14, 0.01, -0.02, 110.0, 120.0, -15.0, 1, 0, 0, 0, 2, 1)
	SetModelAsNoLongerNeeded("prop_cs_hand_radio")
	Citizen.Wait(3000)
	ClearPedTasks(ped)
	DeleteEntity(radioProp)
	radioProp = nil
end

function loadPropDict(model)
	RequestModel(GetHashKey(model))
	while not HasModelLoaded(GetHashKey(model)) do
		Citizen.Wait(500)
	end
end

local radioVolume = 100
RegisterNUICallback('sesac', function(data, cb)
	PlaySound(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
	radioVolume = radioVolume + 5
	if radioVolume > 160 then radioVolume = 160 end
	 exports["saltychat"]:SetRadioVolume(radioVolume/100)
	--QBCore.Functions.Notify("Ses Seviyesi: "..radioVolume.."%")
	SendNUIMessage({volume = 'updatevolume', level = radioVolume })
end)

RegisterNUICallback('seskis', function(data, cb)
	PlaySound(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
	radioVolume = radioVolume - 5
	if radioVolume < 10 then radioVolume = 10 end
	 exports["saltychat"]:SetRadioVolume(radioVolume/100)
	--QBCore.Functions.Notify("Ses Seviyesi: "..radioVolume.."%")
	SendNUIMessage({volume = 'updatevolume', level = radioVolume })
end)

