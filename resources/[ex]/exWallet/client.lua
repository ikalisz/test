local QBCore = exports['qb-core']:GetCoreObject()
local PlayerData = {}

RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    PlayerData = QBCore.Functions.GetPlayerData()
end)

RegisterNetEvent('exWallet:walletMenu')
AddEventHandler('exWallet:walletMenu', function(item)
    PlayerData = QBCore.Functions.GetPlayerData()
    exports['qb-menu']:openMenu({
        {
            header = 'Wallet',
            icon = 'fas fa-wallet',
            isMenuHeader = true
        },
        {
            header = 'Money Status',
            icon = 'fas fa-dollar-sign',
            txt = PlayerData.money['cash']..'$ Cash.',
            params = {
                event = 'para:goster'
            },
            disabled = true
        },
        {
            header = 'Check Your ID',
            icon = 'fas fa-search',
			txt = item.info.owner..' Review ID',
            params = {
                event = 'exWallet:kimlik31',
                args = {
                    item3 = item,
                }
            }
        },
        {
            header = 'Share your ID',
            icon = 'fas fa-handshake',
			txt = item.info.owner..' Share ID.',
            params = {
                event = 'exWallet:kimlik32',
                args = {
                    item3 = item,
                }
            }
        },
        {
            header = 'Driving License & Gun License',
            icon = 'fas fa-id-card',
			txt = item.info.owner..' Examine additional IDs.',
            params = {
                event = 'exWallet:trans',
                args = {
                    item2 = item,
                }
            }
        }
    })
end)

AddEventHandler('exWallet:kimlik31', function(args)
    local newItem2 = args.item3
    TriggerEvent('kimlik:bak', newItem2)
end)

AddEventHandler('exWallet:kimlik32', function(args)
    local newItem2 = args.item3
    TriggerEvent('kimlik:ver', newItem2)
end)

AddEventHandler('exWallet:trans', function(args)
    local newItem = args.item2
    TriggerEvent('exWallet:licenses', newItem)
end)

RegisterNetEvent('exWallet:licenses')
AddEventHandler('exWallet:licenses', function(newItem)
    PlayerData = QBCore.Functions.GetPlayerData()
    exports['qb-menu']:openMenu({
        {
            header = 'Drivers License Transactions',
            icon = 'fas fa-id-card',
            isMenuHeader = true
        },
        {
            header = 'Drivers License',
            icon = 'fas fa-search',
			txt = newItem.info.owner..' View drivers license.',
            params = {
                event = 'exWallet:ehliyet31',
                args = {
                    item3 = newItem,
                }
            }
        },
        {
            header = 'Extend Drivers License',
            icon = 'fas fa-handshake',
			txt = newItem.info.owner..' Extend Drivers License.',
            params = {
                event = 'exWallet:ehliyet32',
                args = {
                    item3 = newItem,
                }
            }
        },
        {
            header = 'Look License',
            icon = 'fas fa-search',
			txt = newItem.info.owner..' View License.',
            params = {
                event = 'exWallet:ruhsat31',
                args = {
                    item3 = newItem,
                }
            }
        },
        {
            header = 'Extend License',
            icon = 'fas fa-handshake',
			txt = newItem.info.owner..' Extend License.',
            params = {
                event = 'exWallet:ruhsat32',
                args = {
                    item3 = newItem,
                }
            }
        },
        {
            header = 'Check Your Wallet',
            icon = 'fas fa-wallet',
            params = {
                event = 'exWallet:trans2',
                args = {
                    item3 = newItem
                }
            }
        }
    })
end)

AddEventHandler('exWallet:ehliyet31', function(args)
    local newItem2 = args.item3
    TriggerEvent('ehliyet:bak', newItem2)
end)

AddEventHandler('exWallet:ehliyet32', function(args)
    local newItem2 = args.item3
    TriggerEvent('ehliyet:ver', newItem2)
end)

AddEventHandler('exWallet:ruhsat31', function(args)
    local newItem2 = args.item3
    TriggerEvent('ruhsat:bak', newItem2)
end)

AddEventHandler('exWallet:ruhsat32', function(args)
    local newItem2 = args.item3
    TriggerEvent('ruhsat:ver', newItem2)
end)

AddEventHandler('exWallet:trans2', function(args)
    local item = args.item3
    TriggerEvent('exWallet:walletMenu', item)
end)

RegisterNetEvent('exWallet:createLicense')
AddEventHandler('exWallet:createLicense', function()
    exports['qb-menu']:openMenu({
        {
            header = 'Identity Transactions',
            icon = 'fas fa-id-card',
            isMenuHeader = true
        },
        {
            header = 'Personal Identity',
            icon = 'fas fa-user',
            txt = Config.KimlikKisiselFatura..'$ get yourself an identity in return.',
            params = {
                event = 'exWallet:takeIDserver'
            }
        },
        {
            header = 'Civil Identity',
            icon = 'fas fa-id-badge',
            txt = Config.KimlikOyuncuFatura..'$ get an ID for a civilian in return.',
            params = {
                event = 'exWallet:takeIDsomeoneServer'
            }
        },
        {
            header = 'Get a Drivers License',
            icon = 'fas fa-car',
            txt = Config.KimlikOyuncuFatura..'$ issue a drivers license for a civilian in exchange.',
            params = {
                event = 'exWallet:takeDriveLserver'
            }
        },
        {
            header = 'Issue License',
            icon = 'fas fa-gun',
            txt = Config.KimlikOyuncuFatura..'$ issue a license for a civilian in return.',
            params = {
                event = 'exWallet:takeWeaponLserver'
            }
        },
    })
end)

AddEventHandler('exWallet:takeIDserver', function()
    TriggerServerEvent('exWallet:takeIDyourself')
end)

AddEventHandler('exWallet:takeIDsomeoneServer', function()
    local otherPlayer = QBCore.Functions.GetClosestPlayer()
    local playerId = GetPlayerServerId(otherPlayer)
    TriggerServerEvent('exWallet:takeIDsomeone', playerId)
end)

AddEventHandler('exWallet:takeDriveLserver', function()
    local otherPlayer = QBCore.Functions.GetClosestPlayer()
    local playerId = GetPlayerServerId(otherPlayer)
    TriggerServerEvent('exWallet:takeDriveL', playerId)
end)

AddEventHandler('exWallet:takeWeaponLserver', function()
    local otherPlayer = QBCore.Functions.GetClosestPlayer()
    local playerId = GetPlayerServerId(otherPlayer)
    TriggerServerEvent('exWallet:takeWeaponL', playerId)
end)

RegisterNetEvent('faturaolusturyarram', function(playerId)
    TriggerServerEvent('esx_billing:sendBill', playerId, 'MRPD', "Identity Fee", Config.KimlikOyuncuFatura)
end)

RegisterNetEvent('faturaolusturyarram2', function(src)
    TriggerServerEvent('esx_billing:sendBill', src, 'MRPD', "Identity Fee", Config.KimlikKisiselFatura)
end)