addEvent ( "NVehicles:playLockSoundOnVehicle", true )
addEventHandler ( "NVehicles:playLockSoundOnVehicle", root, function ( c )
	local s = playSound3D ( "locks/beep.mp3", getElementPosition ( c ) )
	setSoundMinDistance ( s, 20 )
	setSoundMaxDistance ( s, 32 )
end )
