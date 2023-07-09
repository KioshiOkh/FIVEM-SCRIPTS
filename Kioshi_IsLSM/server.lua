local ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)


RegisterServerEvent('kioshi:lsmCheck')
AddEventHandler('kioshi:lsmCheck', function(ID, targetID, type)

    local identifier = ESX.GetPlayerFromId(ID).identifier
    local _source 	 = ESX.GetPlayerFromId(targetID).source
    local job        = ESX.GetPlayerFromId(targetID).job.label

    MySQL.Async.fetchAll(SELECT firstname, lastname, dateofbirth, sex, height FROM users WHERE identifier = @identifier', {['@identifier'] = identifier},
    function(user)
        if(user[1]~= nil) then
            MySQL.Async.fetchAll('SELECT type FROM user_licenses WHERE owner = @identifier', {['@identifier'] = identifier},
            function(licenses)
                if type ~= 'lsm' then
                    if job == 'LSM' then
                        MySQL.Sync.execute('INSERT type INTO user_licenses WHERE owner = @identifier', {['@identifier'] = identifier, ['@type'] = 'lsm'})
                        TriggerClientEvent('esx:showNotification', _source, 'Du hast deinen Dienstausweis erhalten!')
                    else
                        return false
                    end
                else
                    if job ~= 'LSM' then
                        MySQL.Sync.execute('DELETE type FROM user_licenses WHERE owner = @identifier', {['@identifier'] = identifier, ['@type'] = 'lsm'})
                        TriggerClientEvent('esx:showNotification', _source, 'Du hast deinen Dienstausweis abgegeben!')
                    else
                        return true
                    end
            end)
    end)
end)