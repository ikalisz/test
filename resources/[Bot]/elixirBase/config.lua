Config = {}

Config.SystemAvatar = ''
Config.UserAvatar = ''
Config.SystemName = 'ElixirV1.5 Bot'
Config.discordRoleId = ""
Config.discordGuildId = ""
Config.Priority = {
    ["steam:11000010ee7c194"] = 15000000, -- thermite
    ["steam:11000010035326e"] = 15000000, -- rola
    ["steam:11000010e8b6a17"] = 15000000, -- eyyamcu
    ["steam:11000013bc724df"] = 5000000, -- shorty
    ["steam:11000014416b9e0"] = 5000000, -- yeis
    ["steam:110000147b13d99"] = 5000000, -- asap
    ["steam:1100001452d18b0"] = 5000000, -- janset
    ["steam:110000149dc67c4"] = 5000000, -- saliha
    ["steam:110000149ac93d8"] = 5000000, -- Rifah (Bayqus)
}


-- require people to run steam
Config.RequireSteam = false

-- "whitelist" only server
Config.PriorityOnly = false

-- disables hardcap, should keep this true
Config.DisableHardCap = false

-- will remove players from connecting if they don't load within: __ seconds; May need to increase this if you have a lot of downloads.
-- i have yet to find an easy way to determine whether they are still connecting and downloading content or are hanging in the loadscreen.
-- This may cause session provider errors if it is too low because the removed player may still be connecting, and will let the next person through...
-- even if the server is full. 10 minutes should be enough
Config.ConnectTimeOut = 450

-- will remove players from queue if the server doesn't recieve a message from them within: __ seconds
Config.QueueTimeOut = 180

-- will give players temporary priority when they disconnect and when they start loading in
Config.EnableGrace = false

-- how much priority power grace time will give
Config.GracePower = 500

-- how long grace time lasts in seconds
Config.GraceTime = 480

-- on resource start, players can join the queue but will not let them join for __ milliseconds
-- this will let the queue settle and lets other resources finish initializing
Config.JoinDelay = 30000

-- will show how many people have temporary priority in the connection message
Config.ShowTemp = false

-- simple localization
Config.Language = {
    joining = "Joining the server..",
    connecting = "Connecting..",
    idrr = "Failed to get required information, try closing and reopening FiveM.",
    err = "Something went wrong",
    pos = "You are next %d/%d %s",
    connectingerr = "Error adding you to connecting list",
    timedout = "Timed out?",
    wlonly = "Whitelist ONLY!.",
    steam = "Steam is not open."
}