addEvent ( "NGPhone:App.Money:sendPlayerMoney", true )
addEventHandler ( "NGPhone:App.Money:sendPlayerMoney", root, function ( p, amount )
	if ( getPlayerMoney ( source ) < amount ) then
		return exports['NGMessages']:sendClientMessage ( "Shoma in meghdar pool ra nadarid.", source, 255, 0, 0 )
	end
	if ( isElement ( p ) ) then
		exports['NGMessages']:sendClientMessage ( "Darhale ersal $"..amount.." be "..getPlayerName ( p ).."!", source, 0, 255, 0 )
		exports['NGMessages']:sendClientMessage ( getPlayerName ( source ).." mablaghe $"..amount.." be shoma ersal kard!", p, 0, 255, 0 )
		takePlayerMoney ( source, amount ) 
		givePlayerMoney ( p, amount )
		
		local acc1 = getAccountName ( getPlayerAccount ( source ) )
		local acc2 = getAccountName ( getPlayerAccount ( p ) )
		exports['NGLogs']:outputActionLog ( getPlayerName ( source ).."("..acc1..") sent "..getPlayerName(p).."("..acc2..") $"..amount )
	end
end )
