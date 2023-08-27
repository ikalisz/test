local PlayerData = {}
QBCore = nil
Citizen.CreateThread(function()
    while QBCore == nil do
        TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)
        Citizen.Wait(200)
    end
end)

RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    PlayerData = QBCore.Functions.GetPlayerData()
end)



-- Meslek Update
RegisterNetEvent('QBCore:Client:OnJobUpdate')
AddEventHandler('QBCore:Client:OnJobUpdate', function(job)
    PlayerData.job = job
end)

function OpenBossMenu(society, close, options)
	if PlayerData.job.boss then
		options = options or {}
		local elements = {}

		QBCore.Functions.TriggerCallback('esx_society:getJobMoney', function(kasaPara)
			local kasadakipara = kasaPara

			local defaultOptions = {
				withdraw = true,
				deposit = true,
				wash = true,
				employees = true,
				grades = true
			}

			for k,v in pairs(defaultOptions) do
				if options[k] == nil then
					options[k] = v
				end
			end

			table.insert(elements, {label = "Cash $" .. QBCore.Shared.GroupDigits(kasadakipara)})

			if options.withdraw then
				table.insert(elements, {label = 'Withdraw Money from Company/Corporate Account', value = 'withdraw_society_money'})
			end

			if options.deposit then
				table.insert(elements, {label = 'Deposit to Company/Corporate Account', value = 'deposit_money'})
			end

			if options.employees then
				table.insert(elements, {label = 'Employee Management', value = 'manage_employees'})
			end

			if options.grades then
				table.insert(elements, {label = "Salary Management", value = 'manage_grades'})
			end

			QBCore.UI.Menu.Open('default', GetCurrentResourceName(), 'boss_actions_' .. society, {
				title    = 'Boss Menu',
				align    = 'top-left',
				elements = elements
			}, function(data, menu)
				if data.current.value == 'withdraw_society_money' then
					QBCore.UI.Menu.Open('dialog', GetCurrentResourceName(), 'withdraw_society_money_amount_' .. society, {
						title = "Get Money from the Cashier"
					}, function(data2, menu2)
						local amount = tonumber(data2.value)

						if amount == nil then
							QBCore.Functions.Notify("Incorrect Quantity")
						else
							menu2.close()
							TriggerServerEvent('esx_society:withdrawMoney', society, amount)
						end
					end, function(data2, menu2)
						menu2.close()
					end)
				elseif data.current.value == 'deposit_money' then
					QBCore.UI.Menu.Open('dialog', GetCurrentResourceName(), 'deposit_money_amount_' .. society, {
						title = "Put Money in the Safe"
					}, function(data2, menu2)
						local amount = tonumber(data2.value)

						if amount == nil then
							QBCore.Functions.Notify("Incorrect Quantity")
						else
							menu2.close()
							TriggerServerEvent('esx_society:depositMoney', society, amount)
						end
					end, function(data2, menu2)
						menu2.close()
					end)
				elseif data.current.value == 'manage_employees' then
					OpenManageEmployeesMenu(society)
				elseif data.current.value == 'manage_grades' then
					OpenManageGradesMenu(society)
				end
			end, function(data, menu)
				if close then
					close(data, menu)
				end
			end)
		end, society)
	end
end

function OpenManageEmployeesMenu(society)
	QBCore.UI.Menu.Open('default', GetCurrentResourceName(), 'manage_employees_' .. society, {
		title    = 'Employee management',
		align    = 'top-left',
		elements = {
			{label = "Employee list", value = 'employee_list'},
			{label = "Recruitment", value = 'recruit'}
	}}, function(data, menu)
		if data.current.value == 'employee_list' then
			OpenEmployeeList(society)
		elseif data.current.value == 'recruit' then
			OpenRecruitMenu(society)
		end
	end, function(data, menu)
		menu.close()
	end)
end

