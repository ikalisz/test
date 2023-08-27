QBCore = exports['qb-core']:GetCoreObject()
local sekil, notifyikon = "kare","ikonsuz"

RegisterNetEvent("progressbar:sekildegistir", function(progsekil)
    sekil = progsekil
    if sekil == "kare" then 
        QBCore.Functions.Notify('Changed Progressbar to Square', 'primary', 7500)
    elseif sekil == "yuvarlak" then 
        QBCore.Functions.Notify('Changed Progressbar to Round', 'primary', 7500)
    end
end)
RegisterNetEvent("notify:sekildegistir", function(notsekil)
    notifyikon = notsekil
    if notifyikon == "ikonsuz" then 
        QBCore.Functions.Notify('Notify Changed To Iconless', 'primary', 7500)
    elseif notifyikon == "ikonlu" then 
        QBCore.Functions.Notify('Changed to Notify Icon', 'primary', 7500)
    end
end)

RegisterNetEvent("QBCore:Client:OnPlayerLoaded", function()
    Wait(2000)
    local hudSettings = GetResourceKvpString('hudSettings')
    if hudSettings then loadSettings(json.decode(hudSettings)) end
end)

AddEventHandler('onResourceStart', function(resourceName)
    if GetCurrentResourceName() ~= resourceName then return end
    Wait(2000)
    local hudSettings = GetResourceKvpString('hudSettings')
    if hudSettings then loadSettings(json.decode(hudSettings)) end
end)

local function loadSettings(settings)
    local yapildi = 0
    for k,v in pairs(settings) do
        if k == 'isToggleProgbarShapeChecked' then 
            sekil = v
            yapildi = yapildi + 1
        elseif k == "isToggleNotifyShapeChecked" then
            notifyikon = v
            yapildi = yapildi + 1
        end
        if yapildi == 2 then
            break
        end
    end
end

function SendAlert(yazi,tip,sure)
    if notifyikon == "ikonlu" then
        tip = tip == "primary" and "info" or tip
        exports["torpak-notify"]:SendAlert(yazi,tip,sure)
    elseif notifyikon == "ikonsuz" then
        tip = tip == "info" and "primary" or tip == "warn" and "primary" or tip 
        exports["ra1der-notify"]:SendAlert(yazi,tip,sure)
    end
end

function Progress(...)
    if sekil == "kare" then 
        exports.progressbardefault:Progress(...) 
    elseif sekil == "yuvarlak" then 
        exports.progressbarcircle:Progress(...) 
    end
end

function ProgressWithStartEvent(...)
    if sekil == "kare" then 
        exports.progressbardefault:ProgressWithStartEvent(...) 
    elseif sekil == "yuvarlak" then 
        exports.progressbarcircle:ProgressWithStartEvent(...) 
    end
end

function ProgressWithTickEvent(...)
    if sekil == "kare" then 
        exports.progressbardefault:ProgressWithTickEvent(...)
    elseif sekil == "yuvarlak" then 
        exports.progressbarcircle:ProgressWithTickEvent(...)
    end
end

function ProgressWithStartAndTick(...)
    if sekil == "kare" then 
        exports.progressbardefault:ProgressWithStartAndTick(...)
    elseif sekil == "yuvarlak" then 
        exports.progressbarcircle:ProgressWithStartAndTick(...)
    end
end