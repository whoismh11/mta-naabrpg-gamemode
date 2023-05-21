addEvent ( 'NGPhone:App.SMS:SendPlayerMessage', true )
addEventHandler ( 'NGPhone:App.SMS:SendPlayerMessage', root, function ( who, message )
	if ( who and isElement ( who ) ) then
		triggerClientEvent ( who, 'NGPhone:App.SMS:OnPlayerReciveMessage', who, source, message )
		exports['NGLogs']:outputChatLog ( "Phone:SMS", "Az "..getPlayerName(source).." | Be: "..getPlayerName(who).." | Peygham: "..message )
	end
end )
