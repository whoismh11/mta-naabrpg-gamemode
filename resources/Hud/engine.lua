local mapSize=3000
local white2=tocolor(255,255,255,200)
local lastOffX,lastrid=0,0
local radioStartAt=0
local startsetnewr
local newWep
local moneydiff
local moneydiffchangetime=0
local moneychangestr=''
local lastmoney=0
local moneychangetime
local wslot=0
local doflash, overrideflash
local lastwanchange=getTickCount()
local lastwanlvl=0
local weapon=0
local wepswitchtime
local airmode
local roundAreas={}
local radioGoRight
local oldRadio=0
local newRadio=0
local normCol=tocolor(255,255,255,255)
local black=tocolor(0,0,0,255)
local blipTimer
local moneydiff
local areas={}
local blips
local lastcurr=0
local hp=180
local armor=0
local areaTimer
local hpTimer
local dmgTab={}
local elemData={}
local players={}
local blipimages={}
local zoomticks=getTickCount()
local raceMode
local vehicle
local parachute
local vehSwitchTime=0
local showTime=0
local fps=0
local frames,lastsec=0,0
local showTime=0
local madeByHUD={}
local markedvehicles={}
local markedpickups={}
local doFPS = true
local welcomeMsg = true

function onStart()
	getValues()
	roundAreas=getElementData(root,'roundareadata') or {}
	setElementData(root,'roundareadata',nil)
	wslot=getPedWeaponSlot(localP)
	weapon=getPedWeapon(localP,wslot)
	moneychangetime=getTickCount()
	wepswitchtime=getTickCount()
	blips = getElementsByType('blip')
	getBlips()
	for _,v in ipairs(blips) do
		if not elemData[v] then
			elemData[v]={}
		end
		elemData[v][1]=getElementData(v,'blipText')
		elemData[v][2]=getElementData(v,'customBlipPath')
	end
	areaTimer=setTimer(getRadarAreas,5000,0)
	hpTimer=setTimer(refreshHP,100,0)
	bindKey(toogleHUDKey,'down',toogleHUD)
	bindKey('radio_next','down',radioSwitch,true)
	bindKey('F13','down',showSettings,true)
	bindKey('radio_previous','down',radioSwitch,false)
	bindKey('fire','down',weaponFire)
	bindKey(showAllKey,'down',showAll)
	local dxinfo=dxGetStatus()
	if dxinfo['VideoMemoryFreeForMTA']<=10 then
		outputChatBox('Sorry, your video memory is [almost] full.',false,255,0,0)
		outputChatBox('IVhud can\'t draw weapon icons and radar with no video memory aviable.',false,255,0,0)
		outputChatBox('Change your MTA settings or visit MTA forums for more help.',false,255,0,0)
		doDrawRadar,doDrawHUD=false,false
	elseif not dxinfo then
		outputChatBox( 'IVhud is not fully compatible with this MTA version.',false,255,0,0)
		outputChatBox( 'Download MTA 1.1 or higher.',false,255,0,0)
		doDrawRadar,doDrawHUD=false,false
	else
		hudrendertarg=dxCreateRenderTarget(256,300,true)
		weptarg=dxCreateRenderTarget(256,256,true)
		renderImage=dxCreateRenderTarget(size2,size2,false)
		newtarg=dxCreateRenderTarget(size*3,size*3,false)
	end

	doGui()
	doDependableValReCalc()
	reDelDefaultHUD()
	addEventHandler('onClientRender',root,renderFrame)
	if welcomeMsg then
	end
end

function onStop()
	saveSettings()
	setElementData(root,'roundareadata',roundAreas)
	for _,v in ipairs(getElementsByType("blip",resourceRoot)) do
		destroyElement(v)
	end
	killTimer(hpTimer)
	killTimer(areaTimer)
end

function onRaceStart()
	reDelDefaultHUD()
	setTimer(reDelDefaultHUD,300,1)
	if not raceMode then
		raceMode=true
		if isTimer(hpTimer) then
			killTimer(hpTimer)
		end
	end
end

function onRaceStop()
	if raceMode then
		raceMode=false
		if not isTimer(hpTimer) then
			hpTimer=setTimer(refreshHP,100,0)
		end
	end
end

