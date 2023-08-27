local donem = "4" -- "1" yaz, "2" Ara sıra kar yağması(yerler kar olmaz), "3" Full kar, "4" Full Yaz


AvailableWeatherTypes = {
    'EXTRASUNNY', 
    'CLEAR', 
    'NEUTRAL', 
    'SMOG', 
    'FOGGY', 
    'OVERCAST', 
    'CLOUDS', 
    'CLEARING', 
    'RAIN', 
    'THUNDER', 
    'SNOW', 
    'BLIZZARD', 
    'SNOWLIGHT', 
    'XMAS', 
    'HALLOWEEN',
}

AvailableTimeTypes = {
    'MORNING',
    'NOON',
    'EVENING',
    'NIGHT',
}

local CurrentWeather = "EXTRASUNNY"
local freezecWeather = false
local freezeTime = false
local blackout = false

local hour = 8
local min = 0
local sec = 0

QBCore = nil
TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)

RegisterServerEvent('qb-weathersync:server:RequestStateSync')
AddEventHandler('qb-weathersync:server:RequestStateSync', function()
    TriggerClientEvent('qb-weathersync:client:SyncTime', -1, hour, min, CurrentWeather, blackout, sec)
end)

function FreezeElement(element)
    if element == 'weather' then
        freezecWeather = not freezecWeather
    else
        freezeTime = not freezeTime
    end
end

RegisterServerEvent('qb-weathersync:server:setWeather')
AddEventHandler('qb-weathersync:server:setWeather', function(type)
    CurrentWeather = string.upper(type)
    TriggerEvent('qb-weathersync:server:RequestStateSync')
end)

RegisterServerEvent('qb-weathersync:server:toggleBlackout')
AddEventHandler('qb-weathersync:server:toggleBlackout', function()
    ToggleBlackout()
end)

RegisterServerEvent('qb-weathersync:server:setTime')
AddEventHandler('qb-weathersync:server:setTime', function(hour, minute)
    SetExactTime(hour, minute)
end)

function SetWeather(type)
    CurrentWeather = string.upper(type)
    TriggerEvent('qb-weathersync:server:RequestStateSync')
end

function SetTime(type)
    if type:upper() == AvailableTimeTypes[1] then
        ShiftToMinute(0)
        ShiftToHour(9)
        TriggerEvent('qb-weathersync:server:RequestStateSync')
    elseif type:upper() == AvailableTimeTypes[2] then
        ShiftToMinute(0)
        ShiftToHour(12)
        TriggerEvent('qb-weathersync:server:RequestStateSync')
    elseif type:upper() == AvailableTimeTypes[3] then
        ShiftToMinute(0)
        ShiftToHour(18)
        TriggerEvent('qb-weathersync:server:RequestStateSync')
    else
        ShiftToMinute(0)
        ShiftToHour(23)
        TriggerEvent('qb-weathersync:server:RequestStateSync')
    end
end

function SetExactTime(hour, minute)
    local argh = tonumber(hour)
    local argm = tonumber(minute)
    if argh < 24 then
        ShiftToHour(argh)
    else
        ShiftToHour(0)
    end
    if argm < 60 then
        ShiftToMinute(argm)
    else
        ShiftToMinute(0)
    end
    TriggerEvent('qb-weathersync:server:RequestStateSync')
end

function ToggleBlackout()
    blackout = not blackout
    TriggerEvent('qb-weathersync:server:RequestStateSync')
end

function ShiftToMinute(newMinute)
    min = newMinute
end

function ShiftToHour(newHour)
    hour = newHour
end

Citizen.CreateThread(function()
    while true do
        local waitTime = 1
--[[         local date = os.date("*t", os.time())
        hour = tonumber(date["hour"])
        min = tonumber(date["min"])
        sec = tonumber(date["sec"]) ]]
        if freezeTime then
            waitTime = 10
        else
            if hour >= 21 and hour <= 23 or hour >= 0 and hour <= 5 then -- waitTime = oyun için bir dakikanın gerçekte kaç saniye süreceğidir
                waitTime = 5 -- gece
            else
                waitTime = 5 -- gündüz
            end	

            min = min + 1
            if min == 60 then
                min = 0
                hour = hour + 1
                if hour == 24 then
                    hour = 0
                end
            end
        end
        TriggerEvent('qb-weathersync:server:RequestStateSync')
        Citizen.Wait(1000 * waitTime)
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000)
        if freezecWeather then
            Citizen.Wait(1800000)
        elseif donem == "1" then
            if CurrentWeather == "CLOUDS" then
                if math.random(1,3) == 1  then
                    CurrentWeather = "RAIN"
                else
                    CurrentWeather = "CLEARING"
                end
            elseif CurrentWeather == "CLEAR" or CurrentWeather == "EXTRASUNNY"  then
                CurrentWeather = "OVERCAST"
            elseif CurrentWeather == "FOGGY" then
                local new  = math.random(1,2)
                if new == 1 then
                    CurrentWeather = "CLOUDS"
                else
                    CurrentWeather = "CLEAR"
                end
            elseif CurrentWeather == "CLEARING" or CurrentWeather == "OVERCAST" then
                local new = math.random(1,4)
                if new == 1 then
                    CurrentWeather = "FOGGY" 
                elseif new == 2 then
                    CurrentWeather = "CLEAR"
                elseif new == 3 then
                    CurrentWeather = "EXTRASUNNY"
                else
                    CurrentWeather = "SMOG"
                end
            elseif CurrentWeather == "SMOG" or CurrentWeather == "RAIN" then
                CurrentWeather = "CLEAR"
            else
                CurrentWeather = "EXTRASUNNY"
            end

            if CurrentWeather == "FOGGY" or CurrentWeather == "CLEARING" or CurrentWeather == "RAIN" then
                Citizen.Wait(600000)
            else
                Citizen.Wait(1800000)
            end
        elseif donem == "2" then
            local random = math.random(1,2)
            if random == 1 then
                CurrentWeather = "SNOWLIGHT"
            else
                CurrentWeather = "OVERCAST"
            end
            Citizen.Wait(600000)
        elseif donem == "3" then
            CurrentWeather = "XMAS"
            Citizen.Wait(1800000)
        elseif donem == "4" then
            CurrentWeather = "EXTRASUNNY"
            Citizen.Wait(1800000)
        end
        TriggerEvent("qb-weathersync:server:RequestStateSync")
    end
end)

QBCore.Commands.Add("kartopu", "Kartopu Topla", {}, false, function(source, args)
    if CurrentWeather == "XMAS" then
        TriggerClientEvent("inventory:client:PickupSnowballs", source)
    else
        TriggerClientEvent('QBCore:Notify', source, "What Wife Are You Crazy In This Weather??", "error")
    end
end)