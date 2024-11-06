local QBCore = exports['qb-core']:GetCoreObject()

QBCore.Functions.CreateCallback('eh-storages:checkStorage', function(source, cb, storageId)

    local result = MySQL.Sync.fetchScalar("SELECT COUNT(1) FROM storageunits WHERE id = @id", {
        ['@id'] = storageId
    })

    local isowned = result > 0

    if isowned then
        cb(true)
    else
        cb(false)
    end
end)

QBCore.Functions.CreateCallback('eh-storages:isExpired', function(source, cb, storageId)

    local result = MySQL.Sync.fetchScalar("SELECT expiring_date FROM storageunits WHERE id = @id", {
        ['@id'] = storageId
    })

    local currentDate = os.date("%Y/%m/%d/%H:%M:%S")
    local targetDate = result


    if currentDate < targetDate then
        cb(false)
    else
        cb(true)
    end
end)

QBCore.Functions.CreateCallback('eh-storages:checkOwner', function(source, cb, storageId)
    local result = MySQL.Sync.fetchAll('SELECT owner FROM storageunits WHERE id = ?', {storageId})

    if result and #result > 0 then
        local sobstvenik = result[1].owner
        cb(sobstvenik)
    else
        cb(false)
    end
end)

QBCore.Functions.CreateCallback('eh-storages:checkTier', function(source, cb, storageId)
    local result = MySQL.Sync.fetchAll('SELECT tier FROM storageunits WHERE id = ?', {storageId})

    if result and #result > 0 then
        local tier = result[1].tier
        cb(tier)
    else
        cb(false)
    end
end)

QBCore.Functions.CreateCallback('eh-storages:Checkpassword', function(source, cb, storageid, password)

    local storage = MySQL.Sync.fetchAll('SELECT id, password FROM storageunits WHERE id = ? And password = ? ',{storageid, password})
    if next(storage) then
        cb(true)
    else
        return cb(false)
    end
end)

QBCore.Functions.CreateCallback('eh-storages:upDate', function(source, cb, storageid, tier)

	local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    if Player.PlayerData.money.bank >= Config.Tiers[tier].price then
        local date = os.date("%Y/%m/%d/%H:%M:%S", os.time() + 7 * 24 * 60 * 60)

        MySQL.Async.execute("UPDATE storageunits SET expiring_date = @date WHERE id = @id", {["@id"] = storageid, ["@date"] = date}, function(affectedRows)
            if affectedRows > 0 then
                cb(true)
                Player.Functions.RemoveMoney('bank', Config.Tiers[tier].price)
            else
                return cb(false)
            end
        end)
    else
        -- TriggerClientEvent('QBCore:Notify', src, 'Нямате достатъчно пари в банковата си сметка.', 'error', 5000, 'Складове')
        Notify(Lang:t("error.notEnoughMoney"), "error", 5000, true, src)
    end
end)

QBCore.Functions.CreateCallback('eh-storages:changePassword', function(source, cb, storageid, newpassword)

    MySQL.Async.execute("UPDATE storageunits SET password = @password WHERE id = @id", {["@id"] = storageid, ["@password"] = newpassword}, function(affectedRows)
        if affectedRows > 0 then
            cb(true)
        else
            return cb(false)
        end
    end)
end)

QBCore.Functions.CreateCallback('eh-storages:buyStorage', function(source, cb, storageid, owner, password, tier)
	local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    local date = os.date("%Y/%m/%d/%H:%M:%S", os.time() + 7 * 24 * 60 * 60)

    if Player.PlayerData.money.bank >= Config.Tiers[tier].price then
        local storage = MySQL.Sync.execute('INSERT INTO storageunits (`id`, `owner`, `password`, `expiring_date`, `tier`) VALUES (?, ?, ?, ?, ?)',{storageid, owner, password, date, tier})
        cb(true)
        Player.Functions.RemoveMoney('bank', Config.Tiers[tier].price)
    else
        Notify(Lang:t("error.notEnoughMoney"), "error", 5000, true, src)
    end
end)

QBCore.Functions.CreateCallback('eh-storages:cancelRent', function(source, cb, storageId)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    
    local result = MySQL.Sync.fetchScalar("DELETE FROM storageunits WHERE id = @id", {
        ['@id'] = storageId
    })

    local result2 = MySQL.Sync.fetchScalar("DELETE FROM stashitems WHERE stash = @stash", {
        ['@stash'] = 'storage_'.. storageId
    })
    
    cb(true)

end)