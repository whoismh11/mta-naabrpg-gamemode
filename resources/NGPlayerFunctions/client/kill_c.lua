local isDx = false
local sx,sy = guiGetScreenSize ( )
remainingTimeK = 5
l_tick = getTickCount ( )

function dxDrawKill ( )
	isDx = true
	dxDrawText ( "Shoma "..tostring ( remainingTimeK ).. " saniye dige mimirid", 0, 0, (sx/1.1)+2, (sy/1.1)+2, tocolor ( 0, 0, 0, 255 ), 2.5, 'default-bold', 'right', 'bottom' )
	dxDrawText ( "Shoma "..tostring ( remainingTimeK ).. " saniye dige mimirid", 0, 0, sx/1.1, sy/1.1, tocolor ( 255, 255, 0, 255 ), 2.5, 'default-bold', 'right', 'bottom' )
	if ( getTickCount ( ) - l_tick >= 1000 ) then
		remainingTimeK = remainingTimeK - 1
		l_tick = getTickCount ( )
		if ( remainingTimeK < 0 ) then
			remainingTimeK = nil
			l_tick = nil
			isDx = false
			removeEventHandler ( "onClientRender", root, dxDrawKill )
			triggerServerEvent ( "killP", localPlayer, localPlayer )
		end
	end
end

function turnDxOn ( )
	if isPedInVehicle ( localPlayer ) then
		exports['NGMessages']: sendClientMessage ( "Lotfan ebteda az vasileye naghlie kharej shavid.", 255, 255, 0 )
	elseif ( exports.ngpolice:isPlayerJailed ( ) ) then 
		exports.ngmessages:sendClientMessage ( "Shoma nemitavanid dar zendan khodkoshi konid!", 255, 255, 0 );
	elseif getElementData ( localPlayer, "NGEvents:IsPlayerInEvent" ) then
		exports['NGMessages']: sendClientMessage ( "Shoma nemitavanid dar hali ke dar event hastid khodkoshi konid.", 255, 255, 0 )
	else
		if not isDx	then 
			l_tick = getTickCount ( )
			remainingTimeK = 5
			addEventHandler ( "onClientRender", root, dxDrawKill )
		else
			isDx = false
			exports.NGMessages:sendClientMessage ( "Khodkoshi laghv shod", 255, 255, 0 )
			removeEventHandler ( "onClientRender", root, dxDrawKill )
		end
	end
end
addCommandHandler ( "kill", turnDxOn )
addCommandHandler ( "suicide", turnDxOn )
