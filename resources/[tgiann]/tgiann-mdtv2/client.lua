local QBCore = exports['qb-core']:GetCoreObject()

local coreLoaded = false
local nuiFocus = false
local active = false
local tab = 0
coreLoaded = true

local PlayerData = {}

RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    firstLogin()
end)

RegisterNetEvent('QBCore:Client:OnJobUpdate')
AddEventHandler('QBCore:Client:OnJobUpdate', function(job)
    firstLogin()
end)

function firstLogin()
    PlayerData = QBCore.Functions.GetPlayerData()
    if PlayerData.job.name == "police" then
        local firstData = {}
        firstData.name = PlayerData.charinfo.firstname .. " " .. PlayerData.charinfo.lastname
        firstData.rank = QBCore.Shared.Jobs["police"]["grade"][PlayerData.job.grade].label
        firstData.items = {}
        for item, data in pairs(QBCore.Shared.Items) do
            table.insert(firstData.items, data.label)
        end
        QBCore.Functions.TriggerCallback("tgiann-mdtv2:ilk-data", function(result)
            firstData.players = result
            SendNUIMessage({type = 'ilk-bilgi', data = firstData})
        end)
    end
end

RegisterNUICallback('sorgula', function(data, cb)
    local sorguData = nil
    QBCore.Functions.TriggerCallback("tgiann-mdtv2:sorgula", function(result)
        sorguData = result

        while sorguData == nil do Citizen.Wait(0) end
        cb(sorguData)
    end, data)   
end)

RegisterNUICallback('cezakaydetclient', function(data)
    TriggerServerEvent("tgiann-mdtv2:ceza-kaydet", data.data)
end)

local olaylarDataLast = nil
local olaylarDataTime = 0
RegisterNUICallback('olaylardata', function(data, cb)
    -- if GetGameTimer() > olaylarDataTime or olaylarDataTime == 0 then
        olaylarDataTime = GetGameTimer() + 30000
        QBCore.Functions.TriggerCallback("tgiann-mdtv2:olaylardata", function(result)
            olaylarDataLast = result
            cb(result)
        end)
    -- else
    --     cb(olaylarDataLast)
    -- end
end)

local sabikaDataLast = nil
local sabikaDataTime = 0
RegisterNUICallback('sabikadata', function(data, cb)
    if GetGameTimer() > sabikaDataTime or sabikaDataTime == 0 then
        sabikaDataTime = GetGameTimer() + 30000
        QBCore.Functions.TriggerCallback("tgiann-mdtv2:sabikadata", function(result)
            sabikaDataLast = result
            cb(result)
        end, data.id)
    else
        cb(sabikaDataLast)
    end
end)

RegisterNUICallback('sabikasil', function(data, cb)
    TriggerServerEvent("tgiann-mdtv2:sabikasil", data.id)
end)


RegisterNUICallback('resim', function(data, cb)
    if data.url then
        TriggerServerEvent("tgiann-mdtv2:setavatar", data.url, data.id)
    else
        CreateMobilePhone(1)
        CellCamActivate(true, true)
        takePhoto = true
        if nuiFocus then openClose() end
        while takePhoto do
            Citizen.Wait(0)
            if IsControlJustPressed(1, 177) then
                DestroyMobilePhone()
                CellCamActivate(false, false)
                takePhoto = false
            elseif IsControlJustPressed(1, 176) then
                local url = exports['elixir-base']:screenShot()
                if url then
                    SendNUIMessage({type = 'user-avatar', url = url})
                    TriggerServerEvent("tgiann-mdtv2:setavatar", url, data.id)
                else
                    QBCore.Functions.Notify("No Picture Taken!", "error")
                end
                openClose()
                DestroyMobilePhone()
                CellCamActivate(false, false)
                takePhoto = false
            end
            HideHudComponentThisFrame(7)
            HideHudComponentThisFrame(8)
            HideHudComponentThisFrame(9)
            HideHudComponentThisFrame(6)
            HideHudComponentThisFrame(19)
            HideHudAndRadarThisFrame()
        end
    end
end)
function openClose()
    nuiFocus = not nuiFocus
    SetNuiFocus(nuiFocus, nuiFocus)
    if nuiFocus then
        startAnim()
        SendNUIMessage({type = 'open'})
    else
        stopAnim()
        SendNUIMessage({type = 'close'})
    end
end

function stopAnim()
	StopAnimTask(PlayerPedId(), "amb@code_human_in_bus_passenger_idles@female@tablet@idle_a", "idle_a" ,8.0, -8.0, -1, 50, 0, false, false, false)
	DeleteObject(tab)
end

