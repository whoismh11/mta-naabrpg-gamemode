--OBJECTS
local DMDatabase
local DMIDs
local DMOwners
local DMNames
local DMDogSkins
local DMDogFitnesss
local DMDogStrengths
local DMDogActive
local DMNotActive
local DMDogGenders

--.Functions.--

--LOADING
function DMDatabasestart()
DMDataBase = dbConnect("sqlite", "dogs.db")
dbExec( DMDataBase, "CREATE TABLE IF NOT EXISTS dogs(ID INT, Owner TEXT, Name TEXT, DogSkin INT, Fitness INT, Strength INT, Gender TEXT)")
DMDogActive = createElement("Object")
DMNotActive = createElement("Object")
end

function DMDataBaseLoadDogs()
local query = dbQuery(DMDataBase, "SELECT ID FROM `dogs`")
local result = dbPoll ( query, -1 )

DMIDs = createElement("Object")
DMCount = 0
 
if result then
    for _, row in ipairs ( result ) do
 
        for column, value in pairs ( row ) do
		
		DMCount = DMCount + 1
		setElementData(DMIDs, DMCount, value)
        setElementData(DMDogActive, DMCount, DMNotActive)
		end
    end
end

local query = dbQuery(DMDataBase, "SELECT Owner FROM `dogs`")
local result = dbPoll ( query, -1 )

DMOwners = createElement("Object")
DMCount = 0
 
if result then
    for _, row in ipairs ( result ) do
 
        for column, value in pairs ( row ) do
		
		DMCount = DMCount + 1
		setElementData(DMOwners, DMCount, value)
        
		end
    end
end

local query = dbQuery(DMDataBase, "SELECT Name FROM `dogs`")
local result = dbPoll ( query, -1 )
 
DMNames = createElement("Object")
DMCount = 0

if result then
    for _, row in ipairs ( result ) do
 
        for column, value in pairs ( row ) do
		
        DMCount = DMCount + 1		
	    setElementData(DMNames, DMCount, value)
		
        end
    end
end

local query = dbQuery(DMDataBase, "SELECT DogSkin FROM `dogs`")
local result = dbPoll ( query, -1 )
 
DMDogSkins = createElement("Object")
DMCount = 0

if result then
    for _, row in ipairs ( result ) do
 
        for column, value in pairs ( row ) do
		
        DMCount = DMCount + 1		
	    setElementData(DMDogSkins, DMCount, value)
		
        end
    end
end

local query = dbQuery(DMDataBase, "SELECT Fitness FROM `dogs`")
local result = dbPoll ( query, -1 )
 
DMDogFitnesss = createElement("Object")
DMCount = 0

if result then
    for _, row in ipairs ( result ) do
 
        for column, value in pairs ( row ) do
		
        DMCount = DMCount + 1		
	    setElementData(DMDogFitnesss, DMCount, value)
		
        end
    end
end

local query = dbQuery(DMDataBase, "SELECT Strength FROM `dogs`")
local result = dbPoll ( query, -1 )
 
DMDogStrengths = createElement("Object")
DMCount = 0

if result then
    for _, row in ipairs ( result ) do
 
        for column, value in pairs ( row ) do
		
        DMCount = DMCount + 1		
	    setElementData(DMDogStrengths, DMCount, value)
		
        end
    end
end

local query = dbQuery(DMDataBase, "SELECT Gender FROM `dogs`")
local result = dbPoll ( query, -1 )
 
DMDogGenders = createElement("Object")
DMCount = 0

if result then
    for _, row in ipairs ( result ) do
 
        for column, value in pairs ( row ) do
		
        DMCount = DMCount + 1		
	    setElementData(DMDogGenders, DMCount, value)
		
        end
    end
end

DMCountStart = DMCount
end

function DMCheckOwner()
local DMOwnerName = getPlayerName(client)
local DMOwnerGotDog
local DMDogName
local DMDogRace
local DMDogFitness
local DMDogStrength
local DMDogGender

for variable = 1, DMCount, 1 do
	local DMOwner = getElementData(DMOwners, variable)
    if(DMOwner == DMOwnerName)then
	DMDogName = getElementData(DMNames, variable)
    DMDogRace = getElementData(DMDogSkins, variable)
	DMDogFitness = getElementData(DMDogFitnesss, variable)
    DMDogStrength = getElementData(DMDogStrengths, variable)
	DMDogGender = getElementData(DMDogGenders, variable)
	DMOwnerGotDog = true
	end
