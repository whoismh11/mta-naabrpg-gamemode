sx,sy=guiGetScreenSize() --ovibious, dont change it.
localP = localPlayer --was needed in 1.0.5, cba changing now.
root = getRootElement()
resRoot = getResourceRootElement()
deffSettings={
	minVel = 0.3; --velocity, from witch on radar zoom will go bigger
	minDist = 180; --minimum radius of radar in meters, with zoom 1.
	maxVel = 1; --at witch point maxDist will take effect
	maxDist = 360; --[[maximum radius of map in meters, shown with 1 zoom,
		,if velocity of car is maxVel or higher.You can change it, bot dont make it any bigger.]]
	minZoom = 1.3; --minimum changebale zoom
	maxZoom = 3; --maximum changeable zoom
	zoom=1.3; --default zoom
	zoomPlus='='; --key to zoom in the radar
	zoomMinus='-'; --key to zoom out the radar
	toogleHUDKey='num_mul'; --key to toogle Hud
	showAllKey='num_add'; --key that shows all data
	size=0.100*sy; --[[radius of hud, do this*1.3 to get actual radius of radar in pixels.
		Is affected by resolution.]]
	radioX=sx/2;
	radioY=50; --radio display position, in pixels
	radioSize=100/1080*sy; --radio icon size, in pixels
	radioFadeTime=5000; --how long it takes to fade radio hud out
	radioSideIcons=2; --how much radio icons should be drawn on each side of the current radio icon
	radioSlideSpeed=500; --speed, how fast radio icons slide forwards/backwards
	dxSize=1; --size of blip texts, currently cant find optimal solution for all resolutions
	dxFont='arial'; --font of blip texts
	screenSizeCompensate=sy/500; --how much will blip size be affected by your resolution
	txtx=sx-200;
	txty=sy-200; -- < ^ text position
	textColor=tocolor(200,200,200,255); --default color of blip texts
	backgroundCol=tocolor(0,0,0,200); --color of blip text background
	hpCol=tocolor(20,90,20,255); --color of HP bar
	armorCol=tocolor(10,50,100,255); --color of armor bar
	ringCol=tocolor(30,30,30,255); --color of hud ring
	inRingCol=tocolor(0,0,0,255); --color of armour & HP bar background
	moneyGreenCol=tocolor(0,255,130,255);
	moneyRedCol=tocolor(255,0,0,255);
	clipCol=tocolor(150,150,150,255);
	ammoCol=tocolor(225,225,225,255);
	waterCol=tocolor(67,86,88,255);
	finalCol=tocolor(255,255,255,255); --color used in final hud componet drawings
	finalAlpha=210; --final radar alpha
	createBlipsForVehicles=true;
	createBlipsForPickups=true;
	createTextsForVehicles=true;
	createTextsForPickups=true;
	renderPickups=true; --should blips attached to pickups be transformed into a legit pickup blip
	hudX=0;
	hudY=0; --x and y in pixels from right top corner to right top edge of weapon/money/time/wanted level hud area
	doDrawRadio=false;
	doDrawRadar=false;
	doDrawInfo=false;
	doDrawHUD=true;
	blipDimension=math.ceil(sy/70); --default size blip width,height
	x=0.110*sy*1.7;
	y=sy-0.100*sy*1.5; --position of center of radar on screen
}
--end of settings
radioGapSize=1.2
size2=deffSettings.size*2
x2,y2,l2,h2=deffSettings.size*1.5,deffSettings.size*1.5-deffSettings.size*1.3,deffSettings.size*2.6,deffSettings.size*2.6
radioFadeGap=deffSettings.radioSideIcons*deffSettings.radioSize*radioGapSize+deffSettings.radioSize/2
textH=dxGetFontHeight(deffSettings.dxSize,deffSettings.dxFont)
border=110/128*deffSettings.size*1.20
ratio=(deffSettings.maxDist-deffSettings.minDist)/(deffSettings.maxVel-deffSettings.minVel)
doRender=true
radioSwitchTime=0
moneychangecol=deffSettings.moneyGreenCol
settingsOn=false
local advancedOpen=false
local backup={}

function getSettings()
	local config=xmlLoadFile('settings.xml')
	if config then
		local ret={}
		for _,node in ipairs(xmlNodeGetChildren(config)) do
			local key=xmlNodeGetName(node)
			local val=xmlNodeGetValue(node)
			ret[key]=toboolean(val)
			if type(ret[key])~='boolean' then
				ret[key]=tonumber(val) or val
			end
		end
		xmlUnloadFile(config)
		for k in pairs(deffSettings) do
			if ret[k]==nil then
				ret[k]=deffSettings[k]
			end
		end
		return ret
	else
		config=xmlCreateFile('settings.xml','root')
		for k,v in pairs(deffSettings) do
			local child=xmlCreateChild(config,k)
			xmlNodeSetValue(child,tostring(v))
		end
		xmlSaveFile(config)
		xmlUnloadFile(config)
		return deffSettings
	end
