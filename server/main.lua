local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
local htmlEntities = module("vrp", "lib/htmlEntities")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","vrp_repair")
REPclient = Tunnel.getInterface("vrp_repair","vrp_repair")
Tunnel.bindInterface("vrp_repair", vRPrepair)

AddEventHandler("vRP:playerJoinGroup", function(user_id, group, gtype)
    local player = vRP.getUserSource({user_id})
  
    TriggerClientEvent("vRP:RefreshJob", player)
end)

vRP.defInventoryItem({Config.Items.fix.spawnName, Config.Items.fix.name, Config.Items.fix.description, function(args)
    local choices = {}
  
    choices[Config.Items.fix.choiceName] = {function(source, choice)
        local user_id = vRP.getUserId({source})
        local player = vRP.getUserSource({user_id})

        if not vRP.hasPermission({user_id, Config.MechanicPermission}) then

            if Config.Limits.fix.enable then
                local checkLimit = vRPrepair.CheckUsersWithJob(Config.MechanicPermission, Config.Limits.fix.minUsersOnline)

                if checkLimit then

                    REPclient.StartRepair(player, {})

                else

                    vRPclient.playAnim(player, {false, {{Config.Anim.notFound.dict, Config.Anim.notFound.anim, 1}}, false})

                    vRPclient.notify(player, {"There are mechanics online, call one!"})
                end

            else
            
                vRPclient.playAnim(player, {false, {{Config.Anim.notFound.dict, Config.Anim.notFound.anim, 1}}, false})

                vRPclient.notify(player, {"You do not have enough permissions!"})
            end

        else

            REPclient.StartRepair(player, {})
        end
    end}

    return choices
end, Config.Items.fix.weight})

vRP.defInventoryItem({Config.Items.clean.spawnName, Config.Items.clean.name, Config.Items.clean.description, function(args)
    local choices = {}
  
    choices[Config.Items.clean.choiceName] = {function(source, choice)
        local user_id = vRP.getUserId({source})
        local player = vRP.getUserSource({user_id})

        if not vRP.hasPermission({user_id, Config.MechanicPermission}) then

            if Config.Limits.clean.enable then
                local checkLimit = vRPrepair.CheckUsersWithJob(Config.MechanicPermission, Config.Limits.clean.minUsersOnline)

                if checkLimit then

                    REPclient.StartClean(player, {})

                else

                    vRPclient.playAnim(player, {false, {{Config.Anim.notFound.dict, Config.Anim.notFound.anim, 1}}, false})

                    vRPclient.notify(player, {"There are mechanics online, call one!"})
                end

            else
            
                vRPclient.playAnim(player, {false, {{Config.Anim.notFound.dict, Config.Anim.notFound.anim, 1}}, false})

                vRPclient.notify(player, {"You do not have enough permissions!"})
            end

        else

            REPclient.StartClean(player, {})
        end
    end}

    return choices
end, Config.Items.clean.weight})

vRP.defInventoryItem({Config.Items.wheel.spawnName, Config.Items.wheel.name, Config.Items.wheel.description, function(args)
    local choices = {}
  
    choices[Config.Items.wheel.choiceName] = {function(source, choice)
        local user_id = vRP.getUserId({source})
        local player = vRP.getUserSource({user_id})

        if not vRP.hasPermission({user_id, Config.MechanicPermission}) then

            if Config.Limits.wheel.enable then
                local checkLimit = vRPrepair.CheckUsersWithJob(Config.MechanicPermission, Config.Limits.wheel.minUsersOnline)

                if checkLimit then

                    REPclient.StartWheelRepair(player, {})

                else

                    vRPclient.playAnim(player, {false, {{Config.Anim.notFound.dict, Config.Anim.notFound.anim, 1}}, false})

                    vRPclient.notify(player, {"There are mechanics online, call one!"})
                end

            else
            
                vRPclient.playAnim(player, {false, {{Config.Anim.notFound.dict, Config.Anim.notFound.anim, 1}}, false})

                vRPclient.notify(player, {"You do not have enough permissions!"})
            end

        else

            REPclient.StartWheelRepair(player, {})
        end
    end}

    return choices
end, Config.Items.wheel.weight})