DICE_OBJ_MODEL= 1851
DICE_DISTANCE = 1.0             -- distance of dice from the player
DICE_SCALE = 1.6                -- how huge the dice is
DICE_ONE_CYCLE_TIME = 1000
DICE_CYCLES = 3
DICE_VIEW_RESULT_TIME = 2000    -- how long you see the stopped dice

g_dice_table = {}

function resourceStart()
    local ver = getResourceInfo(getThisResource(), "version")

    math.randomseed(getTickCount())

end
addEventHandler("onResourceStart", resourceRoot, resourceStart)

function diceCmd(client, cmd)
    if isPedInVehicle(client) then
        return
    end

    if not isPedOnGround(client) then
        return nil
    end

    -- don't create a new dice while the previous exists
    if g_dice_table[client] ~= nil then
        return
    end

    -- create dice object if it not created yet
    local x,y,z = getElementPosition(client)
    local rx, ry, rz = getElementRotation(client)
    local xv, yv = getPointFromDistanceRotation(x, y, DICE_DISTANCE, rz)

    local rx = math.random(0, 360)
    local ry = math.random(0, 360)
    local rz = math.random(0, 360)
    local dice_obj = createObject(DICE_OBJ_MODEL, xv, yv, z-0.5, rx, ry, rz)
    setObjectScale(dice_obj, DICE_SCALE)

    g_dice_table[client] = dice_obj

    rotateDice(dice_obj, DICE_CYCLES, client)
end
addCommandHandler("dice", diceCmd, false)

function getPointFromDistanceRotation(x, y, dist, angle)
    local a = math.rad(angle + 90)
    local dx = math.cos(a) * dist
    local dy = math.sin(a) * dist
    return x+dx, y+dy
end

function rotateDice(dice_obj, number_to_execute, player)

    local x,y,z = getElementPosition(dice_obj)
    local rx, ry, rz = getElementRotation(dice_obj)

    if number_to_execute > 0 then
        rx = rx + math.random(0, 180)
        ry = ry + math.random(0, 180)
        rz = rz + math.random(0, 180)

        moveObject(dice_obj, DICE_ONE_CYCLE_TIME, x, y, z, rx, ry, rz, "Linear")
        number_to_execute = number_to_execute - 1
        setTimer(rotateDice, DICE_ONE_CYCLE_TIME, 1, dice_obj, number_to_execute, player)
    else
        -- Here we start the last cycle where we should align dice on axis.
        -- Calculate the right angels:
        local cur_x_part = rx / 90
        local round_x = math.floor(cur_x_part + 0.5)
        local dst_rx = round_x * 90
        local drx = dst_rx - rx

        local cur_y_part = ry / 90
        local round_y = math.floor(cur_y_part + 0.5)
        local dst_ry = round_y * 90
        local dry = dst_ry - ry

        local cur_z_part = rz / 90
        local round_z = math.floor(cur_z_part + 0.5)
        local dst_rz = round_z * 90
        local drz = dst_rz - rz

        moveObject(dice_obj, DICE_ONE_CYCLE_TIME, x, y, z, drx, dry, drz, "Linear")
        setTimer(destroyDice, DICE_ONE_CYCLE_TIME + DICE_VIEW_RESULT_TIME, 1, dice_obj, player)
    end
end

function destroyDice(dice_obj, player)
    destroyElement(dice_obj)
    g_dice_table[player] = nil
end
