local args = {...}

if args[1] == nil then
    print("Usage: minerlayer <up/down> [Repeat Amount (optional)]")
    return
end

function reset()
turn1 = 0
RX = 0
RZ = 0
done2 = false
end

reset()

function rs()
    if args[1] == "up" then
        turtle.digUp()
    end
    if args[1] == "down" then
        turtle.digDown()
    end
end

function turn()
    if (turn1 % 2 == 0) then
        turtle.turnRight()
        if turtle.inspect() == true then
            done2 = true
        end
        turtle.forward()
        turtle.turnRight()
    else
        turtle.turnLeft()
        if turtle.inspect() == true then
            done2 = true
        end
        turtle.forward()
        turtle.turnLeft()
    end
    turn1 = turn1+1
    RZ = RZ+1
end

function insD()
    if args[1] == "down" then
        if turtle.inspectDown() then
            X1, X2 = turtle.inspectDown()
            return X2
        end
    else
        if turtle.inspectUp() then
            X1, X2 = turtle.inspectUp()
            return X2
        end
    end
end

function insfix()
    if args[1] == "down" then
        X1, X2 = turtle.inspectDown()
    else
        X1, X2 = turtle.inspectUp()
    end
    return X1, X2
end

function start()
    rs()
    repeat
        repeat
            turtle.forward()
            if (turn1 % 2 == 0) then
                RX = RX+1
            else
                RX = RX-1
            end
            rs()
        until turtle.inspect() == true
        turn()
        if done2 == true then break end
        rs()
    until turtle.inspect() == true or done2 == true
    print("Done!")

    turtle.turnRight()
    i1 = 0
    repeat
        turtle.forward()
        i1 = i1+1
    until i1 == RZ

    turtle.turnRight()

    if RX ~= 0 then
    i2 = 0
    repeat
        turtle.back()
        i2 = i2+1
    until i2 == RX
    end

    print("Layer Mining Done!")
end

function tonumber1(x)
    if x ~= nil then
        return tonumber(x)
    else
        return 1
    end
end

count1 = 0

repeat
    if count1 ~= tonumber1(args[2]) then
        start()
        count1 = count1+1
        print(count1.."/"..tonumber1(args[2]))
    else
        break
    end
    if args[2] ~= nil then
        if tonumber(args[2]) > 1 then
            reset()
            if args[1] == "up" then
                turtle.up()
            else
                turtle.down()
            end
            restart = true
        end
    else
        restart = false
    end
until restart == false
