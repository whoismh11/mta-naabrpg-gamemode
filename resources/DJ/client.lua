screenX,screenY=guiGetScreenSize()
panelacik = false
function alphaFunction()
	if alphaState == true then
		alpha = alpha + 15
		alpharec = alpharec + 8
		alphar = alphar + 3
	if alpha >= 255 then
		alpha = 255
	end
	if alpharec >= 150 then
		alpharec = 150
	end
    if alphar >= 50 then
		alphar = 50
	end
	end
	if alphaState == false then
		alpha = alpha - 15
		alpharec = alpharec - 8
		alphar = alphar - 3
	if alpha <= 0 then
		alpha = 0
		end
	if alpharec <= 0 then
		alpharec = 0
		end
	if alphar <= 0 then
		alphar = 0
		end
	end
end

konum = "left"
addEventHandler("onClientRender", getRootElement(), alphaFunction)

function loadRadioStreamList()
	local streams = xmlLoadFile("urler.xml")
	if not streams then
		streams = xmlCreateFile("urler.xml","streams")
		xmlSaveFile(streams)
	end
	local streamNodes = xmlNodeGetChildren(streams)
	for i,v in ipairs(streamNodes) do
		local row = guiGridListAddRow(GUIEditor.gridlist[1])
		guiGridListSetItemText(GUIEditor.gridlist[1],row,column2,xmlNodeGetAttribute(v, "URL"),false,false)
		guiGridListSetItemText(GUIEditor.gridlist[1],row,column1,xmlNodeGetAttribute(v, "name"),false,false)
	end
	xmlUnloadFile(streams)
end

function updateStreamAndSoundList()
	local streams = xmlCreateFile("urler.xml","streams")
	xmlSaveFile(streams)
	local totalStreams = guiGridListGetRowCount(GUIEditor.gridlist[1])
	for i=0,totalStreams-1 do
		xmlNodeSetValue(xmlCreateChild(streams,"url"),guiGridListGetItemText(GUIEditor.gridlist[1],i,column2))
		local node = xmlCreateChild(streams,"stream")
		xmlNodeSetAttribute(node, "name", guiGridListGetItemText(GUIEditor.gridlist[1],i,column1))
		xmlNodeSetAttribute(node, "URL", guiGridListGetItemText(GUIEditor.gridlist[1],i,column2))
	end
	xmlSaveFile(streams)
	xmlUnloadFile(streams)
end


function startMusic(thePlayer)
thePlayer = thePlayer
setElementData(getLocalPlayer(), "radio", "Closed")
setElementData(resourceRoot, "radio.title", "-")
removeEventHandler ( "onClientRender", root, info )
removeEventHandler("onClientRender", getRootElement(), logo)
if getElementData(resourceRoot, "radio.url") ~= "nil" then
	if radio then
	stopSound(radio)
	end
	radio = playSound(getElementData(resourceRoot, "radio.url"),true)
	addEventHandler("onClientSoundChangedMeta", radio, onClientSoundChangedMeta) 
	addEventHandler ( "onClientRender", root, info )
	addEventHandler("onClientRender", getRootElement(), logo)
	if radio ~= false then
		setElementData(getLocalPlayer(), "radio", "Open")
		if not isTimer(Timer) then
		function delayedChat ( text )
	--outputChatBox ( "Delayed text: " .. text )
        end
		--Timer = setTimer(outputChatBox, 1000, 1, "#00bfffOnline-DJ#00ff00 İstek Şarkıları Söyleyebilirsiniz. #ffffff/istek", 102,255,0, true)
		end
	else
	outputChatBox("Shoma URL Eshtebah Vared Kardid.", 255,0,0)
	end
else 
if radio then
stopSound(radio)
end
end
end

