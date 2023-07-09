Citizen.CreateThread( function()
    while true do
        Citizen.Wait(100)
        while not IsPedInAnyVehicle(PlayerPedId(), false) do
            Citizen.Wait(500)
        end

        local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
        
        if vehicle ~= nil then
                setSpeed(Config.maxspeed, vehicle)
        end
    end)

function setSpeed(speed, vehicle)
        --local defaultSpeed = GetVehicleHandlingFloat(vehicle, 'CHandlingData', 'fInitialDriveMaxFlatVel') --Could be used in specific cases -- no need for it atm
        local VdefaultSpeed = GetVehicleEstimatedMaxSpeed(vehicle)

        local vehicleClass = GetVehicleClass(vehicle)

        if Config.kmh then
            speed = speed / 3.6
        else
            speed = speed / 2.236936
        end

        if (vehicleClass ~= 16) or (vehicleClass ~= 15) or (vehicleClass ~= 14) then
            if VdefaultSpeed  > speed then
                SetVehicleMaxSpeed(vehicle, speed)
            end
        end
end

-- VEHICLE CLASSES
-- id = 0 --compacts
-- id = 1 --sedans
-- id = 2 --SUV's
-- id = 3, --coupes
-- id = 4 --muscle
-- id = 5 --sport classic
-- id = 6 --sport
-- id = 7 --super
-- id = 8 --motorcycle
-- id = 9 --offroad
-- id = 10 --industrial
-- id = 11 -utility
-- id = 12 --vans
-- id = 13 --bicycles
-- id = 14 --boats
-- id = 15, --helicopter
-- id = 16 --plane
-- id = 17 --service
-- id = 18 --emergency
-- id = 19 --military