-- This script applies shader effects to game textures.

--------------------------------------------------------------------------------------------------
-- settings
---------------------------------------------------------------------------------------------------

-- the orange shell effect applied to the grabbed elements
local isShellFxEnabled = true
local shaderCreateMaxDist = 70

-- effect table
local texPathTable = {
 
                   { shadPath = "texRepTra.fx", priority = 3, maxDist = 60, element = "ped",  texList = {"w_physics_sheet" }, pendulumSpeed = 0, wobbleSpeed = -0.5, wobbleSize = 0.75, wobbleDensity = 12.5 },
                   { shadPath = "texRepTra.fx", priority = 3, maxDist = 60, element = "ped",  texList = {"v_physcannon_sheet1" }, pendulumSpeed = 0, wobbleSpeed = 0, wobbleSize = 0, wobbleDensity = 12.5 },
                   { shadPath = "texRepTra.fx", priority = 3, maxDist = 60, element = "ped",  texList = {"v_physcannon_sheet" }, pendulumSpeed = 0, wobbleSpeed = -0.5, wobbleSize = 0.75, wobbleDensity = 12.5 },
                   { shadPath = "texRep.fx", priority = 0, maxDist = 0, element = "world",  texList = {"shotgspaicon" }, texPath = "shotgspaicon.png", pendulumSpeed = 0, wobbleSpeed = 0, wobbleSize = 0, wobbleDensity = 0 }				   
				    }

-- object replace id
local ReplacedModelID = 351
					
-- shaders and textures will be stored here
local applyTable = {}

---------------------------------------------------------------------------------------------------
-- main functions
---------------------------------------------------------------------------------------------------
local enWorldEffectEnabled = false

local isShaderError = nil   
function startCustomTextures()
	if enWorldEffectEnabled or isShaderError then return end
	local texNo = 0
	for id, this in ipairs(texPathTable) do
		applyTable[id] = {}
		applyTable[id].shader = dxCreateShader ( "shaders/"..this.shadPath, this.priority , this.maxDist, false, this.element )
		if applyTable[id].shader then
			dxSetShaderValue ( applyTable[id].shader, "wobbleSpeed",this.wobbleSpeed )
			dxSetShaderValue ( applyTable[id].shader, "wobbleSize",this.wobbleSize )
			dxSetShaderValue ( applyTable[id].shader, "wobbleDensity",this.wobbleDensity ) -- 100 50 25 12.5 6.25  3.125
		end
		dxSetShaderValue ( applyTable[id].shader, "pendulumSpeed", this.pendulumSpeed )	
		if not applyTable[id].shader then
			outputDebugString('GGun: Out of memory error. Some things not initialized properly.',255,30,0)
			stopCustomTextures()
			isShaderError = true
			return 
		end  
		if not applyTable[id].texture and this.texPath then
			applyTable[id].texture = dxCreateTexture ( "textures/"..this.texPath)
			dxSetShaderValue ( applyTable[id].shader, "gTexture", applyTable[id].texture )
		end
		for _,texName in ipairs(this.texList) do
			engineApplyShaderToWorldTexture ( applyTable[id].shader, texName )
			texNo = texNo + 1
			outputDebugString('Applied shader id: '..id..' to texture: '..texName )
		end

	end
	outputDebugString('Number of textures replaced: '..texNo)
	enWorldEffectEnabled = true
end
	
function stopCustomTextures()
	if not enWorldEffectEnabled or isShaderError then return end
	for id, this in ipairs(texPathTable) do
		if applyTable[id] then 
			for _,texName in ipairs(this.texList) do
				engineRemoveShaderFromWorldTexture ( applyTable[id].shader, texName )
				outputDebugString('Removed shader id: '..id..' from texture: '..texName )
			end
			if applyTable[id].shader then
				if isElement(applyTable[id].shader) then 
					destroyElement(applyTable[id].shader)
					applyTable[id].shader = nil
				end
			end
			if applyTable[id].texture then 
				if isElement(applyTable[id].texture) then
					destroyElement(applyTable[id].texture)
					applyTable[id].texture = nil
				end
			end
			applyTable[id] = nil
		else
			outputDebugString('Shader id: '..id..' error')
		end
	end
	enWorldEffectEnabled = false	
