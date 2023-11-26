local FUEL_TYPES_PATTERN = "log"
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
            if string.find(turtle.getItemDetail().name, FUEL_TYPES_PATTERN) then
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

-- 收集木材
local function collectWood()
    print("collectWood")
    for i = 1, 16 do
        turtle.select(i)
        turtle.suck()
    end
end

local function main()
    while true do
        while y < 7 do
            checkFuel()
            chopTree()
            collectWood()

            x = x + 1
            if x > 6 then
                if x % 2 == 0 then
                    turtle.turnRight()
                    turtle.forward()
                    turtle.turnRight()
                end
                if x % 2 == 1 then
                    turtle.turnLeft()
                    turtle.forward()
                    turtle.turnLeft()
                end
                x = 0
                y = y + 1
            end
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
