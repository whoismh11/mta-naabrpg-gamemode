local messages = { 
	"Darsoorate moshahedeye bug, aan ra ba dastoore /report be admin gozaresh dahid.",
	"Telegram: @GameGG_iR",
	"Doost darid pooldar shavid? hemayate mali konid!",
	"Discord: discord.me/gamegg",
	"Az 'F3' baraye didane mobile estefade konid.",
	"Instagram: @GameGG.iR",
	"Az 'F1' baraye didane dastoorat va rahnami estefade konid."
}

local lastI = 0
function sendNextAutomatedMessage (  )
	lastI = lastI + 1
	if ( lastI > #messages ) then
		lastI = 1
	end
	
	sendClientMessage ( messages [ lastI ], root, math.random ( 150, 255 ), math.random ( 150, 255 ), math.random ( 150, 255 ) )
	setTimer ( sendNextAutomatedMessage, 500000, 1 )
end
setTimer ( sendNextAutomatedMessage, 200, 1 )
