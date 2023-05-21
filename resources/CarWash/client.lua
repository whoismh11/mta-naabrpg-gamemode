local dalnostVidimosti = 150
local zapylyayushiesyaDetali = {
	"vehiclegrunge256",
	"vehiclegeneric256",
	"vehicletyres128",
	"vehicledash32",
	"vehiclelights128",
}
local moykaBlipId = 12
local moykaMarkerSize = 3
local moykaMarkers = {
	{1911.2724609375, -1776.3037109375, 13.3828125, 50, 250},
	{2163.0654296875, 2472.8994140625, 10.8203125, 50, 250},
	{2147.728515625, 2713.7431640625, 10.8203125, 50, 250},
	{2454.3271484375, -1461.1748046875, 24, 50, 250},
}
local uslugi = { 3, 6 }

--

local sw, sh = guiGetScreenSize()
local lp = getLocalPlayer()

local dirtTxd = dxCreateTexture("txd/dirt.png")
local dirtShaders = {}

for i, v in ipairs(moykaMarkers) do
	createMarker(v[1], v[2], v[3] - 1, "cylinder", moykaMarkerSize - 0.8, 255, 255, 255, 35)
	createMarker(v[1], v[2], v[3] - 1, "cylinder", moykaMarkerSize - 0.4, 255, 255, 255, 35)
	local marker = createMarker(v[1], v[2], v[3] - 1, "cylinder", moykaMarkerSize, 255, 255, 255, 35)
	setElementData(marker, "markerAvtoMoyka", 1)
	setElementData(marker, "markerAvtoMoykaCeny", { v[4], v[5] })
	local blip = createBlip(v[1], v[2], v[3], moykaBlipId, 2, 255, 255, 255, 255, 0, 350)
end

function createWindow(x, y, w, h, title)
	if (x == "c") then x = (sw - w) / 2 end
	if (y == "c") then y = (sh - h) / 2 end
	local wnd = guiCreateWindow(x, y, w, h, title, false)
	if (wnd) then
		guiSetVisible(wnd, false)
		guiWindowSetSizable(wnd, false)
		guiWindowSetMovable(wnd, false)
	end
	return wnd
end

local wndMain = createWindow("c", "c", 500, 430, "Car Wash")
parent = wndMain
guiCreateStaticImage(20, 30, 460, 230, "1.png", false, parent)
local btnBuy1 = guiCreateButton(20, 270, 460, 40, "", false, parent)
local btnBuy2 = guiCreateButton(20, 320, 460, 40, "", false, parent)
local btnClose = guiCreateButton(20, 370, 460, 40, "Bastan", false, parent)

function onClientGUIClick()
	local cena = getElementData(source, "btnCena") or 0
	if (source == btnBuy1) then
		guiSetVisible(wndMain, false)
		showCursor(false)
		triggerServerEvent("goNachatMoyku", lp, lp, cena, uslugi[1])
	elseif (source == btnBuy2) then
		guiSetVisible(wndMain, false)
		showCursor(false)
		triggerServerEvent("goNachatMoyku", lp, lp, cena, uslugi[2])
	elseif (source == btnClose) then
		guiSetVisible(wndMain, false)
		showCursor(false)
	end
end
addEventHandler("onClientGUIClick", getRootElement(), onClientGUIClick)

function onClientMarkerHit(player, md)
	if (player == lp and md) then
		local veh = getPedOccupiedVehicle(player)
		if (veh) then
			local markerType = getElementData(source, "markerAvtoMoyka") or 0
			if (markerType == 1) then
				local c = getElementData(source, "markerAvtoMoykaCeny")
				if (c) then
					local cena1 = c[1] or 0
					local cena2 = c[2] or 0
					guiSetVisible(wndMain, true)
					showCursor(true)
					--setElementData(veh, "vDannyyMomentMoetsya", nil)
					triggerServerEvent("onStopWash", player, veh)
					guiSetText(btnBuy1, "Car Wash (Aab) - "..cena1.."$.\nSorate Tamiz Kardan "..uslugi[1].."%.")
					setElementData(btnBuy1, "btnCena", cena1)
					guiSetText(btnBuy2, "Car Wash (Aab Va Kaf) - "..cena2.."$.\nSorate Tamiz Kardan "..uslugi[2].."%.")
					setElementData(btnBuy2, "btnCena", cena2)
				end
			end
		end
	end
