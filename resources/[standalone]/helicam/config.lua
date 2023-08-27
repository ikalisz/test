Config = {}

Config.TimeFormat = 0 -- 0 = ZULU (UTC), 1 = In Game Time, 2 = OS TIME (Local Time)
Config.DateFormat = 1 -- 0 = MM/DD/YY, 1 = DD/MM/YY, 2 = YY/MM/DD, 3 = DD-Mon-YYYY

Config.PlaySounds = true
Config.PlayCameraMovementSounds = true -- true ise , helikopter kamerasını hareket ettirdiğinizde sesler çalacaktır.
Config.DisablePoliceScanner = true -- true ise  polis telsizi/tarayıcı/sevkiyat seslerini devre dışı bırakır.
Config.DisableFlightMusic = true -- true ise gta v uçuş sesi kapatılacak

Config.CameraTransition = false -- true ise , kameraya girdiğinizde/çıktığınızda kamera rahatlayacak
Config.CameraTransitionTime = 1000 -- The time the transition/ease will take.

Config.ShowLatitudeLongitude = false -- true olarak ayarlanırsa enlem/boylamı gösterir, aksi takdirde sokağı ve alanı gösterir
Config.TargetMaxReach = 424.0 -- Bir varlığı hedefleyebileceğimiz en uzun mesafe (424, bir oyuncu için normal toplama mesafesidir, pratikte hiçbir zaman bu kadar uzağa ulaşamayacaksınız)
Config.ForceCameraLabel = false -- false or "Label"
Config.CanUseAnyHelicopter = false -- If true, any helicopter can be used, if false, only helicopters in the Config.Helicopters table are allowed.

Config.AllowCameraLock = true -- If true, kamera yere/hedeflere kilitlenebilir
Config.InstantCameraLock = false -- If true, kamera, bir ödemesiz süre gerektirmek yerine hemen hedefe kilitlenir
Config.AllowCameraLockOnGround = true -- If true, kamera zemine/binalara vb. kilitlenebilir.
Config.CameraLockBreakTicks = 3 --Kameranın kırılmadan önce nokta/kişi/araç görüntüsünü kaybedebileceği maksimum işaret sayısı.
-- Doğruysa, bir varlığın üzerine kilitlenirken onun merkezine kilitlenir, yanlışsa kamera, varlığın kilitlemeden hemen önce hedeflediğiniz kısmına kilitlenir
Config.LockOntoCenter = {
    Peds = true, -- Bu yanlış olduğunda mükemmel çalışmama eğilimi vardır.
    Vehicles = true
}

Config.ShowLicensePlate = true -- (LPL)
Config.CheckLicensePlateAngle = true -- If true, helikopter kamerası ile plaka arasındaki açıyı kontrol eder. Bu, kamera plakayı net bir şekilde göremediğinde oyuncunun plakasını okuyamamasına neden olur.
Config.OnlyShowPlateIfLocked = false -- If true, Doğruysa, plaka yalnızca araçta bir kilidimiz varsa gösterilecektir.

Config.WhitelistedJobs = false -- If false, the script doesn't check for jobs. If you want to check for jobs add a table where the job is the key, and the value is the job level like so: Config.WhitelistedJobs = { ['police'] = 2, ['ambulance'] = 5 }
Config.ShowMessageIfWrongJob = true -- If true, it will display an error message of you attempt to enter the camer without the right job, if false no message, just won't allow you to enter

-- false = Anyone can use the camera (including the pilot), 1 = Any passanger (not pilot) can use the camera, 2 = Only rear passangers can use the camera
Config.PassengerOnly = false

Config.ShowPostalCodes = false -- Shows postals while in the camera (This is a little resource heavy)
Config.PostalResource = "nearest-postal" -- The resource the postal file is located in (resource must be loaded before helicam, and the files must be formated like nearest-postal)
Config.PostalFile = "new-postals.json" -- MUST be a JSON file! (Note: The file must be loaded inside the fxmanifest of Config.PostalResource for the helicam script to be able to read it)

