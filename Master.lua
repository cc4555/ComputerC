rednet.open("right")

while true do 
    sInput = read()

    if sInput == "calibrate" then
        print("What computer would you like to calibrate")
        sInput = read()
        if sInput == "1" then
            rednet.broadcast(226, "calibrate")
        elseif sInput == "2" then
            rednet.broadcast(227, "calibrate")
        elseif sInput == "3" then
            rednet.broadcast(228, "calibrate")
        elseif sInput == "4" then
            rednet.broadcast(231, "calibrate")
        end
    end
end
