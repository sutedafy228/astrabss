-- 🌟 АСТРА TELEPORT v1 (XENO ✓ VELOCITY ✓ CODEX ✓) 🌟
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- ТВОИ 5 МЕСТ
local locations = {
    CFrame.new(-412.21, 17.17, 466.99),
    CFrame.new(-436.20, 93.26, 49.28),
    CFrame.new(-481.16, 69.39, -0.23),
    CFrame.new(524.30, 152.29, -410.54),
    CFrame.new(271.45, 25292.31, -871.28)
}

-- GUI (ТОЧНО как в первом сообщении)
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "AstraTP"
screenGui.Parent = playerGui

local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 300, 0, 350)
mainFrame.Position = UDim2.new(0.5, -150, 0.5, -175)
mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
mainFrame.Parent = screenGui

-- Заголовок
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 40)
title.Text = "⭐ АСТРА TELEPORT ⭐"
title.TextColor3 = Color3.new(1,1,1)
title.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
title.TextScaled = true
title.Font = Enum.Font.GothamBold
title.Parent = mainFrame

-- 5 КНОПОК ТЕЛЕПОРТА
local btnNames = {"Место 1 (-412,17,467)", "Место 2 (-436,93,49)", "Место 3 (-481,69,0)", "Место 4 (524,152,-411)", "Место 5 (271,25292,-871)"}

for i = 1, 5 do
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0.9, 0, 0, 50)
    btn.Position = UDim2.new(0.05, 0, 0, 50 + (i-1) * 60)
    btn.Text = "🚀 " .. btnNames[i]
    btn.BackgroundColor3 = Color3.fromRGB(50, 150, 255)
    btn.TextColor3 = Color3.new(1,1,1)
    btn.TextScaled = true
    btn.Font = Enum.Font.Gotham
    btn.Parent = mainFrame
    
    -- ПРОСТОЙ ТЕЛЕПОРТ (как в самом начале!)
    btn.MouseButton1Click:Connect(function()
        if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            player.Character.HumanoidRootPart.CFrame = locations[i]
            print("🌟 Телепорт #" .. i .. " выполнен!")
        end
    end)
end

-- КНОПКА ЗАКРЫТЬ
local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 30, 0, 30)
closeBtn.Position = UDim2.new(1, -35, 0, 5)
closeBtn.Text = "✕"
closeBtn.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
closeBtn.TextColor3 = Color3.new(1,1,1)
closeBtn.TextScaled = true
closeBtn.Parent = title

closeBtn.MouseButton1Click:Connect(function()
    screenGui:Destroy()
end)

-- INSERT = Показать/Скрыть
UserInputService.InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.Insert then
        screenGui.Enabled = not screenGui.Enabled
    end
end)

print("⭐ АСТРА TELEPORT v1 загружена! Кликай кнопки 1-5!")
