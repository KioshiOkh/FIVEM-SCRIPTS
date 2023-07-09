Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if IsControlJustPressed(1, 38) then
            TriggerServerEvent('kioshi:lsmCheck')
        end
    end
end)