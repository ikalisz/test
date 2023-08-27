Config = {}
Config.Core = {
  name = "QBCore",
  gettingCoreObject = "export", -- event/export
  gettingObjectName = "GetCoreObject", -- the event name / export name for getting the core object.
  core_resource_name = "qb-core" -- the core resource name.
}

Config.Location = vector3(-58.05, -1097.59, 26.42)-- The location of the vehicleshop.
Config.BoughtVehicleSpawnLocation = {coords= vector3(-30.98, -1090.9, 25.66),heading = 341.84} -- The location where the purchased vehicle will be spawned.
Config.TestVehicleSpawnLocation = {coords= vector3(-997.56, -3341.85, 13.94),heading = 63.87} -- The location where the testdrive vehicle will be spawned.

Config.Blip = {
  id = 326,
  color = 3,
  scale = 0.8,
  label = "Galeri",
  showBlip = true
}

------------------------------------------------------------------------------------------------------------------------
-- Vehicle Stock
------------------------------------------------------------------------------------------------------------------------

Config.Hour = 20 -- The time when new vehicles will be added to the stock.
Config.NumOfVehicles = 5 -- The amount of vehicles that will be added to the stock.

-- Every day the stock renewing itself with 5 (Config.NumOfVehicles = 5) new vehicles at 12:00 p.m. (Config.Hour = 12).
-- In order for the stock to work you need to call the Config.SetDefaultStockEvent function, Otherwise the stock will be UNLIMITED. 

------------------------------------------------------------------------------------------------------------------------
-- Test Drive
------------------------------------------------------------------------------------------------------------------------

Config.TestDrive = {
    testDriveTimer = 30, -- Duration of the test drive (seconds).
    testDriveCost = 350, -- The price of the test drive.
}

------------------------------------------------------------------------------------------------------------------------
-- Categories And Vehicles
------------------------------------------------------------------------------------------------------------------------

