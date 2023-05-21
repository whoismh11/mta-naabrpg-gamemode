local predefinedHandling = {
	[411] = {
        ["engineAcceleration"] = 22.0,
        ["maxVelocity"] = 200000.0,
        ["tractionMultiplier"] = 0.9,
		["tractionLoss"] = 1.1,
		["suspensionDamping"] = 0.3,
		["suspensionHighSpeedDamping"] = 0.0,
		["engineInertia"] = 100.0,
		["tractionBias"] = 0.48,
	},
	[402] = {
        ["engineAcceleration"] = 15.0,
        ["maxVelocity"] = 160000.0,
        ["tractionMultiplier"] = 0.9,
		["tractionLoss"] = 1.1,
		["suspensionDamping"] = 0.3,
		["suspensionHighSpeedDamping"] = 0.0,
		["engineInertia"] = 100.0,
		["tractionBias"] = 0.48,
	},
	[603] = {
        ["engineAcceleration"] = 16.0,
        ["maxVelocity"] = 160000.0,
        ["tractionMultiplier"] = 0.9,
		["tractionLoss"] = 1.1,
		["suspensionDamping"] = 0.3,
		["suspensionHighSpeedDamping"] = 0.0,
		["engineInertia"] = 100.0,
		["tractionBias"] = 0.48,
	},
	[475] = {
        ["engineAcceleration"] = 15.0,
        ["maxVelocity"] = 160000.0,
        ["tractionMultiplier"] = 0.9,
		["tractionLoss"] = 1.1,
		["suspensionDamping"] = 0.3,
		["suspensionHighSpeedDamping"] = 0.0,
		["engineInertia"] = 100.0,
		["tractionBias"] = 0.48,
	},
	[477] = {
        ["engineAcceleration"] = 17.0,
        ["maxVelocity"] = 160000.0,
        ["tractionMultiplier"] = 0.9,
		["tractionLoss"] = 1.1,
		["suspensionDamping"] = 0.3,
		["suspensionHighSpeedDamping"] = 0.0,
		["engineInertia"] = 100.0,
		["tractionBias"] = 0.48,
	},
	[506] = {
        ["engineAcceleration"] = 18.0,
        ["maxVelocity"] = 180000.0,
        ["tractionMultiplier"] = 0.9,
		["tractionLoss"] = 1.1,
		["suspensionDamping"] = 0.3,
		["suspensionHighSpeedDamping"] = 0.0,
		["engineInertia"] = 100.0,
		["tractionBias"] = 0.48,
	},
	[541] = {
		["engineAcceleration"] = 22.0,
        ["maxVelocity"] = 200000.0,
        ["tractionMultiplier"] = 0.9,
		["tractionLoss"] = 1.1,
		["suspensionDamping"] = 0.3,
		["suspensionHighSpeedDamping"] = 0.0,
		["engineInertia"] = 100.0,
		["tractionBias"] = 0.48,
	},

}

for i,v in pairs (predefinedHandling) do
	if i then
		for handling, value in pairs (v) do
			if not setModelHandling (i, handling, value) then
				outputDebugString ("* Predefined handling '"..tostring(handling).."' for vehicle model '"..tostring(i).."' could not be set to '"..tostring(value).."'")
			end
		end
	end
end

for _,v in ipairs (getElementsByType("vehicle")) do
	if v and predefinedHandling[getElementModel(v)] then
		for k,vl in pairs (predefinedHandling[getElementModel(v)]) do
			setVehicleHandling (v, k, vl)
		end
	end
end

function resetHandling()
	for model in pairs (predefinedHandling) do
		if model then
			for k in pairs(getOriginalHandling(model)) do
				setModelHandling(model, k, nil)
			end
		end
	end

	for _,v in ipairs (getElementsByType("vehicle")) do
		if v then
			local model = getElementModel(v)
			if predefinedHandling[model] then
				for k,h in pairs(getOriginalHandling(model)) do
					setVehicleHandling(v, k, h)
				end
			end
		end
	end
end
addEventHandler("onResourceStop", resourceRoot, resetHandling)
