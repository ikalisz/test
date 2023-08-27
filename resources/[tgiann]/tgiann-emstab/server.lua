QBCore = nil
TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)

QBCore.Functions.CreateCallback("tgiann-emstab:sorgula", function(source, cb, data)
    exports.oxmysql:execute("SELECT * FROM players WHERE CONCAT(firstname, ' ', lastname) LIKE @search LIMIT 30", {
        ['@search'] = '%'..data.data..'%'
    }, function (result)
        if result then
            cb(result)
        end
    end) 
end)

RegisterServerEvent('tgiann-emstab:ceza-kaydet')
AddEventHandler('tgiann-emstab:ceza-kaydet', function(data)
    local src = source
    exports.oxmysql:execute("INSERT INTO tgiann_emstab_olaylar SET aciklama = @aciklama, polis = @polis, zanli = @zanli, esyalar = @esyalar", {
        ["@aciklama"] = data.aciklama,
        ["@polis"] = data.polis,
        ["@zanli"] = data.zanli,
        ["@esyalar"] = json.encode(data.cezalarTable),
     }, function(result1)
        exports.oxmysql:execute("SELECT citizenid FROM players WHERE CONCAT(firstname, ' ', lastname) LIKE @search LIMIT 30", {
            ['@search'] = '%'..data.zanli..'%'
        }, function(result)
            if result[1] then
                exports.oxmysql:execute("INSERT INTO tgiann_emstab_cezalar SET citizenid = @citizenid, aciklama = @aciklama, ceza = @ceza, polis = @polis, cezalar = @cezalar, zanli = @zanli, olayid = @id", {
                    ["@citizenid"] = result[1].citizenid,
                    ["@aciklama"] = data.aciklama,
                    ["@ceza"] = json.encode(data.ceza),
                    ["@polis"] = data.polis,
                    ["@zanli"] = data.zanli,
                    ["@cezalar"] = data.cezaisim,
                    ["@id"] = result1.insertId
                })
            end
        end)
    end)
end)

QBCore.Functions.CreateCallback("tgiann-emstab:olaylardata", function(source, cb, data)
    exports.oxmysql:execute("SELECT * FROM tgiann_emstab_olaylar ORDER BY id DESC LIMIT 100", {
    }, function (result)
        cb(result)
    end) 
end)

QBCore.Functions.CreateCallback("tgiann-emstab:sabikadata", function(source, cb, data)
    exports.oxmysql:execute("SELECT * FROM tgiann_emstab_cezalar WHERE citizenid = @citizenid ORDER BY id DESC ", {
        ["@citizenid"] = data
    }, function (result)
        cb(result)
    end) 
end)

RegisterServerEvent('tgiann-emstab:sabikasil')
AddEventHandler('tgiann-emstab:sabikasil', function(data)
    exports.oxmysql:execute("DELETE FROM tgiann_emstab_cezalar WHERE id = @id", {
        ['@id'] = data
    })
end)

RegisterServerEvent('tgiann-emstab:olaysil')
AddEventHandler('tgiann-emstab:olaysil', function(id)
    exports.oxmysql:execute("DELETE FROM tgiann_emstab_olaylar WHERE id = @id", {
        ['@id'] = id
    })
    exports.oxmysql:execute("DELETE FROM tgiann_emstab_cezalar WHERE olayid = @olayid", {
        ['@olayid'] = id
    })
end)

QBCore.Functions.CreateCallback("tgiann-emstab:olayara", function(source, cb, data)
    exports.oxmysql:execute("SELECT * FROM tgiann_emstab_olaylar WHERE id = @id", {
        ["@id"] = tonumber(data)
    }, function (result)
        cb(result)
    end) 
end)