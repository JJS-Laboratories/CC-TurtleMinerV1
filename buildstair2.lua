local args = {...}

i = 0

function du()
    turtle.digDown()
end
function p()
    turtle.place()
end
function pu()
    turtle.placeDown()
end
function tl()
    turtle.turnLeft()
end
function tr()
    turtle.turnRight()
end
function fw()
    turtle.forward()
end
function up()
    turtle.down()
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


turtle.place()
turtle.placeDown()
turtle.turnRight()
turtle.forward()
turtle.down()
turtle.placeDown()
repeat
    if turtle.getItemDetail() == nil then
        search()
    end
    tl()
    fw()
    up()
    pu()
until turtle.inspect() == true
