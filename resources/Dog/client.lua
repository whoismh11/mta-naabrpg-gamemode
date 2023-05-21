--[OPTIONS] EDIT HERE

local DogPanelKey = "F4" --Default F6
local ChangeStatusKey = "I" --Default P
local DoTrickKey = "O" --Default O
local Language = "English" --English/German 
local EnableCheats = false --Default false

---------------------------------------------------------NO EDIT---------------------------------------------------------
--VALUES
local DMClientOwnerGotDog
local DMClientDogRace
local DMClientDogName
local DMClientDogFitness
local DMClientDogStrength
local DMDogRace
local DMClientDogGender

--VARIABLES
local DMDogPanel
local DMClientOwnerGotDog
local DMAttacker
local DMAttackCount
local DMDogAttacking
local DMHelpActive
local DMDogFitnessTimerWasOn
local DMStatusGuiWasOn
local DMDogSpawned
local DMDogDistanceAnimation
local DMFeedActive
local DMTricksDogPanel
local DMTrickTutorial
local DMCursorx, DMCursory, DMworldx, DMworldy, DMworldz
local DMStopCursorx, DMStopCursory, DMstopworldx, DMStopworldy, DMStopworldz
local DMTricksTutorialActive
local DMStatusActive
local DMDogDeathTimerCount
local DMDogDeathRevive
local DMDogFollow
local DMBallThrowActive
local DMInventoryBallOnGround
local DMCreatorActive
local DogGuardingx, DogGuardingy, DogGuardingz
local DMGuardFollowActive
local DMDogAttack
local DMDogGuardActive
local DMDogTasksPanel
local DMDogFightPanel
local DMDogFightRequestPanel
local DMOnlySpawn
local DMPlayerInFight
local DMRequestClose
local DMDogCreationGender
local DMAttackSound2Active
local DMDogSniffPanel

--COLORS
local DMDogCreationColorR
local DMDogCreationColorG
local DMDogCreationColorB

local DMClientDogGenderColorR
local DMClientDogGenderColorG
local DMClientDogGenderColorB

--OBJECTS
local DMClientDog
local DMDogIdleBlip
local DMBall
local DMGuardCollision
local DMGuardPlayerFound
local DMRequestPlayer
local DMClientRequestDog
local DMAttackSound2Object
local DMGuardSound2Object
local DMDogSniffBlip

--TIMER
local DMPositionSyncTimer
local DMDogFitnessTimer
local DMDogHungerTimer
local DMDogEatTimer
local DMGetCoursorPosTimer
local DMDogDeathTimer
local DMDogIdleTimer
local DMInventoryGetBallTimer
local DMGotBallTimer
local DMDogGuardingTimer
local DMAttackSound1Timer
local DMAttackSound2Timer
local DMGuardSound1Timer
local DMGuardSound2Timer

--DXDRAW
local DMScreenx, DMScreeny = guiGetScreenSize()
local DMTextSizex = ((DMScreenx/1920)/2) + 0.5
local DMTextSizey = ((DMScreeny/1080)/2) + 0.5
local DMImagex =  DMScreenx/1920
local DMImagey =  DMScreeny/1080

--GUI
local DMDogNameEdit
local DMDogNameButton1
local DMDogNameButton2
local DMDogNameButton3
local DMDogNameButton4
local DMDogNameButton5
local DMDogNameButton6
local DMDogNameButton7

local DMDogPanelButton1
local DMDogPanelButton2
local DMDogPanelButton3
local DMDogPanelButton4
local DMDogPanelButton5
local DMDogPanelButton6
local DMDogPanelButton7

local DMHelpButton1

local DMTricksDogButton1
local DMTricksDogButton2
local DMTricksDogButton3
local DMTricksDogButton4
local DMTricksDogButton5
local DMTricksDogButton6
local DMTricksDogButton7

local DMDogTasksButton1
local DMDogTasksButton2
local DMDogTasksButton3
local DMDogFightEdit
local DMDogFightButton
local DMDogSniffButton
local DMDogSniffEdit

local DMDogFightRequestButton1
local DMDogFightRequestButton2

--Textures
local texture1
local texture2
local texture3
local texture4
local texture5
local texture6
local texture7
local texture8

--Sounds

local DMAttackStatusSound
local DMAttackSound1
local DMAttackSound2
local DMGuardSound1
local DMGuardSound2
local DMFightSound1
local DMFightSound2

--Language

local DMLanguage

--.Functions.--
local white = tocolor(255,255,255,255)
function dxDrawImage3D(x,y,z,w,h,m,c,r,...)
        local lx, ly, lz = x+w, y+h, (z+tonumber(r or 0)) or z
	return dxDrawMaterialLine3D(x,y,z, lx, ly, lz, m, h, c or white, ...)
end
function DMRound(num, idp)
  local mult = 10^(idp or 0)
  return math.floor(num * mult + 0.5) / mult
end

--CHECK FOR DOG
function DMCheckOwnerBack(DMOwnerGotDog, DMDogName, DMDogRace,DMDogFitness,DMDogStrength, DMDogGender)
if(DMOwnerGotDog == true)then
DMClientDogRace = DMDogRace
DMClientDogName = DMDogName
DMClientOwnerGotDog = DMOwnerGotDog
DMClientDogFitness = DMDogFitness
DMClientDogStrength = DMDogStrength
DMClientDogGender = DMDogGender
if(DMClientDogGender == "male")then
DMClientDogGenderColorR = 51
DMClientDogGenderColorG = 204
DMClientDogGenderColorB = 255
elseif(DMClientDogGender == "female")then
DMClientDogGenderColorR = 255
DMClientDogGenderColorG = 51
DMClientDogGenderColorB = 204
end
else
DMClientOwnerGotDog = false
end
end

--DOG CREATOR
function DMCreateDog()
if(DMClientOwnerGotDog == true)then
if(DMLanguage == 1)then
outputChatBox("Shoma Darhale Hazer Yek Sag Darid!", 255, 0,0)
elseif(DMLanguage == 2)then
outputChatBox("Du hast bereits einen Hund!", 255, 0,0)
end
else
if(DMDogPanel == true)then
removeEventHandler("onClientRender", getRootElement(), DMDogPanelGui)
DMDogPanel = false 

guiSetVisible(DMDogPanelButton1, false)
guiSetVisible(DMDogPanelButton2, false)
guiSetVisible(DMDogPanelButton3, false)
guiSetVisible(DMDogPanelButton4, false)
guiSetVisible(DMDogPanelButton5, false)
guiSetVisible(DMDogPanelButton6, false)
guiSetVisible(DMDogPanelButton7, false)

showCursor(false)
end

--setTime( 12, 1 )
DMCreatorActive = true
local player = getLocalPlayer()

DMPlayerSkin = getElementModel(player)
DMPlayerx, DMPlayery, DMPlayerz = getElementPosition(player)
setElementInterior ( player, 20, 0, 0, 0)
setElementPosition( player, 0, -1, -2)
setElementFrozen ( player, true )

setCameraMatrix(0, -3, 0, 0.1, 0.3, -0.2)
showCursor(true)
guiSetInputEnabled(true)

DMDogRace = 290
DMDogCreationGender = "male"
DMDogCreationColorR = 51
DMDogCreationColorG = 204
DMDogCreationColorB = 255

addEventHandler("onClientRender", getRootElement(), DMDogCreationGui)
guiSetVisible(DMDogNameEdit, true)
guiSetVisible(DMDogNameButton1, true)
guiSetVisible(DMDogNameButton2, true)
guiSetVisible(DMDogNameButton3, true)
guiSetVisible(DMDogNameButton4, true)
guiSetVisible(DMDogNameButton5, true)
guiSetVisible(DMDogNameButton6, true)
guiSetVisible(DMDogNameButton7, true)
end
end

function DMDogCreationRaceLeft()
if(DMDogRace == 290 or DMDogRace == 291 or DMDogRace == 292)then
  DMDogRace = 299
elseif(DMDogRace == 293 or DMDogRace == 294 or DMDogRace == 295 or DMDogRace == 296)then
  DMDogRace = 290
elseif(DMDogRace == 297 or DMDogRace == 298)then
  DMDogRace = 293
elseif(DMDogRace == 299)then
  DMDogRace = 297
end

destroyElement(DMDogCreatorPed)
DMDogCreatorPed = createPed( DMDogRace , 0.1, 0.3, -0.2 , 90)
setElementInterior ( DMDogCreatorPed, 20, 0.1, 0.3, -0.2)
end

function DMDogCreationRaceRight()
if(DMDogRace == 290 or DMDogRace == 291 or DMDogRace == 292)then
  DMDogRace = 293
elseif(DMDogRace == 293 or DMDogRace == 294 or DMDogRace == 295 or DMDogRace == 296)then
  DMDogRace = 297
elseif(DMDogRace == 297 or DMDogRace == 298)then
  DMDogRace = 299
elseif(DMDogRace == 299)then
  DMDogRace = 290
end

destroyElement(DMDogCreatorPed)
DMDogCreatorPed = createPed( DMDogRace , 0.1, 0.3, -0.2 , 90)
setElementInterior ( DMDogCreatorPed, 20, 0.1, 0.3, -0.2)
end

function DMDogCreationSizeLeft()
if(DMDogRace == 290)then
DMDogRace = 292
elseif(DMDogRace == 291)then
DMDogRace = 290
elseif(DMDogRace == 292)then
DMDogRace = 291

elseif(DMDogRace == 293)then
DMDogRace = 296
elseif(DMDogRace == 294)then
DMDogRace = 293
elseif(DMDogRace == 295)then
DMDogRace = 294
elseif(DMDogRace == 296)then
DMDogRace = 295

elseif(DMDogRace == 297)then
DMDogRace = 298
elseif(DMDogRace == 298)then
DMDogRace = 297
end

destroyElement(DMDogCreatorPed)
DMDogCreatorPed = createPed( DMDogRace , 0.1, 0.3, -0.2 , 90)
setElementInterior ( DMDogCreatorPed, 20, 0.1, 0.3, -0.2)
end

function DMDogCreationSizeRight()
if(DMDogRace == 290)then
DMDogRace = 291
elseif(DMDogRace == 291)then
DMDogRace = 292
elseif(DMDogRace == 292)then
DMDogRace = 290

elseif(DMDogRace == 293)then
DMDogRace = 294
elseif(DMDogRace == 294)then
DMDogRace = 295
elseif(DMDogRace == 295)then
DMDogRace = 296
elseif(DMDogRace == 296)then
DMDogRace = 293

elseif(DMDogRace == 297)then
DMDogRace = 298
elseif(DMDogRace == 298)then
DMDogRace = 297
end

destroyElement(DMDogCreatorPed)
DMDogCreatorPed = createPed( DMDogRace , 0.1, 0.3, -0.2 , 90)
setElementInterior ( DMDogCreatorPed, 20, 0.1, 0.3, -0.2)
end

function DMDogCreationGender()
if(source == DMDogNameButton6)then
DMDogCreationGender = "male"
DMDogCreationColorR = 51
DMDogCreationColorG = 204
DMDogCreationColorB = 255
elseif(source == DMDogNameButton7)then
DMDogCreationGender = "female"
DMDogCreationColorR = 255
DMDogCreationColorG = 51
DMDogCreationColorB = 204
end
end

function DMDogCreationGui()
if(DMLanguage == 1)then
dxDrawRectangle(0.78 * DMScreenx, 0.3 * DMScreeny, 0.17 * DMScreenx, 0.42 * DMScreeny, tocolor(20, 20, 20, 220))
dxDrawText("Sakhtane Sag", 0.785 * DMScreenx, 0.315 * DMScreeny, nil, nil, tocolor(DMDogCreationColorR, DMDogCreationColorG, DMDogCreationColorB, 220), DMTextSizex, DMTextSizey, "default-bold", "left", "center")

dxDrawText("Esm", 0.785 * DMScreenx, 0.34 * DMScreeny, nil, nil, tocolor(255, 255, 255, 220), DMTextSizex, DMTextSizey, "pricedown", "left", "center")
dxDrawRectangle(0.789 * DMScreenx, 0.361 * DMScreeny, 0.152 * DMScreenx, 0.048 * DMScreeny, tocolor(DMDogCreationColorR, DMDogCreationColorG, DMDogCreationColorB, 220))

dxDrawText("Nezhad", 0.785 * DMScreenx, 0.43 * DMScreeny, nil, nil, tocolor(255, 255, 255, 220), DMTextSizex, DMTextSizey, "pricedown", "left", "center")
dxDrawRectangle(0.789 * DMScreenx, 0.451 * DMScreeny, 0.152 * DMScreenx, 0.048 * DMScreeny, tocolor(DMDogCreationColorR, DMDogCreationColorG, DMDogCreationColorB, 220))
dxDrawText("<", 0.789 * DMScreenx, 0.45 * DMScreeny, 0.809 * DMScreenx, 0.51 * DMScreeny, tocolor(0, 0, 0, 220), DMTextSizex, DMTextSizey, "pricedown", "center", "center")
dxDrawText(">", 0.922 * DMScreenx, 0.45 * DMScreeny, 0.942 * DMScreenx, 0.51 * DMScreeny, tocolor(0, 0, 0, 220), DMTextSizex, DMTextSizey, "pricedown", "center", "center")

local DMRaceText
if(DMDogRace == 290 or DMDogRace == 291 or DMDogRace == 292)then
DMRaceText = "Sheperd"
elseif(DMDogRace == 293 or DMDogRace == 294 or DMDogRace == 295 or DMDogRace == 296)then
DMRaceText = "Pitbull"
elseif(DMDogRace == 297 or DMDogRace == 298)then
DMRaceText = "Golden Retriever"
elseif(DMDogRace == 299)then
DMRaceText = "Rottweiler"
end
dxDrawText(DMRaceText, 0.789 * DMScreenx, 0.451 * DMScreeny, 0.9412 * DMScreenx, 0.499 * DMScreeny, tocolor(255, 255, 255, 220), DMTextSizex, DMTextSizey, "default-bold", "center", "center")

dxDrawText("Range Sag", 0.785 * DMScreenx, 0.52 * DMScreeny, nil, nil, tocolor(255, 255, 255, 220), DMTextSizex, DMTextSizey, "pricedown", "left", "center")
dxDrawRectangle(0.789 * DMScreenx, 0.541 * DMScreeny, 0.152 * DMScreenx, 0.048 * DMScreeny, tocolor(DMDogCreationColorR, DMDogCreationColorG, DMDogCreationColorB, 220))
dxDrawText("<", 0.789 * DMScreenx, 0.54 * DMScreeny, 0.809 * DMScreenx, 0.6 * DMScreeny, tocolor(0, 0, 0, 220), DMTextSizex, DMTextSizey, "pricedown", "center", "center")
dxDrawText(">", 0.922 * DMScreenx, 0.54 * DMScreeny, 0.942 * DMScreenx, 0.6 * DMScreeny, tocolor(0, 0, 0, 220), DMTextSizex, DMTextSizey, "pricedown", "center", "center")
local DMFurColorText
if(DMDogRace == 290)then
DMFurColorText = "Meshki"
elseif(DMDogRace == 291)then
DMFurColorText = "Meshki Va Sefid"
elseif(DMDogRace == 292)then
DMFurColorText = "Meshki Va Ghahvei"
elseif(DMDogRace == 293)then
DMFurColorText = "Ghahvei"
elseif(DMDogRace == 294)then
DMFurColorText = "Sefid"
elseif(DMDogRace == 295)then
DMFurColorText = "Khakestari"
elseif(DMDogRace == 296)then
DMFurColorText = "Meshki Va Sefid"
elseif(DMDogRace == 297)then
DMFurColorText = "Ghahvei"
elseif(DMDogRace == 298)then
DMFurColorText = "Sefid"
elseif(DMDogRace == 299)then
DMFurColorText = "Meshki Va Ghahvei"
end
dxDrawText(DMFurColorText, 0.789 * DMScreenx, 0.541 * DMScreeny, 0.9412 * DMScreenx, 0.589 * DMScreeny, tocolor(255, 255, 255, 220), DMTextSizex, DMTextSizey, "default-bold", "center", "center")

dxDrawText("Jensiyat", 0.785 * DMScreenx, 0.61 * DMScreeny, nil, nil, tocolor(255, 255, 255, 220), DMTextSizex, DMTextSizey, "pricedown", "left", "center")
dxDrawText("Pesar", 0.83 * DMScreenx, 0.630 * DMScreeny, nil, nil, tocolor(255, 255, 255, 220), DMTextSizex, DMTextSizey, "pricedown", "center")
dxDrawText("Dokhtar", 0.89 * DMScreenx, 0.630 * DMScreeny, nil, nil, tocolor(255, 255, 255, 220), DMTextSizex, DMTextSizey, "pricedown", "center")

dxDrawImage(0.9 * DMScreenx, 0.67 * DMScreeny, 80 * DMImagex, 50 * DMImagey, texture5  )
dxDrawText("Tamaam", 0.9 * DMScreenx, 0.675 * DMScreeny, DMScreenx * 0.943, DMScreeny * 0.713, tocolor(3, 252, 252, 220), DMTextSizex * 0.7, DMTextSizey * 0.7, "beckett", "center", "center")

elseif(DMLanguage == 2)then
dxDrawRectangle(0.78 * DMScreenx, 0.3 * DMScreeny, 0.17 * DMScreenx, 0.42 * DMScreeny, tocolor(20, 20, 20, 220))
dxDrawText("Hund erschaffen", 0.785 * DMScreenx, 0.315 * DMScreeny, nil, nil, tocolor(DMDogCreationColorR, DMDogCreationColorG, DMDogCreationColorB, 220), DMTextSizex, DMTextSizey, "default-bold", "left", "center")

dxDrawText("Name", 0.785 * DMScreenx, 0.34 * DMScreeny, nil, nil, tocolor(255, 255, 255, 220), DMTextSizex, DMTextSizey, "pricedown", "left", "center")
dxDrawRectangle(0.789 * DMScreenx, 0.361 * DMScreeny, 0.152 * DMScreenx, 0.048 * DMScreeny, tocolor(DMDogCreationColorR, DMDogCreationColorG, DMDogCreationColorB, 220))

dxDrawText("Rasse", 0.785 * DMScreenx, 0.43 * DMScreeny, nil, nil, tocolor(255, 255, 255, 220), DMTextSizex, DMTextSizey, "pricedown", "left", "center")
dxDrawRectangle(0.789 * DMScreenx, 0.451 * DMScreeny, 0.152 * DMScreenx, 0.048 * DMScreeny, tocolor(DMDogCreationColorR, DMDogCreationColorG, DMDogCreationColorB, 220))
dxDrawText("<", 0.789 * DMScreenx, 0.45 * DMScreeny, 0.809 * DMScreenx, 0.51 * DMScreeny, tocolor(0, 0, 0, 220), DMTextSizex, DMTextSizey, "pricedown", "center", "center")
dxDrawText(">", 0.922 * DMScreenx, 0.45 * DMScreeny, 0.942 * DMScreenx, 0.51 * DMScreeny, tocolor(0, 0, 0, 220), DMTextSizex, DMTextSizey, "pricedown", "center", "center")

local DMRaceText
if(DMDogRace == 290 or DMDogRace == 291 or DMDogRace == 292)then
DMRaceText = "Schäferhund"
elseif(DMDogRace == 293 or DMDogRace == 294 or DMDogRace == 295 or DMDogRace == 296)then
DMRaceText = "Pitbull"
elseif(DMDogRace == 297 or DMDogRace == 298)then
DMRaceText = "Golden Retriever"
elseif(DMDogRace == 299)then
DMRaceText = "Rottweiler"
end
dxDrawText(DMRaceText, 0.789 * DMScreenx, 0.451 * DMScreeny, 0.9412 * DMScreenx, 0.499 * DMScreeny, tocolor(255, 255, 255, 220), DMTextSizex, DMTextSizey, "default-bold", "center", "center")

dxDrawText("Fellfarbe", 0.785 * DMScreenx, 0.52 * DMScreeny, nil, nil, tocolor(255, 255, 255, 220), DMTextSizex, DMTextSizey, "pricedown", "left", "center")
dxDrawRectangle(0.789 * DMScreenx, 0.541 * DMScreeny, 0.152 * DMScreenx, 0.048 * DMScreeny, tocolor(DMDogCreationColorR, DMDogCreationColorG, DMDogCreationColorB, 220))
dxDrawText("<", 0.789 * DMScreenx, 0.54 * DMScreeny, 0.809 * DMScreenx, 0.6 * DMScreeny, tocolor(0, 0, 0, 220), DMTextSizex, DMTextSizey, "pricedown", "center", "center")
dxDrawText(">", 0.922 * DMScreenx, 0.54 * DMScreeny, 0.942 * DMScreenx, 0.6 * DMScreeny, tocolor(0, 0, 0, 220), DMTextSizex, DMTextSizey, "pricedown", "center", "center")
local DMFurColorText
if(DMDogRace == 290)then
DMFurColorText = "Schwarz"
elseif(DMDogRace == 291)then
DMFurColorText = "Schwarz & Weiß"
elseif(DMDogRace == 292)then
DMFurColorText = "Schwarz & Braun"
elseif(DMDogRace == 293)then
DMFurColorText = "Braun"
elseif(DMDogRace == 294)then
DMFurColorText = "Weiß"
elseif(DMDogRace == 295)then
DMFurColorText = "Grau"
elseif(DMDogRace == 296)then
DMFurColorText = "Schwarz & Weiß"
elseif(DMDogRace == 297)then
DMFurColorText = "Braun"
elseif(DMDogRace == 298)then
DMFurColorText = "Weiß"
elseif(DMDogRace == 299)then
DMFurColorText = "Schwarz & Braun"
end
dxDrawText(DMFurColorText, 0.789 * DMScreenx, 0.541 * DMScreeny, 0.9412 * DMScreenx, 0.589 * DMScreeny, tocolor(255, 255, 255, 220), DMTextSizex, DMTextSizey, "default-bold", "center", "center")

dxDrawText("Geschlecht", 0.785 * DMScreenx, 0.61 * DMScreeny, nil, nil, tocolor(255, 255, 255, 220), DMTextSizex, DMTextSizey, "pricedown", "left", "center")
dxDrawImage(0.82 * DMScreenx, 0.625 * DMScreeny, 40 * DMImagex, 35 * DMImagey, texture7  )
dxDrawImage(0.88 * DMScreenx, 0.625 * DMScreeny, 45 * DMImagex, 40 * DMImagey, texture8  )

dxDrawImage(0.9 * DMScreenx, 0.67 * DMScreeny, 80 * DMImagex, 50 * DMImagey, texture5  )
dxDrawText("Fertig", 0.9 * DMScreenx, 0.675 * DMScreeny, DMScreenx * 0.943, DMScreeny * 0.713, tocolor(0, 0, 0, 220), DMTextSizex * 0.7, DMTextSizey * 0.7, "beckett", "center", "center")
end
end

function DMDogCreationInteractives()
DMDogNameEdit = guiCreateEdit ( 0.79 * DMScreenx, 0.365 * DMScreeny, 0.15 * DMScreenx, 0.04 * DMScreeny, "", false)
guiSetAlpha(DMDogNameEdit, 0.8)
guiSetVisible(DMDogNameEdit, false)
guiEditSetMaxLength ( DMDogNameEdit, 12)

DMDogNameButton1 = guiCreateButton ( 0.789 * DMScreenx, 0.45 * DMScreeny, 0.02 * DMScreenx, 0.05 * DMScreeny, "<", false)
DMDogNameButton2 = guiCreateButton ( 0.922 * DMScreenx, 0.45 * DMScreeny, 0.02 * DMScreenx, 0.05 * DMScreeny, ">", false)
guiSetVisible(DMDogNameButton1, false)
guiSetVisible(DMDogNameButton2, false)
guiSetAlpha(DMDogNameButton1, 0)
guiSetAlpha(DMDogNameButton2, 0)

DMDogNameButton3 = guiCreateButton ( 0.789 * DMScreenx, 0.54 * DMScreeny, 0.02 * DMScreenx, 0.05 * DMScreeny, "<", false)
DMDogNameButton4 = guiCreateButton ( 0.922 * DMScreenx, 0.54 * DMScreeny, 0.02 * DMScreenx, 0.05 * DMScreeny, ">", false)
guiSetVisible(DMDogNameButton3, false)
guiSetVisible(DMDogNameButton4, false)
guiSetAlpha(DMDogNameButton3, 0)
guiSetAlpha(DMDogNameButton4, 0)

DMDogNameButton6 = guiCreateButton ( 0.82 * DMScreenx, 0.625 * DMScreeny, 0.025 * DMScreenx, 0.035 * DMScreeny, "M", false)
DMDogNameButton7 = guiCreateButton ( 0.88 * DMScreenx, 0.625 * DMScreeny, 0.025 * DMScreenx, 0.035 * DMScreeny, "W", false)
guiSetVisible(DMDogNameButton6, false)
guiSetVisible(DMDogNameButton7, false)
guiSetAlpha(DMDogNameButton6, 0)
guiSetAlpha(DMDogNameButton7, 0)

DMDogNameButton5 = guiCreateButton ( 0.9 * DMScreenx, 0.67 * DMScreeny, 0.043 * DMScreenx, 0.043 * DMScreeny, "Done", false)
guiSetVisible(DMDogNameButton5, false)
guiSetAlpha(DMDogNameButton5, 0)

addEventHandler ( "onClientGUIClick", DMDogNameButton5, DMCreateDogDone, false )
addEventHandler ( "onClientGUIClick", DMDogNameButton1, DMDogCreationRaceLeft, false )
addEventHandler ( "onClientGUIClick", DMDogNameButton2, DMDogCreationRaceRight, false )
addEventHandler ( "onClientGUIClick", DMDogNameButton3, DMDogCreationSizeLeft, false )
addEventHandler ( "onClientGUIClick", DMDogNameButton4, DMDogCreationSizeRight, false )
addEventHandler ( "onClientGUIClick", DMDogNameButton6, DMDogCreationGender, false )
addEventHandler ( "onClientGUIClick", DMDogNameButton7, DMDogCreationGender, false )
end

function DMCreateDogDone()
local DMDogName = guiGetText(DMDogNameEdit)
local DMNameLenght = string.len (DMDogName)

if(DMNameLenght < 3)then
if(DMLanguage == 1)then
outputChatBox("Esm Kootah Mibashad", 255,0,0)
elseif(DMLanguage == 2)then
outputChatBox("Name zu kurz", 255,0,0)
end

else
local player = getLocalPlayer()
setElementFrozen ( player, false)

guiSetInputEnabled(false)
showCursor(false)
removeEventHandler("onClientRender", getRootElement(), DMDogCreationGui)
guiSetVisible(DMDogNameEdit, false)
guiSetVisible(DMDogNameButton1, false)
guiSetVisible(DMDogNameButton2, false)
guiSetVisible(DMDogNameButton3, false)
guiSetVisible(DMDogNameButton4, false)
guiSetVisible(DMDogNameButton5, false)
guiSetVisible(DMDogNameButton6, false)
guiSetVisible(DMDogNameButton7, false)

triggerServerEvent("DMCreateDogSubmit", getRootElement(), DMDogRace, DMDogName, DMPlayerx, DMPlayery, DMPlayerz, DMPlayerSkin, DMDogCreationGender)
triggerServerEvent("DMCheckOwner", getRootElement())
DMCreatorActive = false
end
end

--DOG PANEL
function DMDogPanelGui()
if(DMLanguage == 1)then
if(DMClientOwnerGotDog == true)then
if(DMDogDeathRevive == false)then
dxDrawRectangle(0.78 * DMScreenx, 0.3 * DMScreeny, 0.17 * DMScreenx, 0.37 * DMScreeny, tocolor(20, 20, 20, 220))
dxDrawText("Dog Panel", 0.785 * DMScreenx, 0.315 * DMScreeny, nil, nil, tocolor(DMClientDogGenderColorR, DMClientDogGenderColorG, DMClientDogGenderColorB, 220), DMTextSizex, DMTextSizey, "default-bold", "left", "center")
dxDrawText("Sage Shoma Mord!", 0.78 * DMScreenx, 0.37 * DMScreeny, 0.95 * DMScreenx, 0.37 * DMScreeny, tocolor(255, 255, 255, 220), DMTextSizex, DMTextSizey, "pricedown", "center", "center")
dxDrawText("Ehya: "..(180 - DMDogDeathTimerCount).." Saniye Digar.", 0.78 * DMScreenx, 0.395 * DMScreeny,0.95 * DMScreenx, 0.395 * DMScreeny, tocolor(255, 255, 255, 220), DMTextSizex * 1.2, DMTextSizey * 1.2, "default-bold", "center", "center")
elseif(DMDogDeathRevive == true)then
dxDrawRectangle(0.78 * DMScreenx, 0.3 * DMScreeny, 0.17 * DMScreenx, 0.37 * DMScreeny, tocolor(20, 20, 20, 220))
dxDrawText("Dog Panel", 0.785 * DMScreenx, 0.315 * DMScreeny, nil, nil, tocolor(DMClientDogGenderColorR, DMClientDogGenderColorG, DMClientDogGenderColorB, 220), DMTextSizex, DMTextSizey, "default-bold", "left", "center")
dxDrawText("?", 0.94 * DMScreenx, 0.315 * DMScreeny, nil, nil, tocolor(DMClientDogGenderColorR, DMClientDogGenderColorG, DMClientDogGenderColorB, 220), DMTextSizex * 1.3, DMTextSizey * 1.3, "default-bold", "left", "center")

dxDrawLine(0.78 *DMScreenx, 0.33 * DMScreeny, 0.95 * DMScreenx, 0.33 * DMScreeny, tocolor(255, 255, 255, 220))
dxDrawLine(0.78 *DMScreenx, 0.39 * DMScreeny, 0.95 * DMScreenx, 0.39 * DMScreeny, tocolor(255, 255, 255, 220))
dxDrawText(DMClientDogName, 0.79 * DMScreenx, 0.335 * DMScreeny, 0.941 * DMScreenx, 0.385 * DMScreeny, tocolor(255, 255, 255, 220), DMTextSizex * 1.3, DMTextSizey * 1.3 , "pricedown", "center", "center")

