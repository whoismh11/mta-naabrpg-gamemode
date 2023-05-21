-- settings
local ReplacedWeaponID = 27
local sparkCountMultiplier = 70
local maxEffectDistance = 60
local maxSyncDistance = 60

-- don't touch those
local obj_vel = 0
local buildupTimer = nil
local isLocalEquip = false
local isLocalAming = false

-- Gravity gun main
bindKey("fire","down",function()
	if not getPedControlState("aim_weapon") or isElementInWater(localPlayer) then return end
	local ggun_obj = getElementData(localPlayer,"ggun_taken")
	if not ggun_obj then
		isLocalAming = false
		return
	end 
	if isElement(ggun_obj) and isTimer(buildupTimer) then
		if not isElement(ggun_obj) then ggun_obj = getPedTarget(localPlayer) end
		if not ggun_obj then return end
		local x1,y1,z1 = getElementPosition(localPlayer)
		local x2,y2,z2 = getElementPosition(ggun_obj)
		x2,y2,z2 = x2-x1,y2-y1,z2-z1
		if obj_vel then
			local spd = obj_vel/math.sqrt(x2*x2+y2*y2+z2*z2)
			x2,y2,z2 = x2*spd,y2*spd,z2*spd
			if (math.sqrt(x2*x2+y2*y2+z2*z2) > 0.05) then
				triggerServerEvent("ggun_push",ggun_obj,x2,y2,z2)
			else
				triggerServerEvent("ggun_drop",root)
			end
			killTimer(buildupTimer)
			isLocalAming = false
		end
	else
		if not isElement(ggun_obj) then
			local target = getPedTarget(localPlayer)		
			if target and getElementType(target) ~= "object" and not isElementFrozen(target) then
				if getElementType(target)=="vehicle" then
					local vehType = getVehicleType(target)
					if vehType=="Train" or vehType=="Boat" then
						ggPlaySound(localPlayer,"sounds/fail.ogg",0.5)
						return
					end
				end					
				triggerServerEvent("ggun_take",target)
				if isTimer(buildupTimer) then 
					killTimer(buildupTimer) 
				end
				isLocalAming = true
				createBuildupTimer()
			else
				ggPlaySound(localPlayer,"sounds/fail.ogg",0.5)
			end
		else
			triggerServerEvent("ggun_drop",root)
			killTimer(buildupTimer)
			isLocalAming = false
		end
	end
end
)

addEventHandler("onClientGUIClick", getRootElement(), function()
	if isLocalAming then
		if isElement(getElementData(localPlayer,"ggun_taken")) then
			triggerServerEvent("ggun_drop",root)
			isLocalAming = false
		end
	end
end
)
		
bindKey("aim_weapon","up",function()
	if isElement(getElementData(localPlayer,"ggun_taken")) then
		triggerServerEvent("ggun_drop",root)
		isLocalAming = false
	end
end
)

-- velocity timer		
function createBuildupTimer()
	obj_vel = 0
	buildupTimer = setTimer ( function ()
		if  getKeyState("lalt") then 
			if obj_vel >= 1  then 
				obj_vel = 1
				return 
			end
			obj_vel = obj_vel+0.025
		else
			if obj_vel <= 0  then 
				obj_vel = 0 
				return 
			end
			obj_vel = obj_vel-0.025
		end
	end, 60 , 0 )
	return buildupTimer
end

-- velocity bar
local scx, scy = guiGetScreenSize()
addEventHandler("onClientRender",root,function()
	if not isLocalEquip then return end
	local resMult = (scx/scy)*(6/8)
	dxDrawRectangle(scx*0.78,resMult*scy *0.14334,(scx*0.0666),resMult*(scy*0.02667),tocolor(5,5,5,255))
		dxDrawRectangle(scx*0.7825,resMult*scy*0.14667,(scx*0.0616),resMult*(scy*0.02),tocolor(55, 20,20,255))
	if obj_vel and isLocalAming then
		dxDrawRectangle(scx*0.7825,resMult*scy*0.14667,(scx*0.0616)*math.max(0,obj_vel),resMult*(scy*0.02),tocolor(200*obj_vel+55, 20 + 100 * obj_vel,20,255))
	end
end
)

addEventHandler ("onClientResourceStart",getResourceRootElement( getThisResource()),function()
	if getPedWeapon(getLocalPlayer(),currentWeaponID)==ReplacedWeaponID then
		isLocalEquip = true
	else
		isLocalEquip = false
	end
end
)

