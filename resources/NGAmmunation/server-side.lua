addEvent ( "Ammunation:onClientBuyWeapon", true )
addEventHandler ( "Ammunation:onClientBuyWeapon", root, function ( name, id, price )
	if ( getPlayerMoney ( source ) >= price ) then
		takePlayerMoney ( source, price )
		if ( id ) then	
			if ( id ~= 16 and id ~= 39 ) then
				outputChatBox ( name.." hamrahe 600 golole be gheymate $"..tostring ( price ).." kharidari shod!", source, 0, 255, 0 )
				giveWeapon ( source, id, 600, true )
			else
				outputChatBox ( "do adad "..name.." be gheymate $"..tostring ( price ).." kharidari shod!", source, 0, 255, 0 )
				giveWeapon ( source, id, 2, true )
				--[[if ( id == 39 ) then
					giveWeapon ( source, 40, 999999 ) -- donno why but it's bugged  :C
				end]]
			end
		else
			outputChatBox ( name.." be gheymate $"..tostring ( price ).." kharidari shod!", source, 0, 255, 0 )
			setPedArmor ( source, 100 )
		end
	else
		outputChatBox ( "Shoma tavanayie kharide "..name.." ra nadarid!", source, 255, 0, 0 )
	end
end )

function outputChatBox ( m, p, r, g, b )
	return exports.NGMessages:sendClientMessage ( m, p, r, g, b )
end
