Cfg = {}

voiceTarget = 1

gameVersion = GetGameName()

-- these are just here to satisfy linting
if not IsDuplicityVersion() then
	LocalPlayer = LocalPlayer
	playerServerId = GetPlayerServerId(PlayerId())
end
Player = Player
Entity = Entity

if GetConvar('voice_useNativeAudio', 'false') == 'true' then
    -- native audio distance seems to be larger then regular gta units
    Cfg.voiceModes = {
        { 1.5, "Whisper" }, -- Whisper speech distance in gta distance units
        { 3.0, "Normal" }, -- Normal speech distance in gta distance units
        { 15.0, "Shouting" } -- Shout speech distance in gta distance units
    }
else
    Cfg.voiceModes = {
        { 3.0,  "Whisper" }, -- Whisper speech distance in gta distance units
        { 7.0,  "Normal" }, -- Normal speech distance in gta distance units
        { 25.0, "Shouting" } -- Shout speech distance in gta distance units
    }
end

logger = {
	log = function(message, ...)
	end,
	info = function(message, ...)
		if GetConvarInt('voice_debugMode', 0) >= 1 then
		end
	end,
	warn = function(message, ...)
	end,
	error = function(message, ...)
		error((message):format(...))
	end,
	verbose = function(message, ...)
		if GetConvarInt('voice_debugMode', 0) >= 4 then
		end
	end,
}


function tPrint(tbl, indent)
	indent = indent or 0
	for k, v in pairs(tbl) do
		local tblType = type(v)
		local formatting = string.rep("  ", indent) .. k .. ": "

		if tblType == "table" then
			print(formatting)
			tPrint(v, indent + 1)
		elseif tblType == 'boolean' then
			print(formatting .. tostring(v))
		elseif tblType == "function" then
			print(formatting .. tostring(v))
		else
			print(formatting .. v)
		end
	end
end

local function types(args)
    local argType = type(args[1])
    for i = 2, #args do
        local arg = args[i]
        if argType == arg then
            return true, argType
        end
    end
    return false, argType
end

function type_check(...)
    local vars = {...}
    for i = 1, #vars do
        local var = vars[i]
        local matchesType, varType = types(var)
        if not matchesType then
            table.remove(var, 1)
            error(("Invalid type sent to argument #%s, expected %s, got %s"):format(i, table.concat(var, "|"), varType))
        end
    end
end