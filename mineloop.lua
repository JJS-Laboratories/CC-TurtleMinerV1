i = 1
currentslot = 1
repeat
    turtle.select(currentslot)
    repeat
        turtle.place()
        turtle.placeUp()
        turtle.placeDown()
        turtle.dig()
        turtle.digUp()
        if turtle.inspectDown()["name"] == "minecraft:gravel" then
            turtle.digDown()
        end
    until turtle.getItemDetail() == nil or turtle.getItemDetail()["name"] ~= "minecraft:gravel"

    if turtle.getItemDetail(currentslot+1) ~= nil then
        if turtle.getItemDetail(currentslot+1)["name"] == "minecraft:gravel" then
            currentslot = currentslot+1
        else
            if turtle.getItemDetail(currentslot+2) ~= nil then
                if turtle.getItemDetail(currentslot+2)["name"] == "minecraft:gravel" then
                    currentslot = currentslot+2
                end
            end
        end
    else
        break
    end
until i == 2

textutils.slowPrint("No more gravel found! Program terminated.")