local DMHealth = DMRound(DMClientDogFitness, 1)
dxDrawText("Amaar:", 0.785 * DMScreenx, 0.42 * DMScreeny, nil, nil, tocolor(DMClientDogGenderColorR, DMClientDogGenderColorG, DMClientDogGenderColorB, 220), DMTextSizex, DMTextSizey, "default-bold", "left", "center")
if(DMClientDogGender == "male")then
dxDrawText("Maharat:  #33CCFF"..DMHealth.."#FFFFFF / 100", 0.79 * DMScreenx, 0.445 * DMScreeny, nil, nil, tocolor(255, 225, 255, 220), DMTextSizex, DMTextSizey, "default-bold", "left", "center",nil,nil,nil,true)
elseif(DMClientDogGender == "female")then
dxDrawText("Maharat:  #FF33CC"..DMHealth.."#FFFFFF / 100", 0.79 * DMScreenx, 0.445 * DMScreeny, nil, nil, tocolor(255, 225, 255, 220), DMTextSizex, DMTextSizey, "default-bold", "left", "center",nil,nil,nil,true)
end
if(DMClientDogGender == "male")then
dxDrawText("Ghodrat:  #33CCFF"..DMClientDogStrength.."#FFFFFF / 100", 0.79 * DMScreenx, 0.465 * DMScreeny, nil, nil, tocolor(255, 255, 255, 220), DMTextSizex, DMTextSizey, "default-bold", "left", "center",nil,nil,nil,true)
elseif(DMClientDogGender == "female")then
dxDrawText("Ghodrat:  #FF33CC"..DMClientDogStrength.."#FFFFFF / 100", 0.79 * DMScreenx, 0.465 * DMScreeny, nil, nil, tocolor(255, 255, 255, 220), DMTextSizex, DMTextSizey, "default-bold", "left", "center",nil,nil,nil,true)
end

dxDrawText("Fehrest:", 0.785 * DMScreenx, 0.505 * DMScreeny, nil, nil, tocolor(DMClientDogGenderColorR, DMClientDogGenderColorG, DMClientDogGenderColorB, 220), DMTextSizex, DMTextSizey, "default-bold", "left", "center")
dxDrawText("Toop", 0.79 * DMScreenx, 0.53 * DMScreeny, nil, nil, tocolor(255, 255, 255, 220), DMTextSizex, DMTextSizey, "default-bold", "left", "center")
dxDrawText("Ghaza", 0.79 * DMScreenx, 0.55 * DMScreeny, nil, nil, tocolor(255, 255, 255, 220), DMTextSizex, DMTextSizey, "default-bold", "left", "center")

if(DMDogSpawned == true and DMPlayerInFight == false)then
if(DMClientDogGender == "male")then
dxDrawRectangle(0.92 * DMScreenx, 0.52 * DMScreeny, 0.021 * DMScreenx, 0.015 * DMScreeny, tocolor( DMClientDogGenderColorR, DMClientDogGenderColorG, DMClientDogGenderColorB, 255))
elseif(DMClientDogGender == "female")then
dxDrawRectangle(0.92 * DMScreenx, 0.52 * DMScreeny, 0.021 * DMScreenx, 0.015 * DMScreeny, tocolor( DMClientDogGenderColorR, DMClientDogGenderColorG, DMClientDogGenderColorB, 255))
end
else
if(DMClientDogGender == "male")then
dxDrawRectangle(0.92 * DMScreenx, 0.52 * DMScreeny, 0.021 * DMScreenx, 0.015 * DMScreeny, tocolor( 83, 154, 172, 255))
elseif(DMClientDogGender == "female")then
dxDrawRectangle(0.92 * DMScreenx, 0.52 * DMScreeny, 0.021 * DMScreenx, 0.015 * DMScreeny, tocolor( 172, 83, 154, 255))
end
end
if(DMDogSpawned == true and DMFeedActive == 0 and DMPlayerInFight == false)then
if(DMClientDogGender == "male")then
dxDrawRectangle(0.92 * DMScreenx, 0.54 * DMScreeny, 0.021 * DMScreenx, 0.015 * DMScreeny, tocolor( DMClientDogGenderColorR, DMClientDogGenderColorG, DMClientDogGenderColorB, 255))
elseif(DMClientDogGender == "female")then
dxDrawRectangle(0.92 * DMScreenx, 0.54 * DMScreeny, 0.021 * DMScreenx, 0.015 * DMScreeny, tocolor( DMClientDogGenderColorR, DMClientDogGenderColorG, DMClientDogGenderColorB, 255))
end
else
if(DMClientDogGender == "male")then
dxDrawRectangle(0.92 * DMScreenx, 0.54 * DMScreeny, 0.021 * DMScreenx, 0.015 * DMScreeny, tocolor(83, 154, 172, 255))
elseif(DMClientDogGender == "female")then
dxDrawRectangle(0.92 * DMScreenx, 0.54 * DMScreeny, 0.021 * DMScreenx, 0.015 * DMScreeny, tocolor(172, 83, 154, 255))
end
end

dxDrawText("Estefade", 0.92 * DMScreenx, 0.52 * DMScreeny, 0.941 * DMScreenx, 0.535 * DMScreeny, tocolor(0, 0, 0, 220), DMTextSizex, DMTextSizey, "default-bold", "center", "center")
dxDrawText("Estefade", 0.92 * DMScreenx, 0.54 * DMScreeny, 0.941 * DMScreenx, 0.555 * DMScreeny, tocolor(0, 0, 0, 220), DMTextSizex, DMTextSizey, "default-bold", "center", "center")

dxDrawImage(0.791 * DMScreenx, 0.61 * DMScreeny, 80 * DMImagex, 50 * DMImagey, texture5  )
if(DMDogSpawned == true and DMPlayerInFight == false)then
dxDrawImage(0.844 * DMScreenx, 0.61 * DMScreeny, 80 * DMImagex, 50 * DMImagey, texture5  )
else
dxDrawImage(0.844 * DMScreenx, 0.61 * DMScreeny, 80 * DMImagex, 50 * DMImagey, texture6  )
end
if(DMDogSpawned == true and DMPlayerInFight == false)then
dxDrawImage(0.897 * DMScreenx, 0.61 * DMScreeny, 80 * DMImagex, 50 * DMImagey, texture5  )
else
dxDrawImage(0.897 * DMScreenx, 0.61 * DMScreeny, 80 * DMImagex, 50 * DMImagey, texture6  )
end

local DMSpawnText
if(DMDogSpawned == false)then
DMSpawnText = "Namayesh"
elseif(DMDogSpawned == true)then
DMSpawnText = "Makhfi"
end
dxDrawText(DMSpawnText, 0.791 * DMScreenx, 0.613 * DMScreeny, DMScreenx * 0.833, DMScreeny * 0.653, tocolor(3, 252, 252, 220), DMTextSizex * 0.7, DMTextSizey * 0.7, "beckett", "center", "center")
dxDrawText("Kaar ha", 0.844 * DMScreenx, 0.613 * DMScreeny, DMScreenx * 0.885, DMScreeny * 0.653, tocolor(3, 252, 252, 220), DMTextSizex * 0.7, DMTextSizey * 0.7, "beckett", "center", "center")
dxDrawText("Tarfand Ha", 0.897 * DMScreenx, 0.613 * DMScreeny, DMScreenx * 0.939, DMScreeny * 0.653, tocolor(3, 252, 252, 220), DMTextSizex * 0.7, DMTextSizey * 0.7, "beckett", "center", "center")
end

elseif(DMClientOwnerGotDog == false)then
dxDrawRectangle(0.78 * DMScreenx, 0.3 * DMScreeny, 0.17 * DMScreenx, 0.37 * DMScreeny, tocolor(25, 25, 25, 220))
dxDrawText("Dog Panel", 0.785 * DMScreenx, 0.315 * DMScreeny, nil, nil, tocolor(51, 204, 255, 220), DMTextSizex, DMTextSizey, "default-bold", "left", "center")
dxDrawText("Shoma Sag Nadarid", 0.78 * DMScreenx, 0.37 * DMScreeny, 0.95 * DMScreenx, 0.37 * DMScreeny, tocolor(255, 255, 255, 220), DMTextSizex, DMTextSizey, "pricedown", "center", "center")
dxDrawText("Ba /dog Yeki Besazid", 0.78 * DMScreenx, 0.395 * DMScreeny,0.95 * DMScreenx, 0.395 * DMScreeny, tocolor(255, 255, 255, 220), DMTextSizex * 1.2, DMTextSizey * 1.2, "default-bold", "center", "center")
end
elseif(DMLanguage == 2)then
if(DMClientOwnerGotDog == true)then
if(DMDogDeathRevive == false)then
dxDrawRectangle(0.78 * DMScreenx, 0.3 * DMScreeny, 0.17 * DMScreenx, 0.37 * DMScreeny, tocolor(20, 20, 20, 220))
dxDrawText("Hunde Panel", 0.785 * DMScreenx, 0.315 * DMScreeny, nil, nil, tocolor(DMClientDogGenderColorR, DMClientDogGenderColorG, DMClientDogGenderColorB, 220), DMTextSizex, DMTextSizey, "default-bold", "left", "center")
dxDrawText("Dein Hund ist Tod!", 0.78 * DMScreenx, 0.37 * DMScreeny, 0.95 * DMScreenx, 0.37 * DMScreeny, tocolor(255, 255, 255, 220), DMTextSizex, DMTextSizey, "pricedown", "center", "center")
dxDrawText("Wiederbeleben in "..(180 - DMDogDeathTimerCount).." secs", 0.78 * DMScreenx, 0.395 * DMScreeny,0.95 * DMScreenx, 0.395 * DMScreeny, tocolor(255, 255, 255, 220), DMTextSizex * 1.2, DMTextSizey * 1.2, "default-bold", "center", "center")
elseif(DMDogDeathRevive == true)then
dxDrawRectangle(0.78 * DMScreenx, 0.3 * DMScreeny, 0.17 * DMScreenx, 0.37 * DMScreeny, tocolor(20, 20, 20, 220))
dxDrawText("Hundel Panel", 0.785 * DMScreenx, 0.315 * DMScreeny, nil, nil, tocolor(DMClientDogGenderColorR, DMClientDogGenderColorG, DMClientDogGenderColorB, 220), DMTextSizex, DMTextSizey, "default-bold", "left", "center")
dxDrawText("?", 0.94 * DMScreenx, 0.315 * DMScreeny, nil, nil, tocolor(DMClientDogGenderColorR, DMClientDogGenderColorG, DMClientDogGenderColorB, 220), DMTextSizex * 1.3, DMTextSizey * 1.3, "default-bold", "left", "center")

dxDrawLine(0.78 *DMScreenx, 0.33 * DMScreeny, 0.95 * DMScreenx, 0.33 * DMScreeny, tocolor(255, 255, 255, 220))
dxDrawLine(0.78 *DMScreenx, 0.39 * DMScreeny, 0.95 * DMScreenx, 0.39 * DMScreeny, tocolor(255, 255, 255, 220))
dxDrawText(DMClientDogName, 0.79 * DMScreenx, 0.335 * DMScreeny, 0.941 * DMScreenx, 0.385 * DMScreeny, tocolor(255, 255, 255, 220), DMTextSizex * 1.3, DMTextSizey * 1.3 , "pricedown", "center", "center")

local DMHealth = DMRound(DMClientDogFitness, 1)
dxDrawText("Statistiken:", 0.785 * DMScreenx, 0.42 * DMScreeny, nil, nil, tocolor(DMClientDogGenderColorR, DMClientDogGenderColorG, DMClientDogGenderColorB, 220), DMTextSizex, DMTextSizey, "default-bold", "left", "center")
if(DMClientDogGender == "male")then
dxDrawText("Fitness:  #33CCFF"..DMHealth.."#FFFFFF / 100", 0.79 * DMScreenx, 0.445 * DMScreeny, nil, nil, tocolor(255, 225, 255, 220), DMTextSizex, DMTextSizey, "default-bold", "left", "center",nil,nil,nil,true)
elseif(DMClientDogGender == "female")then
dxDrawText("Fitness:  #FF33CC"..DMHealth.."#FFFFFF / 100", 0.79 * DMScreenx, 0.445 * DMScreeny, nil, nil, tocolor(255, 225, 255, 220), DMTextSizex, DMTextSizey, "default-bold", "left", "center",nil,nil,nil,true)
end
if(DMClientDogGender == "male")then
dxDrawText("Stärke:  #33CCFF"..DMClientDogStrength.."#FFFFFF / 100", 0.79 * DMScreenx, 0.465 * DMScreeny, nil, nil, tocolor(255, 255, 255, 220), DMTextSizex, DMTextSizey, "default-bold", "left", "center",nil,nil,nil,true)
elseif(DMClientDogGender == "female")then
dxDrawText("Stärke:  #FF33CC"..DMClientDogStrength.."#FFFFFF / 100", 0.79 * DMScreenx, 0.465 * DMScreeny, nil, nil, tocolor(255, 255, 255, 220), DMTextSizex, DMTextSizey, "default-bold", "left", "center",nil,nil,nil,true)
end

dxDrawText("Inventar:", 0.785 * DMScreenx, 0.505 * DMScreeny, nil, nil, tocolor(DMClientDogGenderColorR, DMClientDogGenderColorG, DMClientDogGenderColorB, 220), DMTextSizex, DMTextSizey, "default-bold", "left", "center")
dxDrawText("Ball", 0.79 * DMScreenx, 0.53 * DMScreeny, nil, nil, tocolor(255, 255, 255, 220), DMTextSizex, DMTextSizey, "default-bold", "left", "center")
dxDrawText("Hundefutter", 0.79 * DMScreenx, 0.55 * DMScreeny, nil, nil, tocolor(255, 255, 255, 220), DMTextSizex, DMTextSizey, "default-bold", "left", "center")

if(DMDogSpawned == true and DMPlayerInFight == false)then
if(DMClientDogGender == "male")then
dxDrawRectangle(0.915 * DMScreenx, 0.52 * DMScreeny, 0.03 * DMScreenx, 0.015 * DMScreeny, tocolor( DMClientDogGenderColorR, DMClientDogGenderColorG, DMClientDogGenderColorB, 255))
elseif(DMClientDogGender == "female")then
dxDrawRectangle(0.915 * DMScreenx, 0.52 * DMScreeny, 0.03 * DMScreenx, 0.015 * DMScreeny, tocolor( DMClientDogGenderColorR, DMClientDogGenderColorG, DMClientDogGenderColorB, 255))
end
else
if(DMClientDogGender == "male")then
dxDrawRectangle(0.915 * DMScreenx, 0.52 * DMScreeny, 0.03 * DMScreenx, 0.015 * DMScreeny, tocolor( 83, 154, 172, 255))
elseif(DMClientDogGender == "female")then
dxDrawRectangle(0.915 * DMScreenx, 0.52 * DMScreeny, 0.03 * DMScreenx, 0.015 * DMScreeny, tocolor( 172, 83, 154, 255))
end
end
if(DMDogSpawned == true and DMFeedActive == 0 and DMPlayerInFight == false)then
if(DMClientDogGender == "male")then
dxDrawRectangle(0.915 * DMScreenx, 0.54 * DMScreeny, 0.03 * DMScreenx, 0.015 * DMScreeny, tocolor( DMClientDogGenderColorR, DMClientDogGenderColorG, DMClientDogGenderColorB, 255))
elseif(DMClientDogGender == "female")then
dxDrawRectangle(0.915 * DMScreenx, 0.54 * DMScreeny, 0.03 * DMScreenx, 0.015 * DMScreeny, tocolor( DMClientDogGenderColorR, DMClientDogGenderColorG, DMClientDogGenderColorB, 255))
end
else
if(DMClientDogGender == "male")then
dxDrawRectangle(0.915 * DMScreenx, 0.54 * DMScreeny, 0.03 * DMScreenx, 0.015 * DMScreeny, tocolor(83, 154, 172, 255))
elseif(DMClientDogGender == "female")then
dxDrawRectangle(0.915 * DMScreenx, 0.54 * DMScreeny, 0.03 * DMScreenx, 0.015 * DMScreeny, tocolor(172, 83, 154, 255))
end
end

dxDrawText("Benutzen", 0.92 * DMScreenx, 0.52 * DMScreeny, 0.941 * DMScreenx, 0.535 * DMScreeny, tocolor(0, 0, 0, 220), DMTextSizex, DMTextSizey, "default-bold", "center", "center")
dxDrawText("Benutzen", 0.92 * DMScreenx, 0.54 * DMScreeny, 0.941 * DMScreenx, 0.555 * DMScreeny, tocolor(0, 0, 0, 220), DMTextSizex, DMTextSizey, "default-bold", "center", "center")

dxDrawImage(0.791 * DMScreenx, 0.61 * DMScreeny, 80 * DMImagex, 50 * DMImagey, texture5  )
if(DMDogSpawned == true and DMPlayerInFight == false)then
dxDrawImage(0.844 * DMScreenx, 0.61 * DMScreeny, 80 * DMImagex, 50 * DMImagey, texture5  )
else
dxDrawImage(0.844 * DMScreenx, 0.61 * DMScreeny, 80 * DMImagex, 50 * DMImagey, texture6  )
end
if(DMDogSpawned == true and DMPlayerInFight == false)then
dxDrawImage(0.897 * DMScreenx, 0.61 * DMScreeny, 80 * DMImagex, 50 * DMImagey, texture5  )
else
dxDrawImage(0.897 * DMScreenx, 0.61 * DMScreeny, 80 * DMImagex, 50 * DMImagey, texture6  )
end

local DMSpawnText
if(DMDogSpawned == false)then
DMSpawnText = "Spawn"
elseif(DMDogSpawned == true)then
DMSpawnText = "Despawn"
end
dxDrawText(DMSpawnText, 0.791 * DMScreenx, 0.613 * DMScreeny, DMScreenx * 0.833, DMScreeny * 0.653, tocolor(0, 0, 0, 220), DMTextSizex * 0.7, DMTextSizey * 0.7, "beckett", "center", "center")
dxDrawText("Aufgaben", 0.844 * DMScreenx, 0.613 * DMScreeny, DMScreenx * 0.885, DMScreeny * 0.653, tocolor(0, 0, 0, 220), DMTextSizex * 0.7, DMTextSizey * 0.7, "beckett", "center", "center")
dxDrawText("Tricks", 0.897 * DMScreenx, 0.613 * DMScreeny, DMScreenx * 0.939, DMScreeny * 0.653, tocolor(0, 0, 0, 220), DMTextSizex * 0.7, DMTextSizey * 0.7, "beckett", "center", "center")
end

elseif(DMClientOwnerGotDog == false)then
dxDrawRectangle(0.78 * DMScreenx, 0.3 * DMScreeny, 0.17 * DMScreenx, 0.37 * DMScreeny, tocolor(25, 25, 25, 220))
dxDrawText("Hunde Panel", 0.785 * DMScreenx, 0.315 * DMScreeny, nil, nil, tocolor(51, 204, 255, 220), DMTextSizex, DMTextSizey, "default-bold", "left", "center")
dxDrawText("Du hast keinen Hund", 0.78 * DMScreenx, 0.37 * DMScreeny, 0.95 * DMScreenx, 0.37 * DMScreeny, tocolor(255, 255, 255, 220), DMTextSizex, DMTextSizey, "pricedown", "center", "center")
dxDrawText("Erstelle einen mit /dog", 0.78 * DMScreenx, 0.395 * DMScreeny,0.95 * DMScreenx, 0.395 * DMScreeny, tocolor(255, 255, 255, 220), DMTextSizex * 1.2, DMTextSizey * 1.2, "default-bold", "center", "center")
end
end
end

function DMDogPanel()
if(isPedInVehicle(getLocalPlayer()) == false)then
if(DMDogPanel == false and DMTricksDogPanel == false and DMTricksTutorialActive == false and DMDogPanel == false and DMHelpActive == false and DMCreatorActive == false and DMDogTasksPanel == false and DMDogFightPanel == false and DMDogFightRequestPanel == false and DMDogSniffPanel == false)then

if(DMFeedActive == 1)then
DMFeedDogExit()
DMStopFeedAnimation = true
triggerServerEvent("DMFeedDogFinished", getRootElement(), DMStopFeedAnimation)
DMFeedActive = 0
elseif(DMFeedActive == 2)then
killTimer(DMDogEatTimer)
DMFeedDogExit()
DMStopFeedAnimation = false
triggerServerEvent("DMFeedDogFinished", getRootElement(), DMStopFeedAnimation)
DMFeedActive = 0
end

if(DMBallThrowActive == 1)then
destroyElement(DMBall)
removeEventHandler("onClientPreRender",getRootElement(),DMkeepInHand)
removeEventHandler("onClientKey",getRootElement(),DMthrowBall)
removeEventHandler("onClientPlayerWeaponSwitch", getRootElement(),DMballWeaponSwitch)
DMInventoryBallExit()
elseif(DMBallThrowActive == 2)then
killTimer(DMInventoryGetBallTimer)
removeEventHandler("onClientRender",getRootElement(),DMDogActionFollow)
destroyElement(DMBall)
removeEventHandler("onClientRender",getRootElement(),DMthrowedBall)
DMInventoryBallExit()
elseif(DMBallThrowActive == 3)then
killTimer(DMGotBallTimer)
removeEventHandler("onClientRender",getRootElement(),DMDogActionFollow)
DMInventoryBallExit()
end

if(DMDogGuardActive == 1 or DMDogGuardActive == 2 or DMDogGuardActive == 3)then
DMDogGuardExit()
end

if(removeEventHandler("onClientRender", getRootElement(), DMStatusGui))then
DMStatusGuiWasOn = true
DMStatusActive = false
else
DMStatusGuiWasOn = false
end

addEventHandler("onClientRender", getRootElement(), DMDogPanelGui)
DMDogPanel = true

if(DMClientOwnerGotDog == true)then
if(DMDogDeathRevive == true)then
guiSetVisible(DMDogPanelButton1, true)
guiSetVisible(DMDogPanelButton2, true)
guiSetVisible(DMDogPanelButton3, true)
guiSetVisible(DMDogPanelButton4, true)
guiSetVisible(DMDogPanelButton5, true)
guiSetVisible(DMDogPanelButton6, true)
guiSetVisible(DMDogPanelButton7, true)
end
end
showCursor(true)
guiSetInputEnabled(true)
else
local DMStopDog = false
DMExit(DMStopDog)

if(DMRequestClose == true)then
DMPlayerInFight = false
DMRequestClose = false
end
if(DMStatusGuiWasOn == true)then
addEventHandler("onClientRender", getRootElement(), DMStatusGui)
DMStatusActive = true
end
end
end
end

function DMDogPanelInteractives()
DMDogPanelButton1 = guiCreateButton ( 0.791 * DMScreenx, 0.613 * DMScreeny, 0.042 * DMScreenx, 0.04 * DMScreeny, "", false)
DMDogPanelButton2 = guiCreateButton ( 0.844 * DMScreenx, 0.613 * DMScreeny, 0.042 * DMScreenx, 0.04 * DMScreeny, "", false)
DMDogPanelButton3 = guiCreateButton ( 0.897 * DMScreenx, 0.613 * DMScreeny, 0.042 * DMScreenx, 0.04 * DMScreeny, "", false)

DMDogPanelButton4 = guiCreateButton ( 0.92 * DMScreenx, 0.52 * DMScreeny, 0.021 * DMScreenx, 0.015 * DMScreeny, "", false)
DMDogPanelButton5 = guiCreateButton ( 0.92 * DMScreenx, 0.54 * DMScreeny, 0.021 * DMScreenx, 0.015 * DMScreeny, "", false)
DMDogPanelButton6 = guiCreateButton ( 0.92 * DMScreenx, 0.56 * DMScreeny, 0.021 * DMScreenx, 0.015 * DMScreeny, "", false)

DMDogPanelButton7 = guiCreateButton ( 0.935 * DMScreenx, 0.3 * DMScreeny, 0.015 * DMScreenx, 0.025 * DMScreeny, "", false)
guiSetAlpha(DMDogPanelButton1, 0)
guiSetAlpha(DMDogPanelButton2, 0)
guiSetAlpha(DMDogPanelButton3, 0)
guiSetAlpha(DMDogPanelButton4, 0)
guiSetAlpha(DMDogPanelButton5, 0)
guiSetAlpha(DMDogPanelButton6, 0)
guiSetAlpha(DMDogPanelButton7, 0)
guiSetVisible(DMDogPanelButton1, false)
guiSetVisible(DMDogPanelButton2, false)
guiSetVisible(DMDogPanelButton3, false)
guiSetVisible(DMDogPanelButton4, false)
guiSetVisible(DMDogPanelButton5, false)
guiSetVisible(DMDogPanelButton6, false)
guiSetVisible(DMDogPanelButton7, false)

addEventHandler ( "onClientGUIClick", DMDogPanelButton1, DMSpawnDog, false )
addEventHandler ( "onClientGUIClick", DMDogPanelButton2, DMDogTasks, false )
addEventHandler ( "onClientGUIClick", DMDogPanelButton3, DMTricksDog, false )
addEventHandler ( "onClientGUIClick", DMDogPanelButton4, DMInverntoryBall, false )
addEventHandler ( "onClientGUIClick", DMDogPanelButton5, DMFeedDog, false )
--addEventHandler ( "onClientGUIClick", DMDogPanelButton6, "", false )
addEventHandler ( "onClientGUIClick", DMDogPanelButton7, DMHelp, false )
end

--SPAWN
function DMSpawnDog()
if(DMDogSpawned == false)then
local DMStopDog = false
DMExit(DMStopDog)
triggerServerEvent("DMSpawnDog", getRootElement(), DMClientDogRace, DMClientDogFitness)
DMDogSpawned = true
addEventHandler("onClientRender", getRootElement(), DMStatusGui)

elseif(DMDogSpawned == true)then
local DMStopDog = true
DMExit(DMStopDog)

if(DMPlayerInFight == true)then
if(DMLanguage == 1)then
outputChatBox("Shoma Az Mobareze Dast Keshidid!", 255,255,0)
elseif(DMLanguage == 2)then
outputChatBox("Du hast den Kampf aufgegeben", 255,255,0)
end

local DMTriggerPlayer = getPlayerFromName(DMRequestPlayer)
triggerServerEvent("DMDogsFightGiveUp", getRootElement(), DMTriggerPlayer)
DMPlayerInFight = false
end

unbindKey(DoTrickKey,"down", DMDoTrick)
unbindKey(ChangeStatusKey,"down", DMChangeDogStatus)
end
end

function DMSpawnDogBack(DMDog)
DMClientDog = DMDog
local Dogx, Dogy, Dogz = getElementPosition(DMClientDog)
if(DMOnlySpawn == false)then
DMDogIdleBlip = createBlip ( Dogx, Dogy, Dogz , 0, 2, 255, 255, 255, 255, 0, 250)
DMDogIdleTimer = setTimer(function()
destroyElement(DMDogIdleBlip)
local Dogx, Dogy, Dogz = getElementPosition(DMClientDog)
DMDogIdleBlip = createBlip ( Dogx, Dogy, Dogz , 0, 2, 255, 255, 255, 255, 0, 250)

local block, anim = getPedAnimation ( DMClientDog )
if(anim ~= "OFF_Sit_Crash")then
triggerServerEvent("DMDogActionIdle", getRootElement(), DMClientDog)
end
end, 5000, 0)
DMDogStatus = 1

bindKey(ChangeStatusKey,"down", DMChangeDogStatus)
elseif(DMOnlySpawn == true)then
DMOnlySpawn = false
end

DMStatusActive = true

DMDogHungerTimer = setTimer(function()
  if(DMDogHunger == 0)then
   local DMNewHealth = (getElementHealth(DMClientDog) - 5)
   triggerServerEvent("DMDogWasted", getRootElement(), DMClientDog, DMNewHealth)
   if(DMNewHealth <= 0)then
     local DMStopDog = true
    DMExit(DMStopDog)
	DMDogRevive()
   end
  else
    DMDogHunger = DMDogHunger - 1
  end
end, 6000, 0)

addEventHandler("onClientRender", getRootElement(), DMStatusGui)
bindKey(DoTrickKey,"down", DMDoTrick)
bindKey("G","down", function() 
Bone = Bone + 1
end)
Bone = 0
Test = createObject(1247,1,1,1)
setElementCollisionsEnabled (Test, false)
addEventHandler("onClientPreRender", getRootElement(), DMTest )
end

function DMTest()
--local Dogx, Dogy, Dogz = getElementPosition(DMClientDog)
--local DMx, DMy, DMz = getElementPosition(getLocalPlayer())
--dxDrawImage3D(Dogx,Dogy, Dogz - 1, 1, 1, texture1, tocolor(255,255,255,255), nil, Dogx + 50, Dogy,Dogz)
end

--STATUS
function DMStatusGui()
if(DMLanguage == 1)then
dxDrawRectangle(0.80 * DMScreenx, 0.3 * DMScreeny, 0.15 * DMScreenx, 0.18 * DMScreeny, tocolor(25, 25, 25, 220))

if(DMClientDogRace == 290 or DMClientDogRace == 291 or DMClientDogRace == 292)then
dxDrawImage(0.805 * DMScreenx, 0.31 * DMScreeny, 70 * DMImagex, 70 * DMImagey, texture1  )
elseif(DMClientDogRace == 293 or DMClientDogRace == 294 or DMClientDogRace == 295 or DMClientDogRace == 296)then
dxDrawImage(0.805 * DMScreenx, 0.31 * DMScreeny, 70 * DMImagex, 70 * DMImagey, texture2  )
elseif(DMClientDogRace == 297 or DMClientDogRace == 298)then
dxDrawImage(0.805 * DMScreenx, 0.31 * DMScreeny, 70 * DMImagex, 70 * DMImagey, texture3  )
elseif(DMClientDogRace == 299)then
dxDrawImage(0.805 * DMScreenx, 0.31 * DMScreeny, 70 * DMImagex, 70 * DMImagey, texture4  )
end

dxDrawText("Esm: ", 0.85 * DMScreenx, 0.32 * DMScreeny, nil, nil, tocolor(255, 255, 255, 220), DMTextSizex, DMTextSizey, "default-bold", "left", "center")
dxDrawText(DMClientDogName, 0.85 * DMScreenx, 0.345 * DMScreeny, nil, nil, tocolor(255, 255, 255, 220), DMTextSizex, DMTextSizey, "pricedown", "left", "center")

dxDrawText("Salamati: ", 0.805 * DMScreenx, 0.39 * DMScreeny, nil, nil, tocolor(255, 255, 255, 220), DMTextSizex, DMTextSizey, "default-bold", "left", "center")
local DMDogHealth = getElementHealth(DMClientDog)
local DMDogHealthBar = DMDogHealth * 0.0014 + 0.805 
dxDrawLine(0.805 *DMScreenx, 0.40 * DMScreeny, 0.945 * DMScreenx, 0.4 * DMScreeny, tocolor(255,255,255, 220), 5)
dxDrawLine(0.805 *DMScreenx, 0.40 * DMScreeny, DMDogHealthBar * DMScreenx, 0.4 * DMScreeny, tocolor(0,255,51, 220), 5)

local DMDogHungerBar = DMDogHunger * 0.0014 + 0.805 
dxDrawText("Gorosnegi: ", 0.805 * DMScreenx, 0.42 * DMScreeny, nil, nil, tocolor(255, 255, 255, 220), DMTextSizex, DMTextSizey, "default-bold", "left", "center")
dxDrawLine(0.805 *DMScreenx, 0.43 * DMScreeny, 0.945 * DMScreenx, 0.43 * DMScreeny, tocolor(255,255,255, 220), 5)
dxDrawLine(0.805 *DMScreenx, 0.43 * DMScreeny, DMDogHungerBar * DMScreenx, 0.43 * DMScreeny, tocolor(255,255,51, 220), 5)

