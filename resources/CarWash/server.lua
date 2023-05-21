local prostoTakPlus = 0.01
local speedCoef = 1
local speedCoefWater = 10
local weatherCoefs = {
	{0, 0.1},
	{1, 0.1},
	{2, 0.1},
	{3, 0.1},
	{4, 0.1},
	{5, 0.1},
	{6, 0.1},
	{7, 0.5},
	{8, 1.0},
	{9, 0.5},
	{10, 0.1},
	{11, 0.1},
	{12, 0.1},
	{13, 0.1},
	{14, 0.1},
	{15, 0.1},
	{16, 1.0},
	{17, 0.1},
	{18, 0.1},
	{19, 1.0},
	{20, 0.0},
	{21, 0.0},
	{22, 0.0},
}
local setDirtGrps = { "Console", "Level 5", "Level 4" }
local setDirtCmd = "sdirt"

--==

local smokeBoxes = {}

function getVehicleSpeed(veh)
	local result = 0
	local speedx, speedy, speedz = getElementVelocity(veh)
	result = math.sqrt(speedx^2 + speedy^2 + speedz^2)
	return result
end

function onStopWash(veh)
	local moetsya = getElementData(veh, "vDannyyMomentMoetsya") or 0
	if (moetsya > 0) then
		setElementData(veh, "vDannyyMomentMoetsya", nil)
		local driver = getVehicleOccupant(veh)
		if (driver) then
			outputChatBox("#00FFFF[Car Wash] #FFFFFFShosteshoo Be Payan Resid!", driver, 0, 0, 0, true)
		end
		--
		--setVehicleEngineState(veh, true)
		--
		if (smokeBoxes[veh] and isElement(smokeBoxes[veh])) then
			destroyElement(smokeBoxes[veh])
			smokeBoxes[veh] = nil
		end
	end
end
addEvent("onStopWash", true)
addEventHandler("onStopWash", getRootElement(), onStopWash)

setTimer(
	function ()
		for _, veh in ipairs(getElementsByType("vehicle")) do
			local dirtLevel = getElementData(veh, "dirtLevel") or 0
			if (dirtLevel <= 100) then
				local carSpeed = getVehicleSpeed(veh)
				local weatherId = getWeather() + 1
				local weatherCoef = weatherCoefs[weatherId][2] or 0
				local dirtPlus = 0
				if (isElementInWater(veh)) then
					dirtPlus = ((carSpeed * speedCoefWater) + prostoTakPlus) * -1
				else--if (isVehicleOnGround(veh)) then
					dirtPlus = ((carSpeed * speedCoef) + prostoTakPlus) * weatherCoef
				end
				dirtLevel = dirtLevel + dirtPlus
				if (dirtLevel < 0) then dirtLevel = 0
				elseif (dirtLevel > 100) then dirtLevel = 100 end
				setElementData(veh, "dirtLevel", dirtLevel)
			end
			--==
			local moetsya = getElementData(veh, "vDannyyMomentMoetsya") or 0
			if (moetsya > 0) then
				--[[local engineStateMoyka = getVehicleEngineState(veh)
				if (engineStateMoyka ~= false) then
					setVehicleEngineState(veh, false)
				end]]
				--
				local dirtLevel = getElementData(veh, "dirtLevel") or 0
				dirtLevel = dirtLevel - moetsya
				if (dirtLevel < 0) then dirtLevel = 0
				elseif (dirtLevel > 100) then dirtLevel = 100 end
				setElementData(veh, "dirtLevel", dirtLevel)
				if (dirtLevel <= 0) then
					onStopWash(veh)
				end
			end
		end
	end
, 1000, 0)

addEvent("goNachatMoyku", true)
addEventHandler("goNachatMoyku", getRootElement(),
	function(player, money, lvl)
		local veh = getPedOccupiedVehicle(player)
		if (veh) then
			local dirtLevel = getElementData(veh, "dirtLevel") or 0
			if (dirtLevel >= 10) then
				local pmoney = getPlayerMoney(player)
				if (pmoney >= money) then
					takePlayerMoney(player, money)
					setElementData(veh, "vDannyyMomentMoetsya", lvl)
					outputChatBox("#00FFFF[Car Wash] #FFFFFFShostesho Shoroo Shod! Ta Payane Shostesho Lotfan Harekat Nakonid.", player, 0, 0, 0, true)
					outputChatBox("#00FFFF[Car Wash] #FFFFFFShoma #C0FF20"..money.."$ #FFFFFFPardakht Kardid.", player, 0, 0, 0, true)
					--
					--setVehicleEngineState(veh, false)
					--
					if (not smokeBoxes[veh]) then
						local x, y, z = getElementPosition(veh)
						local dim = getElementDimension(veh)
						smokeBoxes[veh] = createObject(2780, x, y, z)
						setElementDimension(smokeBoxes[veh], dim)
						setElementCollisionsEnabled(smokeBoxes[veh], false)
						setElementAlpha(smokeBoxes[veh], 0)
						attachElements(smokeBoxes[veh], veh, 0, 0, -4)
					end
				else
					outputChatBox("#00FFFF[Car Wash] #FFFFFFShoma #C0FF20"..(money - pmoney).."$ Nadarid!", player, 0, 0, 0, true)
				end
			else
				outputChatBox("#00FFFF[Car Wash] #FFFFFFVasileye Naghlieye Shoma Kasif Nemibashad!", player, 0, 0, 0, true)
			end
		else
			outputChatBox("#00FFFF[Car Wash] #FFFFFFBe Vasileye Naghlieye Khod Bazgardid.", player, 0, 0, 0, true)
		end
	end
)

function setNowDirt(player, cmd, lvl)
	local acc = getPlayerAccount(player)
	if (acc) then
		local accName = getAccountName(acc)
		local veh = getPedOccupiedVehicle(player)
		if (veh) then
			local can = false
			for _, v in ipairs(setDirtGrps) do
				local grp = aclGetGroup(v)
				if (grp) then
					if (isObjectInACLGroup("user."..accName, grp)) then
						can = true
						break
					end
				end
			end
			if (can) then
				if (lvl) then
					lvl = tonumber(lvl)
					if (lvl < 0) then lvl = 0
					elseif (lvl > 100) then lvl = 100
					end
					setElementData(veh, "dirtLevel", lvl)
					outputChatBox("Darsade Kasifi Be "..lvl.." Taghir Yaft!", player, 0, 0, 0, true)
				else
					outputChatBox("Syntax: /"..setDirtCmd.." [0-100]", player, 0, 0, 0, true)
				end
			end
		end
	end
end
addCommandHandler(setDirtCmd, setNowDirt)
