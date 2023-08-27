local QBCore = exports['qb-core']:GetCoreObject()
local PlayerData = {}

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    PlayerData = QBCore.Functions.GetPlayerData()
end)

local playercount = 0
Citizen.CreateThread(function()
    SetDiscordAppId(840214915678470185) -- SET YOUR DISCORD APP ID
    SetDiscordRichPresenceAsset('elixir') -- SET YOUR DISCORD RICH PRESENCE IMAGE NAME
    SetDiscordRichPresenceAssetText("ID: "..GetPlayerServerId(PlayerId()))
    SetRichPresence("Connecting...")
    SetDiscordRichPresenceAction(0, "ElixirFW", "https://discord.gg/uRaaUPNKmd") -- SET YOUR URL
    --SetDiscordRichPresenceAction(1, "Connect To Server", "https://discord.gg/uRaaUPNKmd")
end)

RegisterNetEvent('mb-activity:playercount')
AddEventHandler('mb-activity:playercount', function(count)
    local PlayerData = QBCore.Functions.GetPlayerData()
    Wait(45000)
    SetRichPresence(PlayerData.charinfo.firstname.." "..PlayerData.charinfo.lastname.. " " ..count.. "/69")
    playercount = count
end)