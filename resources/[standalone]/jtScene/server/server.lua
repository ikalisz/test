-----------------------
QBCore = exports['qb-core']:GetCoreObject()

local scenes = {}

-----------------------
----   Threads     ----
-----------------------

CreateThread(function()
    UpdateAllScenes()
    while true do 
        DeleteExpiredScenes()
        Wait(Config.AuditInterval)
    end
end)

-----------------------
---- Server Events ----
-----------------------

QBCore.Functions.CreateCallback('haso-scenes:server:GetScenes', function(source, cb)
    cb(scenes)
end)

-----------------------
----   Functions   ----
-----------------------

function UpdateAllScenes()
    scenes = {}
    exports.oxmysql:execute('SELECT * FROM scenes', {}, function(result)
        if result[1] then
            for _, v in pairs(result) do
                local newCoords = json.decode(v.coords)
                scenes[#scenes+1] = {
                    id = v.id,
                    text = v.text,
                    color = v.color,
                    viewdistance = v.viewdistance,
                    expiration = v.expiration,
                    fontsize = v.fontsize,
                    fontstyle = v.fontstyle,
                    coords = vector3(newCoords.x, newCoords.y, newCoords.z),
                }
            end
        end
        TriggerClientEvent('haso-scenes:client:UpdateAllScenes', -1, scenes)
    end)
end

function DeleteExpiredScenes()
    exports.oxmysql:execute('DELETE FROM scenes WHERE date_deletion < NOW()', {}, function(result)
        if result and result.affectedRows > 0 then
            UpdateAllScenes()
        end
    end)
end

RegisterNetEvent('haso-scenes:server:DeleteScene', function(id)
    exports.oxmysql:execute('DELETE FROM scenes WHERE id = ?', {id}, function(result)
        UpdateAllScenes()
    end)
end)

RegisterNetEvent('haso-scenes:server:CreateScene', function(sceneData)
    local src = source 

    exports.oxmysql:execute('INSERT INTO scenes (creator, text, color, viewdistance, expiration, fontsize, fontstyle, coords, date_creation, date_deletion) VALUES (? ,?, ?, ?, ?, ?, ?, ?, NOW(), DATE_ADD(NOW(), INTERVAL ? HOUR))', {
        QBCore.Functions.GetPlayer(src).PlayerData.citizenid, 
        sceneData.text,
        sceneData.color,
        sceneData.viewdistance,
        sceneData.expiration,
        sceneData.fontsize,
        sceneData.fontstyle,
        json.encode(sceneData.coords),
        sceneData.expiration
    }, function(result)
        UpdateAllScenes()
    end)
end)