local FUEL_TYPES_PATTERN = "og"
local WOOD_TYPES_PATTERN = "og"
local SAPLING_TYPES_PATTERN = "sapling"
local TURN_LEFT_BLOOCK = "minecraft:polished_andesite"
local TURN_RIGHT_BLOOCK = "minecraft:polished_granite"
local GOHOME_BLOOCK = "minecraft:pumpkin"
local FUEL_THRESHOLD = 64

local function init()
    turtle.select(1)
    turtle.turnLeft()
    turtle.suck(16)
    turtle.suckUp(64)
    turtle.turnRight()
    digAndForward()
    turtle.turnLeft()
    digAndForward()
end

local function checkFuel()
    if turtle.getFuelLevel() < FUEL_THRESHOLD then
        for i = 1, 16 do
            turtle.select(i)
            local item = turtle.getItemDetail()
            if (item ~= nil) and (string.find(item.name, FUEL_TYPES_PATTERN) ~= nil) then
                turtle.refuel()
                break
            end
        end
        print("refuel")
    end
end




local function chopTreeAndplaceSapling()
    print("chopTree Start")

    local success, data = turtle.inspect()
    
    while success and string.find(data.name, SAPLING_TYPES_PATTERN) == nil do
        turtle.dig()
        success, data = turtle.inspect()
    end

    if not turtle.detect() then
        for i = 1, 16 do
            turtle.select(i)
            local item = turtle.getItemDetail()
            if (item ~= nil) and (string.find(item.name, SAPLING_TYPES_PATTERN) ~= nil) then
                turtle.place()
                break
            end
        end
    end
    print("chopTree End")
end


local function step()
    turtle.turnLeft()
    chopTreeAndplaceSapling()
    turtle.suck()
    turtle.turnRight()
    turtle.suck()
    turtle.turnRight()
    chopTreeAndplaceSapling()
    turtle.suck()
    turtle.turnLeft()
    turtle.suck()
end

local function dorpItems()
    print("DROP ITEMS Start")
    turtle.turnRight()
    for i = 1, 16 do
        turtle.select(i)
        if turtle.getItemCount() > 0 then
            if string.find(turtle.getItemDetail().name, SAPLING_TYPES_PATTERN) ~= nil then
                turtle.dropUp()
            else
                turtle.drop()
            end
        end
    end
    turtle.turnLeft()
end

function digAndForward()
    while turtle.detect() do
        turttle.dig()
    end
    digAndForward()
    
end

local function main()
    while true do

        init()
        while true do
            local success, data = turtle.inspectDown()
            if success and data.name == GOHOME_BLOOCK then
                print("GO HOME AND DROP WOOD")
                turtle.turnRight()
                for i = 1, 10 do
                    digAndForward()
                end
                turtle.turnLeft()
                turtle.turnLeft()
                dorpItems()
                break
            end

            if success and data.name == TURN_LEFT_BLOOCK then
                print("TURN LEFT")
                turtle.turnLeft()
                digAndForward()
                digAndForward()
                digAndForward()
                turtle.turnLeft()
                digAndForward()
            end

            if success and data.name == TURN_RIGHT_BLOOCK then
                print("TURN RIGHT")
                turtle.turnRight()
                digAndForward()
                digAndForward()
                digAndForward()
                turtle.turnRight()
                digAndForward()
            end

            checkFuel()
            step()
            while turtle.detect() do
                turtle.dig()
            end
            digAndForward()
        end
        os.sleep(300)
    end
end


main()
