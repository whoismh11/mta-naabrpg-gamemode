addEventHandler("onResourceStart", resourceRoot,
function () 
		call(getResourceFromName("scoreboard"), "scoreboardAddColumn", "radio", root, 35, "Radio", 250)
	setElementData(resourceRoot, "radio.url", "nil")
end
)

function radio_config_for_admins(thePlayer)
 local accName = getAccountName ( getPlayerAccount ( thePlayer ) ) 
    if isObjectInACLGroup ("user."..accName, aclGetGroup ( "" ) ) or isObjectInACLGroup ("user."..accName, aclGetGroup ( "Level 5" ) ) then 
	triggerClientEvent(thePlayer, "onRadioConfigOpen", root)
	else
	outputChatBox("#ffffffShoma Mojaz Nemibashid!", thePlayer, 102,255,0, true)
	end
end
addCommandHandler( "djpanel", radio_config_for_admins, false, true)

function radio_change(thePlayer)
triggerClientEvent("onClientRadioChanged", root, thePlayer)
end
addEvent("onRadioChanged", true)
addEventHandler("onRadioChanged", root, radio_change)

--- istek sarkılar

addEvent("send", true)
addEventHandler("send", root,
    function (name, report)
        for i,v in ipairs(getElementsByType("player")) do
            if hasObjectPermissionTo(v, "command.ban", true) then
				outputChatBox("   ", v, 255, 0, 0, true)
                outputChatBox("#999999Shakhs:#FFFFFF "..name.." #00f1f9Darkhaste Ahang Karde Ast!", v, 255, 0, 0,  true)
                outputChatBox("#00ffffAhang:#FFFFFF "..report, v, 255, 0, 0, true)
				outputChatBox("   ", v, 255, 0, 0, true)
            end
        end
    end
)

function onMSG (mensaj)
	triggerClientEvent("MSG",getRootElement(),mensaj)
end
addEvent("ServerMSG", true)
addEventHandler("ServerMSG", getRootElement(), onMSG)
