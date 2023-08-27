local QBCore = exports['qb-core']:GetCoreObject()

local DISCORD_WEBHOOK = "https://discord.com/api/webhooks/1073952240936701952/9bpuEkYchAzjoTXclxyi7yx55csTap4mCJbXGCQ9AnvQz40wVC92YCUZpyZrQu79tO8u"

QBCore.Functions.CreateCallback('tgiann:depo:server:readSQL', function(source, cb)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local data = exports.oxmysql:execute('SELECT * FROM tgiann_depo')
    local user = QBCore.Functions.GetPlayer(src)
    --print(json.encode(data))
    cb(data)
end)

RegisterServerEvent("ananinami")
AddEventHandler("ananinami", function(cokiyiyimya)
    src = source
    print(src)
    local result = exports.oxmysql:execute("SELECT tgiann_depo.sifre FROM tgiann_depo WHERE tgiann_depo.ad = @ad", {
        ['@ad'] = cokiyiyimya.ad
    })
    if cokiyiyimya.sifre == result[1].sifre then
        TriggerClientEvent("dogrulandiacilacakkasa", src, cokiyiyimya.ad)
    else
        TriggerClientEvent("sifreyanlis", src)
    end
end)

RegisterServerEvent('tgiann:depo:server:sat')
AddEventHandler('tgiann:depo:server:sat', function(data)
    local identifier = GetPlayerIdentifiers(source)[1]
    if identifier ~= nil then
        exports.oxmysql:execute('DELETE FROM tgiann_depo WHERE identifier = @identifier',
        { ['@identifier'] = identifier }
        )
    end
end)


QBCore.Functions.CreateCallback('tgiann:depo:writesql', function(source, cb, data)
    local _source = source
	local xPlayer = QBCore.Functions.GetPlayer(_source)
	
    if xPlayer.Functions.RemoveMoney("cash", 5000) then
        local identifier = GetPlayerIdentifiers(source)[1]
        exports.oxmysql:execute('INSERT INTO tgiann_depo (ad, sifre,  identifier) VALUES (@ad, @sifre, @identifier)',
        {
          ['@ad']       = data.ad .. math.random(9) .. math.random(9) .. math.random(9) .. math.random(9),
          ['@sifre']    = data.sifre,
          ['@identifier']   = identifier
        },
        function( result )
          cb(true)
        end)
        TriggerEvent('tgianndepo:log:basarili')
        TriggerEvent('DiscordBot:ToDiscord', 'depoalma', 'Player Named' ..data.ad.. "Bought Repository", _source)
    else
        TriggerClientEvent('QBCore:Notify', _source, "$5000 No Money!")
    end
end)