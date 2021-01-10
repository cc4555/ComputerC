local xPos, yPos, zPos = nil
local face = 1 
cal = false
sInput = nil
mineX = -1690
mineY = 12
mineZ = 4739

local cPosX = -1755
local cPosZ = 4752

local id = nil
local senderId, message, protocol = 253,nil,nil

leftOffX = nil
leftOffY = nil
leftOffZ = nil

rednet.open("right")

function calibrate() -- Calibrate the X Y and Z Position of the turtle
    print("received a message from master telling me to calibrate sender #"..senderId)
    sleep(1)
    rednet.send(253, "What is the ID of this turtle?")
    senderId, message, protocol = rednet.receive(10) --receives the id of the turtle
    print(message)
    id = message
    print("The id of this turtle is "..id)
    xPos, yPos, zPos = gps.locate() -- sets the location of where the turtle is from startup
    rednet.send(253, "Finished") -- sends Finished to the master
    print("Finished")
    cal = true
end

function setLocation() -- set the location if position is some how messed up
    xPos, yPos, zPos = gps.locate()
end

function pos() -- print out the position to check where the turtle is
    print("X:" ..xPos.. "  Y:" ..yPos.. "  Z:" ..zPos)
end

function facing() -- print out where the turtle is facing
    print("your facing" ..face)
end

function turnL() -- turns the turtle left and changes the facing variable
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

function turnR() -- turns the turtle right and changed the facing variable
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

function forward() -- moves the turtle forward and changes the Z or the X position
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

function back() -- moves the turtle backwards and changes the Z or the X position
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

function up() -- moves the turtle up by 1 and changes the Y position
    turtle.up()
    if cal == true then
        yPos = yPos + 1
    else
        print("Not Calibrated.")
        print("Calibrating")
        setLocation()
    end
end

function down() -- moves the turtle down by 1 and changes the Y position
    turtle.down()
    if cal == true then
        yPos = yPos - 1
    else
        print("Not Calibrated.")
        print("Calibrating")
        setLocation()
    end
end

function mine() -- tells the turtle to start mining in a 3 by 3
    turtle.dig()
    while turtle.detect() do
        turtle.dig()
    end
    forward()
    turtle.digUp()
    turtle.digDown()
    turnR()
    turtle.dig()
    while turtle.detect() do
        turtle.dig()
    end
    forward()
    turtle.digUp()
    turtle.digDown()
    turnL()
    turnL()
    forward()
    turtle.dig()
    while turtle.detect() do
        turtle.dig()
    end
    forward()
    turtle.digUp()
    turtle.digDown()
    turnR()
    turnR()
    forward()
    turnL()
end


function goMine() -- tells the turtle to move from the base position to the mine to start mining
    print("Going to the mine.")

    if cal == false then
        print("Not Calibrated.")
        print("Calibrating")
        setLocation()
    end

    up()

    if zPos > mineZ then
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
        for i=2, amount do
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

    if zPos < mineZ then
        print("You are on the right side of the mine")
        turnL()
        amount = mineZ - zPos
        for i=1, amount do
            forward()
        end

        print("You are moving to the mine")
        setLocation()
        turnR()
        amount = xPos - mineX
        for i=1, amount do
            forward()
        end

        print("You are now moving down into the mine")
        amount = yPos - mineY
        for i=1, amount-1 do
            down()
        end

        print("Which side of the mine are you going into id#"..id)
        setLocation()
        if id == "1" then -- if the id is 1
            print("Side 1")
            amount = xPos - cPosX
            for i=1, amount do
                forward()
            end

            for i=1, 10 do
                mine()
            end
        elseif id == "2" then -- if the id is 2
            print("Side 2")
            turnR()
            amount = zPos - cPosZ
            for i=1, amount do
                forward()
            end

            for i=1, 10 do
                mine()
            end
        elseif id == "3" then -- if the id is 3
            print("Side 3")
            turnR()
            turnR()
            amount = cPosX - xPos
            for i=1, amount do
                forward()
            end

            for i=1, 10 do
                mine()
            end
        elseif id == "4" then -- if the id is 4
            print("Side 4")
            turnL()
            amount = cPosZ - zPos
            for i=1, amount do
                forward()
            end

            for i=1, 10 do
                mine()
            end
        end
    end
end

    senderId, message, protocol = rednet.receive(10)


    if message == "calibrate" then
        calibrate()
    end

