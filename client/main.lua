vRP = Proxy.getInterface("vRP")
vRPserver = Tunnel.getInterface("vRP", "vrp_repair")
REPserver = Tunnel.getInterface("vrp_repair", "vrp_repair")
Tunnel.bindInterface("vrp_repair", vRPrepair)

REPserver.RefreshPoints({})

AddEventHandler("playerSpawned",function(name, setMessage, deferrals)

    REPserver.RefreshPoints6({})
end)

RegisterNetEvent("vRP:RefreshJob")
AddEventHandler("vRP:RefreshJob", function()

    REPserver.RefreshPoints({})
end)

AddEventHandler('onResourceStop', function(resource)
    
    if resource == GetCurrentResourceName() then

        REPserver.DestroyPoints({})
    end
end)