local QBCore = exports['qb-core']:GetCoreObject()

-- Create Usable Items

QBCore.Functions.CreateUseableItem('wallet', function(source, item)
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
    TriggerClientEvent('exWallet:walletMenu', src, item)
end)

QBCore.Functions.CreateUseableItem("id_card", function(source, item)
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
	TriggerClientEvent("kimlik:islemleri", src, item)
end)

QBCore.Functions.CreateUseableItem("driver_license", function(source, item)
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
	TriggerClientEvent("ehliyet:islemleri", src, item)
end)

QBCore.Functions.CreateUseableItem("weaponlicense", function(source, item)
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
	TriggerClientEvent("ruhsat:islemleri", src, item)
end)

-- Take ID Card / Driver License / Weapon License | Events

RegisterServerEvent('exWallet:takeIDyourself')
AddEventHandler('exWallet:takeIDyourself', function()
	local src = source
    local player = QBCore.Functions.GetPlayer(src)
	takeCard(src)
end)

RegisterServerEvent('exWallet:takeIDsomeone')
AddEventHandler('exWallet:takeIDsomeone', function(playerId)
    local player = QBCore.Functions.GetPlayer(playerId)
	takeCardsomeone(player, playerId)
end)

RegisterServerEvent('exWallet:takeDriveL')
AddEventHandler('exWallet:takeDriveL', function(playerId)
    local player = QBCore.Functions.GetPlayer(playerId)
	takeDriveL(player, playerId)
end)

RegisterServerEvent('exWallet:takeWeaponL')
AddEventHandler('exWallet:takeWeaponL', function(playerId)
    local player = QBCore.Functions.GetPlayer(playerId)
	takeWeaponL(player, playerId)
end)

-- Add Item Functions

RegisterNetEvent("put-money", function(money)
    QBCore.Functions.addJobMoney("police", money)
end)

function takeCard(source)
    local src = source
    local player = QBCore.Functions.GetPlayer(src)
    local info = {}
    info.owner = player.PlayerData.charinfo.firstname..' '..player.PlayerData.charinfo.lastname
    info.citizenid = player.PlayerData.citizenid
    info.firstname = player.PlayerData.charinfo.firstname
    info.lastname = player.PlayerData.charinfo.lastname
    info.birthdate = player.PlayerData.charinfo.birthdate
    info.gender = player.PlayerData.charinfo.gender
    info.nationality = player.PlayerData.charinfo.nationality

    TriggerClientEvent('faturaolusturyarram2', src, src)
    QBCore.Functions.addJobMoney("police", Config.KimlikFatura)
    player.Functions.AddItem('id_card', 1, false, info)
    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["id_card"], "add", 1)
end

function takeCardsomeone(player, playerId)
    local src = source
    local info = {}
    if player ~= nil then
        info.owner = player.PlayerData.charinfo.firstname..' '..player.PlayerData.charinfo.lastname
        info.citizenid = player.PlayerData.citizenid
        info.firstname = player.PlayerData.charinfo.firstname
        info.lastname = player.PlayerData.charinfo.lastname
        info.birthdate = player.PlayerData.charinfo.birthdate
        info.gender = player.PlayerData.charinfo.gender
        info.nationality = player.PlayerData.charinfo.nationality

        TriggerClientEvent('faturaolusturyarram', playerId, playerId)
        QBCore.Functions.addJobMoney("police", Config.KimlikFatura)
        player.Functions.AddItem('id_card', 1, false, info)
        TriggerClientEvent('inventory:client:ItemBox', playerId, QBCore.Shared.Items["id_card"], "add", 1)
        TriggerClientEvent('QBCore:Notify', src, 'Civil '..player.PlayerData.charinfo.firstname..' '..player.PlayerData.charinfo.lastname..' You got ID.', 'success')
        TriggerClientEvent('QBCore:Notify', playerId, 'Your personal ID was taken out and handed over by the police officer.', 'success')
    else
        TriggerClientEvent('QBCore:Notify', src, 'There is no one nearby.', 'error')
    end
end

function takeDriveL(player, playerId)
    local src = source
    local info = {}
    if player ~= nil then
        if player.PlayerData.metadata["licences"]["drive"] then
            info.owner = player.PlayerData.charinfo.firstname..' '..player.PlayerData.charinfo.lastname
            info.citizenid = player.PlayerData.citizenid
            info.firstname = player.PlayerData.charinfo.firstname
            info.lastname = player.PlayerData.charinfo.lastname
            info.birthdate = player.PlayerData.charinfo.birthdate
            info.gender = player.PlayerData.charinfo.gender
            info.nationality = player.PlayerData.charinfo.nationality
            
            TriggerClientEvent('faturaolusturyarram', playerId, playerId)
            QBCore.Functions.addJobMoney("police", Config.KimlikFatura)
            player.Functions.AddItem('driver_license', 1, false, info)
            TriggerClientEvent('inventory:client:ItemBox', playerId, QBCore.Shared.Items["driver_license"], "add", 1)
            TriggerClientEvent('QBCore:Notify', src, 'Civil '..player.PlayerData.charinfo.firstname..' '..player.PlayerData.charinfo.lastname..' You got your license.', 'success')
            TriggerClientEvent('QBCore:Notify', playerId, 'Special drivers license issued and handed over by the police officer.', 'success')
        else
            TriggerClientEvent('QBCore:Notify', src, player.PlayerData.charinfo.firstname..' '..player.PlayerData.charinfo.lastname..' The person does not have the license required to obtain a drivers license..', 'error')
            TriggerClientEvent('QBCore:Notify', playerId, 'You asked for a drivers license from the police officer, but he couldnt give you a license because you didnt have a license..', 'error')
        end
    else
        TriggerClientEvent('QBCore:Notify', src, 'There is no one nearby.', 'error')
    end
end

function takeWeaponL(player, playerId)
    local src = source
    local info = {}
    if player ~= nil then
        if player.PlayerData.metadata["licences"]["weapon"] then
            info.owner = player.PlayerData.charinfo.firstname..' '..player.PlayerData.charinfo.lastname
            info.citizenid = player.PlayerData.citizenid
            info.firstname = player.PlayerData.charinfo.firstname
            info.lastname = player.PlayerData.charinfo.lastname
            info.birthdate = player.PlayerData.charinfo.birthdate
            info.gender = player.PlayerData.charinfo.gender
            info.nationality = player.PlayerData.charinfo.nationality

            TriggerClientEvent('faturaolusturyarram', playerId, playerId)
            QBCore.Functions.addJobMoney("police", Config.KimlikFatura)
            player.Functions.AddItem('weaponlicense', 1, false, info)
            TriggerClientEvent('inventory:client:ItemBox', playerId, QBCore.Shared.Items["weaponlicense"], "add", 1)
            TriggerClientEvent('QBCore:Notify', src, 'Civil '..player.PlayerData.charinfo.firstname..' '..player.PlayerData.charinfo.lastname..' You issued a gun license.', 'success')
            TriggerClientEvent('QBCore:Notify', playerId, 'Special license issued and handed over by the police officer.', 'success')
        else
            TriggerClientEvent('QBCore:Notify', src, player.PlayerData.charinfo.firstname..' '..player.PlayerData.charinfo.lastname..' The person does not have a license required to obtain a license..', 'error')
            TriggerClientEvent('QBCore:Notify', playerId, 'You asked for a drivers license from the police officer, but he couldnt give you a license because you didnt have a license..', 'error')
        end
    else
        TriggerClientEvent('QBCore:Notify', src, 'There is no one nearby.', 'error')
    end
end