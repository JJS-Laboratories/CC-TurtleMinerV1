local args = {...}

local length = tonumber(args[1])
local height = tonumber(args[2])
local width = tonumber(args[3])


print("Tunnel Miner started!")
print("Parameters:")
print("Length(down):"..length)
print("Height(U/D):"..height)
print("Width:(L/R)"..width)

i = 0
repeat
    i = i+1
    turtle.digDown()
    turtle.down()
    if width > 1 then
        turtle.turnRight()
        turtle.dig()
        turtle.turnLeft()
    end
    if width > 2 then
        turtle.turnLeft()
        turtle.dig()
        turtle.turnRight()
    end
    if height > 1 then
        turtle.dig()
        if width > 1 then
            turtle.forward()
            turtle.turnRight()
            turtle.dig()
            turtle.turnLeft()
            if width > 2 then
                turtle.turnLeft()
                turtle.dig()
                turtle.turnRight()
            end
            turtle.back()
        end
    end
    if height > 2 then
        turtle.turnRight()
        turtle.turnRight()
        turtle.dig()
        if width > 1 then
            turtle.forward()
            turtle.turnLeft()
            turtle.dig()
            turtle.turnRight()
            if width > 2 then
                turtle.turnRight()
                turtle.dig()
                turtle.turnLeft()
            end
            turtle.back()
        end
        turtle.turnLeft()
        turtle.turnLeft()
    end
until i == length
i1 = 0
if turtle.getItemDetail(15) ~= nil then
    if turtle.getItemDetail(15)["name"] == "minecraft:water_bucket" then
        turtle.select(15)
        turtle.up()
        turtle.placeDown()
        i1 = 1
    end
end

repeat
    turtle.up()
    i1 = i1+1
until i1 == length

turtle.back()
if height > 2 then
    turtle.back()
end

