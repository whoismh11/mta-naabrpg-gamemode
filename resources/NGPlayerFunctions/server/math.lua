local isMathQuestion = false
function createMathProblem ( p )
	if p and not exports["NGAdministration"]:isPlayerStaff ( p ) then return false end
	if not isMathQuestion then
		local n1 = math.random ( 50, 90 )
		local n2 = math.random ( 20, 45 )
		local n3 = math.random ( 1000, 9000 )
		local reward = math.random ( 300, 600 )
		local question = n1.." - "..n2.." + "..n3
		outputDebugString ( "MATH: Question "..question.." has been generated with an answer of "..n1 - n2 + n3 )
		outputChatBox ( "#DF743F[SOALE RIYAZI]#ffffff Avalin kasi ke soale #ffff00"..question.."#ffffff ra pasokhe sahih dahad, barandeye #00ff00$"..reward.."#ffffff mishavad.(az dastore /result [JAVAB] estefade konid)", getRootElement ( ), 0, 0, 0, true ) 
		
		mathTable = {
			reward = reward,
			question = n1.." - "..n2.." + "..n3,
			answer = n1 - n2 + n3
		}
		
		isMathQuestion = true
		return true
	else
		isMathQuestion = false
		mathTable = nil
		createMathProblem ( )
	end
end 
setTimer ( createMathProblem, 900000, 0 )
addCommandHandler ( "math", createMathProblem )

addCommandHandler ( "result", function ( p, cmd, answer )
	if ( isMathQuestion ) then
		if ( tonumber ( answer ) == tonumber ( mathTable.answer ) ) then
			outputChatBox ( "#DF743F[SOALE RIYAZI] #ff0000"..getPlayerName ( p ).."#ffffff avalin nafari bood ke soale #0000ff"..mathTable.answer.."#ffffff ra javab dad va barandeye mablagh shod #00ff00$"..mathTable.reward, root, 0, 0, 0, true )
			givePlayerMoney ( p, mathTable.reward )
			isMathQuestion = false
			mathTable = nil
			return true
		else
			outputChatBox ( "#DF743F[SOALE RIYAZI] #ffffffMoteasefim, #ffff00"..getPlayerName ( p ).." #ffffffama in javab #ff0000eshtebah#ffffff ast.", p, 255, 0, 0, true )
			return false
		end
	else
		outputChatBox ( "#DF743F[SOALE RIYAZI] #ffffffDar hale hazer hich soale dar hale ejrai vojod nadarad.", p, 255, 0, 0, true )
		return false
	end
end )

function getRunningMathEquation ( )
	if ( mathTable ) then
		return mathTable.question
	end
	return false
end
