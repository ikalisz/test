Config = {}
-- For more info check https://codem.gitbook.io/codem-documentation/

Config.Theme = 'blvck' --  sky, blvck, cherry, kush, mango, proxima
Config.Logo = 'default' -- Default or URL link
Config.BackgroundImage = 'background.png' -- default or custom image/video
-- Backgrounds can be found in html/assets/background/
-- Config.BackgroundImage = 'background.png'

-- To display on left menu (must be an image)
-- Supports max 2 images
Config.AlbumsThumbnail = {
    {
        source = 'https://www.hizliresim.com/sc5cie4', -- Must be a link
    },
    {
        source = 'https://www.hizliresim.com/lhf1bx5', -- Must be a link
    }
}

Config.Albums = {
    {
        source = 'https://www.hizliresim.com/lhf1bx5', -- Must be a link
    },
    {
        source = 'https://www.hizliresim.com/sc5cie4'  -- Must be a link
    }
}

Config.EnableHintMessages = true
Config.HintMessages = {
    {
        text= 'Welcome to Elixir v1.5 QBCore FrameWork.',
        time= 8000,
    },
    {
        text= '...',
        time= 3000,
    },
    {

        text= '...',
        time= 1000,
    }
}

Config.PlayMusicByDefault = true -- if true plays the music when loading screen is active

Config.ButtonLinks = {
    -- ["twitter"] = 'https://twitter.com',
    -- ["instagram"] = 'https://www.instagram.com/',
    -- ["reddit"] = 'https://www.reddit.com/',
    ["discord"] = 'https://discord.gg/uRaaUPNKmd',
}

Config.ServerName = 'ElixirFW v1.5'

Config.Language = {
    ["WELCOME"] = 'WELCOME',
    ["INSIDE_CITY"] = 'Frames from the server',
    ["FOOTAGES"] = 'Latest Images from the Server',
    ["PATCH_NOTES"] = 'Update Notes',
    ["PATCH_NOTES_VERSION"] = 'Update Notes V1.5',
    ["LATEST_UPDATES"] = 'Latest updates...',
    ["FOLLOW_CITY"] = 'Follow us on social media.',


    ["CITY_LOADING"] = 'Please wait, server is loading...',
    ["SETTINGS"] = 'Settings',
    ["ENABLE_MUSIC"] = 'Turn music on/off',
    ["SHOW_MENU"] = 'Show left menu',
    ["SHOW_HINT"] = 'Show hint',
    ["SHOW_ALL"] = 'Show whole interface',



    ["KEYBINDS_INFO"] = 'Click on a button to see its function.',
    ["KEYBINDS_INFO_2"] = 'Some key assignments can be changed in game settings,',
    ["GO_TO"] = 'to change',
    ["FIVEM_SETTINGS"] = 'ESC>Settings>Keybindings>FiveM',
    ["PRESS"] = 'Click',
    ["DOUBLE_PRESS"] = 'Double Click',
    ["COMBINATIONS"] = 'Combinations',
    ["KEYBINDS_INFO_3"] = 'Click on a key to see its assignment.',
    ["KEYBINDS_INFO_4"] = 'Note that these key assignments are shortcuts to commands. There are many commands that are not assigned in the game yet..',

    ["COMMANDS"] = 'Commands',
    ["SHOW_ALL"] = 'Show all commands',
    ["SELECT_COMMAND"] = 'Please choose a command',
    ["DISPLAY_BINDING"] = 'Show assignment',
    ["COMMANDS_INFO"] = 'Click on a command to see its function',
    ["HINT"] = 'Clue',

}

Config.PatchNotes = {
    "Motel system changed",
    "Vehicle Handlings Organized",
    "Added Update Money",
    "Added Weedplanting",
}

Config.Keybinds = {
    ["ESC"] = false,
    ["F1"] = {
        ["pressInfo"] = 'Takes out the Phone',
        ["doublePressInfo"] = false,
    },
    ["F2"] = {
        ["pressInfo"] = 'Opens inventory',
    },
    ["F3"] = false,
    ["F4"] = false,
    ["F5"] = false,
    ["F6"] = {
        ["pressInfo"] = 'Opens the job menus',
    },
    ["F7"] = {
        ["pressInfo"] = 'Opens animation menus',
    },
    ["F8"] = false,
    ["F9"] = {
        ["pressInfo"] = 'Opens the radio menu',
    },
    ["F10"] = false,
    ["F11"] = {
        ["pressInfo"] = 'Changes the speech setting.',
    },
    ["F12"] = false,
    ["“"] = {
        ["pressInfo"] = 'Opens the police dispatch menu',
    },
    ["1"] = {
        ["pressInfo"] = 'Inventory Shortcut',
    },
    ["2"] = {
        ["pressInfo"] = 'Inventory Shortcut',

    },
    ["3"] = {
        ["pressInfo"] = 'Inventory Shortcut',

    },
    ["4"] = {
        ["pressInfo"] = 'Inventory Shortcut',

    },
    ["5"] = {
        ["pressInfo"] = 'Inventory Shortcut',

    },
    ["6"] = {
        ["pressInfo"] = 'Inventory Shortcut',
    },
    ["7"] = false,
    ["8"] = false,
    ["9"] = false,
    ["0"] = false,
    ["-"] = false,
    ["+"] = false,
    ["BACKSPACE"] = false,
    ["TAB"] = {
        ["pressInfo"] = 'Shows inventory shortcuts',
    },
    ["Q"] = false,
    ["W"] = false,
    ["E"] = false,
    ["R"] = false,
    ["T"] = {
        ["pressInfo"] = 'Opens chat',
    },
    ["Y"] = false,
    ["U"] = {
        ["pressInfo"] = 'Locks the vehicle',
    },
    ["I"] = false,
    ["O"] = false,
    ["P"] = false,
    ["["] = false,
    ["]"] = false,
    ["ENTER"] = {
        ["pressInfo"] = 'Opens chat',
    },
    ["CAPS"] = false,
    ["A"] = false,
    ["S"] = false,
    ["D"] = false,
    ["F"] = false,
    ["G"] = {
        ["pressInfo"] = 'Searches the person who raised his hands.',
    },
    ["H"] = false,
    ["J"] = false,
    ["K"] = false,
    ["L"] = false,
    [";"] =  false,
    ["@"] =  false,
    ["LSHIFT"] =  {
        ["pressInfo"] = 'Run',
        ["doublePressInfo"] = false,
        ["combinations"] = {
            {
                ["key"] = 'E',
                ["info"] = 'trips up',
            },
            {
                ["key"] = 'E',
                ["info"] = 'pushes the vehicle',
            },
            
        },
    },
    ["Z"] =  false,
    ["X"] =  false,
    ["C"] =  false,
    ["V"] =  false,
    ["B"] =  false,
    ["N"] =  false,
    ["M"] =  false,
    ["<"] =  false,
    [">"] =  false,
    ["?"] =  false,
    ["RSHIFT"] =  false,
    ["LCTRL"] =  false,
    ["ALT"] =  false,
    ["SPACE"] = false,
    ["ALTGR"] = false,
    ["RCTRL"] = false,
}
-- add only 2 commands here
Config.PreviewCommands = {
    ["hud"]= 'Opens HUD settings',
    ["gfix"]= 'Allows you to exit the gallery when stuck in the gallery',
}

Config.Commands = {
    ["hud"]= 'Opens HUD settings',
    ["gfix"]= 'Allows you to exit the gallery when stuck in the gallery',
    ["e"]= 'Lets you make the animation you want',
    ["mdt"]= 'Opens MDT for Police and Stuff..',
}



