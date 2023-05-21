local g_Me = getLocalPlayer()
local DrawCount = false
local fontScale = 2
local OUTLINE = 4
local MaxDistance = 64
local SoundDistance = 50
local Seconds = 0
local soundID = 6
local Sound = { ["player"] = playSFX3D("genrl", 52, 0, 0, 0, 0, false) }

setElementData(g_Me, "CountDown.Progress", false)
setElementData(g_Me, "CountDown", false)
setElementData(g_Me, "CountDown.Sound", false)

function CountDownProgress()
	Seconds = Seconds+1	
	if (Seconds <= 1) then
		setElementData(g_Me, "CountDown.Progress", "2") --Here you change the string "2".
	elseif (Seconds <= 2) then
		setElementData(g_Me, "CountDown.Progress", "1") --Here you change the string "1".
	elseif (Seconds <= 3) then
		setElementData(g_Me, "CountDown.Progress", "GO!") --Here you change the string "GO!".
	elseif (Seconds <= 4) then
		setElementData(g_Me, "CountDown.Progress", false)
		setElementData(g_Me, "CountDown", false)
		DrawCount = false
		Seconds = 0
	end
end

function playCountdownSound(data, oldValue, newValue) 
	for value, player in ipairs(getElementsByType("player")) do
		if (data == "CountDown.Progress") then
			if not (newValue == false) then
				if getElementData(player, "CountDown") then
					if (newValue == "GO!") then
						soundID = 12
					else
						soundID = 6
					end
					if (player == source) then -- If you remove this, countdowns near you will sound on your position(instead of the owner position).
						local bX, bY, bZ = getPedBonePosition(player, 8)
						Sound[player] = playSFX3D("genrl", 52, soundID, bX, bY, bZ, false)
						setSoundMaxDistance(Sound[player], SoundDistance)
						setSoundVolume(Sound[player], 0.7)
					end
				end
			end
		end
	end
end
addEventHandler("onClientElementDataChange", root, playCountdownSound)

function DrawCountDown()
    local mX, mY, mZ = getCameraMatrix()
	local x, y, z = getElementPosition(g_Me)
	for theKey, player in ipairs(getElementsByType("player")) do
        local pX, pY, pZ = getElementPosition(player)
		local Distance = math.sqrt((mX - pX) ^ 2 + (mY - pY) ^ 2 + (mZ - pZ) ^ 2)
		if Distance <= MaxDistance and isLineOfSightClear(x, y, z, pX, pY, pZ, true, false, false, true) then
			if getElementData(player, "CountDown") then
			    local bX, bY, bZ = getPedBonePosition(player, 8)
			    local sW, sY = getScreenFromWorldPosition(bX, bY, bZ+0.4)
			    if sW then
                    local CountProgress = getElementData(player, "CountDown.Progress")
					if CountProgress then
						local Scale = (Distance/MaxDistance)
						dxDrawBorderedText((OUTLINE-Scale*4), CountProgress, 0, 0, sW*2, sY*2, tocolor (230, 230, 230, 255), (fontScale-Scale*2), "bankgothic", "center", "center", true, false)
					end
				end
			end
		end
    end
end
addEventHandler("onClientRender", root, DrawCountDown)

function StartCountdown()
    if DrawCount then
	    outputChatBox("Lotfan Montazer Bemanid CountDown Tamam Shavad.", 255, 0, 0)
	else
		setElementData(g_Me, "CountDown", true)
		setElementData(g_Me, "CountDown.Progress", "3") --Here you change the string "3".
		setTimer(CountDownProgress, 1000, 4)
		DrawCount = true
	end
end
addCommandHandler("cd", StartCountdown)
addCommandHandler("countdown", StartCountdown)
addCommandHandler("count", StartCountdown)
