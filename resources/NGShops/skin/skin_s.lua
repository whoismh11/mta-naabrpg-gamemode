addEvent ( "NGShops:Skins:ResetPlayerSkin", true )
addEventHandler ( "NGShops:Skins:ResetPlayerSkin", root, function ( )
	setElementModel ( source, getElementModel ( source ) ) 
end )

addEvent ( "NGShops:Skin:UpdatePlayerDefaultSkin", true )
addEventHandler ( "NGShops:Skin:UpdatePlayerDefaultSkin", root, function ( s )
	takePlayerMoney ( source, 250 )
	exports.NGMessages:sendClientMessage ( "Shoma skin jadid kharidari kardid!", source, 0, 255, 0 )
	local cur = tonumber ( getElementData ( source, "NGUser.UnemployedSkin" ) ) or 16
	setElementData ( source, "NGUser.UnemployedSkin", s )
	local t = getPlayerTeam ( source )
	if ( getElementModel ( source ) == cur ) then
		setElementModel ( source, s )
	else
		exports.NGMessages:sendClientMessage ( "Baraye taghire skin khod, az shoghl khod estefa dahid (/resign)", source, 255, 255, 0 )
	end
end )