function startAnim()
    RequestAnimDict("amb@code_human_in_bus_passenger_idles@female@tablet@idle_a")
    while not HasAnimDictLoaded("amb@code_human_in_bus_passenger_idles@female@tablet@idle_a") do
        Citizen.Wait(0)
    end
    TaskPlayAnim(PlayerPedId(), "amb@code_human_in_bus_passenger_idles@female@tablet@idle_a", "idle_a" ,8.0, -8.0, -1, 50, 0, false, false, false)
    tab = CreateObject(`prop_cs_tablet`, 0, 0, 0, true, true, true)
	AttachEntityToEntity(tab, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 28422), -0.05, 0.0, 0.0, 0.0, 0.0, 0.0, true, true, false, true, 1, true)
end

RegisterNUICallback('aranma', function(data, cb)
    TriggerServerEvent("tgiann-mdtv2:aranma", data, true)
end)

RegisterNUICallback('aranmakaldir', function(data, cb)
    TriggerServerEvent("tgiann-mdtv2:aranma", data, false)
end)

RegisterNUICallback('arananlar', function(data, cb)
    QBCore.Functions.TriggerCallback("tgiann-mdtv2:arananlar", function(result)
        cb(result)
    end)
end)

RegisterNUICallback('ev', function(data, cb)
    QBCore.Functions.TriggerCallback("tgiann-mdtv2:ev", function(result)
        cb(result)
    end,data.id)
end)

RegisterNUICallback('olaysil', function(data, cb)
    TriggerServerEvent("tgiann-mdtv2:olaysil", data.id)
end)

RegisterNetEvent('tgiann-denizalti:emp')
AddEventHandler('tgiann-denizalti:emp', function(_active)
	active = _active
	if active then
        if nuiFocus then
            openClose()
        end
  	end
end)

RegisterNetEvent("tgiann-mdtv2:open")
AddEventHandler("tgiann-mdtv2:open", function()
    if PlayerData.job == nil then firstLogin() end
	if PlayerData.job and PlayerData.job.name == "police"  then
		if not active then
			openClose()
		else
			QBCore.Functions.Notify("You Can't Use the Tablet Right Now!", "error")
		end
	end
end)

RegisterNUICallback('kapat', function(data, cb)
    if nuiFocus then openClose() end
end)

RegisterNUICallback('carbodycam', function(data, cb)
    if nuiFocus then openClose() end
    TriggerEvent("rp_interact:client:PoliceDashCams")
end)

RegisterNUICallback("bodycam", function()
    local PlayerData = QBCore.Functions.GetPlayerData()
    if nuiFocus then openClose() end
    TriggerServerEvent("open:bodycam", PlayerData.job.name)
end)

RegisterNUICallback("pkam", function()
    local PlayerData = QBCore.Functions.GetPlayerData()
    if nuiFocus then openClose() end
    TriggerEvent("pkam")
end)


AddEventHandler('onResourceStop', function(resourceName)
    if (GetCurrentResourceName() == resourceName) then
        if nuiFocus then openClose() end
    end
end)

RegisterNUICallback('cadir-r', function(data, cb)
    if exports["tgiann-ev"]:cadirRaid(data.id) then
        if nuiFocus then openClose() end
    else
        SendNUIMessage({type = 'bildirim', msg = "You Must Be in the Tent Area!", durum = 'hata'})
    end
end)

RegisterNUICallback('motel-r', function(data, cb)
    if exports["tgiann-motels"]:motelRaid(data.id) then
        if nuiFocus then openClose() end
    else
        SendNUIMessage({type = 'bildirim', msg = "You Should Be Inside the Motel Room!", durum = 'hata'})
    end
end)

RegisterNUICallback('ev-r', function(data, cb)
    if exports["tgiann-ev"]:evRaid(data.ev) then
        if nuiFocus then openClose() end
    else
        SendNUIMessage({type = 'bildirim', msg = "You Need To Be Near Home!", durum = 'hata'})
    end
end)

RegisterNUICallback('olayara', function(data, cb)
    QBCore.Functions.TriggerCallback("tgiann-mdtv2:olayara", function(result)
        cb(result)
    end, data.id)
end)

RegisterNetEvent("tgiann-mdtv2:zoom")
AddEventHandler("tgiann-mdtv2:zoom", function(data)
    if PlayerData.job and PlayerData.job.name == "police"  then
        if data == nil then
            QBCore.Functions.Notify("You Didn't Enter a Value! (50-100)", "error")
        end

        if tonumber(data) < 50 then
            QBCore.Functions.Notify("You cannot enter a value less than 50", "error")
        elseif tonumber(data) > 100 then
            QBCore.Functions.Notify("You cannot enter a value greater than 100", "error")
        else
            QBCore.Functions.Notify("Tablet Size Adjusted", "success")
            SendNUIMessage({type = 'zoom', val = data})
        end
    end
end)