dxDrawText("Vaziat: ", 0.805 * DMScreenx, 0.455 * DMScreeny, nil, nil, tocolor(255, 255, 255, 220), DMTextSizex, DMTextSizey, "default-bold", "left", "center")

if(DMDogStatus == 1)then
  dxDrawText("Dar Entezar", 0.85 * DMScreenx, 0.455 * DMScreeny, nil, nil, tocolor(0, 255, 51, 220), DMTextSizex, DMTextSizey, "default-bold", "left", "center")
elseif(DMDogStatus == 2)then
  dxDrawText("Donbal Kardan", 0.85 * DMScreenx, 0.455 * DMScreeny, nil, nil, tocolor(255, 255, 51, 220), DMTextSizex, DMTextSizey, "default-bold", "left", "center")
elseif(DMDogStatus == 3)then
  dxDrawText("Hamle Kardan", 0.85 * DMScreenx, 0.455 * DMScreeny, nil, nil, tocolor(255, 0, 0, 220), DMTextSizex, DMTextSizey, "default-bold", "left", "center")
elseif(DMDogStatus == 4)then
  dxDrawText("Khordan", 0.85 * DMScreenx, 0.455 * DMScreeny, nil, nil, tocolor(DMClientDogGenderColorR, DMClientDogGenderColorG, DMClientDogGenderColorB, 220), DMTextSizex, DMTextSizey, "default-bold", "left", "center")
elseif(DMDogStatus == 5)then
  dxDrawText("Bazyabi", 0.85 * DMScreenx, 0.455 * DMScreeny, nil, nil, tocolor(DMClientDogGenderColorR, DMClientDogGenderColorG, DMClientDogGenderColorB, 220), DMTextSizex, DMTextSizey, "default-bold", "left", "center")
elseif(DMDogStatus == 6)then
  dxDrawText("Mohafezat", 0.85 * DMScreenx, 0.455 * DMScreeny, nil, nil, tocolor(DMClientDogGenderColorR, DMClientDogGenderColorG, DMClientDogGenderColorB, 220), DMTextSizex, DMTextSizey, "default-bold", "left", "center")
elseif(DMDogStatus == 7)then
  dxDrawText("Mobareze Kardan", 0.85 * DMScreenx, 0.455 * DMScreeny, nil, nil, tocolor(DMClientDogGenderColorR, DMClientDogGenderColorG, DMClientDogGenderColorB, 220), DMTextSizex, DMTextSizey, "default-bold", "left", "center")
end
elseif(DMLanguage == 2)then
dxDrawRectangle(0.80 * DMScreenx, 0.3 * DMScreeny, 0.15 * DMScreenx, 0.18 * DMScreeny, tocolor(25, 25, 25, 220))

if(DMClientDogRace == 290 or DMClientDogRace == 291 or DMClientDogRace == 292)then
dxDrawImage(0.805 * DMScreenx, 0.31 * DMScreeny, 70 * DMImagex, 70 * DMImagey, texture1  )
elseif(DMClientDogRace == 293 or DMClientDogRace == 294 or DMClientDogRace == 295 or DMClientDogRace == 296)then
dxDrawImage(0.805 * DMScreenx, 0.31 * DMScreeny, 70 * DMImagex, 70 * DMImagey, texture2  )
elseif(DMClientDogRace == 297 or DMClientDogRace == 298)then
dxDrawImage(0.805 * DMScreenx, 0.31 * DMScreeny, 70 * DMImagex, 70 * DMImagey, texture3  )
elseif(DMClientDogRace == 299)then
dxDrawImage(0.805 * DMScreenx, 0.31 * DMScreeny, 70 * DMImagex, 70 * DMImagey, texture4  )
end

dxDrawText("Name: ", 0.85 * DMScreenx, 0.32 * DMScreeny, nil, nil, tocolor(255, 255, 255, 220), DMTextSizex, DMTextSizey, "default-bold", "left", "center")
dxDrawText(DMClientDogName, 0.85 * DMScreenx, 0.345 * DMScreeny, nil, nil, tocolor(255, 255, 255, 220), DMTextSizex, DMTextSizey, "pricedown", "left", "center")

dxDrawText("Leben: ", 0.805 * DMScreenx, 0.39 * DMScreeny, nil, nil, tocolor(255, 255, 255, 220), DMTextSizex, DMTextSizey, "default-bold", "left", "center")
local DMDogHealth = getElementHealth(DMClientDog)
local DMDogHealthBar = DMDogHealth * 0.0014 + 0.805 
dxDrawLine(0.805 *DMScreenx, 0.40 * DMScreeny, 0.945 * DMScreenx, 0.4 * DMScreeny, tocolor(255,255,255, 220), 5)
dxDrawLine(0.805 *DMScreenx, 0.40 * DMScreeny, DMDogHealthBar * DMScreenx, 0.4 * DMScreeny, tocolor(0,255,51, 220), 5)

local DMDogHungerBar = DMDogHunger * 0.0014 + 0.805 
dxDrawText("Hunger: ", 0.805 * DMScreenx, 0.42 * DMScreeny, nil, nil, tocolor(255, 255, 255, 220), DMTextSizex, DMTextSizey, "default-bold", "left", "center")
dxDrawLine(0.805 *DMScreenx, 0.43 * DMScreeny, 0.945 * DMScreenx, 0.43 * DMScreeny, tocolor(255,255,255, 220), 5)
dxDrawLine(0.805 *DMScreenx, 0.43 * DMScreeny, DMDogHungerBar * DMScreenx, 0.43 * DMScreeny, tocolor(255,255,51, 220), 5)

dxDrawText("Status: ", 0.805 * DMScreenx, 0.455 * DMScreeny, nil, nil, tocolor(255, 255, 255, 220), DMTextSizex, DMTextSizey, "default-bold", "left", "center")

if(DMDogStatus == 1)then
  dxDrawText("Warten", 0.85 * DMScreenx, 0.455 * DMScreeny, nil, nil, tocolor(0, 255, 51, 220), DMTextSizex, DMTextSizey, "default-bold", "left", "center")
elseif(DMDogStatus == 2)then
  dxDrawText("Folgen", 0.85 * DMScreenx, 0.455 * DMScreeny, nil, nil, tocolor(255, 255, 51, 220), DMTextSizex, DMTextSizey, "default-bold", "left", "center")
elseif(DMDogStatus == 3)then
  dxDrawText("Attackieren", 0.85 * DMScreenx, 0.455 * DMScreeny, nil, nil, tocolor(255, 0, 0, 220), DMTextSizex, DMTextSizey, "default-bold", "left", "center")
elseif(DMDogStatus == 4)then
  dxDrawText("Essen", 0.85 * DMScreenx, 0.455 * DMScreeny, nil, nil, tocolor(DMClientDogGenderColorR, DMClientDogGenderColorG, DMClientDogGenderColorB, 220), DMTextSizex, DMTextSizey, "default-bold", "left", "center")
elseif(DMDogStatus == 5)then
  dxDrawText("Spielend", 0.85 * DMScreenx, 0.455 * DMScreeny, nil, nil, tocolor(DMClientDogGenderColorR, DMClientDogGenderColorG, DMClientDogGenderColorB, 220), DMTextSizex, DMTextSizey, "default-bold", "left", "center")
elseif(DMDogStatus == 6)then
  dxDrawText("Bewachen", 0.85 * DMScreenx, 0.455 * DMScreeny, nil, nil, tocolor(DMClientDogGenderColorR, DMClientDogGenderColorG, DMClientDogGenderColorB, 220), DMTextSizex, DMTextSizey, "default-bold", "left", "center")
elseif(DMDogStatus == 7)then
  dxDrawText("Kämpfen", 0.85 * DMScreenx, 0.455 * DMScreeny, nil, nil, tocolor(DMClientDogGenderColorR, DMClientDogGenderColorG, DMClientDogGenderColorB, 220), DMTextSizex, DMTextSizey, "default-bold", "left", "center")
end
end
end

--ACTIONS
function DMDogActionFollow()
local DMPlayerx, DMPlayery, DMPlayerz
if(DMDogFollow == 1)then
DMPlayerx, DMPlayery, DMPlayerz = getElementPosition(getLocalPlayer())
elseif(DMDogFollow == 2)then
DMPlayerx, DMPlayery, DMPlayerz = getElementPosition(DMBall)
elseif(DMDogFollow == 3)then
DMPlayerx = DMClientBowlx
DMPlayery = DMClientBowly
elseif(DMDogFollow == 4)then
DMPlayerx = DogGuardingx
DMPlayery = DogGuardingy
end

local DMClientDogx, DMClientDogy, DMClientDogz = getElementPosition(DMClientDog)
local DMDogFinalRotation
local DMDogDistanceAnimationChange
local DMDogRescueTeleport
local DMDogRotation = math.deg(math.atan((DMPlayerx - DMClientDogx) / (DMPlayery - DMClientDogy)))

if(DMPlayerx > DMClientDogx and DMPlayery > DMClientDogy)then
DMDogFinalRotation = DMDogRotation
elseif(DMPlayerx > DMClientDogx and DMPlayery < DMClientDogy)then
DMDogFinalRotation = 180 + DMDogRotation
elseif(DMPlayerx < DMClientDogx and DMPlayery < DMClientDogy)then
DMDogFinalRotation = 180 + DMDogRotation
elseif(DMPlayerx < DMClientDogx and DMPlayery > DMClientDogy)then
DMDogFinalRotation = 360 + DMDogRotation
end

if(DMDogFinalRotation == nil)then
DMDogFinalRotation = 0
end

local DMDistance = getDistanceBetweenPoints2D (DMPlayerx , DMPlayery, DMClientDogx, DMClientDogy)

if(DMDistance <= 1.5)then
  if(DMDogDistanceAnimation ~= 1)then
  DMDogDistanceAnimation = 1
  DMDogDistanceAnimationChange = true
  if( DMDogFollow == 2 and DMInventoryBallOnGround == true)then
  DMDoggotBall()
  end
  elseif(DMDogDistanceAnimation == 1)then
  DMDogDistanceAnimationChange = false
  end
elseif(DMDistance > 1.5 and DMDistance <= 4)then
  if(DMDogDistanceAnimation ~= 2)then
  DMDogDistanceAnimation = 2
  DMDogDistanceAnimationChange = true
  elseif(DMDogDistanceAnimation == 2)then
  DMDogDistanceAnimationChange = false
  end
elseif(DMDistance > 4 and DMDistance <= 7 )then
 if(DMDogDistanceAnimation ~= 3)then
 DMDogDistanceAnimation = 3
 DMDogDistanceAnimationChange = true
 elseif(DMDogDistanceAnimation == 3)then
 DMDogDistanceAnimationChange = false
 end
elseif(DMDistance > 7 and DMDistance <= 50)then
 if(DMDogDistanceAnimation ~= 4)then
 DMDogDistanceAnimation = 4
 DMDogDistanceAnimationChange = true
 elseif(DMDogDistanceAnimation == 4)then
 DMDogDistanceAnimationChange = false
 end
end

if(DMDistance > 50 )then
 DMDogRescueTeleport = true
else
 DMDogRescueTeleport = false
end

triggerServerEvent("DMDogActionFollow", getRootElement(), DMDogFinalRotation, DMDogDistanceAnimation, DMDogDistanceAnimationChange, DMClientDog, DMDogRescueTeleport, DMDogFollow)
end

function DMDogActionAttack()
local DMPlayerx, DMPlayery, DMPlayerz
local DMAttackPerson

if(DMDogAttack == 2)then
DMPlayerx, DMPlayery, DMPlayerz = getElementPosition(DMClientRequestDog)
DMAttackPerson = DMClientRequestDog
elseif(DMDogAttack == 1)then
DMPlayerx, DMPlayery, DMPlayerz = getElementPosition(DMAttacker)
DMAttackPerson = DMAttacker
end
local DMClientDogx, DMClientDogy, DMClientDogz = getElementPosition(DMClientDog)
local DMDogFinalRotation
local DMDogDistanceAnimationChange
local DMDogRescueTeleport
local DMStopAttack

local DMDogRotation = math.deg(math.atan((DMPlayerx - DMClientDogx) / (DMPlayery - DMClientDogy)))

if(DMPlayerx > DMClientDogx and DMPlayery > DMClientDogy)then
DMDogFinalRotation = DMDogRotation
elseif(DMPlayerx > DMClientDogx and DMPlayery < DMClientDogy)then
DMDogFinalRotation = 180 + DMDogRotation
elseif(DMPlayerx < DMClientDogx and DMPlayery < DMClientDogy)then
DMDogFinalRotation = 180 + DMDogRotation
elseif(DMPlayerx < DMClientDogx and DMPlayery > DMClientDogy)then
DMDogFinalRotation = 360 + DMDogRotation
end

if(DMDogFinalRotation == nil)then
DMDogFinalRotation = 0
end

local DMDistance = getDistanceBetweenPoints2D (DMPlayerx , DMPlayery, DMClientDogx, DMClientDogy)

if(DMDistance <= 1.5)then
  if(DMDogDistanceAnimation ~= 1)then
  DMDogDistanceAnimation = 1
  DMDogDistanceAnimationChange = true
  elseif(DMDogDistanceAnimation == 1)then
  DMDogDistanceAnimationChange = false
  end
elseif(DMDistance > 1.5 and DMDistance <= 7 )then
 if(DMDogDistanceAnimation ~= 2)then
 DMDogDistanceAnimation = 2
 DMDogDistanceAnimationChange = true
 elseif(DMDogDistanceAnimation == 2)then
 DMDogDistanceAnimationChange = false
 end
elseif(DMDistance > 7 and DMDistance <= 50)then
 if(DMDogDistanceAnimation ~= 3)then
 DMDogDistanceAnimation = 3
 DMDogDistanceAnimationChange = true
 elseif(DMDogDistanceAnimation == 3)then
 DMDogDistanceAnimationChange = false
 end
end

if(DMDistance > 50 )then
 DMDogRescueTeleport = true
else
 DMDogRescueTeleport = false
end

local DMx, DMy, DMz = getElementPosition(getLocalPlayer())
local DMDistance = getDistanceBetweenPoints2D (DMx , DMy, DMClientDogx, DMClientDogy)

local DMVolume = 1 - DMDistance/50
if(DMVolume <= 0)then
DMVolume = 0
end
if(DMDogAttack == 2)then
setSoundVolume(DMFightSound1, DMVolume)
setSoundVolume(DMFightSound2, DMVolume)
end

if(DMDogAttack == 1)then
if(DMDistance > 50)then
DMStopAttack = true
else
DMStopAttack = false
end
elseif(DMDogAttack == 2)then
DMStopAttack = false
end

DMAttackCount = DMAttackCount + 1
if(DMAttackCount == 50)then
DMAttackCount = 0
end
triggerServerEvent("DMDogActionAttack", getRootElement(), DMDogFinalRotation, DMDogDistanceAnimation, DMDogDistanceAnimationChange, DMClientDog, DMDogRescueTeleport, DMAttackPerson, DMAttackCount, DMClientDogStrength, DMStopAttack, DMDogAttack)
end

function DMCheckAttack(attacker)
if(source == getLocalPlayer())then
DMAttacker = attacker
if(getElementType(attacker) == "player")then
if(DMClientOwnerGotDog == true and DMDogSpawned == true and DMDogStatus == 3)then
if(DMDogAttacking == false)then
removeEventHandler("onClientRender", getRootElement(), DMDogActionFollow )
DMAttackCount = 0
DMDogAttacking = true
DMDogAttack = 1
addEventHandler("onClientRender", getRootElement(), DMDogActionAttack )
triggerServerEvent("DMCheckAttackAttacker", getRootElement(), DMAttacker)
DMAttackSound()
end
if(DMClientDogStrength == 100)then
else
DMClientDogStrength = DMClientDogStrength + 0.5
triggerServerEvent("DMSaveStatStrength", getRootElement(), DMClientDogStrength)
end
else
DMDogAttacking = false
local DMClientDog = nil
triggerServerEvent("DMCheckAttackAttacker", getRootElement(), DMAttacker)
end
end
end
end

function DMCheckAttackAttacker(DMVictim)
if(DMClientOwnerGotDog == true and DMDogSpawned == true and DMDogStatus == 3)then
DMAttacker = DMVictim
removeEventHandler("onClientRender", getRootElement(), DMDogActionFollow )
DMAttackCount = 0
DMDogAttack = 1
addEventHandler("onClientRender", getRootElement(), DMDogActionAttack )
DMDogAttacking = true
DMAttackSound()

if(DMClientDogStrength == 100)then
else
DMClientDogStrength = DMClientDogStrength + 0.5
triggerServerEvent("DMSaveStatStrength", getRootElement(), DMClientDogStrength)
end

end
end

function DMDogActionAttackStop()
removeEventHandler("onClientRender", getRootElement(), DMDogActionAttack )
DMAttackCount = 0
DMDogAttacking = false
DMDogFollow = 1
addEventHandler("onClientRender", getRootElement(), DMDogActionFollow )
end

function DMChangeDogStatus() -- 1 waiting, 2 following, 3 attacking
if(isPedInVehicle(getLocalPlayer()) == false)then
if(DMDogGuardActive == 1 or DMDogGuardActive == 2 or DMDogGuardActive == 3)then
DMDogGuardExit()
else
DMExitStatus()
if(DMDogStatus == 1)then
DMDogStatus = 2
DMDogDistanceAnimation = 0
if(DMClientDogFitness < 100)then
DMDogFitnessTimer = setTimer(function()
 if(DMClientDogFitness < 100)then
   DMClientDogFitness = DMClientDogFitness + 0.02
   DMClientDogFitness = DMRound(DMClientDogFitness, 10)
   triggerServerEvent("DMSaveStatFitness", getRootElement(), DMClientDogFitness)
  else
   DMClientDogFitness = 100
   triggerServerEvent("DMSaveStatFitness", getRootElement(), DMClientDogFitness)
   killTimer(DMDogFitnessTimer)
  end
end, 15000, 0)
end
DMPositionSyncTimer = setTimer(function()
local Dogx, Dogy, Dogz = getElementPosition(DMClientDog)
triggerServerEvent("DMSyncPosition", getRootElement(),DMClientDog, Dogx, Dogy, Dogz)
end, 1000, 0)
DMDogFollow = 1
addEventHandler("onClientRender", getRootElement(), DMDogActionFollow )

elseif(DMDogStatus == 2)then
DMDogStatus = 3
DMDogDistanceAnimation = 0
if(DMClientDogFitness < 100)then
DMDogFitnessTimer = setTimer(function()
 if(DMClientDogFitness < 100)then
   DMClientDogFitness = DMClientDogFitness + 0.02
   DMClientDogFitness = DMRound(DMClientDogFitness, 10)
   triggerServerEvent("DMSaveStatFitness", getRootElement(), DMClientDogFitness)
  else
   DMClientDogFitness = 100
   triggerServerEvent("DMSaveStatFitness", getRootElement(), DMClientDogFitness)
   killTimer(DMDogFitnessTimer)
  end
end, 15000, 0)
end
DMPositionSyncTimer = setTimer(function()
local Dogx, Dogy, Dogz = getElementPosition(DMClientDog)
triggerServerEvent("DMSyncPosition", getRootElement(),DMClientDog, Dogx, Dogy, Dogz)
end, 1000, 0)
DMDogFollow = 1
addEventHandler("onClientRender", getRootElement(), DMDogActionFollow )

DMAttackStatusSound = playSound3D(":DogMod/sounds/dog_growl.mp3", false)

elseif(DMDogStatus == 3)then
triggerServerEvent("DMDogActionIdle", getRootElement(), DMClientDog)
local Dogx, Dogy, Dogz = getElementPosition(DMClientDog)
DMDogIdleBlip = createBlip ( Dogx, Dogy, Dogz , 0, 2, 255, 255, 255, 255, 0, 250)
DMDogStatus = 1
DMDogIdleTimer = setTimer(function()
destroyElement(DMDogIdleBlip) 
local Dogx, Dogy, Dogz = getElementPosition(DMClientDog)
DMDogIdleBlip = createBlip ( Dogx, Dogy, Dogz , 0, 2, 255, 255, 255, 255, 0, 250)

local block, anim = getPedAnimation ( DMClientDog )
if(anim ~= "OFF_Sit_Crash")then
triggerServerEvent("DMDogActionIdle", getRootElement(), DMClientDog)
end
end, 5000, 0)
end
end
end
end

--DOG FEED
function DMFeedDog()
if(DMDogSpawned == true and DMPlayerInFight == false)then
if(DMFeedActive == 0)then
removeEventHandler("onClientRender", getRootElement(), DMDogPanelGui)
DMDogPanel = false 

guiSetVisible(DMDogPanelButton1, false)
guiSetVisible(DMDogPanelButton2, false)
guiSetVisible(DMDogPanelButton3, false)
guiSetVisible(DMDogPanelButton4, false)
guiSetVisible(DMDogPanelButton5, false)
guiSetVisible(DMDogPanelButton6, false)
guiSetVisible(DMDogPanelButton7, false)

showCursor(false)

guiSetInputEnabled(false)
local DMPlayerx, DMPlayery, DMPlayerz = getElementPosition(getLocalPlayer())
local DMClientDogx, DMClientDogy, DMClientDogz = getElementPosition(DMClientDog)
local DMDistance = getDistanceBetweenPoints2D (DMPlayerx , DMPlayery, DMClientDogx, DMClientDogy)
		
if(DMDistance < 50)then
if(DMDogStatus == 1)then
destroyElement(DMDogIdleBlip)
killTimer(DMDogIdleTimer)
DMPositionSyncTimer = setTimer(function()
local Dogx, Dogy, Dogz = getElementPosition(DMClientDog)
triggerServerEvent("DMSyncPosition", getRootElement(),DMClientDog, Dogx, Dogy, Dogz)
end, 1000, 0)
elseif(DMDogStatus == 2)then
removeEventHandler("onClientRender", getRootElement(), DMDogActionFollow )
elseif(DMDogStatus == 3)then
if(removeEventHandler("onClientRender", getRootElement(), DMDogActionFollow ))then
else
removeEventHandler("onClientRender", getRootElement(), DMDogActionAttack)
end
elseif(DMDogStatus == 7)then
DMDogAttacking = false
removeEventHandler("onClientRender", getRootElement(), DMDogActionAttack)
bindKey(ChangeStatusKey, "down", DMChangeDogStatus)
end

DMOldDogStatus = DMDogStatus
DMDogStatus = 4

if(DMStatusGuiWasOn == true)then
DMStatusActive = true
addEventHandler("onClientRender", getRootElement(), DMStatusGui)
end

triggerServerEvent("DMFeedDog", getRootElement())

local DMPlayerx, DMPlayery, DMPlayerz = getElementPosition(getLocalPlayer())
DMClientBowlx = DMPlayerx + 0.5
DMClientBowly = DMPlayery
DMDogDistanceAnimation = 0
DMDogFollow = 3
addEventHandler("onClientRender", getRootElement(), DMDogActionFollow)

DMFeedActive = 1
else
addEventHandler("onClientRender", getRootElement(), DMStatusGui)
if(DMLanguage == 1)then
outputChatBox("Sag Kheyli Door Ast!",255, 0,0)
elseif(DMLanguage == 2)then
outputChatBox("Hund ist zu weit entfernt!",255, 0,0)
end

end
end
end
end

function DMFeedDogBack()
removeEventHandler("onClientRender", getRootElement(), DMDogActionFollow)

DMFeedActive = 2
local DMDogHealth = getElementHealth(DMClientDog)
if(DMDogHealth >= 80)then
setElementHealth(DMClientDog, 100)
else
setElementHealth(DMClientDog, DMDogHealth + 20)
end
DMDogEatTimer = setTimer(function()
  if(DMDogHunger < 100)then
    DMDogHunger = DMDogHunger + 2
  else
    DMDogHunger = 100
	killTimer(DMDogEatTimer)
	DMFeedActive = 0
	DMStopFeedAnimation = false
	triggerServerEvent("DMFeedDogFinished", getRootElement(), DMStopFeedAnimation)
	DMFeedDogExit()
  end
end, 100, 0)
end

function DMFeedDogExit()
if(DMOldDogStatus == 1)then
removeEventHandler("onClientRender", getRootElement(), DMDogActionFollow)
	DMDogStatus = 1
	killTimer(DMPositionSyncTimer)
	triggerServerEvent("DMDogActionIdle", getRootElement(), DMClientDog)
	DMDogIdleTimer = setTimer(function()
    destroyElement(DMDogIdleBlip) 
    local Dogx, Dogy, Dogz = getElementPosition(DMClientDog)
    DMDogIdleBlip = createBlip ( Dogx, Dogy, Dogz , 0, 2, 255, 255, 255, 255, 0, 250)

    local block, anim = getPedAnimation ( DMClientDog )
    if(anim ~= "OFF_Sit_Crash")then
    triggerServerEvent("DMDogActionIdle", getRootElement(), DMClientDog)
    end
    end, 5000, 0)
	elseif(DMOldDogStatus == 2)then
	DMDogStatus = 2
	DMDogDistanceAnimation = 0
	DMDogFollow = 1
    addEventHandler("onClientRender", getRootElement(), DMDogActionFollow )
	elseif(DMOldDogStatus == 3 or DMOldDogStatus == 7)then
	DMDogStatus = 3
	DMDogDistanceAnimation = 0
	DMDogFollow = 1
	addEventHandler("onClientRender", getRootElement(), DMDogActionFollow )
	end
end

--DOG TRICKS
function DMTricksDogGui()
if(DMLanguage == 1)then
dxDrawRectangle(0.78 * DMScreenx, 0.3 * DMScreeny, 0.17 * DMScreenx, 0.37 * DMScreeny, tocolor(20, 20, 20, 220))
dxDrawText("Tarfand Haye Sag", 0.785 * DMScreenx, 0.315 * DMScreeny, nil, nil, tocolor(DMClientDogGenderColorR, DMClientDogGenderColorG, DMClientDogGenderColorB, 220), DMTextSizex, DMTextSizey, "default-bold", "left", "center")

dxDrawLine(0.78 * DMScreenx, 0.33 * DMScreeny, 0.95 * DMScreenx, 0.33 * DMScreeny, tocolor(255, 255, 255, 220))
dxDrawLine(0.78 * DMScreenx, 0.3785 * DMScreeny, 0.95 * DMScreenx, 0.3785 * DMScreeny, tocolor(255, 255, 255, 220))
dxDrawLine(0.78 * DMScreenx, 0.427 * DMScreeny, 0.95 * DMScreenx, 0.427 * DMScreeny, tocolor(255, 255, 255, 220))
dxDrawLine(0.78 * DMScreenx, 0.4755 * DMScreeny, 0.95 * DMScreenx,  0.4755 * DMScreeny, tocolor(255, 255, 255, 220))
dxDrawLine(0.78 * DMScreenx, 0.524 * DMScreeny, 0.95 * DMScreenx,  0.524 * DMScreeny, tocolor(255, 255, 255, 220))
dxDrawLine(0.78 * DMScreenx, 0.5725 * DMScreeny, 0.95 * DMScreenx,  0.5725 * DMScreeny, tocolor(255, 255, 255, 220))
dxDrawLine(0.78 * DMScreenx, 0.621 * DMScreeny, 0.95 * DMScreenx,  0.621 * DMScreeny, tocolor(255, 255, 255, 220))

