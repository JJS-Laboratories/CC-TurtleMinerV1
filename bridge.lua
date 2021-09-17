local args = {...}

if args[1] == nil then
    print("Usage: bridge <length>")
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

i = 0

if args[1] ~= nil then
    repeat
        if turtle.getItemDetail == nil then
            search()
        end
        turtle.placeDown()
        turtle.forward()
        i = i+1
    until i == tonumber(args[1])
end