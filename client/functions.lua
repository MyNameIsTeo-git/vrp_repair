vRPrepair = {
    isWorkshopOn = false,
}

function vRPrepair.StartRepair()
    local playerPed = GetPlayerPed(-1)
    local playerCoords = GetEntityCoords(playerPed)
    local vehicle = GetClosestVehicle(playerCoords, 5.0, 0, 71)
    local engine = GetEntityBoneIndexByName(vehicle, 'engine')
    local engineCoords = GetWorldPositionOfEntityBone(vehicle, engine)

    if DoesEntityExist(vehicle) then

        if IsPedOnFoot(playerPed) then

            if IsVehicleSeatFree(vehicle, -1) then

                if GetDistanceBetweenCoords(playerCoords, engineCoords, true) <= Config.DistanceFromTheEngine then
                    
                    REPserver.GetInventoryItemFix({vehicle})
                    
                else

                    vRP.playAnim({false, {{Config.Anim.notFound.dict, Config.Anim.notFound.anim, 1}}, false})

                    vRP.notify({"Move closer to the engine and try again!"})
                end

            else

                vRP.playAnim({false, {{Config.Anim.notFound.dict, Config.Anim.notFound.anim, 1}}, false})

                vRP.notify({"There must be no one driving!"})
            end
            
        else

            vRP.playAnim({false, {{Config.Anim.notFound.dict, Config.Anim.notFound.anim, 1}}, false})

            vRP.notify({"You must be out of the vehicle!"})
        end

    else

        vRP.playAnim({false, {{Config.Anim.notFound.dict, Config.Anim.notFound.anim, 1}}, false})

        vRP.notify({"There are no vehicles nearby!"})
    end
end

function vRPrepair.RepairVehicle(vehicle)
    local playerPed = GetPlayerPed(-1)
    local playerPedId = PlayerPedId()
    local percentage = math.random(0, 100)

    if DoesEntityExist(vehicle) then

        FreezeEntityPosition(playerPed, true)

        SetVehicleDoorOpen(vehicle, 4, 0, 0)

        TaskStartScenarioInPlace(playerPed, Config.Anim.fix, 0, true)
    
        Citizen.Wait(Config.TimeRepair)
    
        ClearPedTasks(playerPedId)
    
        FreezeEntityPosition(playerPed, false)

        Citizen.Wait(2000)
    
        SetVehicleDoorShut(vehicle, 4, 0, 0)
    
        if percentage <= 77 then

            SetVehicleEngineHealth(vehicle, 1000.0) 
            
            SetVehiclePetrolTankHealth(vehicle, 1000.0)

            vRP.notify({"The vehicle has been repaired!"})

        else

            vRP.playAnim({false, {{Config.Anim.notFound.dict, Config.Anim.notFound.anim, 1}}, false})

            vRP.notify({"You were not able to repair the vehicle, please try again!"})
        end

    else

        vRP.playAnim({false, {{Config.Anim.notFound.dict, Config.Anim.notFound.anim, 1}}, false})

        vRP.notify({"Something went wrong!"})
    end
end

function vRPrepair.StartClean()
    local playerPed = GetPlayerPed(-1)
    local playerCoords = GetEntityCoords(playerPed)
    local vehicle = GetClosestVehicle(playerCoords, 5.0, 0, 71)
    local vehicleCoords = GetEntityCoords(vehicle)

    if DoesEntityExist(vehicle) then

        if IsPedOnFoot(playerPed) then

            if IsVehicleSeatFree(vehicle, -1) then

                if GetDistanceBetweenCoords(playerCoords, vehicleCoords, true) <= Config.DistanceFromTheVehicle then
                    
                    REPserver.GetInventoryItemClean({vehicle})
                    
                else

                    vRP.playAnim({false, {{Config.Anim.notFound.dict, Config.Anim.notFound.anim, 1}}, false})

                    vRP.notify({"Move closer to the vehicle and try again!"})
                end

            else

                vRP.playAnim({false, {{Config.Anim.notFound.dict, Config.Anim.notFound.anim, 1}}, false})

                vRP.notify({"There must be no one driving!"})
            end
            
        else

            vRP.playAnim({false, {{Config.Anim.notFound.dict, Config.Anim.notFound.anim, 1}}, false})

            vRP.notify({"You must be out of the vehicle!"})
        end

    else

        vRP.playAnim({false, {{Config.Anim.notFound.dict, Config.Anim.notFound.anim, 1}}, false})

        vRP.notify({"There are no vehicles nearby!"})
    end
end

function vRPrepair.CleanVehicle(vehicle)
    local playerPed = GetPlayerPed(-1)
    local playerPedId = PlayerPedId()

    if DoesEntityExist(vehicle) then

        FreezeEntityPosition(playerPed, true)

        TaskStartScenarioInPlace(playerPed, Config.Anim.clean, 0, true)
    
        Citizen.Wait(Config.TimeClean)
    
        ClearPedTasks(playerPedId)
        
        FreezeEntityPosition(playerPed, false)

        WashDecalsFromVehicle(vehicle, 1.0)
        
        SetVehicleDirtLevel(vehicle)

        vRP.notify({"The vehicle has been cleaned!"})

    else

        vRP.playAnim({false, {{Config.Anim.notFound.dict, Config.Anim.notFound.anim, 1}}, false})

        vRP.notify({"Something went wrong!"})
    end
end

