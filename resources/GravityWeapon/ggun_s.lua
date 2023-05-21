ggun_enabled = {}

function togglePlayerGravityGun(player,on)
	if not (isElement(player) and getElementType(player) == "player") then return false end
	if on ~= true and on ~= false then return false end
	if ggun_enabled[player] == (on == true) then return false end
	ggun_enabled[player] = on == true
	if on then
		setElementData(player,"ggun_taken",true)
	else
		removeElementData(player,"ggun_taken")
	end
	toggleControl(player,"fire",not on)
	toggleControl(player,"action",not on)
	return true
end

function isGravityGunEnabled(player)
	return ggun_enabled[player] or false
end

addEventHandler("onPlayerQuit",root,function()
	ggun_enabled[source] = nil
	triggerClientEvent("onGGShell",resourceRoot,source,nil,false)
end
)

ped_timer = {}

addEvent("ggun_take",true)
addEventHandler("ggun_take",root,function()
	local tempTimer = getTickCount()
	if not ped_timer[client] then ped_timer[client] = tempTimer - 100 end
	if ped_timer[client] + 100 <= tempTimer then 
		if not isElement(getElementData(source,"ggun_taker")) and not isElement(getElementData(client,"ggun_taken")) then
			triggerClientEvent("onGGPlaySound",resourceRoot,client,"sounds/pickup.ogg",0.5)
			triggerClientEvent("onGGShell",resourceRoot,client,source,true)
			setElementData(client,"ggun_taken",source)
			setElementData(source,"ggun_taker",client)
			ped_timer[source] = tempTimer
		end
	end
end
)

addEvent("ggun_drop",true)
addEventHandler("ggun_drop",root,function()
	local tempTimer = getTickCount()
	if not ped_timer[client] then ped_timer[client] = tempTimer - 100 end
	if ped_timer[client] + 100 <= tempTimer then
		triggerClientEvent("onGGPlaySound",resourceRoot,client,"sounds/drop.ogg",0.3)
		triggerClientEvent("onGGShell",resourceRoot,client,nil,false)
		removeElementData(getElementData(client,"ggun_taken"),"ggun_taker")
		setElementData(client,"ggun_taken",true)
		ped_timer[source] = tempTimer
	end
end
)

addEvent("ggun_push",true)
addEventHandler("ggun_push",root,function(vx,vy,vz)
	local taker = getElementData(source,"ggun_taker")
	if isElement(taker) then setElementData(taker,"ggun_taken",true) end
	local vecLen = math.sqrt(vx * vx + vy * vy + vz * vz)
	triggerClientEvent("onGGPlaySound",resourceRoot,taker,"sounds/fire.ogg",vecLen)
	triggerClientEvent("onGGShell",resourceRoot,client,nil,false)
	triggerClientEvent("onGGCreateSparkEffect",resourceRoot,taker,vecLen)
	removeElementData(source,"ggun_taker")
	setElementVelocity(source,vx,vy,vz)
end
)

addEventHandler("onPlayerWasted", getRootElement(), function()
	if isGravityGunEnabled(source) then
		local elData = getElementData(source,"ggun_taken")
		if elData then
			if isElement(elData) then
				triggerClientEvent("onGGShell",resourceRoot,source,nil,false)
				removeElementData(elData,"ggun_taker")
			end
		end
		togglePlayerGravityGun(source,false)
	end
end
)

roll_timer = {}

-- Turn velocity control
addEvent("GGbindMouseRoll",true)
addEventHandler("GGbindMouseRoll",root,function(isDir)
	local tempTimer = getTickCount()
	if not roll_timer[source] then roll_timer[source] = tempTimer - 100 end
	if roll_timer[source] + 100 <= tempTimer then
		local taken = getElementData(source,"ggun_taken")
		if isElement(taken) then
			if getElementType(taken) == "vehicle" then
				local velX,velY,velZ = getElementAngularVelocity(taken)
				if isDir then
					if velZ<1 then
						setElementAngularVelocity (taken,velX,velY,velZ+0.02)
					end
				else
					if velZ>-1 then
						setElementAngularVelocity (taken,velX,velY,velZ-0.02)
					end
				end
				roll_timer[source] = tempTimer
			end
		end
	end
end
)
