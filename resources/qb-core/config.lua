QBConfig = {}

QBConfig.MaxPlayers = GetConvarInt('sv_maxclients', 64) -- Gets max players from config file, default 32
QBConfig.IdentifierType = "steam" -- Set the identifier type (can be: steam, license)
QBConfig.DefaultSpawn = {x=-1035.71,y=-2731.87,z=12.86,a=0.0}

QBConfig.Money = {}
QBConfig.Money.MoneyTypes = {-- ['type']=startamount - Add or remove money types for your server (for ex. ['blackmoney']=0), remember once added it will not be removed from the database!
    ['cash'] = 500, 
    ['bank'] = 2000
}

QBConfig.Money.DontAllowMinus = {'cash', 'bank'} -- eksiye düşmez

QBConfig.Player = {}
QBConfig.Player.MaxWeight = 100000 -- Max weight a player can carry (currently 120kg, written in grams)
QBConfig.Player.MaxInvSlots = 50 -- Max inventory slots for a player
QBConfig.Player.Bloodtypes = {
    "A+",
    "A-",
    "B+",
    "B-",
    "AB+",
    "AB-",
    "O+",
    "O-",
}

QBConfig.Server = {} -- General server config
QBConfig.Server.closed = false -- Set server closed (no one can join except people with ace permission 'qbadmin.join')
QBConfig.Server.closedReason = "Server Under Maintenance.." -- Reason message to display when people can't join the server
QBConfig.Server.uptime = 0 -- Time the server has been up.
QBConfig.Server.whitelist = TRUE -- Enable or disable whitelist on the server
QBConfig.Server.discord = "https://discord.gg/YOUR_DISCORD" -- Discord invite link
QBConfig.Server.PermissionList = {} -- permission list

QBConfig.JobCD = {
    ["ticaret"] = 3,
    ["shark"] = 20
}