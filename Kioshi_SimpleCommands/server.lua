

RegisterCommand(
    "blip",
    function(source, args, rawCommand)
        TriggerEvent("kioshi_simpleCommand:createBlip", source, args)
end, 
true --[[false = command can be executed by any player, true = command can only be executed by the server console or Admin]]
) 


RegisterCommand(
    "removeblip",
    function(source, args, rawCommand)
        TriggerEvent("kioshi_simpleCommand:removeBlip", source, args)
end, true
) 

RegisterCommand(
    "gunclear",
    function(source, args, rawCommand)
        TriggerEvent("kioshi_simpleCommand:removeAllWeaponFromAPlayer", source, args)
end, true
) 






 --This is the function to create the blip.
RegisterNetEvent("createBlip")
AddEventHandler(
    "kioshi_simpleCommand:createBlip",
    function(source, args)
    
        local pCoords = GetEntityCoords(PlayerPedId(source))
        local blip = AddBlipForArea(pCoords.x, pCoords.y, pCoords.z, 100.0, 50.0)
        local blipName = args[1] ? args[1] : "Blip"
        local colour = args[3] ? args[3] : 1
        local id = args[2] ? args[2] : 1


        -- If the source is > 0, then that means it must be a player.
        if (source > 0) then

            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString(blipName)
            EndTextCommandSetBlipName(blip)
            SetBlipColour(blip, colour)
            SetBlipScale(blip, 1)   
            SetBlipDisplay(blip, 2)
            SetBlipSprite(blip, id)

            Print("Created blip " .. blipName .." at ".. pCoords.x ..", "..pCoords.y ..", ".. pCoords.z .. ".")

        -- If it's not a player, then it must be RCON, a resource, or the server console directly.
        else
            print("This command cannot be executed from the server console or a resource.")
            RemoveBlip(blip)
            blip = nil
        end
end)


    --This is the function to remove the blip.
RegisterNetEvent("kioshi_simpleCommand:removeBlip")
AddEventHandler(
    "kioshi_simpleCommand:removeBlip",
    function(source, args)

        local blipToRemove = args[1] ? args[1] : "Blip"

        RemoveBlip(blipToRemove)
        Print("Removed blip " .. blipToRemove .. ".")
end)

 --This function removes all weapons from a player.
RegisterNetEvent("kioshi_simpleCommand:removeAllWeaponFromAPlayer")
AddEventHandler(
    "kioshi_simpleCommand:removeAllWeaponFromAPlayer",
    function(source, args)

        local player = GetPlayerPed(source)
        RemoveAllPedWeapons(PlayerPedId(args[1]), true)

        print("Removed all weapons from " .. GetPlayerName(args[1]) .. ".")

end)