Config.Vehicles = {
    {
      title = "İmport Araçlar", -- Title of category.
      buttons = {
        {name = "Nissan GT R-35", costs = 4000, model = "r35", maxStock = 10},
        {name = "Mitsubishi Evo 9", costs = 13000, model = "evo9", maxStock = 10},
        {name = "Mercedes GTR-C", costs = 20000, model = "gtrc", maxStock = 10},
        {name = "BMW M5", costs = 8000, model = "22m5", maxStock = 10},
        {name = "Ferrari Misha", costs = 9000, model = "488misha", maxStock = 10},
        {name = "500gtrlam", costs = 9000, model = "Lamborghini Diablo", maxStock = 10},
        {name = "2016 Mclaren 675LT Spider", costs = 9000, model = "675ltsp", maxStock = 10},
        {name = "McLaren 720S", costs = 9000, model = "720s", maxStock = 10},
        {name = "Totoya Supra A80", costs = 9000, model = "a80", maxStock = 10},
        {name = "BMW I8", costs = 9000, model = "acs8", maxStock = 10},
        {name = "Honda S2000", costs = 9000, model = "ap2", maxStock = 10},
        {name = "2014 Audi RS6", costs = 9000, model = "audirs6tk", maxStock = 10},
        {name = "BMW R", costs = 9000, model = "bmwr", maxStock = 10},
        {name = "The Brabham BT62R", costs = 9000, model = "bt62r", maxStock = 10},
        {name = "Corvette C7", costs = 9000, model = "c7", maxStock = 10},
        {name = "2018 Bentley Continental GT Supersports", costs = 9000, model = "contss18", maxStock = 10},
        {name = "Honda Integra Type-R DC5", costs = 9000, model = "dc5", maxStock = 10},
        {name = "Honda Civic EG VTI 94", costs = 9000, model = "delsoleg", maxStock = 10},
        {name = "Dodge Challenger SRT Demon", costs = 9000, model = "demon", maxStock = 10},
        {name = "1992 BMW M3 E36", costs = 9000, model = "e36prb", maxStock = 10},
        {name = "2015 Cadillac Escalade ESV", costs = 9000, model = "esv", maxStock = 10},
        {name = "Mitsubishi EVO 9", costs = 9000, model = "evo9", maxStock = 10},
        {name = "Chevrolet Camaro", costs = 9000, model = "exor", maxStock = 10},
        {name = "Ford F150", costs = 9000, model = "f150", maxStock = 10},
        {name = "Acura NSX (F7LTHY)", costs = 9000, model = "filthynsx", maxStock = 10},
        {name = "Honda / Civic / 2.0 / Type-R", costs = 9000, model = "fk8", maxStock = 10},
        {name = "Nissan Skyline R-34", costs = 9000, model = "fnf4r34", maxStock = 10},
        {name = "Mazda RX7 Sprit", costs = 9000, model = "fnfrx7", maxStock = 10},
        {name = "Ford GT17", costs = 9000, model = "gt17", maxStock = 10},
        {name = "Mercedes AMG GT63 S E", costs = 9000, model = "gt63", maxStock = 10},
        {name = "Toyota GT86", costs = 9000, model = "gt86", maxStock = 10},
        {name = "Nissan GT-R35", costs = 9000, model = "gtr", maxStock = 10},
        {name = "Mercedes-AMG GT R", costs = 9000, model = "gtrc", maxStock = 10},
        {name = "Lamborghini Aventador", costs = 9000, model = "tempesta2", maxStock = 10},
        {name = "Toyota Supra GR2020", costs = 9000, model = "tsgr20", maxStock = 10},
        {name = "Ford Mustang 2019", costs = 9000, model = "mustang19", maxStock = 10},
        {name = "Audi R8 V10 Decennium", costs = 9000, model = "r8v10", maxStock = 10},
        {name = "BMW M5 E60", costs = 9000, model = "m5e60", maxStock = 10},
        {name = "BMW M3 E46", costs = 9000, model = "m3e46", maxStock = 10},
        {name = "BMW M4", costs = 9000, model = "m4", maxStock = 10},
        {name = "Honda NSX NA1", costs = 9000, model = "na1", maxStock = 10},
        {name = "Lamborghini LP670", costs = 9000, model = "lp670", maxStock = 10},
        {name = "Lamborghini LP700", costs = 9000, model = "lp700", maxStock = 10},
        {name = "Nissan GT-R35 Custom", costs = 9000, model = "r35", maxStock = 10},
        {name = "Nissan Silvia S15", costs = 9000, model = "s15rb", maxStock = 10},
        {name = "Porche Panemera 17", costs = 9000, model = "panemera17turbo", maxStock = 10},
        {name = "Subaru WRX", costs = 9000, model = "subwrx", maxStock = 10},
        {name = "Audi R8H", costs = 9000, model = "r8h", maxStock = 10},
        {name = "Jeep SRT-8 2015", costs = 9000, model = "srt8b", maxStock = 10},
        {name = "Honda Odyssey Touring ", costs = 9000, model = "honody", maxStock = 10},
        {name = "Hyundai Veloster", costs = 9000, model = "veln", maxStock = 10},
        {name = "Aston Martin DB11", costs = 9000, model = "db11", maxStock = 10},
        {name = "Subaru Impreza 22B", costs = 9000, model = "22b", maxStock = 10},
        {name = "2012 Mercedes-Benz C63 AMG Coupe", costs = 9000, model = "mbc63", maxStock = 10},
        {name = "Nissan 180sx", costs = 9000, model = "nis180", maxStock = 10},
        {name = "Audi RS6 LK", costs = 9000, model = "audirs6lk", maxStock = 10},
        {name = "M4 2022", costs = 9000, model = "22m4", maxStock = 10},
        {name = "M5 2022", costs = 9000, model = "22M5", maxStock = 10},
      }
    },
    -- Examples:
    {
      title = "Compacts", -- Title of category.
      buttons = {
        {name = "Maxwell Asbo", costs = 4000, model = "Asbo", maxStock = 10},
        {name = "Dinka Blista", costs = 13000, model = "blista", maxStock = 10},
        {name = "Brioso R/A", costs = 20000, model = "brioso", maxStock = 10},
        {name = "Issi 7", costs = 20000, model = "issi7", maxStock = 10},
        {name = "Club BF", costs = 8000, model = "club", maxStock = 10},
        {name = "Karin Dilettante", costs = 9000, model = "dilettante", maxStock = 10},
        {name = "Karin Dilettante Patrol", costs = 12000, model = "dilettante2", maxStock = 10},
        {name = "Dinka Blista Kanjo", costs = 12000, model = "kanjo", maxStock = 10},
        {name = "Weeny Issi", costs = 7000, model = "issi2", maxStock = 10},
        {name = "Weeny Issi Classic", costs = 5000, model = "issi3", maxStock = 10},
        {name = "Benefactor Panto", costs = 3200, model = "panto", maxStock = 10},
        {name = "Bollokan Prairie", costs = 30000, model = "prairie", maxStock = 10},
        {name = "Declasse Rhapsody", costs = 10000, model = "rhapsody", maxStock = 10},
        {name = "Grotti Brioso 300", costs = 12000, model = "brioso2", maxStock = 10},
        {name = "BF Weevil", costs = 9000, model = "weevil", maxStock = 10},
      }
    },
    {
      title = "Coupes", -- Title of category.
      buttons = {
        {name = "Cognoscenti Cabrio Enus", costs = 30000, model = "cogcabrio", maxStock = 10},
        {name = "Exemplar Dewbauchee", costs = 40000, model = "exemplar", maxStock = 10},
        {name = "Ocelot F620", costs = 32500, model = "f620", maxStock = 10},
        {name = "Lampadati Felon", costs = 31000, model = "felon", maxStock = 10},
        {name = "Lampadati Felon GT", costs = 37000, model = "felon2", maxStock = 10},
        {name = "Ocelot Jackal", costs = 19000, model = "jackal", maxStock = 10},
        {name = "Übermacht Oracle", costs = 22000, model = "oracle", maxStock = 10},
        {name = "Übermacht Oracle XS", costs = 28000, model = "oracle2", maxStock = 10},
        {name = "Übermacht Sentinel", costs = 30000, model = "sentinel", maxStock = 10},
        {name = "Übermacht Sentinel XS", costs = 33000, model = "sentinel2", maxStock = 10},
        {name = "Enus Windsor", costs = 27000, model = "windsor", maxStock = 10},
        {name = "Enus Windsor Drop", costs = 34000, model = "windsor2", maxStock = 10},
        {name = "Übermacht Zion", costs = 22000, model = "zion", maxStock = 10},
        {name = "Übermacht Zion Cabrio", costs = 28000, model = "zion2", maxStock = 10},
        {name = "Karin Previon", costs = 149000, model = "previon", maxStock = 10},
        {name = "Dewbauchee Champion", costs = 205000, model = "champion", maxStock = 10},
        {name = "Pegassi Ignus", costs = 1120000, model = "ignus", maxStock = 10},
        {name = "Överflöd Zeno", costs = 1350000, model = "zeno", maxStock = 10},
      }
    },
    {
      title = "Sedans", -- Title of category.
      buttons = {
        {name = "Asea", costs = 30000, model = "asea", maxStock = 10},
        {name = "Asterope", costs = 30000, model = "asterope", maxStock = 10},
        {name = "Enus Cognoscenti 55", costs = 30000, model = "cog55", maxStock = 10},
        {name = "Cheval Fugitive", costs = 20000, model = "fugitive", maxStock = 10},
        {name = "Cinquemila Lampadati", costs = 125000, model = "cinquemila", maxStock = 10},
        {name = "Obey I-Wagen", costs = 225000, model = "iwagen", maxStock = 10},
        {name = "Enus Deity", costs = 505000, model = "deity", maxStock = 10},
        {name = "Enus Jubilee", costs = 485000, model = "jubilee", maxStock = 10},
        {name = "Albany V-STR", costs = 80000, model = "vstr", maxStock = 10},
        {name = "Glendale", costs = 80000, model = "glendale", maxStock = 10},
        {name = "Intruder", costs = 80000, model = "intruder", maxStock = 10},
        {name = "Premier", costs = 80000, model = "premier", maxStock = 10},
        {name = "Primo", costs = 80000, model = "primo", maxStock = 10},
        {name = "Primo XS", costs = 80000, model = "primo2", maxStock = 10},
        {name = "Stanier", costs = 80000, model = "stanier", maxStock = 10},
        {name = "Stratum", costs = 80000, model = "stratum", maxStock = 10},
        {name = "Super Diamond", costs = 80000, model = "superd", maxStock = 10},
        {name = "Surges", costs = 80000, model = "surgge", maxStock = 10},
        {name = "Tailgater", costs = 80000, model = "tailgater", maxStock = 10},
        {name = "Washington", costs = 80000, model = "washington", maxStock = 10},
      }
    },
    {
      title = "Sports", -- Title of category.
      buttons = {
        {name = "Alpha", costs = 37000, model = "alpha", maxStock = 10},
        {name = "Futo", costs = 37000, model = "futo", maxStock = 10},
        {name = "Fusilade", costs = 37000, model = "fusilade", maxStock = 10},
        {name = "Banshee", costs = 37000, model = "banshee", maxStock = 10},
        {name = "Grotti Bestia GTS", costs = 37000, model = "bestiagts", maxStock = 10},
        {name = "Bravado Buffalo S", costs = 24500, model = "buffalo2", maxStock = 10},
        {name = "Pfister Comet S2 Cabrio", costs = 250000, model = "comet7", maxStock = 10},
        {name = "Carbonizzare", costs = 250000, model = "carbonizzare", maxStock = 10},
        {name = "Pfister Comet", costs = 250000, model = "comet2", maxStock = 10},
        {name = "Pfister Comet Retro", costs = 175000, model = "comet3", maxStock = 10},
        {name = "Pfister Comet SR", costs = 155000, model = "comet5", maxStock = 10},
        {name = "Pfister Comet XXL", costs = 155000, model = "comet6", maxStock = 10},
        {name = "Invetero Coquette", costs = 145000, model = "coquette", maxStock = 10},
        {name = "Invetero Coquette D10", costs = 220000, model = "coquette4", maxStock = 10},
        {name = "Obey 8F Drafter", costs = 80000, model = "drafter", maxStock = 10},
        {name = "Annis Elegy Retro Custom", costs = 145000, model = "elegy", maxStock = 10},
        {name = "Annis Elegy RH8", costs = 150000, model = "elegy2", maxStock = 10},
        {name = "Benefactor Feltzer", costs = 97000, model = "feltzer2", maxStock = 10},
        {name = "Vapid Flash GT", costs = 48000, model = "flashgt", maxStock = 10},
        {name = "Lampadati Furore GT", costs = 78000, model = "furoregt", maxStock = 10},
        {name = "Lampadati Komoda", costs = 105000, model = "komoda", maxStock = 10},
        {name = "Överflöd Imorgon", costs = 120000, model = "imorgon", maxStock = 10},
        {name = "Progen Itali GTO", costs = 260000, model = "italigto", maxStock = 10},
        {name = "Ocelot Jugular", costs = 100000, model = "jugular", maxStock = 10},
        {name = "Dinka Jester", costs = 132250, model = "jester", maxStock = 10},
        {name = "Dinka Jester Classic", costs = 115000, model = "jester3", maxStock = 10},
        {name = "Ocelot Locust", costs = 200000, model = "locust", maxStock = 10},
        {name = "Ocelot Lynx", costs = 150000, model = "lynx", maxStock = 10},
        {name = "Dewbauchee Massacro", costs = 110000, model = "massacro", maxStock = 10},
        {name = "Vysser Neo", costs = 230000, model = "neo", maxStock = 10},
        {name = "Pfister Neon", costs = 220000, model = "neon", maxStock = 10},
        {name = "Obey 9F Cabrio", costs = 105000, model = "ninef2", maxStock = 10},
        {name = "Enus Paragon", costs = 135000, model = "paragon", maxStock = 10},
        {name = "Maibatsu Penumbra FF", costs = 89000, model = "penumbra2", maxStock = 10},
        {name = "Dewbauchee Rapid GT Convertible", costs = 92000, model = "rapidgt2", maxStock = 10},
        {name = "Übermacht Revolter", costs = 95000, model = "revolter", maxStock = 10},
        {name = "Hijak Ruston", costs = 130000, model = "ruston", maxStock = 10},
        {name = "Benefactor Schlagen GT", costs = 160000, model = "schlagen", maxStock = 10},
        {name = "Dewbauchee Seven-70", costs = 140000, model = "seven70", maxStock = 10},
        {name = "Dewbauchee Specter", costs = 160000, model = "specter", maxStock = 10},
        {name = "Progen Itali RSX", costs = 260000, model = "italirsx", maxStock = 10},
        {name = "Karin Sultan CR", costs = 55000, model = "sultan2", maxStock = 10},
        {name = "Pariah", costs = 55000, model = "pariah", maxStock = 10},
        {name = "Raiden", costs = 55000, model = "raiden", maxStock = 10},
        {name = "Schafter3", costs = 55000, model = "schafter3", maxStock = 10},
        {name = "Dinka Sugoi", costs = 85000, model = "sugoi", maxStock = 10},
        {name = "Surano", costs = 85000, model = "surano", maxStock = 10},
        {name = "Remus", costs = 85000, model = "remus", maxStock = 10},
        {name = "Growler", costs = 85000, model = "growler", maxStock = 10},
        {name = "rt3000", costs = 85000, model = "growler", maxStock = 10},
      }
    },
    {
      title = "Sports Classic", -- Title of category.
      buttons = {
        {name = "Casco", costs = 165000, model = "casco", maxStock = 10},
        {name = "Gt500", costs = 165000, model = "gt500", maxStock = 10},
        {name = "İnfernus2", costs = 165000, model = "infernus2", maxStock = 10},
        {name = "Pigalle", costs = 165000, model = "pigalle", maxStock = 10},
        {name = "Rapidgt3", costs = 165000, model = "rapidgt3", maxStock = 10},
        {name = "Turismo2", costs = 165000, model = "turismo2", maxStock = 10},
        {name = "Z190", costs = 165000, model = "z190", maxStock = 10},
        {name = "Viseris", costs = 165000, model = "viseris", maxStock = 10},
        {name = "Cheburek", costs = 165000, model = "cheburek", maxStock = 10},
        {name = "Feltzer3", costs = 165000, model = "feltzer3", maxStock = 10},
        {name = "Btype", costs = 165000, model = "btype", maxStock = 10},
        {name = "Btype2", costs = 165000, model = "btype2", maxStock = 10},
        {name = "Btyp3", costs = 165000, model = "btyp3", maxStock = 10},
        {name = "Coquette2", costs = 165000, model = "coquette2", maxStock = 10},
        {name = "Cheetah2", costs = 165000, model = "cheetah2", maxStock = 10},
        {name = "Dynasty", costs = 165000, model = "dynasty", maxStock = 10},
        {name = "Mamba", costs = 165000, model = "mamba", maxStock = 10},
        {name = "Monroe", costs = 165000, model = "monroe", maxStock = 10},
        {name = "Retinue", costs = 165000, model = "retinue", maxStock = 10},
        {name = "Retinue2", costs = 165000, model = "retinue2", maxStock = 10},
        {name = "Stinger", costs = 165000, model = "stinger", maxStock = 10},
        {name = "Swinger", costs = 165000, model = "swinger", maxStock = 10},
        {name = "Zion3", costs = 165000, model = "zion3", maxStock = 10},
      }
    },
    {
      title = "Super", -- Title of category.
      buttons = {
        {name = "Zorrusso", costs = 30000, model = "zorrusso", maxStock = 10},
        {name = "Visione", costs = 30000, model = "visione", maxStock = 10},
        {name = "Italigtb2", costs = 30000, model = "italigtb2", maxStock = 10},
        {name = "Pfister811", costs = 30000, model = "pfister811", maxStock = 10},
        {name = "Krieger", costs = 30000, model = "krieger", maxStock = 10},
        {name = "Tempesta", costs = 30000, model = "tempesta", maxStock = 10},
        {name = "Furia", costs = 30000, model = "furia", maxStock = 10},
        {name = "Adder", costs = 30000, model = "adder", maxStock = 10},
        {name = "Entityxf", costs = 30000, model = "entityxf", maxStock = 10},
        {name = "Fmj", costs = 30000, model = "fmj", maxStock = 10},
        {name = "Nero", costs = 30000, model = "nero", maxStock = 10},
        {name = "Nero2", costs = 30000, model = "nero2", maxStock = 10},
        {name = "Sheava", costs = 30000, model = "sheava", maxStock = 10},
        {name = "Xa21", costs = 30000, model = "xa21", maxStock = 10},
        {name = "Thrax", costs = 30000, model = "thrax", maxStock = 10},
        {name = "Zeno", costs = 30000, model = "zeno", maxStock = 10},
        {name = "Corsita", costs = 30000, model = "corsita", maxStock = 10},
        {name = "Torero2", costs = 30000, model = "torero2", maxStock = 10},
        {name = "Corsita", costs = 30000, model = "corsita", maxStock = 10},
        {name = "Banshee2", costs = 30000, model = "banshee2", maxStock = 10},
        {name = "Bullet", costs = 30000, model = "bullet", maxStock = 10},
        {name = "Entity2", costs = 30000, model = "entity2", maxStock = 10},
        {name = "Emerus", costs = 30000, model = "emerus", maxStock = 10},
        {name = "Gp1", costs = 30000, model = "gp1", maxStock = 10},
        {name = "Infernus", costs = 30000, model = "infernus", maxStock = 10},
        {name = "Osiris", costs = 30000, model = "osiris", maxStock = 10},
        {name = "Reaper", costs = 30000, model = "reaper", maxStock = 10},
        {name = "Sc1", costs = 30000, model = "sc1", maxStock = 10},
        {name = "Sheava", costs = 30000, model = "sheava", maxStock = 10},
        {name = "Sultanrs", costs = 30000, model = "sultanrs", maxStock = 10},
        {name = "Issi 8", costs = 20000, model = "issi8", maxStock = 10},
        {name = "T20", costs = 30000, model = "t20", maxStock = 10},
        {name = "Thrax", costs = 30000, model = "thrax", maxStock = 10},
        {name = "Turismor", costs = 30000, model = "turismor", maxStock = 10},
        {name = "Tyrant", costs = 30000, model = "tyrant", maxStock = 10},
        {name = "Tyrus", costs = 30000, model = "tyrus", maxStock = 10},
        {name = "Vacca", costs = 30000, model = "vacca", maxStock = 10},
        {name = "Vagner", costs = 30000, model = "vagner", maxStock = 10},
        {name = "Visione", costs = 30000, model = "visione", maxStock = 10},
        {name = "Zentorno", costs = 30000, model = "zentorno", maxStock = 10},
        {name = "Zorrusso", costs = 30000, model = "zorrusso", maxStock = 10},

      }
    },
    {
      title = "Muscle", -- Title of category.
      buttons = {
        {name = "Imperator", costs = 23500, model = "imperator", maxStock = 10},
        {name = "Hermes", costs = 23500, model = "hermes", maxStock = 10},
        {name = "Vapid Blade", costs = 23500, model = "blade", maxStock = 10},
        {name = "clique", costs = 23500, model = "clique", maxStock = 10},
        {name = "Albany Buccaneer", costs = 24500, model = "buccaneer", maxStock = 10},
        {name = "ellie", costs = 24500, model = "ellie", maxStock = 10},
        {name = "Albany Buccaneer Lux", costs = 24500, model = "buccaneer2", maxStock = 10},
        {name = "Vapid Chino", costs = 28500, model = "chino", maxStock = 10},
        {name = "Vapid Chino Lux", costs = 28500, model = "chino2", maxStock = 10},
        {name = "Schyster Deviant", costs = 70000, model = "deviant", maxStock = 10},
        {name = "Invetero Coquette BlackFin", costs = 80000, model = "coquette3", maxStock = 10},
        {name = "Vapid Dominator GTX", costs = 70000, model = "dominator3", maxStock = 10},
        {name = "Vapid Dominator ASP", costs = 110000, model = "dominator7", maxStock = 10},
        {name = "Vapid Dominator GTT", costs = 80000, model = "dominator8", maxStock = 10},
        {name = "Hustler", costs = 110000, model = "hustlers", maxStock = 10},
        {name = "Dukes", costs = 110000, model = "dukes", maxStock = 10},
        {name = "Willard Faction GT", costs = 70000, model = "faction2", maxStock = 10},
        {name = "Bravado Gauntlet Hellfire", costs = 80000, model = "gauntlet4", maxStock = 10},
        {name = "Bravado Gauntlet", costs = 80000, model = "gauntlet", maxStock = 10},
        {name = "Bravado Gauntlet Classic Custom", costs = 120000, model = "gauntlet5", maxStock = 10},
        {name = "Vapid Hotknife", costs = 90000, model = "hotknife", maxStock = 10},
        {name = "Vapid Impaler", costs = 95000, model = "impaler", maxStock = 10},
        {name = "Vapid Impaler XS", costs = 95000, model = "impaler2", maxStock = 10},
        {name = "Declasse Moonbeam", costs = 130000, model = "moonbeam2", maxStock = 10},
        {name = "Imponte Nightshade", costs = 70000, model = "nightshade", maxStock = 10},
        {name = "Declasse Sabre GT", costs = 95000, model = "sabregt", maxStock = 10},
        {name = "Declasse Sabre GT Turbo", costs = 95000, model = "sabregt2", maxStock = 10},
        {name = "Vapid Slam Van", costs = 47000, model = "slamvan3", maxStock = 10},
        {name = "Tulip", costs = 47000, model = "tulip", maxStock = 10},
        {name = "Vamos", costs = 47000, model = "vamos", maxStock = 10},
        {name = "Dundreary Virgo Custom", costs = 39800, model = "virgo2", maxStock = 10},
        {name = "Bravado Buffalo STX", costs = 345000, model = "buffalo4", maxStock = 10},
        {name = "Picador", costs = 9000, model = "picador", maxStock = 10},
        {name = "Ruiner", costs = 9000, model = "ruiner", maxStock = 10},
        {name = "Vigero", costs = 9000, model = "vigero", maxStock = 10},
        {name = "Yosemite", costs = 9000, model = "yosemite", maxStock = 10},
        {name = "Phoenix", costs = 9000, model = "phoenix", maxStock = 10},
        {name = "Voodoo", costs = 9000, model = "voodoo", maxStock = 10},
      }
    },
    {
      title = "SUV", -- Title of category.
      buttons = {
        {name = "Gallivanter Baller", costs = 98000, model = "baller", maxStock = 10},
        {name = "Gallivanter Baller X", costs = 98000, model = "baller3", maxStock = 10},
        {name = "Gallivanter Baller LE LWB", costs = 98000, model = "baller4", maxStock = 10},
        {name = "Gallivanter Baller ST", costs = 145000, model = "baller7", maxStock = 10},
        {name = "Karin BeeJay XL", costs = 39000, model = "bjxl", maxStock = 10},
        {name = "Albany Cavalcade", costs = 24000, model = "cavalcade2", maxStock = 10},
        {name = "Vapid Contender", costs = 35000, model = "contender", maxStock = 10},
        {name = "Benefactor Dubsta", costs = 32000, model = "dubsta", maxStock = 10},
        {name = "Benefactor Dubsta L", costs = 32000, model = "dubsta2", maxStock = 10},
        {name = "Fathom FQ2", costs = 32000, model = "fq2", maxStock = 10},
        {name = "Declasse Granger", costs = 29000, model = "granger", maxStock = 10},
        {name = "Bravado Gresley", costs = 25000, model = "gresley", maxStock = 10},
        {name = "Emperor Habanero", costs = 25000, model = "habanero", maxStock = 10},
        {name = "Enus Huntley", costs = 25000, model = "huntley", maxStock = 10},
        {name = "Dundreary Landstalker XL", costs = 25000, model = "landstalker2", maxStock = 10},
        {name = "Lampadati Novak", costs = 70000, model = "novak", maxStock = 10},
        {name = "Mammoth Patriot Stretch", costs = 21000, model = "patriot2", maxStock = 10},
        {name = "Übermacht Rebla GTS", costs = 21000, model = "rebla", maxStock = 10},
        {name = "Obey Rocoto", costs = 13000, model = "rocoto", maxStock = 10},
        {name = "Canis Seminole", costs = 20000, model = "seminole", maxStock = 10},
        {name = "Canis Seminole Frontier", costs = 20000, model = "seminole2", maxStock = 10},
        {name = "Pegassi Toros", costs = 75000, model = "toros", maxStock = 10},
        {name = "Benefactor XLS", costs = 68000, model = "xls", maxStock = 10},
        {name = "Declasse Granger 3600LX", costs = 221000, model = "granger2", maxStock = 10},
        {name = "Pfister Astron", costs = 150000, model = "astron", maxStock = 10},
      }
    },
    {
      title = "Off Road", -- Title of category.
      buttons = {
        {name = "Annis Bifta", costs = 15500, model = "bifta", maxStock = 10},
        {name = "Vapid Caracara", costs = 60000, model = "caracara", maxStock = 10},
        {name = "Vapid Caracara 4x4", costs = 80000, model = "caracara2", maxStock = 10},
        {name = "Annis Dubsta 6x6", costs = 54000, model = "dubsta3", maxStock = 10},
        {name = "Karin Everon", costs = 60000, model = "everon", maxStock = 10},
        {name = "Canis Freecrawler", costs = 75000, model = "freecrawler", maxStock = 10},
        {name = "Annis Hellion", costs = 38000, model = "hellion", maxStock = 10},
        {name = "Canis Kamacho", costs = 50000, model = "kamacho", maxStock = 10},
        {name = "Vapid Riata", costs = 80000, model = "riata", maxStock = 10},
        {name = "Vapid Sandking XL", costs = 57000, model = "sandking", maxStock = 10},
        {name = "Vapid Sandking SWB", costs = 47000, model = "sandking2", maxStock = 10},
        {name = "Vapid Trophy", costs = 47000, model = "trophytruck", maxStock = 10},
        {name = "Vapid Desert Raid", costs = 47000, model = "trophytruck2", maxStock = 10},
        {name = "Maxwell Vagrant", costs = 50000, model = "vagrant", maxStock = 10},
        {name = "Dinka Verus", costs = 20000, model = "verus", maxStock = 10},
        {name = "Annis Bf Injection", costs = 9000, model = "bfinjection", maxStock = 10},
      }
    },
    {
      title = "Motorcycles", -- Title of category.
      buttons = {
        {name = "Dinka Akuma", costs = 55000, model = "akuma", maxStock = 10},
        {name = "LCC Avarus", costs = 20000, model = "avarus", maxStock = 10},
        {name = "WMC Bagger", costs = 13500, model = "bagger", maxStock = 10},
        {name = "Pegassi Bati 801", costs = 19000, model = "bati", maxStock = 10},
        {name = "Pegassi Bati 801RR", costs = 24000, model = "bati2", maxStock = 10},
        {name = "Nagasaki BF400", costs = 22000, model = "bf400", maxStock = 10},
        {name = "Nagasaki Carbon RS", costs = 22000, model = "carbonrs", maxStock = 10},
        {name = "Nagasaki Chimera", costs = 21000, model = "chimera", maxStock = 10},
        {name = "Western Cliffhanger", costs = 28500, model = "cliffhanger", maxStock = 10},
        {name = "WMC Daemon", costs = 14000, model = "daemon", maxStock = 10},
        {name = "Western Daemon Custom", costs = 23000, model = "daemon2", maxStock = 10},
        {name = "Shitzu Defiler", costs = 30000, model = "defiler", maxStock = 10},
        {name = "Principe Diablous", costs = 30000, model = "diablous", maxStock = 10},
        {name = "Principe Diablous Custom", costs = 38000, model = "diablous2", maxStock = 10},
        {name = "Dinka Double-T", costs = 28000, model = "double", maxStock = 10},
        {name = "Pegassi Esskey", costs = 12000, model = "esskey", maxStock = 10},
        {name = "Pegassi FCR 1000", costs = 15000, model = "fcr", maxStock = 10},
        {name = "Pegassi FCR 1000 Custom", costs = 19000, model = "fcr2", maxStock = 10},
        {name = "Shitzu Hakuchou", costs = 17000, model = "hakuchou", maxStock = 10},
        {name = "LLC Innovation", costs = 33500, model = "innovation", maxStock = 10},
        {name = "Principe Lectro", costs = 28000, model = "lectro", maxStock = 10},
        {name = "WMC Nightblade", costs = 23000, model = "nightblade", maxStock = 10},
        {name = "Nagasaki Stryder", costs = 50000, model = "stryder", maxStock = 10},
        {name = "Dinka Vindicator", costs = 39000, model = "vindicator", maxStock = 10},
        {name = "Nagasaki Shinobi", costs = 35000, model = "shinobi", maxStock = 10},
        {name = "Western Reever", costs = 25000, model = "reever", maxStock = 10},
      }
    },
}
for k, v in pairs(Config.Vehicles) do 
  for key, value in pairs(v.buttons) do 
    value.hash = GetHashKey(value.model)
  end