-- Drop element if fall down or in water
local lastTick = getTickCount()
addEventHandler("onClientRender",root,function()
	if getTickCount() - lastTick > 300 then
		if isPedDoingTask(localPlayer,"TASK_SIMPLE_FALL") or isElementInWater(localPlayer) then
			if isElement(getElementData(localPlayer,"ggun_taken")) and not isPedDead(localPlayer) then
				isLocalAming = false
				triggerServerEvent("ggun_drop",root)
			end
		end
		lastTick = getTickCount()
	end
end
)

-- Set element velocity
addEventHandler("onClientRender",root,function()
	local all_players = getElementsByType("player")
	for plnum,player in ipairs(all_players) do
		local taken = getElementData(player,"ggun_taken")
		local cx,cy,cz = getCameraMatrix()
		if isElement(taken) then
			if isElementStreamedIn(taken) and isElementStreamedIn(player) then		
				local x0,y0,z0 = getElementPosition(player)
				if getDistanceBetweenPoints3D (x0,y0,z0,cx,cy,cz)<maxSyncDistance then
					local x1,y1,z1 = getPedTargetStart(player)
					local x2,y2,z2 = getPedTargetEnd(player)
					local x3,y3,z3 = getPedBonePosition (player,25)
					x2,y2,z2 = x2-x1,y2-y1,z2-z1
					local dist = 5/math.sqrt(x2*x2+y2*y2+z2*z2)
					x2,y2,z2 = x2*dist,y2*dist,z2*dist
					local fx,fy,fz = x1+x2,y1+y2,z1+z2
					local cx,cy,cz = getElementPosition(taken)
					x2,y2,z2 = fx-cx,fy-cy,fz-cz
					local spd = math.min(0.05*math.sqrt(x2*x2+y2*y2+z2*z2),0.1)
					x2,y2,z2 = x2*spd,y2*spd,z2*spd
					setElementVelocity(taken,x2,y2,z2)
				end
			end
		end
	end
end
)
	
-- Turn velocity control
addEventHandler("onClientResourceStart", getResourceRootElement( getThisResource()), function()
	local getLastTick = getTickCount()
	function setMouseRollSv(isRight)
		local currentTick = getTickCount()
		if getLastTick + 100 < currentTick then 
			triggerServerEvent("GGbindMouseRoll",localPlayer,isRight) 
			getLastTick = currentTick 
		end 
	end
	bindKey("mouse_wheel_up","down", function() setMouseRollSv(true) end)
	bindKey("mouse_wheel_down","down", function() setMouseRollSv(false) end)
end
)

-- Weapon sounds
addEventHandler ("onClientPlayerWeaponSwitch",getRootElement(),function(previousWeaponID,currentWeaponID)
	if getPedWeapon(getLocalPlayer(),currentWeaponID)==ReplacedWeaponID then
		isLocalEquip = true
		ggPlaySound(localPlayer,"sounds/equip.ogg",0.5)
	else
		isLocalEquip = false
	end
end
)

function ggPlaySound(player,soundPath,volume)
	local x,y,z = getElementPosition(player)
	local cx,cy,cz = getCameraMatrix()
	if getDistanceBetweenPoints3D (x,y,z,cx,cy,cz)>maxEffectDistance then return end
	local ggSound = playSound3D ( soundPath, x, y, z, false)
	setSoundMaxDistance(ggSound,60)
	setSoundMinDistance(ggSound,5)
	setSoundVolume(ggSound,volume)
end

addEvent("onGGPlaySound",true)
addEventHandler("onGGPlaySound",getResourceRootElement(getThisResource()),ggPlaySound)

-- Spark effects
function ggCreateSparkFx(player,force)
	local x1,y1,z1 = getPedBonePosition(player,24)
	local cx,cy,cz = getCameraMatrix()
	if getDistanceBetweenPoints3D(x1,y1,z1,cx,cy,cz)>maxEffectDistance then return end
	local x2,y2,z2 = getPedBonePosition(player,25)
	local vx,vy,vz = x2-x1,y2-y1,z2-z1
	local leng = math.sqrt(vx*vx+vy*vy+vz*vz)
	vx,vy,vz = vx/leng, vy/leng, vz/leng
	local px,py,pz = x1+(vx/2),y1+(vy/2),z1+0.15+(vz/2)
	fxAddSparks( px,py,pz,vx,vy,vz,force, math.ceil(sparkCountMultiplier*force),-vx/3,-vy/3,-vz/3,false,3,1)
end

addEvent("onGGCreateSparkEffect",true)
addEventHandler("onGGCreateSparkEffect",getResourceRootElement(getThisResource()),ggCreateSparkFx)
