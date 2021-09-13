local fuel = turtle.getFuelLevel()
local fuelmax = turtle.getFuelLimit()

local args = {...}

if args[1] == "reset" then
    fs.delete("/mconfig/hook.txt")
    fs.delete("/mconfig/id.txt")
    print("Successfully deleted config!")
    os.sleep(1)
end
enablehook = false
if fs.exists("/DiscordHook.lua") then
    DH = require("DiscordHook")
else
    shell.run("wget https://raw.githubusercontent.com/Wendelstein7/DiscordHook-CC/master/DiscordHook.lua DiscordHook.lua")
    DH = require("DiscordHook")
end

if not fs.exists("/mconfig") then
    fs.makeDir("/mconfig")
end

if not fs.exists("/mconfig/hook.txt") then
    config1 = fs.open("/mconfig/hook.txt", "w")
    print("Please enter WEBHOOK url:\n(or 'false' to disable)")
    input1 = io.read()
    config1.write(input1)
    config1.close()
end
if not fs.exists("/mconfig/id.txt") then
    config2 = fs.open("/mconfig/id.txt", "w")
    print("Please enter your discord ID:")
    input2 = io.read()
    config2.write(input2)
    config2.close()
end

if fs.exists("/mconfig/hook.txt") then
    config1 = fs.open("/mconfig/hook.txt", "r")
    hookURL = config1.readAll()
    if hookURL == "false" then
        enablehook = false
    else
        success, hook = DH.createWebhook(hookURL)
        if not success then
            error("Webhook connection failed! Reason: " .. hook)
        end
        hook.send("**Turtle Miner Hook successfully connected! ID:** "..os.getComputerID())
        enablehook = true
    end
end

if fs.exists("/mconfig/id.txt") then
    config2 = fs.open("/mconfig/id.txt", "r")
    dcID = config2.readAll()
end

logN = 1

if not fs.exists("/log") then
    fs.makeDir("/log")
end

if fs.exists("/log/old.txt") and fs.exists("/log/latest.txt") then
    fs.delete("/log/old.txt")
    fs.move("/log/latest.txt", "/log/old.txt")
end

if fs.exists("/log/latest.txt") and not fs.exists("/log/old.txt") then
    fs.move("/log/latest.txt", "/log/old.txt")
end

if not fs.exists("/log/latest.txt") then
    logfile = fs.open("/log/latest.txt", "w")
    logfile.write("Log Files! \n")
    logfile.close()
end


function log(x)
    print("["..logN.."] "..x)
    logfile = fs.open("/log/latest.txt", "a")
    logfile.write("["..logN.."] "..x.."\n")
    logfile.close()
    if enablehook then
        hook.send("["..logN.."] "..x, "Mining Turtle "..os.getComputerID())
    end
    logN = logN+1
end
function logcd(x)
    print("["..logN.."] "..x)
    logfile = fs.open("/log/latest.txt", "a")
    logfile.write("["..logN.."] "..x.."\n")
    logfile.close()
    logN = logN+1
end

function mineFront(x1)
    i = 0
    logcd("Mining forward: "..x1-i.." "..i1.."/8 Done")
    repeat
        turtle.dig()
        turtle.digUp()
        turtle.forward()
        i = i+1
        RX = RX+1
        logcd("X:"..RX.." Y:"..RY.." Z:"..RZ)
        os.sleep(0.25)
    until i == x1
end

function mineFront3(x1)
    i = 0
    logcd("Mining forward: "..x1-i.." "..i1.."/8 Done")
    repeat
        turtle.dig()
        turtle.digUp()
        turtle.forward()
        i = i+1
        RZ = RZ-1
        logcd("X:"..RX.." Y:"..RY.." Z:"..RZ)
        os.sleep(0.25)
    until i == x1
end

function mineFront2(x1)
    i = 0
    logcd("Mining forward (return): "..x1-i.." "..i1.."/8 Done")
    repeat
        turtle.dig()
        turtle.digUp()
        turtle.forward()
        i = i+1
        RX = RX-1
        logcd("X:"..RX.." Y:"..RY.." Z:"..RZ)
        os.sleep(0.25)
    until i == x1
end

function changeRow(x1)
    logcd("Changing Row (1)")
    turtle.turnRight()
    turtle.dig()
    turtle.digUp()
    turtle.forward()
    turtle.turnRight()
    RZ = RZ+1
    logcd("X:"..RX.." Y:"..RY.." Z:"..RZ)
end
function changeRow2(x1)
    logcd("Changing Row (2)")
    turtle.turnLeft()
    turtle.dig()
    turtle.digUp()
    turtle.forward()
    turtle.turnLeft()
    RZ = RZ+1
    logcd("X:"..RX.." Y:"..RY.." Z:"..RZ)
end
function emptyItems()
    local iz = 0
    if RZ ~= 0 then
        log("Moving Z..")
        turtle.turnLeft()
        repeat
            turtle.forward()
            iz = iz+1
            logcd(iz.."/"..RZ)
        until iz == RZ
        turtle.turnRight()
    end
    local ix = 0
    if RX ~= 0 then
        log("Moving X..")
        repeat
            turtle.back()
            ix = ix+1
            logcd(ix.."/"..RX)
        until ix == RX
    end
    local iy = 0
    if RY ~= 0 then
        log("Moving Y..")
        repeat
            turtle.up()
            iy = iy-1
            logcd(iy.."/"..RY)
        until iy == RY
    end
    turtle.turnLeft()
    i3 = 1
    repeat
        turtle.select(i3)
        turtle.drop()
        i3 = i3+1
    until i3 == 16
    if turtle.getItemDetail(13) ~= nil then
        log("---- Failed to empty inventory.. Stopping! ----")
        os.reboot()
    end 

    turtle.turnLeft()
    turtle.select(16)
    turtle.suck()
    turtle.refuel()
    fuelslot = turtle.getItemDetail(16)
    if fuelslot["name"] == "minecraft:bucket" then
        turtle.turnLeft()
        turtle.drop()
        turtle.turnRight()
    end
    turtle.suck()
    turtle.refuel()
    fuelslot = turtle.getItemDetail(16)
    if fuelslot["name"] == "minecraft:bucket" then
        turtle.turnLeft()
        turtle.drop()
        turtle.turnRight()
    end
    turtle.turnRight()
    turtle.turnRight()
    turtle.select(1)