if(DMClientDogFitness >= 0)then
dxDrawText("Neshastan", 0.785 * DMScreenx, 0.33 * DMScreeny, 0.945 * DMScreenx, 0.3785 * DMScreeny, tocolor(255, 255, 255, 220), DMTextSizex, DMTextSizey, "pricedown", "center", "center")
else
dxDrawText("Ghofl Ast", 0.785 * DMScreenx, 0.33 * DMScreeny, 0.945 * DMScreenx, 0.3685 * DMScreeny, tocolor(255, 255, 255, 220), DMTextSizex, DMTextSizey, "pricedown", "center", "center")
dxDrawText("Maharat 0", 0.785 * DMScreenx, 0.3685 * DMScreeny, 0.945 * DMScreenx, 0.3785 * DMScreeny, tocolor(255, 255, 255, 220), DMTextSizex, DMTextSizey, "default", "center", "center")
dxDrawRectangle(0.78 * DMScreenx, 0.335 * DMScreeny, 0.17 * DMScreenx, 0.048 * DMScreeny, tocolor(20, 20, 20, 100))
end
if(DMClientDogFitness >= 5)then
dxDrawText("Dast Dadan", 0.785 * DMScreenx, 0.3785 * DMScreeny, 0.945 * DMScreenx, 0.427 * DMScreeny, tocolor(255, 255, 255, 220), DMTextSizex, DMTextSizey, "pricedown", "center", "center")
else
dxDrawText("Ghofl Ast", 0.785 * DMScreenx, 0.3785 * DMScreeny, 0.945 * DMScreenx, 0.412 * DMScreeny, tocolor(255, 255, 255, 220), DMTextSizex, DMTextSizey, "pricedown", "center", "center")
dxDrawText("Maharat 5", 0.785 * DMScreenx, 0.412 * DMScreeny, 0.945 * DMScreenx, 0.427 * DMScreeny, tocolor(255, 255, 255, 220), DMTextSizex, DMTextSizey, "default", "center", "center")
dxDrawRectangle(0.78 * DMScreenx, 0.3835 * DMScreeny, 0.17 * DMScreenx, 0.048 * DMScreeny, tocolor(20, 20, 20, 100))
end
if(DMClientDogFitness >= 15)then
dxDrawText("Ghaltidan", 0.785 * DMScreenx, 0.427 * DMScreeny, 0.945 * DMScreenx, 0.4755 * DMScreeny, tocolor(255, 255, 255, 220), DMTextSizex, DMTextSizey, "pricedown", "center", "center")
else
dxDrawText("Ghofl Ast", 0.785 * DMScreenx, 0.427 * DMScreeny, 0.945 * DMScreenx, 0.4605 * DMScreeny, tocolor(255, 255, 255, 220), DMTextSizex, DMTextSizey, "pricedown", "center", "center")
dxDrawText("Maharat 15", 0.785 * DMScreenx, 0.4605 * DMScreeny, 0.945 * DMScreenx, 0.4755 * DMScreeny, tocolor(255, 255, 255, 220), DMTextSizex, DMTextSizey, "default", "center", "center")
dxDrawRectangle(0.78 * DMScreenx, 0.432 * DMScreeny, 0.17 * DMScreenx, 0.048 * DMScreeny, tocolor(20, 20, 20, 100))
end
if(DMClientDogFitness >= 30)then
dxDrawText("Paridan", 0.785 * DMScreenx, 0.4755 * DMScreeny, 0.945 * DMScreenx, 0.524 * DMScreeny, tocolor(255, 255, 255, 220), DMTextSizex, DMTextSizey, "pricedown", "center", "center")
else
dxDrawText("Ghofl Ast", 0.785 * DMScreenx, 0.4755 * DMScreeny, 0.945 * DMScreenx, 0.509 * DMScreeny, tocolor(255, 255, 255, 220), DMTextSizex, DMTextSizey, "pricedown", "center", "center")
dxDrawText("Maharat 30", 0.785 * DMScreenx, 0.509 * DMScreeny, 0.945 * DMScreenx, 0.524 * DMScreeny, tocolor(255, 255, 255, 220), DMTextSizex, DMTextSizey, "default", "center", "center")
dxDrawRectangle(0.78 * DMScreenx, 0.4805 * DMScreeny, 0.17 * DMScreenx, 0.048 * DMScreeny, tocolor(20, 20, 20, 100))
end
if(DMClientDogFitness >= 50)then
dxDrawText("Eltemas", 0.785 * DMScreenx, 0.524 * DMScreeny, 0.945 * DMScreenx, 0.5725 * DMScreeny, tocolor(255, 255, 255, 220), DMTextSizex, DMTextSizey, "pricedown", "center", "center")
else
dxDrawText("Ghofl Ast", 0.785 * DMScreenx, 0.524 * DMScreeny, 0.945 * DMScreenx, 0.5675 * DMScreeny, tocolor(255, 255, 255, 220), DMTextSizex, DMTextSizey, "pricedown", "center", "center")
dxDrawText("Maharat 50", 0.785 * DMScreenx, 0.5575 * DMScreeny, 0.945 * DMScreenx, 0.5725 * DMScreeny, tocolor(255, 255, 255, 220), DMTextSizex, DMTextSizey, "default", "center", "center")
dxDrawRectangle(0.78 * DMScreenx, 0.529 * DMScreeny, 0.17 * DMScreenx, 0.048 * DMScreeny, tocolor(20, 20, 20, 100))
end
if(DMClientDogFitness >= 70)then
dxDrawText("Ninja Kick", 0.785 * DMScreenx, 0.5725 * DMScreeny, 0.945 * DMScreenx, 0.621 * DMScreeny, tocolor(255, 255, 255, 220), DMTextSizex, DMTextSizey, "pricedown", "center", "center")
else
dxDrawText("Ghofl Ast", 0.785 * DMScreenx, 0.5725 * DMScreeny, 0.945 * DMScreenx, 0.606 * DMScreeny, tocolor(255, 255, 255, 220), DMTextSizex, DMTextSizey, "pricedown", "center", "center")
dxDrawText("Maharat 70", 0.785 * DMScreenx, 0.606 * DMScreeny, 0.945 * DMScreenx, 0.621 * DMScreeny, tocolor(255, 255, 255, 220), DMTextSizex, DMTextSizey, "default", "center", "center")
dxDrawRectangle(0.78 * DMScreenx, 0.5775 * DMScreeny, 0.17 * DMScreenx, 0.048 * DMScreeny, tocolor(20, 20, 20, 100))
end
if(DMClientDogFitness >= 95)then
dxDrawText("Moonwalk", 0.785 * DMScreenx, 0.621 * DMScreeny, 0.945 * DMScreenx, 0.6695 * DMScreeny, tocolor(255, 255, 255, 220), DMTextSizex, DMTextSizey, "pricedown", "center", "center")
else
dxDrawText("Ghofl Ast", 0.785 * DMScreenx, 0.621 * DMScreeny, 0.945 * DMScreenx, 0.6545 * DMScreeny, tocolor(255, 255, 255, 220), DMTextSizex, DMTextSizey, "pricedown", "center", "center")
dxDrawText("Maharat 95", 0.785 * DMScreenx, 0.6545 * DMScreeny, 0.945 * DMScreenx, 0.6695 * DMScreeny, tocolor(255, 255, 255, 220), DMTextSizex, DMTextSizey, "default", "center", "center")
dxDrawRectangle(0.78 * DMScreenx, 0.626 * DMScreeny, 0.17 * DMScreenx, 0.044 * DMScreeny, tocolor(20, 20, 20, 100))
end
elseif(DMLanguage == 2)then
dxDrawRectangle(0.78 * DMScreenx, 0.3 * DMScreeny, 0.17 * DMScreenx, 0.37 * DMScreeny, tocolor(20, 20, 20, 220))
dxDrawText("Hunde Tricks", 0.785 * DMScreenx, 0.315 * DMScreeny, nil, nil, tocolor(DMClientDogGenderColorR, DMClientDogGenderColorG, DMClientDogGenderColorB, 220), DMTextSizex, DMTextSizey, "default-bold", "left", "center")

dxDrawLine(0.78 * DMScreenx, 0.33 * DMScreeny, 0.95 * DMScreenx, 0.33 * DMScreeny, tocolor(255, 255, 255, 220))
dxDrawLine(0.78 * DMScreenx, 0.3785 * DMScreeny, 0.95 * DMScreenx, 0.3785 * DMScreeny, tocolor(255, 255, 255, 220))
dxDrawLine(0.78 * DMScreenx, 0.427 * DMScreeny, 0.95 * DMScreenx, 0.427 * DMScreeny, tocolor(255, 255, 255, 220))
dxDrawLine(0.78 * DMScreenx, 0.4755 * DMScreeny, 0.95 * DMScreenx,  0.4755 * DMScreeny, tocolor(255, 255, 255, 220))
dxDrawLine(0.78 * DMScreenx, 0.524 * DMScreeny, 0.95 * DMScreenx,  0.524 * DMScreeny, tocolor(255, 255, 255, 220))
dxDrawLine(0.78 * DMScreenx, 0.5725 * DMScreeny, 0.95 * DMScreenx,  0.5725 * DMScreeny, tocolor(255, 255, 255, 220))
dxDrawLine(0.78 * DMScreenx, 0.621 * DMScreeny, 0.95 * DMScreenx,  0.621 * DMScreeny, tocolor(255, 255, 255, 220))

if(DMClientDogFitness >= 0)then
dxDrawText("Sitz", 0.785 * DMScreenx, 0.33 * DMScreeny, 0.945 * DMScreenx, 0.3785 * DMScreeny, tocolor(255, 255, 255, 220), DMTextSizex, DMTextSizey, "pricedown", "center", "center")
else
dxDrawText("Gesperrt", 0.785 * DMScreenx, 0.33 * DMScreeny, 0.945 * DMScreenx, 0.3685 * DMScreeny, tocolor(255, 255, 255, 220), DMTextSizex, DMTextSizey, "pricedown", "center", "center")
dxDrawText("Fitness 0", 0.785 * DMScreenx, 0.3685 * DMScreeny, 0.945 * DMScreenx, 0.3785 * DMScreeny, tocolor(255, 255, 255, 220), DMTextSizex, DMTextSizey, "default", "center", "center")
dxDrawRectangle(0.78 * DMScreenx, 0.335 * DMScreeny, 0.17 * DMScreenx, 0.048 * DMScreeny, tocolor(20, 20, 20, 100))
end
if(DMClientDogFitness >= 5)then
dxDrawText("Handstand", 0.785 * DMScreenx, 0.3785 * DMScreeny, 0.945 * DMScreenx, 0.427 * DMScreeny, tocolor(255, 255, 255, 220), DMTextSizex, DMTextSizey, "pricedown", "center", "center")
else
dxDrawText("Gesperrt", 0.785 * DMScreenx, 0.3785 * DMScreeny, 0.945 * DMScreenx, 0.412 * DMScreeny, tocolor(255, 255, 255, 220), DMTextSizex, DMTextSizey, "pricedown", "center", "center")
dxDrawText("Fitness 5", 0.785 * DMScreenx, 0.412 * DMScreeny, 0.945 * DMScreenx, 0.427 * DMScreeny, tocolor(255, 255, 255, 220), DMTextSizex, DMTextSizey, "default", "center", "center")
dxDrawRectangle(0.78 * DMScreenx, 0.3835 * DMScreeny, 0.17 * DMScreenx, 0.048 * DMScreeny, tocolor(20, 20, 20, 100))
end
if(DMClientDogFitness >= 15)then
dxDrawText("Roll", 0.785 * DMScreenx, 0.427 * DMScreeny, 0.945 * DMScreenx, 0.4755 * DMScreeny, tocolor(255, 255, 255, 220), DMTextSizex, DMTextSizey, "pricedown", "center", "center")
else
dxDrawText("Gesperrt", 0.785 * DMScreenx, 0.427 * DMScreeny, 0.945 * DMScreenx, 0.4605 * DMScreeny, tocolor(255, 255, 255, 220), DMTextSizex, DMTextSizey, "pricedown", "center", "center")
dxDrawText("Fitness 15", 0.785 * DMScreenx, 0.4605 * DMScreeny, 0.945 * DMScreenx, 0.4755 * DMScreeny, tocolor(255, 255, 255, 220), DMTextSizex, DMTextSizey, "default", "center", "center")
dxDrawRectangle(0.78 * DMScreenx, 0.432 * DMScreeny, 0.17 * DMScreenx, 0.048 * DMScreeny, tocolor(20, 20, 20, 100))
end
if(DMClientDogFitness >= 30)then
dxDrawText("Spring", 0.785 * DMScreenx, 0.4755 * DMScreeny, 0.945 * DMScreenx, 0.524 * DMScreeny, tocolor(255, 255, 255, 220), DMTextSizex, DMTextSizey, "pricedown", "center", "center")
else
dxDrawText("Gesperrt", 0.785 * DMScreenx, 0.4755 * DMScreeny, 0.945 * DMScreenx, 0.509 * DMScreeny, tocolor(255, 255, 255, 220), DMTextSizex, DMTextSizey, "pricedown", "center", "center")
dxDrawText("Fitness 30", 0.785 * DMScreenx, 0.509 * DMScreeny, 0.945 * DMScreenx, 0.524 * DMScreeny, tocolor(255, 255, 255, 220), DMTextSizex, DMTextSizey, "default", "center", "center")
dxDrawRectangle(0.78 * DMScreenx, 0.4805 * DMScreeny, 0.17 * DMScreenx, 0.048 * DMScreeny, tocolor(20, 20, 20, 100))
end
if(DMClientDogFitness >= 50)then
dxDrawText("Betteln", 0.785 * DMScreenx, 0.524 * DMScreeny, 0.945 * DMScreenx, 0.5725 * DMScreeny, tocolor(255, 255, 255, 220), DMTextSizex, DMTextSizey, "pricedown", "center", "center")
else
dxDrawText("Gesperrt", 0.785 * DMScreenx, 0.524 * DMScreeny, 0.945 * DMScreenx, 0.5675 * DMScreeny, tocolor(255, 255, 255, 220), DMTextSizex, DMTextSizey, "pricedown", "center", "center")
dxDrawText("Fitness 50", 0.785 * DMScreenx, 0.5575 * DMScreeny, 0.945 * DMScreenx, 0.5725 * DMScreeny, tocolor(255, 255, 255, 220), DMTextSizex, DMTextSizey, "default", "center", "center")
dxDrawRectangle(0.78 * DMScreenx, 0.529 * DMScreeny, 0.17 * DMScreenx, 0.048 * DMScreeny, tocolor(20, 20, 20, 100))
end
if(DMClientDogFitness >= 70)then
dxDrawText("Ninja Kick", 0.785 * DMScreenx, 0.5725 * DMScreeny, 0.945 * DMScreenx, 0.621 * DMScreeny, tocolor(255, 255, 255, 220), DMTextSizex, DMTextSizey, "pricedown", "center", "center")
else
dxDrawText("Gesperrt", 0.785 * DMScreenx, 0.5725 * DMScreeny, 0.945 * DMScreenx, 0.606 * DMScreeny, tocolor(255, 255, 255, 220), DMTextSizex, DMTextSizey, "pricedown", "center", "center")
dxDrawText("Fitness 70", 0.785 * DMScreenx, 0.606 * DMScreeny, 0.945 * DMScreenx, 0.621 * DMScreeny, tocolor(255, 255, 255, 220), DMTextSizex, DMTextSizey, "default", "center", "center")
dxDrawRectangle(0.78 * DMScreenx, 0.5775 * DMScreeny, 0.17 * DMScreenx, 0.048 * DMScreeny, tocolor(20, 20, 20, 100))
end
if(DMClientDogFitness >= 95)then
dxDrawText("Moonwalk", 0.785 * DMScreenx, 0.621 * DMScreeny, 0.945 * DMScreenx, 0.6695 * DMScreeny, tocolor(255, 255, 255, 220), DMTextSizex, DMTextSizey, "pricedown", "center", "center")
else
dxDrawText("Gesperrt", 0.785 * DMScreenx, 0.621 * DMScreeny, 0.945 * DMScreenx, 0.6545 * DMScreeny, tocolor(255, 255, 255, 220), DMTextSizex, DMTextSizey, "pricedown", "center", "center")
dxDrawText("Fitness 95", 0.785 * DMScreenx, 0.6545 * DMScreeny, 0.945 * DMScreenx, 0.6695 * DMScreeny, tocolor(255, 255, 255, 220), DMTextSizex, DMTextSizey, "default", "center", "center")
dxDrawRectangle(0.78 * DMScreenx, 0.626 * DMScreeny, 0.17 * DMScreenx, 0.044 * DMScreeny, tocolor(20, 20, 20, 100))
end
end
end

function DMTricksDog()
if(DMDogSpawned == true and DMPlayerInFight == false)then
removeEventHandler("onClientRender", getRootElement(), DMDogPanelGui)
DMDogPanel = false 

guiSetVisible(DMDogPanelButton1, false)
guiSetVisible(DMDogPanelButton2, false)
guiSetVisible(DMDogPanelButton3, false)
guiSetVisible(DMDogPanelButton4, false)
guiSetVisible(DMDogPanelButton5, false)
guiSetVisible(DMDogPanelButton6, false)
guiSetVisible(DMDogPanelButton7, false)

addEventHandler("onClientRender", getRootElement(), DMTricksDogGui)
guiSetVisible(DMTricksDogButton1, true)
guiSetVisible(DMTricksDogButton2, true)
guiSetVisible(DMTricksDogButton3, true)
guiSetVisible(DMTricksDogButton4, true)
guiSetVisible(DMTricksDogButton5, true)
guiSetVisible(DMTricksDogButton6, true)
guiSetVisible(DMTricksDogButton7, true)
guiSetVisible(DMTricksDogButton8, true)
DMTricksDogPanel = true
end
end

function DMTricksDogInteractives()
DMTricksDogButton1 = guiCreateButton ( 0.78 * DMScreenx, 0.33 * DMScreeny, 0.17 * DMScreenx, 0.0485 * DMScreeny, "", false)
DMTricksDogButton2 = guiCreateButton ( 0.78 * DMScreenx, 0.3785 * DMScreeny, 0.17 * DMScreenx, 0.0485 * DMScreeny, "", false)
DMTricksDogButton3 = guiCreateButton ( 0.78 * DMScreenx, 0.427 * DMScreeny, 0.17 * DMScreenx, 0.0485 * DMScreeny, "", false)
DMTricksDogButton4 = guiCreateButton ( 0.78 * DMScreenx, 0.4755 * DMScreeny, 0.17 * DMScreenx, 0.0485 * DMScreeny, "", false)
DMTricksDogButton5 = guiCreateButton ( 0.78 * DMScreenx, 0.524 * DMScreeny, 0.17 * DMScreenx, 0.0485 * DMScreeny, "", false)
DMTricksDogButton6 = guiCreateButton ( 0.78 * DMScreenx, 0.5725 * DMScreeny, 0.17 * DMScreenx, 0.0485 * DMScreeny, "", false)
DMTricksDogButton7 = guiCreateButton ( 0.78 * DMScreenx, 0.621 * DMScreeny, 0.17 * DMScreenx, 0.0485 * DMScreeny, "", false)

guiSetAlpha(DMTricksDogButton1, 0)
guiSetAlpha(DMTricksDogButton2, 0)
guiSetAlpha(DMTricksDogButton3, 0)
guiSetAlpha(DMTricksDogButton4, 0)
guiSetAlpha(DMTricksDogButton5, 0)
guiSetAlpha(DMTricksDogButton6, 0)
guiSetAlpha(DMTricksDogButton7, 0)

guiSetVisible(DMTricksDogButton1, false)
guiSetVisible(DMTricksDogButton2, false)
guiSetVisible(DMTricksDogButton3, false)
guiSetVisible(DMTricksDogButton4, false)
guiSetVisible(DMTricksDogButton5, false)
guiSetVisible(DMTricksDogButton6, false)
guiSetVisible(DMTricksDogButton7, false)

addEventHandler ( "onClientGUIClick", DMTricksDogButton1, DMTricksDogTutorial, false )
addEventHandler ( "onClientGUIClick", DMTricksDogButton2, DMTricksDogTutorial, false )
addEventHandler ( "onClientGUIClick", DMTricksDogButton3, DMTricksDogTutorial, false )
addEventHandler ( "onClientGUIClick", DMTricksDogButton4, DMTricksDogTutorial, false )
addEventHandler ( "onClientGUIClick", DMTricksDogButton5, DMTricksDogTutorial, false )
addEventHandler ( "onClientGUIClick", DMTricksDogButton6, DMTricksDogTutorial, false )
addEventHandler ( "onClientGUIClick", DMTricksDogButton7, DMTricksDogTutorial, false )
end

function DMTricksDogTutorialGui()
if(DMLanguage == 1)then
if(DMGotCursorPosition == false)then
dxDrawRectangle(0.45 * DMScreenx, 0.4 * DMScreeny, 0.1 * DMScreenx, 0.2 * DMScreeny, tocolor(20, 20, 20, 220))
dxDrawText("In Yek Amoozesh Ast. Agar Mikhahid Sage Shoma Dar Heyne Bazi Kardan Tarfand Ejra Konad, Kelide O Ra Bezanid.", 0.45 * DMScreenx, 0.405 * DMScreeny, 0.55 * DMScreenx,  0.5 * DMScreeny, tocolor(255, 255, 255, 220), DMTextSizex, DMTextSizey, "default", "center", "center",false, true)
dxDrawText("Click and hold on the screen", 0.45 * DMScreenx, 0.505 * DMScreeny, 0.55 * DMScreenx,  0.6 * DMScreeny, tocolor(DMClientDogGenderColorR, DMClientDogGenderColorG, DMClientDogGenderColorB, 220), DMTextSizex, DMTextSizey, "default-bold", "center", "center",false, true)
else
dxDrawRectangle(0.45 * DMScreenx, 0.45 * DMScreeny, 0.1 * DMScreenx, 0.1 * DMScreeny, tocolor(20, 20, 20, 220))
if(DMClientDogGender == "male")then
dxDrawText("Be Mostatile Aabi Bekeshid", 0.45 * DMScreenx, 0.45 * DMScreeny, 0.55 * DMScreenx,  0.55 * DMScreeny, tocolor(DMClientDogGenderColorR, DMClientDogGenderColorG, DMClientDogGenderColorB, 220), DMTextSizex, DMTextSizey, "default-bold", "center", "center")
elseif(DMClientDogGender == "female")then
dxDrawText("Be Mostatile Soorati Bekeshid", 0.45 * DMScreenx, 0.45 * DMScreeny, 0.55 * DMScreenx,  0.55 * DMScreeny, tocolor(DMClientDogGenderColorR, DMClientDogGenderColorG, DMClientDogGenderColorB, 220), DMTextSizex, DMTextSizey, "default-bold", "center", "center")
end

if(DMTrickTutorial == 1)then
dxDrawRectangle((DMCursorx - 0.1) * DMScreenx, (DMCursory + 0.2) * DMScreeny, 0.2 * DMScreenx, 0.2 * DMScreeny, tocolor(DMClientDogGenderColorR, DMClientDogGenderColorG, DMClientDogGenderColorB, 240))
end
if(DMTrickTutorial == 2)then
dxDrawRectangle((DMCursorx - 0.1) * DMScreenx, (DMCursory + 0.2) * DMScreeny, 0.2 * DMScreenx, 0.2 * DMScreeny, tocolor(0, 0, 0, 100))
dxDrawRectangle((DMCursorx - 0.1) * DMScreenx, (DMCursory - 0.4) * DMScreeny, 0.2 * DMScreenx, 0.2 * DMScreeny, tocolor(0, 0, 0, 100))
dxDrawRectangle(0 * DMScreenx, (DMCursory - 0.1) * DMScreeny, (DMCursorx - 0.2) * DMScreenx, 0.2 * DMScreeny, tocolor(0, 0, 0, 100))
dxDrawRectangle((DMCursorx + 0.2) * DMScreenx, (DMCursory - 0.1) * DMScreeny, (1 - DMCursorx - 0.2) * DMScreenx, 0.2 * DMScreeny, tocolor(0, 0, 0, 100))
dxDrawRectangle((DMCursorx - 0.1) * DMScreenx, 0 * DMScreeny, 0.2 * DMScreenx, (DMCursory - 0.4) * DMScreeny, tocolor(0, 0, 0, 200))--!!
dxDrawRectangle((DMCursorx - 0.1) * DMScreenx, (DMCursory + 0.4) * DMScreeny, 0.2 * DMScreenx, (1 - DMCursory + 0.2) * DMScreeny, tocolor(DMClientDogGenderColorR, DMClientDogGenderColorG, DMClientDogGenderColorB, 240))
end
if(DMTrickTutorial == 3)then
dxDrawRectangle((DMCursorx - 0.1) * DMScreenx, (DMCursory + 0.2) * DMScreeny, 0.2 * DMScreenx, 0.2 * DMScreeny, tocolor(0, 0, 0, 100))--!!
dxDrawRectangle((DMCursorx - 0.1) * DMScreenx, (DMCursory - 0.4) * DMScreeny, 0.2 * DMScreenx, 0.2 * DMScreeny, tocolor(DMClientDogGenderColorR, DMClientDogGenderColorG, DMClientDogGenderColorB, 240))
end
if(DMTrickTutorial == 4)then
dxDrawRectangle((DMCursorx - 0.1) * DMScreenx, (DMCursory + 0.2) * DMScreeny, 0.2 * DMScreenx, 0.2 * DMScreeny, tocolor(0, 0, 0, 100))
dxDrawRectangle((DMCursorx - 0.1) * DMScreenx, (DMCursory - 0.4) * DMScreeny, 0.2 * DMScreenx, 0.2 * DMScreeny, tocolor(0, 0, 0, 100))
dxDrawRectangle(0 * DMScreenx, (DMCursory - 0.1) * DMScreeny, (DMCursorx - 0.2) * DMScreenx, 0.2 * DMScreeny, tocolor(0, 0, 0, 100))
dxDrawRectangle((DMCursorx + 0.2) * DMScreenx, (DMCursory - 0.1) * DMScreeny, (1 - DMCursorx - 0.2) * DMScreenx, 0.2 * DMScreeny, tocolor(0, 0, 0, 100))--!!
dxDrawRectangle((DMCursorx - 0.1) * DMScreenx, 0 * DMScreeny, 0.2 * DMScreenx, (DMCursory - 0.4) * DMScreeny, tocolor(DMClientDogGenderColorR, DMClientDogGenderColorG, DMClientDogGenderColorB, 240))
end
if(DMTrickTutorial == 5)then
dxDrawRectangle((DMCursorx - 0.1) * DMScreenx, (DMCursory + 0.2) * DMScreeny, 0.2 * DMScreenx, 0.2 * DMScreeny, tocolor(0, 0, 0, 100))
dxDrawRectangle((DMCursorx - 0.1) * DMScreenx, (DMCursory - 0.4) * DMScreeny, 0.2 * DMScreenx, 0.2 * DMScreeny, tocolor(0, 0, 0, 100))--!!
dxDrawRectangle(0 * DMScreenx, (DMCursory - 0.1) * DMScreeny, (DMCursorx - 0.2) * DMScreenx, 0.2 * DMScreeny, tocolor(51, 204, 255, 240))
dxDrawRectangle((DMCursorx + 0.2) * DMScreenx, (DMCursory - 0.1) * DMScreeny, (1 - DMCursorx - 0.2) * DMScreenx, 0.2 * DMScreeny, tocolor(DMClientDogGenderColorR, DMClientDogGenderColorG, DMClientDogGenderColorB, 240))
end
if(DMTrickTutorial == 7)then
dxDrawRectangle((DMCursorx - 0.1) * DMScreenx, (DMCursory + 0.2) * DMScreeny, 0.2 * DMScreenx, 0.2 * DMScreeny, tocolor(0, 0, 0, 100))
dxDrawRectangle((DMCursorx - 0.1) * DMScreenx, (DMCursory - 0.4) * DMScreeny, 0.2 * DMScreenx, 0.2 * DMScreeny, tocolor(0, 0, 0, 100))
dxDrawRectangle(0 * DMScreenx, (DMCursory - 0.1) * DMScreeny, (DMCursorx - 0.2) * DMScreenx, 0.2 * DMScreeny, tocolor(0, 0, 0, 100))
dxDrawRectangle((DMCursorx + 0.2) * DMScreenx, (DMCursory - 0.1) * DMScreeny, (1 - DMCursorx - 0.2) * DMScreenx, 0.2 * DMScreeny, tocolor(0, 0, 0, 100))
dxDrawRectangle((DMCursorx - 0.1) * DMScreenx, 0 * DMScreeny, 0.2 * DMScreenx, (DMCursory - 0.4) * DMScreeny, tocolor(0, 0, 0, 200))
dxDrawRectangle((DMCursorx - 0.1) * DMScreenx, (DMCursory + 0.4) * DMScreeny, 0.2 * DMScreenx, (1 - DMCursory + 0.2) * DMScreeny, tocolor(0, 0, 0, 200))--!!
dxDrawRectangle(0 * DMScreenx, 0 * DMScreeny, (DMCursorx - 0.2) * DMScreenx, (DMCursory - 0.2) * DMScreeny, tocolor(DMClientDogGenderColorR, DMClientDogGenderColorG, DMClientDogGenderColorB, 240))
end
if(DMTrickTutorial == 8)then
dxDrawRectangle((DMCursorx - 0.1) * DMScreenx, (DMCursory + 0.2) * DMScreeny, 0.2 * DMScreenx, 0.2 * DMScreeny, tocolor(0, 0, 0, 100))
dxDrawRectangle((DMCursorx - 0.1) * DMScreenx, (DMCursory - 0.4) * DMScreeny, 0.2 * DMScreenx, 0.2 * DMScreeny, tocolor(0, 0, 0, 100))
dxDrawRectangle(0 * DMScreenx, (DMCursory - 0.1) * DMScreeny, (DMCursorx - 0.2) * DMScreenx, 0.2 * DMScreeny, tocolor(0, 0, 0, 100))
dxDrawRectangle((DMCursorx + 0.2) * DMScreenx, (DMCursory - 0.1) * DMScreeny, (1 - DMCursorx - 0.2) * DMScreenx, 0.2 * DMScreeny, tocolor(0, 0, 0, 100))
dxDrawRectangle((DMCursorx - 0.1) * DMScreenx, 0 * DMScreeny, 0.2 * DMScreenx, (DMCursory - 0.4) * DMScreeny, tocolor(0, 0, 0, 200))
dxDrawRectangle((DMCursorx - 0.1) * DMScreenx, (DMCursory + 0.4) * DMScreeny, 0.2 * DMScreenx, (1 - DMCursory + 0.2) * DMScreeny, tocolor(0, 0, 0, 200))
dxDrawRectangle(0 * DMScreenx, 0 * DMScreeny, (DMCursorx - 0.2) * DMScreenx, (DMCursory - 0.2) * DMScreeny, tocolor(0, 0, 0, 100))--!!
dxDrawRectangle(0 * DMScreenx, (DMCursory + 0.4) * DMScreeny, (DMCursorx - 0.2) * DMScreenx, (1 - DMCursory + 0.2) * DMScreeny, tocolor(DMClientDogGenderColorR, DMClientDogGenderColorG, DMClientDogGenderColorB, 240))
end
end
elseif(DMLanguage == 2)then
if(DMGotCursorPosition == false)then
dxDrawRectangle(0.45 * DMScreenx, 0.4 * DMScreeny, 0.1 * DMScreenx, 0.2 * DMScreeny, tocolor(20, 20, 20, 220))
dxDrawText("Dies ist eine Anleitung. Wenn du einen Trick während des spielens durchführen möchtest, drücke O.", 0.45 * DMScreenx, 0.405 * DMScreeny, 0.55 * DMScreenx,  0.5 * DMScreeny, tocolor(255, 255, 255, 220), DMTextSizex, DMTextSizey, "default", "center", "center",false, true)
dxDrawText("Klicke und Halte die Maustaste", 0.45 * DMScreenx, 0.505 * DMScreeny, 0.55 * DMScreenx,  0.6 * DMScreeny, tocolor(DMClientDogGenderColorR, DMClientDogGenderColorG, DMClientDogGenderColorB, 220), DMTextSizex, DMTextSizey, "default-bold", "center", "center",false, true)
else
dxDrawRectangle(0.425 * DMScreenx, 0.45 * DMScreeny, 0.15 * DMScreenx, 0.1 * DMScreeny, tocolor(20, 20, 20, 220))
if(DMClientDogGender == "male")then
dxDrawText("Ziehe den Cursor zum blauen Rechteck", 0.45 * DMScreenx, 0.45 * DMScreeny, 0.55 * DMScreenx,  0.55 * DMScreeny, tocolor(DMClientDogGenderColorR, DMClientDogGenderColorG, DMClientDogGenderColorB, 220), DMTextSizex, DMTextSizey, "default-bold", "center", "center")
elseif(DMClientDogGender == "female")then
dxDrawText("Ziehe den Cursor zum pinken Rechteck", 0.45 * DMScreenx, 0.45 * DMScreeny, 0.55 * DMScreenx,  0.55 * DMScreeny, tocolor(DMClientDogGenderColorR, DMClientDogGenderColorG, DMClientDogGenderColorB, 220), DMTextSizex, DMTextSizey, "default-bold", "center", "center")
end

