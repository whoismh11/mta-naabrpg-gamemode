
txd = engineLoadTXD ('MPG_Hollywood.txd') 
engineImportTXD (txd, 13831) 
dff = engineLoadDFF('MPG_Hollywood.dff', 13831) 
engineReplaceModel (dff, 13831)
col = engineLoadCOL ('MPG_Hollywood.col')
engineReplaceCOL (col, 13831)
engineSetModelLODDistance(13831,10000)
