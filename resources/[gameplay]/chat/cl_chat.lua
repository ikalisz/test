

local chatInputActive = false
local chatInputActivating = false
local chatHidden = true
local chatLoaded = false

RegisterNetEvent('chatMessage')
RegisterNetEvent('chat:addTemplate')
RegisterNetEvent('chat:addMessage')
RegisterNetEvent('chat:addSuggestion')
RegisterNetEvent('chat:addSuggestions')
RegisterNetEvent('chat:removeSuggestion')
RegisterNetEvent('chat:clear')

-- internal events
RegisterNetEvent('__cfx_internal:serverPrint')

RegisterNetEvent('_chat:messageEntered')

--deprecated, use chat:addMessage
AddEventHandler('chatMessage', function(author, ctype, text)
  local args = { text }
  if author ~= "" then
    table.insert(args, 1, author)
  end
  local ctype = ctype ~= false and ctype or "normal"
  SendNUIMessage({
    type = 'ON_MESSAGE',
    message = {
      template = '<div class="chat-message '..ctype..'"><div class="chat-message-body '..ctype..'"><strong>{0}:</strong> {1}</div></div>',
      args = {author, text}
    }
  })
end)

AddEventHandler('__cfx_internal:serverPrint', function(msg)

  SendNUIMessage({
    type = 'ON_MESSAGE',
    message = {
      templateId = 'print',
      multiline = true,
      args = { msg }
    }
  })
end)

AddEventHandler('chat:addMessage', function(message)
  SendNUIMessage({
    type = 'ON_MESSAGE',
    message = message
  })
end)

RegisterNetEvent('chat:tgiannAddSuggestion')
AddEventHandler('chat:tgiannAddSuggestion', function(perm, commands)
  for command, info in pairs(commands) do
    if perm == "god" or perm == info.permission then
      TriggerEvent('chat:addSuggestion', "/"..command, info.help, info.arguments)
    end
  end
end)

RegisterNetEvent('chat:forceClose')
AddEventHandler('chat:forceClose', function()
  SendNUIMessage({type = 'forceClose'})
end)

AddEventHandler('__cfx_internal:serverPrint', function(msg)
  if msg ~= "" then
    SendNUIMessage({
      type = 'ON_MESSAGE',
      message = {
        templateId = 'print',
        multiline = true,
        args = { msg }
      }
    })
  end
end)

-- addSuggestion
local addSuggestion = function(name, help, params)
  SendNUIMessage({
    type = 'ON_SUGGESTION_ADD',
    suggestion = {
      name = name,
      help = help,
      params = params or nil
    }
  })
end
exports('addSuggestion', addSuggestion)
AddEventHandler('chat:addSuggestion', addSuggestion)

AddEventHandler('chat:addSuggestions', function(suggestions)
  for _, suggestion in ipairs(suggestions) do
    SendNUIMessage({
      type = 'ON_SUGGESTION_ADD',
      suggestion = suggestion
    })
  end
end)

AddEventHandler('chat:removeSuggestion', function(name)
  SendNUIMessage({
    type = 'ON_SUGGESTION_REMOVE',
    name = name
  })
end)

AddEventHandler('chat:addTemplate', function(id, html)
  SendNUIMessage({
    type = 'ON_TEMPLATE_ADD',
    template = {
      id = id,
      html = html
    }
  })
end)

AddEventHandler('chat:clear', function(name)
  SendNUIMessage({
    type = 'ON_CLEAR'
  })
end)

local function stringSplit(inputstr, sep)
  if sep == nil then
    sep = "%s"
  end
  local t={}
  for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
    table.insert(t, str)
  end
  return t
end
local function stringJoin(tbl)
  local str = tbl[1]
  for k, v in pairs(tbl) do
    if k ~= 1 then
      str = str .. " " .. v
    end
  end
  return str
end

RegisterNUICallback('chatResult', function(data, cb)
  chatInputActive = false
  SetNuiFocus(false)
  TriggerEvent("idkapatla")

  if not data.canceled then
    local id = PlayerId()

    --deprecated
    local r, g, b = 0, 0x99, 255

    local message = data.message
    if string.sub(message, 1, 1) ~= "/" then
        message = "/" .. message
    end
    local args = stringSplit(message, " ")
    local cmd = args[1]
    cmd = string.lower(cmd)
    args[1] = cmd
    message = stringJoin(args)

    if message:sub(1, 1) == '/' then
      ExecuteCommand(message:sub(2))
    else
      TriggerServerEvent('_chat:messageEntered', GetPlayerName(id), { r, g, b }, message, data.mode)
    end
  end

  cb('ok')
end)

local function refreshCommands()
  if GetRegisteredCommands then
    local registeredCommands = GetRegisteredCommands()

    local suggestions = {}

    for _, command in ipairs(registeredCommands) do
        if IsAceAllowed(('command.%s'):format(command.name)) then
          if string.sub(command.name, 1, 1) ~= "+" and string.sub(command.name, 1, 1) ~= "-" then
            table.insert(suggestions, {
                name = '/' .. command.name,
                help = ''
            })
          end
        end
    end

    TriggerEvent('chat:addSuggestions', suggestions)
  end
end

local function refreshThemes()
  local themes = {}

  for resIdx = 0, GetNumResources() - 1 do
    local resource = GetResourceByFindIndex(resIdx)

    if GetResourceState(resource) == 'started' then
      local numThemes = GetNumResourceMetadata(resource, 'chat_theme')

      if numThemes > 0 then
        local themeName = GetResourceMetadata(resource, 'chat_theme')
        local themeData = json.decode(GetResourceMetadata(resource, 'chat_theme_extra') or 'null')

        if themeName and themeData then
          themeData.baseUrl = 'nui://' .. resource .. '/'
          themes[themeName] = themeData
        end
      end
    end
  end

  SendNUIMessage({
    type = 'ON_UPDATE_THEMES',
    themes = themes
  })
end

AddEventHandler('onClientResourceStart', function(resName)
  Wait(500)

  refreshCommands()
  refreshThemes()
end)

AddEventHandler('onClientResourceStop', function(resName)
  Wait(500)

  refreshCommands()
  refreshThemes()
end)

RegisterNUICallback('loaded', function(data, cb)
  TriggerServerEvent('chat:init');

  refreshCommands()
  refreshThemes()

  chatLoaded = true

  cb('ok')
end)

Citizen.CreateThread(function()
  SetTextChatEnabled(false)
  SetNuiFocus(false, false)
  RegisterKeyMapping('+chat', 'Chat', 'keyboard', 't')

  while true do
    Wait(100)
    if chatLoaded then
      local shouldBeHidden = false
      if IsScreenFadedOut() or IsPauseMenuActive() then shouldBeHidden = true end
      if (shouldBeHidden and not chatHidden) or (not shouldBeHidden and chatHidden) then
        chatHidden = shouldBeHidden
        SendNUIMessage({
          type = 'ON_SCREEN_STATE_CHANGE',
          shouldHide = shouldBeHidden
        })
      end
    end
  end
end)


RegisterCommand("+chat", function()
  local checkPhone = exports["high_phone"]:phoneIsOpen()
  if not checkPhone then
    if not chatInputActive then
      chatInputActive = true
      chatInputActivating = true

      TriggerServerEvent('lucid-s-chat:syncforeveryone', "ss", true)
      
      SendNUIMessage({
        type = 'ON_OPEN'
      })
    end
    -- TriggerEvent("disc-showid:kapat")

    if chatInputActivating then
      SetNuiFocus(true)
      chatInputActivating = false
      TriggerEvent("idgosterla")
    end
  end
end, false)