local args = {...}

if args[1] == nil then
    print("Usage: minerstair <up/down>")
    return
end

function start1()
    repeat
        turtle.up()
    until turtle.inspectUp()
end
function start2()
    turtle.digUp()
    turtle.up()
    turtle.digUp()
    turtle.up()
end
function start3()
    i = 0
    break1 = 0
    repeat
        turtle.digUp()
        turtle.dig()
        turtle.forward()
        turtle.digUp()
        turtle.placeDown()
        turtle.turnRight()
        turtle.up()
        if not turtle.inspectUp() then
            break1 = break1+1
        end
    until break1 > 2
end

function start1d()
    repeat
        turtle.down()
    until turtle.inspectDown()
end
function start2d()
    turtle.digDown()
    turtle.down()
    turtle.digDown()
    turtle.down()
end
function start3d()
    i = 0
    break1 = 0
    repeat
        turtle.digDown()
        turtle.dig()
        turtle.forward()
        turtle.digDown()
        turtle.turnRight()
        turtle.down()
        if not turtle.inspectDown() then
            break1 = break1+1
        end
    until break1 > 2
end

if args[1] == "up" then
    start1()
    start2()

    start3()
end
if args[1] == "down" then
    start1d()
    start2d()
    start3d()
    turtle.forward()
end