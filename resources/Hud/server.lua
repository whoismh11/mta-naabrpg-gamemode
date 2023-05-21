local roundAreas={}
local root=getRootElement()
local res=getResourceRootElement()

addEventHandler("onResourceStart",res,function()
	roundAreas=getElementData(root,"roundareadata") or {}
	setElementData(root,"roundareadata",nil)
end)

addEventHandler("onResourceStop",res,function()
	setElementData(root,"roundareadata",roundAreas)
end)

function createRoundRadarArea(ax,ay,aradius,r,g,b,a)
	if not (tonumber(ax) or tonumber(ay) or tonumber(aradius)) then return false end
	local new=createElement("roundradararea")
	roundAreas[new]={r or 255,g or 255,b or 255,a or 150}
	roundRadarAreaDimensions(new,ax,ay,aradius)
	addEventHandler("onClientElementDestroy",new,function()
		roundAreas[source]=nil
	end)
	triggerClientEvent(root,"onServerCreateRoundArea",new,ax,ay,aradius,r,g,b,a)
	return new
end

function roundRadarAreaDimensions(area,ax,ay,aradius)
	if not roundAreas[area] then return false end
	if tonumber(ax) and tonumber(ay) and tonumber(aradius) then
		roundAreas[area][10],roundAreas[area][11],roundAreas[area][12]=ax,ay,aradius
		triggerClientEvent(root,"onServerChangeRoundAreaDimensions",area,area,ax,ay,aradius)
		
		return true
	else
		return roundAreas[area][10],roundAreas[area][11],roundAreas[area][12]
	end
end

function roundRadarAreaFlashing(area,interval,r,g,b,a,easetype,easeperiod,easeamplitude,easeovershoot)
	if not roundAreas[area] then return false end
	if interval then
		roundAreas[area][5],roundAreas[area][6],roundAreas[area][7],roundAreas[area][8],roundAreas[area][9],roundAreas[area][13],roundAreas[area][14],roundAreas[area][15],roundAreas[area][16]=interval,r,g,b,a,easetype,easeperiod,easeamplitude,easeovershoot
		triggerClientEvent(root,"onServerChangeRoundAreaFlashing",area,area,interval,r,g,b,a,easetype,easeperiod,easeamplitude,easeovershoot)
		return true
	else
		return roundAreas[area][5],roundAreas[area][6],roundAreas[area][7],roundAreas[area][8],roundAreas[area][9],roundAreas[area][13],roundAreas[area][14],roundAreas[area][15],roundAreas[area][16]
	end
end

function roundRadarAreaColor(area,r,g,b,a)
	if not roundAreas[area] then return false end
	if tonumber(r) and tonumber(g) and tonumber(b) then
		roundAreas[area][1],roundAreas[area][2],roundAreas[area][3],roundAreas[area][4]=r,g,b,tonumber(a) or 150
		triggerClientEvent(root,"onServerChangeRoundAreaColor",area,area,r,g,b,a)
		return true
	else
		return roundAreas[area][1],roundAreas[area][2],roundAreas[area][3],roundAreas[area][4]
	end
end

function isElementInRoundRadarArea(element,area)
	if not (roundAreas[area] or isElement(element)) then return nil end
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
