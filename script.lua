-- 🌟 Astra BeeSwarm Teleport GUI 🌟
-- Твои координаты + перетаскиваемое меню
-- Работает на Velocity, Xeno, Codex Delta

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Ждём персонажа
local character = player.Character or player.CharacterAdded:Wait()
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")

-- ТВОИ координаты (первое место)
local locations = {
    ["Место 1"] = CFrame.new(-412.209473, 17.1699581, 466.990509, 
        0.814550877, -1.483022596e-09, -0.580092072, 
        1.252825070e-09, 1, -7.97343858e-10, 
        0.580092072, -7.727677536e-11, 0.814550877)
}

-- Создаём GUI
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "AstraTeleport"
screenGui.Parent = playerGui

local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 280, 0, 350)
mainFrame.Position = UDim2.new(0.5, -140, 0.5, -175)
mainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
mainFrame.BorderSizePixel = 0
mainFrame.Parent = screenGui

-- Заголовок (перетаскивание)
local titleBar = Instance.new("Frame")
titleBar.Size = UDim2.new(1, 0, 0, 40)
titleBar.BackgroundColor3 = Color3.fromRGB(45, 45, 65)
titleBar.Parent = mainFrame

local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(1, -40, 1, 0)
titleLabel.Position = UDim2.new(0, 10, 0, 0)
titleLabel.Text = "⭐ АСТРА TELEPORT ⭐"
titleLabel.TextColor3 = Color3.new(1,1,1)
titleLabel.BackgroundTransparency = 1
titleLabel.TextScaled = true
titleLabel.Font = Enum.Font.GothamBold
titleLabel.Parent = titleBar

-- Кнопка телепорта (первое место)
local tpBtn1 = Instance.new("TextButton")
tpBtn1.Size = UDim2.new(0.9, 0, 0, 50)
tpBtn1.Position = UDim2.new(0.05, 0, 0, 60)
tpBtn1.Text = "🚀 Место 1 (-412, 17, 467)"
tpBtn1.BackgroundColor3 = Color3.fromRGB(50, 150, 255)
tpBtn1.TextColor3 = Color3.new(1,1,1)
tpBtn1.TextScaled = true
tpBtn1.Font = Enum.Font.Gotham
tpBtn1.Parent = mainFrame

-- Пустые слоты для других 17 мест (добавишь координаты)
for i = 2, 10 do
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0.45, -5, 0, 40)
    btn.Position = UDim2.new((i-2)%2 * 0.52 + 0.02, 0, 0, 130 + math.floor((i-2)/2) * 45)
    btn.Text = "Место " .. i .. "\n(добавь координаты)"
    btn.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
    btn.TextColor3 = Color3.new(1,1,1)
    btn.TextScaled = true
    btn.Font = Enum.Font.Gotham
    btn.Parent = mainFrame
end

-- Перетаскивание GUI
local dragging = false
local dragStart = nil
local startPos = nil

titleBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = mainFrame.Position
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - dragStart
        mainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

titleBar.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

-- Телепорт функция
tpBtn1.MouseButton1Click:Connect(function()
    humanoidRootPart.CFrame = locations["Место 1"]
    print("🌟 Телепорт на Место 1 выполнен!")
end)

-- Клавиша для открытия/закрытия (INSERT)
UserInputService.InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.Insert then
        screenGui.Enabled = not screenGui.Enabled
    end
end)

print("🌟 АСТРА TELEPORT GUI загружена! INSERT = показать/скрыть")
