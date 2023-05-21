local ReplacedWeaponID = 27

addEventHandler ( 'onPlayerWeaponSwitch', getRootElement ( ),
	function ( previousWeaponID, currentWeaponID )
		if getElementType(source)~="player" then return false end
		if currentWeaponID==ReplacedWeaponID then
			if not isGravityGunEnabled(source) then
				togglePlayerGravityGun(source,true)
			end
		else
			if isGravityGunEnabled(source) then
				togglePlayerGravityGun(source,false)
			end
		end
	end
)

addEventHandler("onResourceStart", getResourceRootElement( getThisResource()), function()
	for index,value in ipairs(getElementsByType("Player")) do
		if getPedWeapon(value)==ReplacedWeaponID then
			if not isGravityGunEnabled(value) then
				togglePlayerGravityGun(value,true)
			end
		end
	end
end
)

addEventHandler("onResourceStop", getResourceRootElement( getThisResource()), function()
	for index,value in ipairs(getElementsByType("Player")) do
		if isGravityGunEnabled(value) then
			togglePlayerGravityGun(value,false)
		end
	end
end
)