end
if(DMOwnerGotDog == true)then
triggerClientEvent(client, "DMCheckOwnerBack", getRootElement(), DMOwnerGotDog, DMDogName, DMDogRace,DMDogFitness,DMDogStrength, DMDogGender)
else
triggerClientEvent(client, "DMCheckOwnerBack", getRootElement(), DMOwnerGotDog)
end
end

--SAVING
function DMDatabaseSave()
if(DMCount >= DMCountStart)then
for variable = 1, DMCountStart, 1 do
    local DMOwner = getElementData(DMOwners, variable)
	local DMName = getElementData(DMNames, variable)
	local DMDogSkin = getElementData(DMDogSkins, variable)
    local DMDogFitness = getElementData(DMDogFitnesss, variable)
	local DMDogStrength = getElementData(DMDogStrengths, variable)
	local DMDogGender = getElementData(DMDogGenders, variable)
	
	dbExec( DMDataBase, "UPDATE dogs SET Owner = ? WHERE ID= ?",DMOwner,variable)
	dbExec( DMDataBase, "UPDATE dogs SET Name = ? WHERE ID = ?",DMName,variable)
	dbExec( DMDataBase, "UPDATE dogs SET DogSkin = ? WHERE ID = ?",DMDogSkin,variable)
	dbExec( DMDataBase, "UPDATE dogs SET Fitness = ? WHERE ID = ?",DMDogFitness,variable)
	dbExec( DMDataBase, "UPDATE dogs SET Strength = ? WHERE ID = ?",DMDogStrength,variable)
	dbExec( DMDataBase, "UPDATE dogs SET Gender = ? WHERE ID = ?",DMDogGender,variable)
end
for variable = DMCountStart + 1, DMCount, 1 do
    local DMID = getElementData(DMIDs, variable)
	local DMOwner = getElementData(DMOwners, variable)
	local DMName = getElementData(DMNames, variable)
	local DMDogSkin = getElementData(DMDogSkins, variable)
    local DMDogFitness = getElementData(DMDogFitnesss, variable)
	local DMDogStrength = getElementData(DMDogStrengths, variable)
	local DMDogGender = getElementData(DMDogGenders, variable)
	
	dbExec( DMDataBase, "INSERT	INTO dogs VALUES (?,?,?,?,?,?,?)",DMID,DMOwner,DMName,DMDogSkin,DMDogFitness,DMDogStrength,DMDogGender)
end
end
if(DMCount < DMCountStart)then
for variable = 1, DMCount, 1 do
	local DMOwner = getElementData(DMOwners, variable)
	local DMName = getElementData(DMNames, variable)
	local DMDogSkin = getElementData(DMDogSkins, variable)
    local DMDogFitness = getElementData(DMDogFitnesss, variable)
	local DMDogStrength = getElementData(DMDogStrengths, variable)
	local DMDogGender = getElementData(DMDogGenders, variable)
	
	dbExec( DMDataBase, "UPDATE dogs SET Owner = ? WHERE ID= ?",DMOwner,variable)
	dbExec( DMDataBase, "UPDATE dogs SET Name = ? WHERE ID = ?",DMName,variable)
	dbExec( DMDataBase, "UPDATE dogs SET DogSkin = ? WHERE ID = ?",DMDogSkin,variable)
	dbExec( DMDataBase, "UPDATE dogs SET Fitness = ? WHERE ID = ?",DMDogFitness,variable)
	dbExec( DMDataBase, "UPDATE dogs SET Strength = ? WHERE ID = ?",DMDogStrength,variable)
	dbExec( DMDataBase, "UPDATE dogs SET Strength = ? WHERE ID = ?",DMDogGender,variable)
end
for variable = DMCount + 1, DMCountStart, 1 do
   dbExec( DMDataBase, "DELETE from dogs WHERE ID = ?",variable)
end
end
end

function DMSaveStatFitness(DMClientDogFitness)
local DMOwnerName = getPlayerName(client)

for variable = 1, DMCount, 1 do
	local DMOwner = getElementData(DMOwners, variable)
    if(DMOwner == DMOwnerName)then
    setElementData(DMDogFitnesss, variable, DMClientDogFitness)
    end
