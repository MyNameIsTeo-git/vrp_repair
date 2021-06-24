vRPrepair = {}

function vRPrepair.CheckUsersWithJob(job, limit)
    local amount = #vRP.getUsersByPermission({job})
    
    if amount <= limit then
    
        return true
    
    else

        return false
    end
end

function vRPrepair.GetInventoryItemFix(vehicle)
    local user_id = vRP.getUserId({source})
    local player = vRP.getUserSource({user_id})

    if vRP.getInventoryItemAmount({user_id, Config.Items.fix.spawnName}) > 0 then
		
        vRP.tryGetInventoryItem({user_id, Config.Items.fix.spawnName, 1, true})
				
        REPclient.RepairVehicle(player, {vehicle})

	else

        vRPclient.playAnim(player, {false, {{Config.Anim.notFound.dict, Config.Anim.notFound.anim, 1}}, false})

        vRPclient.notify(player, {"You don't have the Repair Kit!"})
	end
end

function vRPrepair.GetInventoryItemClean(vehicle)
    local user_id = vRP.getUserId({source})
    local player = vRP.getUserSource({user_id})

    if vRP.getInventoryItemAmount({user_id, Config.Items.clean.spawnName}) > 0 then
		
        vRP.tryGetInventoryItem({user_id, Config.Items.clean.spawnName, 1, true})
				
        REPclient.CleanVehicle(player, {vehicle})

	else

        vRPclient.playAnim(player, {false, {{Config.Anim.notFound.dict, Config.Anim.notFound.anim, 1}}, false})

        vRPclient.notify(player, {"You don't have the Cleaning Kit!"})
	end
end

function vRPrepair.GetInventoryItemWheel(vehicle, nWheel)
    local user_id = vRP.getUserId({source})
    local player = vRP.getUserSource({user_id})

    if vRP.getInventoryItemAmount({user_id, Config.Items.wheel.spawnName}) > 0 then
		
        vRP.tryGetInventoryItem({user_id, Config.Items.wheel.spawnName, 1, true})
				
        REPclient.WheelRepairVehicle(player, {vehicle, nWheel})

	else

        vRPclient.playAnim(player, {false, {{Config.Anim.notFound.dict, Config.Anim.notFound.anim, 1}}, false})

        vRPclient.notify(player, {"You don't have the Wheel Kit!"})
	end
end

function vRPrepair.BuildPoints()
    local user_id = vRP.getUserId({source})
    local player = vRP.getUserSource({user_id})

    if vRP.hasPermission({user_id, Config.MechanicPermission}) then

        for k, v in pairs(Config.Workshops) do

            vRPclient.setNamedMarker(player, {"vRPrepair:Workshop:" .. k, v.pos.x, v.pos.y, v.pos.z - 1, 3.0, 3.0, 0.3, 0, 125, 255, 125, 150})
        
            vRP.setArea({player, "vRPrepair:Workshop:" .. k, v.pos.x, v.pos.y, v.pos.z, 1, 5.0, area_enter, area_leave})
        end
    end
end

function vRPrepair.RefreshPoints()
    local user_id = vRP.getUserId({source})
    local player = vRP.getUserSource({user_id})

    if vRP.hasPermission({user_id, Config.MechanicPermission}) then

        vRPrepair.BuildPoints()
    
    else

        vRPrepair.DestroyPoints()
    end
end

function vRPrepair.DestroyPoints()
    local user_id = vRP.getUserId({source})
    local player = vRP.getUserSource({user_id})

    for k, v in pairs(Config.Workshops) do

        vRPclient.removeNamedMarker(player, {"vRPrepair:Workshop:" .. k})

        vRP.removeArea({player, "vRPrepair:Workshop:" .. k})

        REPclient.clearArea(player, {v.pos})
    end
end

function area_enter(source, area)
    local user_id = vRP.getUserId({source})
    local player = vRP.getUserSource({user_id})

    REPclient.StartWorkshop(player, {})
end


function area_leave(source, area)
    local user_id = vRP.getUserId({source})
    local player = vRP.getUserSource({user_id})

    REPclient.StopWorkshop(player, {})
end