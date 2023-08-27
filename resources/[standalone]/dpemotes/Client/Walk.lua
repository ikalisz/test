RegisterNetEvent("dpemotes:set-walk")
AddEventHandler("dpemotes:set-walk", function(name)
  local name = firstToUpper(name)

  if name == "Reset" then
    local playerPed = PlayerPedId()
    local model = GetEntityModel(playerPed)
    if model == 1885233650 then -- Erkek Model
      WalkMenuStart("MOVE_P_M_ONE")
    elseif model == -1667301416 then
      WalkMenuStart("move_f@multiplayer")
    else
      ResetPedMovementClipset(PlayerPedId())
    end
    return
  elseif name == "Yaralı" then
    WalkMenuStart("move_m@injured")
    return
  end

  local name2 = table.unpack(DP.Walks[name])
  if name2 ~= nil then
    WalkMenuStart(name2)
  else
    EmoteChatMessage("'"..name.."' is not a valid walk")
  end
end)

function WalkMenuStart(name)
  RequestWalking(name)
  TriggerEvent("elixir-base:setlastMovementClipset", name)
  SetPedMovementClipset(PlayerPedId(), name, 0.2)
  RemoveAnimSet(name)
end

function RequestWalking(set)
  RequestAnimSet(set)
  while not HasAnimSetLoaded(set) do
    Citizen.Wait(1)
  end 
end

function WalksOnCommand(source, args, raw)
  local WalksCommand = ""
  for a in pairsByKeys(DP.Walks) do
    WalksCommand = WalksCommand .. ""..string.lower(a)..", "
  end
  EmoteChatMessage(WalksCommand)
  EmoteChatMessage("To reset do /walk reset")
end

function WalkCommandStart(source, args, raw)
  local name = firstToUpper(args[1])

  if name == "Reset" then
      ResetPedMovementClipset(PlayerPedId()) return
  end

  local name2 = table.unpack(DP.Walks[name])
  if name2 ~= nil then
    WalkMenuStart(name2)
  else
    EmoteChatMessage("'"..name.."' is not a valid walk")
  end
end