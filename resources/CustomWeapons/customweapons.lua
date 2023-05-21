-- Genji Katana -> Katana
addEventHandler ( "onClientResourceStart", resourceRoot,
	function ()
		txd = engineLoadTXD ("GenjiKatana.txd")
		engineImportTXD (txd, 339)
		dff = engineLoadDFF ("GenjiKatana.dff")
		engineReplaceModel (dff, 339)
	end
);

-- AK-47 Dragon -> AK47
addEventHandler ( "onClientResourceStart", resourceRoot,
	function ()
		txd = engineLoadTXD ("AK47Dragon.txd")
		engineImportTXD (txd, 355)
		dff = engineLoadDFF ("AK47Dragon.dff")
		engineReplaceModel (dff, 355)
	end
);

-- Knife Cur -> Knife
addEventHandler ( "onClientResourceStart", resourceRoot,
	function ()
		txd = engineLoadTXD ("Knife.txd")
		engineImportTXD (txd, 335)
		dff = engineLoadDFF ("Knife.dff")
		engineReplaceModel (dff, 335)
	end
);

-- New Panje -> Panje
addEventHandler ( "onClientResourceStart", resourceRoot,
	function ()
		txd = engineLoadTXD ("Panje.txd")
		engineImportTXD (txd, 331)
		dff = engineLoadDFF ("Panje.dff")
		engineReplaceModel (dff, 331)
	end
);

-- New Flower -> Flower
addEventHandler ( "onClientResourceStart", resourceRoot,
	function ()
		txd = engineLoadTXD ("Flower.txd")
		engineImportTXD (txd, 325)
		dff = engineLoadDFF ("Flower.dff")
		engineReplaceModel (dff, 325)
	end
);

-- New Sniper -> Sniper
addEventHandler ( "onClientResourceStart", resourceRoot,
	function ()
		txd = engineLoadTXD ("sniper.txd")
		engineImportTXD (txd, 358)
		dff = engineLoadDFF ("sniper.dff")
		engineReplaceModel (dff, 358)
	end
);