function onClientSoundChangedMeta(streamTitle) 
    local tTags = getSoundMetaTags(source) 
    if (tTags) then 
			alphaState = false
        setTimer ( function()
        alphaState = true
        for tag,value in pairs(tTags) do 
            textis = string.gsub(string.format("%s", value), "f/", "ft. ")
        end 
		end, 700, 1)
    end 
end 

addEvent("onClientRadioChanged", true)
addEventHandler("onClientRadioChanged", root, startMusic)

function makeRadioStayOff()
    cancelEvent()
end

addEventHandler("onClientResourceStart",getResourceRootElement(getThisResource()),startMusic)
addEventHandler("onClientPlayerRadioSwitch",getRootElement(),makeRadioStayOff)
addEventHandler("onClientPlayerVehicleEnter",getRootElement(),makeRadioStayOff)

local sounds = {}
local soundsDisabled = true

addEventHandler('onClientResourceStart', getRootElement(), 
function(resource)
	if string.sub(getResourceName(resource),1,5) == "race-" then
		sounds = {}
		setTimer(checkForMusic, 50,1,source)
	end
end	
)	

function checkForMusic (resRoot)
	sounds = getElementsByType('sound', resRoot)
	if soundsDisabled then
		disableSounds()
	end
end

addCommandHandler('dj', function()
if not soundsDisabled then
	soundsDisabled = true
	disableSounds()
		setRadioChannel(0)
		addEventHandler("onClientPlayerRadioSwitch",getRootElement(),makeRadioStayOff)
		addEventHandler ( "onClientRender", root, info )
		addEventHandler("onClientRender", getRootElement(), logo)
		startMusic()
else
	soundsDisabled = false
	enableSounds()
		stopSound(radio) 
		setElementData(getLocalPlayer(), "radio", "Closed", true)
		setElementData(resourceRoot, "radio.title", "Shoma DJ Ra Mute Kardid! Az '/dj' Baraye UnMute Kardane Mojadad Estefade Konid.")
		removeEventHandler("onClientPlayerRadioSwitch",getRootElement(),makeRadioStayOff)
		removeEventHandler ( "onClientRender", root, info )
			 textis = "DJ #00ff00Active"
		removeEventHandler("onClientRender", getRootElement(), logo)
end
end)

function disableSounds()
	for k,v in ipairs(sounds) do
		setSoundVolume(v, 0)
	end
end

function enableSounds()
	for k,v in ipairs(sounds) do
		setSoundVolume(v, 1)
	end
end

function centerWindow (center_window)
    local screenW, screenH = guiGetScreenSize()
    local windowW, windowH = guiGetSize(center_window, false)
    local x, y = (screenW - windowW) /2,(screenH - windowH) /2
    return guiSetPosition(center_window, x, y, false)
end

