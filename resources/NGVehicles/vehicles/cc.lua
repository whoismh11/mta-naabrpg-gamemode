addCommandHandler ( "cc", function ( p, _, ... )
	if ( isPlayerMuted ( p ) ) then
		return exports['NGMessages']:sendClientMessage ( "Vaghti ke shoma mute bashid in dastoor gheyre faal mishavad.", p, 255, 0, 0 )
	end
	if ( isPedInVehicle ( p ) ) then
		if ( ... ) then
			local car = getPedOccupiedVehicle ( p )
			if ( car ) then
				local msg = table.concat ( { ... }, " " )
				local pN = exports['NGChat']:getPlayerTags(p)..getPlayerName(p):gsub ( "#%x%x%x%x%x%x", "" )
				outputChatBox ( "(CC)"..pN..": #ffffff"..msg, p, 255, 0, 130, true )
				for seat, player in ipairs ( getVehicleOccupants ( car ) ) do
					outputChatBox ( "(CC)"..pN..": #ffffff"..msg, player, r, g, b, true )
				end
			end
		else
			outputChatBox ( "Syntax: /cc [message]", p, 255, 0, 100 )
		end
	else
		outputChatBox ( "Shoma dar vasileye naghlie nistid.", p, 255, 0, 100 )
	end
end )
