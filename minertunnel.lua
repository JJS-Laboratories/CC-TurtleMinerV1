local args = {...}

if args[1] == nil then
    print("Usage: minertunnel <length> <height(2-3)> <width(1-3)>")
    return
end

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

print("Restart with same parameters? (to the right) (y/n)")

result = io.read()

if result == "y" then
    turtle.turnRight()
    turtle.up()
    turtle.forward()
    turtle.forward()
    turtle.forward()
    turtle.turnLeft()
    shell.run("minertunnel", args[1], args[2], args[3])
endturtle.down()