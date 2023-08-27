QBCore = nil
TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)

QBCore.Functions.CreateCallback('tgiann-kosetut:satis-gerceklesti', function(source, cb, RastgeleEsya, fiyat, miktar, key)
    local src = source
    if QBCore.Functions.kickHacKer(src, key) then -- QBCore.Key
        local xPlayer = QBCore.Functions.GetPlayer(src)
        if xPlayer.Functions.RemoveItem(RastgeleEsya, miktar, xPlayer.Functions.GetItemByName(RastgeleEsya).slot) then
            xPlayer.Functions.AddMoney('cash', fiyat*miktar)
            TriggerClientEvent("QBCore:Notify", src, miktar ..' Piece '.. QBCore.Shared.Items[RastgeleEsya].label ..' '.. fiyat*miktar ..'$ Sold in exchange')
            TriggerEvent('DiscordBot:ToDiscord', 'kosetut',  'Player Named ' ..miktar ..' Piece '.. QBCore.Shared.Items[RastgeleEsya].label ..' '.. fiyat*miktar ..'$ Sold in exchange', xPlayer.PlayerData.source)
            cb(true)
        else
            TriggerClientEvent("QBCore:Notify", src, "Buyer Doesn't Want To Buy Any Items On Him")
            cb(false)
        end
    end
end)

