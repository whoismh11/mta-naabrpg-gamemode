local cigarettes = { } 
function cigarette ( thePlayer )
    if ( not isElement ( cigarettes [ thePlayer ] ) ) then
        local x, y, z = getElementPosition ( thePlayer )
        cigarettes [ thePlayer ] = createObject ( 1485, 0, 0, 0 )
        exports [ "bone_attach" ]:attachElementToBone ( cigarettes [ thePlayer ], thePlayer, 1, -0.01, -0.01, -0.02, 90, 90, 0 )
        toggleControl ( thePlayer, "jump", false )
        toggleControl ( thePlayer, "sprint", false )
        toggleControl ( thePlayer, "crouch", false )
    else
        toggleControl ( thePlayer, "jump", true )
        toggleControl ( thePlayer, "sprint", true )
        toggleControl ( thePlayer, "crouch", true )
        destroyElement ( cigarettes [ thePlayer ] )
    end
end
addCommandHandler ( "smoke", cigarette )
