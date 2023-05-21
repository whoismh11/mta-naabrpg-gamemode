local thecolors={
	'hpCol',
	'armorCol',
	'ringCol',
	'moneyGreenCol',
	'moneyRedCol',
	'clipCol',
	'ammoCol',
	'textColor',
	'backgroundCol'
}

checkboxes={}
local checkboxesrev={}

checks={
	'doDrawRadio';
	'doDrawInfo';
	'doDrawHUD';
	'doDrawRadar';
	'createBlipsForVehicles';
	'createTextsForVehicles';
	'createBlipsForPickups';
	'createTextsForPickups'
}

local texts={
	'Draw radio';
	'Draw information labels';
	'Draw weapons and money';
	'Draw radar';
	'Draw blips for vehicles';
	'Draw blip texts for vehicles';
	'Draw blips for pickups';
	'Draw blip texts for pickups'
}

local lastclick,lastrow=0,1

local gridBorders={
	7,24,40,28
}

function doGui()
	gui={
		radar=guiCreateWindow(x-size*1.1+1,y-size*1.1-17,size*2.2,size*2.2+17,'Radar - Move and resize',false);
		radio=guiCreateWindow(radioX-radioSize*1.2*(radioSideIcons),radioY-20,radioSize*1.2*radioSideIcons*2,radioSize+22,'Radio - Move and resize',false);
		hud=guiCreateWindow(sx-hudX-256,hudY,256,266,'HUD - Drag to move',false);
		text=guiCreateWindow(txtx,txty-17,150,160,'Text Info - Drag to move',false);
		save=guiCreateButton(sx/2-100,sy-50,95,45,'Accept',false);
		cancel=guiCreateButton(sx/2+5,sy-50,95,45,'Decline',false);
		default=guiCreateButton(sx/2-100,sy-90,95,35,'Reset defaults',false);
		advanced=guiCreateButton(sx/2+5,sy-90,95,35,'Advanced settings',false);
	}
	createSettingsWindow()
	guiSetVisible(gui.radar,false)
	guiSetAlpha(gui.radar,0.3)
	guiWindowSetSizable(gui.hud,false)
	guiSetVisible(gui.radio,false)
	guiSetAlpha(gui.radio,0.3)
	guiWindowSetSizable(gui.text,false)
	guiSetVisible(gui.hud,false)
	guiSetAlpha(gui.hud,0.3)
	guiSetVisible(gui.text,false)
	guiSetAlpha(gui.text,0.3)
	guiSetVisible(gui.save,false)
	guiSetVisible(gui.cancel,false)
	guiSetVisible(gui.default,false)
	guiSetVisible(gui.advanced,false)

	addEventHandler('onClientGUIMove',gui.radar,function()
		local posx,posy=guiGetPosition(source,false)
		local sizex,sizey=guiGetSize(source,false)
		if posx<0 or posx+sizex>sx or posy<0 or posy+sizey>sy then
			posx=math.clip(0,posx,sx-sizex)
			posy=math.clip(0,posy,sy-sizey)
			guiSetPosition(source,posx,posy,false)
		end
		x,y=posx-1+size*1.1,posy+17+size*1.1
	end)
	addEventHandler('onClientGUISize',gui.radar,function()
		if dontcallgui then return end
		local posx,posy=guiGetPosition(source,false)
		local sizex,sizey=guiGetSize(source,false)
		local setsize=math.clip(150,(sizex+sizey-17)/2,500)
		if posx<0 or posx+setsize>sx or posy<0 or posy+setsize+17>sy then
			posx=math.clip(0,posx,sx-setsize)
			posy=math.clip(0,posy,sy-setsize-17)
			guiSetPosition(source,posx,posy,false)
		end
		guiSetSize(source,setsize,setsize+17,false)
		size=setsize/2.2
		size2=setsize/1.1
		x,y=posx-1+size*1.1,posy+17+size*1.1
		x2,y2,l2,h2=size*1.5-size*1.3,size*1.5-size*1.3,size*2.6,size*2.6
		border=110/128*size*1.20
		if dxGetMaterialSize(renderImage)~=size2 then
			destroyElement(renderImage)
			renderImage=dxCreateRenderTarget(size2,size2,false)
		end
		if dxGetMaterialSize(newtarg)~=size*3 then
			destroyElement(newtarg)
			newtarg=dxCreateRenderTarget(size*3,size*3,false)
		end
	end)
	addEventHandler('onClientGUISize',gui.radio,function()
		if dontcallgui then return end
		local posx,posy=guiGetPosition(source,false)
		local sizex,sizey=guiGetSize(source,false)
		sizey=math.clip(20,sizey,200)
		sizex=math.clip(200,sizex,1000)
		if posx<0 or posx+sizex>sx or posy<0 or posy+sizey+22>sy then
			posx=math.clip(0,posx,sx-sizex)
			posy=math.clip(0,posy,sy-sizey-22)
			guiSetPosition(source,posx,posy,false)
		end
		guiSetSize(source,sizex,sizey,false)
		radioX,radioY=posx+sizex/2,posy+20
		radioSize=sizey-22
		radioSideIcons=math.floor((sizex-(sizex%(radioSize*radioGapSize)))/radioGapSize/radioSize/2+0.5)
		radioFadeGap=sizex/2-radioSize/2
	end)
	addEventHandler('onClientGUIMove',gui.radio,function()
		if dontcallgui then return end
		local posx,posy=guiGetPosition(source,false)
		local sizex,sizey=guiGetSize(source,false)
		if posx<0 or posx+sizex>sx or posy<0 or posy+sizey>sy then
			posx=math.clip(0,posx,sx-sizex)
			posy=math.clip(0,posy,sy-sizey)
			guiSetPosition(source,posx,posy,false)
		end
		radioX,radioY=posx+sizex/2,posy+20
	end)
	addEventHandler('onClientGUIMove',gui.hud,function()
		local posx,posy=guiGetPosition(source,false)
		local sizex,sizey=guiGetSize(source,false)
		if posx<0 or posx+sizex>sx or posy<0 or posy+sizey>sy then
			posx=math.clip(0,posx,sx-sizex)
			posy=math.clip(0,posy,sy-sizey)
			guiSetPosition(source,posx,posy,false)
		end
		hudX,hudY=sx-(posx+sizex),posy
	end)
	addEventHandler('onClientGUIMove',gui.text,function()
		local posx,posy=guiGetPosition(source,false)
		local sizex,sizey=guiGetSize(source,false)
		if posx<0 or posx+sizex>sx or posy<0 or posy+sizey>sy then
			posx=math.clip(0,posx,sx-sizex)
			posy=math.clip(0,posy,sy-sizey)
			guiSetPosition(source,posx,posy,false)
		end
		txtx,txty=posx,posy+17
	end)
	addEventHandler('onClientGUIClick',gui.save,function(btn, state)
		if btn=='left' and state=='up' then
			saveChanges()
		end
	end)
	addEventHandler('onClientGUIClick',gui.cancel,function(btn, state)
		if btn=='left' and state=='up' then
			undoChanges()
		end
	end)
	addEventHandler('onClientGUIClick',gui.default,function(btn, state)
		if btn=='left' and state=='up' then
			setDefault()
		end
	end)
	addEventHandler('onClientGUIClick',gui.advanced,function(btn, state)
		if btn=='left' and state=='up' then
			showSettings(false,false,true,true)
		end
	end)
