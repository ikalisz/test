--[[
cl_ui.lua
Functionality for everything that is the UI.
]]
local InstalledText = "Installed"
local purchasedText = "Purchased"
local noMoney = "Not Enough Money"

--[[
cl_ui.lua
Functionality for everything that is the UI.
]]

--#[Local Variable]#--
local currentMenuItemID = 0
local currentMenuItem = ""
local currentMenuItem2 = ""
local currentMenu = "mainMenu"

local currentCategory = 0

local currentPaintCategory = 0
local currentPaintType = 0

local currentWheelCategory = 0

local currentNeonSide = 0

local menuStructure = {}

--#[Local Functions]#--
local function roundNum(num, numDecimalPlaces)
    return tonumber(string.format("%." .. (numDecimalPlaces or 0) .. "f", num))
end

local function toggleMenuContainer(state)
    SendNUIMessage({
        toggleMenuContainer = true,
        state = state
    })
end

local function createMenu(menu, heading, subheading)
    SendNUIMessage({
        createMenu = true,
        menu = menu,
        heading = heading,
        subheading = subheading
    })
end

local function destroyMenus()
    SendNUIMessage({
        destroyMenus = true
    })
end

local function populateMenu(menu, id, item, item2)
    SendNUIMessage({
        populateMenu = true,
        menu = menu,
        id = id,
        item = item,
        item2 = item2
    })
end

local function finishPopulatingMenu(menu)
    SendNUIMessage({
        finishPopulatingMenu = true,
        menu = menu
    })
end

local function updateMenuHeading(menu)
    SendNUIMessage({
        updateMenuHeading = true,
        menu = menu
    })
end

local function updateMenuSubheading(menu)
    SendNUIMessage({
        updateMenuSubheading = true,
        menu = menu
    })
end

local function updateMenuStatus(text)
    SendNUIMessage({
        updateMenuStatus = true,
        statusText = text
    })
end

local function toggleMenu(state, menu)
    SendNUIMessage({
        toggleMenu = true,
        state = state,
        menu = menu
    })
end

local function updateItem2Text(menu, id, text)
    SendNUIMessage({
        updateItem2Text = true,
        menu = menu,
        id = id,
        item2 = text
    })
end

local function updateItem2TextOnly(menu, id, text)
    SendNUIMessage({
        updateItem2TextOnly = true,
        menu = menu,
        id = id,
        item2 = text
    })
end

local function scrollMenuFunctionality(direction, menu)
    SendNUIMessage({
        scrollMenuFunctionality = true,
        direction = direction,
        menu = menu
    })
end

local function playSoundEffect(soundEffect, volume)
    SendNUIMessage({
        playSoundEffect = true,
        soundEffect = soundEffect,
        volume = volume
    })
end

local function isMenuActive(menu)
    local menuActive = false

    if menu == "modMenu" then
        for k, v in pairs(vehicleCustomisation) do 
            if (v.category:gsub("%s+", "") .. "Menu") == currentMenu then
                menuActive = true
    
                break
            else
                menuActive = false
            end
        end
    elseif menu == "PaintMenu" then
        for k, v in pairs(vehiclePaintOptions) do
            if (v.category:gsub("%s+", "") .. "Menu") == currentMenu then
                menuActive = true
    
                break
            else
                menuActive = false
            end
        end
    elseif menu == "WheelsMenu" then
        for k, v in pairs(vehicleWheelOptions) do
            if (v.category:gsub("%s+", "") .. "Menu") == currentMenu then
                menuActive = true
    
                break
            else
                menuActive = false
            end
        end
    elseif menu == "NeonSideMenu" then
        for k, v in pairs(vehicleNeonOptions.neonTypes) do
            if (v.name:gsub("%s+", "") .. "Menu") == currentMenu then
                menuActive = true
    
                break
            else
                menuActive = false
            end
        end
    end

    return menuActive
end

