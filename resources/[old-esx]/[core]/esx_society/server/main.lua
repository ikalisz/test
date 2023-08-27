QBCore = nil
TriggerEvent('QBCore:GetObject', function(obj) 
	QBCore = obj
end)

RegisterServerEvent('esx_society:withdrawMoney')
AddEventHandler('esx_society:withdrawMoney', function(societyName, amount)
	local xPlayer = QBCore.Functions.GetPlayer(source)
	local amount = QBCore.Shared.Round(tonumber(amount))

	if QBCore.Functions.getJobMoney(societyName) >= amount then
		QBCore.Functions.removeJobMoney(societyName, amount)
		xPlayer.Functions.AddMoney('cash', amount)
		TriggerClientEvent("QBCore:Notify", xPlayer.PlayerData.source, QBCore.Shared.GroupDigits(amount) .. "$ Took")
	else
		TriggerClientEvent("QBCore:Notify", xPlayer.PlayerData.source, "There Isn't That Much Money in the Safe")
	end
end)

RegisterServerEvent('esx_society:depositMoney')
AddEventHandler('esx_society:depositMoney', function(societyName, amount)
	local src = source
	local xPlayer = QBCore.Functions.GetPlayer(src)
	local amount = QBCore.Shared.Round(tonumber(amount))

	if xPlayer.Functions.RemoveMoney('cash', amount) then
		TriggerClientEvent("QBCore:Notify", xPlayer.PlayerData.source, QBCore.Shared.GroupDigits(amount) .. "$ Deposited")
		QBCore.Functions.addJobMoney(societyName, amount)
	else
		TriggerClientEvent("QBCore:Notify", xPlayer.PlayerData.source, "You Don't Have Enough Money")
	end
end)

QBCore.Functions.CreateCallback('esx_society:getJobMoney', function(source, cb, society)
	cb(QBCore.Functions.getJobMoney(society))
end)

QBCore.Functions.CreateCallback('esx_society:getJob', function(source, cb, society)
	cb(QBCore.Functions.checkJonPayment(society))
end)

QBCore.Functions.CreateCallback('esx_society:getEmployees', function(source, cb, society)
	MySQL.query('SELECT charinfo, citizenid, metadata, job FROM players WHERE jobname = @jobname', {
		['@jobname'] = society
	}, function (results)
		local employees = {}
		for i=1, #results, 1 do
			local charinfo = json.decode(results[i].charinfo)
			local jobs = json.decode(results[i].job)
			local metadata = json.decode(results[i].metadata)
			local dutytime = metadata.dutytime
			if dutytime == nil then dutytime = 0 end
			table.insert(employees, {
				name       = charinfo.firstname .. ' ' .. charinfo.lastname,
				time = QBCore.Shared.Round(dutytime / 60, 1),
				citizenid = results[i].citizenid,
				job = {
					name        = jobs.name,
					label       = jobs.label,
					grade       = jobs.grade,
					grade_name  = jobs.gradelabel,
				}
			})
		end
		cb(employees)
	end)
end)

QBCore.Functions.CreateCallback('esx_society:getOnlinePlayers', function(source, cb)
	local xPlayers = QBCore.Functions.GetPlayers()
	local players = {}

	for i=1, #xPlayers, 1 do
		local xPlayer = QBCore.Functions.GetPlayer(xPlayers[i])
		table.insert(players, {
			source = xPlayer.PlayerData.source,
			citizenid = xPlayer.PlayerData.citizenid,
			name = xPlayer.PlayerData.charinfo.firstname .. " " .. xPlayer.PlayerData.charinfo.lastname,
			job = xPlayer.PlayerData.job.name
		})
	end

	cb(players)
end)

QBCore.Functions.CreateCallback('esx_society:setJob', function(source, cb, citizenid, jobName, grade)
	local xPlayer = QBCore.Functions.GetPlayer(source)
	if xPlayer.PlayerData.job.boss then
		local xTarget = QBCore.Functions.GetPlayerByCitizenId(citizenid)
		TriggerClientEvent("QBCore:Notify", source, "Action Applied")
		if xTarget then
			xTarget.Functions.SetJob(jobName, grade)
			cb()
		else
			MySQL.query('SELECT job FROM players WHERE citizenid = @citizenid', {
				['@citizenid'] = citizenid
			}, function (results)
				local jobsTable = json.decode(results[1].job)
				jobsTable.grade = grade
				jobsTable.payment = QBCore.Shared.Jobs[jobName].grade[grade].payment
				jobsTable.gradelabel = QBCore.Shared.Jobs[jobName].grade[grade].label
				jobsTable.label = QBCore.Shared.Jobs[jobName].label
				jobsTable.name = jobName

				if QBCore.Shared.Jobs[jobName].grade[grade].boss then
					jobsTable.boss = true
				else
					jobsTable.boss = false
				end
				MySQL.update('UPDATE players SET jobname = @jobname, job = @job WHERE citizenid = @citizenid', {
					['@jobname'] = jobName,
					['@job'] = json.encode(jobsTable),
					['@citizenid'] = citizenid
				}, function()
					cb()
				end)
			end)
		end
	else
		cb()
	end
end)

QBCore.Functions.CreateCallback('esx_society:setJobSalary', function(source, cb, job, grade, salary)
	local xPlayer = QBCore.Functions.GetPlayer(source)
	if xPlayer.PlayerData.job.boss then
		if salary <= Config.MaxSalary then
			QBCore.Shared.setJobMoney(job, grade, salary)
			QBCore.Shared.Jobs[job].grade[grade].payment = salary
			cb()
		else
			cb()
		end
	else
		cb()
	end
end)

QBCore.Functions.CreateCallback('esx_society:restDutyTime', function(source, cb, cid)
	local citizenid = cid
	local tPlayer = QBCore.Functions.GetPlayerByCitizenId(citizenid)
	if tPlayer then
		tPlayer.Functions.SetMetaData("dutytime", 0)
		tPlayer.Functions.Save()
		cb()
	else
		MySQL.query('SELECT metadata FROM players WHERE citizenid = @citizenid', {
			['@citizenid'] = citizenid
		}, function(results)
			local metaData = json.decode(results[1].metadata)
			metaData.dutytime = 0
			MySQL.update('UPDATE players SET metadata = @metadata WHERE citizenid = @citizenid', {
				['@citizenid'] = citizenid,
				['@metadata'] = json.encode(metaData),
			}, function()
				cb()
			end)
		end)
	end
end)