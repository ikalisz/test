Config = {}

Config.UpdateFrequency = 300 -- seconds interval between removing values 

Config.Skills = {
    ["Kondisyon"] = {
        ["Menu"] = true,
        ["Current"] = 15, -- Default value 
        ["RemoveAmount"] = 0, -- % to remove when updating,
        ["Stat"] = "MP0_STAMINA" -- GTA stat hashname
    },

    ["Güç"] = {
        ["Menu"] = true,
        ["Current"] = 5,
        ["RemoveAmount"] = 0,
        ["Stat"] = "MP0_STRENGTH"
    },

   ["Ciğer Kapasitesi"] = {
        ["Menu"] = false,
        ["Current"] = 0,
        ["RemoveAmount"] = 0,
        ["Stat"] = "MP0_LUNG_CAPACITY"
    },

    ["Sürüş Yeteneği"] = {
        ["Menu"] = false,
        ["Current"] = 0,
        ["RemoveAmount"] = 0,
        ["Stat"] = "MP0_DRIVING_ABILITY"
    },

    ["Ön Kaldırma Yeteneği"] = {
        ["Menu"] = false,
        ["Current"] = 0,
        ["RemoveAmount"] = 0,
        ["Stat"] = "MP0_WHEELIE_ABILITY"
    }
}