end
end

function DMSaveStatStrength(DMClientDogStrength)
local DMOwnerName = getPlayerName(client)

for variable = 1, DMCount, 1 do
	local DMOwner = getElementData(DMOwners, variable)
    if(DMOwner == DMOwnerName)then
    setElementData(DMDogStrengths, variable, DMClientDogStrength)
    end
end
end

--CREATE / DELETE
function DMCreateDogSubmit(DMDogRace, DMDogName, DMPlayerx, DMPlayery, DMPlayerz, DMPlayerSkin, DMDogCreationGender)
local DMOwnerName = getPlayerName(client)

DMCount = DMCount + 1
setElementData(DMIDs, DMCount, DMCount)
setElementData(DMOwners, DMCount,DMOwnerName)
setElementData(DMNames, DMCount,DMDogName)
setElementData(DMDogSkins, DMCount,DMDogRace)
if(DMDogCreationGender == "male")then
setElementData(DMDogFitnesss, DMCount, 0)
setElementData(DMDogStrengths, DMCount, 10)
elseif(DMDogCreationGender == "female")then
setElementData(DMDogFitnesss, DMCount, 10)
setElementData(DMDogStrengths, DMCount, 0)
end
setElementData(DMDogGenders, DMCount, DMDogCreationGender)
setElementData(DMDogActive, DMCount, DMNotActive)

spawnPlayer(client, DMPlayerx, DMPlayery, DMPlayerz, 0 , DMPlayerSkin)
fadeCamera(client, true)
setCameraTarget(client, client)
end

function DMDeleteDog(DMDogSpawned, DMClientDog)
local DMOwnerName = getPlayerName(client)
local DMOwnerSlot

for variable = 1, DMCount, 1 do
	local DMOwner = getElementData(DMOwners, variable)
    if(DMOwner == DMOwnerName)then
    DMOwnerSlot = variable
	end
end

DMCount = DMCount - 1

for variable = DMOwnerSlot, DMCount, 1 do
	local DMOwner = getElementData(DMOwners, variable + 1)
    setElementData(DMOwners, variable, DMOwner)
    local DMName = getElementData(DMNames, variable + 1)
	setElementData(DMNames, variable, DMName)
	local DMDogSkin = getElementData(DMDogSkins, variable + 1)
    setElementData(DMDogSkins, variable, DMDogSkin)
	local DMDogFitness = getElementData(DMDogFitnesss, variable + 1)
	setElementData(DMDogFitnesss, variable, DMDogFitness)
	local DMDogStrength = getElementData(DMDogStrengths, variable + 1)
	setElementData(DMDogStrengths, variable, DMDogStrength)
	local DMDogGender = getElementData(DMDogGenders, variable + 1)
	setElementData(DMDogGenders, variable, DMDogGender)
	
	local DMDogActive = getElementData(DMDogActive, variable + 1)
	setElementData(DMDogActive, variable, DMDogActive)
end
removeElementData(DMIDs, DMCount + 1)
removeElementData(DMOwners, DMCount + 1)
removeElementData(DMDogSkins, DMCount + 1)
removeElementData(DMNames, DMCount + 1)
removeElementData(DMDogFitnesss, DMCount + 1)
removeElementData(DMDogStrengths, DMCount + 1)
removeElementData(DMDogGenders, DMCount + 1)
removeElementData(DMDogActive, DMCount + 1)

if(DMDogSpawned == true)then
destroyElement(DMClientDog)
end
end

function DMDeleteDogNoSpawn()
local DMOwnerName = getPlayerName(client)
local DMOwnerSlot

for variable = 1, DMCount, 1 do
	local DMOwner = getElementData(DMOwners, variable)
    if(DMOwner == DMOwnerName)then
    DMOwnerSlot = variable
	end
end

DMCount = DMCount - 1

for variable = DMOwnerSlot, DMCount, 1 do
	local DMOwner = getElementData(DMOwners, variable + 1)
    setElementData(DMOwners, variable, DMOwner)
    local DMName = getElementData(DMNames, variable + 1)
	setElementData(DMNames, variable, DMName)
	local DMDogSkin = getElementData(DMDogSkins, variable + 1)
    setElementData(DMDogSkins, variable, DMDogSkin)
	local DMDogFitness = getElementData(DMDogFitnesss, variable + 1)
	setElementData(DMDogFitnesss, variable, DMDogFitness)
	local DMDogStrength = getElementData(DMDogStrengths, variable + 1)
	setElementData(DMDogStrengths, variable, DMDogStrength)
	local DMDogGender = getElementData(DMDogGenders, variable + 1)
	setElementData(DMDogGenders, variable, DMDogGender)
