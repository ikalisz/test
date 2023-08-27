Config = {}

-- priority list can be any identifier. (hex steamid, steamid32, ip) Integer = power over other people with priority
-- a lot of the steamid converting websites are broken rn and give you the wrong steamid. I use https://steamid.xyz/ with no problems.
-- you can also give priority through the API, read the examples/readme.
Config.Priority = {
    ["STEAM_0:1:0000####"] = 1,
    ["steam:110000######"] = 25,
    ["ip:127.0.0.0"] = 85
}

-- require people to run steam
Config.RequireSteam = true

-- "whitelist" only server
Config.PriorityOnly = false

-- disables hardcap, should keep this true
Config.DisableHardCap = true

-- will remove players from connecting if they don't load within: __ seconds; May need to increase this if you have a lot of downloads.
-- i have yet to find an easy way to determine whether they are still connecting and downloading content or are hanging in the loadscreen.
-- This may cause session provider errors if it is too low because the removed player may still be connecting, and will let the next person through...
-- even if the server is full. 10 minutes should be enough
Config.ConnectTimeOut = 600

-- will remove players from queue if the server doesn't recieve a message from them within: __ seconds
Config.QueueTimeOut = 90

-- will give players temporary priority when they disconnect and when they start loading in
Config.EnableGrace = false

-- how much priority power grace time will give
Config.GracePower = 5

-- how long grace time lasts in seconds
Config.GraceTime = 480

Config.AntiSpam = true
Config.AntiSpamTimer = 5
Config.PleaseWait = "Please wait %d seconds. The connection will start automatically!"

-- on resource start, players can join the queue but will not let them join for __ milliseconds
-- this will let the queue settle and lets other resources finish initializing
Config.JoinDelay = 30000

-- will show how many people have temporary priority in the connection message
Config.ShowTemp = false

-- simple localization
Config.Language = {
    joining = "\xF0\x9F\x8E\x89Joining in...",
    connecting = "\xE2\x8F\xB3Connecting...",
    idrr = "\xE2\x9D\x97[ELIXIR] Error: None of your Steam IDs could be retrieved, try restarting.",
    err = "\xE2\x9D\x97[ELIXIR] Something went wrong.",
    pos = "\xF0\x9F\x90\x8CYou are %d/%d. \xF0\x9F\x95\x9C%s You will be logged in in seconds..",
    connectingerr = "\xE2\x9D\x97[ELIXIR] Error: An error occurred while adding to the link list.",
    timedout = "\xE2\x9D\x97[ELIXIR] Error: Timed out?",
    wlonly = "\xE2\x9D\x97[ELIXIR] You need to have a whitelist to join this server.",
    steam = "\xE2\x9D\x97 [ELIXIR] Error: Steam should be running.",
    stopForDebug = "\xE2\x9D\x97 [ELIXIR] Error: Stop For Debug",
    whitelist = {
        noDiscord = "\xE2\x9D\x97 [ELIXIR] Error: Discord should be running.",
        noRole = "\xE2\x9D\x97 [ELIXIR] Error: You do not have the whitelist role.",
        checkingRoles = "\xE2\x8F\xB3Your roles are checked...",
        checkingQueue = "\xF0\x9F\x94\x8DYou are added to the queue..."

    }
}

Config.enableDiscordWhitelist = false -- For Enable Whitelist System
Config.discordServerGuild = "YourServerID" -- Discord Server ID to check it if player is in the server
Config.discordBotToken = "YourDiscordBotToken"  -- Discord Token Bot - You Can Create at https://discord.com/developers/applications

Config.Roles = {
	whitelist = {
		roleID = "RoleID", --Role ID
		point = 1,  -- any bigger point can push player on the first row of queue
	},
}