end
exports("araclar", function()
  return Config.Vehicles
end)
-- Explanation of the buttons:
--[[
    name = vehicle's label (The name which is displayed in the vehicle menu).
    costs = vehicle's price.
    model = vehicle's model.
    stock = The maximum stock a vehicle can reach (Explanation from above).
]]

------------------------------------------------------------------------------------------------------------------------
-- Color selection:
------------------------------------------------------------------------------------------------------------------------

-- Full list of colors - https://wiki.rage.mp/index.php?title=Vehicle_Colors
Config.Colors = {
  {r = 13, g = 17, b = 22, colorName = "Metallic Black", gtaColor = 0},
  {r = 28, g = 29, b = 33, colorName = "Metallic Graphite Black", gtaColor = 1},
  {r = 50, g = 56, b = 61, colorName = "Metallic Black Steal", gtaColor = 2},
  {r = 69, g = 75, b = 79, colorName = "Metallic Dark Silver", gtaColor = 3},
  {r = 153, g = 157, b = 160, colorName = "Metallic Silver", gtaColor = 4},
  {r = 194, g = 196, b = 198, colorName = "Metallic Blue Silver", gtaColor = 5},
  {r = 151, g = 154, b = 151, colorName = "Metallic Steel Gray", gtaColor = 6},
  {r = 99, g = 115, b = 128, colorName = "Metallic Shadow Silver", gtaColor = 7},
  {r = 99, g = 98, b = 92, colorName = "Metallic Stone Silver", gtaColor = 8},
  {r = 60, g = 63, b = 71, colorName = "Metallic Midnight Silver", gtaColor = 9},
  {r = 68, g = 78, b = 84, colorName = "Metallic Gun Metal", gtaColor = 10},
  {r = 29, g = 33, b = 41, colorName = "Metallic Anthracite Grey", gtaColor = 11},
  {r = 99, g = 98, b = 92, colorName = "Matte Black", gtaColor = 12},
  {r = 38, g = 40, b = 42, colorName = "Matte Gray", gtaColor = 13},
  {r = 81, g = 85, b = 84, colorName = "Matte Light Grey", gtaColor = 14},
  {r = 21, g = 25, b = 33, colorName = "Util Black", gtaColor = 15},
  {r = 30, g = 36, b = 41, colorName = "Util Black Poly", gtaColor = 16},
  {r = 51, g = 58, b = 60, colorName = "Util Dark Silver", gtaColor = 17},
  {r = 140, g = 144, b = 149, colorName = "Util Silver", gtaColor = 18},
  {r = 57, g = 67, b = 77, colorName = "Util Gun Metal", gtaColor = 19},
  {r = 80, g = 98, b = 114, colorName = "Util Shadow Silver", gtaColor = 20},
  {r = 30, g = 35, b = 47, colorName = "Worn Black", gtaColor = 21},
  {r = 54, g = 58, b = 63, colorName = "Worn Graphite", gtaColor = 22},
  {r = 160, g = 161, b = 153, colorName = "Worn Silver Grey", gtaColor = 23},
  {r = 211, g = 211, b = 211, colorName = "Worn Silver", gtaColor = 24},
  {r = 183, g = 191, b = 202, colorName = "Worn Blue Silver", gtaColor = 25},
  {r = 119, g = 135, b = 148, colorName = "Worn Shadow Silver", gtaColor = 26},
  {r = 192, g = 14, b = 26, colorName = "Metallic Red", gtaColor = 27},
  {r = 218, g = 25, b = 24, colorName = "Metallic Torino Red", gtaColor = 28},
  {r = 182, g = 17, b = 27, colorName = "Metallic Formula Red", gtaColor = 29},
  {r = 165, g = 30, b = 35, colorName = "Metallic Blaze Red", gtaColor = 30},
  {r = 123, g = 26, b = 34, colorName = "Metallic Graceful Red", gtaColor = 31},
  {r = 142, g = 27, b = 31, colorName = "Metallic Garnet Red", gtaColor = 32},
  {r = 111, g = 24, b = 24, colorName = "Metallic Desert Red", gtaColor = 33},
  {r = 73, g = 17, b = 29, colorName = "Metallic Cabernet Red", gtaColor = 34},
  {r = 99, g = 98, b = 92, colorName = "Metallic Candy Red", gtaColor = 35},
  {r = 212, g = 74, b = 23, colorName = "Metallic Sunrise Orange", gtaColor = 36},
  {r = 194, g = 148, b = 79, colorName = "Metallic Classic Gold", gtaColor = 37},
  {r = 247, g = 134, b = 22, colorName = "Metallic Orange", gtaColor = 38},
  {r = 207, g = 31, b = 33, colorName = "Matte Red", gtaColor = 39},
  {r = 115, g = 32, b = 33, colorName = "Matte Dark Red", gtaColor = 40},
  {r = 242, g = 125, b = 32, colorName = "Matte Orange", gtaColor = 41},
  {r = 255, g = 201, b = 31, colorName = "Matte Yellow", gtaColor = 42},
  {r = 156, g = 16, b = 22, colorName = "Util Red", gtaColor = 43},
  {r = 222, g = 15, b = 24, colorName = "Util Bright Red", gtaColor = 44},
  {r = 143, g = 30, b = 23, colorName = "Util Garnet Red", gtaColor = 45},
  {r = 169, g = 71, b = 68, colorName = "Worn Red", gtaColor = 46},
  {r = 177, g = 108, b = 81, colorName = "Worn Golden Red", gtaColor = 47},
  {r = 55, g = 28, b = 37, colorName = "Worn Dark Red", gtaColor = 48},
  {r = 19, g = 36, b = 40, colorName = "Metallic Dark Green", gtaColor = 49},
  {r = 18, g = 46, b = 43, colorName = "Metallic Racing Green", gtaColor = 50},
  {r = 18, g = 56, b = 60, colorName = "Metallic Sea Green", gtaColor = 51},
  {r = 49, g = 66, b = 63, colorName = "Metallic Olive Green", gtaColor = 52},
  {r = 21, g = 92, b = 45, colorName = "Metallic Green", gtaColor = 53},
  {r = 27, g = 103, b = 112, colorName = "Metallic Gasoline Blue Green", gtaColor = 54},
  {r = 102, g = 184, b = 31, colorName = "Matte Lime Green", gtaColor = 55},
  {r = 34, g = 56, b = 62, colorName = "Util Dark Green", gtaColor = 56},
  {r = 29, g = 90, b = 63, colorName = "Util Green", gtaColor = 57},
  {r = 45, g = 66, b = 63, colorName = "Worn Dark Green", gtaColor = 58},
  {r = 69, g = 89, b = 75, colorName = "Worn Green", gtaColor = 59},
  {r = 101, g = 134, b = 127, colorName = "Worn Sea Wash", gtaColor = 60},
  {r = 34, g = 46, b = 70, colorName = "Metallic Midnight Blue", gtaColor = 61},
  {r = 35, g = 49, b = 85, colorName = "Metallic Dark Blue", gtaColor = 62},
  {r = 48, g = 76, b = 126, colorName = "Metallic Saxony Blue", gtaColor = 63},
  {r = 71, g = 87, b = 143, colorName = "Metallic Blue", gtaColor = 64},
  {r = 99, g = 123, b = 167, colorName = "Metallic Mariner Blue", gtaColor = 65},
  {r = 57, g = 71, b = 98, colorName = "Metallic Harbor Blue", gtaColor = 66},
  {r = 214, g = 231, b = 241, colorName = "Metallic Diamond Blue", gtaColor = 67},
  {r = 118, g = 175, b = 190, colorName = "Metallic Surf Blue", gtaColor = 68},
  {r = 39, g = 81, b = 144, colorName = "Util Blue", gtaColor = 77},
  {r = 66, g = 113, b = 225, colorName = "Util Maui Blue Poly", gtaColor = 80},
  {r = 37, g = 58, b = 167, colorName = "Matte Blue", gtaColor = 83},
  {r = 255, g = 207, b = 32, colorName = "Metallic Taxi Yellow", gtaColor = 88},
  {r = 251, g = 226, b = 18, colorName = "Metallic Race Yellow", gtaColor = 89},
  {r = 80, g = 50, b = 24, colorName = "Metallic Pueblo Beige", gtaColor = 94},
  {r = 34, g = 27, b = 25, colorName = "Metallic Choco Brown", gtaColor = 96},
  {r = 172, g = 153, b = 117, colorName = "Metallic Straw Beige", gtaColor = 99},
  {r = 117, g = 43, b = 25, colorName = "Metallic Choco Orange", gtaColor = 104},
  {r = 223, g = 213, b = 178, colorName = "Metallic Sun Bleeched Sand", gtaColor = 106},
  {r = 247, g = 237, b = 213, colorName = "Metallic Cream", gtaColor = 107},
  {r = 120, g = 95, b = 51, colorName = "Util Medium Brown", gtaColor = 109},
  {r = 255, g = 255, b = 246, colorName = "Metallic White", gtaColor = 111},
  {r = 234, g = 234, b = 234, colorName = "Metallic Frost White", gtaColor = 112},
  {r = 176, g = 171, b = 148, colorName = "Worn Honey Beige", gtaColor = 113},
  {r = 53, g = 65, b = 88, colorName = "Brushed Black steel", gtaColor = 118},
  {r = 234, g = 230, b = 222, colorName = "Worn Off White", gtaColor = 121},
  {r = 223, g = 221, b = 208, colorName = "Util Off White", gtaColor = 122},
  {r = 242, g = 173, b = 46, colorName = "Worn Orange", gtaColor = 123},
  {r = 249, g = 164, b = 88, colorName = "Worn Light Orange", gtaColor = 124},
  {r = 78, g = 100, b = 67, colorName = "Matte Green", gtaColor = 128},
  {r = 246, g = 174, b = 32, colorName = "Orange", gtaColor = 138},
  {r = 176, g = 238, b = 110, colorName = "Green", gtaColor = 139},
  {r = 105, g = 103, b = 72, colorName = "Matte Olive Drab", gtaColor = 152},
  {r = 122, g = 108, b = 85, colorName = "Matte Desert Brown", gtaColor = 153},
  {r = 195, g = 180, b = 146, colorName = "Matte Desert Tan", gtaColor = 154},
  {r = 90, g = 99, b = 82, colorName = "Matte Foilage Green", gtaColor = 155},
}
-- Explanation of color selection:
--[[
    r,g,b = (The color rgb values according to your gta color).
    colorName = color's name (put whatever you want).
    gtaColor = the color number from gta list.
]]

