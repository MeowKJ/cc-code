local FUEL_TYPES_PATTERN = "log"
local SAPLING_TYPES_PATTERN = "sapling"
local FUEL_THRESHOLD = 64
local x = 0
local y = 0

local function init()
    turtle.select(1)
end

local function checkFuel()
    if turtle.getFuelLevel() < FUEL_THRESHOLD then
        for i = 1, 16 do
            turtle.select(i)
            local name  = turtle.getItemDetail().name
            if not name == nil and string.find(turtle.getItemDetail().name, FUEL_TYPES_PATTERN) then
                turtle.refuel()
                break
            end
        end
        print("refuel")
    end
end

local function chopTree()
    print("chopTree Time")
    while turtle.detect() do
        turtle.dig()
    end
    for i = 1, 16 do
        turtle.select(i)
        local name  = turtle.getItemDetail().name
        if not name == nil and string.find(turtle.getItemDetail().name, SAPLING_TYPES_PATTERN) then
            turtle.place()
            break
        end
    end
    turtle.forward()
end

local function goHome()
    turtle.turnLeft()
    for i = 1, 6 do
        turtle.forward()
    end
    turtle.turnLeft()
    for i = 1, 6 do
        turtle.forward()
    end
    turtle.turnLeft()
    turtle.turnLeft()
end

local function collectWood()
    print("collectWood")
    turtle.suck()
end

local function main()
    while true do
        while y < 7 do
            checkFuel()
            chopTree()
            collectWood()
            if x > 6 then
                if y % 2 == 0 then
                    turtle.turnRight()
                    turtle.forward()
                    turtle.turnRight()
                end
                if y % 2 == 1 then
                    turtle.turnLeft()
                    turtle.forward()
                    turtle.turnLeft()
                end
                x = 0
                y = y + 1
            end
            x = x + 1
        end
        goHome()
        x = 0
        y = 0
        print("GO HOME AND DROP WOOD")
        os.sleep(300)
    end
end

init()
main()