end		

---------------------------------------------------------------------------------------------------
-- onClientResourceStart 
---------------------------------------------------------------------------------------------------
local ggunModel = { txd = nil, dff = nil } 		
addEventHandler("onClientResourceStart", getResourceRootElement( getThisResource()), function()
	ggunModel.txd = engineLoadTXD( "textures/ggun.txd" )
	ggunModel.dff = engineLoadDFF( "models/ggun.dff", 0 )
	engineImportTXD( ggunModel.txd, ReplacedModelID )
	engineReplaceModel( ggunModel.dff, ReplacedModelID )
	startCustomTextures()
end
)

addEventHandler("onClientResourceStop", getResourceRootElement( getThisResource()), function()
	stopCustomTextures()
	engineRestoreModel(ReplacedModelID)
	if ggunModel.txd then
		if isElement(ggunModel.txd) then
			destroyElement(ggunModel.txd)
			ggunModel.txd = nil
		end
	end
	if ggunModel.dff then
		if isElement(ggunModel.dff) then
			destroyElement(ggunModel.dff)
			ggunModel.dff = nil
		end
	end
	if renderTimeTimer then
		if isTimer(renderTimeTimer) then
			killTimer(renderTimeTimer)
			renderTimeTimer = nil
		end
	end
end
)

---------------------------------------------------------------------------------------------------
-- shell effect
---------------------------------------------------------------------------------------------------
local shellTable = {}

function ggShellManage(PPlayer,PObject,isCreate)
	if not isShellFxEnabled then return end
	if isCreate then
		if not shellTable.shader then
			shellTable.shader = dxCreateShader("shaders/texShell.fx",0,60,true,"ped,vehicle")
			shellTable.texture = dxCreateTexture("textures/shell.jpg")
			dxSetShaderValue(shellTable.shader,"gTextureShell",shellTable.texture)
			outputDebugString("Created shell shader for gravity_gun")
		end
		if isElement(PObject) and isElement(PPlayer) and isElement(shellTable.shader) then
			shellTable[PPlayer] = {}
			shellTable[PPlayer].object = PObject
			shellTable[PPlayer].isOn = true
			shellTable[PPlayer].isApplied = false
		end
	else
		if isElement(PPlayer) then
			if shellTable[PPlayer] then
				if isElement(shellTable[PPlayer].object) and isElement(shellTable.shader) then
					shellTable[PPlayer].isOn = false	
				end
			end
		end
	end
end

addEventHandler("onClientRender",root,function()
	if not shellTable.shader then return end
	for index,this in ipairs(getElementsByType("player")) do
		if shellTable[this] then
			if shellTable[this].isOn then
				if shellTable[this].isApplied==false and isElementStreamedIn(shellTable[this].object) then
					local x1,y1,z1 = getElementPosition(this)
					local cx,cy,cz = getCameraMatrix()
					if getDistanceBetweenPoints3D(x1,y1,z1,cx,cy,cz)<shaderCreateMaxDist then 		
						engineApplyShaderToWorldTexture(shellTable.shader,"*",shellTable[this].object)
						engineRemoveShaderFromWorldTexture(shellTable.shader,"muzzle_*",shellTable[this].object)
						engineRemoveShaderFromWorldTexture(shellTable.shader,"dodo92prop64black",shellTable[this].object)
						engineRemoveShaderFromWorldTexture(shellTable.shader,"cargobobrotorblack128",shellTable[this].object)
						engineRemoveShaderFromWorldTexture(shellTable.shader,"unnamed",shellTable[this].object)
						shellTable[this].isApplied = true
					end
				else
					local x1,y1,z1 = getElementPosition(this)
					local cx,cy,cz = getCameraMatrix()
					if isElement(shellTable[this].object) then
						if getDistanceBetweenPoints3D(x1,y1,z1,cx,cy,cz)>shaderCreateMaxDist then
							engineRemoveShaderFromWorldTexture(shellTable.shader,"*",shellTable[this].object)
							shellTable[this].isApplied = false
						end
					end
				end	
			else
				if shellTable[this].isApplied==true and ((shellTable[this].isOn==false) or not isElementStreamedIn(shellTable[this].object)) then
					engineRemoveShaderFromWorldTexture(shellTable.shader,"*",shellTable[this].object)
					shellTable[this].isApplied = false
				end
			end
		end
	end
end
)

