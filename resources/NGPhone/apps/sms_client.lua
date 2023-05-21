addEvent ( "NGPhone:App.SMS:OnPlayerReciveMessage", true )
addEventHandler ( "NGPhone:App.SMS:OnPlayerReciveMessage", root, function ( from, message )
	local second, minute, hour = getThisTime ( )
	exports['NGMessages']:sendClientMessage ( getPlayerName ( from ).." be shoma peygham ersal kard! Az F3 -> SMS baraye didane aan estefade konid.", 0, 255, 0 )
	playSound ( "audio/sms_alert.mp3" )
	if ( not pages['sms'].sMessages[from] ) then
		pages['sms'].sMessages[from] = ""
	end
	local message = "["..table.concat({hour,minute,second},":").."] Az: "..message.."\n"
	pages['sms'].sMessages[from] = pages['sms'].sMessages[from]..message
	if ( pages['sms'].selectedPlayer == from ) then
		guiSetText ( pages['sms'].messages, pages['sms'].sMessages[from] )
	end
	pages['sms'].fromLast = from
	
end )

function sms_reply ( cmd, ... )
	if pages['sms'].fromLast and isElement ( pages['sms'].fromLast ) then
		if ... then
			local msg = table.concat ( { ... }, " " )
			triggerServerEvent ( "NGPhone:App.SMS:SendPlayerMessage", localPlayer, pages['sms'].fromLast, msg )
			exports['NGMessages']:sendClientMessage ( "Peygham be "..tostring ( getPlayerName ( pages['sms'].fromLast ) ).." ersal shod!", 0, 255, 0 )
		else
			exports['NGMessages']:sendClientMessage ( "Format: /"..cmd.." [message]", 255, 255, 0 )
		end
	else
		exports['NGMessages']:sendClientMessage ( "Akharin ferestandeye payame daryaftie shoma digar vojod nadarad.", 255, 255, 0 )
	end
end
addCommandHandler ( 're', sms_reply )
addCommandHandler ( 'reply', sms_reply )
