local mysql = exports["oxmysql"]
local VorpInv = exports.vorp_inventory:vorp_inventoryApi()


VorpInv.registerInventory("Comunitario", "Comunitario", 1000, true, true,true, false, false,false)

-- Configuração de um raio de 2 metros
local radius = 2

-- Definindo as coordenadas dos pontos centrais das áreas
local centerPoint1 = vector3(-291.67, 785.1, 119.47)
local centerPoint2 = vector3(2635.6, -1271.51, 52.48)
local centerPoint3 = vector3(-790.83, -1304.68, 43.84)
local centerPoint4 = vector3(2922.89, 1353.37, 45.06)
local centerPoint5 = vector3(-1407.31, -2297.29, 43.62)
local centerPoint6 = vector3(-1316.34, 2436.4, 310.94)

-- Definindo a área permitida
local allowedArea = {
    {
        minX = centerPoint1.x - radius,
        maxX = centerPoint1.x + radius,
        minY = centerPoint1.y - radius,
        maxY = centerPoint1.y + radius,
        minZ = centerPoint1.z - radius,
        maxZ = centerPoint1.z + radius
    },
    {
        minX = centerPoint2.x - radius,
        maxX = centerPoint2.x + radius,
        minY = centerPoint2.y - radius,
        maxY = centerPoint2.y + radius,
        minZ = centerPoint2.z - radius,
        maxZ = centerPoint2.z + radius
    },
    {
        minX = centerPoint3.x - radius,
        maxX = centerPoint3.x + radius,
        minY = centerPoint3.y - radius,
        maxY = centerPoint3.y + radius,
        minZ = centerPoint3.z - radius,
        maxZ = centerPoint3.z + radius
    },
    {
        minX = centerPoint4.x - radius,
        maxX = centerPoint4.x + radius,
        minY = centerPoint4.y - radius,
        maxY = centerPoint4.y + radius,
        minZ = centerPoint4.z - radius,
        maxZ = centerPoint4.z + radius
    },
    {
        minX = centerPoint5.x - radius,
        maxX = centerPoint5.x + radius,
        minY = centerPoint5.y - radius,
        maxY = centerPoint5.y + radius,
        minZ = centerPoint5.z - radius,
        maxZ = centerPoint5.z + radius
    },
    {
        minX = centerPoint6.x - radius,
        maxX = centerPoint6.x + radius,
        minY = centerPoint6.y - radius,
        maxY = centerPoint6.y + radius,
        minZ = centerPoint6.z - radius,
        maxZ = centerPoint6.z + radius
    }
}



RegisterNetEvent('bauComunitario')
AddEventHandler('bauComunitario', function(args)
    local source = source
    local playerCoords = GetEntityCoords(GetPlayerPed(source))
    
    if source > 0 and isInArea(playerCoords, allowedArea) then
        VorpInv.OpenInv(source, 'Comunitario')
    else
        TriggerClientEvent("chatMessage", source, "^1Você precisa estar perto de algum bau de doações para usar este comando!")
    end
end)

RegisterCommand("comunitario", function(source, args, rawCommand)
    TriggerClientEvent('bauComunitarioClient', source, args)
end)

function isInArea(coords, area)
    for i = 1, #area do
        if coords.x >= area[i].minX and coords.x <= area[i].maxX
            and coords.y >= area[i].minY and coords.y <= area[i].maxY
            and coords.z >= area[i].minZ and coords.z <= area[i].maxZ then
            return true
        end
    end
    return false
end

AddEventHandler("playerSpawned", function()
    TriggerClientEvent("chatMessage", source, "^3Você está na área permitida para o comando /comunitario.")
end)

AddEventHandler("playerEnteredZone", function(zone)
    if isInArea(GetEntityCoords(GetPlayerPed(source)), allowedArea) then
        TriggerClientEvent("chatMessage", source, "^3Você está na área permitida para o comando /comunitario.")
    end
end)