end
removeElementData(DMIDs, DMCount + 1)
removeElementData(DMOwners, DMCount + 1)
removeElementData(DMDogSkins, DMCount + 1)
removeElementData(DMNames, DMCount + 1)
removeElementData(DMDogFitnesss, DMCount + 1)
removeElementData(DMDogStrengths, DMCount + 1)
removeElementData(DMDogGenders, DMCount + 1)
end

--SPAWN
function DMSpawnDog(DMClientDogRace, DMClientDogFitness)
local x,y,z = getElementPosition(client)
local DMDog = createPed (DMClientDogRace , x , y + 1, z, 0, true )
setPedAnimation( DMDog, "INT_OFFICE", "OFF_Sit_Crash")

local DMOwnerName = getPlayerName(client)
for variable = 1, DMCount, 1 do
	local DMOwner = getElementData(DMOwners, variable)
    if(DMOwner == DMOwnerName)then
    setElementData(DMDogActive, variable, DMDog)
	end
end

triggerClientEvent(client, "DMSpawnDogBack", getRootElement(), DMDog)
end

function DMDespawnDog(DMClientDog)
destroyElement(DMClientDog)
local DMOwnerName = getPlayerName(client)
for variable = 1, DMCount, 1 do
	local DMOwner = getElementData(DMOwners, variable)
    if(DMOwner == DMOwnerName)then
    setElementData(DMDogActive, variable, DMNotActive)
	end
end
end

--CAR
function DMOwnerCar(DMPlayerInVehicle, DMClientDog, DMx, DMy, DMz, DMVehicle, DMSeat)
if(DMPlayerInVehicle == true)then
if(DMSeat == 0)then
setElementInterior(DMClientDog, 21, 0, 0 , 0)
else
warpPedIntoVehicle ( DMClientDog, DMVehicle, DMSeat)
setPedAnimation( DMClientDog, "LOWRIDER", "lrgirl_l1_loop")
end
elseif(DMPlayerInVehicle == false)then
removePedFromVehicle (DMClientDog)
setElementInterior(DMClientDog, 0, DMx, DMy + 3, DMz)
end
end

--FEED DOG
function DMFeedDog()
local DMPlayerFinalRotation
local DMPlayerx, DMPlayery, DMPlayerz = getElementPosition(client)

DMDogBowl = createObject(1510,DMPlayerx + 0.5,DMPlayery,DMPlayerz - 0.9)
setElementRotation(client, 0,0, 270)
setPedAnimation(client, "ped", "WEAPON_crouch")
end

function DMFeedDogFinished(DMStopFeedAnimation)
if(DMStopFeedAnimation == true)then
setPedAnimation(client)
end
destroyElement(DMDogBowl)
end

--DOG STATES
function DMDogActionFollow(DMDogFinalRotation, DMDogDistanceAnimation, DMDogDistanceAnimationChange, DMClientDog, DMDogRescueTeleport, DMDogFollow)
if(DMClientDog ~= nil)then
setElementRotation(DMClientDog, 0, 0, -DMDogFinalRotation, default, true)
end
if(DMDogRescueTeleport == false) then
if(DMDogDistanceAnimationChange == true)then
  if(DMDogDistanceAnimation == 1)then
  setPedAnimation( DMClientDog, "ped", "factalk")
  if(DMDogFollow == 3)then
   setPedAnimation(client)
   triggerClientEvent(client, "DMFeedDogBack", getRootElement())
  end
  elseif(DMDogDistanceAnimation == 2)then
  setPedAnimation( DMClientDog, "ped", "WALK_civi")
  elseif(DMDogDistanceAnimation == 3)then
  setPedAnimation( DMClientDog, "ped", "run_csaw")
  elseif(DMDogDistanceAnimation == 4)then
  setPedAnimation( DMClientDog, "ped", "sprint_civi")
  end
end
else
local x,y,z = getElementPosition(client)
setElementPosition( DMClientDog, x + 5, y, z)
end
end