function vehEnter(veh,seat)
	entering=true
	worthDrawingRadio=true
	newRadio=getRadioChannel()
	oldRadio=newRadio
	radioSwitchTime=getTickCount()
	vehSwitchTime=getTickCount()
	setElementData(source,'vehicleSeat',seat,true)
end

function vehExit()
	newRadio=getRadioChannel()
	oldRadio=getRadioChannel()
	radioSwitchTime=0
	setElementData(source,'vehicleSeat',false,true)
end

function getRadarRadius ()
	if not vehicle then
		return minDist
	else
		if getVehicleType(vehicle) == 'Plane' then
			return maxDist
		end
		local speed = ( getDistanceBetweenPoints3D(0,0,0,getElementVelocity(vehicle)) )
		if speed <= minVel then
			return minDist
		elseif speed >= maxVel then
			return maxDist
		end
		local streamDistance = speed - minVel
		streamDistance = streamDistance * ratio
		streamDistance = streamDistance + minDist
		return math.ceil(streamDistance)
	end
end

function getRot()
	local camRot
	local cameraTarget = getCameraTarget()
	if not cameraTarget then
		local px,py,_,lx,ly = getCameraMatrix()
		camRot = getVectorRotation(px,py,lx,ly)
	else
		if vehicle then
			if getPedControlState'vehicle_look_behind' or ( getPedControlState'vehicle_look_left' and getPedControlState'vehicle_look_right' ) or ( getVehicleType(vehicle)~='Plane' and getVehicleType(vehicle)~='Helicopter' and ( getPedControlState'vehicle_look_left' or getPedControlState'vehicle_look_right' ) ) then
				camRot = -math.rad(getPedRotation(localP))
			else
				local px,py,_,lx,ly = getCameraMatrix()
				camRot = getVectorRotation(px,py,lx,ly)
			end
		elseif getPedControlState('look_behind') then
			camRot = -math.rad(getPedRotation(localP))
		else
			local px,py,_,lx,ly = getCameraMatrix()
			camRot = getVectorRotation(px,py,lx,ly)
		end
	end
	return camRot
end

function refreshElementData(name)
	local etype=getElementType(source)
	if etype=='blip' and elemData[source] then
		if name=='blipText' then
			elemData[source][1]=getElementData(source,name)
		elseif name=='customBlipPath' then
			elemData[source][2]=getElementData(source,name)
		end
	elseif etype=='player' and name=='vehicleSeat' then
		if not players[source] then
			players[source]=getElementData(source,name)
		end
	end
end

function getRadarAreas()
	areas=getElementsByType('radararea')
end

