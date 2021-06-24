# [vRP] vrp_repair

vRP Repair System by *MyNameIsTeo__*

### Preview

[Click Here](https://streamable.com/krdqza)

- Time 0:08 `wheel_kit`
- Time 0:46 `cleaning_kit`
- Time 1:02 `repair_kit`
- Time 1:28 `Blip repair`
- Time 2:07 `Sbug`

### Explanation

This script contains 4 different repair methods. Three of these are usable items:
- Repair kit to repair the engine and oil leaks of the vehicle `repair_kit` (To use it you have to approach the engine of the vehicle)
- Cleaning kit to clean the vehicle `cleaning_kit` (To use this kit you must approach the vehicle)
- Wheel kit to replace the flat wheel of a vehicle `wheel_kit` (To use it you have to approach the flat wheel of the vehicle)
The last missing repair is the body repair (yeah, you don't fix the body with the repair kit) that can be done through one or more blips (modifiable through config) where you will make emote and repair not only the body of the vehicle but also clean it and fix it mechanically.

In the Config you can edit the permission used by mechanics, the name, description etc. of the kits and choose whether they can only be used by mechanics or also by citizens (Config.Limits)

*Example:*
```
Config.Limits = {
    fix = {
        enable = true, -- IF IS enable ALL CAN REPAIR USING THE repair_kit BUT
        minUsersOnline = 0, -- ONLY IF MECHANICALS ARE <= 0
    },
}
```

### Requirements:

- [Dunko vRP](https://github.com/DunkoUK/dunko_vrp)

### Installation

- Download the script
- If the name of the folder is `vrp_repair-master` rename it to `vrp_repair`.
- Put the `vrp_repair` folder in your server's resource folder 
- Add this in your `server.cfg`:
```
start vrp_repair
```

### Need help?

Contact me on my [Discord](https://discord.gg/xe4UVMZ)