function load_gui()
GUIEditor = {
    gridlist = {},
    button = {},
    edit = {},
    label = {}
}

        RadioConfigMainWindow = guiCreateStaticImage(344, 308, 593, 385, "panel.png", false)
        guiWindowSetSizable(RadioConfigMainWindow, false)
        guiSetAlpha(RadioConfigMainWindow, 1.00)
		centerWindow( RadioConfigMainWindow )
	
		guiCreateLabel(225, 1, 125, 24, "DJ Panel", false, RadioConfigMainWindow)
        GUIEditor.edit[1] = guiCreateEdit(10, 45, 289, 25, "Linke Ahang", false, RadioConfigMainWindow)
		GUIEditor.edit[3] = guiCreateEdit(10, 80, 289, 25, "Esme Ahang", false, RadioConfigMainWindow)
        GUIEditor.button[1] = guiCreateButton(106, 265, 96, 24, "Ezafe Kardan", false, RadioConfigMainWindow)
        GUIEditor.button[2] = guiCreateButton(380, 352, 132, 23, "Hazf Kardan", false, RadioConfigMainWindow)
        GUIEditor.button[3] = guiCreateButton(10, 110, 71, 24, "Pakhsh", false, RadioConfigMainWindow)
		GUIEditor.button[4] = guiCreateButton(520, 0, 71, 24, "X", false, RadioConfigMainWindow)
		GUIEditor.button[5] = guiCreateButton(226, 110, 71, 24, "Tavaghof", false, RadioConfigMainWindow)
        GUIEditor.gridlist[1] = guiCreateGridList(309, 45, 274, 297, false, RadioConfigMainWindow)
        GUIEditor.edit[2] = guiCreateEdit(10, 225, 289, 25, "", false, RadioConfigMainWindow)
		column1 = guiGridListAddColumn(GUIEditor.gridlist[1], "name", 0.9)
		column2 = guiGridListAddColumn(GUIEditor.gridlist[1], "URL", 1)
		guiSetVisible(RadioConfigMainWindow, false)
		loadRadioStreamList()

		addEventHandler ( "onClientGUIClick", GUIEditor.button[4], function ()
		showCursor(not guiGetVisible(RadioConfigMainWindow))
		guiSetVisible(RadioConfigMainWindow, not guiGetVisible(RadioConfigMainWindow))
		end
		, false)

		addEventHandler ( "onClientGUIClick", GUIEditor.button[3], function ()
		radioURL = guiGetText(GUIEditor.edit[1])
		url_len = string.len(radioURL)
			if url_len <= 12 then
			outputChatBox("#ff0000Lotfan Tamame Ghesmat Haro Por Konid!", 255, 0, 0, true)
			elseif guiGetText(GUIEditor.edit[3]) ~= "" and guiGetText(GUIEditor.edit[3]) ~= " " and guiGetText(GUIEditor.edit[3]) ~= "Esme Ahang" then
			setElementData(resourceRoot, "radio.url", radioURL, true)
			triggerServerEvent("onRadioChanged", root, radioURL)			
            else
            outputChatBox("#FF0000Lotfan Tamame Ghesmat Haro Por Konid!", 255, 0, 0, true)			
			end			
		   end
		  , false)
		  
		  function Enviar()
	mensj = guiGetText(GUIEditor.edit[3])
	triggerServerEvent("ServerMSG",getRootElement(),mensj)
    end
    addEventHandler("onClientGUIClick", GUIEditor.button[3], Enviar, false)
	
	function greetingHandler ( message )
				alphaState = false
        setTimer ( function()
        alphaState = true
    textis = message
	dj = "#00ffffOnline-DJ" 
		end, 700, 1)

