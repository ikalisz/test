Config = {}
Config.Data = {}

Config.Data.DisplayTimer = 5
Config.Data.DisplayDistance = 4.0
Config.Data.Departments = { 
    ["lspd"] = {
        label = "MRPD",
        background_image = "https://static.wikia.nocookie.net/gtawiki/images/2/21/Lossantos_seal.png",
        background_color = "rgb(38, 42, 78)",
        description = "<h3>Mission Row Police Department: </h3><p>The person showing this badge is a government official.</p><p>Los Santos, PD</p>",
        colors= {
            text = "white",
            underline = "white",
            photo = "black",
        }
    },
    -- ["bcso"] = {
    --     label = ">Blaine County Şerif Ofisi",
    --     background_image = "https://static.wikia.nocookie.net/gtawiki/images/3/32/LSSD.png",
    --     background_color = "rgb(200, 78, 0)",
    --     description = "<h3>Blaine County Şerif Ofisi</h3><p>Bu rozeti gösteren kişi bir devlet görevlisi.</p><p>Los Santos, CA</p>",
    --     colors = {
    --         text = "white",
    --         underline = "white",
    --         photo = "white",
    --     }
    -- },
    ["medic"] = {
        label = "Los Santos Medical Department",
        background_image = "https://nremt.org/icon.png",
        background_color = "rgb(40, 40, 60)",
        description = "<h3>Los Santos Medical Department</h3><p>Person displaying this badge is medically qualified.</p><p>Los Santos, CA</p>",
        colors = {
            text = "white",
            underline = "white",
            photo = "white",
        }
    },
}
Config.Functions = {}

Config.Functions.CanDisplayIdentity = function() -- Client Check to see if the player can show their identity
        -- if (PlayerData.job.name ~= "police" or PlayerData.job.name ~= "ambulance") then
        --     return false 
        -- else 
        --     return true
        -- end
    return true
end

Config.Functions.CanEditIdentity = function() -- Client Check to see if the player can edit their identity
    return true
end

Config.Functions.OnEditSubmit = function(data) -- Client handler for when the player submits their edited identity
    --[[ Example: I dont want to allow the player to edit their name
    if (CurrentData.name ~= data.name) then 
        data.name = CurrentData.name
    end
    ]]--
    return data
end