-- Adds a audio sumbix while in a helicopter/plane (noise suppression) (NOTE: Get's applied to all helicopters/planes, not just the ones with a camera)
Config.UseSubmix = false
Config.NoSubmixInCamera = false -- Only applys if Config.UseSubmix is set to true, if true, this will stop the submix when you are using the camera

-- If true, players will be able to rappel from helicopters that support it.
Config.AllowRappeling = true

-- If the script should add chat suggestions for some of the chat commands.
Config.AddChatSuggestions = true

-- Spotlight
Config.AllowSpotlight = true
Config.MaxAmountOfSpotlights = false -- false or number, set's the maximum amount of spotlights that are allowed on the server at any given time (global limit)
Config.Spotlight = {
    Colour = { R = 255, G = 255, B = 255 }, -- The RGB colour values of the spotlight, you can for example make it slightly more blue like so: { R = 220, G = 220, B = 255 }
    MaxDistance = 600.0,                    -- The maximum distance the spotlight will glow
    DefaultBrightness = 5.0,                -- The defult brightness of the spotlight
    MinBrightness = 0.5,                    -- The minimum brightness of the spotlight
    MaxBrightness = 15.0,                   -- The maximum brightness of the spotlight
    BrightnessIncrements = 0.75,            -- How much to change the brightness of the spotlight when adjusting it
    Roundness = 2.0,                        -- The "roundness" of the spotlight
    DefaultRadius = 10.0,                   -- The defult radius/size of the spotlight
    MinRadius = 5.0,                        -- The minimum radius of the spotlight
    MaxRadius = 15.0,                       -- The maximum radius of the spotlight
    RadiusIncrements = 0.75,                -- How much to change the radius of the spotlight when adjusting it
    Falloff = 200.0,                        -- 
}

Config.HideMinimap = false
Config.ZoomBarOffset = 20 -- The offset in % from the bottom of the screen the zoom bar will be when the minimap is enabled. (If you have something on the top of your minimap then setting it to 25 usally works well)
Config.TargetBlip = {
    Display = true,
    Sprite = 390,
    Colour = 40
}

Config.AllowNightVision = true
Config.AllowNightVisionDuringDay = true -- If the night vision can be enabeld during the day or not.
Config.AllowThermal = true
Config.ThermalOptions = {
    MaxThickness = 1.0, -- 1.0 = Default GTA, can't see trough much at all. 20.0 = Able to see trough most thin walls, however won't be able to see trough the ground or multiple/thick walls.
    MinNoise = 0.0, -- The minimum amount of background noise
    MaxNoise = 0.1, -- The maximum amount of background noise
    FadeStart = 5000.0, -- How far away (meters) before the "background" fade starts
    FadeEnd = 6000.0 -- How far away (meters) before the "background" fade becomes solid
}

Config.AllowMarkers = true
Config.Marker = {
    MaxAmount = 9, -- Above 9 the number markers should be disabled.
    MaxDrawDistance = 1000.0, -- The furthest distance a marker will be drawn at.
    Circle = {
        Type = 23,
        Scale = 8.0,
        Colour = { R = 230, G = 50, B = 50, A = 200 } -- { R = 110, G = 160, B = 230, A = 200 }
    },
    Number = {
        Display = true, -- Set this to false if you want the max amount of markers the be above 9
        Scale = 6.0,
        Colour = { R = 230, G = 50, B = 50, A = 200 }
    },
    Blip = {
        Display = true, -- Whether to display marker blips
        Number = true, -- Whether to display the number on the blip or not (99 is cap.)
        Sprite = 57,
        Scale = 0.75,
        Colour = 1, -- Red
    }
}

Config.UseAnimProp = true -- If true, players will have a tablet in their hands while using the camera
Config.Tablet = {
    model = -1585232418, -- prop_cs_tablet
    anim = {
        dict = "amb@world_human_seat_wall_tablet@female@base",
        name = "base"
    },
    bone = 57005, -- SKEL_R_Hand
    offset = vector3(0.17, 0.10, -0.13),
    rotation = vector3(20.0, 180.0, 180.0)
}

Config.ShowInstructions = false -- If true, instructions will be showns while you are in the camera
-- Used this website to get the controls (~INPUT_5D25DCCD~ for example): http://tools.povers.fr/hashgenerator/
-- 0 = On the right, 3+ = on the left.
Config.InstructionButtons = {
    [0] = { control = "~INPUT_5D25DCCD~", label = "  Spot Işığı Parlaklığını Ayarla (scroll +)" },
    [1] = { control = "~INPUT_F8C9FB3A~", label = "Spot Işığı Yarıçapını Ayarla (scroll +)" },
    [2] = { control = "~INPUT_DB481F5~", label = "Kamerayı Kilitle" }, -- This doesn't work for some reason...
    [3] = { control = "~INPUT_662F7BF5~", label = "Marker Ekle Kaldır" },
    [4] = { control = "~INPUT_DB471A88~", label = "Döngü Vizyonu" },
    [5] = { control = "~INPUT_51D50495~", label = "Heli Işığı" },
    [6] = { control = "~INPUT_5D25DCCD~", label = "Kameradan Çık" }
}

-- Speed Units:
-- KTS = Knots (nautical miles per hour)
-- MPH = Miles per hour
-- KMH = Kilometers per hour
-- MPS = Meters per second
-- FPS = Feet per second

-- Distance Units:
-- FT = Feet
-- M = Meters
-- MI = Miles
Config.Units = {
    Speed = "KTS", -- The speed of the helicopter                               (unit type: speed)
    Altitude = "FT", -- The altitude of the helicopter                          (unit type: distance)
    TargetSpeed = "KMH", -- The speed of the target the camera is looking at    (unit type: speed)
    TargetElevation = "FT", -- The elevation of where the camera is aming       (unit type: distance)
    TargetDistance = "M" -- The distance from the helicopter to the target      (unit type: distance)
}

Config.Camera = {
    MovementSpeed = {
        Keyboard = 3.0,
        Controller = 1.0
    },
    Zoom = {
        Max = 50.0,
        Min = 5.0,
        Speed = 5.0
    },
    RotationLimits = {
        Up = 25.0,
        Down = -89.5
    }
}

-- Docs: https://docs.fivem.net/docs/game-references/input-mapper-parameter-ids/ -- https://docs.fivem.net/docs/game-references/input-mapper-parameter-ids/keyboard/
Config.Keybinds = {
    ToggleCam = {
        Type = "KEYBOARD",
        Key = "E"
    },
    AttemptLock = {
        Type = "KEYBOARD",
        Key = "SPACE"
    },
    CycleVision = {
        Type = "MOUSE_BUTTON",
        Key = "MOUSE_RIGHT"
    },
    ToggleMarker = {
        Type = "MOUSE_BUTTON",
        Key = "MOUSE_MIDDLE"
    },
    Rappel = {
        Type = "KEYBOARD",
        Key = "X"
    },
    Spotlight = {
        Type = "KEYBOARD",
        Key = "G"
    },
    SpotlightBrightness = {
        Type = "KEYBOARD",
        Key = "LMENU"
    },
    SpotlightRadius = {
        Type = "KEYBOARD",
        Key = "LCONTROL"
    },
    Postals = {
        Type = "KEYBOARD",
        Key = ""
    }
}

Config.Localisation = {
    -- Notifications
    Notification = {
        JobNotWhitelisted = "You Are Not a Police",
        JobGrade = "Your rank is not enough!",
        NoCameraHeli = "This helicopter does not have a camera",
        NoCameraPlane = "There is no camera on this plane!!",
        IsPilot = "You cannot use the camera when you are a pilot!",
        NotInRear = "You must be behind the helicopter to use the camera.",
        CameraInUse = "Someone else is already using the camera!",
        SpotlightInUse = "Someone else is already using the camera!",
        NoSpotlight = "This helicopter has no spotlight!!",
        SpotlightGlobalLimit = "Global spotlight limit reached!",
        CannotRappelFromHeli = "This helicopter does not support rope landing!",
        CannotRappelFromSeat = "You can't rope off this seat!",
        ToHighToRappel = "The helicopter is too far to land on the rope!",
        ConfirmRappel = "Are you sure you want to go down with the rope? (Press again to confirm)",
        Rappeling = "Rope Down!"
    },
    -- Blip Names
    Blip = {
        Target = "Helicopter Camera Target",
        Marker = "Helicopter Marker"
    },
    -- Keybinding Descriptions
    KeyMapping = {
        ToggleCam = "Helicam - Change Camera",
        AttemptLock = "Helicam - Trial Lock",
        CycleVision = "Helicam - Cycle Vision",
        ToggleMarker = "Helicam - Add/Remove Markers",
        Rappel = "Helicam - Descent from a helicopter",
        Spotlight = "Helicam - Activate Helicopter Light",
        SpotlightBrightness = "Helicam - (+ scroll) Adjust Spotlight Brightness",
        SpotlightRadius = "Helicam - (+ scroll) Adjust Spotlight Radius",
        Postals = "Helicam - Change Mailings"
    },
    ChatSuggestions = {
        ToggleCamera = "Helicopter Camera / Enter and Exit",
        Rappel = "Landing from the helicopter"
    }
}

-- Nightvision/Thermal/Spotlight/PassengerOnly can be manually enabled/disabled for each model by adding one or more of following varabels under the model.
-- nightvision = false / true
-- thermalvision = false / true
-- spotlight = false / true
-- passengerOnly = false / 1 / 2 (see Config.PassengerOnly)
Config.Helicopters = {
    -- Default (if there is any missing data it will draw it's options from here)
    default = {
        offset = vector3(0.0, 0.0, -1.0),
        -- nightvision = true,   -- These are only needed/used if Config.AllowNightVision or Config.AllowThermal is set to false
        -- thermalvision = true, -- You can add these to each and every model, adding these and setting them to false disables the vision even if Config.AllowThermal etc. is set to true
        -- spotlight = true,     -- Allows yo overwrite Config.AllowSpotlight on a helicopter to helicopter basis.
        -- passengerOnly = false,
        labels = {
            [0] = "FLIR SYSTEMS"
        }
    },
    -- Police Maverick (polmav)
    [353883353] = {
        offset = vector3(0.0, 2.65, -1.0),
        labels = { -- Liveries
            [0] = "MRPD", -- 0 is default
            [1] = "AIR AMBULANCE"
        }
    },
    -- Maverick (maverick)
    [-1660661558] = {
        offset = vector3(0.0, 3.45, -0.65)
    },
    -- Buzzard Attack Chopper (buzzard)
    [788747387] = {
        offset = vector3(0.0, 2.15, -0.35)
    },
    -- Buzzard (buzzard2)
    [745926877] = {
        offset = vector3(0.0, 2.15, -0.35)
    },
    -- Frogger (frogger)
    [744705981] = {
        offset = vector3(0.0, 3.0, -0.35)
    },
    -- TPI/FIB Frogger (frogger2)
    [1949211328] = {
        offset = vector3(0.0, 3.0, -0.35),
        labels = { -- Liveries
            [0] = "FEDERAL INVESTIGATION BUREAU",
            [1] = "TREVOR PHILIPS ENTERPRISES"
        }
    },
    -- Annihilator/Patriotism and Immigration Authority (annihilator)
    [837858166] = {
        offset = vector3(-0.5, 4.0, -0.35),
        labels = { -- Liveries
            [0] = "NATIONAL OFFICE OF SECURITY ENFORCMENT"
        }
    },
    -- Valkyrie (valkyrie)
    [-1600252419] = {
        offset = vector3(0.0, 4.0, -1.15),
        labels = { -- Liveries
            [0] = "UNITED STATES ARMY"
        }
    },
    -- Avenger (avenger)
    [-2118308144] = {
        offset = vector3(0.0, 9.45, -2.45),
        labels = { -- Liveries
            [0] = "UNITED STATES MARINES"
        }
    },
    [-1804332227] = { --polas 350
        offset = vector3(0.0, 9.45, -2.45),
        labels = { -- Liveries
            [0] = "UNITED STATES MARINES"
        }
    }

    -- Example of custom helicopter:
    -- Emergency Maverick AS350 (eheli)
    -- [`eheli`] = {
    --     offset = vector3(0.0, 3.0, -1.15),
    --     labels = { -- Liveries
    --         [0] = "LOS SANTOS POLICE DEPARTMENT",
    --         [1] = "SAN ANDREAS HIGHWAY PATROL",
    --         [2] = "BLAIN COUNTY SHERIFF OFFICE",
    --         [3] = "SAN ANDREAS FIRE DEPARTMENT"
    --     }
    -- },
    -- You can also do GetHashKey("eheli") instead of `eheli`
    -- Here is a guide if you need more help: https://madsl.gitbook.io/docs/resources/helicopter-camera/adding-custom-helicopters
}
