local args = {...}

local length = tonumber(args[1])
local height = tonumber(args[2])
local width = tonumber(args[3])


print("Tunnel Miner started!")
print("Parameters:")
print("Length:"..length)
print("Height:"..height)
print("Width:"..width)

os.sleep(0.25)

i = 0
repeat
    i = i+1
    turtle.dig()
    turtle.forward()
    turtle.digUp()
    if height == 3 then
        turtle.digDown()
    end
    if width > 1 then
        if width > 1 then
            turtle.turnRight()
            turtle.dig()
            turtle.forward()
            turtle.digUp()
            if height == 3 then
                turtle.digDown()
            end
            turtle.back()
            turtle.turnLeft()
        end
        if width > 2 then
            turtle.turnLeft()
            turtle.dig()
            turtle.forward()
            turtle.digUp()
            if height == 3 then
                turtle.digDown()
            end
            turtle.back()
            turtle.turnRight()
        end
    end
until i == length

i1 = 0
repeat
    turtle.back()
    i1 = i1+1
until i1 == length

turtle.down()