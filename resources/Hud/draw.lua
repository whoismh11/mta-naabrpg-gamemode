addEventHandler("onClientResourceStart", resourceRoot, function()
	setPlayerHudComponentVisible("all", false)
	setPlayerHudComponentVisible("crosshair", true)
end)

addEventHandler("onClientResourceStop", resourceRoot, function()
	setPlayerHudComponentVisible("all", true)
end)

local drawFont = dxCreateFont("font/draw.ttf", 8)
local drawFontCity = dxCreateFont("font/draw.ttf", 25)

local scx, scy = guiGetScreenSize()

local lastCity = ""
local cityDraw = false
local cityDrawTimer
local cityDrawAlpha = 0
local cityDrawAlphaBoolean = true
local cityDrawTime = 0
local cityDrawTimeI = getTickCount()

addEventHandler("onClientRender", root, function()
	checkNewCity()
end)

function checkNewCity()
	local city = getZoneName(getElementPosition(localPlayer))
	if city ~= lastCity then
		lastCity = city
		if cityDraw then
			killTimer(cityDrawTimer)
			cityDrawTimer = setTimer(function() removeEventHandler("onClientRender", root, drawCity) cityDraw = false cityDrawAlpha = 0 end, 5000, 1)
		else
			addEventHandler("onClientRender", root, drawCity)
			cityDrawTimer = setTimer(function() removeEventHandler("onClientRender", root, drawCity) cityDraw = false cityDrawAlpha = 0 end, 5000, 1)
			cityDraw = true
			cityDrawAlphaBoolean = true
		end
		cityDrawTimeI = getTickCount()
	end
end

function drawCity()
	if cityDrawAlpha < 255 and cityDrawAlphaBoolean then
		cityDrawAlpha = cityDrawAlpha +5
	else
		cityDrawAlphaBoolean = false
	end
	
	if cityDrawTimeI+3000 < getTickCount() then
		if cityDrawAlpha > 0 then
			cityDrawAlpha = cityDrawAlpha - 5
		end
	end
	dxDrawText(lastCity, 1, scy-100+1, scx+1, scy-100+1, tocolor(0, 0, 0, cityDrawAlpha), 1, drawFontCity, "center", "top", false, false, true)
	dxDrawText(lastCity, 0, scy-100, scx, scy-100, tocolor(255, 255, 255, cityDrawAlpha), 1, drawFontCity, "center", "top", false, false, true)
end

local lastCar = ""
local carDraw = false
local carDrawTimer
local carDrawAlpha = 0
local carDrawAlphaBoolean = true
local carDrawTime = 0
local carDrawTimeI = getTickCount()

addEventHandler("onClientRender", root, function()
	checkNewCar()
end)

function checkNewCar()
	if not (isPedInVehicle(localPlayer)) then return end
	local car = getPedOccupiedVehicle(localPlayer)
	if not car then return end
	local carname = getVehicleName(car)
	if carname ~= lastCar then
		lastCar = carname
		if carDraw then
			killTimer(carDrawTimer)
			carDrawTimer = setTimer(function() removeEventHandler("onClientRender", root, drawCar) carDraw = false carDrawAlpha = 0 end, 5000, 1)
		else
			addEventHandler("onClientRender", root, drawCar)
			carDrawTimer = setTimer(function() removeEventHandler("onClientRender", root, drawCar) carDraw = false carDrawAlpha = 0 end, 5000, 1)
			carDraw = true
			carDrawAlphaBoolean = true
		end
		carDrawTimeI = getTickCount()
	end
end

function drawCar()
	if carDrawAlpha < 255 and carDrawAlphaBoolean then
		carDrawAlpha = carDrawAlpha +5
	else
		carDrawAlphaBoolean = false
	end
	
	if carDrawTimeI+3000 < getTickCount() then
		if carDrawAlpha > 0 then
			carDrawAlpha = carDrawAlpha - 5
		end
	end
	dxDrawText(lastCar, 1, scy-140+1, scx+1, scy-140+1, tocolor(0, 0, 0, carDrawAlpha), 1, drawFontCity, "center", "top", false, false, true)
	dxDrawText(lastCar, 0, scy-140, scx, scy-140, tocolor(65, 200, 130, carDrawAlpha), 1, drawFontCity, "center", "top", false, false, true)
end