if(DMTrickTutorial == 1)then
dxDrawRectangle((DMCursorx - 0.1) * DMScreenx, (DMCursory + 0.2) * DMScreeny, 0.2 * DMScreenx, 0.2 * DMScreeny, tocolor(DMClientDogGenderColorR, DMClientDogGenderColorG, DMClientDogGenderColorB, 240))
end
if(DMTrickTutorial == 2)then
dxDrawRectangle((DMCursorx - 0.1) * DMScreenx, (DMCursory + 0.2) * DMScreeny, 0.2 * DMScreenx, 0.2 * DMScreeny, tocolor(0, 0, 0, 100))
dxDrawRectangle((DMCursorx - 0.1) * DMScreenx, (DMCursory - 0.4) * DMScreeny, 0.2 * DMScreenx, 0.2 * DMScreeny, tocolor(0, 0, 0, 100))
dxDrawRectangle(0 * DMScreenx, (DMCursory - 0.1) * DMScreeny, (DMCursorx - 0.2) * DMScreenx, 0.2 * DMScreeny, tocolor(0, 0, 0, 100))
dxDrawRectangle((DMCursorx + 0.2) * DMScreenx, (DMCursory - 0.1) * DMScreeny, (1 - DMCursorx - 0.2) * DMScreenx, 0.2 * DMScreeny, tocolor(0, 0, 0, 100))
dxDrawRectangle((DMCursorx - 0.1) * DMScreenx, 0 * DMScreeny, 0.2 * DMScreenx, (DMCursory - 0.4) * DMScreeny, tocolor(0, 0, 0, 200))--!!
dxDrawRectangle((DMCursorx - 0.1) * DMScreenx, (DMCursory + 0.4) * DMScreeny, 0.2 * DMScreenx, (1 - DMCursory + 0.2) * DMScreeny, tocolor(DMClientDogGenderColorR, DMClientDogGenderColorG, DMClientDogGenderColorB, 240))
end
if(DMTrickTutorial == 3)then
dxDrawRectangle((DMCursorx - 0.1) * DMScreenx, (DMCursory + 0.2) * DMScreeny, 0.2 * DMScreenx, 0.2 * DMScreeny, tocolor(0, 0, 0, 100))--!!
dxDrawRectangle((DMCursorx - 0.1) * DMScreenx, (DMCursory - 0.4) * DMScreeny, 0.2 * DMScreenx, 0.2 * DMScreeny, tocolor(DMClientDogGenderColorR, DMClientDogGenderColorG, DMClientDogGenderColorB, 240))
end
if(DMTrickTutorial == 4)then
dxDrawRectangle((DMCursorx - 0.1) * DMScreenx, (DMCursory + 0.2) * DMScreeny, 0.2 * DMScreenx, 0.2 * DMScreeny, tocolor(0, 0, 0, 100))
dxDrawRectangle((DMCursorx - 0.1) * DMScreenx, (DMCursory - 0.4) * DMScreeny, 0.2 * DMScreenx, 0.2 * DMScreeny, tocolor(0, 0, 0, 100))
dxDrawRectangle(0 * DMScreenx, (DMCursory - 0.1) * DMScreeny, (DMCursorx - 0.2) * DMScreenx, 0.2 * DMScreeny, tocolor(0, 0, 0, 100))
dxDrawRectangle((DMCursorx + 0.2) * DMScreenx, (DMCursory - 0.1) * DMScreeny, (1 - DMCursorx - 0.2) * DMScreenx, 0.2 * DMScreeny, tocolor(0, 0, 0, 100))--!!
dxDrawRectangle((DMCursorx - 0.1) * DMScreenx, 0 * DMScreeny, 0.2 * DMScreenx, (DMCursory - 0.4) * DMScreeny, tocolor(DMClientDogGenderColorR, DMClientDogGenderColorG, DMClientDogGenderColorB, 240))
end
if(DMTrickTutorial == 5)then
dxDrawRectangle((DMCursorx - 0.1) * DMScreenx, (DMCursory + 0.2) * DMScreeny, 0.2 * DMScreenx, 0.2 * DMScreeny, tocolor(0, 0, 0, 100))
dxDrawRectangle((DMCursorx - 0.1) * DMScreenx, (DMCursory - 0.4) * DMScreeny, 0.2 * DMScreenx, 0.2 * DMScreeny, tocolor(0, 0, 0, 100))--!!
dxDrawRectangle(0 * DMScreenx, (DMCursory - 0.1) * DMScreeny, (DMCursorx - 0.2) * DMScreenx, 0.2 * DMScreeny, tocolor(51, 204, 255, 240))
dxDrawRectangle((DMCursorx + 0.2) * DMScreenx, (DMCursory - 0.1) * DMScreeny, (1 - DMCursorx - 0.2) * DMScreenx, 0.2 * DMScreeny, tocolor(DMClientDogGenderColorR, DMClientDogGenderColorG, DMClientDogGenderColorB, 240))
end
if(DMTrickTutorial == 7)then
dxDrawRectangle((DMCursorx - 0.1) * DMScreenx, (DMCursory + 0.2) * DMScreeny, 0.2 * DMScreenx, 0.2 * DMScreeny, tocolor(0, 0, 0, 100))
dxDrawRectangle((DMCursorx - 0.1) * DMScreenx, (DMCursory - 0.4) * DMScreeny, 0.2 * DMScreenx, 0.2 * DMScreeny, tocolor(0, 0, 0, 100))
dxDrawRectangle(0 * DMScreenx, (DMCursory - 0.1) * DMScreeny, (DMCursorx - 0.2) * DMScreenx, 0.2 * DMScreeny, tocolor(0, 0, 0, 100))
dxDrawRectangle((DMCursorx + 0.2) * DMScreenx, (DMCursory - 0.1) * DMScreeny, (1 - DMCursorx - 0.2) * DMScreenx, 0.2 * DMScreeny, tocolor(0, 0, 0, 100))
dxDrawRectangle((DMCursorx - 0.1) * DMScreenx, 0 * DMScreeny, 0.2 * DMScreenx, (DMCursory - 0.4) * DMScreeny, tocolor(0, 0, 0, 200))
dxDrawRectangle((DMCursorx - 0.1) * DMScreenx, (DMCursory + 0.4) * DMScreeny, 0.2 * DMScreenx, (1 - DMCursory + 0.2) * DMScreeny, tocolor(0, 0, 0, 200))--!!
dxDrawRectangle(0 * DMScreenx, 0 * DMScreeny, (DMCursorx - 0.2) * DMScreenx, (DMCursory - 0.2) * DMScreeny, tocolor(DMClientDogGenderColorR, DMClientDogGenderColorG, DMClientDogGenderColorB, 240))
end
if(DMTrickTutorial == 8)then
dxDrawRectangle((DMCursorx - 0.1) * DMScreenx, (DMCursory + 0.2) * DMScreeny, 0.2 * DMScreenx, 0.2 * DMScreeny, tocolor(0, 0, 0, 100))
dxDrawRectangle((DMCursorx - 0.1) * DMScreenx, (DMCursory - 0.4) * DMScreeny, 0.2 * DMScreenx, 0.2 * DMScreeny, tocolor(0, 0, 0, 100))
dxDrawRectangle(0 * DMScreenx, (DMCursory - 0.1) * DMScreeny, (DMCursorx - 0.2) * DMScreenx, 0.2 * DMScreeny, tocolor(0, 0, 0, 100))
dxDrawRectangle((DMCursorx + 0.2) * DMScreenx, (DMCursory - 0.1) * DMScreeny, (1 - DMCursorx - 0.2) * DMScreenx, 0.2 * DMScreeny, tocolor(0, 0, 0, 100))
dxDrawRectangle((DMCursorx - 0.1) * DMScreenx, 0 * DMScreeny, 0.2 * DMScreenx, (DMCursory - 0.4) * DMScreeny, tocolor(0, 0, 0, 200))
dxDrawRectangle((DMCursorx - 0.1) * DMScreenx, (DMCursory + 0.4) * DMScreeny, 0.2 * DMScreenx, (1 - DMCursory + 0.2) * DMScreeny, tocolor(0, 0, 0, 200))
dxDrawRectangle(0 * DMScreenx, 0 * DMScreeny, (DMCursorx - 0.2) * DMScreenx, (DMCursory - 0.2) * DMScreeny, tocolor(0, 0, 0, 100))--!!
dxDrawRectangle(0 * DMScreenx, (DMCursory + 0.4) * DMScreeny, (DMCursorx - 0.2) * DMScreenx, (1 - DMCursory + 0.2) * DMScreeny, tocolor(DMClientDogGenderColorR, DMClientDogGenderColorG, DMClientDogGenderColorB, 240))
end
end
end
end

function DMTricksDogTutorial()
DMTrickTutorial = 0
if(source == DMTricksDogButton1)then
if(DMClientDogFitness >= 0)then
DMTrickTutorial = 1
end
elseif(source == DMTricksDogButton2)then
if(DMClientDogFitness >= 5)then
DMTrickTutorial = 3
end
elseif(source == DMTricksDogButton3)then
if(DMClientDogFitness >= 15)then
DMTrickTutorial = 5
end
elseif(source == DMTricksDogButton4)then
if(DMClientDogFitness >= 30)then
DMTrickTutorial = 4
end
elseif(source == DMTricksDogButton5)then
if(DMClientDogFitness >= 50)then
DMTrickTutorial = 2
end
elseif(source == DMTricksDogButton6)then
if(DMClientDogFitness >= 70)then
DMTrickTutorial = 7
end
elseif(source == DMTricksDogButton7)then
if(DMClientDogFitness >= 95)then
DMTrickTutorial = 8
end
end

if(DMTrickTutorial ~= 0)then
removeEventHandler("onClientRender", getRootElement(), DMTricksDogGui)
DMTricksDogPanel = false
guiSetVisible(DMTricksDogButton1, false)
guiSetVisible(DMTricksDogButton2, false)
guiSetVisible(DMTricksDogButton3, false)
guiSetVisible(DMTricksDogButton4, false)
guiSetVisible(DMTricksDogButton5, false)
guiSetVisible(DMTricksDogButton6, false)
guiSetVisible(DMTricksDogButton7, false)
guiSetVisible(DMTricksDogButton8, false)

DMTricksTutorialActive = true

DMGotCursorPosition = false
DMGetCoursorPosTimer = setTimer(function()
if(DMGotCursorPosition == false)then
if (getKeyState( "mouse1" ) == true)then
DMCursorx, DMCursory, DMworldx, DMworldy, DMworldz = getCursorPosition()
DMGotCursorPosition = true
end
elseif(DMGotCursorPosition == true)then
if (getKeyState( "mouse1" ) == false)then
DMStopCursorx, DMStopCursory, DMstopworldx, DMStopworldy, DMStopworldz = getCursorPosition()
local DMDogTrick
local DMCursorDifx = DMStopCursorx - DMCursorx
local DMCursorDify = DMStopCursory - DMCursory
local DMLeft = false

if(DMCursorDifx < 0.1 and DMCursorDifx > -0.1)then
if(DMCursorDify > 0.2 and DMCursorDify < 0.4)then
DMDogTrick = 1
DMTrickLength = 1000
end
end

if(DMCursorDifx < 0.1 and DMCursorDifx > -0.1)then
if(DMCursorDify > 0.4)then
DMDogTrick = 2
DMTrickLength = 1000
end
end

--up
if(DMCursorDifx < 0.1 and DMCursorDifx > -0.1)then
if(DMCursorDify < -0.2 and DMCursorDify > -0.4)then
DMDogTrick = 3
DMTrickLength = 700
end
end

if(DMCursorDifx < 0.1 and DMCursorDifx > -0.1)then
if(DMCursorDify < -0.4)then
DMDogTrick = 4
DMTrickLength = 800
end
end

--right
if(DMCursorDifx > 0.2 )then
if(DMCursorDify < 0.1 and DMCursorDify > -0.1)then
DMDogTrick = 5
DMTrickLength = 1000
DMLeft = false
end
end

--left
if(DMCursorDifx < -0.2 )then
if(DMCursorDify < 0.1 and DMCursorDify > -0.1)then
DMDogTrick = 5
DMTrickLength = 1000
DMLeft = true
end
end

--upleft
if(DMCursorDifx < -0.2)then
if(DMCursorDify < -0.2)then
DMDogTrick = 7
DMTrickLength = 900
end
end

--downright
if(DMCursorDifx < -0.2)then
if(DMCursorDify > 0.2)then
DMDogTrick = 8
DMTrickLength = 2000
end
end

if(DMDogTrick == DMTrickTutorial)then
killTimer(DMGetCoursorPosTimer)
showCursor(false)
guiSetInputEnabled(false)
removeEventHandler("onClientRender", getRootElement(), DMTricksDogTutorialGui)
DMTricksTutorialActive = false
if(DMDogSpawned == true)then
if(DMDogTrick == 5)then
if(DMLeft == true)then
DMDogTrick = 6
end
end
addEventHandler("onClientRender", getRootElement(), DMStatusGui)
DMStatusActive = true
triggerServerEvent("DMDoTrick", getRootElement(), DMDogTrick, DMDogStatus, DMClientDog, DMTrickLength)
end
else
DMGotCursorPosition = false
if(DMLanguage == 1)then
outputChatBox("Tarfand Na Movafagh Bood", 255,0,0)
elseif(DMLanguage == 2)then
outputChatBox("Trick fehlgeschlagen", 255,0,0)
end

end

end
end
end, 50, 0)

addEventHandler("onClientRender", getRootElement(), DMTricksDogTutorialGui)
end
end

function DMDoTrickGui()
dxDrawRectangle((DMCursorx + 0.01) * DMScreenx, (DMCursory - 0.01) * DMScreeny, 0.04 * DMScreenx, 0.02 * DMScreeny, tocolor(255, 255, 255, 150))
dxDrawRectangle((DMCursorx - 0.05) * DMScreenx, (DMCursory - 0.01) * DMScreeny, 0.04 * DMScreenx, 0.02 * DMScreeny, tocolor(255, 255, 255, 150))
dxDrawRectangle((DMCursorx - 0.01) * DMScreenx, (DMCursory - 0.05) * DMScreeny, 0.02 * DMScreenx, 0.1 * DMScreeny, tocolor(255, 255, 255, 150))
end

function DMDoTrick()
if(isPedInVehicle(getLocalPlayer()) == false and DMBallThrowActive == 0 and DMFeedActive == 0 and DMDogAttacking == false)then
showCursor(true)
local DMGotCursorPosition = false
local DMGetCoursorPosTimer
local DMDogTrick
local DMTrickLength

DMGetCoursorPosTimer = setTimer(function()
if(DMGotCursorPosition == false)then
if (getKeyState( "mouse1" ) == true)then
DMCursorx, DMCursory, DMworldx, DMworldy, DMworldz = getCursorPosition()
DMGotCursorPosition = true
addEventHandler("onClientRender", getRootElement(), DMDoTrickGui)
end
elseif(DMGotCursorPosition == true)then
if (getKeyState( "mouse1" ) == false)then
removeEventHandler("onClientRender", getRootElement(), DMDoTrickGui)
DMStopCursorx, DMStopCursory, DMstopworldx, DMStopworldy, DMStopworldz = getCursorPosition()
killTimer(DMGetCoursorPosTimer)
showCursor(false)
local DMCursorDifx = DMStopCursorx - DMCursorx
local DMCursorDify = DMStopCursory - DMCursory
local DMGotAnim = false
--down
if(DMCursorDifx < 0.1 and DMCursorDifx > -0.1)then
if(DMCursorDify > 0.2 and DMCursorDify < 0.4)then
if(DMClientDogFitness >= 0)then
DMDogTrick = 1
DMTrickLength = 1000
DMGotAnim = true
end
end
end

if(DMCursorDifx < 0.1 and DMCursorDifx > -0.1)then
if(DMCursorDify > 0.4)then
if(DMClientDogFitness >= 50)then
DMDogTrick = 2
DMTrickLength = 1000
DMGotAnim = true
end
end
end

--up
if(DMCursorDifx < 0.1 and DMCursorDifx > -0.1)then
if(DMCursorDify < -0.2 and DMCursorDify > -0.4)then
if(DMClientDogFitness >= 5)then
DMDogTrick = 3
DMTrickLength = 700
DMGotAnim = true
end
end
end

if(DMCursorDifx < 0.1 and DMCursorDifx > -0.1)then
if(DMCursorDify < -0.4)then
if(DMClientDogFitness >= 30)then
DMDogTrick = 4
DMTrickLength = 800
DMGotAnim = true
end
end
end

--right
if(DMCursorDifx > 0.2 )then
if(DMCursorDify < 0.1 and DMCursorDify > -0.1)then
if(DMClientDogFitness >= 15)then
DMDogTrick = 5
DMTrickLength = 1000
DMGotAnim = true
end
end
end

--left
if(DMCursorDifx < -0.2 )then
if(DMCursorDify < 0.1 and DMCursorDify > -0.1)then
if(DMClientDogFitness >= 15)then
DMDogTrick = 6
DMTrickLength = 1000
DMGotAnim = true
end
end
end

--upleft
if(DMCursorDifx < -0.2)then
if(DMCursorDify < -0.2)then
if(DMClientDogFitness >= 70)then
DMDogTrick = 7
DMTrickLength = 900
DMGotAnim = true
end
end
end

--downright
if(DMCursorDifx < -0.2)then
if(DMCursorDify > 0.2)then
if(DMClientDogFitness >= 100)then
DMDogTrick = 8
DMTrickLength = 2000
DMGotAnim = true
end
end
end

if(DMGotAnim == true)then
triggerServerEvent("DMDoTrick", getRootElement(), DMDogTrick, DMDogStatus, DMClientDog, DMTrickLength)
end

end
end
end, 50, 0)
end
end

--INVENTORY (special thanks to brudi r1k3)
function DMInverntoryBall()
if(DMDogSpawned == true and DMPlayerInFight == false)then
if(DMBallThrowActive == 0)then
local DMStopDog = false
DMExit(DMStopDog)

if(DMStatusGuiWasOn == true)then
DMStatusActive = true
addEventHandler("onClientRender", getRootElement(), DMStatusGui)
end

    setPedWeaponSlot(getLocalPlayer(),0)
	DMBall = createObject(3002,0,0,0)
	setElementCollisionsEnabled(DMBall,false)
	addEventHandler("onClientPreRender",getRootElement(),DMkeepInHand)
	addEventHandler("onClientKey",getRootElement(),DMthrowBall)
	addEventHandler("onClientPlayerWeaponSwitch", getRootElement(),DMballWeaponSwitch)
	unbindKey(ChangeStatusKey,"down", DMChangeDogStatus)
	DMBallThrowActive = 1
end
end
end

function DMkeepInHand()
	local x,y,z = getPedBonePosition(getLocalPlayer(),26)
	setElementPosition(DMBall,x,y,z)
end

function DMballWeaponSwitch(prev,cur)
	if prev == 0 then
		destroyElement(DMBall)
removeEventHandler("onClientPreRender",getRootElement(),DMkeepInHand)
removeEventHandler("onClientKey",getRootElement(),DMthrowBall)
removeEventHandler("onClientPlayerWeaponSwitch", getRootElement(),DMballWeaponSwitch)
	DMInventoryBallExit()	
	end
end

function DMthrowBall(button, state)
	if button == "mouse1" and state == true then
	DMBallThrowActive = 2
	DMInventoryBallOnGround = false
	DMOldDogStatus = DMDogStatus
	if(DMDogStatus == 1)then
    destroyElement(DMDogIdleBlip)
    killTimer(DMDogIdleTimer)
    DMPositionSyncTimer = setTimer(function()
    local Dogx, Dogy, Dogz = getElementPosition(DMClientDog)
    triggerServerEvent("DMSyncPosition", getRootElement(),DMClientDog, Dogx, Dogy, Dogz)
    end, 1000, 0)
    elseif(DMDogStatus == 2)then
    removeEventHandler("onClientRender", getRootElement(), DMDogActionFollow )
    elseif(DMDogStatus == 3)then
    if(removeEventHandler("onClientRender", getRootElement(), DMDogActionFollow ))then
    else
    removeEventHandler("onClientRender", getRootElement(), DMDogActionAttack)
    end
	elseif(DMDogStatus == 7)then
	DMDogAttacking = false
    removeEventHandler("onClientRender", getRootElement(), DMDogActionAttack)
    end
    
	DMDogStatus = 5
		setPedAnimation(getLocalPlayer(),"GRENADE", "WEAPON_throw",-1,false)
		setTimer(function()
			xInHand,yInHand,zInHand = getElementPosition(DMBall)
			removeEventHandler("onClientPreRender",getRootElement(),DMkeepInHand)
			toggleControl("fire",true)
			setElementPosition(DMBall)
			pedx, pedy, pedz = getElementPosition(getLocalPlayer())
			rotx,roty,rotz = getElementRotation(getLocalPlayer())
			maxZ = pedz+4
			r = 0.1
			oldGroundDiff = 1
			addEventHandler("onClientRender",getRootElement(),DMthrowedBall)
		end,300,1)
		setTimer(function()
			setPedAnimation(getLocalPlayer())
		end,900,1)
		removeEventHandler("onClientPlayerWeaponSwitch", getRootElement(),DMballWeaponSwitch)
		removeEventHandler("onClientKey",getRootElement(),DMthrowBall)
		
		local DMPlayerx, DMPlayery, DMPlayerz = getElementPosition(getLocalPlayer())
		local DMClientDogx, DMClientDogy, DMClientDogz = getElementPosition(DMClientDog)
		local DMDistance = getDistanceBetweenPoints2D (DMPlayerx , DMPlayery, DMClientDogx, DMClientDogy)
		if(DMDistance >= 20)then
		if(DMLanguage == 1)then
          outputChatBox("Sage Shoma Kheyli Door Ast", 255, 0,0)
        elseif(DMLanguage == 2)then
          outputChatBox("Hund ist zu weit entfernt", 255,0,0)
        end
		destroyElement(DMBall)
		removeEventHandler("onClientRender",getRootElement(),DMthrowedBall)
		DMInventoryBallExit()
		else
		DMDogFollow = 2
		addEventHandler("onClientRender",getRootElement(),DMDogActionFollow)
		DMInventoryGetBallTimer = setTimer(function()
		if(DMLanguage == 1)then
          outputChatBox("Sage Shoma Natavanest Be Toop Bepesad", 255, 0,0)
        elseif(DMLanguage == 2)then
          outputChatBox("Dein Hund konnte den Ball nicht finden", 255,0,0)
        end
		destroyElement(DMBall)
		removeEventHandler("onClientRender",getRootElement(),DMthrowedBall)
		DMInventoryBallExit()
		end, 10000, 1)
	    end
	end
end

function DMthrowedBall()
	oldx, oldy, oldz = getElementPosition(DMBall)
	oldz = newz
	newx = math.cos(math.rad(rotz+90))*r + pedx
	newy = math.sin(math.rad(rotz+90))*r + pedy
	newz = -1/30*(r-12)^2 + zInHand + 5
	oldGroundDiff = newGroundDiff
	newGroundDiff = oldz-getGroundPosition(oldx,oldy,oldz+1)
	if newGroundDiff>0 then
		r = r + 0.8
		setElementPosition(DMBall,newx,newy,newz)
	else
		if newGroundDiff-oldGroundDiff > 1.1 then
		end
		removeEventHandler("onClientRender",getRootElement(),DMthrowedBall)
		setElementPosition(DMBall,oldx,oldy,getGroundPosition(oldx,oldy,oldz+1)+0.1)
		DMInventoryBallOnGround = true
	end
end

function DMDoggotBall()
killTimer(DMInventoryGetBallTimer)
DMDogFollow = 1
destroyElement(DMBall)
DMBallThrowActive = 3
DMGotBallTimer = setTimer(function()
local DMPlayerx, DMPlayery, DMPlayerz = getElementPosition(getLocalPlayer())
local DMClientDogx, DMClientDogy, DMClientDogz = getElementPosition(DMClientDog)
local DMDistance = getDistanceBetweenPoints2D (DMPlayerx , DMPlayery, DMClientDogx, DMClientDogy)
if(DMDistance <= 1.5)then
killTimer(DMGotBallTimer)
removeEventHandler("onClientRender",getRootElement(),DMDogActionFollow)
DMInventoryBallExit()
end
end, 50,0)
end

function DMInventoryBallExit()
bindKey(ChangeStatusKey,"down", DMChangeDogStatus)
	if(DMBallThrowActive == 2 or DMBallThrowActive == 3)then
		if(DMOldDogStatus == 1 )then
		  triggerServerEvent("DMDogActionIdle", getRootElement(), DMClientDog)
          killTimer(DMPositionSyncTimer)
          DMDogStatus = 1
          DMDogIdleTimer = setTimer(function()
          destroyElement(DMDogIdleBlip) 
          local Dogx, Dogy, Dogz = getElementPosition(DMClientDog)
          DMDogIdleBlip = createBlip ( Dogx, Dogy, Dogz , 0, 2, 255, 255, 255, 255, 0, 250)

          local block, anim = getPedAnimation ( DMClientDog )
          if(anim ~= "OFF_Sit_Crash")then
          triggerServerEvent("DMDogActionIdle", getRootElement(), DMClientDog)
          end
          end, 5000, 0)
		elseif(DMOldDogStatus == 2 or DMOldDogStatus == 3 or DMOldDogStatus == 7)then
		  DMDogFollow = 1
          DMDogDistanceAnimation = 0
		  addEventHandler("onClientRender", getRootElement(), DMDogActionFollow )
		  if(DMOldDogStatus == 7)then
		  DMOldDogStatus = 3
		  end
		   DMDogStatus = DMOldDogStatus
		end

    end
DMBallThrowActive = 0
end

--TASKS
function DMDogActionGuard()
local DMPlayerx, DMPlayery, DMPlayerz = getElementPosition(DMGuardPlayerFound)
local DMClientDogx, DMClientDogy, DMClientDogz = getElementPosition(DMClientDog)
local DMDogFinalRotation
local DMDogDistanceAnimationChange
local DMDogRescueTeleport
local DMDogRotation = math.deg(math.atan((DMPlayerx - DMClientDogx) / (DMPlayery - DMClientDogy)))

if(DMPlayerx > DMClientDogx and DMPlayery > DMClientDogy)then
DMDogFinalRotation = DMDogRotation
elseif(DMPlayerx > DMClientDogx and DMPlayery < DMClientDogy)then
DMDogFinalRotation = 180 + DMDogRotation
elseif(DMPlayerx < DMClientDogx and DMPlayery < DMClientDogy)then
DMDogFinalRotation = 180 + DMDogRotation
elseif(DMPlayerx < DMClientDogx and DMPlayery > DMClientDogy)then
DMDogFinalRotation = 360 + DMDogRotation
end

if(DMDogFinalRotation == nil)then
DMDogFinalRotation = 0
end

local DMDistance = getDistanceBetweenPoints2D (DMPlayerx , DMPlayery, DMClientDogx, DMClientDogy)

if(DMDistance <= 1.5)then
  if(DMDogDistanceAnimation ~= 1)then
  DMDogDistanceAnimation = 1
  DMDogDistanceAnimationChange = true
  if( DMDogFollow == 2 and DMInventoryBallOnGround == true)then
  DMDoggotBall()
  end
  elseif(DMDogDistanceAnimation == 1)then
  DMDogDistanceAnimationChange = false
  end
elseif(DMDistance > 1.5 and DMDistance <= 4)then
  if(DMDogDistanceAnimation ~= 2)then
  DMDogDistanceAnimation = 2
  DMDogDistanceAnimationChange = true
  elseif(DMDogDistanceAnimation == 2)then
  DMDogDistanceAnimationChange = false
  end
elseif(DMDistance > 4 and DMDistance <= 7 )then
 if(DMDogDistanceAnimation ~= 3)then
 DMDogDistanceAnimation = 3
 DMDogDistanceAnimationChange = true
 elseif(DMDogDistanceAnimation == 3)then
 DMDogDistanceAnimationChange = false
 end
elseif(DMDistance > 7 and DMDistance <= 50)then
 if(DMDogDistanceAnimation ~= 4)then
 DMDogDistanceAnimation = 4
 DMDogDistanceAnimationChange = true
 elseif(DMDogDistanceAnimation == 4)then
 DMDogDistanceAnimationChange = false
 end
end

if(DMDistance > 50 )then
 DMDogRescueTeleport = true
else
 DMDogRescueTeleport = false
end

DMAttackCount = DMAttackCount + 1
if(DMAttackCount == 50)then
DMAttackCount = 0
end

triggerServerEvent("DMDogActionGuard", getRootElement(), DMDogFinalRotation, DMDogDistanceAnimation, DMDogDistanceAnimationChange, DMClientDog, DMDogRescueTeleport, DMAttackCount, DMGuardPlayerFound, DMClientDogStrength)
end

function DMDogGuard()
if(DMDogSpawned == true)then
DMDogGuardActive = 1
local DMStopDog = false
DMExit(DMStopDog)
DMExitStatus()
--POS SYNC
triggerServerEvent("DMDogActionIdle", getRootElement(), DMClientDog)
DogGuardingx, DogGuardingy, DogGuardingz = getElementPosition(DMClientDog)
DMDogIdleBlip = createBlip ( DogGuardingx, DogGuardingy, DogGuardingz , 0, 2, 255, 0, 0, 255, 0, 250)
DMOldDogStatus = DMDogStatus
DMDogStatus = 6
DMGuardFollowActive = false
addEventHandler("onClientRender", getRootElement(), DMStatusGui)
DMGuardCollision = createColCircle ( DogGuardingx, DogGuardingy, 8 )
local DMGuardAttack = false

DMDogGuardingTimer = setTimer(function()

local players = getElementsWithinColShape ( DMGuardCollision, "player" )
DMAlreadyFound = false
local theKey, thePlayer
for theKey,thePlayer in ipairs(players) do
    if(DMAlreadyFound == false)then
    if(isPedInVehicle(thePlayer) == false)then
	if(thePlayer ~= getLocalPlayer())then
    DMGuardPlayerFound = thePlayer
	DMAlreadyFound = true
	end
	end
	end
end

if(DMAlreadyFound == true)then
if(DMGuardAttack == false)then
DMAttackCount = 0
addEventHandler("onClientRender", getRootElement(), DMDogActionGuard)
DMDogGuardActive = 2
DMGuardAttack = true
DMGuardSound()
end
else
if(DMGuardAttack == true)then
DMDogGuardActive = 1
removeEventHandler("onClientRender", getRootElement(), DMDogActionGuard )
DMGuardAttack = false
end
local Dogx, Dogy, Dogz = getElementPosition(DMClientDog)
local DMDistance = getDistanceBetweenPoints2D ( DogGuardingx, DogGuardingy, Dogx, Dogy)
if(DMDistance <= 1.5)then
local block, anim = getPedAnimation ( DMClientDog )
if(anim ~= "OFF_Sit_Crash")then
triggerServerEvent("DMDogActionIdle", getRootElement(), DMClientDog)
end
if(DMGuardFollowActive == true)then
DMGuardFollowActive = false
DMDogGuardActive = 1
removeEventHandler("onClientRender", getRootElement(), DMDogActionFollow )
end
else
DMDogDistanceAnimation = 0
DMDogFollow = 4
DMGuardFollowActive = true
DMDogGuardActive = 3
addEventHandler("onClientRender", getRootElement(), DMDogActionFollow )
end
end
end, 1000, 0)
end
end

