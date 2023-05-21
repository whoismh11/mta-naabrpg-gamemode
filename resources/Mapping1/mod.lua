 function replaceModel()
   local txd = engineLoadTXD ( "data/oldgarage_sfse.txd")
   engineImportTXD ( txd, 11387 )
   
   local txd = engineLoadTXD ( "data/oldgarage_sfse.txd")
   engineImportTXD ( txd, 11326 )
   
   local txd = engineLoadTXD ( "data/oldgarage_sfse.txd")
   engineImportTXD ( txd, 11416 )
   
   local txd = engineLoadTXD ( "data/hubint1_sfse.txd") 
   engineImportTXD ( txd, 11389 )
   
   local txd = engineLoadTXD ( "data/4730.txd") 
   engineImportTXD ( txd, 4730 )
   
   local txd = engineLoadTXD ( "data/barrio1_lae.txd") 
   engineImportTXD ( txd, 5397, 5409, 5489, 5681 )
   
   local txd = engineLoadTXD ( "data/wshxrefpump.txd") 
   engineImportTXD ( txd, 1676 )
   
   local txd = engineLoadTXD ( "data/2697.txd") 
   engineImportTXD ( txd, 2697 )
   
   local txd = engineLoadTXD ( "data/2657.txd") 
   engineImportTXD ( txd, 2657 )
 end
 addEventHandler ( "onClientResourceStart", getResourceRootElement(getThisResource()),
     function()
         replaceModel()
         setTimer (replaceModel, 1000, 1)
     end
)

addCommandHandler("reloadmod", replaceModel)