function DMDogActionIdle(DMClientDog)
setPedAnimation( DMClientDog, "INT_OFFICE", "OFF_Sit_Crash")
end

function DMDogActionAttack(DMDogFinalRotation, DMDogDistanceAnimation, DMDogDistanceAnimationChange, DMClientDog, DMDogRescueTeleport, DMAttackPerson, DMAttackCount, DMClientDogStrength, DMStopAttack, DMDogAttack)
if(DMStopAttack == true)then
triggerClientEvent(client, "DMDogActionAttackStop", getRootElement())
end

if(DMClientDog ~= nil)then
setElementRotation(DMClientDog, 0, 0, -DMDogFinalRotation, default, true)
end
if(DMDogRescueTeleport == false) then
if(DMDogDistanceAnimationChange == true)then
  if(DMDogDistanceAnimation == 1)then
  setPedAnimation( DMClientDog, "ped", "HIT_behind")
  elseif(DMDogDistanceAnimation == 2)then
  setPedAnimation( DMClientDog, "ped", "run_csaw")
  elseif(DMDogDistanceAnimation == 3)then
  setPedAnimation( DMClientDog, "ped", "sprint_civi")
  end
end
else
local x,y,z = getElementPosition(client)
setElementPosition( DMClientDog, x + 5, y, z)
end

if(DMDogDistanceAnimation == 1)then
if(DMAttackCount == 1)then
local DMDogDamage = (getElementHealth(DMAttackPerson) - (5 + DMClientDogStrength * 0.05))
setElementHealth(DMAttackPerson, DMDogDamage)
end
end

if(DMAttackPerson ~= nil)then
if(DMDogAttack == 1)then
if(isPedDead(DMAttackPerson))then
triggerClientEvent(client, "DMDogActionAttackStop", getRootElement())
end
elseif(DMDogAttack == 2)then
if(getElementHealth(DMAttackPerson) <= 0)then
triggerClientEvent(client, "DMDogFightWin", getRootElement())
end
if(getElementHealth(DMClientDog) <= 0)then
triggerClientEvent(client, "DMDogFightLose", getRootElement())
end
end
end
end

function DMCheckAttackAttacker(DMAttacker)
local DMVictim = client
triggerClientEvent(DMAttacker, "DMCheckAttackAttacker", getRootElement(), DMVictim)
end

--SOUNDS
function DMAttackSound(DMAttacker, DMClientDog)
local DMTriggerPerson = DMAttacker
local DMTriggerDog = DMClientDog
triggerClientEvent(DMTriggerPerson, "DMAttackSoundBack", getRootElement(), DMTriggerDog)
end

function DMAttackSoundStop(DMAttacker)
local DMTriggerPerson = DMAttacker
triggerClientEvent(DMTriggerPerson, "DMAttackSoundStopBack", getRootElement())
end

function DMGuardSound(DMGuardPlayerFound, DMClientDog)
local DMTriggerPerson = DMGuardPlayerFound
local DMTriggerDog = DMClientDog
triggerClientEvent(DMTriggerPerson, "DMAttackSoundBack", getRootElement(), DMTriggerDog)
end

function DMGuardSoundStop(DMGuardPlayerFound)
local DMTriggerPerson = DMGuardPlayerFound
triggerClientEvent(DMTriggerPerson, "DMAttackSoundStopBack", getRootElement())
end

--TASK GUARD
function DMDogActionGuard(DMDogFinalRotation, DMDogDistanceAnimation, DMDogDistanceAnimationChange, DMClientDog, DMDogRescueTeleport, DMAttackCount, DMGuardPlayerFound, DMClientDogStrength)
if(DMClientDog ~= nil)then
setElementRotation(DMClientDog, 0, 0, -DMDogFinalRotation, default, true)
end
if(DMDogRescueTeleport == false) then
if(DMDogDistanceAnimationChange == true)then
  if(DMDogDistanceAnimation == 1)then
  setPedAnimation( DMClientDog, "ped", "HIT_behind")
  elseif(DMDogDistanceAnimation == 2)then
  setPedAnimation( DMClientDog, "ped", "WALK_civi")
  elseif(DMDogDistanceAnimation == 3)then
  setPedAnimation( DMClientDog, "ped", "run_csaw")
  elseif(DMDogDistanceAnimation == 4)then
  setPedAnimation( DMClientDog, "ped", "sprint_civi")
  end
