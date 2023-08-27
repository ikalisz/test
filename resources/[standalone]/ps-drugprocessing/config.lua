Config = {}

Config.Delays = {
	WeedProcessing = 1000 * 10,
	MethProcessing = 1000 * 10,
	CokeProcessing = 1000 * 10,
	lsdProcessing = 1000 * 10,
	HeroinProcessing = 1000 * 10,
	thionylchlorideProcessing = 1000 * 10,
}

Config.CircleZones = {
	WeedField = {coords = vector3(-212.46, 2645.2, 49.46), name = ('Weed Farm'), radius = 100.0}, -- Kullanılmıyor
	WeedProcessing = {coords = vector3(-1169.44, -1572.93, 4.66), name = ('Weed Process'), radius = 100.0}, -- Kullanılmıyor
	
	MethProcessing = {coords = vector3(978.17, -147.98, -48.53), name = ('Meth Process'), radius = 20.0}, -- Meth Asit Birleştirme Konumu
	MethTemp = {coords = vector3(982.56, -145.59, -49.0), name = ('Meth Temperature'), radius = 20.0}, -- Sıcaklık Ayarlama Konumu
	MethBag = {coords = vector3(987.81, -140.43, -49.0), name = ('Meth Bagging'), radius = 20.0}, -- Meth Paketleme Konumu
 
	HydrochloricAcidFarm = {coords = vector3(-1069.25, 4945.57, 212.18), name = ('Hydrochloric Acid'), radius = 100.0}, -- Asitlerin Toplanma Bölgeleri
	SulfuricAcidFarm = {coords = vector3(-3026.89, 3334.91, 10.04), name = ('Sulfuric Acid'), radius = 100.0}, -- Asitlerin Toplanma Bölgeleri
	SodiumHydroxideFarm = {coords = vector3(1449.91, -1688.78, 66.32), name = ('Sodium Hydroxide'), radius = 50.0}, -- Asitlerin Toplanma Bölgeleri
	
	ChemicalsField = {coords = vector3(1264.97, 1803.96, 82.94), name = ('Chemicals'), radius = 100.0}, -- Kimsayal Varil Toplama Bölgesi
	ChemicalsConvertionMenu = {coords = vector3(3536.71, 3662.63, 28.12), name = ('Chemicals Process'), radius = 100.0}, -- Yukarıda ki kordinattan toplanılan varil bu kordinatta asitlere ayrıştırılıyor

	CokeField = {coords = vector3(5286.28, -5168.99, 25.0), name = ('Coke'), radius = 100.0}, -- Kokain Toplama Bölgesi
	CokeProcessing = {coords = vector3(5212.72, -5128.34, 7.04), name = ('Coke Process'), radius = 20.0},  -- Kokain İşleme Bölgesi
	CokePowder = {coords = vector3(5213.88, -5130.92, 6.21), name = ('Powder Cutting'), radius = 20.0}, -- Kokain İşleme Bölgesi 2
	CokeBrick = {coords = vector3(5215.83, -5129.82, 6.3), name = ('Brick Up Packages'), radius = 20.0}, -- Kokain Patkeleme Bölgesi
	
	HeroinField = {coords = vector3(-2339.15, -54.32, 95.05), name = ('Heroin'), radius = 100.0}, -- kullanılmıyor
	HeroinProcessing = {coords = vector3(1413.37, -2041.74, 52.0), name = ('Heroin Process'), radius = 100.0}, -- kullanılmıyor

	lsdProcessing = {coords = vector3(892.32, -2171.81, 32.29), name = ('LSD process'), radius = 100.0}, -- Kimsayal Varillerinden ayrıştırılan lsa burada lsd olarak çeviriliyor

	thionylchlorideProcessing = {coords = vector3(-679.59, 5800.46, 17.33), name = ('Thi Clo Process'), radius = 100.0}, -- Kullanılmıyor
}


Config.MethLab = {
	["enter"] = {
        coords = vector4(683.45, -789.7, 24.5, 359.27),
    },
    ["exit"] = {
        coords = vector4(969.57, -147.07, -46.4, 267.52),  --vector3(969.57, -147.07, -46.4)
    },
}

Config.CokeLab = {
	-- ["enter"] = {
    --     coords = vector4(813.21, -2398.69, 23.66, 171.51), --vector3(813.21, -2398.69, 23.66)
    -- },
    -- ["exit"] = {
    --     coords = vector4(1088.68, -3187.68, -38.99, 176.04), -- GTA DLC Biker Cocaine Lab -- vector3(1088.68, -3187.68, -38.99)
    -- },
}

Config.WeedLab = {
	--[[["enter"] = {
        coords = vector4(813.21, -2398.69, 23.66, 171.51), --vector3(813.21, -2398.69, 23.66)
    },
    ["exit"] = {
        coords = vector4(1088.68, -3187.68, -38.99, 176.04), -- GTA DLC Biker Cocaine Lab -- vector3(1088.68, -3187.68, -38.99)
    },]]--
}


--------------------------------
-- DRUG CONFIG AMOUNTS --
--------------------------------

--------------------------------
-- COKE PROCESSING AMOUNTS --
--------------------------------

Config.CokeProcessing = {
	CokeLeaf = 1, -- Amount of Leaf Needed to Process
	ProcessCokeLeaf = math.random(2,7), -- Amount of Coke Received
	-- Processing Small Bricks --
	Coke = 10, -- Amount of Coke Needed for Small Brick
	BakingSoda = 5, -- Amount of Baking Soda Needed for Small Brick
	SmallCokeBrick = math.random(2,7),
	-- Process Small Bricks Into Large Brick --
	SmallBrick = 4, -- Amount of Small Bricks Required
	LargeBrick = 1, -- Large Bricks Received
}

--------------------------------
-- METH PROCESSING AMOUNTS --
--------------------------------
Config.MethProcessing = {
	-- Chemical Processing --
	SulfAcid = 1, -- Amount of Sulfuric Acid Needed for Liquid Mix
	HydAcid = 1, -- Amount of Hydrochloric Acid Needed for Liquid Mix
	SodHyd = 1, -- Amount of Sodium Hydroxide Needed for Liquid Mix
	Meth = math.random(5,12), -- Amount of Meth Recevied From 1 Tray
}

--------------------------------
-- HEROIN PROCESSING AMOUNTS --
--------------------------------
Config.HeroinProcessing = {
	Poppy = 2 -- Amount of Poppy Required for 1 Heroin
}