------------------------------------------------------------------------------------------------------------------------
-- Functions:
------------------------------------------------------------------------------------------------------------------------

-- Client:
Config.BuyVehicleFunc = function(QBCore,vehicleEntity,vehicleName)
  --[[
    This function is called when the purchased vehicle's entity is created and after the player has paid for the vehicle. 
    Parameters:
      @Core: The current core object.
      @vehicleEntity: The purchased vehicle's entity after it's been created.
      @vehicleName: The model listed in Config.Vehicles.
    
    Example for implementation:
    ]]
    local vehicleProps = QBCore.Functions.GetVehicleProperties(vehicleEntity)
    local model = GetEntityModel(vehicleEntity)
    vehicleProps.displayName = vehicleName
    TriggerServerEvent('rn-vehicleshop:setVehicleOwned', vehicleProps)
end

Config.TestDriveFunc = function(QBCore,vehicleEntity)

end

-- Server:
Config.GetPlayerMoney = function(playerId,QBCore)
  --[[
    This function is used for getting the player's money.
    Parameters:
      @playerId: The player server id/source.
      @Core: The current core object.
    
    Example for Qbus implementation is down below.
    ]]
    if type(playerId) == "number" then
        local player = QBCore.Functions.GetPlayer(playerId)
        if player then
            return player.PlayerData.money["cash"]
        end
    end
