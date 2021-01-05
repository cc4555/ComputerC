local xPos, yPos, zPos = nil
face = 1
cal = false
sInput = nil
mineX = -1691
mineY = 11
mineZ = 4739

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

function turnLeft()
    if face == 0 then
        face = 1
    elseif face == 1 then
        face = 2
    elseif face == 2 then
        face = 3
    elseif face == 3 then
        face = 0
    end
end

function turnRight()
    if face == 0 then
        face = 3
    elseif face == 1 then
        face = 0
    elseif face == 2 then
        face = 1
    elseif face == 3 then
        face = 2
    end
end

function forward()
    print("Turtle moving forward")
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
    getLocation()

    up()
    for i=1,29 do
        forward()
    end
    turnRight()
    for i=1,4 do
        forward()
    end
    for i=1,20 do
        down()
    end
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
    elseif sInput == "stop" then
        break
    end
end
