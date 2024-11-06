QBCore = exports['qb-core']:GetCoreObject()
Config = {}

Config.Tiers = { -- you can add as many as you want but you need to edit "availableTiers" in Storages
    [1] = {
        name = 'Small',
        price = 5000,
        maxWeight = 100000,
        slots = 36,
        rentDays = 999999 -- For how many days is the storage rent [you still need to change "week" in the locales]
    },
    [2] = {
        name = 'Medium',
        price = 10000,
        maxWeight = 250000,
        slots = 46,
        rentDays = 999999 -- For how many days is the storage rent [you still need to change "week" in the locales]
    },
    [3] = {
        name = 'Big',
        price = 15000,
        maxWeight = 500000,
        slots = 56,
        rentDays = 999999 -- For how many days is the storage rent [you still need to change "week" in the locales]
    }
}

Config.Storages = { -- all storages' polyzones for the eye
    [1] = {coords = vector3(-73.25, -1197.58, 27.67), heading = 0.0, width = 2.2, length = 5.0, minZ=26.67, maxZ=30.67},
    [2] = {coords = vector3(-67.8, -1199.76, 27.73), heading = 315.0, width = 2.2, length = 5.0, minZ=26.67, maxZ=30.67},
    [3] = {coords = vector3(-62.14, -1205.51, 28.29), heading = 312.0, width = 2.2, length = 5.0, minZ=26.67, maxZ=30.67},
    [4] = {coords = vector3(-56.76, -1210.8, 28.64), heading = 315.0, width = 2.2, length = 5.0, minZ=26.67, maxZ=30.67},
    [5] = {coords = vector3(-53.74, -1216.65, 28.7), heading = 270.0, width = 2.2, length = 5.0, minZ=26.67, maxZ=30.67},
    [6] = {coords = vector3(-78.53, -1203.43, 27.62), heading = 0.0, width = 2.2, length = 5.0, minZ=26.67, maxZ=30.67},
    [7] = {coords = vector3(-70.51, -1205.91, 27.88), heading = 315.0, width = 2.2, length = 5.0, minZ=26.67, maxZ=30.67},
    [8] = {coords = vector3(-65.3, -1211.12, 28.29), heading = 315.0, width = 2.2, length = 5.0, minZ=26.67, maxZ=30.67},
    [9] = {coords = vector3(-66.18, -1227.21, 28.85), heading = 52.0, width = 2.2, length = 5.0, minZ=26.67, maxZ=30.67},
    [10] = {coords = vector3(-71.84, -1234.27, 29.02), heading = 51.0, width = 2.2, length = 5.0, minZ=26.67, maxZ=30.67},
    [11] = {coords = vector3(-57.23, -1228.45, 28.76), heading = 47.0, width = 2.5, length = 5.0, minZ=26.67, maxZ=30.67},
    [12] = {coords = vector3(-61.33, -1232.87, 28.87), heading = 47.0, width = 2.5, length = 5.0, minZ=26.67, maxZ=30.67},
    [13] = {coords = vector3(-66.72, -1238.76, 29.01), heading = 47.0, width = 2.5, length = 5.0, minZ=26.67, maxZ=30.67},
    [14] = {coords = vector3(-73.56, -1242.71, 29.17), heading = 47.0, width = 2.5, length = 5.0, minZ=26.67, maxZ=30.67},
    [15] = {coords = vector3(-85.86, -1794.85, 28.45), heading = 47.0, width = 2.5, length = 5.0, minZ=26.67, maxZ=30.67},
    [16] = {coords = vector3(183.06, -1840.47, 28.24), heading = 47.0, width = 2.5, length = 5.0, minZ=26.67, maxZ=30.67},
    [17] = {coords = vector3(-320.25, -1400.65, 31.77), heading = 47.0, width = 2.5, length = 5.0, minZ=26.67, maxZ=30.67},
}

function OpenStorage(StorageId, Tier)
    TriggerServerEvent("ps-inventory:server:OpenInventory", "stash", "storage_"..StorageId, {
        maxweight = Config.Tiers[Tier].maxWeight,
        slots = Config.Tiers[Tier].slots,
    })
    TriggerEvent("ps-inventory:client:SetCurrentStash", "storage_"..StorageId)
end

function Notify(message, type, time, isServer, source)
    if isServer then
        TriggerClientEvent('QBCore:Notify', source, message, type, time, 'Storages')
    else
        QBCore.Functions.Notify(message, type, time, 'Storages')
    end
end