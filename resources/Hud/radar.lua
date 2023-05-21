--Features
local enableBlips = true
local renderNorthBlip = true
local alwaysRenderMap = false --true = always render map, false = only render when in interior world 0 (radar will stay, only the map will stop rendering)
local alwaysRenderOxygen = false --true = always render oxygen, false = only when oxygen not full/local player in water
local disableGTASAhealth = true --Disable GTASA's HUD health display
local disableGTASAarmor = true --Disable GTASA's HUD armour display
local disableGTASAoxygen = true --Disable GTASA's HUD oxygen display

--Dimensions & Sizes
local worldW, worldH = 2000, 2000 --map image dimensions - if map image changed, please edit appropriately
local blip = 10 --Blip size, pixels relative to 1366x768 resolution

--Colours - Notice: Health colours smoothly according it local player's HP.
local healthOkayR, healthOkayG, healthOkayB = 0, 255, 130 --RGB for health which is 'okay' (50% or more)
local healthBadR, healthBadG, healthBadB = 200, 0, 0 --RGB for health which is 'bad' (25%)
local healthCriticalR, healthCriticalG, healthCriticalB = 255, 0, 0 --RGB for health which is 'critically low' (near/at 0%)
local armorColorR, armorColorG, armorColorB = 0, 175, 240
local oxygenColorR, oxygenColorG, oxygenColorB = 255, 255, 0



------------------------------------------------------------------------------------
--Do not modify anything below unless you're absolutely sure of what you're doing.--
------------------------------------------------------------------------------------

local sx, sy = guiGetScreenSize()
local rt = dxCreateRenderTarget(290, 175)
local xFactor, yFactor = sx/1125, sy/807
local xFactor = yFactor --otherwise the radar looses it's 2:3 ratio.


-- Useful functions --
function findRotation(x1,y1,x2,y2) --Author: Doomed_Space_Marine & robhol
  local t = -math.deg(math.atan2(x2-x1,y2-y1))
  if t < 0 then t = t + 360 end;
  return t;
end
function getPointFromDistanceRotation(x, y, dist, angle) --Author: robhol
    local a = math.rad(90 - angle);
    local dx = math.cos(a) * dist;
    local dy = math.sin(a) * dist;
    return x+dx, y+dy;
end