end
function returnHome()
    local iz = 0
    if RZ ~= 0 then
        log("Moving Z..")
        turtle.turnLeft()
        repeat
            turtle.forward()
            iz = iz+1
            logcd(iz.."/"..RZ)
        until iz == RZ
        turtle.turnRight()
    end
    local ix = 0
    if RX ~= 0 then
        log("Moving X..")
        repeat
            turtle.back()
            ix = ix+1
            logcd(ix.."/"..RX)
        until ix == RX
    end
    local iy = 0
    if RY ~= 0 then
        log("Moving Y..")
        repeat
            turtle.up()
            iy = iy-1
            logcd(iy.."/"..RY)
        until iy == RY
    end
    os.reboot()
end

function returnWork()
    local iy2 = 0
    local ix2 = 0
    local iz2 = 0
    local RY2 = RY
    if RY ~= 0 then
        log("Moving Y..")
        repeat
            turtle.down()
            iy2 = iy2-1
            logcd(iy2.."/"..RY)
        until iy2 == RY
    end
    if RX ~= 0 then
        log("Moving X..")
        repeat
            turtle.forward()
            ix2 = ix2+1
            logcd(ix2.."/"..RX)
        until ix2 == RX
    end
    if RZ ~= 0 then
        log("Moving Z..")
        turtle.turnRight()
        repeat
            turtle.forward()
            iz2 = iz2+1
            logcd(iz2.."/"..RZ)
        until iz2 == RZ
        turtle.turnLeft()
    end
end

RX = 0
RY = 0
RZ = 0

log("Turtle fuel is "..fuel.."/"..fuelmax.." (Refuel threshold is "..(fuelmax/16)..")")
os.sleep(0.25)

if fuel < (fuelmax/1) then
    turtle.select(16)
    local fuelslot = turtle.getItemDetail(16)
    if fuelslot ~= nil then
    log("Item in Fuel Slot! : "..fuelslot["name"].." Attempting to refuel..")
    turtle.refuel()
    os.sleep(0.25)
    local fuel = turtle.getFuelLevel()
    log("Turtle fuel is now "..fuel.."/"..fuelmax)
    end
end

turtle.select(1)

os.sleep(0.25)

log("Engage Miner? (y/n)")
result1 = io.read()
log("User Input: "..result1)
if result1 == "y" then
    log("Starting!")
    log("Y Offset: ")
    result2 = io.read()
    log("User Input: "..result2)
    turtle.digDown()
    turtle.down()
    RY = RY-1
    logcd("X:"..RX.." Y:"..RY.." Z:"..RZ)
    offset1 = 0
    if result2 ~= nil and tonumber(result2) ~= 0 then
        log("Offsetting..")
        if tonumber(result2) > 1 then
            repeat
                turtle.digDown()
                turtle.down()
                offset1 = offset1+1
                RY = RY-1
                logcd("X:"..RX.." Y:"..RY.." Z:"..RZ)
            until offset1 == tonumber(result2)-1
        else
            turtle.digDown()
            turtle.down()
        end
        log("Offsetting Done!")
    end
    repeat
        i1 = 0
        repeat
            if turtle.getItemDetail(13) ~= nil then
                log("-- Full inventory! returning home.. --")
                emptyItems()
                log("Return & Drop done! Returning to work..")
                returnWork()
            end
            if turtle.getFuelLevel() < fuelmax/16 then
                log("-- Low Fuel! Refueling enabled. --")
                emptyItems()
                os.sleep(1)
                if turtle.getFuelLevel() < fuelmax/16 then
                    turtle.turnRight()
                    if enablehook then
                    hook.send("<@"..dcID.."> **Your turtle with ID:** __"..os.getComputerID().."__ **Ran out of fuel.**")
                    end
                    os.reboot()
                end
            end
            mineFront(15)
            changeRow(1)
            mineFront2(15)
            changeRow2()
            i1 = i1+1
            local inspect1, inspect2 = turtle.inspect()
            if inspect2["name"] == "minecraft:bedrock" then
                log("--- Bedrock Detected! Returning Home ---")
                breakloop = true
                breakloop2 = true
                emptyItems()
                break
            end
        until i1 == 8 or breakloop == true
        local inspect1, inspect2 = turtle.inspectDown()
        if inspect2["name"] == "minecraft:bedrock" then
            log("--- Bedrock Detected! Returning Home ---")
            breakloop = true
            breakloop2 = true
            emptyItems()
            break
        end
        log("---- Done one layer! Lowering.. ----".." Current Coords: X:"..RX.." Y:"..RY.." Z:"..RZ)
        turtle.turnLeft()
        mineFront3(16)
        turtle.turnRight()
        turtle.digDown()
        turtle.down()
        RY = RY-1
        logcd("X:"..RX.." Y:"..RY.." Z:"..RZ)
    until breakloop2 == true
end