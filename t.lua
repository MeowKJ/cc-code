local FUEL_TYPES_PATTERN = "log"
local FUEL_THRESHOLD = 64
local x = 0
local y = 0

-- 初始化
local function init()
    turtle.select(1)
end

-- 检查是否需要加燃料
local function checkFuel()
    if turtle.getFuelLevel() < FUEL_THRESHOLD then
        for i = 1, 16 do
            turtle.select(i)
            if string.find(turtle.getItemDetail().name, FUEL_TYPES_PATTERN) then
                turtle.refuel()
                break
            end
        end
        print("燃料不足，正在加燃料...")
    end
end

-- 砍树
local function chopTree()
    print("正在砍树...")
    while turtle.detect() do
        turtle.dig()
    end
    turtle.forward()
end

-- 回家
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
    print("正在收集木材...")
    for i = 1, 16 do
        turtle.select(i)
        turtle.drop()
    end
end

-- 主程序
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
        -- 存放到箱子
        print("GO HOME AND DROP WOOD")
        -- 等待一段时间再进行下一次操作
        os.sleep(300) -- 5分钟
    end
end

-- 启动程序
init()
main()
