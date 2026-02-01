-- BSS Delta Fixed Script (2026) - Работает в Drlta Executor
local Players = game:GetService("Players")
local player = Players.LocalPlayer

-- Проверка PlaceId
if game.PlaceId ~= 1537690962 then
    print("НЕ BSS! PlaceId:", game.PlaceId)
    return
end

print("BSS Script LOADED! ✅")

-- Простой GUI через ScreenGui (Delta friendly)
local sg = Instance.new("ScreenGui")
sg.Name = "BSSHack"
sg.Parent = player.PlayerGui

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 300, 0, 400)
frame.Position = UDim2.new(0, 10, 0, 10)
frame.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
frame.BorderSizePixel = 0
frame.Parent = sg

-- Заголовок
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 50)
title.Position = UDim2.new(0, 0, 0, 0)
title.BackgroundColor3 = Color3.new(0, 0.5, 1)
title.Text = "🐝 BSS ULTIMATE v2.0"
title.TextColor3 = Color3.new(1,1,1)
title.TextScaled = true
title.Font = Enum.Font.GothamBold
title.Parent = frame

-- AutoFarm Toggle
local autoFarmBtn = Instance.new("TextButton")
autoFarmBtn.Size = UDim2.new(0.9, 0, 0, 40)
autoFarmBtn.Position = UDim2.new(0.05, 0, 0, 70)
autoFarmBtn.BackgroundColor3 = Color3.new(0.2, 0.8, 0.2)
autoFarmBtn.Text = "AutoFarm ❌"
autoFarmBtn.TextColor3 = Color3.new(1,1,1)
autoFarmBtn.TextScaled = true
autoFarmBtn.Parent = frame

local autoFarmEnabled = false
autoFarmBtn.MouseButton1Click:Connect(function()
    autoFarmEnabled = not autoFarmEnabled
    autoFarmBtn.Text = autoFarmEnabled and "AutoFarm ✅" or "AutoFarm ❌"
    autoFarmBtn.BackgroundColor3 = autoFarmEnabled and Color3.new(0, 1, 0) or Color3.new(0.8, 0.2, 0.2)
    
    spawn(function()
        while autoFarmEnabled and player.Character do
            -- Собираем токены поблизости
            for _, obj in pairs(workspace:GetChildren()) do
                if obj.Name == "Token" and obj:FindFirstChild("ClickDetector") then
                    local dist = (obj.Position - player.Character.HumanoidRootPart.Position).Magnitude
                    if dist < 100 then
                        fireclickdetector(obj.ClickDetector)
                    end
                end
            end
            
            -- Телепорт к Sunflower Field (координаты поля)
            if player.Character.HumanoidRootPart then
                player.Character.HumanoidRootPart.CFrame = CFrame.new(109, 48, 485)
            end
            
            wait(0.5)
        end
    end)
end)

-- AutoDig Toggle
local autoDigBtn = Instance.new("TextButton")
autoDigBtn.Size = UDim2.new(0.9, 0, 0, 40)
autoDigBtn.Position = UDim2.new(0.05, 0, 0, 120)
autoDigBtn.BackgroundColor3 = Color3.new(0.8, 0.2, 0.2)
autoDigBtn.Text = "AutoDig ❌"
autoDigBtn.TextColor3 = Color3.new(1,1,1)
autoDigBtn.TextScaled = true
autoDigBtn.Parent = frame

local autoDigEnabled = false
autoDigBtn.MouseButton1Click:Connect(function()
    autoDigEnabled = not autoDigEnabled
    autoDigBtn.Text = autoDigEnabled and "AutoDig ✅" or "AutoDig ❌"
    autoDigBtn.BackgroundColor3 = autoDigEnabled and Color3.new(0, 1, 0) or Color3.new(0.8, 0.2, 0.2)
end)

-- SpeedHack Toggle
local speedBtn = Instance.new("TextButton")
speedBtn.Size = UDim2.new(0.9, 0, 0, 40)
speedBtn.Position = UDim2.new(0.05, 0, 0, 170)
speedBtn.BackgroundColor3 = Color3.new(0.8, 0.2, 0.2)
speedBtn.Text = "Speed 50 ❌"
speedBtn.TextColor3 = Color3.new(1,1,1)
speedBtn.TextScaled = true
speedBtn.Parent = frame

local speedEnabled = false
speedBtn.MouseButton1Click:Connect(function()
    speedEnabled = not speedEnabled
    if speedEnabled and player.Character then
        player.Character.Humanoid.WalkSpeed = 80
        speedBtn.Text = "Speed 80 ✅"
        speedBtn.BackgroundColor3 = Color3.new(0, 1, 0)
    else
        if player.Character then
            player.Character.Humanoid.WalkSpeed = 16
        end
        speedBtn.Text = "Speed 50 ❌"
        speedBtn.BackgroundColor3 = Color3.new(0.8, 0.2, 0.2)
    end
end)

-- Закрыть кнопку
local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 30, 0, 30)
closeBtn.Position = UDim2.new(1, -35, 0, 5)
closeBtn.BackgroundColor3 = Color3.new(1, 0, 0)
closeBtn.Text = "X"
closeBtn.TextColor3 = Color3.new(1,1,1)
closeBtn.TextScaled = true
closeBtn.Parent = frame

closeBtn.MouseButton1Click:Connect(function()
    sg:Destroy()
end)

-- AutoDig Loop (отдельный)
spawn(function()
    while wait(0.1) do
        if autoDigEnabled then
            -- Имитация клика мышью
            mouse1click()
        end
    end
end)

print("GUI создан! Нажми Execute повторно если не появилось")
