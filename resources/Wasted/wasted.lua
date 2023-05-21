local TIME_TO_WAIT = 5000 --The milliseconds to wait before spectating the person
                          --who killed us, the cunt

local KILLER_TEXT_COLOR = tocolor(255, 255, 255, 200)

local KILL_TEXT_X = 0.5 --Where the text starts to the left of the screen
local KILL_TEXT_Y = 0.535 --How far down the screen comes before we have text
local KILL_TEXT_COLOR = tocolor(255, 255, 255, 200) --The color of the text
local KILL_TEXT_SIZE = 1.5 --The size of our text
local KILL_TEXT_FONT = "font/ARLRDBD.ttf" --The font face of our text
local KILL_TEXT_ALIGN_X = "center" --The font alignment on the x axis
local KILL_TEXT_ALIGN_Y = "center" --The font alignment on the y axis
local KILL_TEXT_CLIP = false --Clip text outside of box
local KILL_TEXT_WRAP = false --Wrap text if it reaches end of box
local KILL_TEXT_ONTOP = true --Render on top of the gui

local WASTED_TEXT_X = 0.5 --Where the text starts to the left of the screen
local WASTED_TEXT_Y = 0.48 --How far down the screen comes before we have text
local WASTED_TEXT_COLOR = tocolor(255, 0, 0, 200) --The color of the text
local WASTED_TEXT_SIZE = 4 --The size of our text
local WASTED_TEXT_FONT = "pricedown" --The font face of our text
local WASTED_TEXT_ALIGN_X = "center" --The font alignment on the x axis
local WASTED_TEXT_ALIGN_Y = "center" --The font alignment on the y axis
local WASTED_TEXT_CLIP = false --Clip text outside of box
local WASTED_TEXT_WRAP = false --Wrap text if it reaches end of box
local WASTED_TEXT_ONTOP = true --Render on top of the gui

function playerDied(killer, weapon, bodypart)
	if getElementData(getLocalPlayer(), "inpaintball") ~= true then

		wastedSound()

		local playerX, playerY, playerZ = getElementPosition(source)

		displayKillText(getKillString(source, killer, weapon, bodypart))

		local spectate
		if killer then 
			if killer ~= getLocalPlayer() then

			local killerX, killerY, killerZ = getElementPosition(killer)
        
			spectate = killer
			end
		else 

		end 
	end
end 
addEventHandler("onClientPlayerWasted", getLocalPlayer(), playerDied)

function getKillString(player, killer, weapon, bodypart)
    local killText = ""

    if player then
        killText = killText .. ""
    end --if

    if killer then
        killText = getPlayerName(killer) .. " Shoma Ra Kosht!"
    else
        killText = killText .. " Shoma Khod Koshi Kardid!"
    end 

    if weapon then
        local weapName = getWeaponNameFromID(weapon)
        if weapname ~= false then
        end 
    end 

    return killText
end 

local killText = ""

function displayKillText(text)
    killText = text

    addEventHandler("onClientRender", getRootElement(), drawKillText)

    setTimer(stopDisplayDrawKillText, TIME_TO_WAIT, 1)
end 
function stopDisplayDrawKillText()
    removeEventHandler("onClientRender", getRootElement(), drawKillText)
end 

function drawKillText()
    local sX, sY = guiGetScreenSize()
    local left, top

    left = KILL_TEXT_X * sX
    top = KILL_TEXT_Y * sY
    dxDrawText(killText, left, top, left, top, KILL_TEXT_COLOR,
        KILL_TEXT_SIZE, KILL_TEXT_FONT, KILL_TEXT_ALIGN_X,
        KILL_TEXT_ALIGN_Y, KILL_TEXT_CLIP, KILL_TEXT_WRAP,
        KILL_TEXT_ONTOP)

    left = WASTED_TEXT_X * sX
    top = WASTED_TEXT_Y * sY
    dxDrawText("wasted", left, top, left, top, WASTED_TEXT_COLOR,
        WASTED_TEXT_SIZE, WASTED_TEXT_FONT, WASTED_TEXT_ALIGN_X,
        WASTED_TEXT_ALIGN_Y, WASTED_TEXT_CLIP, WASTED_TEXT_WRAP,
        WASTED_TEXT_ONTOP)
end 

function wastedSound()
    if true then
        local wasted = playSound("wasted.mp3");

        setSoundVolume(sound, 0.1);
    end
end

-- OLD Film
local screenWidth, screenHeight = guiGetScreenSize()
local myScreenSource = dxCreateScreenSource(screenWidth, screenHeight)
local showHud = "false"
local flickerStrength = 0

addEventHandler("onClientPlayerWasted", getLocalPlayer(),
function()
if getElementData(getLocalPlayer(), "inpaintball") ~= true then
    if getVersion ().sortable < "1.1.0" then
        
        return
    else
        createShader()
    end
end
end)

function createShader()
    oldFilmShader, oldFilmTec = dxCreateShader("shaders/old_film.fx")
	setTimer(function() destroyElement(oldFilmShader) end, 5000, 1)
 
    if (not oldFilmShader) then

    else

    end
end

function updateShader()
    if (showHud == "true") then
        setPlayerHudComponentVisible("all", false) 
    end
    
    upDateScreenSource()

    if (oldFilmShader) then
        local flickering = math.random(100 - flickerStrength, 100)/100
        dxSetShaderValue(oldFilmShader, "ScreenSource", myScreenSource);
        dxSetShaderValue(oldFilmShader, "Flickering", flickering);
        dxDrawImage(0, 0, screenWidth, screenHeight, oldFilmShader)
    end
end
addEventHandler("onClientPreRender", root, updateShader)

function upDateScreenSource()
    dxUpdateScreenSource(myScreenSource)
end

-- Tarja
function showClientImage()
	if getElementData(getLocalPlayer(), "inpaintball") ~= true then
		local img = guiCreateStaticImage( 0, 0, 1921, 221, "starja.png", true )
		setTimer(function() destroyElement(img) end, 5000, 1)
		local img = guiCreateStaticImage( 0, 0, 1920, 1080, "images/vignette1.dds", true )
		setTimer(function() destroyElement(img) end, 5000, 1)
	end
end
addEventHandler ( "onClientPlayerWasted", getLocalPlayer(), showClientImage)
