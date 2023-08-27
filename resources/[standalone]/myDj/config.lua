Config = {}
Translation = {}

Translation = {
    ['de'] = {
        ['DJ_interact'] = 'Press ~g~E~s~ to access the DJ desk',
        ['title_does_not_exist'] = '~r~This title does not exist!',
    },

    ['en'] = {
        ['DJ_interact'] = 'Press ~g~E~s~, to access the DJ desk',
        ['title_does_not_exist'] = '~r~This title does not exist!',
    }
}

Config.Locale = 'en'

Config.useESX = false -- can not be disabled without changing the callbacks
Config.enableCommand = false

Config.enableMarker = false -- purple marker at the DJ stations

Config.DJPositions = {
    {
        name = 'test',
        pos = vector3(-1381.33, -616.432, 31.497),
        requiredJob = nil, 
        range = 30.0, 
        volume = 1.0 --[[ do not touch the volume! --]]
    }

    --{name = 'bahama', pos = vector3(-1381.01, -616.17, 31.5), requiredJob = 'DJ', range = 25.0}
}