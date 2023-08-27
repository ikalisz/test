RegisterCommand('editor', function(source, args)
	Citizen.Wait(0)
	if args[1] == "start" or args[1] == "record" then
		StartRecording(1)
	elseif args[1] == "cancel" then
		StopRecordingAndDiscardClip()
	elseif args[1] == "save" then
		StopRecordingAndSaveClip()
	elseif args[1] == "again" then
		StartRecording(0)
	elseif args[1] == "ac" then
		NetworkSessionLeaveSinglePlayer()
		ActivateRockstarEditor()
	else
		return
	end
end)
TriggerEvent('chat:addSuggestion', '/editor' .. 'start, record, cancel, save, again, ac')