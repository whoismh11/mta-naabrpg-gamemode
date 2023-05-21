addCommandHandler( "poop",
	function( plr )	
		if getElementData(plr,"tazepoop") ~= true then
		
			for _,p in ipairs (getElementsByType("player")) do
				triggerClientEvent("syncSong", resourceRoot, plr)
			end
			
			setElementData(plr,"tazepoop",true)
			x, y, z = getElementPosition( plr )
			setPedAnimation( plr, "ped", "cower", 3000, false, true, false )
			local int =  getElementInterior(plr)
			local dim = getElementDimension ( plr )
			PP = createObject ( 2814, x, y, z-0.8, 0, 0, 180 )
			setElementDimension(PP,dim)
			setElementInterior(PP,int)
			
			setTimer( function ( )
				destroyElement( PP )
				setElementData(plr,"tazepoop",nil)
			end, 600000, 1)
		end
	end
)
