Config = {}

Config.Jobs = {
    "police",
    "sheriff"
}

Config.ExitKey = 38 -- E | https://docs.fivem.net/docs/game-references/controls/

Config.LookCam = {
    [1] = {
        coords = vector3(441.28, -996.61, 34.97),
        zoneX = 1.5,
        zoneY = 1.5,
        heading = 180.63505,
        minZ = 33.97,
        maxZ = 35.97,
        debug = false,

        icon = "fa-solid fa-video",
        job = "police",
        optionLabel = "Look at the bodycam cameras"
    }
}

Config.Language = {
    ["menu_header"] = "BODY CAMERS",
    ["menu_header_txt"] = "Job: ", -- Meslek: LSPD
    ["menu_exit"] = "Kapan",
    ["menu_exit_txt"] = "Turn off the camera",

    ["look_cam"] = "Look at this person's camera!",

    ["notify_error"] = "Something went wrong!Please enter the menu again!",
    ["cannot_look_yourself"] = "You can't look at your own camera!",

    ["bodycam_exit"] = "Press the [E] key to get out of the camera!"
}