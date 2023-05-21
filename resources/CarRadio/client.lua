local positions = {} 

local radius = 180

local step = (360 / #playlist)

local visible = false
local blurBox = false

local width, height = guiGetScreenSize()

sW = (width / 2)
sH = (height / 2)

local function GeneratePositions(posX,posY,radius,width,angleAmount,startAngle,stopAngle,color,postGUI)
	if (type( posX ) ~= "number") or (type( posY ) ~= "number") then
		return false
	end
	local function clamp( val, lower, upper )
		if ( lower > upper ) then lower, upper = upper, lower end
		return math.max( lower, math.min( upper, val ) )
	end
	radius = type( radius ) == "number" and radius or 50
	width = type( width ) == "number" and width or 5
	angleAmount = type( angleAmount ) == "number" and angleAmount or 1
	startAngle = clamp( type( startAngle ) == "number" and startAngle or 0, 0, 360 )
	stopAngle = clamp( type( stopAngle ) == "number" and stopAngle or 360, 0, 360 )
	color = color or tocolor( 255, 255, 255, 200 )
	postGUI = type( postGUI ) == "boolean" and postGUI or false
	if ( stopAngle < startAngle ) then
		local tempAngle = stopAngle
		stopAngle = startAngle
		startAngle = tempAngle
	end
	local count = 0;
	for i = startAngle, stopAngle, angleAmount do
		local startX = math.cos( math.rad( i ) ) * ( radius - width )
		local startY = math.sin( math.rad( i ) ) * ( radius - width )
		local endX = math.cos( math.rad( i ) ) * ( radius + width )
		local endY = math.sin( math.rad( i ) ) * ( radius + width )
		count = count + 1
		if count >= step then
			table.insert(positions, { startX + posX, startY + posY } )
			count = 0
		end
	end
	return true
end

local function isCursorOnElement(posX,posY,width,height)
	if isCursorShowing() then
		local mouseX, mouseY = getCursorPosition()
		local clientW, clientH = guiGetScreenSize()
		local mouseX, mouseY = mouseX * clientW, mouseY * clientH
		if (mouseX > posX and mouseX < (posX + width) and mouseY > posY and mouseY < (posY + height)) then
			return true
		end
	end
	return false
end

local function setupBlurBox()
	if blurBox then
		exports.blur_box:destroyBlurBox(blurBox)
		blurBox = nil
		return true
	end
	blurBox = exports.blur_box:createBlurBox(0, 0, width, height, 100, 100, 100, 100, false)
	exports.blur_box:setScreenResolutionMultiplier(0.4, 0.4)
	exports.blur_box:setBlurIntensity(4)
end

local function draw()
	if visible then
		local veh = getPedOccupiedVehicle(localPlayer)
		if veh then
			for i, data in ipairs(positions) do
				local isPosition = isCursorOnElement(data[1] - 30,data[2] - 30,60,60)
				dxDrawImage(data[1] - 30,data[2] - 30,60,60,playlist[i][1],0,0,0,tocolor(255,255,255,isPosition and 100 or 255),false)
			end
			dxDrawImage(0, 0, width, height, "Assets/bg.png", 0, 0, 0, tocolor(255,255,255,120), false)
			dxDrawImage(positions[3][1] - 30,positions[3][2] - 120,60,60,"Assets/off.png",0,0,0,tocolor(255,255,255,isCursorOnElement(positions[3][1] - 30,positions[3][2] - 120,60,60) and 100 or 255),false)
			dxDrawText("VOLUME", sW, sH, width / 2, height / 3,tocolor(255,255,255,255),1.15,"bankgothic","center","center",false,false,true,false,false)
			local meta = ""
			local sound = getElementData(veh,"music:attach")
			if (sound) then
				if isElement(sound) then
					local id = getElementData(veh,"music:id") or 0
					if id then
						dxDrawText(playlist[id][3],sW,-180,width / 2,height / 2,tocolor(255,255,255,255),1.65,"default-bold","center","center",false,false,true,false,false)
					end
					meta = getSoundMetaTags(sound)
					if meta.stream_title then
						dxDrawText("Dar Hale Pakhsh: "..meta.stream_title,sW,-130,width / 2,height / 2,tocolor(255,255,255,255),1,"default-bold","center","center",false,false,true,false,false)
					end
				end
			end
			local k = ""
			for i = 1, volume do	
				k = k .. "+"
			end
			local s = ""
			local lenght = string.len(k)
			if lenght < 10 then
				for i = 1, (10 - lenght) do
					s = s .. "−"
				end
			end
			k = "#00cc00" .. k
			s = "#ff0000" .. s
			dxDrawText("\n\n["..k..""..s.."#ffffff]",sW,sH,width / 2,height / 3,tocolor(255,255,255,255),2,"default","center","center",false,false,true,true,false)
			dxDrawText("Baraye Taghire Volume, Az '[' Va ']' Estefade Konid.",sW,sH,width / 2,height / 2,tocolor(255,255,255,255),1,"default","center","center",false,false,true,true,false)
		else
			visible = false
		end
	end
end

addEventHandler("onClientResourceStart",resourceRoot,
function()
	setRadioChannel(0)
	
	addEventHandler("onClientPlayerRadioSwitch",root, 
	function() 
		cancelEvent() 
	end) 

	local vehicles = getElementsByType("vehicle",root,true)
	
	for i, vehicle in ipairs(vehicles) do
		VehicleRadio(vehicle)
	end
	
	GeneratePositions(sW,sH,radius,nil,nil,nil,360)
	
	addEventHandler("onClientRender",root,draw)
	
	bindKey(key,"down",
	function()
		local veh = getPedOccupiedVehicle(localPlayer)
		if veh then
			visible = not visible
			showCursor(visible)
			setupBlurBox()
		end
	end)
	
	function changeVolume(key)
		local veh = getPedOccupiedVehicle(localPlayer)
		if veh then
			local music = getElementData(veh,"music:attach")
			if isElement(music) then
				volume = getSoundVolume(music) * 10
				if key == down then
					volume = volume - 1
					if volume < 0 then
						volume = 0
					end
				elseif key == up then
					volume = volume + 1
					if volume > 10 then
						volume = 10
					end
				end
				setSoundVolume(music,volume * 1 / 10)
			end
		end
	end
	bindKey(down,"down",changeVolume)
	bindKey(up,"down",changeVolume)
	
	addEventHandler("onClientClick",root,
	function(button,state)
		if (button == "left" and state) then
			local veh = getPedOccupiedVehicle(localPlayer)
			if veh and visible then
				if isCursorOnElement(positions[3][1] - 30,positions[3][2] - 120,60,60) then
					local music = getElementData(veh,"music:attach")
					if isElement(music) then
						destroyElement(music)
					end
					return true
				end
				for i, data in ipairs(positions) do
					local isPosition = isCursorOnElement(data[1] - 30,data[2] - 30,60,60)
					if isPosition then
						setElementData(veh,"music:id",i)
						break
					end
				end
			end
		end
	end)
end)
