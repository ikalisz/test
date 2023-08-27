RegisterNetEvent('evy_arm:check_sv')
AddEventHandler('evy_arm:check_sv', function(nearTableId)
    if props[nearTableId].place1 == 0 and not props[nearTableId].started then
        props[nearTableId].place1 = source
        TriggerClientEvent('evy_arm:check_cl', source, 'place1')
    elseif props[nearTableId].place2 == 0 and props[nearTableId].place1 ~= 0 then
        props[nearTableId].place2 = source
        TriggerClientEvent('evy_arm:check_cl', source, 'place2')
    else
        TriggerClientEvent('evy_arm:check_cl', source, 'noplace')
    end

    if props[nearTableId].place1 ~= 0 and props[nearTableId].place2 ~= 0 and not props[nearTableId].started then
        TriggerClientEvent('evy_arm:start_cl', props[nearTableId].place1)
        TriggerClientEvent('evy_arm:start_cl', props[nearTableId].place2)
    end
end)

RegisterNetEvent('evy_arm:updategrade_sv')
AddEventHandler('evy_arm:updategrade_sv', function(gradeUpValue, nearTableId)
    if props[nearTableId].place1 == source or props[nearTableId].place2 == source then
        props[nearTableId].grade = props[nearTableId].grade + gradeUpValue
        if props[nearTableId].grade <= 0.10 then
            props[nearTableId].grade = -999
        elseif props[nearTableId].grade >= 0.90 then
            props[nearTableId].grade = 999
        end
        
        TriggerClientEvent('evy_arm:updategrade_cl', props[nearTableId].place1, props[nearTableId].grade)
        TriggerClientEvent('evy_arm:updategrade_cl', props[nearTableId].place2, props[nearTableId].grade)
    end
end)

RegisterNetEvent('evy_arm:disband_sv')
AddEventHandler('evy_arm:disband_sv', function(nearTableId)
    if props[nearTableId].place1 == source or props[nearTableId].place2 == source then
        if props[nearTableId].place1 ~= 0 then
            TriggerClientEvent('evy_arm:reset_cl', props[nearTableId].place1)
        end
        if props[nearTableId].place2 ~= 0 then
            TriggerClientEvent('evy_arm:reset_cl', props[nearTableId].place2)
        end
        props[nearTableId].place1 = 0
        props[nearTableId].place2 = 0
        props[nearTableId].started = false
        props[nearTableId].grade = 0.5
    end
end)