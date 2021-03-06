local senderId, message, protocol = nil

rednet.open("right")

while true do
    sInput = read()

    if sInput == "calibrate" then
        print("What turtle would you like to calibrate?")
        sInput = read()
        if sInput == "1" then
            print("Sending to turtle 1")
            rednet.send(226, "calibrate") -- sends the turtle the calibrate command
            senderId, message, protocol = rednet.receive()
            print(message)
            sInput = read()
            rednet.send(226, sInput) -- sends the id of the turtle
            senderId, message, protocol = rednet.receive()
            print(message)

        elseif sInput == "2" then
            rednet.send(227, "calibrate")
        elseif sInput == "3" then
            rednet.send(228, "calibrate")
        elseif sInput == "4" then
            rednet.send(231, "calibrate")
        end
    elseif sInput == "goMine" then
        rednet.send(226, "goMine")
        rednet.receive()
    end

end
