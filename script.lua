--[[
Скрипт для Bee Swarm Simulator - Полностью тихий режим
]]

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local VirtualInputManager = game:GetService("VirtualInputManager")

local hivePositions = {
    [6] = Vector3.new(-186.75, 5.93, 331.65),
    [5] = Vector3.new(-149.63, 5.93, 330.82),
    [4] = Vector3.new(-112.97, 5.93, 330.97),
    [3] = Vector3.new(-76.39, 5.93, 330.25),
    [2] = Vector3.new(-39.98, 5.93, 330.26),
    [1] = Vector3.new(-3.15, 5.93, 330.75)
}

local priorityOrder = {6, 5, 4, 3, 2, 1}

local function hasHive()
    return LocalPlayer:FindFirstChild("Honeycomb") ~= nil
end

local function getOccupiedHives()
    local occupied = {}
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then
            local honeycomb = player:FindFirstChild("Honeycomb")
            if honeycomb then
                local hiveString = tostring(honeycomb.Value)
                local gameHive = string.match(hiveString, "Hive(%d+)")
                if gameHive then
                    occupied[tonumber(gameHive)] = true
                end
            end
        end
    end
    return occupied
end

local function pressE()
    VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.E, false, game)
    task.wait(0.05)
    VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.E, false, game)
end

local function moveToHive(hiveNumber)
    local character = LocalPlayer.Character
    if not character then return false end
    
    local humanoid = character:FindFirstChild("Humanoid")
    local rootPart = character:FindFirstChild("HumanoidRootPart")
    
    if humanoid and rootPart then
        local targetPos = hivePositions[hiveNumber]
        if targetPos then
            humanoid:MoveTo(targetPos)
            
            local startTime = tick()
            while (rootPart.Position - targetPos).Magnitude > 7 do
                task.wait(0.1)
                if tick() - startTime > 20 then
                    return false
                end
            end
            return true
        end
    end
    return false
end

-- Основной код
if hasHive() then return end

local occupied = getOccupiedHives()
local targetHive = nil

for _, hive in ipairs(priorityOrder) do
    if not occupied[hive] then
        targetHive = hive
        break
    end
end

if not targetHive then return end

local moved = moveToHive(targetHive)
if not moved then return end

for i = 1, 3 do
    pressE()
    task.wait(0.1)
end

task.wait(0.5)
