
local QBCore = exports['qb-core']:GetCoreObject()


--============================================================== Sell/Gear Menus

RegisterNetEvent('doj:client:SellLegalFish')
AddEventHandler('doj:client:SellLegalFish', function()
    exports['qb-menu']:openMenu({
		{
            header = "Pearl's Seafood Restorant",
            isMenuHeader = true
        },
        {
            header = "Sell ​​Tuna Fish",
            txt = "Current price : $"..Config.mackerelPrice.."",
            params = {
				isServer = true,
                event = "fishing:server:SellLegalFish",
				args = 1
            }
        },
        {
            header = "Sell cod fish",
            txt = "Current price : $"..Config.codfishPrice.." ",
            params = {
				isServer = true,
                event = "fishing:server:SellLegalFish",
				args = 2
            }
        },
		{
            header = "Sell Bick Fish",
            txt = "Current price : $"..Config.bassPrice.." ",
            params = {
				isServer = true,
                event = "fishing:server:SellLegalFish",
				args = 3 
            }
        },
        {
            header = "Sell ​​Flounder",
            txt = "Current price : $"..Config.flounderPrice.." ",
            params = {
				isServer = true,
                event = "fishing:server:SellLegalFish",
				args = 4
            }
        },
		{
            header = "Sell ​​Stingray Fish",
            txt = "Current price : $"..Config.stingrayPrice.."",
            params = {
				isServer = true,
                event = "fishing:server:SellLegalFish",
				args = 5
            }
        },		
        {
            header = "Exit",
            txt = "",
            params = {
                event = "qb-menu:closeMenu"
            }
        },
    })
end)

