local WARP_LOCS = { 
	DEFAULT = { },
	ADMIN = { },
	RELEASE = { }
}

addEventHandler ( "onResourceStart", resourceRoot, function ( )
	
	local warp_default = get ( "*JAIL_WARP_LOCATION" );
	local warp_admin = get ( "*JAIL_WARP_ADMIN_LOCATION" );
	local warp_release = get ( "*JAIL_WARP_RELEASE_LOCATION" );
	
	if ( not warp_default ) then 
		outputDebugString ( "Couldn't find '*JAIL_WARP_LOCATION' setting in NGPolice" );
		WARP_LOCS.DEFAULT = { 0, 0, 0 }
	else 
		local warp_default = split ( warp_default, "," );
		if ( #warp_default ~= 3 ) then 
			outputDebugString ( "'*JAIL_WARP_LOCATION' setting value should be x,y,z (no spaces, please confirm format is correct)" );
			WARP_LOCS.DEFAULT = { 0, 0, 0 }
		elseif ( not tonumber ( warp_default[1] ) or not tonumber ( warp_default[2] ) or not tonumber ( warp_default[3] ) ) then 
			outputDebugString ( "Failed to convert all '*JAIL_WARP_LOCATION' coordinates to floats. Please confirm they are numbers" );
			WARP_LOCS.DEFAULT = { 0, 0, 0 }
		else 
			WARP_LOCS.DEFAULT = { tonumber(warp_default[1]), tonumber(warp_default[2]), tonumber(warp_default[3]) };
		end 
	end 
	
	if ( not warp_release ) then 
		outputDebugString ( "Couldn't find '*JAIL_WARP_RELEASE_LOCATION' setting in NGPolice" );
		WARP_LOCS.RELEASE = { 0, 0, 0 }
	else 
		local warp_release = split ( warp_release, "," );
		if ( #warp_release ~= 3 ) then 
			outputDebugString ( "'*JAIL_WARP_RELEASE_LOCATION' setting value should be x,y,z (no spaces, please confirm format is correct)" );
			WARP_LOCS.RELEASE = { 0, 0, 0 }
		elseif ( not tonumber ( warp_release[1] ) or not tonumber ( warp_release[2] ) or not tonumber ( warp_release[3] ) ) then 
			outputDebugString ( "Failed to convert all '*JAIL_WARP_RELEASE_LOCATION' coordinates to floats. Please confirm they are numbers" );
			WARP_LOCS.RELEASE = { 0, 0, 0 }
		else 
			WARP_LOCS.RELEASE = { tonumber(warp_release[1]), tonumber(warp_release[2]), tonumber(warp_release[3]) };
		end 
	end 
	
	if ( not warp_admin ) then 
		outputDebugString ( "Couldn't find '*JAIL_WARP_ADMIN_LOCATION' setting in NGPolice" );
		WARP_LOCS.ADMIN = { 0, 0, 0 }
	else 
		local warp_admin = split ( warp_admin, "," );
		if ( #warp_admin ~= 3 ) then 
			outputDebugString ( "'*JAIL_WARP_ADMIN_LOCATION' setting value should be x,y,z (no spaces, please confirm format is correct)" );
			WARP_LOCS.ADMIN = { 0, 0, 0 }
		elseif ( not tonumber ( warp_admin[1] ) or not tonumber ( warp_admin[2] ) or not tonumber ( warp_admin[3] ) ) then 
			outputDebugString ( "Failed to convert all '*JAIL_WARP_ADMIN_LOCATION' coordinates to floats. Please confirm they are numbers" );
			WARP_LOCS.ADMIN = { 0, 0, 0 }
		else 
			WARP_LOCS.ADMIN = { tonumber(warp_admin[1]), tonumber(warp_admin[2]), tonumber(warp_admin[3]) };
		end 
	end 
	
	outputDebugString ( "Default jail warp location: "..tostring ( table.concat( WARP_LOCS.DEFAULT, ", " ) ) )
	outputDebugString ( "Admin jail warp location: "..tostring ( table.concat( WARP_LOCS.ADMIN, ", " ) ) )
	outputDebugString ( "Release jail warp location: "..tostring ( table.concat( WARP_LOCS.RELEASE, ", " ) ) )

end );

local jailedPlayers = { }

function isPlayerJailed ( p )
	if ( p and getElementType ( p ) == 'player' ) then
		if ( jailedPlayers[p] ) then
			return tonumber ( getElementData ( p, 'NGPolice:JailTime' ) )
		else
			return false
		end
	end
	return nil
end

function jailPlayer ( p, dur, announce, element, reason ) 
	if( p and dur ) then
		local announce = announce or false
		jailedPlayers[p] = dur
		setElementInterior ( p, 0 )
		setElementDimension ( p, 33 )
		
		local __x, __y, __z = unpack ( WARP_LOCS.DEFAULT )
		if ( element and reason ) then
			__x, __y, __z = unpack ( WARP_LOCS.ADMIN )
		end 
		
		setElementPosition ( p, __x, __y, __z );
		--outputChatBox ( table.concat ( { __x, __y, __z }, ", " ) );
		
		setElementData ( p, 'NGPolice:JailTime', tonumber ( dur ) )
		setElementData ( p, "isGodmodeEnabled", true )
		exports['NGJobs']:updateJobColumn ( getAccountName ( getPlayerAccount ( p ) ), 'TimesArrested', "AddOne" )
		if ( announce ) then
			local reason = reason or "Classified"
			local msg = ""
			if ( element and reason ) then
				msg = getPlayerName ( p ).." zendani shod tavasote "..getPlayerName ( element ).." be modate "..tostring ( dur ).." saniye ("..reason..")"
			elseif ( element ) then
				msg =  getPlayerName ( p ).." zendani shod tavasote "..getPlayerName ( element ).." be modate "..tostring ( dur ).." saniye"
			end
			exports['NGMessages']:sendClientMessage ( msg, root, 0, 120, 255 )
			exports['NGLogs']:outputPunishLog ( p, element or "Console", tostring ( msg ) )
		end
		triggerEvent ( "onPlayerArrested", p, dur, element, reason )
		triggerClientEvent ( p, "onPlayerArrested", p, dur, element, reason )
		return true
	end
	return false
end

function unjailPlayer ( p, triggerClient )
	local p = p or source
	setElementDimension ( p, 0 )
	setElementInterior ( p, 0 )
	setElementPosition ( p, 1543.32, -1675.6, 13.56 )
	exports['NGMessages']:sendClientMessage ( "Shoma az zendan azad shodid.", p, 0, 255, 0 )
	jailedPlayers[p] = nil
	setElementData ( p, "NGPolice:JailTime", nil )
	setElementData ( p, "isGodmodeEnabled", nil )
	exports['NGLogs']:outputActionLog ( getPlayerName ( p ).." has been unjailed" )
	if ( triggerClient ) then
		triggerClientEvent ( p, 'NGJail:StopJailClientTimer', p ) 
	end
end
addEvent ( "NGJail:UnjailPlayer", true )
addEventHandler ( "NGJail:UnjailPlayer", root, unjailPlayer )

function getJailedPlayers ( )
	return jailedPlayers
end

addCommandHandler ( "jail", function ( p, _, p2, time, ... )
	if ( exports['NGAdministration']:isPlayerStaff ( p ) ) then
		if ( p2 and time ) then
			local toJ = getPlayerFromName ( p2 ) or exports['NGPlayerFunctions']:getPlayerFromNamePart ( p2 )
			if toJ then
				jailPlayer ( toJ, time, true, p, table.concat ( { ... }, " " ) )
			else
				exports['NGMessages']:sendClientMessage ( "Playeri ba \""..p2.."\" dar esmesh peyda nashod.", p, 255, 0, 0 )
			end
		else
			exports['NGMessages']:sendClientMessage ( "Syntax: /jail [player name/part of name] [seconds] [reason]", p, 255, 255, 0 )
		end
	end
end )

addCommandHandler ( "unjail", function ( p, _, p2 ) 
	if ( not exports['NGAdministration']:isPlayerStaff ( p ) ) then
		return false
	end if ( not p2 ) then
		return exports['NGMessages']:sendClientMessage ( "Syntax: /unjail [player]", p, 255, 255, 0 )
	end if ( not getPlayerFromName ( p2 ) ) then
		p2 = exports['NGPlayerFunctions']:getPlayerFromNamePart ( p2 )
		if not p2 then
			return exports['NGMessages']:sendClientMessage ( "In player dar server vojod nadarad.", p, 255, 0, 0 )
		end
	end
	
	if ( jailedPlayers[p2] ) then
		exports['NGMessages']:sendClientMessage ( "Shoma "..getPlayerName ( p2 ).." ra azad kardid!", p, 0, 255, 0 )
		exports['NGMessages']:sendClientMessage ( "Shoma tavasote "..getPlayerName ( p ).." azad shodid!", p2, 0, 255, 0 )
		unjailPlayer ( p2, true )
	else
		exports['NGMessages']:sendClientMessage ( "In player zendani nist.", p, 255, 0, 0 )
	end
	
end )

addEventHandler ( "onResourceStop", resourceRoot, function ( )
	exports['NGSQL']:saveAllData ( false )
end )  addEventHandler ( "onResourceStart", resourceRoot, function ( )
	setTimer ( function ( )
		local q = exports['NGSQL']:db_query ( "SELECT * FROM accountdata" )
		local data = { }
		for i, v in ipairs ( q ) do
			data[v['Username']] = v['JailTime']
		end
		
		for i, v in pairs ( data ) do 
			local p = exports['NGPlayerFunctions']:getPlayerFromAcocunt ( i )
			if p then
				local t = tonumber ( getElementData ( p, 'NGPolice:JailTime' ) ) or i
				jailPlayer ( p, tonumber ( t ), false )
			end
		end
	end, 500, 1 )
end )
addEvent ( "onPlayerArrested", true )