local function updateCurrentMenuItemID(id, item, item2)
    currentMenuItemID = id
    currentMenuItem = item
    currentMenuItem2 = item2
    if isMenuActive("modMenu") then
        if currentCategory ~= 18 then
            PreviewMod(currentCategory, currentMenuItemID)
        end
    elseif isMenuActive("PaintMenu") then
        PreviewColour(currentPaintCategory, currentPaintType, currentMenuItemID)
    elseif isMenuActive("WheelsMenu") then
        if currentWheelCategory ~= -1 and currentWheelCategory ~= 20 then
            PreviewWheel(currentCategory, currentMenuItemID, currentWheelCategory)
        end
    elseif isMenuActive("NeonSideMenu") then
        PreviewNeon(currentNeonSide, currentMenuItemID)
    elseif currentMenu == "WindowTintsMenu" then
        PreviewWindowTint(currentMenuItemID)
    elseif currentMenu == "NeonColoursMenu" then
        local r = vehicleNeonOptions.neonColours[currentMenuItemID].r
        local g = vehicleNeonOptions.neonColours[currentMenuItemID].g
        local b = vehicleNeonOptions.neonColours[currentMenuItemID].b

        PreviewNeonColour(r, g, b)
    elseif currentMenu == "XenonColoursMenu" then
        PreviewXenonColour(currentMenuItemID)
    elseif currentMenu == "LiveryMenu" then
        PreviewOldLivery(currentMenuItemID)
    end
end

--#[Global Functions]#--
function Draw3DText(x, y, z, str, r, g, b, a, font, scaleSize, enableProportional, enableCentre, enableOutline, enableShadow, sDist, sR, sG, sB, sA)
    local onScreen, worldX, worldY = World3dToScreen2d(x, y, z)
    local gameplayCamX, gameplayCamY, gameplayCamZ = table.unpack(GetGameplayCamCoords())

    if onScreen then
        SetTextScale(1.0, scaleSize)
        SetTextFont(font)
        SetTextColour(r, g, b, a)
        SetTextEdge(2, 0, 0, 0, 150)

        if enableProportional then
            SetTextProportional(1)
        end

        if enableOutline then
            SetTextOutline()
        end

        if enableShadow then
            SetTextDropshadow(sDist, sR, sG, sB, sA)
            SetTextDropShadow()
        end

        if enableCentre then
            SetTextCentre(1)
        end
        
        SetTextEntry("STRING")
        AddTextComponentString(str)
        DrawText(worldX, worldY)
    end
end

