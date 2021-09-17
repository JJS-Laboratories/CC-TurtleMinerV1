local args = {...}

if args[1] == nil then
    print("Usage: minerwall <Replace? (true/false)>")
    return
end

local replace1 = args[1]

turn1 = 0

if replace1 == "true" then
    block1 = turtle.getItemDetail()["name"]
    textutils.slowPrint("Selected Block:"..block1)
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
end

function rs()
    turtle.dig()
    if replace1 == "true" then
        turtle.place()
    end
end

function turn()
    turtle.forward()
    turtle.turnLeft()
    turn1 = turn1+1   
end

function start()
    repeat
        rs()
        repeat
            if replace1 == "true" then
                if turtle.getItemDetail() ~= nil then
                    if turtle.getItemDetail()["name"] ~= block1 then
                        search()
                    end
                end
                if turtle.getItemDetail() == nil then
                    search()
                end
            end
            if (turn1 % 2 == 0) then
                turtle.up()
            else
                turtle.down()
            end
            rs()
        until turtle.inspectDown() == true or turtle.inspectUp() == true
        turtle.turnRight()
        if turtle.inspect() == true then
            done2 = true
        else
            done2 = false
        end
        turn()
    until done2 == true  
end

start()
    
            
    