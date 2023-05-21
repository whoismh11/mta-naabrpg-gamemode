-- Stop Animations
addEventHandler("onResourceStart", resourceRoot, function()
    for k, v in ipairs(getElementsByType("player")) do
      bindKey(v, "mouse2", "down", "stopanim")
    end
end
)
addEventHandler("onPlayerJoin", root, function()
    bindKey(source, "mouse2", "down", "stopanim")
end
)

function stopanim ( source )
    setPedAnimation ( source, "ped", "seat_up", -1, false, false, false, true )
	setPedAnimation ( source )
end
addCommandHandler ( "stopanim", stopanim )

-- Sex Animation
function sex ( source )
    outputChatBox ( "Syntax: /sex[1-2]", source, 255, 255, 255 )
end
addCommandHandler ( "sex", sex )

function sex1 ( source )
    setPedAnimation ( source, "sex", "sex_1_cum_p", -1, true, false, false, false )
end
addCommandHandler ( "sex1", sex1 )

function sex2 ( source )
    setPedAnimation ( source, "sex", "sex_1_cum_w", -1, true, false, false, false )
end
addCommandHandler ( "sex2", sex2 )

-- Kiss Animation
function kiss ( source )
    outputChatBox ( "Syntax: /kiss[1-3]", source, 255, 255, 255 )
end
addCommandHandler ( "kiss", kiss )

function kiss1 ( source )
    setPedAnimation ( source, "kissing", "playa_kiss_01", -1, false, false, false, false )
end
addCommandHandler ( "kiss1", kiss1 )

function kiss2 ( source )
    setPedAnimation ( source, "kissing", "playa_kiss_02", -1, false, false, false, false )
end
addCommandHandler ( "kiss2", kiss2 )

function kiss3 ( source )
    setPedAnimation ( source, "kissing", "playa_kiss_03", -1, false, false, false, false )
end
addCommandHandler ( "kiss3", kiss3 )

-- Wank Animation
function wank ( source )
    setPedAnimation ( source, "PAULNMAC", "wank_loop", -1, true, false, false, false )
end
addCommandHandler ( "wank", wank )

-- BlowJob Animation
function bj ( source )
    outputChatBox ( "Syntax: /blowjob[1-4]", source, 255, 255, 255 )
end
addCommandHandler ( "blowjob", bj )

function bj1 ( source )
    setPedAnimation ( source, "blowjobz", "BJ_Couch_Loop_P", -1, true, false, false, false )
end
addCommandHandler ( "blowjob1", bj1 )

function bj2 ( source )
    setPedAnimation ( source, "blowjobz", "BJ_Couch_Loop_W", -1, true, false, false, false )
end
addCommandHandler ( "blowjob2", bj2 )

function bj3 ( source )
    setPedAnimation ( source, "blowjobz", "BJ_Car_Loop_P", -1, true, false, false, false )
end
addCommandHandler ( "blowjob3", bj3 )

function bj4 ( source )
    setPedAnimation ( source, "blowjobz", "BJ_Car_Loop_W", -1, true, false, false, false )
end
addCommandHandler ( "blowjob4", bj4 )

-- Gro Animation
function gro ( source )
    outputChatBox ( "Syntax: /gro[1-2]", source, 255, 255, 255 )
end
addCommandHandler ( "gro", gro )

function gro1 ( source )
    setPedAnimation ( source, "beach", "parksit_m_loop", -1, true, false, false, false )
end
addCommandHandler ( "gro1", gro1 )

function gro2 ( source )
    setPedAnimation ( source, "beach", "parksit_w_loop", -1, true, false, false, false )
end
addCommandHandler ( "gro2", gro2 )

-- Lay Animation
function lay ( source )
    outputChatBox ( "Syntax: /lay[1-2]", source, 255, 255, 255 )
end
addCommandHandler ( "lay", lay )

function lay1 ( source )
    setPedAnimation ( source, "beach", "lay_bac_loop", -1, true, false, false, false )
end
addCommandHandler ( "lay1", lay1 )

function lay2 ( source )
    setPedAnimation ( source, "beach", "sitnwait_loop_w", -1, true, false, false, false )
end
addCommandHandler ( "lay2", lay2 )

-- Sit Animation
function sit ( source )
	setPedAnimation ( source, "ped", "seat_down", -1, false, false, false, true )
end
addCommandHandler ( "sit", sit )

-- Render Animation
function render ( source )
	setPedAnimation ( source, "shop", "shp_rob_handsup", -1, false, false, false, true )
end
addCommandHandler ( "render", render )

-- Dance Animation
function dance ( source )
    outputChatBox ( "Syntax: /dance[1-13]", source, 255, 255, 255 )
end
addCommandHandler ( "dance", dance )

function dance1 ( source )
		setPedAnimation ( source, "dancing", "bd_clap", -1, true, false, false, false )
end
addCommandHandler ( "dance1", dance1 )

function dance2 ( source )
    setPedAnimation ( source, "dancing", "bd_clap1", -1, true, false, false, false )
end
addCommandHandler ( "dance2", dance2 )

function dance3 ( source )
    setPedAnimation ( source, "dancing", "dance_loop", -1, true, false, false, false )
end
addCommandHandler ( "dance3", dance3 )

function dance4 ( source )
    setPedAnimation ( source, "dancing", "dan_down_a", -1, true, false, false, false )
end
addCommandHandler ( "dance4", dance4 )

function dance5 ( source )
    setPedAnimation ( source, "dancing", "dan_left_a", -1, true, false, false, false )
end
addCommandHandler ( "dance5", dance5 )

function dance6 ( source )
    setPedAnimation ( source, "dancing", "dan_loop_a", -1, true, false, false, false )
end
addCommandHandler ( "dance6", dance6 )

function dance7 ( source )
    setPedAnimation ( source, "dancing", "dan_right_a", -1, true, false, false, false )
end
addCommandHandler ( "dance7", dance7 )

function dance8 ( source )
    setPedAnimation ( source, "dancing", "dan_up_a", -1, true, false, false, false )
end
addCommandHandler ( "dance8", dance8 )

function dance9 ( source )
    setPedAnimation ( source, "dancing", "dnce_m_a", -1, true, false, false, false )
end
addCommandHandler ( "dance9", dance9 )

function dance10 ( source )
    setPedAnimation ( source, "dancing", "dnce_m_b", -1, true, false, false, false )
end
addCommandHandler ( "dance10", dance10 )

function dance11 ( source )
    setPedAnimation ( source, "dancing", "dnce_m_c", -1, true, false, false, false )
end
addCommandHandler ( "dance11", dance11 )

function dance12 ( source )
    setPedAnimation ( source, "dancing", "dnce_m_d", -1, true, false, false, false )
end
addCommandHandler ( "dance12", dance12 )

function dance13 ( source )
    setPedAnimation ( source, "dancing", "dnce_m_e", -1, true, false, false, false )
end
addCommandHandler ( "dance13", dance13 )
