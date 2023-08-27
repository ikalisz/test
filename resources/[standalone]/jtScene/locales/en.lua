local Translations = {
    notify = {
        ["laser_error"] = "Laser Not Displayed.",
        ["scene_delete"] = "Scene Deleted",
        ["scene_error"] = "There's no scene you can delete!",
    }
}
Lang = Locale:new({phrases = Translations, warnOnMissing = true})