function drawRadar()
	setPlayerHudComponentVisible("all", false)
	setPlayerHudComponentVisible("crosshair", true)
	if disableGTASAhealth then setPlayerHudComponentVisible("health", false) end
	if disableGTASAarmor then setPlayerHudComponentVisible("armour", false) end
	if disableGTASAoxygen then setPlayerHudComponentVisible("breath", false) end
	if (not isPlayerMapVisible()) then
		local mW, mH = dxGetMaterialSize(rt)
		local x, y = getElementPosition(localPlayer)
		local X, Y = mW/2 -(x/(6000/worldW)), mH/2 +(y/(6000/worldH))
		local camX,camY,camZ = getElementRotation(getCamera())
		dxSetRenderTarget(rt, true)
		if alwaysRenderMap or getElementInterior(localPlayer) == 0 then
			dxDrawRectangle(0, 0, mW, mH, 0xFF7CA7D1) --render background
			dxDrawImage(X - worldW/2, mH/5 + (Y - worldH/2), worldW, worldH, "images/world.jpg", camZ, (x/(6000/worldW)), -(y/(6000/worldH)), tocolor(255, 255, 255, 200))
		end
		dxSetRenderTarget()
		dxDrawRectangle((14)*xFactor, sy-((197+10))*yFactor, (292)*xFactor, (188)*yFactor, tocolor(0, 0, 0, 200))
		dxDrawImage((10+5)*xFactor, sy-((200+5))*yFactor, (300-10)*xFactor, (175)*yFactor, rt, 0, 0, 0, tocolor(255, 255, 255, 200))
		local health = math.max(math.min(getElementHealth(localPlayer)/(0.232018558500192*getPedStat(localPlayer, 24) -32.018558511152), 1), 0)
		local armor = math.max(math.min(getPedArmor(localPlayer)/100, 1), 0)
		local oxygen = math.max(math.min(getPedOxygenLevel(localPlayer)/(1.5*getPedStat(localPlayer, 225) +1000), 1), 0)
		local r, g, b
		if health >= 0.25 then
			r, g, b = interpolateBetween(healthBadR, healthBadG, healthBadB, healthOkayR, healthOkayG, healthOkayB, math.floor(health*20)/10, "InOutQuad")
		else
			r, g, b = interpolateBetween(healthCriticalR, healthCriticalB, healthCriticalB, healthBadR, healthBadG, healthBadB, math.floor(health*20)/10, "InOutQuad")
		end
		local col = tocolor(r, g, b, 190)
		local bg = tocolor(r, g, b, 100)
		dxDrawRectangle((15)*xFactor, sy-(29)*yFactor, (144.9)*xFactor, (8)*yFactor, bg)
		dxDrawRectangle((15)*xFactor, sy-(29)*yFactor, (144.9*health)*xFactor, (8)*yFactor, col)
		if alwaysRenderOxygen or (oxygen < 1 or isElementInWater(localPlayer)) then
			dxDrawRectangle((161)*xFactor, sy-(29)*yFactor, (71.3)*xFactor, (8)*yFactor, tocolor(armorColorR, armorColorG, armorColorB, 100))
			dxDrawRectangle((161)*xFactor, sy-(29)*yFactor, (71.3*armor)*xFactor, (8)*yFactor, tocolor(armorColorR, armorColorG, armorColorB, 190))
			dxDrawRectangle((233)*xFactor, sy-(29)*yFactor, (71.3)*xFactor, (8)*yFactor, tocolor(oxygenColorR, oxygenColorG, oxygenColorB, 100))
			dxDrawRectangle((233)*xFactor, sy-(29)*yFactor, (71.3*oxygen)*xFactor, (8)*yFactor, tocolor(oxygenColorR, oxygenColorG, oxygenColorB, 190))
		else
			dxDrawRectangle((160.8)*xFactor, sy-(29)*yFactor, (143.9)*xFactor, (7.5)*yFactor, tocolor(armorColorR, armorColorG, armorColorB, 100))
			dxDrawRectangle((160.8)*xFactor, sy-(29)*yFactor, (143.9*armor)*xFactor, (7.5)*yFactor, tocolor(armorColorR, armorColorG, armorColorB, 190))
		end
		local rx, ry, rz = getElementRotation(localPlayer)
		local lB = (25)*xFactor
		local rB = (15+280)*xFactor
		local tB = sy-(195)*yFactor
		local bB = tB + (155)*yFactor
		local cX, cY = (rB+lB)/2, (tB+bB)/2 +(35)*yFactor
		local toLeft, toTop, toRight, toBottom = cX-lB, cY-tB, rB-cX, bB-cY
		for k, v in ipairs(getElementsByType("blip")) do
			local bx, by = getElementPosition(v)
			local actualDist = getDistanceBetweenPoints2D(x, y, bx, by)
			local maxDist = getBlipVisibleDistance(v)
			if actualDist <= maxDist and getElementDimension(v)==getElementDimension(localPlayer) and getElementInterior(v)==getElementInterior(localPlayer) then
				local dist = actualDist/(6000/((worldW+worldH)/2))
				local rot = findRotation(bx, by, x, y)-camZ
				local bpx, bpy = getPointFromDistanceRotation(cX, cY, math.min(dist, math.sqrt(toTop^2 + toRight^2)), rot)
				local bpx = math.max(lB, math.min(rB, bpx))
				local bpy = math.max(tB, math.min(bB, bpy))
				local bid = getElementData(v, "customIcon") or getBlipIcon(v)
				local _, _, _, bcA = getBlipColor(v)
				local bcR, bcG, bcB = 255, 255, 255
				if getBlipIcon(v) == 0 then
					bcR, bcG, bcB = getBlipColor(v)
				end
				local bS = getBlipSize(v)
				dxDrawImage(bpx -(blip*bS)*xFactor/2, bpy -(blip*bS)*yFactor/2, (blip*bS)*xFactor, (blip*bS)*yFactor, "images/blip/"..bid..".png", 0, 0, 0, tocolor(bcR, bcG, bcB, bcA))
			end
		end
		if renderNorthBlip then
			local rot = -camZ+180
			local bpx, bpy = getPointFromDistanceRotation(cX, cY, math.sqrt(toTop^2 + toRight^2), rot) --get position
			local bpx = math.max(lB, math.min(rB, bpx))
			local bpy = math.max(tB, math.min(bB, bpy)) --cap position to screen
			local dist = getDistanceBetweenPoints2D(cX, cY, bpx, bpy) --get distance to the capped position
			local bpx, bpy = getPointFromDistanceRotation(cX, cY, dist, rot) --re-calculate position based on new distance
			if bpx and bpy then --if position was obtained successfully
				local bpx = math.max(lB, math.min(rB, bpx))
				local bpy = math.max(tB, math.min(bB, bpy)) --cap position just in case
				dxDrawImage(bpx -(blip*2)/2, bpy -(blip*2)/2, blip*2, blip*2, "images/blip/4.png", 0, 0, 0) --draw north (4) blip
			end
		end
		dxDrawImage(cX -(blip*2)*xFactor/2, cY -(blip*2)*yFactor/2, (blip*2)*xFactor, (blip*2.6)*yFactor, "images/player.png", camZ-rz, 0, 0)
	end
end
addEventHandler("onClientRender", root, drawRadar)

addEventHandler("onClientResourceStop", resourceRoot, function()
	setPlayerHudComponentVisible("all", true)
	if disableGTASAhealth then setPlayerHudComponentVisible("health", true) end
	if disableGTASAarmor then setPlayerHudComponentVisible("armour", true) end
	if disableGTASAoxygen then setPlayerHudComponentVisible("breath", true) end
end)