function DMDogGuardExit()
if(DMDogGuardActive == 1)then
killTimer(DMDogGuardingTimer)
destroyElement(DMDogIdleBlip)
destroyElement(DMGuardCollision)
elseif(DMDogGuardActive == 2)then
killTimer(DMDogGuardingTimer)
destroyElement(DMDogIdleBlip)
destroyElement(DMGuardCollision)
removeEventHandler("onClientRender", getRootElement(), DMDogActionGuard )
elseif(DMDogGuardActive == 3)then
killTimer(DMDogGuardingTimer)
destroyElement(DMDogIdleBlip)
destroyElement(DMGuardCollision)
removeEventHandler("onClientRender", getRootElement(), DMDogActionFollow )
end
if(DMDogGuardActive == 1 or DMDogGuardActive == 2 or DMDogGuardActive == 3)then
DMDogGuardActive = 0
if(DMOldDogStatus == 1)then
triggerServerEvent("DMDogActionIdle", getRootElement(), DMClientDog)
local Dogx, Dogy, Dogz = getElementPosition(DMClientDog)
DMDogIdleBlip = createBlip ( Dogx, Dogy, Dogz , 0, 2, 255, 255, 255, 255, 0, 250)
DMDogStatus = 1
DMDogIdleTimer = setTimer(function()
destroyElement(DMDogIdleBlip) 
local Dogx, Dogy, Dogz = getElementPosition(DMClientDog)
DMDogIdleBlip = createBlip ( Dogx, Dogy, Dogz , 0, 2, 255, 255, 255, 255, 0, 250)

local block, anim = getPedAnimation ( DMClientDog )
if(anim ~= "OFF_Sit_Crash")then
triggerServerEvent("DMDogActionIdle", getRootElement(), DMClientDog)
end
end, 5000, 0)
elseif(DMOldDogStatus == 2)then
DMDogStatus = 2
DMDogDistanceAnimation = 0
if(DMClientDogFitness < 100)then
DMDogFitnessTimer = setTimer(function()
 if(DMClientDogFitness < 100)then
   DMClientDogFitness = DMClientDogFitness + 0.02
   DMClientDogFitness = DMRound(DMClientDogFitness, 10)
   triggerServerEvent("DMSaveStatFitness", getRootElement(), DMClientDogFitness)
  else
   DMClientDogFitness = 100
   triggerServerEvent("DMSaveStatFitness", getRootElement(), DMClientDogFitness)
   killTimer(DMDogFitnessTimer)
  end
end, 15000, 0)
end
DMPositionSyncTimer = setTimer(function()
local Dogx, Dogy, Dogz = getElementPosition(DMClientDog)
triggerServerEvent("DMSyncPosition", getRootElement(),DMClientDog, Dogx, Dogy, Dogz)
end, 1000, 0)
DMDogFollow = 1
addEventHandler("onClientRender", getRootElement(), DMDogActionFollow )
elseif(DMOldDogStatus == 3)then
DMDogStatus = 3
DMDogDistanceAnimation = 0
if(DMClientDogFitness < 100)then
DMDogFitnessTimer = setTimer(function()
 if(DMClientDogFitness < 100)then
   DMClientDogFitness = DMClientDogFitness + 0.02
   DMClientDogFitness = DMRound(DMClientDogFitness, 10)
   triggerServerEvent("DMSaveStatFitness", getRootElement(), DMClientDogFitness)
  else
   DMClientDogFitness = 100
   triggerServerEvent("DMSaveStatFitness", getRootElement(), DMClientDogFitness)
   killTimer(DMDogFitnessTimer)
  end
end, 15000, 0)
end
DMPositionSyncTimer = setTimer(function()
local Dogx, Dogy, Dogz = getElementPosition(DMClientDog)
triggerServerEvent("DMSyncPosition", getRootElement(),DMClientDog, Dogx, Dogy, Dogz)
end, 1000, 0)
DMDogFollow = 1
addEventHandler("onClientRender", getRootElement(), DMDogActionFollow )
end
end
end

function DMDogFightGui()
if(DMLanguage == 1)then
dxDrawRectangle(0.78 * DMScreenx, 0.3 * DMScreeny, 0.17 * DMScreenx, 0.22 * DMScreeny, tocolor(20, 20, 20, 220))
dxDrawText("Mobarezeye Sag Ha", 0.785 * DMScreenx, 0.315 * DMScreeny, nil, nil, tocolor(DMClientDogGenderColorR, DMClientDogGenderColorG, DMClientDogGenderColorB, 220), DMTextSizex, DMTextSizey, "default-bold", "left", "center")

dxDrawLine(0.78 *DMScreenx, 0.33 * DMScreeny, 0.95 * DMScreenx, 0.33 * DMScreeny, tocolor(255, 255, 255, 220))
dxDrawLine(0.78 *DMScreenx, 0.39 * DMScreeny, 0.95 * DMScreenx, 0.39 * DMScreeny, tocolor(255, 255, 255, 220))

dxDrawText("Esme Bazikoni Ke Mikhahid Ba Oo Mobarezeye Sag Ha Ra Anjam dahid Vared Konid. In Mobareze Beyne Yek Sag Ba Yek Sage Digar Ast Va Barande Ghodrat Daryaft Mikonad!", 0.785 * DMScreenx, 0.41 * DMScreeny, 0.95 * DMScreenx, 0.47 * DMScreeny, tocolor(255, 255, 255, 220), DMTextSizex, DMTextSizey, "default-bold", "center", "top", false, true)

dxDrawImage(0.9 * DMScreenx, 0.47 * DMScreeny, 80 * DMImagex, 50 * DMImagey, texture5  )
dxDrawText("Ersal", 0.9 * DMScreenx, 0.473 * DMScreeny, DMScreenx * 0.942, DMScreeny * 0.513, tocolor(3, 252, 252, 220), DMTextSizex * 0.7, DMTextSizey * 0.7, "beckett", "center", "center")
elseif(DMLanguage == 2)then
dxDrawRectangle(0.78 * DMScreenx, 0.3 * DMScreeny, 0.17 * DMScreenx, 0.22 * DMScreeny, tocolor(20, 20, 20, 220))
dxDrawText("Hunde Kampf", 0.785 * DMScreenx, 0.315 * DMScreeny, nil, nil, tocolor(DMClientDogGenderColorR, DMClientDogGenderColorG, DMClientDogGenderColorB, 220), DMTextSizex, DMTextSizey, "default-bold", "left", "center")

dxDrawLine(0.78 *DMScreenx, 0.33 * DMScreeny, 0.95 * DMScreenx, 0.33 * DMScreeny, tocolor(255, 255, 255, 220))
dxDrawLine(0.78 *DMScreenx, 0.39 * DMScreeny, 0.95 * DMScreenx, 0.39 * DMScreeny, tocolor(255, 255, 255, 220))

dxDrawText("Gebe den Names des Spielers ein mit dem Sie kämpfen möchten. Hierbei kämpft Hund gegen Hund und der Gewinner wird stärker!", 0.785 * DMScreenx, 0.41 * DMScreeny, 0.95 * DMScreenx, 0.47 * DMScreeny, tocolor(255, 255, 255, 220), DMTextSizex, DMTextSizey, "default-bold", "center", "top", false, true)

dxDrawImage(0.9 * DMScreenx, 0.47 * DMScreeny, 80 * DMImagex, 50 * DMImagey, texture5  )
dxDrawText("Fertig", 0.9 * DMScreenx, 0.473 * DMScreeny, DMScreenx * 0.942, DMScreeny * 0.513, tocolor(0, 0, 0, 220), DMTextSizex * 0.7, DMTextSizey * 0.7, "beckett", "center", "center")
end
end

function DMDogFightInteractives()
DMDogFightEdit = guiCreateEdit ( 0.79 * DMScreenx, 0.335 * DMScreeny, 0.15 * DMScreenx, 0.05 * DMScreeny, "", false)
guiSetAlpha(DMDogFightEdit, 0.8)
guiSetVisible(DMDogFightEdit, false)

DMDogFightButton = guiCreateButton ( 0.9 * DMScreenx, 0.473 * DMScreeny, 0.042 * DMScreenx, 0.04 * DMScreeny, "", false)
guiSetAlpha(DMDogFightButton, 0)
guiSetVisible(DMDogFightButton, false)
addEventHandler ( "onClientGUIClick", DMDogFightButton, DMDogFightStart, false )
end

function DMDogFight()
if(DMDogSpawned == true)then
guiSetVisible(DMDogTasksButton1, false)
guiSetVisible(DMDogTasksButton2, false)
guiSetVisible(DMDogTasksButton3, false)
removeEventHandler("onClientRender", getRootElement(), DMDogTasksGui)
DMDogTasksPanel = false

guiSetVisible(DMDogFightEdit, true)
guiSetVisible(DMDogFightButton, true)
addEventHandler("onClientRender", getRootElement(), DMDogFightGui)
DMDogFightPanel = true
end
end

function DMDogFightStart()
local DMStopDog = false
DMExit(DMStopDog)

if(DMDogSpawned == true)then
addEventHandler("onClientRender", getRootElement(), DMStatusGui)
DMStatusActive = true
end

local DMDogFightPlayer = getPlayerFromName(guiGetText(DMDogFightEdit))
if(DMDogFightPlayer == false)then
if(DMLanguage == 1)then
outputChatBox("Shakhs Peyda Nashod", 255, 0,0)
elseif(DMLanguage == 2)then
outputChatBox("Person konnte nicht gefunden werden", 255, 0,0)
end
else
if(DMDogFightPlayer == getLocalPlayer())then
if(DMLanguage == 1)then
outputChatBox("Shoma Nemitavanid Ba Khodetan Mobareze Konid", 255,0,0)
elseif(DMLanguage == 2)then
outputChatBox("Du kannst nicht mit dir selbst kämpfen", 255,0,0)
end
else
if(isPedInVehicle(DMDogFightPlayer) == true)then
if(DMLanguage == 1)then
outputChatBox(getPlayerName(DMDogFightPlayer).." Dar Hale Ranandegi Ast", 255,0,0)
elseif(DMLanguage == 2)then
outputChatBox(getPlayerName(DMDogFightPlayer).." fährt gerade", 255,0,0)
end
else
local DMx, DMy, DMz = getElementPosition(getLocalPlayer())
local DMOpponentx, DMOpponenty, DMOpponentz = getElementPosition(DMDogFightPlayer)
local DMDistance = getDistanceBetweenPoints2D (DMx , DMy, DMOpponentx, DMOpponenty)

if(DMDistance <= 20)then
triggerServerEvent("DMDogFightRequest", getRootElement(), DMDogFightPlayer, DMClientDog)
DMPlayerInFight = true
DMRequestPlayer = getPlayerName(DMDogFightPlayer)
else
if(DMLanguage == 1)then
outputChatBox(getPlayerName(DMDogFightPlayer).." Kheyli Door Ast", 255,0,0)
elseif(DMLanguage == 2)then
outputChatBox(getPlayerName(DMDogFightPlayer).." ist zu weit entfernt", 255,0,0)
end
end
end
end
end
end

function DMDogFightRequestGui()
if(DMLanguage == 1)then
dxDrawRectangle(0.78 * DMScreenx, 0.3 * DMScreeny, 0.17 * DMScreenx, 0.22 * DMScreeny, tocolor(20, 20, 20, 220))
dxDrawText("Mobarezeye Sag Ha", 0.785 * DMScreenx, 0.315 * DMScreeny, nil, nil, tocolor(DMClientDogGenderColorR, DMClientDogGenderColorG, DMClientDogGenderColorB, 220), DMTextSizex, DMTextSizey, "default-bold", "left", "center")

dxDrawLine(0.78 *DMScreenx, 0.33 * DMScreeny, 0.95 * DMScreenx, 0.33 * DMScreeny, tocolor(255, 255, 255, 220))
dxDrawLine(0.78 *DMScreenx, 0.39 * DMScreeny, 0.95 * DMScreenx, 0.39 * DMScreeny, tocolor(255, 255, 255, 220))
dxDrawText(DMRequestPlayer, 0.79 * DMScreenx, 0.335 * DMScreeny, 0.941 * DMScreenx, 0.385 * DMScreeny, tocolor(255, 255, 255, 220), DMTextSizex * 1.1, DMTextSizey * 1.1 , "pricedown", "center", "center")

dxDrawText("Mikhahad Ba Shoma Mobareze Konad!", 0.785 * DMScreenx, 0.42 * DMScreeny, 0.95 * DMScreenx, 0.42 * DMScreeny, tocolor(255, 255, 255, 220), DMTextSizex* 1.2, DMTextSizey* 1.2, "default-bold", "center", "center")

dxDrawImage(0.8 * DMScreenx, 0.463 * DMScreeny, 80 * DMImagex, 50 * DMImagey, texture5  )
dxDrawImage(0.89 * DMScreenx, 0.463 * DMScreeny, 80 * DMImagex, 50 * DMImagey, texture5  )
dxDrawText("Ghabool Kardan", 0.8 * DMScreenx, 0.463 * DMScreeny, DMScreenx * 0.842, DMScreeny * 0.513, tocolor(3, 252, 252, 220), DMTextSizex * 0.7, DMTextSizey * 0.7, "beckett", "center", "center")
dxDrawText("Rad Kardan", 0.89 * DMScreenx, 0.463 * DMScreeny, DMScreenx * 0.932, DMScreeny * 0.513, tocolor(3, 252, 252, 220), DMTextSizex * 0.7, DMTextSizey * 0.7, "beckett", "center", "center")
elseif(DMLanguage == 2)then
dxDrawRectangle(0.78 * DMScreenx, 0.3 * DMScreeny, 0.17 * DMScreenx, 0.22 * DMScreeny, tocolor(20, 20, 20, 220))
dxDrawText("Hunde Kampf", 0.785 * DMScreenx, 0.315 * DMScreeny, nil, nil, tocolor(DMClientDogGenderColorR, DMClientDogGenderColorG, DMClientDogGenderColorB, 220), DMTextSizex, DMTextSizey, "default-bold", "left", "center")

dxDrawLine(0.78 *DMScreenx, 0.33 * DMScreeny, 0.95 * DMScreenx, 0.33 * DMScreeny, tocolor(255, 255, 255, 220))
dxDrawLine(0.78 *DMScreenx, 0.39 * DMScreeny, 0.95 * DMScreenx, 0.39 * DMScreeny, tocolor(255, 255, 255, 220))
dxDrawText(DMRequestPlayer, 0.79 * DMScreenx, 0.335 * DMScreeny, 0.941 * DMScreenx, 0.385 * DMScreeny, tocolor(255, 255, 255, 220), DMTextSizex * 1.1, DMTextSizey * 1.1 , "pricedown", "center", "center")

dxDrawText("fordert dich zu Kampf heraus!", 0.785 * DMScreenx, 0.42 * DMScreeny, 0.95 * DMScreenx, 0.42 * DMScreeny, tocolor(255, 255, 255, 220), DMTextSizex* 1.2, DMTextSizey* 1.2, "default-bold", "center", "center")

dxDrawImage(0.8 * DMScreenx, 0.463 * DMScreeny, 80 * DMImagex, 50 * DMImagey, texture5  )
dxDrawImage(0.89 * DMScreenx, 0.463 * DMScreeny, 80 * DMImagex, 50 * DMImagey, texture5  )
dxDrawText("Akzeptieren", 0.8 * DMScreenx, 0.463 * DMScreeny, DMScreenx * 0.842, DMScreeny * 0.513, tocolor(3, 252, 252, 220), DMTextSizex * 0.7, DMTextSizey * 0.7, "beckett", "center", "center")
dxDrawText("Ablehnen", 0.89 * DMScreenx, 0.463 * DMScreeny, DMScreenx * 0.932, DMScreeny * 0.513, tocolor(3, 252, 252, 220), DMTextSizex * 0.7, DMTextSizey * 0.7, "beckett", "center", "center")
end
end

function DMDogFightRequestInteractives()
DMDogFightRequestButton1 = guiCreateButton ( 0.8 * DMScreenx, 0.463 * DMScreeny, 0.042 * DMScreenx, 0.04 * DMScreeny, "", false)
guiSetAlpha(DMDogFightRequestButton1, 0)
guiSetVisible(DMDogFightRequestButton1, false)
addEventHandler ( "onClientGUIClick", DMDogFightRequestButton1, DMDogsFightStart, false )

DMDogFightRequestButton2 = guiCreateButton ( 0.89 * DMScreenx, 0.463 * DMScreeny, 0.042 * DMScreenx, 0.04 * DMScreeny, "", false)
guiSetAlpha(DMDogFightRequestButton2, 0)
guiSetVisible(DMDogFightRequestButton2, false)
addEventHandler ( "onClientGUIClick", DMDogFightRequestButton2, DMDogFightRequestDecilned, false )
end

function DMDogFightRequestBack(RequestPlayer, DMRequestDog)
if(DMPlayerInFight == false)then
if(DMClientOwnerGotDog == true and DMDogDeathRevive == true)then
local DMStopDog = false
DMExit(DMStopDog)
triggerServerEvent("DMDogFightRequestSent", getRootElement(), RequestPlayer)
DMRequestPlayer = getPlayerName(RequestPlayer)
DMClientRequestDog = DMRequestDog
showCursor(true)
guiSetInputEnabled(true)
addEventHandler("onClientRender", getRootElement(), DMDogFightRequestGui)
guiSetVisible(DMDogFightRequestButton1, true)
guiSetVisible(DMDogFightRequestButton2, true)
DMDogFightRequestPanel = true
DMPlayerInFight = true
DMRequestClose = true
else
local DMRequestError = 1
triggerServerEvent("DMDogFightRequestFailed", getRootElement(), RequestPlayer, DMRequestError)
end
else
local DMRequestError = 2
triggerServerEvent("DMDogFightRequestFailed", getRootElement(), RequestPlayer, DMRequestError)
end
end

function DMDogFightRequestFailed(DMOpponent, DMRequestError)
if(DMRequestError == 1)then
if(DMLanguage == 1)then
outputChatBox(getPlayerName(DMOpponent).." Sag Nadarad", 255,0,0)
elseif(DMLanguage == 2)then
outputChatBox(getPlayerName(DMOpponent).." hat keinen Hund", 255,0,0)
end
elseif(DMRequestError == 2)then
if(DMLanguage == 1)then
outputChatBox(getPlayerName(DMOpponent).." Darhale Mobareze Ast", 255,0,0)
elseif(DMLanguage == 2)then
outputChatBox(getPlayerName(DMOpponent).." befindet sich bereits in einem Kampf", 255,0,0)
end
end
DMPlayerInFight = false
end

function DMDogFightRequestSent()
if(DMLanguage == 1)then
outputChatBox("Darkhaste Mobarezeye Sag Ha Ersal Karde Ast", 255 , 255,0)
elseif(DMLanguage == 2)then
outputChatBox("Hundekampf Anfrage gesendet", 255 , 255,0)
end
end

function DMDogsFightStart()
if(DMLanguage == 1)then
outputChatBox("Mobarezeye Sag Ha Aghaz Shod", 255, 255,0)
elseif(DMLanguage == 2)then
outputChatBox("Hundekampf startet", 255, 255,0)
end

showCursor(false)
guiSetInputEnabled(false)
removeEventHandler("onClientRender", getRootElement(), DMDogFightRequestGui)
guiSetVisible(DMDogFightRequestButton1, false)
guiSetVisible(DMDogFightRequestButton2, false)
DMDogFightRequestPanel = false

if(DMDogSpawned == false)then
DMOnlySpawn = true
DMSpawnDog()
elseif(DMDogSpawned == true)then
local DMStopDog = false
DMExit(DMStopDog)
DMExitStatus()
addEventHandler("onClientRender", getRootElement(), DMStatusGui)
DMStatusActive = true
unbindKey(ChangeStatusKey, "down", DMChangeDogStatus)
end

DMDogStatus = 7
if(DMClientDogFitness < 100)then
DMDogFitnessTimer = setTimer(function()
 if(DMClientDogFitness < 100)then
   DMClientDogFitness = DMClientDogFitness + 0.02
   DMClientDogFitness = DMRound(DMClientDogFitness, 10)
   triggerServerEvent("DMSaveStatFitness", getRootElement(), DMClientDogFitness)
  else
   DMClientDogFitness = 100
   triggerServerEvent("DMSaveStatFitness", getRootElement(), DMClientDogFitness)
   killTimer(DMDogFitnessTimer)
  end
end, 15000, 0)
end
DMPositionSyncTimer = setTimer(function()
local Dogx, Dogy, Dogz = getElementPosition(DMClientDog)
triggerServerEvent("DMSyncPosition", getRootElement(),DMClientDog, Dogx, Dogy, Dogz)
end, 1000, 0)

local RequestPlayer = getPlayerFromName(DMRequestPlayer)
DMAttackCount = 0
DMDogAttack = 2

setTimer(function()
addEventHandler("onClientRender", getRootElement(), DMDogActionAttack )
DMDogAttacking = true
DMFightSound1 = playSound(":DogMod/sounds/barklong.mp3", true)
setTimer(function() DMFightSound2 = playSound(":DogMod/sounds/barklong.mp3", true) end, 1200,1)
triggerServerEvent("DMDogsFightStart", getRootElement(), RequestPlayer, DMClientDog)
end, 500, 1)
end

function DMDogsFightStartBack(DMRequestDog)
if(DMLanguage == 1)then
outputChatBox("Mobarezeye Sag Ha Aghaz Shod", 255, 255,0)
elseif(DMLanguage == 2)then
outputChatBox("Hundekampf startet", 255, 255,0)
end

local DMStopDog = false
DMExit(DMStopDog)
DMExitStatus()
unbindKey(ChangeStatusKey, "down", DMChangeDogStatus)
addEventHandler("onClientRender", getRootElement(), DMStatusGui)

DMDogStatus = 7
if(DMClientDogFitness < 100)then
DMDogFitnessTimer = setTimer(function()
 if(DMClientDogFitness < 100)then
   DMClientDogFitness = DMClientDogFitness + 0.02
   DMClientDogFitness = DMRound(DMClientDogFitness, 10)
   triggerServerEvent("DMSaveStatFitness", getRootElement(), DMClientDogFitness)
  else
   DMClientDogFitness = 100
   triggerServerEvent("DMSaveStatFitness", getRootElement(), DMClientDogFitness)
   killTimer(DMDogFitnessTimer)
  end
end, 15000, 0)
end
DMPositionSyncTimer = setTimer(function()
local Dogx, Dogy, Dogz = getElementPosition(DMClientDog)
triggerServerEvent("DMSyncPosition", getRootElement(),DMClientDog, Dogx, Dogy, Dogz)
end, 1000, 0)

DMClientRequestDog = DMRequestDog
DMAttackCount = 0
DMDogAttack = 2
DMFightSound1 = playSound(":DogMod/sounds/barklong.mp3", true)
setTimer(function() DMFightSound2 = playSound(":DogMod/sounds/barklong.mp3", true) end, 1200,1)
addEventHandler("onClientRender", getRootElement(), DMDogActionAttack )
DMDogAttacking = true
end

function DMDogFightRequestDecilned()
DMPlayerInFight = false
showCursor(false)
guiSetInputEnabled(false)
removeEventHandler("onClientRender", getRootElement(), DMDogFightRequestGui)
guiSetVisible(DMDogFightRequestButton1, false)
guiSetVisible(DMDogFightRequestButton2, false)
DMDogFightRequestPanel = false

local RequestPlayer = getPlayerFromName(DMRequestPlayer)
triggerServerEvent("DMDogFightRequestDecilned", getRootElement(), RequestPlayer)
if(DMDogSpawned == true)then
addEventHandler("onClientRender", getRootElement(), DMStatusGui)
DMStatusActive = true
end
end

function DMDogFightRequestDecilnedBack()
if(DMLanguage == 1)then
outputChatBox("Darkhaste Shoma Rad Shod", 255, 0,0)
elseif(DMLanguage == 2)then
outputChatBox("Deine Anfrage wurde abgelehnt", 255, 0,0)
end
DMPlayerInFight = false
end

function DMDogFightLose()
DMPlayerInFight = false
DMDogRevive()
if(DMLanguage == 1)then
outputChatBox("Sage Shoma Mobareze Ra Bakht!",255,255,0)
elseif(DMLanguage == 2)then
outputChatBox("Dein Hund hat den Kampf verloren!",255,255,0)
end
end

function DMDogFightWin() 
DMPlayerInFight = false
if(DMLanguage == 1)then
outputChatBox("Sage Shoma Mobareze Ra Bord!",0,255,0)
elseif(DMLanguage == 2)then
outputChatBox("Dein Hund hat den Kampf gewonnen!",0,255,0)
end
DMExitStatus()
DMClientDogStrength = DMClientDogStrength + 2
triggerServerEvent("DMSaveStatStrength", getRootElement(), DMClientDogStrength)

triggerServerEvent("DMDogActionIdle", getRootElement(), DMClientDog)
local Dogx, Dogy, Dogz = getElementPosition(DMClientDog)
DMDogIdleBlip = createBlip ( Dogx, Dogy, Dogz , 0, 2, 255, 255, 255, 255, 0, 250)
DMDogStatus = 1
DMDogIdleTimer = setTimer(function()
destroyElement(DMDogIdleBlip) 
local Dogx, Dogy, Dogz = getElementPosition(DMClientDog)
DMDogIdleBlip = createBlip ( Dogx, Dogy, Dogz , 0, 2, 255, 255, 255, 255, 0, 250)

local block, anim = getPedAnimation ( DMClientDog )
if(anim ~= "OFF_Sit_Crash")then
triggerServerEvent("DMDogActionIdle", getRootElement(), DMClientDog)
end
end, 5000, 0)

addEventHandler("onClientRender", getRootElement(), DMStatusGui)
bindKey(DoTrickKey,"down", DMDoTrick)
end

function DMDogsFightGiveUpBack(RequestPlayer)
DMPlayerInFight = false
if(DMLanguage == 1)then
outputChatBox(getPlayerName(RequestPlayer).." Az Mobareze Enseraf Dad!", 0, 255,0)
elseif(DMLanguage == 2)then
outputChatBox(getPlayerName(RequestPlayer).." hat den Kampf aufgegeben", 0, 255,0)
end

DMExitStatus()
DMClientDogStrength = DMClientDogStrength + 2
triggerServerEvent("DMSaveStatStrength", getRootElement(), DMClientDogStrength)

triggerServerEvent("DMDogActionIdle", getRootElement(), DMClientDog)
local Dogx, Dogy, Dogz = getElementPosition(DMClientDog)
DMDogIdleBlip = createBlip ( Dogx, Dogy, Dogz , 0, 2, 255, 255, 255, 255, 0, 250)
DMDogStatus = 1
DMDogIdleTimer = setTimer(function()
destroyElement(DMDogIdleBlip) 
local Dogx, Dogy, Dogz = getElementPosition(DMClientDog)
DMDogIdleBlip = createBlip ( Dogx, Dogy, Dogz , 0, 2, 255, 255, 255, 255, 0, 250)

local block, anim = getPedAnimation ( DMClientDog )
if(anim ~= "OFF_Sit_Crash")then
triggerServerEvent("DMDogActionIdle", getRootElement(), DMClientDog)
end
end, 5000, 0)
end

function DMDogSniff()
if(DMDogSpawned == true)then
guiSetVisible(DMDogTasksButton1, false)
guiSetVisible(DMDogTasksButton2, false)
guiSetVisible(DMDogTasksButton3, false)
removeEventHandler("onClientRender", getRootElement(), DMDogTasksGui)
DMDogTasksPanel = false

guiSetVisible(DMDogSniffEdit, true)
guiSetVisible(DMDogSniffButton, true)
addEventHandler("onClientRender", getRootElement(), DMDogSniffGui)
DMDogSniffPanel = true
end
end

function DMDogSniffGui()
if(DMLanguage == 1)then
dxDrawRectangle(0.78 * DMScreenx, 0.3 * DMScreeny, 0.17 * DMScreenx, 0.22 * DMScreeny, tocolor(20, 20, 20, 220))
dxDrawText("Boo Keshidane Shakhs", 0.785 * DMScreenx, 0.315 * DMScreeny, nil, nil, tocolor(DMClientDogGenderColorR, DMClientDogGenderColorG, DMClientDogGenderColorB, 220), DMTextSizex, DMTextSizey, "default-bold", "left", "center")

dxDrawLine(0.78 *DMScreenx, 0.33 * DMScreeny, 0.95 * DMScreenx, 0.33 * DMScreeny, tocolor(255, 255, 255, 220))
dxDrawLine(0.78 *DMScreenx, 0.39 * DMScreeny, 0.95 * DMScreenx, 0.39 * DMScreeny, tocolor(255, 255, 255, 220))

dxDrawText("Esme Bazikoni Ke Sage Shoma Bayad Peyda Konad Ra Vared Konid. Shakhse Morede Nazar Rooye Naghshe Alamatgozari Mishavad.", 0.785 * DMScreenx, 0.41 * DMScreeny, 0.94 * DMScreenx, 0.47 * DMScreeny, tocolor(255, 255, 255, 220), DMTextSizex, DMTextSizey, "default-bold", "center", "top", false, true)

dxDrawImage(0.9 * DMScreenx, 0.47 * DMScreeny, 80 * DMImagex, 50 * DMImagey, texture5  )
dxDrawText("Anjam", 0.9 * DMScreenx, 0.473 * DMScreeny, DMScreenx * 0.942, DMScreeny * 0.513, tocolor(3, 252, 252, 220), DMTextSizex * 0.7, DMTextSizey * 0.7, "beckett", "center", "center")
elseif(DMLanguage == 2)then
dxDrawRectangle(0.78 * DMScreenx, 0.3 * DMScreeny, 0.17 * DMScreenx, 0.22 * DMScreeny, tocolor(20, 20, 20, 220))
dxDrawText("Person erschnüffeln", 0.785 * DMScreenx, 0.315 * DMScreeny, nil, nil, tocolor(DMClientDogGenderColorR, DMClientDogGenderColorG, DMClientDogGenderColorB, 220), DMTextSizex, DMTextSizey, "default-bold", "left", "center")

dxDrawLine(0.78 *DMScreenx, 0.33 * DMScreeny, 0.95 * DMScreenx, 0.33 * DMScreeny, tocolor(255, 255, 255, 220))
dxDrawLine(0.78 *DMScreenx, 0.39 * DMScreeny, 0.95 * DMScreenx, 0.39 * DMScreeny, tocolor(255, 255, 255, 220))

dxDrawText("Gebe den Namen des Spielers ein den du findest möchtest. Er wird auf der Map markiert", 0.785 * DMScreenx, 0.41 * DMScreeny, 0.94 * DMScreenx, 0.47 * DMScreeny, tocolor(255, 255, 255, 220), DMTextSizex, DMTextSizey, "default-bold", "center", "top", false, true)

dxDrawImage(0.9 * DMScreenx, 0.47 * DMScreeny, 80 * DMImagex, 50 * DMImagey, texture5  )
dxDrawText("Fertig", 0.9 * DMScreenx, 0.473 * DMScreeny, DMScreenx * 0.942, DMScreeny * 0.513, tocolor(0, 0, 0, 220), DMTextSizex * 0.7, DMTextSizey * 0.7, "beckett", "center", "center")
end
end

function DMDogSniffInteractives()
DMDogSniffEdit = guiCreateEdit ( 0.79 * DMScreenx, 0.335 * DMScreeny, 0.15 * DMScreenx, 0.05 * DMScreeny, "", false)
guiSetAlpha(DMDogSniffEdit, 0.8)
guiSetVisible(DMDogSniffEdit, false)

