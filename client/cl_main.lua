function round(num, numDecimalPlaces)
    local mult = 10^(numDecimalPlaces or 0)
    return math.floor(num + 0.5 * mult)
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local lastheading = 1
        local heading = 1
        local lastStreetA = 0
        local lastStreetB = 0
        local camRot = GetGameplayCamRot(0)
        local playerPos = GetEntityCoords(PlayerPedId(), true)
        local streetA, streetB = GetStreetNameAtCoord(playerPos.x, playerPos.y, playerPos.z)
        street = {}
        heading = tostring(round(360.0 - ((camRot.z + 360.0) % 360.0)))
        if heading == '360' then heading = '0' end
        if heading ~= lastheading then
            if IsPedInAnyVehicle(PlayerPedId(), false) then
                SendNUIMessage({ action = "display", value = heading })
            else
                SendNUIMessage({ action = "hide", value = heading })
            end
        end
        
        lastHeading = heading

        if not ((streetA == lastStreetA or streetA == lastStreetB) and (streetB == lastStreetA or streetB == lastStreetB)) then
            lastStreetA = streetA
            lastStreetB = streetB
        end

        if lastStreetA ~= 0 then
            table.insert(street, GetStreetNameFromHashKey(lastStreetA))
        end

        if lastStreetB ~= 0 then
            table.insert(street, GetStreetNameFromHashKey(lastStreetB))
        end

        if street ~= lastStreet then
            if IsPedInAnyVehicle(PlayerPedId(), false) then
                SendNUIMessage({ action = "display", streetA = GetStreetNameFromHashKey(lastStreetA) })
                SendNUIMessage({ action = "display", streetB = GetStreetNameFromHashKey(lastStreetB) })
            else
                SendNUIMessage({ action = "hide", type = streetA })
            end
            Citizen.Wait(0)
        end
        lastStreet = street
        Citizen.Wait(0)
    end
end)