function vRPrepair.StartWorkshop()
    Citizen.CreateThread(function()

        local playerPed = GetPlayerPed(-1)
        local playerPedId = PlayerPedId()

        vRPrepair.isWorkshopOn = true

        while vRPrepair.isWorkshopOn do

            Citizen.Wait(5)

            if IsPedInAnyVehicle(playerPed, false) then

                vRPrepair.ShowHelpNotification("Press ~INPUT_PICKUP~ to repair and clean the vehicle.")

                if IsControlJustPressed(0, 38) then

                    local vehicle = GetVehiclePedIsIn(playerPed, false)

                    if DoesEntityExist(vehicle) then

                        vRPrepair.isWorkshopOn = false

                        local vehicleHeading = GetEntityHeading(vehicle)

                        SetVehicleEngineOn(vehicle, false, false, false)

                        TaskLeaveVehicle(playerPed, vehicle, 0)

                        Citizen.Wait(1500)

                        FreezeEntityPosition(vehicle, true)

                        SetVehicleDoorsLocked(vehicle, 3)

                        SetEntityHeading(playerPed, vehicleHeading - 90)

                        TaskStartScenarioInPlace(playerPed, Config.Anim.workshop, 0, true)

                        Citizen.Wait(Config.TimeRepair)

                        TaskStartScenarioInPlace(playerPed, Config.Anim.clean, 0, true)

                        Citizen.Wait(Config.TimeClean)

                        ClearPedTasks(playerPedId)

                        SetVehicleFixed(vehicle)

                        SetVehicleEngineHealth(vehicle, 1000.0) 

                        SetVehiclePetrolTankHealth(vehicle, 1000.0)

                        WashDecalsFromVehicle(vehicle, 1.0)

                        SetVehicleDirtLevel(vehicle)

                        FreezeEntityPosition(vehicle, false)

                        SetVehicleDoorsLocked(vehicle, 1)

                        TaskEnterVehicle(playerPed, vehicle, 20000, -1, 1.0, 1, 0)

                        vRP.notify({"The vehicle has been repaired and cleaned!"})
                    end
                end
            end
        end
    end)
end

function vRPrepair.StopWorkshop()

    vRPrepair.isWorkshopOn = false
end

function vRPrepair.clearArea(coords)    
    local vehicle = GetClosestVehicle(coords, 7.0, 0, 71)

    if DoesEntityExist(vehicle) then

        SetEntityAsMissionEntity(vehicle, true, true)

        Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(vehicle))
    end
end

function vRPrepair.StartWheelRepair()
    local playerPed = GetPlayerPed(-1)
    local playerCoords = GetEntityCoords(playerPed)
    local vehicle = GetClosestVehicle(playerCoords, 5.0, 0, 71)
    local wheel = nil
    local nWheel = nil

    for k, v in pairs(Config.Wheels) do

        if IsVehicleTyreBurst(vehicle, k, false) then

            wheel = GetEntityBoneIndexByName(vehicle, v)

            nWheel = k

            break
        end
    end
    
    if wheel ~= nil then
        local wheelCoords = GetWorldPositionOfEntityBone(vehicle, wheel)

        if DoesEntityExist(vehicle) then

            if IsPedOnFoot(playerPed) then
    
                if IsVehicleSeatFree(vehicle, -1) then
    
                    if GetDistanceBetweenCoords(playerCoords, wheelCoords, true) <= Config.DistanceFromTheEngine then
                        
                        REPserver.GetInventoryItemWheel({vehicle, nWheel})
                        
                    else
    
                        vRP.playAnim({false, {{Config.Anim.notFound.dict, Config.Anim.notFound.anim, 1}}, false})
    
                        vRP.notify({"Move closer to the wheel and try again!"})
                    end
    
                else
    
                    vRP.playAnim({false, {{Config.Anim.notFound.dict, Config.Anim.notFound.anim, 1}}, false})
    
                    vRP.notify({"There must be no one driving!"})
                end
                
            else
    
                vRP.playAnim({false, {{Config.Anim.notFound.dict, Config.Anim.notFound.anim, 1}}, false})
    
                vRP.notify({"You must be out of the vehicle!"})
            end
    
        else
    
            vRP.playAnim({false, {{Config.Anim.notFound.dict, Config.Anim.notFound.anim, 1}}, false})
    
            vRP.notify({"There are no vehicles nearby!"})
        end

    else

        vRP.notify({"No flat tyres!"})
    end
end

function vRPrepair.WheelRepairVehicle(vehicle, nWheel)
    local playerPed = GetPlayerPed(-1)
    local playerPedId = PlayerPedId()
    local percentage = math.random(0, 100)

    if DoesEntityExist(vehicle) then

        FreezeEntityPosition(playerPed, true)

        ResetPedMovementClipset(playerPed, 0)

        vRP.playAnim({true, {{Config.Anim.wheel.dict, Config.Anim.wheel.anim, 1}}, false})

        RequestAnimSet("move_ped_crouched")

        while (not HasAnimSetLoaded("move_ped_crouched")) do 
            
            Citizen.Wait(100)
        end 

        SetPedMovementClipset(playerPed, "move_ped_crouched", 0.25)

        Citizen.Wait(Config.TimeWheel)
    
        ClearPedTasks(playerPedId)

        ResetPedMovementClipset(playerPed, 0)

        FreezeEntityPosition(playerPed, false)
    
        SetVehicleTyreFixed(vehicle, nWheel)

        vRP.notify({"The wheel has been repaired!"})

    else

        vRP.playAnim({false, {{Config.Anim.notFound.dict, Config.Anim.notFound.anim, 1}}, false})

        vRP.notify({"Something went wrong!"})
    end
end

function vRPrepair.ShowHelpNotification(msg)

    AddTextEntry("STRING" .. msg, msg)
    BeginTextCommandDisplayHelp("STRING" .. msg)
    EndTextCommandDisplayHelp(0, false, true, -1)
end