local xPos, yPos, zPos = nil
face = 1
cal = false
sInput = nil
mineX = -1690
mineY = 12
mineZ = 4739

leftOffX = nil
leftOffY = nil
leftOffZ = nil


function setLocation()
    print("Getting location")
    xPos, yPos, zPos = gps.locate()
    print("Location set")
    cal = true
end

function printLocation()
    if cal == true then
        print(xPos.." "..yPos.." "..zPos)
    else
        print("This miner needs to be calibrated")
    end
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
        turtle.turnLeft()
    elseif face == 3 then
        face = 0
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
    elseif face == 3 then
        face = 2
        turtle.turnRight()
    end
end

function forward()
    turtle.forward()
    if cal == true then
     if face == 0 then
      zPos = zPos - 1
     elseif face == 1 then
      xPos = xPos - 1
     elseif face == 2 then
      zPos = zPos + 1
     elseif face == 3 then
      xPos = xPos + 1
     end
    else
     print("Not Calibrated.")
    end
end

function back()
    turtle.back()
    if cal == true then
        if face == 0 then
            zPos = zPos + 1
        elseif face == 1 then
            xPos = xPos + 1
        elseif face == 2 then
            zPos = zPos - 1
        elseif face == 3 then
            xPos = xPos - 1
        end
    else
        print("Not Calibrated")
    end
end

function up()
    turtle.up()
    if cal == true then
        yPos = yPos + 1
    else
        print("Not Calibrated")
    end
end

function down()
    turtle.down()
    if cal == true then
        yPos = yPos - 1
    else
        print("Not Calibrated")
    end
end

function refuel()
    turtle.refuel()
end

function goMine()
    print("Going to the Mine")

    up()

    if zPos ~= mineZ then
        if zPos > mineZ then --if the turtle is on the left side of the mine

            turnR()

            amount = zPos - mineZ
            print("moving forward " ..amount)
            for i=1,amount do
                forward()
            end

            turnL()

            amount = mineZ - zPos
            print("moving forward " ..amount)
            for i=-20,amount do
                forward()
            end

            setLocation()

            if yPos ~= mineY then
                while yPos ~= mineY+1 do
                    down()
                    print(yPos)
                end
            end
        end

        if zPos < mineZ then --if the turtle is on the right side of the mine

            turnL()

            amount = mineZ - zPos
            print("moving forward " ..amount)
            for i=1,amount do
                forward()
            end

            turnR()

            amount = mineZ - zPos
            print("moving forward " ..amount)
            for i=-20, amount do
                forward()
            end

            setLocation()

            if yPos ~= mineY then
                while yPos ~= mineY do
                    down()
                end
            end

            xPos, yPos, zPos = gps.locate()
        end

        turnR()

        for i=0,5 do
            forward()
        end

        mine(5)

    end
end

function mine(length)
    for i=0,length do

        turtle.dig()
        if turtle.detect() then
            while turtle.detect() == true do
                turtle.dig()
            end
        end

        forward()
        turtle.digUp()
        turtle.digDown()
        turnL()

        turtle.dig()
        if turtle.detect() then
            while turtle.detect() == true do
                turtle.dig()
            end
        end

        forward()
        turtle.digDown()
        turtle.digUp()
        turnR()
        turnR()
        forward()

        turtle.dig()
        if turtle.detect() then
            while turtle.detect() == true do
                turtle.dig()
            end
        end
        forward()
        turtle.digDown()
        turtle.digUp()
        turnL()
        turnL()
        forward()
        turnR()
        xPos = xPos + 1
    end
end

function invCheck()
    for i=1,16 do
        turtle.getItemSpace(i)
        itemName = turtle.getItemDetail()
        itemCount = turtle.getItemCount()

        if turtle.getItemSpace(16) then
            if turtle.getItemCount() == 64 then
                goBack()
            end
        end
    end
end

function goBack()
    setLocation()
    leftOffX = xPos
    turnR()
    turnR()
    if xPos ~= mineX then
        while xPos ~= mineX do
            forward()
        end
    end
    
    for i=0,20 do
        up()
    end

    for i=0,18 do
        forward()
    end

    turnL()

    for i=0,20 do
        forward()
    end

    for i=0,16 do
        turtle.dropDown(i)
    end

    turnR()
    turnR()

end

while true do
    sInput = read()
    if sInput == "setLocation" or sInput == "set location" then
        setLocation()
    elseif sInput == "printLocation" or sInput == "print location" then
        printLocation()
    elseif sInput == "forward" then
        forward()
    elseif sInput == "refuel" then
        refuel()
    elseif sInput == "goMine" then
        goMine()
    elseif sInput == "mine" then
        sInput = tonumber(read())
        mine(sInput)
    elseif sInput == "invCheck" then
        invCheck()
    elseif sInput == "goBack" then
        goBack()
    elseif sInput == "stop" then
        break
    end
end
