QBCore = nil
TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)

QBCore.Functions.CreateUseableItem("polis_karti", function(source)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    TriggerClientEvent("lesimo-kimlikgoster", src)
end)


RegisterServerEvent("lg-identification:identify")
AddEventHandler("lg-identification:identify", function(identity)
    local src = source
    TriggerClientEvent("lg-identification:identify", -1, identity, GetEntityCoords(GetPlayerPed(src)))
end)

function SetIdentification(source, identity)
    if (source == -1) then return end
    TriggerEvent("lg-identification:set", source, identity)
end

exports("SetIdentification", SetIdentification)