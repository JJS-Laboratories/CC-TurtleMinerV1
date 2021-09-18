local args = {...}

if args[1] == nil then
    print("Usage: minertunnel <length> <height(2-3)> <width(1-3)> <bridge (true/false)>")
    return
end

function search()
    print("Initalizing search for blocks")
    slot1 = 1
    done1 = false
    repeat
        print("Searching slot "..slot1)
        if turtle.getItemDetail(slot1) ~= nil then
            turtle.select(slot1)
            turtle.transferTo(1)
            turtle.select(1)
            break
        else
            slot1 = slot1+1
        end
        if slot1 == 16 and turtle.getItemDetail(16) == nil then
            os.sleep(2)
            textutils.slowPrint("Not found.. rebooting")
            os.reboot()
        end
    until done1 == true
end

local length = tonumber(args[1])
local height = tonumber(args[2])
local width = tonumber(args[3])
local bridge1 = args[4]


print("Tunnel Miner started!")
print("Parameters:")
print("Length:"..length)
print("Height:"..height)
print("Width:"..width)
print("Bridge:"..bridge1)

os.sleep(0.25)

i = 0
repeat
    i = i+1
    turtle.dig()
    turtle.forward()
    if bridge1 == "true" and height < 3 then
        if turtle.getItemDetail() == nil then
            search()
            turtle.placeDown()
        else
            turtle.placeDown()
        end
    end
    turtle.digUp()
    if height == 3 then
        turtle.digDown()
        if bridge1 == "true" then
            turtle.down()
            if turtle.getItemDetail() == nil then
                search()
                turtle.placeDown()
            else
                turtle.placeDown()
            end
            turtle.up()
        end
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
end