end
addEvent( "MSG", true )
addEventHandler( "MSG", localPlayer, greetingHandler )

		addEventHandler ( "onClientGUIClick", GUIEditor.button[5], function ()
		thePlayer = getLocalPlayer()
		setElementData(resourceRoot, "radio.title", "DJ Ahang Ra Motevaghef Kard.")
		setElementData(resourceRoot, "radio.url", "nil")
		triggerServerEvent("onRadioChanged", root, thePlayer)
		removeEventHandler ( "onClientRender", root, info )
		removeEventHandler("onClientRender", getRootElement(), logo)
		end
		, false)
		
		addEventHandler ( "onClientGUIClick", GUIEditor.button[1], function ()
		if guiGetText(GUIEditor.edit[1]) ~= "" then
		radioURL = guiGetText(GUIEditor.edit[1])
		radioName = guiGetText(GUIEditor.edit[2])
		row = guiGridListAddRow(GUIEditor.gridlist[1])
		guiGridListSetItemText (GUIEditor.gridlist[1], row, column1, radioName, false, false)
		guiGridListSetItemText (GUIEditor.gridlist[1], row, column2, radioURL, false, false)
		guiSetText( GUIEditor.edit[1],"")
		guiSetText( GUIEditor.edit[2],"")
		updateStreamAndSoundList()
		end
		end
		, false)
		
		addEventHandler("onClientGUIClick", resourceRoot, function()
	    if guiGetText(GUIEditor.edit[1]) == "Linke Ahang" then
		if source == GUIEditor.edit[1] then
		guiSetText(GUIEditor.edit[1], "")
	    end
		end
        end)
		
		addEventHandler("onClientGUIClick", resourceRoot, function()
	    if guiGetText(GUIEditor.edit[3]) == "Esme Ahang" then
		if source == GUIEditor.edit[3] then
		guiSetText(GUIEditor.edit[3], "")
	    end
		end
        end)
		
		addEventHandler ( "onClientGUIClick", GUIEditor.button[2], function ()
		if guiGridListGetSelectedItem(GUIEditor.gridlist[1]) ~= -1 then
			local row, column = guiGridListGetSelectedItem(GUIEditor.gridlist[1])
			guiGridListRemoveRow(GUIEditor.gridlist[1],row)
			updateStreamAndSoundList()
		end
		end
		, false)
		
		--Play stream
		addEventHandler("onClientGUIDoubleClick",GUIEditor.gridlist[1],
		function (thePlayer)
		if guiGridListGetSelectedItem(GUIEditor.gridlist[1]) ~= -1 then
			local row, column = guiGridListGetSelectedItem(GUIEditor.gridlist[1])
			radioURL = guiGridListGetItemText(GUIEditor.gridlist[1],row,column2)
			thePlayer = getLocalPlayer()
			setElementData(resourceRoot, "radio.url", radioURL, true)
			triggerServerEvent("onRadioChanged", root, thePlayer)
			playerName = getPlayerName(thePlayer)
			triggerServerEvent("onPlayerSetRadio", root, playerName)
			thePlayer = thePlayer
			local playerName = getPlayerName ( thePlayer )
			konum = "left"
	        dj = "DJ #FF0000"..playerName
		end
		end
		, false)
end
addEventHandler("onClientResourceStart", resourceRoot, load_gui)

function radio_config_open()
		showCursor(not guiGetVisible(RadioConfigMainWindow))
		guiSetVisible(RadioConfigMainWindow, not guiGetVisible(RadioConfigMainWindow))
end
addEvent( "onRadioConfigOpen", true )
addEventHandler( "onRadioConfigOpen", root, radio_config_open)


local screenW, screenH = guiGetScreenSize()
textis = "Online Radio #00ff00Active"
dj = "NaaB"
     function info()
        dxDrawRectangle((screenW - dxGetTextWidth(textis, 1.2, "default-bold") - 10) / 2, (screenH - 58), dxGetTextWidth(textis, 1.2, "default-bold") + 10, 20, tocolor(0, 0, 0, alpharec), false)
        dxDrawRectangle((screenW - dxGetTextWidth(textis, 1.2, "default-bold") - 10) / 2, (screenH - 98), dxGetTextWidth(textis, 1.2, "default-bold") + 10, 14, tocolor(0, 0, 0, alpharec), false)
        dxDrawRectangle((screenW - dxGetTextWidth(textis, 1.2, "default-bold") - 10) / 2, (screenH - 84), dxGetTextWidth(textis, 1.2, "default-bold") + 10, 26, tocolor(0, 0, 0, alphar), false)
        dxDrawText(textis, (screenW - 208) / 2, (screenH - 110), ((screenW - 208) / 2) + 208, ( (screenH - 58)) + 28, tocolor(255, 255, 255, alpha), 1.2, "default-bold", "center", "center", false, false, false, true, false)
        dxDrawText(dj, (screenW - dxGetTextWidth(textis, 1.2, "default-bold") - 5) / 2, (screenH - 66), ((screenW - 208) / 2) + dxGetTextWidth(textis, 1.2, "default-bold"), ( (screenH - 58)) + 28, tocolor(255, 255, 255, alpha), 1.00, "default-bold", konum, "center", false, false, false, true, false)
    panelacik = true
	end
-- istek sarkılar

key = ""
local r, g, b = math.random(255), math.random(255), math.random(255)

