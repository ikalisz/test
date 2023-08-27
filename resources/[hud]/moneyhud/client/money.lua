local cashAmount = 0
local isLoggedIn = false
local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent("QBCore:Client:OnPlayerLoaded", function()
    PlayerData = QBCore.Functions.GetPlayerData()
    if PlayerData and PlayerData.money then
        cashAmount = QBCore.Shared.Round(PlayerData.money.cash)
    end
    isLoggedIn = true
end)

RegisterNetEvent("tgiannHudMoney")
AddEventHandler("tgiannHudMoney", function(show)
    SendNUIMessage({
        type = "money",
        show = show,
        money = cashAmount

    })
end)

RegisterNetEvent("hud:client:SetMoney")
AddEventHandler("hud:client:SetMoney", function()
    isLoggedIn = true
    PlayerData = QBCore.Functions.GetPlayerData()
    if PlayerData and PlayerData.money then
        cashAmount = QBCore.Shared.Round(PlayerData.money.cash)
    end
end)

RegisterNetEvent("hud:client:OnMoneyChange")
AddEventHandler("hud:client:OnMoneyChange", function(type, amount, isMinus)
    isLoggedIn = true
    if type == "cash" then
        PlayerData = QBCore.Functions.GetPlayerData()
        cashAmount = QBCore.Shared.Round(PlayerData.money.cash)
        SendNUIMessage({
            type = "moneyUpdate",
            money = amount,

            newCashAmount = cashAmount,

            isMinus = isMinus
        })
    end
end)
