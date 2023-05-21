function vehicleExplode ()
    --destroy wreck after 5 minutes
    setTimer( destroyElement, 10000, 1, source)
end

addEventHandler ( "onVehicleExplode", getRootElement(), vehicleExplode )
