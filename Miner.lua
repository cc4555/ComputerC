local xPos, yPos, zPos = nil
local face = 1 
cal = false
sInput = nil
mineX = -1690
mineY = 12
mineZ = 4739

local cPosX = -1751

leftOffX = nil
leftOffY = nil
leftOffZ = nil

function calibrate()
    print("Calibrating")
    xPos, yPos, zPos = gps.locate()
    print("Finished")
    cal = true
end

function setLocation()
    xPos, yPos, zPos = gps.locate()
end

function pos()
    print("X:" ..xPos.. "  Y:" ..yPos.. "  Z:" ..zPos)
end

function facing()
    print("your facing" ..face)
end

function turnL()
    if face == 0 then
        face = 1
        turtle.turnLeft()
    elseif face == 1 then
        face = 2
        turtle.turnLeft()
    elseif face == 2 then
        face = 3
        turle.turnLeft()
    elseif face == 3 then
        face = 4
        turtle.turnLeft()
    end
end

function turnR()
    if face == 0 then
        face = 3
        turtle.turnRight()
    elseif face == 1 then
        face = 0
        turtle.turnRight()
    elseif face == 2 then
        face = 1
        turtle.turnRight()
    elseif fasce == 3 then
        face = 2
        turtle.turnRight()
    end
end

function forward()
    turtle.forward()
    if cal == true then
        if face == 0 then
            zPos = zPos + 1
        elseif face == 1 then
            xPos = xPos - 1
        elseif face == 2 then
            zPos = zPos - 1
        elseif face == 3 then
            xPos = xPos + 1
        end
    else
        print("Not Calibrated.")
        print("Calibrating")
        setLocation()
    end
end

function back()
    turtle.back()
    if cal == true then
        if face == 0 then
            zPos = zPos - 1
        elseif face == 1 then
            xPos = xPos + 1
        elseif face == 2 then
            zPos = zPos + 1
        elseif face == 3 then
            xPos = xPos - 1
        end
    else
        print("Not Calibrated.")
        print("Calibrating")
        setLocation()
    end
end

function up()
    turtle.up()
    if cal == true then
        yPos = yPos + 1
    else
        print("Not Calibrated.")
        print("Calibrating")
        setLocation()
    end
end

function down()
    turtle.down()
    if cal == true then
        yPos = yPos - 1
    else
        print("Not Calibrated.")
        print("Calibrating")
        setLocation()
    end
end

function continue()
end

function mine()
    turtle.dig()
    while turtle.detect() do
        turtle.dig()
    end
    forward()
    turtle.digUp()
    turtle.digDown()
    turnR()
    turtle.dig()
    forward()
    turtle.digUp()
    turtle.digDown()
    turnL()
    turnL()
    forward()
    turtle.dig()
    forward()
    turtle.digUp()
    turtle.digDown()
end


function goMine()
    print("Going to the mine.")

    if cal == false then
        print("Not Calibrated.")
        print("Calibrating")
        setLocation()
    end

    up()

    if zPos ~= mineZ then
        turnR()
        amount = zPos - mineZ
        for i=1, amount do
            forward()
            print(zPos)
        end
        
        setLocation()
        turnL()
        amount = xPos - mineX
        amount = amount - amount + amount
        for i=1, amount do
            forward()
        end

        amount = yPos - mineY
        for i=1, amount-1 do
            down()
        end
        
        setLocation()

        amount = xPos - cPosX
        for i=1, amount do
            forward()
        end

        for i=1, 10 do
            mine()
        end

    end
end

while true do
    sInput = read()

    if sInput == "calibrate" then
        calibrate()
    elseif sInput == "goMine" then
        goMine()
    elseif sInput == "face" then
        facing()
    elseif sInput == "turnR" then
        turnR()
    elseif sInput == "turnL" then
        turnL()
    elseif sInput == "forward" then
        forward()
    elseif sInput == "back" then
        back()
    elseif sInput == "pos" then
        pos()
    elseif sInput == "mine" then
        mine()
    end
end
