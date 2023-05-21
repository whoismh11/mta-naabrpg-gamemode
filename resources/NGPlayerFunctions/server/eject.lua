function print ( msg, p, r, g, b )
	return exports.NGMessages:sendClientMessage ( msg, p, r, g, b )
end

function ejectPlayer ( p, _, nab )
	if nab	then
		if isPedInVehicle ( p )	then
			if getPedOccupiedVehicleSeat ( p ) == 0	then
			local ej = getPlayerFromNamePart ( nab )
			local veh = getPedOccupiedVehicle ( p )
				if ej	then
					if ej ~= p	then
						if getPedOccupiedVehicle ( ej ) == veh	then
						removePedFromVehicle ( ej )
						print ( "Shoma "..getPlayerName(ej).." ra az vasileye naghlie biron kardid!", p, 255, 255, 0, true, 8 )
						print ( "Shoma az vasileye naghlie biron andakhte shodid, tavasote "..getPlayerName(p), ej, 255, 255, 0, true, 8 )
						else print ( nab.." dar vasileye naghlie nist", p, 255, 255, 0, true, 8 )
						end
					else print ( "Shoma nemitavanid khod ra biron konid.", p, 255, 255, 0, true, 8 )
					end
				else print ( nab.." dar vasileye naghlie nist", p, 255, 255, 0, true, 8 )
				end
			else print ( "Shoma ranandeye vasileye naghlie nistid", p, 255, 255, 0, true, 8 )
			end
		else print ( "Shoma dar vasileye naghlie nistid", p, 255, 255, 0, true, 8 )
		end
	else print ( "/eject [player]", p, 255, 255, 0, true, 8 )
	end
end
addCommandHandler ( "eject", ejectPlayer )
