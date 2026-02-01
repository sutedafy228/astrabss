-- 🌟 Astra BeeSwarm Teleport GUI v2 (5 МЕСТ) 🌟
-- Velocity/Xeno Compatible | Закрыть + Скрыть

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local character = player.Character or player.CharacterAdded:Wait()
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")

-- ✅ ТВОИ 5 МЕСТ (полные CFrame)
local locations = {
    ["Место 1"] = CFrame.new(-412.209473, 17.1699581, 466.990509, 
        0.814550877, -1.483022596e-09, -0.580092072, 
        1.252825070e-09, 1, -7.97343858e-10, 
        0.580092072, -7.727677536e-11, 0.814550877),
    
    ["Место 2"] = CFrame.new(-436.199249, 93.2595596, 49.2813301, 
        -0.978726089, 3.790221478e-09, -0.205171272, 
        1.05675391e-09, 1, 1.34324303e-08, 
        0.205171272, 1.292985450e-08, -0.978726089),
    
    ["Место 3"] = CFrame.new(-481.157837, 69.3887939, -0.23113434, 
        -0.949120283, 1.305610290e-08, 0.314913839, 
        -1.356494476e-08, 1, -8.23427371e-08, 
        -0.314913839, -8.242494696e-08, -0.949120283),
    
    ["Место 4"] = CFrame.new(524.299622, 152.285828, -410.543518, 
        -0.514481783, 6.966588736e-08, 0.857501328, 
        4.0147814e-08, 1, -5.715509496e-08, 
        -0.857501328, 5.021548510e-09, -0.514481783),
    
    ["Место 5"] = CFrame.new(271.446899, 25292.3125, -871.283875, 
        -0.524544299, 3.75788254e-08, 0.85138315, 
        -5.99211205e-08, 1, -8.105646296e-08, 
        -0.85138315, -9.353353650e-08, -0.524544299)
}

-- GUI
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "AstraTeleport"
screenGui.Parent = playerGui

local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 300, 0, 420)
mainFrame.Position = UDim2.new(0.5, -150, 0.5, -210)
mainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
mainFrame.BorderSizePixel = 0
mainFrame.Parent = screenGui

-- Заголовок с кнопкой X
local titleBar = Instance.new("Frame")
titleBar.Size = UDim2.new(1, 0, 0, 45)
titleBar.BackgroundColor3 = Color3.fromRGB(45, 45, 65)
titleBar.Parent = mainFrame

local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(0.8, 0, 1, 0)
titleLabel.Text = "⭐ АСТРА TELEPORT (5 МЕСТ) ⭐"
titleLabel.TextColor3 = Color3.new(1,1,1)
titleLabel.BackgroundTransparency = 1
titleLabel.TextScaled = true
titleLabel.Font = Enum.Font.GothamBold
titleLabel.Parent = titleBar

local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 35, 0, 35)
closeBtn.Position = UDim2.new(1, -40, 0, 5)
closeBtn.Text = "✕"
closeBtn.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
closeBtn.TextColor3 = Color3.new(1,1,1)
closeBtn.TextScaled = true
closeBtn.Font = Enum.Font.GothamBold
closeBtn.Parent = titleBar

-- 5 кнопок телепорта
local buttons = {}
local btnNames = {"Место 1 (-412,17,467)", "Место 2 (-436,93,49)", "Место 3 (-481,69,0)", "Место 4 (524,152,-411)", "Место 5 (271,25292,-871)"}
for i = 1, 5 do
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0.92, 0, 0, 55)
    btn.Position = UDim2.new(0.04, 0, 0, 55 + (i-1) * 65)
    btn.Text = "🚀 " .. btnNames[i]
    btn.BackgroundColor3 = Color3.fromRGB(50, 150, 255)
    btn.TextColor3 = Color3.new(1,1,1)
    btn.TextScaled = true
    btn.Font = Enum.Font.Gotham
    btn.Parent = mainFrame
    buttons[i] = btn
end

-- Перетаскивание
local dragging, dragStart, startPos
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

-- Телепорт по кнопкам
for i = 1, 5 do
    buttons[i].MouseButton1Click:Connect(function()
        local placeName = btnNames[i]:match("Место (%d+)") or "Место " .. i
        humanoidRootPart.CFrame = locations[placeName:match("Место (%d+)") and "Место " .. i or placeName]
        print("🌟 Телепорт на " .. placeName .. " выполнен!")
    end)
end

-- Кнопка закрыть (X)
closeBtn.MouseButton1Click:Connect(function()
    screenGui:Destroy()
    print("❌ Astra Teleport закрыт!")
end)

-- INSERT = скрыть/показать
UserInputService.InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.Insert then
        screenGui.Enabled = not screenGui.Enabled
    end
end)

print("🌟 АСТРА TELEPORT v2 (5 МЕСТ) загружена! INSERT=скрыть | X=закрыть")
