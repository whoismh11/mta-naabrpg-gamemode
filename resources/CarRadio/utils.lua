volume = 10

function VehicleRadio(vehicle)	
	setRadioChannel(0)
	setPlayerHudComponentVisible("radio",false)
	if isElement(vehicle) and getElementType(vehicle) == "vehicle" then
		local music = getElementData(vehicle,"music:attach")
		if isElement(music) then
			destroyElement(music)
		end
		local x,y,z = getElementPosition(vehicle)
		local id = getElementData(vehicle,"music:id") or 0
		if playlist[id] then
			local music = playSound3D(playlist[id][2],x,y,z)
			setSoundMaxDistance(music,50)
			attachElements(music,vehicle)
			setElementData(vehicle,"music:attach",music,false)
			setSoundVolume(music,volume * 1 / 10)
		end
	end
end

addEventHandler("onClientElementDataChange",getRootElement(),
	function(dataName,oldValue)
		if getElementType(source) == "vehicle" and dataName == "music:id" then
			if isElementStreamedIn(source) then
				VehicleRadio(source)
			end
		end
	end
);

addEventHandler("onClientElementStreamIn",getRootElement(),
    function()
        if getElementType(source) == "vehicle" then
			VehicleRadio(source) 
        end
    end
);

addEventHandler( "onClientElementStreamOut",getRootElement(),
	function()
		if getElementType(source) == "vehicle" then
			local music = getElementData(source,"music:attach")
			if isElement(music) then
				destroyElement(music)
			end
        end
    end
);

addEventHandler("onClientVehicleExplode",getRootElement(), 
	function()
		local music = getElementData(source,"music:attach")
		if isElement(music) then
			destroyElement(music)
		end
	end
);

addEventHandler("onClientVehicleExplode",getRootElement(), 
	function()
		local music = getElementData(source,"music:attach")
		if isElement(music) then
			destroyElement(music)
		end
	end
);

addEventHandler("onClientElementDestroy",getRootElement(), 
	function()
		if getElementType(source) == "vehicle" then
			local music = getElementData(source,"music:attach")
			if isElement(music) then
				destroyElement(music)
			end
		end
	end
);