end

Config.RemovePlayerMoney = function(playerId, amount, QBCore)
  --[[
    This function is used for paying for the vehicle/testdrive.
    Parameters:
      @playerId: The player server id/source.
      @amount: the amount to pay.
      @Core: The current core object.
    
    Example for Qbus implementation is down below.
    ]]
    local player = QBCore.Functions.GetPlayer(playerId)
    if player then
        player.Functions.RemoveMoney("bank", amount)
    end
end

Config.GetPlayerNameFunc = function(playerId,QBCore)
  --[[
    This function is used for getting the character's name.
    Parameters:
      @playerId: The player server id/source.
      @Core: The current core object.
    
    Example for Qbus implementation is down below.
    ]]
    local player = QBCore.Functions.GetPlayer(playerId)
    return player.PlayerData.charinfo.firstname .. " " .. player.PlayerData.charinfo.lastname 
end

Config.ResetStockEvent = {
    name = "rn-vehicleshop:resetstock", -- This event resets the vehicles' stock. [*Server Side*],
    safe_for_net = true --[[
        true = allows you to trigger the event from a client side script and from a server side script.
        false =  allows you to trigger the event from a server side script only.
    ]]
}
   
Config.SetDefaultStockEvent = {
  name = "rn-vehicleshop:setDefaultStock", -- This event generates the stock.json file with values from the config.lua [*It is recommended to do it on first launch.]
  safe_for_net = true --[[
    true = allows you to trigger the event from a client side script and from a server side script.
    false =  allows you to trigger the event from a server side script only.
  ]]
}
