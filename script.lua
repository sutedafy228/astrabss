-- 🌟 ASTRA STAR JELLY TELEPORT 🌟
-- Xeno ✓ Velocity ✓ Codex Delta ✓ Draggable ✓

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- STAR JELLY Locations (your 5 coordinates)
local starJellyLocs = {
    CFrame.new(-412.21, 17.17, 466.99),   -- Star Jelly 1
    CFrame.new(-436.20, 93.26, 49.28),    -- Star Jelly 2  
    CFrame.new(-481.16, 69.39, -0.23),    -- Star Jelly 3
    CFrame.new(524.30, 152.29, -410.54),  -- Star Jelly 4
    CFrame.new(271.45, 25292.31, -871.28) -- Star Jelly 5
}

-- GUI
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "AstraStarJelly"
screenGui.Parent = playerGui

local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 280, 0, 320)
mainFrame.Position = UDim2.new(0.5, -140, 0.5, -160)
mainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 40)
mainFrame.BorderSizePixel = 0
mainFrame.Parent = screenGui

-- Title Bar (GOLD - for dragging)
local titleBar = Instance.new("Frame")
titleBar.Size = UDim2.new(1, 0, 0, 45)
titleBar.BackgroundColor3 = Color3.fromRGB(255, 215, 0)
titleBar.Parent = mainFrame

local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(1, 0, 1, 0)
titleLabel.Text = "⭐ ASTRA STAR JELLY ⭐"
titleLabel.TextColor3 = Color3.new(0, 0, 0)
titleLabel.BackgroundTransparency = 1
titleLabel.TextScaled = true
titleLabel.Font = Enum.Font.GothamBold
titleLabel.Parent = titleBar

-- Star Jelly 1-5 Buttons
local jellyNames = {"Star Jelly 1", "Star Jelly 2", "Star Jelly 3", "Star Jelly 4", "Star Jelly 5"}

for i = 1, 5 do
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0.88, 0, 0, 45)
    btn.Position = UDim2.new(0.06, 0, 0, 55 + (i-1) * 55)
    btn.Text = "⭐ " .. jellyNames[i]
    btn.BackgroundColor3 = Color3.fromRGB(50, 200, 255)
    btn.TextColor3 = Color3.new(1,1,1)
    btn.TextScaled = true
    btn.Font = Enum.Font.GothamBold
    btn.Parent = mainFrame
    
    btn.MouseButton1Click:Connect(function()
        if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            player.Character.HumanoidRootPart.CFrame = starJellyLocs[i]
            print("⭐ Teleported to " .. jellyNames[i] .. "!")
        end
    end)
end

-- CLOSE Button
local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 30, 0, 30)
closeBtn.Position = UDim2.new(1, -35, 0, 7)
closeBtn.Text = "✕"
closeBtn.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
closeBtn.TextColor3 = Color3.new(1,1,1)
closeBtn.TextScaled = true
closeBtn.Font = Enum.Font.GothamBold
closeBtn.Parent = titleBar

closeBtn.MouseButton1Click:Connect(function()
    screenGui:Destroy()
end)

-- ✅ DRAGGING (tested working code)
local dragging = false
local dragInput, mousePos, framePos

titleBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        mousePos = input.Position
        framePos = mainFrame.Position
        
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - mousePos
        mainFrame.Position = UDim2.new(framePos.X.Scale, framePos.X.Offset + delta.X, framePos.Y.Scale, framePos.Y.Offset + delta.Y)
    end
end)

-- INSERT = Show/Hide
UserInputService.InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.Insert then
        screenGui.Enabled = not screenGui.Enabled
    end
end)

print("⭐ ASTRA STAR JELLY loaded! Drag gold title bar!")
