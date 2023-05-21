local shops = {
	{ 1928.92, -2294.31, 13.55 },
	{ 1041.46, -1016.23, 32.11 },
	{ 2645.03, -2044.31, 13.64 },
	{ -1297.07, -240.16, 14.14 },
	{ -2723.11, 217.24, 4.48 },
	{ -1787.24, 1215.26, 25.13 },
	{ -1936.64, 246.25, 34.46 },
	{ 1329.75, 1487.58, 10.82 },
	{ 2386.67, 1052.13, 10.82 },
	{ 356.63, 2540.61, 16.71 },
}

local pnsBlips = { }
setTimer ( function ( )
	local createBlips = exports['NGPhone']:getSetting ( "usersetting_display_modshopblips" )
	for i, v in ipairs ( shops ) do
		local x, y, z = unpack ( v )
		local z = z - 3
		addEventHandler ( 'onClientMarkerHit', createMarker ( x, y, z, 'cylinder', 5, 0, 255, 0, 140 ), function ( p ) 
			if ( p == localPlayer ) then
				triggerServerEvent ( "NGShops:Module->PNS:onClientHitShop", localPlayer, localPlayer )
			end
		end )
		if ( createBlips ) then 
			pnsBlips[i] = createBlip ( x, y, z, 27, 2, 255, 255, 255, 255, 0, 450 ) 
		end
	end
end, 500, 1 )

addEvent ( "onClientUserSettingChange", true )
addEventHandler ( "onClientUserSettingChange", root, function ( g, v )
	if ( g == "usersetting_display_modshopblips" ) then
		for i, v in pairs ( pnsBlips ) do
			destroyElement ( pnsBlips [ i ] )
			pnsBlips [ i ] = nil
		end
		
		if v then
			for i, v2 in pairs ( shops ) do
				local x, y, z= unpack ( v2 )
				pnsBlips[i] = createBlip ( x, y, z, 27, 2, 255, 255, 255, 255, 0, 450 ) 
			end
		end
	end
end )
