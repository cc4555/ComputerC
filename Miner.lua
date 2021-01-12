-- The location the turtle is at and the direction the turtle is facing
local zPos, yPos, zPos = nil
local face = 1

-- Where was the the last position that the turtle was left off at
local northC = nil
local southC = nil
local westC = nil
local eastC = nil

-- The id of the turtle and the master computer information
local id = nil -- 1 = west 2 = north 3 = east 4 = south
local senderId, message, protocol = 253,nil,nil

-- Other variables cal (Calibrated) sInput (Input from the user in the turtle)
-- mine (The location of the mine) base (The location where the turtle started off at)
cal = false
sInput = nil
mineX = -1690
mineY = 12
mineZ = 4739

baseX = nil
baseY = nil
baseZ = nil

rednet.open("right") -- opening the rednet port to allow comunication for turtle and master computer

function calibrate() -- Calibrate the X Y and Z Position of the turtle and set the base location
    print("Received the message to calibrate from the master computer")
    sleep(1)
    rednet.send(senderId, "What is the ID of this turtle?")
    senderId, message, protocol = rednet.receive() -- receives the id of the turtle
    print(message)
    id = message
    print("The id of this turtle is " ..id)
    xPos, yPos, zPos = gps.locate() -- sets the location of where the turtle is from startup
    baseX, baseY, baseZ = gps.locate() -- set the base location to allow the turtle to come back
    rednet.send(senderId, "Finished the calibration and set the base location")
    print("Finished the calibration and set the base location")
    cal = true
end

function pos() -- prints out the position of the turtle
    print("X: " ..xPos.. " Y: " ..yPos.. " Z: " ..zPos)
end

function facing() -- print out where the turtle is facing
    print("The Turtle is facing " ..face)
end

function turnL() -- turns the turtle left and changes the facing variable
    if face == 0 then
        face = 1
        turtle.turnLeft()
    elseif face == 1 then
        face =2
        turtle.turnLeft()
    elseif face == 2 then
        face = 3
        turtle.turnLeft()
    elseif face == 3 then
        face = 4
        turtle.turnLeft()
    end
end

function turnR() -- turns the turtle right and changes the facing varible
    if face == 0 then
        face = 3
        turtle.turnRight()
    elseif face == 1 then
        face = 0
        turtle.turnRight()
    elseif face == 2 then
        face = 1
        turtle.turnRight()
    elseif face == 3 then
        face = 2
        turtle.turnRight()
    end
end

function forward() -- moves the turtle forward and changes the Z or the X position
    if cal == true then
        turtle.forward()
        if face == 0 then
            zPos = zPos + 1
        elseif face == 1 then
            xPos = xPos - 1
        elseif face == 2 then
            zPos = zPos - 1
        elseif face == 3 then
            xPos = zPos - 1
        end
    elseif cal == false then
        print("Please calibrate the turtle")
        rednet.send(senderId, "Please calibrate the turtle")
    end
end

function back() -- moves the turtle backwards and changes the Z or the X position
    if cal == true then
        turtle.back()
        if face == 0 then
            zPos = zPos - 1
        elseif face == 1 then
            xPos = xPos + 1
        elseif face == 2 then
            zPos = zPos + 1
        elseif face == 3 then
            xPos = xPos -1
        end
    elseif cal == false then
        print("Please calibrate the turtle")
        rednet.send(senderId, "Please calibrate the turtle")
    end
end

function up() -- moves the turtle up and changes the Y position
    if cal == true then
        turtle.up()
        yPos = yPos + 1
    else
        print("Please calibrate the turtle")
        rednet.send(senderId, "Please calibrate the turtle")
    end
end

function down() -- moves the turtle down and changes the Y position
    if cal == true then
        turtle.down()
        yPos = yPos - 1
    else
        print("Please calibrate the turtle")
        rednet.send(snederId, "Please calibrate the turtle")
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

function goMine() -- tells the turle to move from the base position to the mine to start mining
    print("Going to the mine.")

    if cal == false then
        calibrate()
    end

    up()

    if zPos > mineZ then
        turnR()
        amount = zPos - mineZ
        for i=1, amount do
            forward()
        end

        turnL()
        amount = xPos - mineX
        amount = amount
        for i=1, amount do
            forward()
        end

        amount = yPos - mineY
        for i=1, amount-1 do
            down()
        end

        if id == "1" then -- if the id is 1 the turtle picks west
            print("Going West")
            rednet.send(senderId, "Going West")
            amount = xPos - westC
            for i=1, amount do
                foward()
            end

            for i=1, 10 do
                mine()
            end
        elseif id == "2" then -- if the id is 2 the turtle picks north
            print("Going North")
            rednet.send(senderId, "Going North")
            amount = zPos - northC
            for i=1, amount do
                forward()
            end 

            for i=1, 10 do
                mine()
            end
        elseif id == "3" then -- if the id is 3 the turtle picks east
            print("Going West")
            rednet.send(senderId, "Going West")
            amount = eastC - xPos
            for i=1, amount do
                forward()
            end

            for i=1, 10 do
                mine()
            end
        elseif id == "4" then -- if the id is 4 the turtle picks south
            print("Going South")
            rednet.send(senderId, "Going South")
            amount = southC - zPos
            for i=1, amount do
                forward()
            end

            for i=1, 10 do
                mine()
            end
        end
    end
end

senderId, message, protocol = rednet.receive(10) -- wait for the message to be sent from the master computer

if message == "goMine" then
    goMine()
elseif message == "calibrate" then
    calibrate()
end
