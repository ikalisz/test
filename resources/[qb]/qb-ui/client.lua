local tablo = {}
function showInteraction(text , type, id)
    if id then 
       tablo[id] = true
    end 
    SendNUIMessage({
        type = "open",
        text = text,
        color = type,
    })
end

function hideInteraction(id)
    if id and tablo[id] then
        tablo[id] = false 
    elseif id and not tablo[id] then 
        return 
    end
    SendNUIMessage({
        type = "close",
    })
end

RegisterCommand("uifix", function()
    if id and tablo[id] then
        tablo[id] = false 
    elseif id and not tablo[id] then 
        return 
    end
    SendNUIMessage({
        type = "close",
    })
end)

local tablo = {
	vector3(-1131.92, -1552.82, 4.3236)
	}
	Citizen.CreateThread(function()
		while true do
			local sleep = 750
			local ped = PlayerPedId()
			local coords = GetEntityCoords(ped)
			local distance = false
			for k,v in ipairs(tablo) do
			  local distance2 = #(coords - v)
			  if distance2 <= 2 then
				distance = true
				break
			  end
			end
			if distance then
				sleep = 5
				exports['qb-ui']:showInteraction("[E] - M3 TO QB", nil, "tablo")
			else
				exports['qb-ui']:hideInteraction("tablo")
			end
			Citizen.Wait(sleep)
		end
	end)

    local tablo = {
        vector3(-1127.09, -1567.17, 4.3201)
        }
        Citizen.CreateThread(function()
            while true do
                local sleep = 750
                local ped = PlayerPedId()
                local coords = GetEntityCoords(ped)
                local distance = false
                for k,v in ipairs(tablo) do
                  local distance2 = #(coords - v)
                  if distance2 <= 2 then
                    distance = true
                    break
                  end
                end
                if distance then
                    sleep = 5
                    exports['qb-ui']:showInteraction("[E] - M3 TO 2", nil, "tablo2")
                else
                    exports['qb-ui']:hideInteraction("tablo2")
                end
                Citizen.Wait(sleep)
            end
        end)