function InitiateMenus(isMotorcycle, vehicleHealth, title)
    local LiveryOk = false
    --#[Repair Menu]#--
    if vehicleHealth < 1000.0 then
        local repairCost = vehicleCustomisationPrices.repair.price

        TriggerServerEvent("np-bennys:updateRepairCost", repairCost)
        createMenu("repairMenu", title, "Repair Vehicle")
        populateMenu("repairMenu", -1, "Fix it", "$" .. repairCost)
        finishPopulatingMenu("repairMenu")
    end

    --#[Main Menu]#--
    createMenu("mainMenu", title, "Select Modifications")

    for k, v in ipairs(vehicleCustomisation) do 
        local validMods, amountValidMods = CheckValidMods(v.category, v.id)
        if amountValidMods > 0 or v.id == 18 then
            populateMenu("mainMenu", v.id, v.category, "none")
        end
    end

    populateMenu("mainMenu", -1, "Paint", "none")

    if not isMotorcycle then
        populateMenu("mainMenu", -2, "Window Tints", "none")
        populateMenu("mainMenu", -3, "Neon", "none")
    end

    populateMenu("mainMenu", 22, "Xenon Headlights", "none")
    populateMenu("mainMenu", 23, "Wheels", "none")

    local livCount = GetVehicleLiveryCount(plyVeh)
    if livCount > 0 then 
        LiveryOk = true 
        populateMenu("mainMenu", 24, "Livery", "none") 
    end
    populateMenu("mainMenu", 25, "Extras", "none")

    finishPopulatingMenu("mainMenu")

    --#[Mods Menu]#--
    for k, v in ipairs(vehicleCustomisation) do 
        local validMods, amountValidMods = CheckValidMods(v.category, v.id)
        local currentMod, currentModName = GetCurrentMod(v.id)

        if amountValidMods > 0 or v.id == 18 then
            if v.id == 11 or v.id == 12 or v.id == 13 or v.id == 15 or v.id == 16 then --Performance Upgrades
                local tempNum = 0
            
                createMenu(v.category:gsub("%s+", "") .. "Menu", v.category, "Select Level")

                for m, n in pairs(validMods) do
                    tempNum = tempNum + 1

                    if maxVehiclePerformanceUpgrades == 0 then
                        populateMenu(v.category:gsub("%s+", "") .. "Menu", n.id, n.name, "$" .. calcPrice(vehicleCustomisationPrices.performance.prices[tempNum]))

                        if currentMod == n.id then
                            updateItem2Text(v.category:gsub("%s+", "") .. "Menu", n.id, InstalledText)
                        end
                    else
                        if tempNum <= (maxVehiclePerformanceUpgrades + 1) then
                            populateMenu(v.category:gsub("%s+", "") .. "Menu", n.id, n.name, "$" .. calcPrice(vehicleCustomisationPrices.performance.prices[tempNum]))

                            if currentMod == n.id then
                                updateItem2Text(v.category:gsub("%s+", "") .. "Menu", n.id, InstalledText)
                            end
                        end
                    end
                end
                
                finishPopulatingMenu(v.category:gsub("%s+", "") .. "Menu")
            elseif v.id == 18 then
                local currentTurboState = GetCurrentTurboState()
                createMenu(v.category:gsub("%s+", "") .. "Menu", v.category .. " Customisation", "Turbo Enable/Disabe")

                populateMenu(v.category:gsub("%s+", "") .. "Menu", 0, "Disable", "$0")
                populateMenu(v.category:gsub("%s+", "") .. "Menu", 1, "Enable", "$" .. calcPrice(vehicleCustomisationPrices.turbo.price))

                updateItem2Text(v.category:gsub("%s+", "") .. "Menu", currentTurboState, InstalledText)

                finishPopulatingMenu(v.category:gsub("%s+", "") .. "Menu")
            else
                createMenu(v.category:gsub("%s+", "") .. "Menu", v.category .. " Customisation", "Choose a Mod")

                for m, n in pairs(validMods) do
                    populateMenu(v.category:gsub("%s+", "") .. "Menu", n.id, n.name, "$" .. calcPrice(vehicleCustomisationPrices.cosmetics.price))

                    if currentMod == n.id then
                        updateItem2Text(v.category:gsub("%s+", "") .. "Menu", n.id, InstalledText)
                    end
                end
                
                finishPopulatingMenu(v.category:gsub("%s+", "") .. "Menu")
            end
        end
    end

    --#[Paint Menu]#--
    createMenu("PaintMenu", "Paint", "Choose Color Category")

    populateMenu("PaintMenu", 0, "Primary Color", "none")
    populateMenu("PaintMenu", 1, "Secondary Color", "none")
    populateMenu("PaintMenu", 2, "Pearl", "none")
    populateMenu("PaintMenu", 3, "Rim Colours", "none")
    populateMenu("PaintMenu", 4, "Indicator Colors", "none")
    populateMenu("PaintMenu", 5, "Interior Colors", "none")

    finishPopulatingMenu("PaintMenu")

    --#[Paint Types]#--
    createMenu("PaintTypeMenu", "Paint Type", "Choose a Paint Type")

    for k, v in ipairs(vehiclePaintOptions) do
        populateMenu("PaintTypeMenu", v.id, v.category, "none")
    end

    finishPopulatingMenu("PaintTypeMenu")

    --#[Paint Colours]#--
    for k, v in ipairs(vehiclePaintOptions) do 
        createMenu(v.category .. "Menu", v.category .. " Colours", "Choose Color")

        for m, n in ipairs(v.colours) do
            populateMenu(v.category .. "Menu", n.id, n.name, "$" .. calcPrice(vehicleCustomisationPrices.paint.price))
        end

        finishPopulatingMenu(v.category .. "Menu")
    end

    --#[Wheel Categories Menu]#--
    createMenu("WheelsMenu", "Wheels", "Choose Color")

    for k, v in ipairs(vehicleWheelOptions) do 
        if isMotorcycle then
            if v.id == -1 or v.id == 20 or v.id == 6 then --Motorcycle Wheels
                populateMenu("WheelsMenu", v.id, v.category, "none")
            end
        else
            populateMenu("WheelsMenu", v.id, v.category, "none")
        end
    end

    finishPopulatingMenu("WheelsMenu")

    --#[Wheels Menu]#--
    for k, v in ipairs(vehicleWheelOptions) do 
        if v.id == -1 then
            local currentCustomWheelState = GetCurrentCustomWheelState()
            createMenu(v.category:gsub("%s+", "") .. "Menu", v.category, "Custom Tires Active/Disable")

            populateMenu(v.category:gsub("%s+", "") .. "Menu", 0, "Default", "$0")
            populateMenu(v.category:gsub("%s+", "") .. "Menu", 1, "Activate", "$" .. calcPrice(vehicleCustomisationPrices.customwheels.price))

            updateItem2Text(v.category:gsub("%s+", "") .. "Menu", currentCustomWheelState, InstalledText)

            finishPopulatingMenu(v.category:gsub("%s+", "") .. "Menu")
        elseif v.id ~= 20 then
            if isMotorcycle then
                if v.id == 6 then --Motorcycle Wheels
                    local validMods, amountValidMods = CheckValidMods(v.category, v.wheelID, v.id)

                    createMenu(v.category .. "Menu", v.category .. " Wheels", "Choose Wheel")

                    for m, n in pairs(validMods) do
                        populateMenu(v.category .. "Menu", n.id, n.name, "$" .. calcPrice(vehicleCustomisationPrices.wheels.price))
                    end

                    finishPopulatingMenu(v.category .. "Menu")
                end
            else
                local validMods, amountValidMods = CheckValidMods(v.category, v.wheelID, v.id)

                createMenu(v.category .. "Menu", v.category .. " Wheels", "Choose Wheel")

                for m, n in pairs(validMods) do
                    populateMenu(v.category .. "Menu", n.id, n.name, "$" .. calcPrice(vehicleCustomisationPrices.wheels.price))
                end

                finishPopulatingMenu(v.category .. "Menu")
            end
        end
    end

    --#[Wheel Smoke Menu]#-- 
    local currentWheelSmokeR, currentWheelSmokeG, currentWheelSmokeB = GetCurrentVehicleWheelSmokeColour()
    createMenu("WheelSmokeMenu", "Tire Smoke Colors", "Choose Color")

    for k, v in ipairs(vehicleTyreSmokeOptions) do
        populateMenu("WheelSmokeMenu", k, v.name, "$" .. calcPrice(vehicleCustomisationPrices.wheelsmoke.price))

        if v.r == currentWheelSmokeR and v.g == currentWheelSmokeG and v.b == currentWheelSmokeB then
            updateItem2Text("WheelSmokeMenu", k, InstalledText)
        end
    end

    finishPopulatingMenu("WheelSmokeMenu")

    --#[Window Tint Menu]#--
    local currentWindowTint = GetCurrentWindowTint()
    createMenu("WindowTintsMenu", "Window Tints", "Choose Window Tint Quality")

    for k, v in ipairs(vehicleWindowTintsOptions) do 
        populateMenu("WindowTintsMenu", v.id, v.name, "$" .. calcPrice(vehicleCustomisationPrices.windowtints.price))

        if currentWindowTint == v.id then
            updateItem2Text("WindowTintsMenu", v.id, InstalledText)
        end
    end

    finishPopulatingMenu("WindowTintsMenu")

    --#[Old Livery Menu]#--
    if LiveryOk then
        local tempOldLivery = GetVehicleLivery(plyVeh)
        createMenu("LiveryMenu", "Livery", "Select Coating")
        for i=0, GetVehicleLiveryCount(plyVeh)-1 do
            populateMenu("LiveryMenu", i, "Livery", "$"..calcPrice(vehicleCustomisationPrices.livery.price))
            if tempOldLivery == i then
                updateItem2Text("LiveryMenu", i, InstalledText)
            end
        end
        finishPopulatingMenu("LiveryMenu")
    end

    --#[Vehicle Extras Menu]#--
    createMenu("ExtrasMenu", "Extras", "Extra ON/OFF")
    for i=1, 12 do
        if DoesExtraExist(plyVeh, i) then
            populateMenu("ExtrasMenu", i, "Extra "..tostring(i), "ON/OFF")
        else
            populateMenu("ExtrasMenu", i, "No Extras!", "NONE")
        end
    end
    finishPopulatingMenu("ExtrasMenu")

    --#[Neons Menu]#--
    createMenu("NeonMenu", "Neon Customization", "Select Category")

    for k, v in ipairs(vehicleNeonOptions.neonTypes) do
        populateMenu("NeonMenu", v.id, v.name, "none")
    end

    populateMenu("NeonMenu", -1, "Neon Colours", "none")
    finishPopulatingMenu("NeonMenu")

    --#[Neon State Menu]#--
    for k, v in ipairs(vehicleNeonOptions.neonTypes) do
        local currentNeonState = GetCurrentNeonState(v.id)
        createMenu(v.name:gsub("%s+", "") .. "Menu", "Neon Customization", "Enable/Disable Neon")

        populateMenu(v.name:gsub("%s+", "") .. "Menu", 0, "Disabled", "$0")
        populateMenu(v.name:gsub("%s+", "") .. "Menu", 1, "Enabled", "$" .. calcPrice(vehicleCustomisationPrices.neonside.price))

        updateItem2Text(v.name:gsub("%s+", "") .. "Menu", currentNeonState, InstalledText)

        finishPopulatingMenu(v.name:gsub("%s+", "") .. "Menu")
    end

    --#[Neon Colours Menu]#--
    local currentNeonR, currentNeonG, currentNeonB = GetCurrentNeonColour()
    createMenu("NeonColoursMenu", "Neon Colours", "Choose Color")

    for k, v in ipairs(vehicleNeonOptions.neonColours) do
        populateMenu("NeonColoursMenu", k, vehicleNeonOptions.neonColours[k].name, "$" .. calcPrice(vehicleCustomisationPrices.neoncolours.price))

        if currentNeonR == vehicleNeonOptions.neonColours[k].r and currentNeonG == vehicleNeonOptions.neonColours[k].g and currentNeonB == vehicleNeonOptions.neonColours[k].b then
            updateItem2Text("NeonColoursMenu", k, InstalledText)
        end
    end

    finishPopulatingMenu("NeonColoursMenu")

    --#[Xenons Menu]#--
    createMenu("XenonHeadlightsMenu", "Xenon Headlights", "Select Category")

    populateMenu("XenonHeadlightsMenu", 0, "Xenon", "none")
    populateMenu("XenonHeadlightsMenu", 1, "Xenon Colours", "none")

    finishPopulatingMenu("XenonHeadlightsMenu")

    --#[Xenons Headlights Menu]#--
    local currentXenonState = GetCurrentXenonState()
    createMenu("XenonMenu", "Headlights", "Xenon Headlights Enable/Disable")

    populateMenu("XenonMenu", 0, "Xenon Remove", "$0")
    populateMenu("XenonMenu", 1, "Xenon Enable", "$" .. calcPrice(vehicleCustomisationPrices.xenon.price))

    updateItem2Text("XenonMenu", currentXenonState, InstalledText)

    finishPopulatingMenu("XenonMenu")

    --#[Xenons Colour Menu]#--
    local currentXenonColour = GetCurrentXenonColour()
    createMenu("XenonColoursMenu", "Xenon Far Colours", "Choose Color")

    for k, v in ipairs(vehicleXenonOptions.xenonColours) do
        populateMenu("XenonColoursMenu", v.id, v.name, "$" .. calcPrice(vehicleCustomisationPrices.xenoncolours.price))

        if currentXenonColour == v.id then
            updateItem2Text("XenonColoursMenu", v.id, InstalledText)
        end
    end

    finishPopulatingMenu("XenonColoursMenu")