DMDogSniffButton = guiCreateButton ( 0.9 * DMScreenx, 0.473 * DMScreeny, 0.042 * DMScreenx, 0.04 * DMScreeny, "", false)
guiSetAlpha(DMDogSniffButton, 0)
guiSetVisible(DMDogSniffButton, false)
addEventHandler ( "onClientGUIClick", DMDogSniffButton, DMDogActionSniff, false )
end

function DMDogActionSniff()
local DMStopDog = false
DMExit(DMStopDog)

if(DMDogSpawned == true)then
addEventHandler("onClientRender", getRootElement(), DMStatusGui)
DMStatusActive = true
end

local DMDogFightPlayer = getPlayerFromName(guiGetText(DMDogSniffEdit))
if(DMDogFightPlayer == false)then
if(DMLanguage == 1)then
outputChatBox("Sage Shoma Hich Booyi Esteshmam Nemikonad", 255, 0,0)
elseif(DMLanguage == 2)then
outputChatBox("Dein Hund riecht nichts", 255, 0,0)
end
else
local DMPlayerx, DMPlayery, DMPlayerz = getElementPosition(DMDogFightPlayer)
DMDogSniffBlip = createBlip ( DMPlayerx, DMPlayery, DMPlayerz , 58, 2, 255, 0, 0, 255, 0, 9999)
if(DMLanguage == 1)then
outputChatBox(getPlayerName(DMDogFightPlayer).." Peyda Shod!", 0,255,0)
elseif(DMLanguage == 2)then
outputChatBox(getPlayerName(DMDogFightPlayer).." wurde gefunden!", 0,255,0)
end
setTimer(function()
destroyElement(DMDogSniffBlip)
end, 10000, 1)
end
end

function DMDogTasksGui()
if(DMLanguage == 1)then
dxDrawRectangle(0.78 * DMScreenx, 0.3 * DMScreeny, 0.17 * DMScreenx, 0.37 * DMScreeny, tocolor(20, 20, 20, 220))
dxDrawText("Kaarhaye Sag", 0.785 * DMScreenx, 0.315 * DMScreeny, nil, nil, tocolor(DMClientDogGenderColorR, DMClientDogGenderColorG, DMClientDogGenderColorB, 220), DMTextSizex, DMTextSizey, "default-bold", "left", "center")

dxDrawLine(0.78 * DMScreenx, 0.33 * DMScreeny, 0.95 * DMScreenx, 0.33 * DMScreeny, tocolor(255, 255, 255, 220))
dxDrawLine(0.78 * DMScreenx, 0.3785 * DMScreeny, 0.95 * DMScreenx, 0.3785 * DMScreeny, tocolor(255, 255, 255, 220))
dxDrawLine(0.78 * DMScreenx, 0.427 * DMScreeny, 0.95 * DMScreenx, 0.427 * DMScreeny, tocolor(255, 255, 255, 220))
dxDrawLine(0.78 * DMScreenx, 0.4755 * DMScreeny, 0.95 * DMScreenx,  0.4755 * DMScreeny, tocolor(255, 255, 255, 220))

dxDrawText("Negahbani", 0.785 * DMScreenx, 0.33 * DMScreeny, 0.945 * DMScreenx, 0.3785 * DMScreeny, tocolor(255, 255, 255, 220), DMTextSizex, DMTextSizey, "pricedown", "center", "center")
dxDrawText("Mobareze", 0.785 * DMScreenx, 0.3785 * DMScreeny, 0.945 * DMScreenx, 0.427 * DMScreeny, tocolor(255, 255, 255, 220), DMTextSizex, DMTextSizey, "pricedown", "center", "center")
dxDrawText("Boo Keshidan", 0.785 * DMScreenx, 0.427 * DMScreeny, 0.945 * DMScreenx, 0.4755 * DMScreeny, tocolor(255, 255, 255, 220), DMTextSizex, DMTextSizey, "pricedown", "center", "center")
elseif(DMLanguage == 2)then
dxDrawRectangle(0.78 * DMScreenx, 0.3 * DMScreeny, 0.17 * DMScreenx, 0.37 * DMScreeny, tocolor(20, 20, 20, 220))
dxDrawText("Hunde Aufgaben", 0.785 * DMScreenx, 0.315 * DMScreeny, nil, nil, tocolor(DMClientDogGenderColorR, DMClientDogGenderColorG, DMClientDogGenderColorB, 220), DMTextSizex, DMTextSizey, "default-bold", "left", "center")

dxDrawLine(0.78 * DMScreenx, 0.33 * DMScreeny, 0.95 * DMScreenx, 0.33 * DMScreeny, tocolor(255, 255, 255, 220))
dxDrawLine(0.78 * DMScreenx, 0.3785 * DMScreeny, 0.95 * DMScreenx, 0.3785 * DMScreeny, tocolor(255, 255, 255, 220))
dxDrawLine(0.78 * DMScreenx, 0.427 * DMScreeny, 0.95 * DMScreenx, 0.427 * DMScreeny, tocolor(255, 255, 255, 220))
dxDrawLine(0.78 * DMScreenx, 0.4755 * DMScreeny, 0.95 * DMScreenx,  0.4755 * DMScreeny, tocolor(255, 255, 255, 220))

dxDrawText("Position bewachen", 0.785 * DMScreenx, 0.33 * DMScreeny, 0.945 * DMScreenx, 0.3785 * DMScreeny, tocolor(255, 255, 255, 220), DMTextSizex, DMTextSizey, "pricedown", "center", "center")
dxDrawText("Hunde Kampf", 0.785 * DMScreenx, 0.3785 * DMScreeny, 0.945 * DMScreenx, 0.427 * DMScreeny, tocolor(255, 255, 255, 220), DMTextSizex, DMTextSizey, "pricedown", "center", "center")
dxDrawText("Spieler erschnüffeln", 0.785 * DMScreenx, 0.427 * DMScreeny, 0.945 * DMScreenx, 0.4755 * DMScreeny, tocolor(255, 255, 255, 220), DMTextSizex, DMTextSizey, "pricedown", "center", "center")
end
end

function DMDogTasks()
if(DMDogSpawned == true and DMPlayerInFight == false)then
removeEventHandler("onClientRender", getRootElement(), DMDogPanelGui)
DMDogPanel = false 

guiSetVisible(DMDogPanelButton1, false)
guiSetVisible(DMDogPanelButton2, false)
guiSetVisible(DMDogPanelButton3, false)
guiSetVisible(DMDogPanelButton4, false)
guiSetVisible(DMDogPanelButton5, false)
guiSetVisible(DMDogPanelButton6, false)
guiSetVisible(DMDogPanelButton7, false)

guiSetVisible(DMDogTasksButton1, true)
guiSetVisible(DMDogTasksButton2, true)
guiSetVisible(DMDogTasksButton3, true)
addEventHandler("onClientRender", getRootElement(), DMDogTasksGui)
DMDogTasksPanel = true
end
end

function DMDogTasksInteractives()
DMDogTasksButton1 = guiCreateButton ( 0.78 * DMScreenx, 0.33 * DMScreeny, 0.17 * DMScreenx, 0.0485 * DMScreeny, "", false)
DMDogTasksButton2 = guiCreateButton ( 0.78 * DMScreenx, 0.3785 * DMScreeny, 0.17 * DMScreenx, 0.0485 * DMScreeny, "", false)
DMDogTasksButton3 = guiCreateButton ( 0.78 * DMScreenx, 0.427 * DMScreeny, 0.17 * DMScreenx, 0.0485 * DMScreeny, "", false)

guiSetAlpha(DMDogTasksButton1, 0)
guiSetAlpha(DMDogTasksButton2, 0)
guiSetAlpha(DMDogTasksButton3, 0)

guiSetVisible(DMDogTasksButton1, false)
guiSetVisible(DMDogTasksButton2, false)
guiSetVisible(DMDogTasksButton3, false)

addEventHandler ( "onClientGUIClick", DMDogTasksButton1, DMDogGuard, false )
addEventHandler ( "onClientGUIClick", DMDogTasksButton2, DMDogFight, false )
addEventHandler ( "onClientGUIClick", DMDogTasksButton3, DMDogSniff, false )
end

--SOUNDS
function DMAttackSound()
DMAttackSound1 = playSound(":DogMod/sounds/barklong.mp3", true)
triggerServerEvent("DMAttackSound", getRootElement(), DMAttacker, DMClientDog)

DMAttackSound1Timer = setTimer(function()
if(DMDogStatus == 3 and DMDogAttacking == true)then
local DMx, DMy, DMz = getElementPosition(getLocalPlayer())
local DMClientDogx, DMClientDogy, DMClientDogz = getElementPosition(DMClientDog)
local DMDistance = getDistanceBetweenPoints2D (DMx , DMy, DMClientDogx, DMClientDogy)
local DMVolume = 1 - DMDistance/50
if(DMVolume <= 0)then
DMVolume = 0
end
setSoundVolume(DMAttackSound1, DMVolume)
else
killTimer(DMAttackSound1Timer)
stopSound(DMAttackSound1)
local DMSound = playSound(":DogMod/sounds/growl.mp3", false)
setSoundVolume(DMSound, 0.3)
triggerServerEvent("DMAttackSoundStop", getRootElement(), DMAttacker)
end
end, 500, 0)
end

function DMAttackSoundBack(DMTriggerDog)
DMAttackSound2 = playSound(":DogMod/sounds/barklong.mp3", true)
DMAttackSound2Object = DMTriggerDog

DMAttackSound2Timer = setTimer(function()
local DMx, DMy, DMz = getElementPosition(getLocalPlayer())
local DMClientDogx, DMClientDogy, DMClientDogz = getElementPosition(DMAttackSound2Object)
local DMDistance = getDistanceBetweenPoints2D (DMx , DMy, DMClientDogx, DMClientDogy)
local DMVolume = 1 - DMDistance/50
if(DMVolume <= 0)then
DMVolume = 0
end
setSoundVolume(DMAttackSound2, DMVolume)
end, 500, 0)
end

function DMAttackSoundStopBack()
killTimer(DMAttackSound2Timer)
stopSound(DMAttackSound2)
end

function DMGuardSound()
DMGuardSound1 = playSound(":DogMod/sounds/barklong.mp3", true)
triggerServerEvent("DMGuardSound", getRootElement(), DMGuardPlayerFound, DMClientDog)

DMGuardSound1Timer = setTimer(function()
if(DMDogGuardActive ==  2)then
local DMx, DMy, DMz = getElementPosition(getLocalPlayer())
local DMClientDogx, DMClientDogy, DMClientDogz = getElementPosition(DMClientDog)
local DMDistance = getDistanceBetweenPoints2D (DMx , DMy, DMClientDogx, DMClientDogy)
local DMVolume = 1 - DMDistance/50
if(DMVolume <= 0)then
DMVolume = 0
end
setSoundVolume(DMGuardSound1, DMVolume)
else
killTimer(DMGuardSound1Timer)
stopSound(DMGuardSound1)
local DMSound = playSound(":DogMod/sounds/growl.mp3", false)
setSoundVolume(DMSound, 0.3)
triggerServerEvent("DMGuardSoundStop", getRootElement(), DMGuardPlayerFound)
end
end, 500, 0)
end

function DMGuardSoundBack(DMTriggerDog)
DMGuardSound2 = playSound(":DogMod/sounds/barklong.mp3", true)
DMGuardSound2Object = DMTriggerDog

DMGuardSound2Timer = setTimer(function()
local DMx, DMy, DMz = getElementPosition(getLocalPlayer())
local DMClientDogx, DMClientDogy, DMClientDogz = getElementPosition(DMGuardSound2Object)
local DMDistance = getDistanceBetweenPoints2D (DMx , DMy, DMClientDogx, DMClientDogy)
local DMVolume = 1 - DMDistance/50
if(DMVolume <= 0)then
DMVolume = 0
end
setSoundVolume(DMGuardSound2, DMVolume)
end, 500, 0)
end

function DMGuardSoundStopBack()
killTimer(DMGuardSound2Timer)
stopSound(DMGuardSound2)
end

--EXITS
function DMDeleteDog()
if(DMBallThrowActive == 0)then
if(DMFeedActive == 0)then
if(DMClientOwnerGotDog == true)then
if(DMDogSpawned == false)then
if(DMDogPanel == true)then
removeEventHandler("onClientRender", getRootElement(), DMDogPanelGui)
DMDogPanel = false 

guiSetVisible(DMDogPanelButton1, false)
guiSetVisible(DMDogPanelButton2, false)
guiSetVisible(DMDogPanelButton3, false)
guiSetVisible(DMDogPanelButton4, false)
guiSetVisible(DMDogPanelButton5, false)
guiSetVisible(DMDogPanelButton6, false)
guiSetVisible(DMDogPanelButton7, false)

showCursor(false)
guiSetInputEnabled(false)
end
triggerServerEvent("DMDeleteDogNoSpawn", getRootElement())
if(killTimer(DMDogDeathTimer))then
end
if(DMDogDeathRevive == false)then
DMDogDeathRevive = true
killTimer(DMDogDeathTimer)
end

elseif(DMDogSpawned == true)then

local DMStopDog = true
DMExit(DMStopDog)

triggerServerEvent("DMDeleteDog", getRootElement(), DMDogSpawned, DMClientDog)
unbindKey(DoTrickKey,"down", DMDoTrick)
unbindKey(ChangeStatusKey,"down", DMChangeDogStatus)
end
triggerServerEvent("DMCheckOwner", getRootElement())
DMDogSpawned = false
if(DMLanguage == 1)then
outputChatBox("Sag Hazf Shod!", 255, 0,0)
elseif(DMLanguage == 2)then
outputChatBox("Hund gelöscht!", 255, 0,0)
end
else
if(DMLanguage == 1)then
outputChatBox("Shoma Sag Nadarid!", 255, 0,0)
elseif(DMLanguage == 2)then
outputChatBox("Du hast keinen Hund!", 255, 0,0)
end
end
else
if(DMLanguage == 1)then
outputChatBox("Sabr Konid Sage Shoma Ghazasho Bokhorad!", 255, 0,0)
elseif(DMLanguage == 2)then
outputChatBox("Warte bis dein Hund gegessen hat!", 255, 0,0)
end
end
else
if(DMLanguage == 1)then
outputChatBox("Sabr Konid Sage Shoma Toop Bazisho Tamaam Konad!", 255, 0,0)
elseif(DMLanguage == 2)then
outputChatBox("Warte bis dein Hund mit dem Ball gespielt hat", 255, 0,0)
end
end
end

function DMPlayerDeath()
if(source == getLocalPlayer())then

local DMStopDog = true
DMExit(DMStopDog)

unbindKey(DoTrickKey,"down", DMDoTrick)
unbindKey(ChangeStatusKey,"down", DMChangeDogStatus)
killTimer(DMDogHungerTimer)
end
end

function DMDogDamage(attacker, weapon, bodypart, loss)
if(source == DMClientDog)then
cancelEvent()
local DMHealth = getElementHealth(DMClientDog)
local DMNewHealth = DMHealth - loss * (1 - DMClientDogFitness / 200)
triggerServerEvent("DMDogWasted", getRootElement(), DMClientDog, DMNewHealth)

if(DMNewHealth <= 0)then
DMDogRevive()
end
end
end

function DMDogRevive()
local DMStopDog = true
DMExit(DMStopDog)
DMDogDeathRevive = false
DMDogDeathTimerCount = 0

DMDogDeathTimer = setTimer(function()
DMDogDeathTimerCount = DMDogDeathTimerCount + 1
if(DMDogDeathTimerCount == 180)then
DMDogDeathRevive = true
killTimer(DMDogDeathTimer)
end
end, 1000, 0)
end

function DMExit(DMStopDog)
if(DMTricksDogPanel == true)then
removeEventHandler("onClientRender", getRootElement(), DMTricksDogGui)
DMTricksDogPanel = false
guiSetVisible(DMTricksDogButton1, false)
guiSetVisible(DMTricksDogButton2, false)
guiSetVisible(DMTricksDogButton3, false)
guiSetVisible(DMTricksDogButton4, false)
guiSetVisible(DMTricksDogButton5, false)
guiSetVisible(DMTricksDogButton6, false)
guiSetVisible(DMTricksDogButton7, false)
showCursor(false)
guiSetInputEnabled(false)
end
if(DMTricksTutorialActive == true)then
killTimer(DMGetCoursorPosTimer)
showCursor(false)
guiSetInputEnabled(false)
removeEventHandler("onClientRender", getRootElement(), DMTricksDogTutorialGui)
DMTricksTutorialActive = false
end
if(DMDogPanel == true)then
removeEventHandler("onClientRender", getRootElement(), DMDogPanelGui)
DMDogPanel = false 
if(DMClientOwnerGotDog == true)then
if(DMDogDeathRevive == true)then
guiSetVisible(DMDogPanelButton1, false)
guiSetVisible(DMDogPanelButton2, false)
guiSetVisible(DMDogPanelButton3, false)
guiSetVisible(DMDogPanelButton4, false)
guiSetVisible(DMDogPanelButton5, false)
guiSetVisible(DMDogPanelButton6, false)
guiSetVisible(DMDogPanelButton7, false)
end
end
showCursor(false)
guiSetInputEnabled(false)
end
if(DMStatusActive == true)then
removeEventHandler("onClientRender", getRootElement(), DMStatusGui)
DMStatusActive = false
end
if(DMHelpActive == true)then
removeEventHandler("onClientRender", getRootElement(), DMHelpGui)
guiSetVisible(DMHelpButton1, false)
DMHelpActive = false
showCursor(false)
guiSetInputEnabled(false)
end
if(DMDogTasksPanel == true)then
removeEventHandler("onClientRender", getRootElement(), DMDogTasksGui)
DMDogTasksPanel = false
guiSetVisible(DMDogTasksButton1, false)
guiSetVisible(DMDogTasksButton2, false)
guiSetVisible(DMDogTasksButton3, false)
showCursor(false)
guiSetInputEnabled(false)
end
if(DMDogFightPanel == true)then
removeEventHandler("onClientRender", getRootElement(), DMDogFightGui)
DMDogFightPanel = false
guiSetVisible(DMDogFightEdit, false)
guiSetVisible(DMDogFightButton, false)
showCursor(false)
guiSetInputEnabled(false)
if(DMDogSpawned == true)then
addEventHandler("onClientRender", getRootElement(), DMStatusGui)
DMStatusActive = true
end
end
if(DMDogFightRequestPanel == true)then
showCursor(false)
guiSetInputEnabled(false)
removeEventHandler("onClientRender", getRootElement(), DMDogFightRequestGui)
guiSetVisible(DMDogFightRequestButton1, false)
guiSetVisible(DMDogFightRequestButton2, false)
DMDogFightRequestPanel = false
local RequestPlayer = getPlayerFromName(DMRequestPlayer)
triggerServerEvent("DMDogFightRequestDecilned", getRootElement(), RequestPlayer)
if(DMDogSpawned == true)then
addEventHandler("onClientRender", getRootElement(), DMStatusGui)
DMStatusActive = true
end
end
if(DMDogSniffPanel == true)then
showCursor(false)
guiSetInputEnabled(false)
removeEventHandler("onClientRender", getRootElement(), DMDogSniffGui)
guiSetVisible(DMDogSniffEdit, false)
guiSetVisible(DMDogSniffButton, false)
DMDogSniffPanel = false
end
if(DMStopDog == true)then
if(DMFeedActive == 1)then
DMFeedDogExit()
DMStopFeedAnimation = true
triggerServerEvent("DMFeedDogFinished", getRootElement(), DMStopFeedAnimation)
DMFeedActive = 0
elseif(DMFeedActive == 2)then
killTimer(DMDogEatTimer)
DMFeedDogExit()
DMStopFeedAnimation = false
triggerServerEvent("DMFeedDogFinished", getRootElement(), DMStopFeedAnimation)
DMFeedActive = 0
end
if(DMBallThrowActive == 1)then
destroyElement(DMBall)
removeEventHandler("onClientPreRender",getRootElement(),DMkeepInHand)
removeEventHandler("onClientKey",getRootElement(),DMthrowBall)
removeEventHandler("onClientPlayerWeaponSwitch", getRootElement(),DMballWeaponSwitch)
DMInventoryBallExit()
elseif(DMBallThrowActive == 2)then
killTimer(DMInventoryGetBallTimer)
removeEventHandler("onClientRender",getRootElement(),DMDogActionFollow)
destroyElement(DMBall)
removeEventHandler("onClientRender",getRootElement(),DMthrowedBall)
DMInventoryBallExit()
elseif(DMBallThrowActive == 3)then
killTimer(DMGotBallTimer)
removeEventHandler("onClientRender",getRootElement(),DMDogActionFollow)
DMInventoryBallExit()
end
if(DMDogGuardActive == 1)then
killTimer(DMDogGuardingTimer)
destroyElement(DMDogIdleBlip)
destroyElement(DMGuardCollision)
elseif(DMDogGuardActive == 2)then
killTimer(DMDogGuardingTimer)
destroyElement(DMDogIdleBlip)
destroyElement(DMGuardCollision)
removeEventHandler("onClientRender", getRootElement(), DMDogActionGuard )
elseif(DMDogGuardActive == 3)then
killTimer(DMDogGuardingTimer)
destroyElement(DMDogIdleBlip)
destroyElement(DMGuardCollision)
removeEventHandler("onClientRender", getRootElement(), DMDogActionFollow )
end
if(DMDogGuardActive == 1 or DMDogGuardActive == 2 or DMDogGuardActive == 3)then
DMDogGuardActive = 0
if(DMOldDogStatus == 1)then
triggerServerEvent("DMDogActionIdle", getRootElement(), DMClientDog)
local Dogx, Dogy, Dogz = getElementPosition(DMClientDog)
DMDogIdleBlip = createBlip ( Dogx, Dogy, Dogz , 0, 2, 255, 255, 255, 255, 0, 250)
DMDogStatus = 1
DMDogIdleTimer = setTimer(function()
destroyElement(DMDogIdleBlip) 
local Dogx, Dogy, Dogz = getElementPosition(DMClientDog)
DMDogIdleBlip = createBlip ( Dogx, Dogy, Dogz , 0, 2, 255, 255, 255, 255, 0, 250)

local block, anim = getPedAnimation ( DMClientDog )
if(anim ~= "OFF_Sit_Crash")then
triggerServerEvent("DMDogActionIdle", getRootElement(), DMClientDog)
end
end, 5000, 0)
elseif(DMOldDogStatus == 2)then
DMDogStatus = 2
DMDogDistanceAnimation = 0
if(DMClientDogFitness < 100)then
DMDogFitnessTimer = setTimer(function()
 if(DMClientDogFitness < 100)then
   DMClientDogFitness = DMClientDogFitness + 0.02
   DMClientDogFitness = DMRound(DMClientDogFitness, 10)
   triggerServerEvent("DMSaveStatFitness", getRootElement(), DMClientDogFitness)
  else
   DMClientDogFitness = 100
   triggerServerEvent("DMSaveStatFitness", getRootElement(), DMClientDogFitness)
   killTimer(DMDogFitnessTimer)
  end
end, 15000, 0)
end
DMPositionSyncTimer = setTimer(function()
local Dogx, Dogy, Dogz = getElementPosition(DMClientDog)
triggerServerEvent("DMSyncPosition", getRootElement(),DMClientDog, Dogx, Dogy, Dogz)
end, 1000, 0)
DMDogFollow = 1
addEventHandler("onClientRender", getRootElement(), DMDogActionFollow )
elseif(DMOldDogStatus == 3)then
DMDogStatus = 3
DMDogDistanceAnimation = 0
if(DMClientDogFitness < 100)then
DMDogFitnessTimer = setTimer(function()
 if(DMClientDogFitness < 100)then
   DMClientDogFitness = DMClientDogFitness + 0.02
   DMClientDogFitness = DMRound(DMClientDogFitness, 10)
   triggerServerEvent("DMSaveStatFitness", getRootElement(), DMClientDogFitness)
  else
   DMClientDogFitness = 100
   triggerServerEvent("DMSaveStatFitness", getRootElement(), DMClientDogFitness)
   killTimer(DMDogFitnessTimer)
  end
end, 15000, 0)
end
DMPositionSyncTimer = setTimer(function()
local Dogx, Dogy, Dogz = getElementPosition(DMClientDog)
triggerServerEvent("DMSyncPosition", getRootElement(),DMClientDog, Dogx, Dogy, Dogz)
end, 1000, 0)
DMDogFollow = 1
addEventHandler("onClientRender", getRootElement(), DMDogActionFollow )
end
end
if(DMDogStatus == 1)then
killTimer(DMDogIdleTimer)
destroyElement(DMDogIdleBlip)
elseif(DMDogStatus == 2)then
killTimer(DMPositionSyncTimer)
if(DMClientDogFitness < 100)then
killTimer(DMDogFitnessTimer)
end
removeEventHandler("onClientRender", getRootElement(), DMDogActionFollow )

elseif(DMDogStatus == 3)then
killTimer(DMPositionSyncTimer)
if(DMClientDogFitness < 100)then
killTimer(DMDogFitnessTimer)
end

if(DMDogAttacking == true)then
DMAttackCount = 0
DMDogAttacking = false
removeEventHandler("onClientRender", getRootElement(), DMDogActionAttack)
else
removeEventHandler("onClientRender", getRootElement(), DMDogActionFollow )
end
elseif(DMDogStatus == 7)then
killTimer(DMPositionSyncTimer)
if(DMClientDogFitness < 100)then
killTimer(DMDogFitnessTimer)
end
DMAttackCount = 0
removeEventHandler("onClientRender", getRootElement(), DMDogActionAttack)
stopSound(DMFightSound1)
stopSound(DMFightSound2)
end
killTimer(DMDogHungerTimer)
triggerServerEvent("DMDespawnDog", getRootElement(), DMClientDog)
DMDogSpawned = false
end
end

function DMExitStatus()
if(DMFeedActive == 1)then
DMFeedDogExit()
DMStopFeedAnimation = true
triggerServerEvent("DMFeedDogFinished", getRootElement(), DMStopFeedAnimation)
DMFeedActive = 0
elseif(DMFeedActive == 2)then
killTimer(DMDogEatTimer)
DMFeedDogExit()
DMStopFeedAnimation = false
triggerServerEvent("DMFeedDogFinished", getRootElement(), DMStopFeedAnimation)
DMFeedActive = 0
end
if(DMBallThrowActive == 1)then
destroyElement(DMBall)
removeEventHandler("onClientPreRender",getRootElement(),DMkeepInHand)
removeEventHandler("onClientKey",getRootElement(),DMthrowBall)
removeEventHandler("onClientPlayerWeaponSwitch", getRootElement(),DMballWeaponSwitch)
DMInventoryBallExit()
elseif(DMBallThrowActive == 2)then
killTimer(DMInventoryGetBallTimer)
removeEventHandler("onClientRender",getRootElement(),DMDogActionFollow)
destroyElement(DMBall)
removeEventHandler("onClientRender",getRootElement(),DMthrowedBall)
DMInventoryBallExit()
elseif(DMBallThrowActive == 3)then
killTimer(DMGotBallTimer)
removeEventHandler("onClientRender",getRootElement(),DMDogActionFollow)
DMInventoryBallExit()
end
if(DMDogStatus == 1)then
killTimer(DMDogIdleTimer)
destroyElement(DMDogIdleBlip)
elseif(DMDogStatus == 2)then
killTimer(DMPositionSyncTimer)
if(DMClientDogFitness < 100)then
killTimer(DMDogFitnessTimer)
end
removeEventHandler("onClientRender", getRootElement(), DMDogActionFollow )

elseif(DMDogStatus == 3)then
killTimer(DMPositionSyncTimer)
if(DMClientDogFitness < 100)then
killTimer(DMDogFitnessTimer)
end

if(DMDogAttacking == true)then
DMAttackCount = 0
DMDogAttacking = false
removeEventHandler("onClientRender", getRootElement(), DMDogActionAttack)
else
removeEventHandler("onClientRender", getRootElement(), DMDogActionFollow )
end
elseif(DMDogStatus == 7)then
killTimer(DMPositionSyncTimer)
if(DMClientDogFitness < 100)then
killTimer(DMDogFitnessTimer)
end
DMAttackCount = 0
removeEventHandler("onClientRender", getRootElement(), DMDogActionAttack)
stopSound(DMFightSound1)
stopSound(DMFightSound2)
local DMSound = playSound(":DogMod/sounds/growl.mp3", false)
setSoundVolume(DMSound, 0.3)
end
end

--HELP
function DMHelp()
if(DMHelpActive == false)then
removeEventHandler("onClientRender", getRootElement(), DMDogPanelGui)
DMDogPanel = false

guiSetVisible(DMDogPanelButton1, false)
guiSetVisible(DMDogPanelButton2, false)
guiSetVisible(DMDogPanelButton3, false)
guiSetVisible(DMDogPanelButton4, false)
guiSetVisible(DMDogPanelButton5, false)
guiSetVisible(DMDogPanelButton6, false)
guiSetVisible(DMDogPanelButton7, false)

DMHelpActive = true

addEventHandler("onClientRender", getRootElement(), DMHelpGui)
guiSetVisible(DMHelpButton1, true)
elseif(DMHelpActive == true)then
removeEventHandler("onClientRender", getRootElement(), DMHelpGui)
guiSetVisible(DMHelpButton1, false)
DMHelpActive = false

addEventHandler("onClientRender", getRootElement(), DMDogPanelGui)
DMDogPanel = true 

guiSetVisible(DMDogPanelButton1, true)
guiSetVisible(DMDogPanelButton2, true)
guiSetVisible(DMDogPanelButton3, true)
guiSetVisible(DMDogPanelButton4, true)
guiSetVisible(DMDogPanelButton5, true)
guiSetVisible(DMDogPanelButton6, true)
guiSetVisible(DMDogPanelButton7, true)
end
end

local DMHelpTextSizex = DMScreenx/1920
local DMHelpTextSizey = DMScreeny/1080
function DMHelpGui()
if(DMLanguage == 1)then
dxDrawRectangle(0.78 * DMScreenx, 0.3 * DMScreeny, 0.17 * DMScreenx, 0.37 * DMScreeny, tocolor(20, 20, 20, 220))
dxDrawText("Dog Help", 0.785 * DMScreenx, 0.315 * DMScreeny, nil, nil, tocolor(DMClientDogGenderColorR, DMClientDogGenderColorG, DMClientDogGenderColorB, 220), DMHelpTextSizey, DMHelpTextSizey, "default-bold", "left", "center")

dxDrawText("About:", 0.785 * DMScreenx, 0.33 * DMScreeny, nil, nil, tocolor(DMClientDogGenderColorR, DMClientDogGenderColorG, DMClientDogGenderColorB, 220), DMHelpTextSizey, DMHelpTextSizey, "default-bold", "left", "center")
dxDrawText("This Mod finally allows you to create your own Dog in MTA! Check for Updates on the mtasa.com page from Dog Mod by SuperBrandy", 0.79 * DMScreenx, 0.36 * DMScreeny, 0.941 * DMScreenx, 0.36 * DMScreeny, tocolor(255, 255, 255, 220), DMHelpTextSizey, DMHelpTextSizey, "default-bold", "left", "center",false, true)

