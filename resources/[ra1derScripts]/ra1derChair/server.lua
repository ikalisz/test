QBCore = nil
TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)

QBCore.Functions.CreateUseableItem('sandalye1', function(source)
    TriggerClientEvent('hover-chairs:Chair1', source)
end)

QBCore.Functions.CreateUseableItem('sandalye2', function(source)
    TriggerClientEvent('hover-chairs:Chair2', source)
end)
