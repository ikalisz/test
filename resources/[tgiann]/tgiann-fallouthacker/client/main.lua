local BildirimsSansi = 25
local HackManuAc = false

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

RegisterNetEvent('tgiann-fallouthacker:hack-menu-ac')
AddEventHandler('tgiann-fallouthacker:hack-menu-ac', function()
	hackMenuAc()
end)

RegisterNetEvent('tgiann-fallouthacker:hack-menu-kapat')
AddEventHandler('tgiann-fallouthacker:hack-menu-kapat', function()
	SetNuiFocus(false, false)
	BildirimsSansi = 25
	HackManuAc = false
	SendNUIMessage({menu = 'close'})
end)

function hackMenuAc()
	SendNUIMessage({menu = 'open'})
	SetNuiFocus(true, true)
	HackManuAc = true
end

RegisterNUICallback('MenuKapat', function(data)
	if data.basarili then
		TriggerServerEvent('tgiann-hacker:hackparasi', 50, QBCore.Key)
	elseif not data.basarili then
		QBCore.Functions.Notify("Hack Failed")	
	end
	SetNuiFocus(false, false)
	BildirimsSansi = 25
	HackManuAc = false
	TriggerEvent("tgiann-hacker:police-alert", "Terminal")
	Citizen.Wait(25000)
	TriggerEvent("tgiann-hacker:police-alert", "Terminal")
end)

RegisterNUICallback('MenuKapatv2', function()
	SetNuiFocus(false, false)
	BildirimsSansi = 25
	HackManuAc = false
end)

RegisterNUICallback('bildirim', function()
	BildirimsSansi = BildirimsSansi + 25
	if math.random(1, 100) > 100 - BildirimsSansi then
		TriggerEvent("tgiann-hacker:police-alert", "Terminal")
	end
end)

AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		SetNuiFocus(false, false)
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		if HackManuAc and (IsControlJustPressed(0, 177) or IsControlJustPressed(0, 214) or IsControlJustPressed(0, 49)) then
			HackManuAc = false
			SendNUIMessage({menu = 'open'})
			SetNuiFocus(false, false)
		end
	end
end)