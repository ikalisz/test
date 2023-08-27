local Translations = {
    notify = {
        ["no_money"] = "You Don't Have Enough Money",
        ["refuel_cancel"] = "Refueling Canceled",
        ["jerrycan_full"] = "This Gas Can Is Already Full",
        ["jerrycan_empty"] = "This Gas Can is Empty",
        ["vehicle_full"] = "Vehicle Already Full of Gasoline",
        ["already_full"] = "Gas can already full",
        ["no_nozzle"] = "You Have To Get The Pump To Fill Your Bleach",
        ["broke_nozle"] = "$100 Penalty for Breaking the Pops",
        ["cant_havenozzle"] = "You Already Got the Pump",
        ["cant_dontnozzle"] = "You Don't Have a Pump",

    }
}
Lang = Locale:new({phrases = Translations, warnOnMissing = true})