end
addEventHandler("onClientMarkerHit", getRootElement(), onClientMarkerHit)

function onClientMarkerLeave(player, md)
	if (player == lp and md) then
		local veh = getPedOccupiedVehicle(player)
		if (veh) then
			local markerType = getElementData(source, "markerAvtoMoyka") or 0
			if (markerType > 0) then
				guiSetVisible(wndMain, false)
				showCursor(false)
				--setElementData(veh, "vDannyyMomentMoetsya", nil)
				triggerServerEvent("onStopWash", player, veh)
			end
		end
	end
end
addEventHandler("onClientMarkerLeave", getRootElement(), onClientMarkerLeave)

function onClientRender()
	
	local veh = getPedOccupiedVehicle(lp)
	if (veh) then
		local dirtLevel = getElementData(veh, "dirtLevel") or 0
		if (dirtLevel) then
			local text = "Darsade Kasifi: "..math.floor(dirtLevel).."%"
			dxDrawText(text, 1365 - 1, 0 - 1, 0 - 1, sh - 20 - 1, tocolor(0, 0, 0), 1, "default-bold", "center", "bottom")
			dxDrawText(text, 1365, 0, 0, sh - 20, tocolor(255, 255, 255), 1, "default-bold", "center", "bottom")
			dxDrawImage(582 - 2, sh - 15 - 2, 204, 9, "b.png", 0, 0, 0, tocolor(0, 0, 0, 170))
			dxDrawImage(582, sh - 15, (dirtLevel * 2), 5, "b.png", 0, 0, 0, tocolor((dirtLevel * 1.28), (255 - (dirtLevel * 2.55)), 0))
		end
	end
	
	--
	local x, y, z = getElementPosition(lp)
	for _, obj in ipairs(getElementsByType("marker")) do
		local markerType = getElementData(obj, "markerAvtoMoyka") or 0
		if (markerType > 0) then
			local x2, y2, z2 = getElementPosition(obj)
			local dist = getDistanceBetweenPoints3D(x2, y2, z2, x, y, z)
			if (dist >= 3 and dist <= 35) then
				local h = { getScreenFromWorldPosition(x2, y2, z2) }
				if (h[1] and h[2]) then
					local text = "Car Wash\n"..math.floor(dist).." m."
					dxDrawImage(h[1] - 26, h[2] - 64 - 30, 50, 63, "m.png", 0, 0, 0, tocolor(0, 0, 0))
					dxDrawImage(h[1] - 25, h[2] - 63 - 30, 50, 63, "m.png", 0, 0, 0, tocolor(255, 255, 255))
					dxDrawText(text, h[1] - 1, h[2] - 1, h[1] - 1, h[2] - 1, tocolor(0, 0, 0), 1, "default-bold", "center", "bottom")
					dxDrawText(text, h[1], h[2], h[1], h[2], tocolor(255, 255, 255), 1, "default-bold", "center", "bottom")
				end
			end
		end
	end
end
addEventHandler("onClientRender", getRootElement(), onClientRender)

setTimer(
	function ()
		for _, veh in ipairs(getElementsByType("vehicle")) do
			local dirtLevel = getElementData(veh, "dirtLevel")
			if (dirtLevel and tonumber(dirtLevel)) then
				if (not dirtShaders[veh]) then
					dirtShaders[veh] = dxCreateShader("shader.fx", 0, dalnostVidimosti, true, "vehicle")
					dxSetShaderValue(dirtShaders[veh], "gTexture", dirtTxd)
					for _, name in ipairs(zapylyayushiesyaDetali) do
						engineRemoveShaderFromWorldTexture(dirtShaders[veh], name, veh)
						engineApplyShaderToWorldTexture(dirtShaders[veh], name, veh)
					end
					for _, name in ipairs(engineGetModelTextureNames(getElementModel(veh))) do
						engineRemoveShaderFromWorldTexture(dirtShaders[veh], name, veh)
						engineApplyShaderToWorldTexture(dirtShaders[veh], name, veh)
					end
				end
				local alphaLevel = dirtLevel / 120
				dxSetShaderValue(dirtShaders[veh], "gAlpha", alphaLevel)
			end
		end
	end
, 1000, 0)