dxDrawText("Commands:", 0.785 * DMScreenx, 0.39 * DMScreeny, nil, nil, tocolor(DMClientDogGenderColorR, DMClientDogGenderColorG, DMClientDogGenderColorB, 220), DMHelpTextSizey, DMHelpTextSizey, "default-bold", "left", "center")
dxDrawText("/dog - create dog", 0.79 * DMScreenx, 0.405 * DMScreeny, 0.941 * DMScreenx, 0.405 * DMScreeny, tocolor(255, 255, 255, 220), DMHelpTextSizey, DMHelpTextSizey, "default-bold", "left", "center", false, true)
dxDrawText("/deletedog - delete dog", 0.79 * DMScreenx, 0.42 * DMScreeny, 0.941 * DMScreenx, 0.42 * DMScreeny, tocolor(255, 255, 255, 220), DMHelpTextSizey, DMHelpTextSizey, "default-bold", "left", "center", false, true)
dxDrawText(DogPanelKey.." - open dog panel", 0.79 * DMScreenx, 0.435 * DMScreeny, 0.941 * DMScreenx, 0.435 * DMScreeny, tocolor(255, 255, 255, 220), DMHelpTextSizey, DMHelpTextSizey, "default-bold", "left", "center", false, true)

dxDrawText("Actions:", 0.785 * DMScreenx, 0.45 * DMScreeny, nil, nil, tocolor(DMClientDogGenderColorR, DMClientDogGenderColorG, DMClientDogGenderColorB, 220), DMHelpTextSizey, DMHelpTextSizey, "default-bold", "left", "center")
dxDrawText(ChangeStatusKey..": Change dog status", 0.79 * DMScreenx, 0.465 * DMScreeny, 0.941 * DMScreenx, 0.465 * DMScreeny, tocolor(255, 255, 255, 220), DMHelpTextSizey, DMHelpTextSizey, "default-bold", "left", "center", false, true)
dxDrawText(DoTrickKey..": Do trick", 0.79 * DMScreenx, 0.48 * DMScreeny, 0.941 * DMScreenx, 0.48 * DMScreeny, tocolor(255, 255, 255, 220), DMHelpTextSizey, DMHelpTextSizey, "default-bold", "left", "center", false, true)
dxDrawText("Idle: Your dog keeps waiting at one point", 0.79 * DMScreenx, 0.495 * DMScreeny, 0.941 * DMScreenx, 0.495 * DMScreeny, tocolor(255, 255, 255, 220), DMHelpTextSizey, DMHelpTextSizey, "default-bold", "left", "center", false, true)
dxDrawText("Following: Your dog is following you", 0.79 * DMScreenx, 0.51 * DMScreeny, 0.941 * DMScreenx, 0.51 * DMScreeny, tocolor(255, 255, 255, 220), DMHelpTextSizey, DMHelpTextSizey, "default-bold", "left", "center", false, true)
dxDrawText("Attacking: Your dog guards you from attacks and helps you by attacking others", 0.79 * DMScreenx, 0.532 * DMScreeny, 0.941 * DMScreenx, 0.532 * DMScreeny, tocolor(255, 255, 255, 220), DMHelpTextSizey, DMHelpTextSizey, "default-bold", "left", "center", false, true) 

dxDrawText("Statistics:", 0.785 * DMScreenx, 0.555 * DMScreeny, nil, nil, tocolor(DMClientDogGenderColorR, DMClientDogGenderColorG, DMClientDogGenderColorB, 220), DMHelpTextSizey, DMHelpTextSizey, "default-bold", "left", "center")
dxDrawText("Fitness: Increases the Health of your dog, gained by walking. Unlocks tricks", 0.79 * DMScreenx, 0.575 * DMScreeny, 0.941 * DMScreenx, 0.575 * DMScreeny, tocolor(255, 255, 255, 220), DMHelpTextSizey, DMHelpTextSizey, "default-bold", "left", "center", false, true)
dxDrawText("Strength: Increases the Damage your dog does, gained by attacking", 0.79 * DMScreenx, 0.605 * DMScreeny, 0.941 * DMScreenx, 0.605 * DMScreeny, tocolor(255, 255, 255, 220), DMHelpTextSizey, DMHelpTextSizey, "default-bold", "left", "center", false, true)

dxDrawImage(0.9 * DMScreenx, 0.62 * DMScreeny, 80 * DMImagex, 50 * DMImagey, texture5  )
dxDrawText("Done", 0.9 * DMScreenx, 0.623 * DMScreeny, DMScreenx * 0.942, DMScreeny * 0.663, tocolor(3, 252, 252, 220), DMHelpTextSizey * 0.7, DMHelpTextSizey * 0.7, "beckett", "center", "center")
elseif(DMLanguage == 2)then
dxDrawRectangle(0.78 * DMScreenx, 0.3 * DMScreeny, 0.17 * DMScreenx, 0.37 * DMScreeny, tocolor(20, 20, 20, 220))
dxDrawText("DogMod Hilfe", 0.785 * DMScreenx, 0.315 * DMScreeny, nil, nil, tocolor(DMClientDogGenderColorR, DMClientDogGenderColorG, DMClientDogGenderColorB, 220), DMHelpTextSizey, DMHelpTextSizey, "default-bold", "left", "center")

dxDrawText("Über:", 0.785 * DMScreenx, 0.33 * DMScreeny, nil, nil, tocolor(DMClientDogGenderColorR, DMClientDogGenderColorG, DMClientDogGenderColorB, 220), DMHelpTextSizey, DMHelpTextSizey, "default-bold", "left", "center")
dxDrawText("Dieser Mod bringt Hunde in deine MTA Welt! Neue Updates sind auf der mtasa.com Website -DogMod by SuperBrandy- zu finden", 0.79 * DMScreenx, 0.36 * DMScreeny, 0.941 * DMScreenx, 0.36 * DMScreeny, tocolor(255, 255, 255, 220), DMHelpTextSizey, DMHelpTextSizey, "default-bold", "left", "center",false, true)

dxDrawText("Befehle:", 0.785 * DMScreenx, 0.39 * DMScreeny, nil, nil, tocolor(DMClientDogGenderColorR, DMClientDogGenderColorG, DMClientDogGenderColorB, 220), DMHelpTextSizey, DMHelpTextSizey, "default-bold", "left", "center")
dxDrawText("/dog - Hund erstellen", 0.79 * DMScreenx, 0.405 * DMScreeny, 0.941 * DMScreenx, 0.405 * DMScreeny, tocolor(255, 255, 255, 220), DMHelpTextSizey, DMHelpTextSizey, "default-bold", "left", "center", false, true)
dxDrawText("/deletedog - Hund löschen", 0.79 * DMScreenx, 0.42 * DMScreeny, 0.941 * DMScreenx, 0.42 * DMScreeny, tocolor(255, 255, 255, 220), DMHelpTextSizey, DMHelpTextSizey, "default-bold", "left", "center", false, true)
dxDrawText(DogPanelKey.." - Hunde Panel öffnen", 0.79 * DMScreenx, 0.435 * DMScreeny, 0.941 * DMScreenx, 0.435 * DMScreeny, tocolor(255, 255, 255, 220), DMHelpTextSizey, DMHelpTextSizey, "default-bold", "left", "center", false, true)

dxDrawText("Aktionen:", 0.785 * DMScreenx, 0.45 * DMScreeny, nil, nil, tocolor(DMClientDogGenderColorR, DMClientDogGenderColorG, DMClientDogGenderColorB, 220), DMHelpTextSizey, DMHelpTextSizey, "default-bold", "left", "center")
dxDrawText(ChangeStatusKey..": Status des Hundes ändern", 0.79 * DMScreenx, 0.465 * DMScreeny, 0.941 * DMScreenx, 0.465 * DMScreeny, tocolor(255, 255, 255, 220), DMHelpTextSizey, DMHelpTextSizey, "default-bold", "left", "center", false, true)
dxDrawText(DoTrickKey..": Tricks ausführen", 0.79 * DMScreenx, 0.48 * DMScreeny, 0.941 * DMScreenx, 0.48 * DMScreeny, tocolor(255, 255, 255, 220), DMHelpTextSizey, DMHelpTextSizey, "default-bold", "left", "center", false, true)
dxDrawText("Wartend: Dein Hund wartet an einem Punkt", 0.79 * DMScreenx, 0.495 * DMScreeny, 0.941 * DMScreenx, 0.495 * DMScreeny, tocolor(255, 255, 255, 220), DMHelpTextSizey, DMHelpTextSizey, "default-bold", "left", "center", false, true)
dxDrawText("Folgen: Dein Hund folgt dir", 0.79 * DMScreenx, 0.51 * DMScreeny, 0.941 * DMScreenx, 0.51 * DMScreeny, tocolor(255, 255, 255, 220), DMHelpTextSizey, DMHelpTextSizey, "default-bold", "left", "center", false, true)
dxDrawText("Attackieren: Dein Hund greift an und beschützt dich", 0.79 * DMScreenx, 0.525 * DMScreeny, 0.941 * DMScreenx, 0.525 * DMScreeny, tocolor(255, 255, 255, 220), DMHelpTextSizey, DMHelpTextSizey, "default-bold", "left", "center", false, true) 

dxDrawText("Statistiken:", 0.785 * DMScreenx, 0.555 * DMScreeny, nil, nil, tocolor(DMClientDogGenderColorR, DMClientDogGenderColorG, DMClientDogGenderColorB, 220), DMHelpTextSizey, DMHelpTextSizey, "default-bold", "left", "center")
dxDrawText("Fitness: Erhöht das Leben deines Hundes durch laufen. Schaltet Tricks frei", 0.79 * DMScreenx, 0.575 * DMScreeny, 0.941 * DMScreenx, 0.575 * DMScreeny, tocolor(255, 255, 255, 220), DMHelpTextSizey, DMHelpTextSizey, "default-bold", "left", "center", false, true)
dxDrawText("Stärke: Erhöht den Schaden deines Hundes, erhöht sich durch Attacken", 0.79 * DMScreenx, 0.605 * DMScreeny, 0.941 * DMScreenx, 0.605 * DMScreeny, tocolor(255, 255, 255, 220), DMHelpTextSizey, DMHelpTextSizey, "default-bold", "left", "center", false, true)

dxDrawImage(0.9 * DMScreenx, 0.62 * DMScreeny, 80 * DMImagex, 50 * DMImagey, texture5  )
dxDrawText("Fertig", 0.9 * DMScreenx, 0.623 * DMScreeny, DMScreenx * 0.942, DMScreeny * 0.663, tocolor(0, 0, 0, 220), DMHelpTextSizey * 0.7, DMHelpTextSizey * 0.7, "beckett", "center", "center")
end
end

function DMHelpInteractives()
DMHelpButton1 = guiCreateButton ( 0.9 * DMScreenx, 0.623 * DMScreeny, 0.042 * DMScreenx, 0.04 * DMScreeny, "", false)
guiSetAlpha(DMHelpButton1, 0)
guiSetVisible(DMHelpButton1, false)
addEventHandler ( "onClientGUIClick", DMHelpButton1, DMHelp, false )
end

--CHEATS
function DMUnlockAll()
if(EnableCheats == true)then
if(DMClientOwnerGotDog == true)then
if(DMDogSpawned == false)then
DMClientDogFitness = 100
triggerServerEvent("DMSaveStatFitness", getRootElement(), DMClientDogFitness)
DMClientDogStrength = 100
triggerServerEvent("DMSaveStatStrength", getRootElement(), DMClientDogStrength)
else
if(DMLanguage == 1)then
outputChatBox("Ebteda Sage Khod Ra Makhfi Konid", 255,0,0)
elseif(DMLanguage == 2)then
outputChatBox("Despawne deinen Hund zuerst", 255,0,0)
end
end
else
if(DMLanguage == 1)then
outputChatBox("Shoma Sag Nadarid", 255,0,0)
elseif(DMLanguage == 2)then
outputChatBox("Du hast keinen Hund", 255,0,0)
end
end
else
if(DMLanguage == 1)then
outputChatBox("Cheat Gheyre Faal Ast", 255,0,0)
elseif(DMLanguage == 2)then
outputChatBox("Cheats sind ausgeschalten", 255,0,0)
end
end
end

--LANGUAGE

--.Handler.--

addEventHandler("onClientResourceStart", getResourceRootElement(getThisResource()), 
	function ()
    -- load dogs  	
	--SHEPERD	      
      txd = engineLoadTXD("skins/txd/germansheperdblack.txd")
      engineImportTXD(txd, 290)
      dff = engineLoadDFF("skins/dff/germansheperd.dff", 290)
      engineReplaceModel(dff, 290)
	  
	  txd = engineLoadTXD("skins/txd/germansheperdblackwhite.txd")
      engineImportTXD(txd, 291)
      dff = engineLoadDFF("skins/dff/germansheperd.dff", 291)
      engineReplaceModel(dff, 291)
    
      txd = engineLoadTXD("skins/txd/germansheperdblackbrown.txd")
      engineImportTXD(txd, 292)
      dff = engineLoadDFF("skins/dff/germansheperd.dff", 292)
      engineReplaceModel(dff, 292)
	  
	--PITBULL
      txd = engineLoadTXD("skins/txd/pitbullbrown.txd")
      engineImportTXD(txd, 293)
      dff = engineLoadDFF("skins/dff/pitbull1.dff", 293)
      engineReplaceModel(dff, 293)
		
      txd = engineLoadTXD("skins/txd/pitbullwhite.txd")
      engineImportTXD(txd, 294)
      dff = engineLoadDFF("skins/dff/pitbull1.dff", 294)
      engineReplaceModel(dff, 294)
	  
	  txd = engineLoadTXD("skins/txd/pitbullgrey.txd")
      engineImportTXD(txd, 295)
      dff = engineLoadDFF("skins/dff/pitbull1.dff", 295)
      engineReplaceModel(dff, 295)
		
	  txd = engineLoadTXD("skins/txd/pitbullblackwhite.txd")
      engineImportTXD(txd, 296)
      dff = engineLoadDFF("skins/dff/pitbull2.dff", 296)
      engineReplaceModel(dff, 296)
				
    --GOLDERRETRIEVER
	  txd = engineLoadTXD("skins/txd/goldenretrieverbrown.txd")
      engineImportTXD(txd, 297)
      dff = engineLoadDFF("skins/dff/goldenretriever.dff", 297)
      engineReplaceModel(dff, 297)  
	  
	  txd = engineLoadTXD("skins/txd/goldenretrieverwhite.txd")
      engineImportTXD(txd, 298)
      dff = engineLoadDFF("skins/dff/goldenretriever.dff", 298)
      engineReplaceModel(dff, 298)  
	
    --ROTTWEILER
	  txd = engineLoadTXD("skins/txd/rottweiler.txd")
      engineImportTXD(txd, 299)
      dff = engineLoadDFF("skins/dff/rottweiler.dff", 299)
      engineReplaceModel(dff, 299)  
	  
	-- load textures
		texture1 = dxCreateTexture(":DogMod/textures/sheperd.png" , "argb", true,"clamp" )
		texture2 = dxCreateTexture(":DogMod/textures/pitbull.png" , "argb", true,"clamp" )
		texture3 = dxCreateTexture(":DogMod/textures/goldenretriever.png" , "argb", true,"clamp" )
		texture4 = dxCreateTexture(":DogMod/textures/rottweiler.png" , "argb", true,"clamp" )
		texture5 = dxCreateTexture(":DogMod/textures/button.png" , "argb", true,"clamp" )
		texture6 = dxCreateTexture(":DogMod/textures/buttonfalse.png" , "argb", true,"clamp" )
		texture7 = dxCreateTexture(":DogMod/textures/male.png" , "argb", true,"clamp" )
		texture8 = dxCreateTexture(":DogMod/textures/female.png" , "argb", true,"clamp" )
		
		bindKey(DogPanelKey, "down", DMDogPanel)
		
		DMDogPanel = false
		DMFeedActive = 0
		DMDogAttacking = false
		DMDogHunger = 100
		DMDogSpawned = false
		DMHelpActive = false
		DMTricksDogPanel = false
		DMTricksTutorialActive = false
		DMStatusActive = false
		DMDogDeathRevive = true
		DMBallThrowActive = 0
		DMCreatorActive = false
		DMDogTasksPanel = false
		DMDogFightPanel = false
		DMDogDeathRevive = true
		DMDogFightRequestPanel = false
		DMOnlySpawn = false
		DMPlayerInFight = false
		DMRequestClose = false
		DMAttackSound2 = false
		DMDogSniffPanel = false
		
		local DMroom = createObject ( 14865, 0, 0, 0, 0, 0, 0 )
	    setElementInterior ( DMroom, 20, 0, 0, 0)
		
		local DMtable = createObject ( 2762 , 0.1, 0.5, -1.6, 0, 0, 0 )
	    setElementInterior ( DMtable, 20, 0.1, 0.5, -1.6)
		
		DMDogCreatorPed = createPed ( 290 , 0.1, 0.3, -0.2 , 90)
	    setElementInterior ( DMDogCreatorPed, 20, 0.1, 0.3, -0.2)
		
		triggerServerEvent("DMCheckOwner", getRootElement())
		
		DMDogCreationInteractives()
		DMDogPanelInteractives()
		DMHelpInteractives()
		DMTricksDogInteractives()
		DMDogTasksInteractives()
		DMDogFightInteractives()
		DMDogFightRequestInteractives()
		DMDogSniffInteractives()
		
		if(Language == "English")then
		  DMLanguage = 1
		elseif(Language == "German")then
		  DMLanguage = 2
		end
	end
	)

addCommandHandler("dog", DMCreateDog)
addCommandHandler("deletedog", DMDeleteDog)
addCommandHandler("unlockall", DMUnlockAll)

addEvent( "DMCheckOwnerBack", true )
addEventHandler( "DMCheckOwnerBack", getRootElement(), DMCheckOwnerBack )

addEvent( "DMSpawnDogBack", true )
addEventHandler( "DMSpawnDogBack", getRootElement(), DMSpawnDogBack )

addEvent( "DMFeedDogBack", true )
addEventHandler( "DMFeedDogBack", getRootElement(), DMFeedDogBack )

addEvent( "DMCheckAttackAttacker", true )
addEventHandler( "DMCheckAttackAttacker", getRootElement(), DMCheckAttackAttacker )

addEvent( "DMDogActionAttackStop", true )
addEventHandler( "DMDogActionAttackStop", getRootElement(), DMDogActionAttackStop )

addEvent( "DMDogFightRequestBack", true )
addEventHandler( "DMDogFightRequestBack", getRootElement(), DMDogFightRequestBack )

addEvent("DMDogFightRequestFailed", true)
addEventHandler("DMDogFightRequestFailed", getRootElement(), DMDogFightRequestFailed)

addEvent("DMDogFightRequestSent", true)
addEventHandler("DMDogFightRequestSent", getRootElement(), DMDogFightRequestSent)

addEvent("DMDogFightRequestDecilnedBack", true)
addEventHandler("DMDogFightRequestDecilnedBack", getRootElement(), DMDogFightRequestDecilnedBack)

addEvent("DMDogFightWin", true)
addEventHandler("DMDogFightWin", getRootElement(), DMDogFightWin)

addEvent("DMDogFightLose", true)
addEventHandler("DMDogFightLose", getRootElement(), DMDogFightLose)

addEvent("DMDogsFightStartBack", true)
addEventHandler("DMDogsFightStartBack", getRootElement(), DMDogsFightStartBack)

addEvent("DMDogsFightGiveUpBack", true)
addEventHandler("DMDogsFightGiveUpBack", getRootElement(), DMDogsFightGiveUpBack)

addEvent("DMAttackSoundBack", true)
addEventHandler("DMAttackSoundBack", getRootElement(), DMAttackSoundBack)

addEvent("DMAttackSoundStopBack", true)
addEventHandler("DMAttackSoundStopBack", getRootElement(), DMAttackSoundStopBack)

addEvent("DMGuardSoundBack", true)
addEventHandler("DMGuardSoundBack", getRootElement(), DMGuardSoundBack)

addEvent("DMGuardSoundStopBack", true)
addEventHandler("DMGuardSoundStopBack", getRootElement(), DMGuardSoundStopBack)

addEventHandler ( "onClientPlayerWasted", getLocalPlayer(), DMPlayerDeath )
addEventHandler ( "onClientPlayerDamage", getRootElement(), DMCheckAttack )

addEventHandler ( "onClientPedDamage", getRootElement(), DMDogDamage )

--IN CAR

addEventHandler("onClientPlayerVehicleEnter",getRootElement(),
function()
if(source == getLocalPlayer())then
if(DMDogSpawned == false)then
local DMStopDog = false
DMExit(DMStopDog)
elseif(DMDogSpawned == true)then
local DMStopDog = false
DMExit(DMStopDog)
addEventHandler("onClientRender", getRootElement(), DMStatusGui)
DMStatusActive = true
local DMVehicle = getPedOccupiedVehicle(source)
local DMVehicleType = getVehicleType (DMVehicle)

local DMSeat
if(DMVehicleType == "Automobile" or DMVehicleType == "Helicopter" or DMVehicleType == "Monster Truck")then
local DMSeats = getVehicleMaxPassengers (DMVehicle)
if(DMSeats == 0)then
DMSeat = 0
end
if(DMSeats == 1)then
if(getVehicleOccupant ( DMVehicle, 1 ) == false)then
DMSeat = 1
else
DMSeat = 0
end
end
if(DMSeats == 2)then
if(getVehicleOccupant ( DMVehicle, 1 ) == false)then
DMSeat = 1
elseif(getVehicleOccupant ( DMVehicle, 2 ) == false)then
DMSeat = 2
else
DMSeat = 0
end
end
if(DMSeats == 3)then
if(getVehicleOccupant ( DMVehicle, 1 ) == false)then
DMSeat = 1
elseif(getVehicleOccupant ( DMVehicle, 2 ) == false)then
DMSeat = 2
elseif(getVehicleOccupant ( DMVehicle, 3 ) == false)then
DMSeat = 3
else
DMSeat = 0
end
end
if(DMSeats == 4)then
if(getVehicleOccupant ( DMVehicle, 1 ) == false)then
DMSeat = 1
elseif(getVehicleOccupant ( DMVehicle, 2 ) == false)then
DMSeat = 2
elseif(getVehicleOccupant ( DMVehicle, 3 ) == false)then
DMSeat = 3
elseif(getVehicleOccupant ( DMVehicle, 4 ) == false)then
DMSeat = 4
else
DMSeat = 0
end
end
if(DMSeats == 5)then
if(getVehicleOccupant ( DMVehicle, 1 ) == false)then
DMSeat = 1
elseif(getVehicleOccupant ( DMVehicle, 2 ) == false)then
DMSeat = 2
elseif(getVehicleOccupant ( DMVehicle, 3 ) == false)then
DMSeat = 3
elseif(getVehicleOccupant ( DMVehicle, 4 ) == false)then
DMSeat = 4
elseif(getVehicleOccupant ( DMVehicle, 5 ) == false)then
DMSeat = 5
else
DMSeat = 0
end
end
if(DMSeats == 6)then
if(getVehicleOccupant ( DMVehicle, 1 ) == false)then
DMSeat = 1
elseif(getVehicleOccupant ( DMVehicle, 2 ) == false)then
DMSeat = 2
elseif(getVehicleOccupant ( DMVehicle, 3 ) == false)then
DMSeat = 3
elseif(getVehicleOccupant ( DMVehicle, 4 ) == false)then
DMSeat = 4
elseif(getVehicleOccupant ( DMVehicle, 5) == false)then
DMSeat = 5
elseif(getVehicleOccupant ( DMVehicle, 6 ) == false)then
DMSeat = 6
else
DMSeat = 0
end
end
if(DMSeats == 7)then
if(getVehicleOccupant ( DMVehicle, 1 ) == false)then
DMSeat = 1
elseif(getVehicleOccupant ( DMVehicle, 2 ) == false)then
DMSeat = 2
elseif(getVehicleOccupant ( DMVehicle, 3 ) == false)then
DMSeat = 3
elseif(getVehicleOccupant ( DMVehicle, 4 ) == false)then
DMSeat = 4
elseif(getVehicleOccupant ( DMVehicle, 5) == false)then
DMSeat = 5
elseif(getVehicleOccupant ( DMVehicle, 6 ) == false)then
DMSeat = 6
elseif(getVehicleOccupant ( DMVehicle, 7 ) == false)then
DMSeat = 7
else
DMSeat = 0
end
end
if(DMSeats == 8)then
if(getVehicleOccupant ( DMVehicle, 1 ) == false)then
DMSeat = 1
elseif(getVehicleOccupant ( DMVehicle, 2 ) == false)then
DMSeat = 2
elseif(getVehicleOccupant ( DMVehicle, 3 ) == false)then
DMSeat = 3
elseif(getVehicleOccupant ( DMVehicle, 4 ) == false)then
DMSeat = 4
elseif(getVehicleOccupant ( DMVehicle, 5) == false)then
DMSeat = 5
elseif(getVehicleOccupant ( DMVehicle, 6 ) == false)then
DMSeat = 6
elseif(getVehicleOccupant ( DMVehicle, 7 ) == false)then
DMSeat = 7
elseif(getVehicleOccupant ( DMVehicle, 8 ) == false)then
DMSeat = 8
else
DMSeat = 0
end
end
else
DMSeat = 0
end

if(DMFeedActive == 1)then
DMFeedDogExit()
DMStopFeedAnimation = true
triggerServerEvent("DMFeedDogFinished", getRootElement(), DMStopFeedAnimation)
DMFeedActive = 0
elseif(DMFeedActive == 2)then
killTimer(DMDogEatTimer)
DMFeedDogExit()
DMStopFeedAnimation = false
triggerServerEvent("DMFeedDogFinished", getRootElement(), DMStopFeedAnimation)
DMFeedActive = 0
end

if(DMBallThrowActive == 1)then
destroyElement(DMBall)
removeEventHandler("onClientPreRender",getRootElement(),DMkeepInHand)
removeEventHandler("onClientKey",getRootElement(),DMthrowBall)
removeEventHandler("onClientPlayerWeaponSwitch", getRootElement(),DMballWeaponSwitch)
DMInventoryBallExit()
elseif(DMBallThrowActive == 2)then
killTimer(DMInventoryGetBallTimer)
removeEventHandler("onClientRender",getRootElement(),DMDogActionFollow)
destroyElement(DMBall)
removeEventHandler("onClientRender",getRootElement(),DMthrowedBall)
DMInventoryBallExit()
elseif(DMBallThrowActive == 3)then
killTimer(DMGotBallTimer)
removeEventHandler("onClientRender",getRootElement(),DMDogActionFollow)
DMInventoryBallExit()
end

if(DMDogStatus == 2 )then
removeEventHandler("onClientRender", getRootElement(), DMDogActionFollow )
local DMPlayerInVehicle = true
killTimer(DMDogFitnessTimer)
killTimer(DMPositionSyncTimer)

triggerServerEvent("DMOwnerCar", getRootElement(), DMPlayerInVehicle, DMClientDog,DMx, DMy, DMz, DMVehicle, DMSeat)
elseif(DMDogStatus == 3)then
if(removeEventHandler("onClientRender", getRootElement(), DMDogActionFollow ))then
else
removeEventHandler("onClientRender", getRootElement(), DMDogActionAttack)
DMDogAttacking = false
end
local DMPlayerInVehicle = true
killTimer(DMDogFitnessTimer)
killTimer(DMPositionSyncTimer)
triggerServerEvent("DMOwnerCar", getRootElement(), DMPlayerInVehicle, DMClientDog,DMx, DMy, DMz, DMVehicle, DMSeat)
elseif(DMDogStatus == 7)then
local DMPlayerInVehicle = true
removeEventHandler("onClientRender", getRootElement(), DMDogActionAttack)
DMDogAttacking = false
killTimer(DMDogFitnessTimer)
killTimer(DMPositionSyncTimer)
stopSound(DMFightSound1)
stopSound(DMFightSound2)
if(DMLanguage == 1)then
outputChatBox("Shoma Az Mobareze Enseraf Dadid", 255,255,0)
elseif(DMLanguage == 2)then
outputChatBox("Du hast den Kampf aufgegeben", 255,255,0)
end
local DMTriggerPlayer = getPlayerFromName(DMRequestPlayer)
triggerServerEvent("DMDogsFightGiveUp", getRootElement(), DMTriggerPlayer)
DMDogStatus = 3
triggerServerEvent("DMOwnerCar", getRootElement(), DMPlayerInVehicle, DMClientDog,DMx, DMy, DMz, DMVehicle, DMSeat)
end
end
end
end)

addEventHandler("onClientPlayerVehicleExit",getRootElement(),
function()
if(source == getLocalPlayer())then
if(DMDogSpawned == true)then
if(DMDogStatus == 2 or DMDogStatus == 3)then
local DMPlayerInVehicle = false

DMPositionSyncTimer = setTimer(function()
local Dogx, Dogy, Dogz = getElementPosition(DMClientDog)
triggerServerEvent("DMSyncPosition", getRootElement(),DMClientDog, Dogx, Dogy, Dogz)
end, 1000, 0)

if(DMClientDogFitness < 100)then
DMDogFitnessTimer = setTimer(function()
  if(DMClientDogFitness < 100)then
   DMClientDogFitness = DMClientDogFitness + 0.2
   DMClientDogFitness = DMRound(DMClientDogFitness, 10)
   triggerServerEvent("DMSaveStatFitness", getRootElement(), DMClientDogFitness)
  else
   DMClientDogFitness = 100
   triggerServerEvent("DMSaveStatFitness", getRootElement(), DMClientDogFitness)
   killTimer(DMDogFitnessTimer)
  end
end, 15000, 0)
end

local DMx, DMy, DMz = getElementPosition(getLocalPlayer())
DMDogDistanceAnimation = 0
DMDogFollow = 1
addEventHandler("onClientRender", getRootElement(), DMDogActionFollow )
triggerServerEvent("DMOwnerCar", getRootElement(), DMPlayerInVehicle, DMClientDog, DMx, DMy, DMz)
end
end
end
end)

--POSITION SYNC
addEventHandler ( "onClientPedDamage", getRootElement(), 
function()
if(source == DMClientDog)then
local Dogx, Dogy, Dogz = getElementPosition(DMClientDog)
triggerServerEvent("DMSyncPosition", getRootElement(),DMClientDog, Dogx, Dogy, Dogz)
if(DMDogStatus == 1)then
destroyElement(DMDogIdleBlip)
DMDogIdleBlip = createBlip ( Dogx, Dogy, Dogz , 0, 2, 255, 255, 255, 255, 0, 250)
end
end
end)
