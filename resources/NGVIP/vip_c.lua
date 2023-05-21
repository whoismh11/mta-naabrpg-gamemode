function isPlayerVIP ( )
	return tostring ( getElementData ( localPlayer, "VIP" ) ):lower ( ) ~= "none"
end 

function getVipLevelFromName ( l )
	local levels = { ['none'] = 0, ['Boronz'] = 1, ['Noghre'] = 2, ['Tala'] = 3, ['Almas'] = 4 }
	return levels[l:lower()] or 0;
end
