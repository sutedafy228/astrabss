-- 🌟 Astra Teleport GUI v3 (ИСПРАВЛЕНО) 🌟
-- ✅ ТЕЛЕПОРТ 100% РАБОТАЕТ на Velocity!

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- ФУНКЦИЯ безопасного телепорта
local function safeTeleport(cframe)
    spawn(function()
        local character = player.Character
        if character and character:FindFirstChild("HumanoidRootPart") then
            character.HumanoidRootPart.CFrame = cframe
            print("✅ ТЕЛЕПОРТ ВЫПОЛНЕН!")
        else
            wait(1)
            local newChar = player.Character
            if newChar and newChar:FindFirstChild("HumanoidRootPart") then
                newChar.HumanoidRootPart.CFrame = cframe
                print("✅ ТЕЛЕПОРТ ВЫПОЛНЕН (respawn)")
            end
        end
    end)
end

-- ТВОИ 5 МЕСТ
local locations = {
    [1] = CFrame.new(-412.209473, 17.1699581, 466.990509, 
        0.814550877, -1.483022596e-09, -0.580092072, 
        1.252825070e-09, 1, -7.97343858e-10, 
        0.580092072, -7.727677536e-11, 0.814550877),
    
    [2] = CFrame.new(-436.199249, 93.2595596, 49.2813301, 
        -0.978726089, 3.790221478e-09, -0.205171272, 
        1.05675391e-09, 1, 1.34324303e-08, 
        0.205171272, 1.292985450e-08, -0.978726089),
    
    [3] = CFrame.new(-481.157837, 69.3887939, -0.23113434, 
        -0.949120283, 1.305610290e-08, 0.314913839, 
        -1.356494476e-08, 1, -8.23427371e-08, 
        -0.314913839, -8.242494696e-08, -0.949120283),
    
    [4] = CFrame.new(524.299622, 152.285828, -410.543518, 
        -0.514481783, 6.966588736e-08, 0.857501328, 
        4.0147814e-08, 1, -5.715509496e-08, 
        -0.857501328, 5.021548510e-09, -0.514481783),
    
    [5] = CFrame.new(271.446899, 25292.3125, -871.283875, 
        -0.524544299, 3.75788254e-08, 0.85138315, 
        -5.99211205e-08, 1, -8.105646296e-08, 
        -0.85138315, -9.353353650e-08, -0.524544299)
}

-- GUI
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "AstraTP"
screenGui.Parent = playerGui

local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 320, 0, 380)
mainFrame.Position = UDim2.new(0.5, -160, 0.5, -190)
mainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
mainFrame.BorderSizePixel = 2
mainFrame.BorderColor3 = Color3.fromRGB(0, 255, 0)
mainFrame.Parent = screenGui

-- Заголовок
local titleBar = Instance.new("Frame")
titleBar.Size = UDim2.new(1, 0, 0, 40)
titleBar.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
titleBar.Parent = mainFrame

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -50, 1, 0)
title.Text = "⭐ АСТРА TELEPORT ⭐"
title.TextColor3 = Color3.new(1,1,1)
title.BackgroundTransparency = 1
title.TextScaled = true
title.Font = Enum.Font.GothamBold
title.Parent = titleBar

local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 40, 0, 30)
closeBtn.Position = UDim2.new(1, -45, 0, 5)
closeBtn.Text = "✕"
closeBtn.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
closeBtn.TextColor3 = Color3.new(1,1,1)
closeBtn.TextScaled = true
closeBtn.Font = Enum.Font.GothamBold
closeBtn.Parent = titleBar

-- КНОПКИ ТЕЛЕПОРТА (простая нумерация)
local btnTexts = {"Место 1", "Место 2", "Место 3", "Место 4", "Место 5"}
for i = 1, 5 do
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0.9, 0, 0, 50)
    btn.Position = UDim2.new(0.05, 0, 0, 50 + (i-1) * 60)
    btn.Text = "🚀 " .. btnTexts[i]
    btn.BackgroundColor3 = Color3.fromRGB(50, 200, 50)
    btn.TextColor3 = Color3.new(1,1,1)
    btn.TextScaled = true
    btn.Font = Enum.Font.GothamBold
    btn.Parent = mainFrame
    
    -- ✅ ПРЯМАЯ ПРИВЯЗКА КНОПКИ К МЕСТУ
    btn.MouseButton1Click:Connect(function()
        safeTeleport(locations[i])
    end)
end

-- Перетаскивание
local dragging = false
local dragInput, dragStart, startPos
titleBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = mainFrame.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and input == dragInput then
        local delta = input.Position - dragStart
        mainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

-- Закрыть
closeBtn.MouseButton1Click:Connect(function()
    screenGui:Destroy()
end)

-- INSERT toggle
UserInputService.InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.Insert then
        screenGui.Enabled = not screenGui.Enabled
    end
end)

print("🚀 АСТРА TELEPORT v3 ИСПРАВЛЕНО! Жми кнопки 1-5!")
