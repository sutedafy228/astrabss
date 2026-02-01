-- 🔥 ПРОСТОЙ АСТРА TELEPORT 🔥
-- КОПИРУЙ → VELOCITY → EXECUTE = РАБОТАЕТ!

local Players = game:GetService("Players")
local player = Players.LocalPlayer

-- ТВОИ 5 МЕСТ (только позиция X,Y,Z)
local tp1 = CFrame.new(-412.21, 17.17, 466.99)
local tp2 = CFrame.new(-436.20, 93.26, 49.28)
local tp3 = CFrame.new(-481.16, 69.39, -0.23)
local tp4 = CFrame.new(524.30, 152.29, -410.54)
local tp5 = CFrame.new(271.45, 25292.31, -871.28)

-- GUI
local gui = Instance.new("ScreenGui")
gui.Parent = player:WaitForChild("PlayerGui")

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 250, 0, 300)
frame.Position = UDim2.new(0.5, -125, 0.5, -150)
frame.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
frame.Parent = gui

-- КНОПКИ (ПРЯМОЙ ТЕЛЕПОРТ)
local btn1 = Instance.new("TextButton")
btn1.Size = UDim2.new(0.9, 0, 0, 50)
btn1.Position = UDim2.new(0.05, 0, 0, 10)
btn1.Text = "1: -412, 17, 467"
btn1.Parent = frame
btn1.MouseButton1Click:Connect(function()
    player.Character.HumanoidRootPart.CFrame = tp1
end)

local btn2 = Instance.new("TextButton")
btn2.Size = UDim2.new(0.9, 0, 0, 50)
btn2.Position = UDim2.new(0.05, 0, 0, 70)
btn2.Text = "2: -436, 93, 49"
btn2.Parent = frame
btn2.MouseButton1Click:Connect(function()
    player.Character.HumanoidRootPart.CFrame = tp2
end)

local btn3 = Instance.new("TextButton")
btn3.Size = UDim2.new(0.9, 0, 0, 50)
btn3.Position = UDim2.new(0.05, 0, 0, 130)
btn3.Text = "3: -481, 69, 0"
btn3.Parent = frame
btn3.MouseButton1Click:Connect(function()
    player.Character.HumanoidRootPart.CFrame = tp3
end)

local btn4 = Instance.new("TextButton")
btn4.Size = UDim2.new(0.9, 0, 0, 50)
btn4.Position = UDim2.new(0.05, 0, 0, 190)
btn4.Text = "4: 524, 152, -411"
btn4.Parent = frame
btn4.MouseButton1Click:Connect(function()
    player.Character.HumanoidRootPart.CFrame = tp4
end)

local btn5 = Instance.new("TextButton")
btn5.Size = UDim2.new(0.9, 0, 0, 50)
btn5.Position = UDim2.new(0.05, 0, 0, 250)
btn5.Text = "5: 271, 25292, -871"
btn5.Parent = frame
btn5.MouseButton1Click:Connect(function()
    player.Character.HumanoidRootPart.CFrame = tp5
end)

print("⭐ АСТРА TELEPORT Готов! Кликай кнопки!")
