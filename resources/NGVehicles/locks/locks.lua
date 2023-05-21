addCommandHandler ( "lock", function ( p )
	local acc = getPlayerAccount ( p )
	if ( isGuestAccount ( acc ) ) then
		return exports['NGMessages']:sendClientMessage ( "Baraye estefade az in dastoor lotfan login konid.", p, 255, 0, 0 )
	end
	
	local acc = getAccountName ( acc )
	local x, y, z = getElementPosition ( p )
	for i, v in pairs ( vehicles ) do 
		if ( getElementData ( v, "NGVehicles:VehicleAccountOwner" ) == acc ) then 
			local dist = getDistanceBetweenPoints3D ( x, y, z, getElementPosition ( v ) )
			if ( dist <= 30 ) then
				setVehicleOverrideLights ( v, 2 )
				triggerClientEvent ( root, "NVehicles:playLockSoundOnVehicle", root, v )
				local locked = isVehicleLocked ( v )
				setVehicleLocked ( v, not locked )
				local name = getVehicleNameFromModel ( getElementModel ( v ) )
				if locked then
					exports['NGMessages']:sendClientMessage ( "Shoma "..name.." khod ra baz kardid", p, 0, 255, 0 )
					exports['NGLogs']:outputActionLog ( getPlayerName ( p ).." "..name.." khod ra baz kard" )
				else
					exports['NGMessages']:sendClientMessage ( "Shoma "..name.." khod ra ghofl kardid", p, 255, 255, 0 )
					exports['NGLogs']:outputActionLog ( getPlayerName ( p ).." "..name.." khod ra ghofl kard" )
				end
				setTimer ( function ( v )
					setVehicleOverrideLights ( v, 1 )
					
					setTimer ( function ( v )
						setVehicleOverrideLights ( v, 2 )
						triggerClientEvent ( root, "NVehicles:playLockSoundOnVehicle", root, v )
						setTimer ( function ( v )
							setVehicleOverrideLights ( v, 1 )
						end, 300, 1, v )
						
					end, 300, 1, v )
					
				end, 300, 1, v )
				return true, not locked
			end
		end
	end
	exports['NGMessages']:sendClientMessage ( "Hich vasileye naghliei dar in atraf nemibashad.", p, 255, 255, 0 )
	return false, nil
end )
