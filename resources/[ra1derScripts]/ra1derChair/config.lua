Config = {}
Config["UseCommands"] = false --- Ability to use commands like /spawnchair1 for everyone
Config["UseTriggers"] = true -- I recommend having this on it allows for you to use the documentation below to customize this and use it anyway you would like.
Config["ClientTrigger1"] = "hover:Chair1"
Config["ClientTrigger2"] = "hover:Chair2"
Config["Chair1Command"] = "spawnchair1"
Config["Chair2Command"] = "spawnchair2"

--[[
    Khaoz Chairs Documentation
    ____________________________________
    If you would like to incorperate this into any custom script of your own choice, like usable items ect.. you can do so.
    You will just need to trigger the specified triggers you setup and make sure they are named the exact you'd like for example
    ____________________________________
    CLIENT SIDE EVENT TRIGGERS
    ____________________________________
    TriggerEvent('hover:Chair1')
    TriggerEvent('hover:Chair2')
    ____________________________________
    These are clientside triggers incase you'd like a server event to trigger them simply just do 
    ____________________________________
    SERVER SIDE EVENT TRIGGERS
    ____________________________________
    TriggerClientEvent('hover:Chair1', source)
    TriggerClientEvent('hover:Chair2', source)


]]