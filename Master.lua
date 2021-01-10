local senderId, message, protocol = nil

rednet.open("right")

while true do 
    sInput = read()

    if sInput == "calibrate" then
        print("What computer would you like to calibrate")
        sInput = read()
        if sInput == "1" then
            print("broadcasting to computer 226 (turtle 1)")
            senderId, message, protocol = rednet.receive(10)
            rednet.send(226, "calibrate") -- sends the turtle the calibrate command
            rednet.receive(10)
            rednet.send(226, sInput)
            rednet.receive(10)
            redbet.receive(10)

        elseif sInput == "2" then
            rednet.send(227, "calibrate")
        elseif sInput == "3" then
            rednet.send(228, "calibrate")
        elseif sInput == "4" then
            rednet.send(231, "calibrate")
        end
    end

    
end
