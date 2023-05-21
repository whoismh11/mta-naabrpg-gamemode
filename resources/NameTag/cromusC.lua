local font = dxCreateFont("gfx/font.ttf",7,true)
local dxCromus = dxCreateFont("gfx/font.ttf",10,true)
local normalDrawDistance = 70.0
local drawDistance = normalDrawDistance
local eventDrawDistance = 10.0

function onClientResourceStart(resource)
	visibleTick = getTickCount()
	counter = 0
	customHealthbar = false
	for k, player in pairs(getElementsByType("player")) do
		setPlayerNametagShowing(player, false)
	end	
end
addEventHandler("onClientResourceStart", resourceRoot, onClientResourceStart )

function onClientResourceStop(resource)
	for k, player in pairs(getElementsByType("player")) do
		setPlayerNametagShowing(player, true)
	end	
end
addEventHandler( "onClientResourceStop", resourceRoot, onClientResourceStop)

function onClientPlayerJoin()
	setPlayerNametagShowing(source, false)
end
addEventHandler("onClientPlayerJoin", root, onClientPlayerJoin)

function drawHPBar( x, y, v, d)
	if(v < 0.0) then
		v = 0.0
	elseif(v > 100.0) then
		v = 100.0
	end
	dxDrawImage(x - 40, y, 80, 8, "gfx/false.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
	dxDrawImage(x - 39, y + 1, v/1.28 , 6, "gfx/vida.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
end

function drawArmourBar( x, y, v, d)
	if(v < 0.0) then
		v = 0.0
	elseif(v > 100.0) then
		v = 100.0
	end
	dxDrawImage(x - 40, y, 80, 8, "gfx/false.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
	dxDrawImage(x - 39, y + 1, v/1.28 , 6, "gfx/colete.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
end

sx,sy = guiGetScreenSize()
px,py = 1366,768
SX,SY =  (sx/px), (sy/py)

function chatCheckPulse()
    local chatting = isChatBoxInputActive() or isConsoleActive()
	if(chatting ~= g_oldChatting) then
		setElementData(localPlayer, "chatting", chatting)
		g_oldChatting = chatting
	end 
end
setTimer(chatCheckPulse, 500, 0)

function drawPlayerTags()
	local cx, cy, cz, lx, ly, lz = getCameraMatrix()
	if(getElementData(localPlayer, "special.event")) then
		drawDistance = eventDrawDistance
	else
		drawDistance = normalDrawDistance
	end
	local target = getPedTarget(localPlayer)
	for k, player in pairs(getElementsByType("player", root, true)) do
		if(player ~= localPlayer) then
			local vx, vy, vz = getPedBonePosition(player, 8)
			local dist = getDistanceBetweenPoints3D(cx, cy, cz, vx, vy, vz )
			if dist < drawDistance or player == target then
				if( isLineOfSightClear(cx, cy, cz, vx, vy, vz, true, false, false) ) then
					local x, y = getScreenFromWorldPosition (vx, vy, vz + 0.3)
					if(x and y) then
						--local tag = getElementData(player, "gang.tag") or ""
						-- local name = tag .. getPlayerName(player) .. "(" .. (getElementData(player, "id") or "?") .. ")"
						-- local nameU = tag .. string.gsub(getPlayerName(player), "#%x%x%x%x%x%x", "") .. "(" .. (getElementData(player, "id") or "?") .. ")"
						local name = getPlayerName(player).."(ID:"..(getElementData(player, "ID") or 0)..")"
						local nameU = string.gsub(getPlayerName(player).."(ID:"..(getElementData(player, "ID") or 0)..")", "#%x%x%x%x%x%x", "")
						local scale = SY*1
						local w = dxGetTextWidth(nameU, scale, dxCromus)
						local h = dxGetFontHeight(scale, dxCromus)
						local color = tocolor(getPlayerNametagColor(player))

						dxDrawText(name, x - w / 2,y - h - 12, w, h, color, scale, dxCromus, "left", "top", false, false, false, true, false)

						if(getElementData(player, "chatting")) then
						dxDrawImage ( x - 1  - w / 2 - h-h/5,y - 1 - h - 15, h, h, "gfx/level_typing.png", 0, 0, 0, color)
	
						end
	
						local health = getElementHealth ( player )
						local armour = getPedArmor ( player )

						if(health > 0.0) then
							local rate =   math.ceil(500/(getPedStat(player,24)))
							drawHPBar(x, y-2.0, health*rate, dist)
							if(armour > 0.0) then
								drawArmourBar(x, y-10.0, armour, dist)
							end
							local cargo = getElementData(player, "cargo")
							if(cargo) then
								w = dxGetTextWidth(cargo, 1.2, font )
								dxDrawText(cargo, x - 1  - w / 2,y - 1 - h - 12-18, w, h, tocolor(0,0,0), 1.2, font)			
							end					
						end
					end
				end
			end
		end
	end
end

function drawPedTags()
	local cx, cy, cz, lx, ly, lz = getCameraMatrix()
	local target = getPedTarget(localPlayer)
	for k, ped in pairs(getElementsByType("ped", root, true)) do
		if(getElementData(ped, "nametagShowing")) then
			local vx, vy, vz = getPedBonePosition(ped, 8)
			local dist = getDistanceBetweenPoints3D(cx, cy, cz, vx, vy, vz )
			if dist < drawDistance or ped == target then
				if( isLineOfSightClear(cx, cy, cz, vx, vy, vz, true, false, false) ) then
					local x, y = getScreenFromWorldPosition (vx, vy, vz + 0.3)
					if(x and y) then
						local tag = getElementData(ped, "gang.tag") or ""
						local name = tag .. (getElementData(ped, "pedName") or "")
						local scale = SY*0.9
						local w = dxGetTextWidth(name, scale, font)
						local h = dxGetFontHeight(scale, font)
						
						local color = tocolor(255,255,255)
						
						local pedNametagColor = getElementData(ped, "pedNametagColor")
						
						if(pedNametagColor) then
							local r,g,b = unpack(pedNametagColor)
							color = tocolor(r,g,b)
						end

						dxDrawText(name, x - 1  - w / 2,y - 1 - h, w, h, tocolor(0,0,0,200), scale, font)
						dxDrawText(name, x - w / 2,y - h, w, h, color, scale, font)

						local health = getElementHealth(ped)
						local armour = getPedArmor(ped)

						if(health > 0.0) then
							local rate =   math.ceil(500/(getPedStat(ped,24)))
							--drawHPBar(x, y-6.0, health*rate, dist)
							if(armour > 0.0) then
								--drawArmourBar(x, y-12.0, armour, dist)
							end				
						end
						if(getElementData(ped, "hologram")) then
							local text = "Desconectado"
							w = dxGetTextWidth(text, 1, "default-bold")
							dxDrawText(text, x - 1  - w / 2,y - 1 - h - 12-18, w, h, tocolor(0,0,0), 1, "default-bold")
							dxDrawText(text, x - w / 2,y - h - 12-18, w, h, tocolor(255,255,255), 1, "default-bold")
						end						
					end
				end
			end
		end
	end
end

function drawCarTags()
	local cx, cy, cz, lx, ly, lz = getCameraMatrix()
	for k, vehicle in pairs(getElementsByType("vehicle", root, true)) do
		local px, py, pz = getElementPosition(vehicle)
		local dist = getDistanceBetweenPoints3D(cx, cy, cz, px, py, pz)
		if dist < 60 then
			if( isLineOfSightClear(cx, cy, cz, px, py, pz, true, false, false) ) then
				local x, y = getScreenFromWorldPosition (px, py, pz + 1)
				if(x and y) then
					local owner = getElementData(vehicle, "owner")
					if isElement(owner) then
						local ownerName = getPlayerName(owner)
						local h = dxGetFontHeight(SY*0.8, fontPlayers)
						local w = dxGetTextWidth(ownerName, SY*0.8, fontPlayers)
						dxDrawText(ownerName, x - w / 2, y + h*-2, w, h, tocolor(getPlayerNametagColor(owner)), SY*0.8, fontPlayers)			
					end
				end
			end
		end
	end
end

function onClientRender()
	drawPlayerTags()
	--drawPedTags()
	--drawCarTags()
end
addEventHandler("onClientRender", root, onClientRender)

enabled = true
function ativarnt()
	enabled = not enabled
	if enabled then
		addEventHandler("onClientRender", root, onClientRender)
	else
		removeEventHandler("onClientRender", root, onClientRender)
	end
end
addCommandHandler("nametag",ativarnt)