end
else
local x,y,z = getElementPosition(client)
setElementPosition( DMClientDog, x + 5, y, z)
end

if(DMDogDistanceAnimation == 1)then
if(DMAttackCount == 1)then
local DMDogDamage = (getElementHealth(DMGuardPlayerFound) - (5 + DMClientDogStrength * 0.05))
setElementHealth(DMGuardPlayerFound, DMDogDamage)
end
end
end

--TASK DOGFIGHT
function DMDogFightRequest(DMDogFightPlayer, DMClientDog)
local RequestPlayer = client
local DMRequestDog = DMClientDog
triggerClientEvent(DMDogFightPlayer, "DMDogFightRequestBack", getRootElement(), RequestPlayer, DMRequestDog)
end

function DMDogFightRequestFailed(RequestPlayer, DMRequestError)
local DMOpponent = client
triggerClientEvent(RequestPlayer, "DMDogFightRequestFailed", getRootElement(), DMOpponent, DMRequestError)
end

function DMDogFightRequestSent(RequestPlayer)
triggerClientEvent(RequestPlayer, "DMDogFightRequestSent", getRootElement())
end

function DMDogFightRequestDecilned(RequestPlayer)
triggerClientEvent(RequestPlayer, "DMDogFightRequestDecilnedBack", getRootElement())
end

function DMDogsFightStart(RequestPlayer, DMClientDog)
local DMRequestDog = DMClientDog
triggerClientEvent(RequestPlayer, "DMDogsFightStartBack", getRootElement(), DMRequestDog)
end

function DMDogsFightGiveUp(DMTriggerPlayer)
local RequestPlayer = client
local TriggerPlayer = DMTriggerPlayer
triggerClientEvent(TriggerPlayer, "DMDogsFightGiveUpBack", getRootElement(), RequestPlayer)
end

--TRICKS
function DMDoTrick(DMDogTrick, DMDogStatus, DMClientDog, DMTrickLength)
if(DMDogTrick == 1)then
setPedAnimation( DMClientDog, "INT_OFFICE", "OFF_Sit_Crash")
elseif(DMDogTrick == 2)then
setPedAnimation(DMClientDog, "BIKES", "BIKEs_Ride")
elseif(DMDogTrick == 3)then
setPedAnimation(DMClientDog, "ped", "abseil")
elseif(DMDogTrick == 4)then
setPedAnimation(DMClientDog, "BSKTBALL", "BBALL_Jump_Shot")
elseif(DMDogTrick == 5)then
setPedAnimation(DMClientDog, "ped", "Crouch_Roll_R")
elseif(DMDogTrick == 6)then
setPedAnimation(DMClientDog, "ped", "Crouch_Roll_L")
elseif(DMDogTrick == 7)then
setPedAnimation(DMClientDog, "BIKED", "BIKEd_kick")
elseif(DMDogTrick == 8)then
setPedAnimation(DMClientDog, "BIKED", "BIKEd_pushes")
end

setTimer(function()
if(DMDogStatus == 1)then
setPedAnimation( DMClientDog, "INT_OFFICE", "OFF_Sit_Crash")
elseif(DMDogStatus == 2 or DMDogStatus == 3)then
setPedAnimation(DMClientDog)
end
end, DMTrickLength, 1)
end

--POSITION
function DMSyncPosition(DMClientDog,Dogx, Dogy, Dogz)
if(Dogx ~= nil and DMClientDog ~= nil)then
setElementPosition(DMClientDog,Dogx,Dogy,Dogz)
end
end

--WASTED
function DMDogWasted(DMClientDog, DMNewHealth)
if(DMNewHealth > 0)then
setElementHealth(DMClientDog, DMNewHealth)
else
setElementHealth(DMClientDog, 0)
end
end

--.Handler.--

addEventHandler("onResourceStart", getResourceRootElement(getThisResource()), 
function()
 	 DMDatabasestart()
	 DMDataBaseLoadDogs()
end)

addEventHandler("onResourceStop", getResourceRootElement(getThisResource()), 
function()
 	 DMDatabaseSave()
end)