GUIEditor_Window = {}
GUIEditor_Button = {}
GUIEditor_Memo = {}
GUIEditor_Label = {}

GUIEditor_Window[1] = guiCreateWindow(250,224,531,263,"Song Request Panel",false)
guiSetAlpha(GUIEditor_Window[1],1)
guiWindowSetSizable(GUIEditor_Window[1],false)
guiSetVisible (GUIEditor_Window[1], false)
GUIEditor_Button[1] = guiCreateButton(14,207,81,39,"Ersal",false,GUIEditor_Window[1])
GUIEditor_Button[2] = guiCreateButton(106,207,81,39,"Pak Kardan",false,GUIEditor_Window[1])
GUIEditor_Button[3] = guiCreateButton(441,207,81,39,"Bastan",false,GUIEditor_Window[1])
GUIEditor_Memo[1] = guiCreateMemo(9,23,513,173,"",false,GUIEditor_Window[1])


function OpenWin()
	if guiGetVisible (GUIEditor_Window[1]) then   
		guiSetVisible (GUIEditor_Window[1], false)
		showCursor(false) 
		guiSetInputEnabled(false)
	else
		guiSetVisible (GUIEditor_Window[1], true)
		showCursor(true)
		guiSetInputEnabled(true)

	end 
end 
bindKey(key, "down", OpenWin) 
addCommandHandler ( "song", OpenWin )


addEventHandler("onClientGUIClick", root,
	function(name, report)
		if (source == GUIEditor_Button[1]) then
			local name = getPlayerName(localPlayer)
			local report = guiGetText(GUIEditor_Memo[1])
			triggerServerEvent("send", root, name, report)
			guiSetText(GUIEditor_Memo[1], "")
		elseif (source == GUIEditor_Button[2]) then
			guiSetText(GUIEditor_Memo[1], "")
		elseif (source == GUIEditor_Button[3]) then
			guiSetVisible (GUIEditor_Window[1], false)
			showCursor(false) 
			guiSetInputEnabled(false)		
		end
	end
)

alpha = 0
alpharec = 0
alphar = 0

alphaState = true

-- logo

local screenW, screenH = guiGetScreenSize()
degerler = {
	["canakkalelogo"] = 0,
}
local canakkale = {
	["canakkalelogo"] = 0
}

local canakkalegecilmez = "right" 
	function logo()
        dxDrawRectangle((screenW - dxGetTextWidth(textis, 1.2, "default-bold") - 110) / 2, (screenH - 98), 50, 60, tocolor(0, 0, 0, alpharec), false)
		dxDrawImage( (screenW - dxGetTextWidth(textis, 1.2, "default-bold") - 110) / 2, (screenH - 93), 50, 50, "logo.png", canakkale["canakkalelogo"], 0, 0, tocolor( 255, 255, 255, alpha) )
		dxDrawRectangle((screenW + dxGetTextWidth(textis, 1.2, "default-bold") + 10) / 2, (screenH - 98), 50, 60, tocolor(0, 0, 0, alpharec), false) 		dxDrawImage( (screenW + dxGetTextWidth(textis, 1.2, "default-bold") + 10) / 2, (screenH - 93), 50, 50, "logo.png", canakkale["canakkalelogo"], 0, 0, tocolor( 255, 255, 255, alpha) )
		if ( canakkale["canakkalelogo"] == 15 ) then
			canakkalegecilmez = "right"
		elseif ( canakkale["canakkalelogo"] == -15 ) then
			canakkalegecilmez = "left"
		end
			
		if ( canakkalegecilmez == "left" ) then
			canakkale["canakkalelogo"] = canakkale["canakkalelogo"] + 0.5
		elseif ( canakkalegecilmez == "right" ) then
			canakkale["canakkalelogo"] = canakkale["canakkalelogo"] - 0.5
		end
	end

setTimer( function() 
	degerler["canakkalelogo"] = degerler["canakkalelogo"] + 15
end, 100, 10 )
