-- For all Screens --       
local sx,sy = guiGetScreenSize()
local px,py = 1600,900
local x,y =  (sx/px), (sy/py)

-- Tacho --
addEventHandler("onClientRender", root,
function ( source )
    local playerVehicle = getPedOccupiedVehicle ( getLocalPlayer() )
    if playerVehicle then
    local vehicleHealth = getElementHealth ( playerVehicle )
    local vehicleSpeed = getElementVelocity ( playerVehicle )
    dxDrawLine(x*-1130, y*602, x*500, y*602, tocolor(0, 0, 0, 0), 3, true)
    dxDrawLine(x*-1130, y*686, x*500, y*686, tocolor(0, 0, 0, 0), 3, true)
    dxDrawLine(x*-1130, y*601, x*500, y*687, tocolor(0, 0, 0, 0), 3, true)
    dxDrawLine(x*1590, y*600, x*1590, y*686, tocolor(0, 0, 0, 0), 3, true)
    dxDrawRectangle(x*16, y*636, x*134, y*31, tocolor(0, 0, 0, 170), true) -- Rahmen
    dxDrawRectangle(x*1854, y*614, x*126, y*23, tocolor(0, 0, 0, 0), true) -- Health
    dxDrawRectangle(x*1454, y*614, x*126/1000*vehicleHealth, y*23, tocolor(0, 0, 0, 0), true) -- Health
    dxDrawText((math.floor(vehicleHealth/10)).."", x*999, y*999, x*999, y*999, tocolor(255, 255, 255, 255), 1.30, "default-bold", "center", "center", false, false, true, false, false) -- Health
    sx, sy, sz = getElementVelocity (getPedOccupiedVehicle(localPlayer)) -- Speed
    vehiclekmh = math.floor(((sx^2 + sy^2 + sz^2)^(0.5))*180) -- Speed
    dxDrawText(""..tostring(vehiclekmh).."kmh", x*999, y*999, x*999, y*999, tocolor(255, 255, 255, 255), 1.20, "default-bold", "center", "center", false, false, true, false, false) -- Speed
    end
end)

function nitroShow()
    if isPedInVehicle(localPlayer) then
    local car = getPedOccupiedVehicle(localPlayer)
    local nitro = getVehicleNitroLevel(car)
        if nitro ~= false and nitro ~= nil and nitro > 0 then
            dxDrawRectangle(x*20, y*640, x*126, y*23, tocolor(44, 44, 44, 255), true) -- Nos Show
            dxDrawRectangle(x*20, y*640, x*126/10*10*nitro, y*23, tocolor(0, 70, 149, 255), true) -- Nos Show
            dxDrawText((math.floor(nitro/1*100)).."% Nitro", x*-1291, y*-49, x*1454, y*1354, tocolor(255, 255, 255, 255), 1.30, "default-bold", "center", "center", false, false, true, false, false) -- Nos Show
        else
            --dxDrawRectangle(x*1305, y*814, x*126, y*23, tocolor(0, 70, 149, 255), true) -- Nos Hide
            dxDrawText("No Nitro", x*-1291, y*-49, x*1454, y*1354, tocolor(255, 255, 255, 255), 1.30, "default-bold", "center", "center", false, false, true, false, false) -- Nos Hide
        end
    end
end
addEventHandler("onClientRender",getRootElement(),nitroShow)