end

function createSettingsWindow()
	window=guiCreateWindow(math.min(sx/2-175,724),sy/2,394,310,'IVhud - Advanced Settings',false)
	guiWindowSetSizable(window,false)
	guiSetAlpha(window,0.7)
	guiSetVisible(window,false)
	panel=guiCreateTabPanel(10,25,374,238,false,window)
		colorstab=guiCreateTab("Colors",panel)
			colorlist=guiCreateGridList(5,10,364,160,false,colorstab)
			guiGridListSetSortingEnabled(colorlist,false)
			guiGridListAddColumn(colorlist,'Color description',0.5)
			guiGridListAddColumn(colorlist,'Current color',0.2)
			guiGridListAddColumn(colorlist,'Default color',0.2)
			for i=1,10 do
				guiGridListAddRow(colorlist)
			end
			guiGridListSetItemText(colorlist,1,1,'HP bar color',false,false)
			guiGridListSetItemText(colorlist,2,1,'Armor bar color',false,false)
			guiGridListSetItemText(colorlist,3,1,'Inner and outer ring color',false,false)
			guiGridListSetItemText(colorlist,4,1,'Positive money text color',false,false)
			guiGridListSetItemText(colorlist,5,1,'Negative money text color',false,false)
			guiGridListSetItemText(colorlist,6,1,'Clip display color',false,false)
			guiGridListSetItemText(colorlist,7,1,'Ammo display color',false,false)
			guiGridListSetItemText(colorlist,8,1,'Radar blip text color',false,false)
			guiGridListSetItemText(colorlist,9,1,'Radar blip text background',false,false)
			for i=1,10 do 
				guiGridListSetItemText(colorlist,i,2,'',false,false)
				guiGridListSetItemText(colorlist,i,3,'',false,false)
			end
			local change=guiCreateButton(5,177,179,30,'Change',false,colorstab)
			local deff=guiCreateButton(190,177,179,30,'Set default',false,colorstab)
			addEventHandler('onClientGUIClick',colorlist,handleBuggedDoubleClick,false)
			addEventHandler('onClientGUIClick',change,openColorPicker,false)
			addEventHandler('onClientGUIClick',deff,setDeffCol,false)
		local disabling=guiCreateTab('Disabling features',panel)
			for id,setting in ipairs(checks) do
				local y=13+200/(#checks)*(id-1)
				local checkbox=guiCreateCheckBox(10,y,354,15,texts[id],_G[setting],false,disabling)
				checkboxesrev[checkbox]=id
				checkboxes[id]=checkbox
				addEventHandler('onClientGUIClick',checkbox,function()
					local id=checkboxesrev[source]
					setElementData(localP,"IVhud_"..checks[id],_G[checks[id]],true)
					_G[checks[id]]=guiCheckBoxGetSelected(source)
					if id==3 then
						if guiCheckBoxGetSelected(source) and not weptarg then
							weptarg=dxCreateRenderTarget(256,256,true)
						end
					elseif id==4 then
						guiSetEnabled(checkboxes[5],guiCheckBoxGetSelected(source))
						guiSetEnabled(checkboxes[6],guiCheckBoxGetSelected(source) and createBlipsForVehicles)
						guiSetEnabled(checkboxes[7],guiCheckBoxGetSelected(source))
						guiSetEnabled(checkboxes[8],guiCheckBoxGetSelected(source) and createBlipsForPickups)
						if guiCheckBoxGetSelected(source) and not hudrendertarg then
							hudrendertarg=dxCreateRenderTarget(256,300,true)
							if not texture then
								texture=dxCreateTexture('images/radar.jpg')
							end
							if not mask then
								mask=dxCreateTexture('images/mask2.png')
							end
							if not shader then
								shader=dxCreateShader('shader.fx')
							end
							dxSetShaderValue(shader,'finalAlpha',finalAlpha/255)
							dxSetShaderValue(shader,'maskTex0',mask)
							doDependableValReCalc()
						end
					elseif id>4 then
						if id==5 then
							guiSetEnabled(checkboxes[6],guiCheckBoxGetSelected(source))
						elseif id==6 then
							markedvehicles={}
						elseif id==7 then
							guiSetEnabled(checkboxes[8],guiCheckBoxGetSelected(source))
						else
							markedpickups={}
						end
						getBlips()
					end
					reDelDefaultHUD()
				end,false)
			end
			texts=nil

	local savebutton=guiCreateButton(10,269,182,30,'Save',false,window)
	local cancelbutton=guiCreateButton(202,269,182,30,'Cancel',false,window)
	addEventHandler('onClientGUIClick',savebutton,saveChanges,false)
	addEventHandler('onClientGUIClick',cancelbutton,undoChanges,false)
	for _,check in ipairs(checks) do
		setElementData(localP,"IVhud_"..check,_G[check],true)
	end
end

function handleBuggedDoubleClick(button,state)
	if button=="left" and state=="up" then
		local ticks=getTickCount()
		listrow=guiGridListGetSelectedItem(colorlist)
		if ticks-lastclick<500 and listrow==lastrow then
			openColorPicker()
		end
		lastclick,lastrow=ticks,listrow
	end
end

function openColorPicker()
	listrow=guiGridListGetSelectedItem(colorlist)
	if listrow==-1 then return end
	colval=thecolors[listrow]
	colorPicker.openSelect(colval)
	update=true
	if not event then
		addEventHandler("onClientRender", root, updateColor)
		event=true
	end
end

function setDeffCol()
	listrow=guiGridListGetSelectedItem(colorlist)
	if listrow==-1 then return end
	colval=thecolors[listrow]
	update=false
	_G[colval]=deffSettings[colval]
end

function closedColorPicker()
	event=false
	removeEventHandler("onClientRender", root, updateColor)
end

function updateColor()
	if not update then return end
	local r, g, b = colorPicker.updateTempColors()
	_G[colval]=tocolor(r,g,b,colval=='backgroundCol' and 200 or 255)
end

function drawColors()
	if guiGetSelectedTab(panel)~=colorstab then return end
	local x,y=guiGetPosition(window,false)
	local six,siy=guiGetSize(colorlist,false)
	x=15+(x+(siy-gridBorders[3]))+(six-gridBorders[1]-gridBorders[3])*0.2
	y,six,siy=60+y+gridBorders[2],(six-gridBorders[1]-gridBorders[3])*0.478,siy-gridBorders[2]-gridBorders[4]
	local xsize,ysize=math.ceil(six/2),math.ceil(siy/8)
	for i=1,9 do
		dxDrawRectangle(x+2,y+2,xsize-4,ysize-4,_G[thecolors[i]],true)
		dxDrawRectangle(x+xsize+2,y+2,xsize-4,ysize-4,deffSettings[thecolors[i]],true)
		y=y+ysize
	end
end
