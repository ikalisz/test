Config = {}
Config.MaxWidth = 5.0
Config.MaxHeight = 5.0
Config.MaxLength = 5.0
Config.DamageNeeded = 100.0
Config.EnableProne = true
Config.JointEffectTime = 60
Config.RemoveWeaponDrops = true
Config.RemoveWeaponDropsTimer = 25
Config.DefaultPrice = 20 -- carwash
Config.DirtLevel = 0.1 --carwash dirt level

ConsumeablesEat = {
    ["kraker"] = math.random(15, 16),
    ["sosisli"] = math.random(15, 30),
    ["ekmek"] = math.random(25, 30),
    ["burgers"] = math.random(25, 35),
    ["burgerm"] = math.random(15, 35),
    ["burgerl"] = math.random(30, 50),
    ["burgerxl"] = math.random(20, 40),
    ["friess"] = math.random(10, 25),
    ["friesm"] = math.random(20, 40),
    ["friesl"] = math.random(25, 45),
    ["friesxl"] = math.random(22, 45),
    ["hotdogs"] = math.random(15, 35),
    ["hotdogm"] = math.random(25, 56),
    ["hotdogl"] = math.random(15, 30),
    ["hotdogxl"] = math.random(15, 55),
    ["tacos"] = math.random(11, 25),
    ["tacot"] = math.random(15, 35),
    ["tacok"] = math.random(22, 44),
    ["tacoxl"] = math.random(33, 55),
    ["tburgers"] = math.random(15, 35),
    ["tburgerm"] = math.random(22, 44),
    ["tburgerl"] = math.random(35, 55),
    ["tburgerxl"] = math.random(45, 55),
    ["pburger"] = math.random(45, 55),
    ["tavukmenu"] = math.random(55, 65),
    ["mezetabagi"] = math.random(35, 55),
    ["kekuzum"] = math.random(11, 22),
    ["pogacadomates"] = math.random(10, 15),
    ["pogacapatates"] = math.random(10, 15),
    ["kahvekek"] = math.random(10, 15),
    ["beyazpeynir"] = math.random(5, 10),
    ["ezme"] = math.random(5, 10),
}

ConsumeablesDrink = {
    ["water"] = math.random(15, 22),
    ["portakal_suyu"] = math.random(25, 33),
    ["domates_suyu"] = math.random(11, 15),
    ["turtle_soup"] = math.random(22, 55),
    ["atom"] = math.random(25, 35),
    ["ayran"] = math.random(25, 35),
    ["kola"] = math.random(25, 35),
    ["americano"] = math.random(11, 12),
    ["latte"] = math.random(12, 12),
    ["graphius"] = math.random(15, 35),
    ["macha"] = math.random(12, 15),
    ["kahve"] = math.random(22, 22),
    ["cay"] = math.random(22, 33),
}

ConsumeablesAlcohol = {
    ["vodka"] = math.random(20, 30),
    ["beer"] = math.random(30, 40),
}