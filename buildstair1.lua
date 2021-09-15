local args = {...}

i = 0

function du()
    turtle.digUp()
end
function p()
    turtle.place()
end
function pu()
    turtle.placeUp()
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
    turtle.up()
end


turtle.place()
turtle.placeUp()
turtle.turnRight()
turtle.forward()
turtle.up()
turtle.placeUp()
repeat
    tl()
    fw()
    up()
    pu()
until turtle.inspect() == true
