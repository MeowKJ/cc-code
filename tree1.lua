local FUEL_TYPES_PATTERN = "og"
local WOOD_TYPES_PATTERN = "og"
local SAPLING_TYPES_PATTERN = "sapling"
local TURN_LEFT_BLOOCK = "minecraft:polished_andesite"
local TURN_RIGHT_BLOOCK = "minecraft:polished_granite"
local GOHOME_BLOOCK = "minecraft:pumpkin"
local FUEL_THRESHOLD = 64


local function init()
    turtle.select(1)
    turtle.forward()
    turtle.turnLeft()
    turtle.forward()
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


local function main()
    while true do
        init()
        while true do
            local success, data = turtle.inspectDown()
            if success and data.name == GOHOME_BLOOCK then
                print("GO HOME AND DROP WOOD")
                turtle.turnRight()
                for i = 1, 10 do
                    turtle.forward()
                end
                turtle.turnLeft()
                turtle.turnLeft()
                break
            end

            if success and data.name == TURN_LEFT_BLOOCK then
                print("TURN LEFT")
                turtle.turnLeft()
                turtle.forward()
                turtle.forward()
                turtle.forward()
                turtle.turnLeft()
                turtle.forward()
            end

            if success and data.name == TURN_RIGHT_BLOOCK then
                print("TURN RIGHT")
                turtle.turnRight()
                turtle.forward()
                turtle.forward()
                turtle.forward()
                turtle.turnRight()
                turtle.forward()
            end

            checkFuel()
            step()
            turtle.forward()
        end
        os.sleep(300)
    end
end


main()
