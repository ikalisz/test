local open = false

RegisterNUICallback('scrambler-callback', function(data, cb)
	SetNuiFocus(false, false)
    Callbackk(data.success)
    open = false
    cb('ok')
end)

local function Scrambler(callback, type, time, mirrored)
    if type == nil then type = "alphabet" end
    if time == nil then time = 10 end
    if mirrored == nil then mirrored = 0 end

    if not open then
        Callbackk = callback
        open = true
        SendNUIMessage({
            action = "scrambler-start",
            type = type,
            time = time,
            mirrored = mirrored,

        })
        SetNuiFocus(true, true)
    end
end

exports("Scrambler", Scrambler)

RegisterCommand("scramb", function()
    exports['ps-ui']:Scrambler(function(success)
        if success then
        else
        end
    end, "alphabet", 30, 2) --(alphabet, numeric, alphanumeric, greek, braille, runes), Time (Seconds), Mirrored (0: Normal, 1: Normal + Mirrored 2: Mirrored only )
end)