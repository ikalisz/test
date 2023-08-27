local CurrentTest       = nil
local EhliyetTipi = nil

QBCore = nil
Citizen.CreateThread(function()
    while QBCore == nil do
        TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)
        Citizen.Wait(200)
	end
end)

RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
	local PlayerData = QBCore.Functions.GetPlayerData()
	ownedLicenses = PlayerData.metadata.licences
end)

function DrawMissionText(msg, time)
	ClearPrints()
	BeginTextCommandPrint('STRING')
	AddTextComponentSubstringPlayerName(msg)
	EndTextCommandPrint(time, true)
end

function StartTheoryTest(tip, money)
	CurrentTest = 'theory'
	EhliyetTipi = tip
	SendNUIMessage({openQuestion = true})

	QBCore.SetTimeout(200, function()
		SetNuiFocus(true, true)
	end)
	TriggerServerEvent('esx_dmvschool:pay',money)
end

function StopTheoryTest(success)
	CurrentTest = nil
	SendNUIMessage({openQuestion = false})

	SetNuiFocus(false)
	if success then
		TriggerServerEvent('esx_dmvschool:addLicense', EhliyetTipi, QBCore.Key)
	else
		QBCore.Functions.Notify("You failed the test maybe next time!")
	end
end

function OpenDMVSchoolMenu()
	local elements = {}

	if not ownedLicenses['drive'] then
		table.insert(elements, {
			label = (('%s: <span style="color:green;">%s</span>'):format("Driving Exam", "$".. QBCore.Shared.GroupDigits(Config.Prices['drive']))),
			money = Config.Prices['drive'],
			type = 'drive'
		})
	end

	if not ownedLicenses['drive_bike'] then
		table.insert(elements, {
			label = (('%s: <span style="color:green;">%s</span>'):format("Motorcycle Exam", "$".. QBCore.Shared.GroupDigits(Config.Prices['drive_bike']))),
			money = Config.Prices['drive_bike'],
			type = 'drive_bike'
		})
	end

	if not ownedLicenses['drive_truck'] then
		table.insert(elements, {
			label = (('%s: <span style="color:green;">%s</span>'):format("Pickup Truck Exam", "$".. QBCore.Shared.GroupDigits(Config.Prices['drive_truck']))),
			money = Config.Prices['drive_truck'],
			type = 'drive_truck'
		})
	end

	QBCore.UI.Menu.CloseAll()

	QBCore.UI.Menu.Open('default', GetCurrentResourceName(), 'dmvschool_actions', {
		title    = "Driving School",
		elements = elements,
		align    = 'top-left'
	}, function(data, menu)
		menu.close()
		StartTheoryTest(data.current.type, data.current.money)

	end, function(data, menu)
		menu.close()
	end)
end

RegisterNUICallback('question', function(data, cb)
	SendNUIMessage({openSection = 'question'})
	cb()
end)

RegisterNUICallback('close', function(data, cb)
	StopTheoryTest(true)
	cb()
end)

RegisterNUICallback('kick', function(data, cb)
	StopTheoryTest(false)
	cb()
end)

RegisterNetEvent('esx_dmvschool:loadLicenses')
AddEventHandler('esx_dmvschool:loadLicenses', function(licenses)
	ownedLicenses = licenses
end)

RegisterNetEvent('dmvschollKeybindGeneral')
AddEventHandler('dmvschollKeybindGeneral', function(licenses)
	if #(Config.DMVSchoolPos - GetEntityCoords(PlayerPedId())) < 5 then
		OpenDMVSchoolMenu()
	end
end)

-- Create Blips
Citizen.CreateThread(function()
	local blip = AddBlipForCoord(Config.DMVSchoolPos.x, Config.DMVSchoolPos.y, Config.DMVSchoolPos.z)

	SetBlipSprite (blip, 498)
	SetBlipDisplay(blip, 4)
	SetBlipScale  (blip, 0.5)
	SetBlipAsShortRange(blip, true)

	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("Driving School")
	EndTextCommandSetBlipName(blip)
end)

-- Display markers
Citizen.CreateThread(function()
	exports["elixir-base"]:addNotif("E", "Driving School", 4, 2, vector3(Config.DMVSchoolPos.x, Config.DMVSchoolPos.y, Config.DMVSchoolPos.z))
end)