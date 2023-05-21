local max_time = 30		-- Minutes

setTimer ( function ( )
	local max_milsecs = ( max_time * 60 ) * 1000
	for i, v in pairs ( getElementsByType ( "player" ) ) do
		if ( not exports.NGAdministration:isPlayerStaff ( v ) ) then
			local idle = getPlayerIdleTime ( v )
			if ( idle > max_milsecs ) then
				kickPlayer ( v, "Shoma AFK shenasayi shodid va besoorate khodkar az server kick shodid! Dobare be server join shavid." )
			elseif ( idle > max_milsecs ) then
				exports.NGMessages:sendClientMessage ( "Lotfan harekat konid, dar gheyre in soorat shoma ".. math.floor ( ( max_milsecs - idle ) / 1000 ).." saniye dige be dalile AFK boodan kick mishavid.", v, 255, 0, 0 ) 
			end
		end
	end
end, 5000, 0 )