end

function DestroyMenus()
    destroyMenus()
end

function DisplayMenuContainer(state)
    toggleMenuContainer(state)
end

function DisplayMenu(state, menu)
    if state then
        currentMenu = menu
    end

    toggleMenu(state, menu)
    updateMenuHeading(menu)
    updateMenuSubheading(menu)
end

function MenuManager(state)
    if state then
        if currentMenuItem2 ~= InstalledText then
            if isMenuActive("modMenu") then
                if currentCategory == 18 then --Turbo
                    if AttemptPurchase("turbo") then
                        ApplyMod(currentCategory, currentMenuItemID)
                        playSoundEffect("wrench", 0.4)
                        updateItem2Text(currentMenu, currentMenuItemID, InstalledText)
                        updateMenuStatus(purchasedText)
                    else
                        updateMenuStatus(noMoney)
                    end
                elseif currentCategory == 11 or currentCategory == 12 or currentCategory== 13 or currentCategory == 15 or currentCategory == 16 then --Performance Upgrades
                    if AttemptPurchase("performance", currentMenuItemID) then
                        ApplyMod(currentCategory, currentMenuItemID)
                        playSoundEffect("wrench", 0.4)
                        updateItem2Text(currentMenu, currentMenuItemID, InstalledText)
                        updateMenuStatus(purchasedText)
                    else
                        updateMenuStatus(noMoney)
                    end
                else
                    if AttemptPurchase("cosmetics") then
                        ApplyMod(currentCategory, currentMenuItemID)
                        playSoundEffect("wrench", 0.4)
                        updateItem2Text(currentMenu, currentMenuItemID, InstalledText)
                        updateMenuStatus(purchasedText)
                    else
                        updateMenuStatus(noMoney)
                    end
                end
            elseif isMenuActive("PaintMenu") then
                if AttemptPurchase("paint") then
                    ApplyColour(currentPaintCategory, currentPaintType, currentMenuItemID)
                    playSoundEffect("boya", 1.0)
                    updateItem2Text(currentMenu, currentMenuItemID, InstalledText)
                    updateMenuStatus(purchasedText)
                else
                    updateMenuStatus(noMoney)
                end
            elseif isMenuActive("WheelsMenu") then
                if currentWheelCategory == 20 then
                    if AttemptPurchase("wheelsmoke") then
                        local r = vehicleTyreSmokeOptions[currentMenuItemID].r
                        local g = vehicleTyreSmokeOptions[currentMenuItemID].g
                        local b = vehicleTyreSmokeOptions[currentMenuItemID].b

                        ApplyTyreSmoke(r, g, b)
                        playSoundEffect("wrench", 0.4)
                        updateItem2Text(currentMenu, currentMenuItemID, InstalledText)
                        updateMenuStatus(purchasedText)
                    else
                        updateMenuStatus(noMoney)
                    end
                else
                    if currentWheelCategory == -1 then --Custom Wheels
                        local currentWheel = GetCurrentWheel()

                        if currentWheel == -1 then
                            updateMenuStatus("You Cannot Install Custom Tires on Stock Rims!")
                        else
                            if AttemptPurchase("customwheels") then
                                ApplyCustomWheel(currentMenuItemID)
                                playSoundEffect("wrench", 0.4)
                                updateItem2Text(currentMenu, currentMenuItemID, InstalledText)
                                updateMenuStatus(purchasedText)
                            else
                                updateMenuStatus(noMoney)
                            end
                        end
                    else
                        local currentWheel = GetCurrentWheel()
                        local currentCustomWheelState = GetOriginalCustomWheel()

                        if currentCustomWheelState and currentWheel == -1 then
                            updateMenuStatus("You Cannot Install Stock Wheels With Custom Tire Fitted!")
                        else
                            if AttemptPurchase("wheels") then
                                ApplyWheel(currentCategory, currentMenuItemID, currentWheelCategory)
                                playSoundEffect("wrench", 0.4)
                                updateItem2Text(currentMenu, currentMenuItemID, InstalledText)
                                updateMenuStatus(purchasedText)
                            else
                                updateMenuStatus(noMoney)
                            end
                        end
                    end
                end
            elseif isMenuActive("NeonSideMenu") then
                if AttemptPurchase("neonside") then
                    ApplyNeon(currentNeonSide, currentMenuItemID)
                    playSoundEffect("wrench", 0.4)
                    updateItem2Text(currentMenu, currentMenuItemID, InstalledText)
                    updateMenuStatus(purchasedText)
                else
                    updateMenuStatus(noMoney)
                end 
            else
                if currentMenu == "repairMenu" then
                    if AttemptPurchase("repair") then
                        currentMenu = "mainMenu"
                        RepairVehicle()
                        ExitBennys()
                        playSoundEffect("wrench", 0.4)
                    else
                        updateMenuStatus(noMoney)
                    end
                elseif currentMenu == "mainMenu" then
                    currentMenu = currentMenuItem:gsub("%s+", "") .. "Menu"
                    currentCategory = currentMenuItemID

                    toggleMenu(false, "mainMenu")
                    toggleMenu(true, currentMenu)
                    updateMenuHeading(currentMenu)
                    updateMenuSubheading(currentMenu)
                elseif currentMenu == "PaintMenu" then
                    currentMenu = "PaintTypeMenu"
                    currentPaintCategory = currentMenuItemID

                    toggleMenu(false, "PaintMenu")
                    toggleMenu(true, currentMenu)
                    updateMenuHeading(currentMenu)
                    updateMenuSubheading(currentMenu)
                elseif currentMenu == "PaintTypeMenu" then
                    currentMenu = currentMenuItem:gsub("%s+", "") .. "Menu"
                    currentPaintType = currentMenuItemID

                    toggleMenu(false, "PaintTypeMenu")
                    toggleMenu(true, currentMenu)
                    updateMenuHeading(currentMenu)
                    updateMenuSubheading(currentMenu)
                elseif currentMenu == "WheelsMenu" then
                    local currentWheel, currentWheelName, currentWheelType = GetCurrentWheel()

                    currentMenu = currentMenuItem:gsub("%s+", "") .. "Menu"
                    currentWheelCategory = currentMenuItemID
                    
                    if currentWheelType == currentWheelCategory then
                        updateItem2Text(currentMenu, currentWheel, InstalledText)
                    end

                    toggleMenu(false, "WheelsMenu")
                    toggleMenu(true, currentMenu)
                    updateMenuHeading(currentMenu)
                    updateMenuSubheading(currentMenu)
                elseif currentMenu == "NeonMenu" then
                    currentMenu = currentMenuItem:gsub("%s+", "") .. "Menu"
                    currentNeonSide = currentMenuItemID

                    toggleMenu(false, "NeonMenu")
                    toggleMenu(true, currentMenu)
                    updateMenuHeading(currentMenu)
                    updateMenuSubheading(currentMenu)
                elseif currentMenu == "XenonHeadlightsMenu" then
                    currentMenu = currentMenuItem:gsub("%s+", "") .. "Menu"

                    toggleMenu(false, "XenonHeadlightsMenu")
                    toggleMenu(true, currentMenu)
                    updateMenuHeading(currentMenu)
                    updateMenuSubheading(currentMenu)
                elseif currentMenu == "WindowTintsMenu" then
                    if AttemptPurchase("windowtints") then
                        ApplyWindowTint(currentMenuItemID)
                        playSoundEffect("boya", 1.0)
                        updateItem2Text(currentMenu, currentMenuItemID, InstalledText)
                        updateMenuStatus(purchasedText)
                    else
                        updateMenuStatus(noMoney)
                    end
                elseif currentMenu == "NeonColoursMenu" then
                    if AttemptPurchase("neoncolours") then
                        local r = vehicleNeonOptions.neonColours[currentMenuItemID].r
                        local g = vehicleNeonOptions.neonColours[currentMenuItemID].g
                        local b = vehicleNeonOptions.neonColours[currentMenuItemID].b

                        ApplyNeonColour(r, g, b)
                        playSoundEffect("boya", 1.0)
                        updateItem2Text(currentMenu, currentMenuItemID, InstalledText)
                        updateMenuStatus(purchasedText)
                    else
                        updateMenuStatus(noMoney)
                    end
                elseif currentMenu == "XenonMenu" then
                    if AttemptPurchase("xenon") then
                        ApplyXenonLights(currentCategory, currentMenuItemID)
                        playSoundEffect("wrench", 0.4)
                        updateItem2Text(currentMenu, currentMenuItemID, InstalledText)
                        updateMenuStatus(purchasedText)
                    else
                        updateMenuStatus(noMoney)
                    end
                elseif currentMenu == "XenonColoursMenu" then
                    if AttemptPurchase("xenoncolours") then
                        ApplyXenonColour(currentMenuItemID)
                        playSoundEffect("boya", 1.0)
                        updateItem2Text(currentMenu, currentMenuItemID, InstalledText)
                        updateMenuStatus(purchasedText)
                    else
                        updateMenuStatus(noMoney)
                    end
                elseif currentMenu == "LiveryMenu" then
                    if AttemptPurchase("livery") then
                        ApplyOldLivery(currentMenuItemID)
                        playSoundEffect("wrench", 0.1)
                        updateItem2Text(currentMenu, currentMenuItemID, InstalledText)
                        updateMenuStatus(purchasedText)
                    else
                        updateMenuStatus(noMoney)   
                    end
                elseif currentMenu == "ExtrasMenu" then
                    ApplyExtra(currentMenuItemID)
                    playSoundEffect("wrench", 0.1)
                    updateItem2TextOnly(currentMenu, currentMenuItemID, "Toggle")
                    updateMenuStatus(purchasedText)
                end
            end
        else
            if currentMenu == "ExtrasMenu" then
                ApplyExtra(currentMenuItemID)
                playSoundEffect("wrench", 0.1)
                updateItem2TextOnly(currentMenu, currentMenuItemID, "Toggle")
                updateMenuStatus(purchasedText)
            end
        end
    else
        updateMenuStatus("")

        if isMenuActive("modMenu") then
            toggleMenu(false, currentMenu)

            currentMenu = "mainMenu"

            if currentCategory ~= 18 then
                RestoreOriginalMod()
            end

            toggleMenu(true, currentMenu)
            updateMenuHeading(currentMenu)
            updateMenuSubheading(currentMenu)
        elseif isMenuActive("PaintMenu") then
            toggleMenu(false, currentMenu)

            currentMenu = "PaintTypeMenu"

            RestoreOriginalColours()

            toggleMenu(true, currentMenu)
            updateMenuHeading(currentMenu)
            updateMenuSubheading(currentMenu)
        elseif isMenuActive("WheelsMenu") then            
            if currentWheelCategory ~= 20 and currentWheelCategory ~= -1 then
                local currentWheel = GetOriginalWheel()
                updateItem2Text(currentMenu, currentWheel, "$" .. calcPrice(vehicleCustomisationPrices.wheels.price))
                RestoreOriginalWheels()
            end

            toggleMenu(false, currentMenu)

            currentMenu = "WheelsMenu"


            toggleMenu(true, currentMenu)
            updateMenuHeading(currentMenu)
            updateMenuSubheading(currentMenu)
        elseif isMenuActive("NeonSideMenu") then
            toggleMenu(false, currentMenu)

            currentMenu = "NeonMenu"

            RestoreOriginalNeonStates()

            toggleMenu(true, currentMenu)
            updateMenuHeading(currentMenu)
            updateMenuSubheading(currentMenu)
        else
            if currentMenu == "mainMenu" or currentMenu == "repairMenu" then
                ExitBennys()
            elseif currentMenu == "PaintMenu" or currentMenu == "WindowTintsMenu" or currentMenu == "WheelsMenu" or currentMenu == "NeonMenu" or currentMenu == "XenonHeadlightsMenu" or currentMenu == "LiveryMenu" or currentMenu == "ExtrasMenu" then
                toggleMenu(false, currentMenu)

                if currentMenu == "WindowTintsMenu" then
                    RestoreOriginalWindowTint()
                end

                if currentMenu == "LiveryMenu" then
                    RestoreOldLivery()
                end

                currentMenu = "mainMenu"

                toggleMenu(true, currentMenu)
                updateMenuHeading(currentMenu)
                updateMenuSubheading(currentMenu)
            elseif currentMenu == "PaintTypeMenu" then
                toggleMenu(false, currentMenu)

                currentMenu = "PaintMenu"

                toggleMenu(true, currentMenu)
                updateMenuHeading(currentMenu)
                updateMenuSubheading(currentMenu)
            elseif currentMenu == "NeonColoursMenu" then
                toggleMenu(false, currentMenu)

                currentMenu = "NeonMenu"

                RestoreOriginalNeonColours()

                toggleMenu(true, currentMenu)
                updateMenuHeading(currentMenu)
                updateMenuSubheading(currentMenu)
            elseif currentMenu == "XenonMenu" then
                toggleMenu(false, currentMenu)

                currentMenu = "XenonHeadlightsMenu"

                toggleMenu(true, currentMenu)
                updateMenuHeading(currentMenu)
                updateMenuSubheading(currentMenu)
            elseif currentMenu == "XenonColoursMenu" then
                toggleMenu(false, currentMenu)

                currentMenu = "XenonHeadlightsMenu"

                RestoreOriginalXenonColour()

                toggleMenu(true, currentMenu)
                updateMenuHeading(currentMenu)
                updateMenuSubheading(currentMenu)
            end
        end
    end
end

function MenuScrollFunctionality(direction)
    scrollMenuFunctionality(direction, currentMenu)
end

--#[NUI Callbacks]#--
RegisterNUICallback("selectedItem", function(data, cb)
    updateCurrentMenuItemID(tonumber(data.id), data.item, data.item2)

    --print("Current Selected Item: " .. currentMenuItemID)

    cb("ok")
end)

RegisterNUICallback("updateItem2", function(data, cb)
    currentMenuItem2 = data.item

    cb("ok")
end)