end

function saveSettings()
	local config=xmlLoadFile('settings.xml')
	local settings={}
	for k in pairs(deffSettings) do
		local child=xmlFindChild(config,k,0)
		if not child then
			child=xmlCreateChild(config,k)
		end
		xmlNodeSetValue(child,tostring(_G[k]))
	end
	xmlSaveFile(config)
	xmlUnloadFile(config)
end

function saveChanges()
	saveSettings() --dunno is really such crash protection needed, but meh, not that resource intense, delete it if you want.
	showSettings(_,_,advancedOpen,false)
	backup={}
end

function undoChanges()
	for k,v in pairs(backup) do
		_G[k]=v
	end
	backup={}
	doDependableValReCalc()
	showSettings(_,_,advancedOpen,false)
end

function setDefault()
	for k,v in pairs(deffSettings) do
		_G[k]=v
	end
	doDependableValReCalc()
end

function showSettings(_,_,show,advanced)
	advanced=not not advanced --nil delete
	advancedOpen=advanced
	doRender=true
	posGUI=(not advanced) and show
	settingsOn=not not show
	showCursor(settingsOn,false)
	guiSetVisible(gui.hud,settingsOn and doDrawHUD and not advanced)
	guiSetVisible(gui.radar,settingsOn and doDrawRadar and not advanced)
	guiSetVisible(gui.text,settingsOn and doDrawInfo and not advanced)
	guiSetVisible(gui.radio,settingsOn and doDrawRadio and not advanced)
	guiSetVisible(gui.default,settingsOn and not advanced)
	guiSetVisible(gui.save,settingsOn and not advanced)
	guiSetVisible(gui.cancel,settingsOn and not advanced)
	guiSetVisible(gui.advanced,settingsOn and not advanced)
	guiSetVisible(window,settingsOn and advanced)
	if event then
		removeEventHandler("onClientRender", root, updateColor)
	end
	if not advanced then
		removeEventHandler("onClientRender", root, drawColors)
		colorPicker.closeSelect()
	else
		addEventHandler("onClientRender", root, drawColors)
	end
	if settingsOn then
		backup=getBackup()
		entering=true
		worthDrawingRadio=true
		radioSwitchTime=getTickCount()
		showAll()
		if not isTimer(settingtimer) then
			settingtimer=setTimer(function()
				entering=true
				worthDrawingRadio=true
				radioSwitchTime=getTickCount()
				showAll()
			end,3000,0)
		end
	else
		if isTimer(settingtimer) then
			killTimer(settingtimer)
		end
	end
end

function getBackup()
	local backuptbl={}
		for k in pairs(deffSettings) do
			backuptbl[k]=_G[k]
		end
	return backuptbl
end

function getValues()
	for k,v in pairs(getSettings()) do --sorry i dont feel like making the code 2times longer in size to save up few KB
		_G[k]=v
	end
end

function doDependableValReCalc()
	dontcallgui=true
	if doDrawRadar then
		textH=dxGetFontHeight(dxSize,dxFont)
		size2=size*2
		x2,y2,l2,h2=size*1.5-size*1.3,size*1.5-size*1.3,size*2.6,size*2.6
		border=110/128*size*1.20
		if isElement(renderImage) then
			destroyElement(renderImage)
		end
		renderImage=dxCreateRenderTarget(size2,size2,false)
		if isElement(newtarg) then
			destroyElement(newtarg)
		end
		newtarg=dxCreateRenderTarget(size*3,size*3,false)
		guiSetPosition(gui.radar,x-size*1.1+1,y-size*1.1-17,false)
		guiSetSize(gui.radar,size*2.2,size*2.2+17,false)
	end
	if doDrawRadio then
		radioFadeGap=radioSideIcons*radioGapSize*radioSize+radioSize*radioGapSize/2
		guiSetPosition(gui.radio,radioX-radioFadeGap-radioSize*radioGapSize/2,radioY-20,false)
		guiSetSize(gui.radio,radioSize*radioGapSize*(radioSideIcons+1)*2,radioSize+22,false)
	end
	if doDrawHUD then
		guiSetPosition(gui.hud,sx-hudX-256,hudY,false)
	end
	if doDrawInfo then
		guiSetPosition(gui.text,txtx,txty-17,false)
	end
	guiSetEnabled(checkboxes[5],doDrawRadar)
	guiSetEnabled(checkboxes[7],doDrawRadar)
	guiSetEnabled(checkboxes[6],doDrawRadar and createBlipsForVehicles)
	guiSetEnabled(checkboxes[8],doDrawRadar and createBlipsForPickups)
	for id,cbox in ipairs(checkboxes) do
		guiCheckBoxSetSelected(cbox,_G[checks[id]])
	end
	getBlips()
	dontcallgui=false
end

function reDelDefaultHUD()
	if doDrawHUD then
	end
	if doDrawRadar then
	end
	if doDrawRadio then
	end
	if doDrawInfo then
	end
	if raceMode then
	end
end