addEvent("onGGShell",true)
addEventHandler("onGGShell",getResourceRootElement(getThisResource()),ggShellManage)

---------------------------------------------------------------------------------------------------
-- additional stuff for nightMod 
---------------------------------------------------------------------------------------------------
-- static
local nightVisionAdd = 0.3
local carlightAdd = 0.10
local standardAdd = 0.02
-- dynamic
local isGoogleOn = false
local isFlashlightOn = false
local isCarlightOn = false

local tempVis = 0.0

function countRenderTime()
	if renderTimeTimer then return end
	renderTimeTimer = setTimer( function()
		if not enWorldEffectEnabled then return end
		local hour, minute = getTime()
			
		if hour < 6 then dawn_aspect=0 end 
		if hour <= 6 and hour >= 5 then dawn_aspect = (((hour-5)*60+minute))/120 end
		if hour > 6 and hour < 20 then dawn_aspect = 1 end
		if hour>=20  then dawn_aspect = -6*((((hour-20)*60)+minute)/1440)+1 end
			
		tempVis = standardAdd
		if isFlashlightOn or isCarlightOn then tempVis = carlightAdd end
		if isGoogleOn then tempVis = nightVisionAdd end
			
		local outValue = math.min(dawn_aspect + tempVis, 1)  -- 0.1
		local gbrightness = math.min(dawn_aspect + 0.05 + tempVis, 1) -- 0.15
			
		for id, this in ipairs(applyTable) do
			dxSetShaderValue( this.shader,"gDayTime", outValue)
			dxSetShaderValue( this.shader,"gBrightness", gbrightness)
		end
	end ,200,0)	
end


addEventHandler("onClientResourceStart", root, function(startedResName)
	local resource_name = tostring(getResourceName(startedResName))
	if resource_name == "dynamic_lighting_nightMod" then
		countRenderTime()
	end
end
)

addEventHandler("onClientResourceStop", root, function(startedResName)
	local resource_name = tostring(getResourceName(startedResName))
	if resource_name == "dynamic_lighting_nightMod" then
		if not renderTimeTimer then return end
		killTimer(renderTimeTimer)
		renderTimeTimer = nil
		if not enWorldEffectEnabled then return end
		for id, this in ipairs(applyTable) do
			dxSetShaderValue( this.shader,"gDayTime", 1)
			dxSetShaderValue( this.shader,"gBrightness", 1)
		end		
	end
end
)

addEventHandler("onClientResourceStart", getResourceRootElement( getThisResource()), function()
	local this_resource =  getResourceFromName ("dynamic_lighting_nightMod")
	if this_resource then
		if getResourceState (this_resource)=="running" then
			countRenderTime()
		end
	end
end
)

addEvent( "switchFlashLight", true )
addEventHandler( "switchFlashLight", root, function(isOn) isFlashlightOn = isOn end)
addEvent( "switchGoogleNM", true )
addEventHandler( "switchGoogleNM", root, function(isOn) isGoogleOn = isOn end)
addEvent( "switchCarLightNM", true )
addEventHandler( "switchCarLightNM", root, function(isOn) isCarlightOn = isOn end)
