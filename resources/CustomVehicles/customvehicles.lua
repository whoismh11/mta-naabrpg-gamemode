-- Lamborghini Aventador -> Infernus
txd = engineLoadTXD ("LamborghiniAventador.txd")
engineImportTXD (txd, 411)
dff = engineLoadDFF ("LamborghiniAventador.dff")
engineReplaceModel (dff, 411)

-- Bentley Continental GT -> Buffalo
txd = engineLoadTXD ("BentleyContinental.txd")
engineImportTXD (txd, 402)
dff = engineLoadDFF ("BentleyContinental.dff")
engineReplaceModel (dff, 402)

-- Ford Mustang -> Phoenix
txd = engineLoadTXD ("FordMustang.txd")
engineImportTXD (txd, 603)
dff = engineLoadDFF ("FordMustang.dff")
engineReplaceModel (dff, 603)

-- Chevrolet Camaro -> Sabre
txd = engineLoadTXD ("ChevroletCamaro.txd")
engineImportTXD (txd, 475)
dff = engineLoadDFF ("ChevroletCamaro.dff")
engineReplaceModel (dff, 475)

-- Audi R8 GT -> ZR-350
txd = engineLoadTXD ("AudiR8GT.txd")
engineImportTXD (txd, 477)
dff = engineLoadDFF ("AudiR8GT.dff")
engineReplaceModel (dff, 477)

-- Mercedes-Benz S-Class Coupe AMG -> Super GT
txd = engineLoadTXD ("MercedesBenzAMG.txd")
engineImportTXD (txd, 506)
dff = engineLoadDFF ("MercedesBenzAMG.dff")
engineReplaceModel (dff, 506)

-- Bugatti Chiron Pur Sport 2020 -> Bullet
txd = engineLoadTXD ("BugattiChiron.txd")
engineImportTXD (txd, 541)
dff = engineLoadDFF ("BugattiChiron.dff")
engineReplaceModel (dff, 541)
