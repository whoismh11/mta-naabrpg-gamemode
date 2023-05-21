function asd(plr)
local veh = getPedOccupiedVehicle(plr)

    if ( getVehicleOverrideLights (veh) == 2 ) then
        setVehicleOverrideLights (veh, 1)
    else
        setVehicleOverrideLights (veh, 2)
    end
end

addEventHandler("onResourceStart", getRootElement(), function()
for k, v in ipairs(getElementsByType("player")) do
bindKey(v, "lctrl", "down", asd)
end
end
)

addEventHandler("onPlayerJoin", root, function()
bindKey(source, "lctrl", "down", asd)
end
)