addEventHandler ( "onPlayerQuit", getRootElement(), function()
local DMOwnerName = getPlayerName(source)
local DMDog

for variable = 1, DMCount, 1 do
	local DMOwner = getElementData(DMOwners, variable)
    if(DMOwner == DMOwnerName)then
    DMDog = getElementData(DMDogActive, variable)
	setElementData(DMDogActive, variable, DMNotActive)
	end
end


if(getElementType (DMDog) == "ped")then
destroyElement(DMDog)
end
end)

addEvent("DMCheckOwner", true)
addEventHandler("DMCheckOwner", getRootElement(), DMCheckOwner)

addEvent("DMCreateDogSubmit", true)
addEventHandler("DMCreateDogSubmit", getRootElement(), DMCreateDogSubmit)

addEvent("DMSpawnDog", true)
addEventHandler("DMSpawnDog", getRootElement(), DMSpawnDog)

addEvent("DMDespawnDog", true)
addEventHandler("DMDespawnDog", getRootElement(), DMDespawnDog)

addEvent("DMDogActionFollow", true)
addEventHandler("DMDogActionFollow", getRootElement(), DMDogActionFollow)

addEvent("DMDogActionIdle", true)
addEventHandler("DMDogActionIdle", getRootElement(), DMDogActionIdle)

addEvent("DMDogActionAttack", true)
addEventHandler("DMDogActionAttack", getRootElement(), DMDogActionAttack)

addEvent("DMDogActionGuard", true)
addEventHandler("DMDogActionGuard", getRootElement(), DMDogActionGuard)

addEvent("DMCheckAttackAttacker", true)
addEventHandler("DMCheckAttackAttacker", getRootElement(), DMCheckAttackAttacker)

addEvent("DMOwnerCar", true)
addEventHandler("DMOwnerCar", getRootElement(), DMOwnerCar)

addEvent("DMFeedDog", true)
addEventHandler("DMFeedDog", getRootElement(), DMFeedDog)

addEvent("DMFeedDogFinished", true)
addEventHandler("DMFeedDogFinished", getRootElement(), DMFeedDogFinished)

addEvent("DMSaveStatFitness", true)
addEventHandler("DMSaveStatFitness", getRootElement(), DMSaveStatFitness)

addEvent("DMSaveStatStrength", true)
addEventHandler("DMSaveStatStrength", getRootElement(), DMSaveStatStrength)

addEvent("DMDeleteDogNoSpawn", true)
addEventHandler("DMDeleteDogNoSpawn", getRootElement(), DMDeleteDog)

addEvent("DMDeleteDog", true)
addEventHandler("DMDeleteDog", getRootElement(), DMDeleteDog)

addEvent("DMDogWasted", true)
addEventHandler("DMDogWasted", getRootElement(), DMDogWasted)

addEvent("DMSyncPosition", true)
addEventHandler("DMSyncPosition", getRootElement(), DMSyncPosition)

addEvent("DMDoTrick", true)
addEventHandler("DMDoTrick", getRootElement(), DMDoTrick)

addEvent("DMDogFightRequest", true)
addEventHandler("DMDogFightRequest", getRootElement(), DMDogFightRequest)

addEvent("DMDogFightRequestFailed", true)
addEventHandler("DMDogFightRequestFailed", getRootElement(), DMDogFightRequestFailed)

addEvent("DMDogFightRequestSent", true)
addEventHandler("DMDogFightRequestSent", getRootElement(), DMDogFightRequestSent)

addEvent("DMDogFightRequestDecilned", true)
addEventHandler("DMDogFightRequestDecilned", getRootElement(), DMDogFightRequestDecilned)

addEvent("DMDogsFightStart", true)
addEventHandler("DMDogsFightStart", getRootElement(), DMDogsFightStart)

addEvent("DMDogsFightGiveUp", true)
addEventHandler("DMDogsFightGiveUp", getRootElement(), DMDogsFightGiveUp)

addEvent("DMAttackSound", true)
addEventHandler("DMAttackSound", getRootElement(), DMAttackSound)

addEvent("DMAttackSoundStop", true)
addEventHandler("DMAttackSoundStop", getRootElement(), DMAttackSoundStop)

addEvent("DMGuardSound", true)
addEventHandler("DMGuardSound", getRootElement(), DMGuardSound)

addEvent("DMGuardSoundStop", true)
addEventHandler("DMGuardSoundStop", getRootElement(), DMGuardSoundStop)