function ultilizeDamageScreen(attacker,weapon,_,loss)
	refreshHP()
	local type=getElementType(attacker)
	local slot=type~='vehicle' and getPedWeaponSlot(attacker) or false
	if attacker and attacker~=source and not (slot==8 or (slot==7 and weapon~=38)) then
		local px1,py1=getElementPosition(source)
		local px2,py2=getElementPosition(attacker)
		dmgTab[#dmgTab+1]={getTickCount(),math.deg(getVectorRotation(px1,py1,px2,py2)),math.min(25.5*loss,255)}
	else
		local len=#dmgTab
		for n=1,12 do
			dmgTab[len+n]={getTickCount(),30*n,math.min(25.5*loss,255)}
		end
	end
	if #dmgTab>18 then
		repeat
			table.remove(dmgTab,1)
		until #dmgTab<18
	end
end

function drawRadarAreas(mx,my,mw,mh)
	for _,area in pairs(areas) do
		if getElementInterior(localP)==getElementInterior(area) and getElementDimension(localP)==getElementDimension(area) then
			local rax,ray=getElementPosition(area)
			local raw,rah=getRadarAreaSize(area)
			local ramx,ramy,ramw,ramh=(3000+rax)/6000*mapSize,(3000-ray)/6000*mapSize,raw/6000*mapSize,-(rah/6000*mapSize)
			if doesCollide(mx,my,mw,mh,ramx,ramy,ramw,ramh) then
				local r,g,b,a=getRadarAreaColor(area)
				if isRadarAreaFlashing(area) then
					a=a*math.abs(getTickCount()%1000-500)/500
				end
				local sRatio=size2/mw
				local dx,dy,dw,dh=(ramx-mx)*sRatio,(ramy-my)*sRatio,ramw*sRatio,ramh*sRatio
				dxDrawRectangle(dx,dy,dw,dh,tocolor(r,g,b,a),false)
			end
		end
	end
end

function drawRoundAreas(nx,ny,maprad)
	for _,content in pairs(roundAreas) do
		local ax,ay,arad=(3000+content[10])/6000*mapSize,(3000-content[11])/6000*mapSize,content[12]/6000*mapSize
		if isRingInRing(nx,ny,maprad,ax,ay,arad) then
			local sRatio=size/maprad
			local sax,say=(ax-(nx-maprad))*sRatio,(ay-(ny-maprad))*sRatio
			local sradius=arad*sRatio
			local r,g,b,a=content[1],content[2],content[3],content[4]
			if content[6] and content[13] then
				local prog=math.abs(getTickCount()%(content[5]*2)-content[5])/content[5]
				if content[13]=='Binary' then
					prog=math.floor(prog+0.5)
				end
				r,g,b=interpolateBetween(r,g,b,content[6],content[7],content[8],prog,content[13]~='Binary' and content[13] or 'Linear',content[14],content[15],content[16])
				a=a+(getEasingValue(prog,content[13]~='Binary' and content[13] or 'Linear',content[14],content[15],content[16])*(content[9]-a))
			end
		end
	end
end

function drawHudItems()
	if not doDrawHUD then return end
	dxSetRenderTarget(hudrendertarg,true)
	local currBufferOff=40
	local wantedlvl=getPlayerWantedLevel(localP)
	local ticks=getTickCount()
	if wantedlvl>0 then
		if wantedlvl~=lastwanlvl then
			if wantedlvl>lastwanlvl then
			end
			lastwanlvl=wantedlvl
		end
		for i=1,6 do
			dxDrawImage(256-30*i,hudY,32,32,(i<=wantedlvl) and 'images/wanted.png' or 'images/wanted_a.png',0,0,0,finalCol)
		end
	end
	local money=getPlayerMoney(localP)
	if lastmoney~=money then
		moneydiff=money-lastmoney
		moneychangetime=ticks
		moneychangestr=(moneydiff>0 and '+' or '')..tostring(moneydiff)..'$ '
		moneychangecol=moneydiff>0 and moneyGreenCol or moneyRedCol
		moneydiffchangetime=ticks
		lastmoney=money
	end
	if ticks-moneychangetime<15000 then
		local moneystr=tostring(money)..'$ '
		local moneycol=money>=0 and moneyGreenCol or moneyRedCol
		local moneyw=dxGetTextWidth(moneystr,1.2,'pricedown')
		dxDrawTextBordered(moneystr,math.min(221-moneyw,191),currBufferOff,256,currBufferOff+32,moneycol,2,1.2,'pricedown','center','top',false,false,false)
		if ticks-moneydiffchangetime<15000 then
			currBufferOff=currBufferOff+30
			local moneychangew=dxGetTextWidth(moneychangestr,1,'pricedown')
			dxDrawTextBordered(moneychangestr,math.min(221-moneychangew,191),currBufferOff,256,currBufferOff+32,moneychangecol,2,1,'pricedown','center','top',false,false,false)
		end
		currBufferOff=currBufferOff+30
	end
	if ticks-wepswitchtime<10000 then
		local weapon=getPedWeapon(localP)
		if weapon==13 then weapon=12 end
		if weapon==45 then weapon=44 end
		dxSetRenderTarget(weptarg,true)
		local alpha=1
		if ticks-wepswitchtime>8000 then
			alpha=1-(ticks-wepswitchtime-8000)/2000
		end
		if wslot>1 and wslot<10 then
			local ammo=' '..tostring(getPedTotalAmmo(localP))
			local clip=0
			local ammow=dxGetTextWidth(ammo,1.2,'pricedown')
			if not (weapon==25 or (weapon>32 and weapon<37) or wslot==8) then
				clip=getPedAmmoInClip(localP)
				local clipw=dxGetTextWidth(clip,1.2,'pricedown')+5
				dxDrawTextBordered(clip,236-ammow-clipw,0,256,currBufferOff+32,clipCol,2,1.2,'pricedown','left','top',false,false,false)
			end
			dxDrawTextBordered(ammo-clip,236-ammow,0,256,currBufferOff+32,ammoCol,2,1.2,'pricedown','left','top',false,false,false)
			currBufferOff=currBufferOff+32
		else
			currBufferOff=currBufferOff+16
		end
		dxDrawImage(0,32,256,128,'images/'..weapon..'.png',0,0,0,tocolor(255,255,255,255*alpha))
		dxSetRenderTarget(hudrendertarg)
		dxDrawImage(0,currBufferOff-32,256,256,weptarg,0,0,0,normCol)
	end
	dxSetRenderTarget()
	dxDrawImage(sx-hudX-256,hudY,256,300,hudrendertarg,0,0,0,finalCol,posGUI)
end

function renderFrame()
	if doRender and not isPlayerMapVisible() then
		local px,py,pz=getElementPosition(localP)
		vehicle=getPedOccupiedVehicle(localP)
		if doDrawRadar then
			local drawonborder
			local prz=getPedRotation(localP)
			local nx,ny=(3000+px)/6000*mapSize,(3000-py)/6000*mapSize
			local radius=getRadarRadius()
			local maprad=radius/6000*mapSize*zoom
			local preRot=-getRot()
			local rot=math.deg(preRot)
			dxSetRenderTarget(renderImage,true)
			if getElementInterior(localP)==0 then
				local mx,my,mw,mh=nx-maprad,ny-maprad,maprad*2,maprad*2
				local scx,scy,scw,sch=0,0,size2,size2
				local absx,absy=math.abs(px),math.abs(py)
				local dontDrawSc
				if absx+radius*zoom>3000 then
					if absx-radius*zoom>3000 then
						dontDrawSc=true
					elseif px<0 then
						mw=mx+mw
						mx=0
						scw=scw*(mw/(maprad*2))
						scx=size2-scw
					else
						mw=mw-(mx+mw-mapSize)
						scw=scw*(mw/(maprad*2))
					end
				end
				if absy+radius*zoom>3000 and not dontDrawSc then
					if absy-radius*zoom>3000 then
						dontDrawSc=true
					elseif py>0 then
						mh=my+mh
						my=0
						sch=sch*(mh/(maprad*2))
						scy=size2-sch
					else
						mh=mh-(my+mh-mapSize)
						sch=sch*(mh/(maprad*2))
					end
				end
				dxDrawRectangle(0,0,size2,size2,waterCol,false)
				if not dontDrawSc then
					dxDrawImageSection(scx,scy,scw,sch,mx,my,mw,mh,texture,0,0,0,normCol,false)
				end
				if screenRender then
					destroyElement(screenRender)
					screenRender=false
				end
			else
				if not screenRender then
					screenRender=dxCreateScreenSource(sx,sy)
				else
					dxUpdateScreenSource(screenRender)
					dxDrawImageSection(-size/2,-size/2,size*3,size*3,x-size*1.5,y-size*1.5,size*3,size*3,screenRender,0,0,0,normCol,false)
					rot=0
				end
			end
			drawRadarAreas(nx-maprad,ny-maprad,maprad*2,maprad*2)
			drawRoundAreas(nx,ny,maprad)
			dxSetRenderTarget(newtarg,true)
			dxDrawImage(size/2,size/2,size2,size2,renderImage,rot,0,0,normCol,false)
			for k,v in ipairs(dmgTab) do
				v[3]=v[3]-(getTickCount()-v[1])/800
				if v[3]<=0 then
					table.remove(dmgTab,k)
				else
				end
			end
			prepareBlips(px,py,pz,preRot,radius*zoom)
			drawAir(pz)
			drawHP()
			for _,v in ipairs(blipimages) do
				dxDrawImage(size*1.5+v[1]-x,size*1.5+v[2]-y,v[3],v[4],v[5],v[6],0,0,v[7],false)
			end
			if not (airmode or parachute) then
			end
			local Nx,Ny=getPointFromDistanceRotation(size*1.5,size*1.5,size*0.9,-rot-180)
			blipimages={}
			dxSetRenderTarget()
			dxSetShaderValue(shader,'tex0',newtarg)
			dxDrawImage(x-size*1.5,y-size*1.5,size*3,size*3,shader,0,0,0,finalCol,posGUI)
			local keyIn=getKeyState(zoomPlus)
			local keyOut=getKeyState(zoomMinus)
			if keyIn or keyOut then
				local progress=(getTickCount()-zoomticks)/1000
				zoom=math.max(minZoom,math.min(maxZoom,zoom+((keyIn and -1 or 1)*progress)))
			end
		end
		drawRadio()
		drawHudItems()
		drawTexts(px,py,pz)
	end
	zoomticks=getTickCount()
	if doFPS then
		frames=frames+1
		if zoomticks-1000>lastsec then
			local prog=(zoomticks-lastsec)
			lastsec=zoomticks
			fps=frames/(prog/1000)
			frames=fps*((prog-1000)/1000)
		end
	end
end

function prepareBlips(px,py,pz,rot,radiusR)
	local blips = getElementsByType("blip",root,true)
	table.sort(blips,function(b1,b2)
		return getBlipOrdering(b1)<getBlipOrdering(b2)
	end)
	for _,blip in ipairs(blips) do
		if getElementInterior(localP)==getElementInterior(blip) and getElementDimension(localP)==getElementDimension(blip) then
			local target=getElementAttachedTo(blip)
			local targetType=isElement(target) and getElementType(target)
			local bx,by,bz=getElementPosition(blip)
			local occupant,doSkip
			if not elemData[blip] then getBlips(blip) end
			local bSize=math.min(getBlipSize(blip),4)*blipDimension/2
			local visDist=madeByHUD[blip] and radiusR*0.92+bSize*radiusR/size*0.9
			if targetType=='vehicle' then
				occupant=getVehicleOccupant(target,0)
				doSkip=isVehicleBlown(target)
			end
			local r,g,b,a=getBlipColor(blip)
			if not (localP==occupant and airMode)
			and not (madeByHUD[blip] and (doSkip or occupant))
			and (localP~=target and a~=0 and ( not visDist or visDist>getDistanceBetweenPoints3D(px,py,pz,bx,by,bz) )) then
				local dist=getDistanceBetweenPoints2D(bx,by,px,py)
				local blipPointRot=0
				local id=getBlipIcon(blip)
				local path=elemData[blip][7]
				local blipRot=math.deg(-getVectorRotation(px,py,bx,by)-rot)-180
				local customBlipPath=elemData[blip][2]
				local text=elemData[blip][1]
				local textcolor
				if renderPickups and createTextsForPickups and targetType=='pickup' then
					local pType=getPickupType(target)
					path='images/blips/pickup'..pType..'.png'
					if type(text)~='string' then
						text=pType==2 and getWeaponNameFromID(getPickupWeapon(target))
					end
				end
				if id==0 then
					if pz<bz-5 then
						path='images/blips/'..id..'-up.png'
					elseif pz>bz+5 then
						path='images/blips/'..id..'-up.png'
						blipPointRot=180
					end
				end
				if type(customBlipPath)=='string' then
					path=customBlipPath
				end
				if (id==2 or id==3) and target then
					if targetType=='vehicle' then
						_,_,zRot=getElementRotation(target)
						blipPointRot=(360-zRot)+math.deg(rot)+45
					elseif targetType=='ped' or targetType=='player' then
						zRot=getPedRotation(target)
						blipPointRot=zRot-math.deg(rot)
					end
				end
				if text~=true then
					if type(text)=='string' then
						if targetType=='player' and (not (players[target]==0 or players[target]==nil)) then
							text=false
						elseif targetType=='player' then
							local pr,pg,pb=getPlayerNametagColor(target)
							textcolor=tocolor(pr,pg,pb,200)
						end
					else
						if targetType=='vehicle' and createTextsForVehicles then
							text=getVehicleName(target)
							setElementData(blip,'blipText',text)
						elseif targetType=='player' then
							if target==localP then
								text=true
							else
								text=getPlayerName(target)
							end
							setElementData(blip,'blipText',text,false)
							if type(text)=='string' then
								elemData[blip][9]=text:find('#%x%x%x%x%x%x')
							end
						end
					end
				end
				local maxSize=madeByHUD[blip] and size*0.91 or size*0.9
				local scrdist1,scrdist2=dist/radiusR*size,(visDist or getBlipVisibleDistance(blip))/radiusR*size
				local sRad=math.min(scrdist1,maxSize)
				if scrdist1+bSize>scrdist2 then
					bSize=scrdist2-scrdist1
				end
				local dx,dy=getPointFromDistanceRotation(x,y,sRad,blipRot)
				blipimages[#blipimages+1]={dx-bSize/2,dy-bSize/2,bSize,bSize,path,blipPointRot,tocolor(r,g,b,a)}
				if type(text)=='string' then
					local drawColored=elemData[blip][9]
					textcolor=textcolor or elemData[blip][8] or white2
					local textL=dxGetTextWidth(text:gsub('#%x%x%x%x%x%x',''),dxSize,dxFont)
					local dx,dy=getPointFromDistanceRotation(size*1.5,size*1.5,sRad,blipRot)
					local tbx,tby=dx+(textL/2),dy+(bSize/2+textH-1)
					if math.ceil(sRad)<maxSize then
						local textx,texty=math.ceil(dx-textL/2),math.ceil(dy+bSize/2)
						dxDrawRectangle(textx-1,texty+2,textL+2,textH-3,backgroundCol,false)
						if drawColored then
							dxDrawColorText(text,textx,texty,textx+textL,texty+textH,textcolor,dxSize,dxFont,'left','top',true,false,false)
						else
							dxDrawText(text,textx,texty,textx+textL,texty+textH,textcolor,dxSize,dxFont,'left','top',true,false,false)
						end
					end
				end
			end
		end
	end
end

function getBlips(blip)
	if not blip then
		if createBlipsForVehicles and doDrawRadar then
			for k,v in pairs(getElementsByType('vehicle')) do
				if not markedvehicles[v] then
					local blip=createBlipAttachedTo(v,2,1.4,255,255,255,255)
					madeByHUD[blip]=true
					markedvehicles[v]=true
					setElementData(blip,'customBlipPath','images/blips/pedvehicle.png')
					setBlipVisibleDistance(blip,400)
				end
			end
		else
			for k in pairs(madeByHUD) do
				local attachedto=getElementAttachedTo(k)
				if getElementType(attachedto)=='vehicle' then
					destroyElement(k)
					madeByHUD[k]=nil
					markedvehicles[attachedto]=nil
				end
			end
		end
		if createBlipsForPickups and doDrawRadar then
			for k,v in pairs(getElementsByType('pickup')) do
				if not markedpickups[v] then
					local blip=createBlipAttachedTo(v,1,1.3,255,255,255,255,-65000)
					madeByHUD[blip]=true
					markedpickups[v]=true
				end
			end
		else
			for k in pairs(madeByHUD) do
				local attachedto=getElementAttachedTo(k)
				if getElementType(attachedto)=='pickup' then
					destroyElement(k)
					madeByHUD[k]=nil
					markedpickups[attachedto]=nil
				end
			end
		end
		for blip in pairs(madeByHUD) do
			if isElement(blip) then
				local attachedto=getElementAttachedTo(blip)
				if attachedto and getElementType(attachedto)=='vehicle' then
					if createTextsForVehicles then
						setElementData(blip,'blipText',nil)
					else
						setElementData(blip,'blipText',true)
					end
				elseif attachedto and getElementType(attachedto)=='pickup' then
					if createTextsForPickups then
						setElementData(blip,'blipText',nil)
					else
						setElementData(blip,'blipText',true)
					end
				end
			else
				madeByHUD[blip]=nil
			end
		end
		blips = getElementsByType("blip")
	end
	for _,v in pairs(blip and {blip} or blips) do
		if not elemData[v] then
			elemData[v]={}
		end
		local path=getElementData(v,'customBlipPath')
		if not path then
			elemData[v][7]='images/blips/'..getBlipIcon(v)..'.png'
		else
			elemData[v][7]=path
		end
	end
end

function refreshHP()
	hp=getElementHealth(localP)*1.8/(1+math.max(getPedStat(localP,24)-569,0)/431)
	armor=getPedArmor(localP)*1.8
end

function drawHP()
	if raceMode and vehicle then
		hp=(getElementHealth(vehicle)-250)*0.24
		armor=0
	end
	local degr=360
	local hpTempCol
	if hp<=18 then
		local ticks=getTickCount()%600
		local red=ticks<=300 and 0 or 200
		hpTempCol=tocolor(red,0,0,255)
	end
	hpTempCol=hpTempCol or hpCol
	if armor~=0 then
		degr=degr-hp
		degr=degr-armor
	else
		degr=degr-hp*2
	end

	local currprog=0
	for n=0,6 do
		local val=180/2^n
		if math.ceil(val)<=degr then
			degr=degr-val
			currprog=currprog+val
			if degr>=360 then
				break
			end
		end
	end
end

function drawAir(pz)
	if (vehicle and (getVehicleType(vehicle)=='Plane' or getVehicleType(vehicle)=='Helicopter')) or parachute then
		airmode=true
		if pz>200 then
			pz=pz/5
		end
		local prog=math.max(0,math.min(1,pz/200))
		dxDrawRectangle(size*1.5,size/2,2,size2,airBackCol,false)
		dxDrawLine(size*1.5-28,math.floor(size*2.45-(size2*prog)),size*1.5+27,math.floor(size*2.45-(size2*prog)),normCol,1.5,false)
	else
		airmode=false
	end
end

function toogleHUD()
	doRender=not doRender
end

function weaponSwitch(_,slot)
	wslot=slot
	wepswitchtime=getTickCount()
	parachute=getPedWeapon(localP)==46
end

function weaponFire()
	wepswitchtime=getTickCount()
end

function drawRadio()
	if doDrawRadio and worthDrawingRadio and (vehicle or settingsOn) then
		local baseAlpha=math.min(255,700-(getTickCount()-radioSwitchTime)/radioFadeTime*700)
		if baseAlpha>0 then
			if startsetnewr then
				radioStartAt=lastOffX
				oldRadio=(oldRadio-lastrid)%13
				startsetnewr=false
				entering=false
			end
			local right=radioGoRight and -1 or 1
			local diff=0
			for n=1,13 do
				diff=diff+right
				if (oldRadio-n*right)%13==newRadio then break end
			end
			local prog=math.min((getTickCount()-radioSwitchTime)/radioSlideSpeed,1)
			local rid,offX=math.modf(radioStartAt*(1-prog)+diff*prog)
			if entering then
				rid,offX=0,0
			end
			for id=-radioSideIcons-1,radioSideIcons+1 do
				local xOff=(offX+id)*radioSize
				local alpha=(1-math.abs(xOff)/radioFadeGap)*255
				local radioID=(oldRadio-rid+id)%13
				if alpha>0 and radioID~=0 then
				end
			end
			if prog==1 and setnewr then
				radioStartAt=0
				oldRadio=newRadio
				setnewr=false
			end
			lastOffX,lastrid=offX,rid
		else
			entering=false
			worthDrawingRadio=false
		end
	end
end

function drawTexts(px,py,pz)
	if not doDrawInfo then return end
	local ticks=getTickCount()
	if vehicle and (ticks-5000<vehSwitchTime or ticks-10000<showTime) then
		dxDrawTextBordered(getVehicleName(vehicle),txtx,txty,txtx+160,txty+40,hpCol,2,1.3,'pricedown','center','top',true,true,posGUI)
	end
	if ticks-10000<showTime then
		dxDrawTextBordered(getZoneName(px,py,pz,false),txtx,txty+45,txtx+160,txty+80,normCol,1,1.1,'default-bold','center','top',false,false,posGUI)
		dxDrawTextBordered(getZoneName(px,py,pz,true),txtx,txty+57,txtx+160,txty+120,armorCol,1,1,'diploma','center','top',false,false,posGUI)
		local hrs,mins=getTime()
		local hrs,mins=tostring(hrs),tostring(mins)
		if #hrs==1 then hrs='0'..hrs end
		if #mins==1 then mins='0'..mins end
		dxDrawTextBordered(hrs..':'..mins,txtx,txty+85,txtx+160,txty+160,normCol,2,3,'default-bold','center','top',false,false,posGUI)
	end
end

function radioSwitch(_,_,forward)
	startsetnewr=true
	setnewr=true
	worthDrawingRadio=true
	radioGoRight=forward
	radioSwitchTime=getTickCount()
	newRadio=getRadioChannel()
end

function showAll()
	showTime=getTickCount()
	moneychangetime=showTime
	wepswitchtime=showTime
end

function checkForBlips()
	if markedvehicles[source] or markedpickups[source] then
		local attaches=getAttachedElements(source)
		for _,v in ipairs(attaches) do
			if madeByHUD[v] then
				destroyElement(v)
			end
		end
	end
end

function createRoundRadarArea(ax,ay,aradius,r,g,b,a)
	if not (tonumber(ax) or tonumber(ay) or tonumber(aradius)) then return false end
	local new=source or createElement('roundradararea')
	roundAreas[new]={r or 255,g or 255,b or 255,a or 150}
	roundRadarAreaDimensions(new,ax,ay,aradius)
	addEventHandler('onClientElementDestroy',new,function()
		roundAreas[source]=nil
	end)
	return new
end

function roundRadarAreaDimensions(area,ax,ay,aradius)
	if not roundAreas[area] then return false end
	if tonumber(ax) and tonumber(ay) and tonumber(aradius) then
		roundAreas[area][10],roundAreas[area][11],roundAreas[area][12]=ax,ay,aradius
		return true
	else
		return roundAreas[area][10],roundAreas[area][11],roundAreas[area][12]
	end
end

function roundRadarAreaFlashing(area,interval,r,g,b,a,easetype,easeperiod,easeamplitude,easeovershoot)
	if not roundAreas[area] then return false end
	if interval then
		roundAreas[area][5],roundAreas[area][6],roundAreas[area][7],roundAreas[area][8],roundAreas[area][9],roundAreas[area][13],roundAreas[area][14],roundAreas[area][15],roundAreas[area][16]=interval,r,g,b,a,easetype,easeperiod,easeamplitude,easeovershoot
		return true
	else
		return roundAreas[area][5],roundAreas[area][6],roundAreas[area][7],roundAreas[area][8],roundAreas[area][9],roundAreas[area][13],roundAreas[area][14],roundAreas[area][15],roundAreas[area][16]
	end
end

function roundRadarAreaColor(area,r,g,b,a)
	if not roundAreas[area] then return false end
	if tonumber(r) and tonumber(g) and tonumber(b) then
		roundAreas[area][1],roundAreas[area][2],roundAreas[area][3],roundAreas[area][4]=r,g,b,tonumber(a) or 150
		return true
	else
		return roundAreas[area][1],roundAreas[area][2],roundAreas[area][3],roundAreas[area][4]
	end
end

function isElementInRoundRadarArea(element,area)
	if not (roundAreas[area] or isElement(element)) then return false end
	local ex,ey=getElementPosition(element)
	local ax,ay,arad=roundAreas[area][10],roundAreas[area][11],roundAreas[area][12]
	return getDistanceBetweenPoints2D(ex,ey,ax,ay)<=arad
end

function getElementsInRoundRadarArea(area,elemtype)
	if not roundAreas[area] then return false end
	local ax,ay,arad=roundAreas[area][10],roundAreas[area][11],roundAreas[area][12]
	local colcircle=createColCircle(ax,ay,arad)
	local elems=getElementsWithinColShape(colcicle,elemtype)
	destroyElement(colcircle)
	return elems
end

addEvent('onServerCreateRoundArea',true)
addEvent('onServerChangeRoundAreaDimensions',true)
addEvent('onServerChangeRoundAreaFlashing',true)
addEvent('onServerChangeRoundAreaColor',true)
addEventHandler('onClientElementDestroy',root,checkForBlips)
addEventHandler('onServerCreateRoundArea',root,createRoundRadarArea)
addEventHandler('onServerChangeRoundAreaDimensions',root,roundRadarAreaDimensions)
addEventHandler('onServerChangeRoundAreaFlashing',root,roundRadarAreaFlashing)
addEventHandler('onServerChangeRoundAreaColor',root,roundRadarAreaColor)
addEventHandler('onClientPlayerWeaponFire',root,weaponFire)
addEventHandler('onClientPlayerWeaponSwitch',root,weaponSwitch)
addEventHandler('onClientResourceStart',resRoot,onStart)
addEventHandler('onClientResourceStop',resRoot,onStop)
local race=getResourceFromName('race')
if race then
	addEvent('onClientMapStarting',true)
	addEventHandler('onClientMapStarting',getResourceRootElement(race),onRaceStart)
	addEventHandler('onClientResourceStop',getResourceRootElement(race),onRaceStop)
end
addEventHandler('onClientPlayerDamage',localP,ultilizeDamageScreen)
addEventHandler('onClientElementDataChange',root,refreshElementData)
addEventHandler('onClientPlayerVehicleEnter',localP,vehEnter)
addEventHandler('onClientPlayerVehicleStartExit',localP,vehExit)
