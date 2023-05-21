function cromusCargos(player)
	if isObjectInACLGroup("user."..getAccountName(getPlayerAccount(player)), aclGetGroup("Console")) then
		setElementData(player, "cargo", "GENERAL OWNER")
		setElementData(player, "cargo->cor", {255,140,140})
	elseif isObjectInACLGroup("user."..getAccountName(getPlayerAccount(player)), aclGetGroup("Level 5")) then
		setElementData(player, "cargo", "Administrator")
		setElementData(player, "cargo->cor", {255,163,0})
	elseif isObjectInACLGroup("user."..getAccountName(getPlayerAccount(player)), aclGetGroup("Level 4")) then
		setElementData(player, "cargo", "Supervisor")
		setElementData(player, "cargo->cor", {255,140,140})
	elseif isObjectInACLGroup("user."..getAccountName(getPlayerAccount(player)), aclGetGroup("Level 3")) then
		setElementData(player, "cargo", "SuperModerator")
		setElementData(player, "cargo->cor", {255,140,140})
	elseif isObjectInACLGroup("user."..getAccountName(getPlayerAccount(player)), aclGetGroup("Level 2")) then
		setElementData(player, "cargo", "Moderator")
		setElementData(player, "cargo->cor", {255,140,140})
	elseif isObjectInACLGroup("user."..getAccountName(getPlayerAccount(player)), aclGetGroup("Level 1")) then
		setElementData(player, "cargo", "Helper")
		setElementData(player, "cargo->cor", {255,140,140})
		elseif isObjectInACLGroup("user."..getAccountName(getPlayerAccount(player)), aclGetGroup("Everyone")) then
		setElementData(player, "cargo", " ")
		setElementData(player, "cargo->cor", {255,140,140})
	end
end

function onResourceStart()
	for _, player in pairs(getElementsByType("player")) do
		cromusCargos(player)
	end
end
addEventHandler("onResourceStart",resourceRoot,onResourceStart)

function onPlayerLogin()
	cromusCargos(source)
end
addEventHandler("onPlayerLogin",root,onPlayerLogin)