function OpenEmployeeList(society)
	QBCore.Functions.TriggerCallback('esx_society:getEmployees', function(employees)

		local elements = {
			head = {"Worker", "Working Hour", "Rank", "Action"},
			rows = {}
		}
		
		for i=1, #employees, 1 do
			local gradeLabel = employees[i].job.grade_name

			table.insert(elements.rows, {
				data = employees[i],
				cols = {
					employees[i].name,
					employees[i].time,
					gradeLabel,
					'{{' .. 'Change rank' .. '|promote}} {{' .. 'kov' .. '|fire}} {{' .. 'Reset Overtime' .. '|dutytime}}'
				}
			})
		end

		QBCore.UI.Menu.Open('list', GetCurrentResourceName(), 'employee_list_' .. society, elements, function(data, menu)
			local employee = data.data

			if data.value == 'promote' then
				menu.close()
				OpenPromoteMenu(society, employee)
			elseif data.value == 'fire' then
				QBCore.Functions.TriggerCallback('esx_society:setJob', function()
					OpenEmployeeList(society)
				end, employee.citizenid, 'unemployed', 1)
			elseif data.value == 'dutytime' then
				menu.close()
				QBCore.Functions.TriggerCallback('esx_society:restDutyTime', function(players)
					OpenEmployeeList(society)
				end, employee.citizenid)
			end
		end, function(data, menu)
			menu.close()
			OpenManageEmployeesMenu(society)
		end)
	end, society)
end

function OpenRecruitMenu(society)
	QBCore.Functions.TriggerCallback('esx_society:getOnlinePlayers', function(players)
		local elements = {}

		for i=1, #players, 1 do
			if players[i].job.name ~= society then
				table.insert(elements, {
					label = players[i].name,
					value = players[i].source,
					name = players[i].name,
					citizenid = players[i].citizenid
				})
			end
		end

		QBCore.UI.Menu.Open('default', GetCurrentResourceName(), 'recruit_' .. society, {
			title    = "Recruitment",
			align    = 'top-left',
			elements = elements
		}, function(data, menu)
			QBCore.UI.Menu.Open('default', GetCurrentResourceName(), 'recruit_confirm_' .. society, {
				title    = data.current.name .. " Would you like to hire someone?",
				align    = 'top-left',
				elements = {
					{label = "No", value = 'no'},
					{label = "Yes", value = 'yes'}
			}}, function(data2, menu2)
				menu2.close()

				if data2.current.value == 'yes' then
					QBCore.Functions.TriggerCallback('esx_society:setJob', function()
						OpenRecruitMenu(society)
					end, data.current.citizenid, society, 1)
				end
			end, function(data2, menu2)
				menu2.close()
			end)
		end, function(data, menu)
			menu.close()
		end)
	end)
end

function OpenPromoteMenu(society, employee)
	QBCore.Functions.TriggerCallback('esx_society:getJob', function(job)
		local elements = {}
		for i=1, #job, 1 do
			local gradeLabel = (job[i].label)

			table.insert(elements, {
				label = gradeLabel,
				value = i,
				--selected = (employee.job.grade == job.grades[i].grade)
			})
		end

		QBCore.UI.Menu.Open('default', GetCurrentResourceName(), 'promote_employee_' .. society, {
			title    = employee.name .. "Assign",
			align    = 'top-left',
			elements = elements
		}, function(data, menu)
			menu.close()
			QBCore.Functions.TriggerCallback('esx_society:setJob', function()
				OpenEmployeeList(society)
			end, employee.citizenid, society, data.current.value, 'promote')
		end, function(data, menu)
			menu.close()
			OpenEmployeeList(society)
		end)
	end, society)
end

function OpenManageGradesMenu(society)
	QBCore.Functions.TriggerCallback('esx_society:getJob', function(job)
		local elements = {}

		for i=1, #job do
			local gradeLabel = job[i].label

			table.insert(elements, {
				label = ('%s - <span style="color:green;"> &nbsp%s</span>'):format(gradeLabel, "$".. QBCore.Shared.GroupDigits(job[i].payment)),
				value = i
			})
		end

		QBCore.UI.Menu.Open('default', GetCurrentResourceName(), 'manage_grades_' .. society, {
			title    = "Salary Management",
			align    = 'top-left',
			elements = elements
		}, function(data, menu)
			QBCore.UI.Menu.Open('dialog', GetCurrentResourceName(), 'manage_grades_amount_' .. society, {
				title = "Salary amount"
			}, function(data2, menu2)

				local amount = tonumber(data2.value)

				if amount == nil then
					QBCore.Functions.Notify("Incorrect Quantity")
				elseif amount > Config.MaxSalary then
					QBCore.Functions.Notify("this salary is not allowed")
				else
					menu2.close()
					QBCore.Functions.TriggerCallback('esx_society:setJobSalary', function()
						OpenManageGradesMenu(society)
					end, society, data.current.value, amount)
				end
			end, function(data2, menu2)
				menu2.close()
			end)
		end, function(data, menu)
			menu.close()
		end)
	end, society)
end

AddEventHandler('esx_society:openBossMenu', function(society, close, options)
	OpenBossMenu(society, close, options)
end)
