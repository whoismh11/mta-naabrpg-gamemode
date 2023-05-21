addEvent ( "NGGym->Modules->Walking->SetWalkingStyle", true )
addEventHandler ( "NGGym->Modules->Walking->SetWalkingStyle", root, function ( style )
	local settings = getElementData ( source, "PlayerServerSettings")
	if ( not settings ) then
		setElementData ( source, "PlayerServerSettings", { } )
		settings = { }
	end

	settings.walkStyle = style
	setElementData ( source, "PlayerServerSettings", settings )
	source:setWalkingStyle ( style )
	exports.ngmessages:sendClientMessage ( "Walking Style shoma update shod!", source, 0, 255, 0 )
end )
