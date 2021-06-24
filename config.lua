Config = {}

---------
-- FIX --
---------

Config.DistanceFromTheEngine = 1.5 -- DISTANCE FROM THE ENGINE

Config.TimeRepair = 15000 -- TIME TO FIX THE ENGINE

-----------
-- CLEAN --
-----------

Config.DistanceFromTheVehicle = 1.5 -- DISTANCE FROM THE VEHICLE

Config.TimeClean = 10000 -- TIME TO CLEAN THE VEHICLE

-----------
-- WHEEL --
-----------

Config.DistanceFromTheWheel = 1.5 -- DISTANCE FROM THE WHEEL

Config.TimeWheel = 12500 -- TIME TO FIX THE WHEEL

-- DON'T TOUCH THIS
Config.Wheels = {
    [0] = "wheel_lf",
    [1] = "wheel_rf",
    [2] = "wheel_lm",
    [3] = "wheel_rm",
    [4] = "wheel_lr",
    [5] = "wheel_rr",
}

--------------
-- WORKSHOP --
--------------

-- LIST OF BLIPS TO REPAIR THE VEHICLE
Config.Workshops = {
    [1] = {
        pos = vector3(-222.896, -1329.750, 30.890)
    },
    -- [2] = {
    --     pos = vector3(233.876, -139.700, 20.435)
    -- },
    -- [3] = {
    --     pos = vector3(-456.823, 2139.575, 27.234)
    -- },
}

---------
-- ALL --
---------

Config.MechanicPermission = "vehicle.repair" -- PERMISSION TO MAKE ALL KINDS OF REPAIRS

-- HERE YOU CAN EDIT ITEMS
Config.Items = {

    fix = {
        spawnName = "repair_kit",
        name = "Repair Kit",
        description = "Use it to repair a vehicle!",
        choiceName = "Use",
        weight = 0.50,
    },

    clean = {
        spawnName = "cleaning_kit",
        name = "Cleaning Kit",
        description = "Use it to clean a vehicle!",
        choiceName = "Use",
        weight = 0.15,
    },

    wheel = {
        spawnName = "wheel_kit",
        name = "Wheel Kit",
        description = "Use it to repair a wheel of a vehicle!",
        choiceName = "Use",
        weight = 1.25,
    },
}

-- HERE YOU CAN EDIT LIMITS
Config.Limits = {

    fix = {
        enable = true,
        minUsersOnline = 0,
    },

    clean = {
        enable = true,
        minUsersOnline = 0,
    },

    wheel = {
        enable = true,
        minUsersOnline = 0,
    },

}

-- DON'T TOUCH THIS
Config.Anim = {

    fix = "PROP_HUMAN_BUM_BIN",

    clean = "WORLD_HUMAN_MAID_CLEAN",

    workshop = "PROP_HUMAN_BUM_BIN",

    wheel = {
        dict = "mini@repair",
        anim = "fixing_a_ped",
    },

    notFound = {
        dict = "gestures@m@standing@casual",
        anim = "gesture_damn",
    },

}