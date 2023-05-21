function Skin() 
  txd = engineLoadTXD("data/dynamite.txd", 2814 )
  engineImportTXD(txd, 2814)
  dff = engineLoadDFF("data/dynamite.dff", 2814 )
  engineReplaceModel(dff, 2814)
end 
addEventHandler ( "onClientResourceStart", getResourceRootElement(getThisResource()), Skin)

function sedayepoop(plr)
	 local soundepoop = playSound3D("data/sound.mp3", 0, 0, 0, false)
	 attachElements(soundepoop, plr)
end
addEvent("syncSong",true)
addEventHandler("syncSong", getRootElement(), sedayepoop)
