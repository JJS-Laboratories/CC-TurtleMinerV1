local args = {...}

if args[1] == nil then
    print("Usage: minerreplace <up/down>")
    return
end

turn1 = 0
RX = 0
RZ = 0
done2 = false
block1 = turtle.getItemDetail()["name"]

textutils.slowPrint("Selected block: "..block1)

function rs()
    if args[1] == "up" then
        turtle.digUp()
        turtle.placeUp()
    end
    if args[1] == "down" then
        turtle.digDown()
        turtle.placeDown()
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


function search()
    print("Initalizing search for: "..block1)
    slot1 = 1
    done1 = false
    repeat
        print("Searching slot "..slot1)
        if turtle.getItemDetail(slot1) ~= nil then
            if turtle.getItemDetail(slot1)["name"] == block1 then
                turtle.select(slot1)
                turtle.transferTo(1)
                turtle.select(1)
                break
            else
                slot1 = slot1+1
            end
        else
            slot1 = slot1+1
        end
        if slot1 == 16 and turtle.getItemDetail(16) == nil then
            os.sleep(2)
            textutils.slowPrint("Not found.. rebooting")
            os.reboot()
        end
    until done1 == true
    term.clear()
end

rs()
repeat
    repeat
        if turtle.getItemDetail() ~= nil then
            if turtle.getItemDetail()["name"] ~= block1 then
                search()
            end
        end
        if turtle.getItemDetail() == nil then
            search()
        end
        turtle.forward()
        if (turn1 % 2 == 0) then
            RX = RX+1
        else
            RX = RX-1
        end
        if insD() ~= nil then
            if insD()["name"] ~= block1 then
                rs()
            end
        else
            if insfix() == false then
                rs()
            end
        end
    until turtle.inspect() == true
    turn()
    if done2 == true then break end
    if insD() ~= nil then
        if insD()["name"] ~= block1 then
            rs()
        end
    else
        if insfix() == false then
            rs()
        end
    end
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

print("Layer Replacement Done!")