-- 🌟 ASTRA STAR JELLY PREMIUM DESIGN 🌟
-- Xeno ✓ Velocity ✓ Codex Delta ✓ ULTRA BEAUTIFUL!

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- STAR JELLY LOCATIONS
local starJellyLocs = {
    CFrame.new(-412.21, 17.17, 466.99),
    CFrame.new(-436.20, 93.26, 49.28), 
    CFrame.new(-481.16, 69.39, -0.23),
    CFrame.new(524.30, 152.29, -410.54),
    CFrame.new(271.45, 25292.31, -871.28)
}

-- MAIN GUI
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "AstraStarJellyPremium"
screenGui.Parent = playerGui

-- MAIN FRAME (Glass Effect)
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 320, 0, 380)
mainFrame.Position = UDim2.new(0.5, -160, 0.5, -190)
mainFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 25)
mainFrame.BorderSizePixel = 0
mainFrame.Parent = screenGui

-- GLASS CORNER ROUNDER
local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 20)
corner.Parent = mainFrame

-- SHADOW EFFECT
local shadow = Instance.new("Frame")
shadow.Size = UDim2.new(1, 10, 1, 10)
shadow.Position = UDim2.new(0, -5, 0, -5)
shadow.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
shadow.BackgroundTransparency = 0.7
shadow.ZIndex = 0
shadow.Parent = mainFrame
local shadowCorner = Instance.new("UICorner")
shadowCorner.CornerRadius = UDim.new(0, 25)
shadowCorner.Parent = shadow

-- GRADIENT BACKGROUND
local gradient = Instance.new("UIGradient")
gradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(30, 40, 80)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(10, 20, 50))
}
gradient.Rotation = 45
gradient.Parent = mainFrame

-- ✨ GLOWING TITLE BAR ✨
local titleBar = Instance.new("Frame")
titleBar.Size = UDim2.new(1, 0, 0, 60)
titleBar.BackgroundColor3 = Color3.fromRGB(255, 215, 0)
titleBar.BorderSizePixel = 0
titleBar.Parent = mainFrame

local titleCorner = Instance.new("UICorner")
titleCorner.CornerRadius = UDim.new(0, 20)
titleCorner.Parent = titleBar

local titleGradient = Instance.new("UIGradient")
titleGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 100)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 215, 0)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 180, 0))
}
titleGradient.Parent = titleBar

local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(0.85, 0, 1, 0)
titleLabel.Text = "✨ ASTRA STAR JELLY ✨"
titleLabel.TextColor3 = Color3.fromRGB(15, 15, 35)
titleLabel.BackgroundTransparency = 1
titleLabel.TextScaled = true
titleLabel.Font = Enum.Font.GothamBold
titleLabel.Parent = titleBar

-- CLOSE BUTTON (Premium Style)
local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 40, 0, 40)
closeBtn.Position = UDim2.new(1, -45, 0, 10)
closeBtn.Text = "✕"
closeBtn.BackgroundColor3 = Color3.fromRGB(255, 80, 80)
closeBtn.TextColor3 = Color3.new(1,1,1)
closeBtn.TextScaled = true
closeBtn.Font = Enum.Font.GothamBold
closeBtn.Parent = titleBar

local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(0, 10)
closeCorner.Parent = closeBtn

-- BUTTONS (Neon Glow Effect)
local jellyNames = {"Star Jelly 1", "Star Jelly 2", "Star Jelly 3", "Star Jelly 4", "Star Jelly 5"}

for i = 1, 5 do
    -- Button Frame
    local btnFrame = Instance.new("Frame")
    btnFrame.Size = UDim2.new(0.9, 0, 0, 55)
    btnFrame.Position = UDim2.new(0.05, 0, 0, 75 + (i-1) * 65)
    btnFrame.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
    btnFrame.BorderSizePixel = 0
    btnFrame.Parent = mainFrame
    
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 15)
    btnCorner.Parent = btnFrame
    
    local btnGradient = Instance.new("UIGradient")
    btnGradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 200, 255)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 120, 220))
    }
    btnGradient.Parent = btnFrame
    
    -- Button Text
    local btnText = Instance.new("TextButton")
    btnText.Size = UDim2.new(1, 0, 1, 0)
    btnText.Text = "⭐ " .. jellyNames[i]
    btnText.BackgroundTransparency = 1
    btnText.TextColor3 = Color3.new(1,1,1)
    btnText.TextScaled = true
    btnText.Font = Enum.Font.GothamBold
    btnText.Parent = btnFrame
    
    -- TELEPORT
    btnText.MouseButton1Click:Connect(function()
        if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            player.Character.HumanoidRootPart.CFrame = starJellyLocs[i]
            -- BUTTON FLASH EFFECT
            local flash = TweenService:Create(btnFrame, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(255, 255, 100)})
            flash:Play()
            flash.Completed:Connect(function()
                btnFrame.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
            end)
            print("✨ Teleported to " .. jellyNames[i] .. "!")
        end
    end)
end

-- HOVER EFFECTS FOR CLOSE BUTTON
closeBtn.MouseEnter:Connect(function()
    TweenService:Create(closeBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(255, 120, 120)}):Play()
end)
closeBtn.MouseLeave:Connect(function()
    TweenService:Create(closeBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(255, 80, 80)}):Play()
end)

closeBtn.MouseButton1Click:Connect(function()
    TweenService:Create(mainFrame, TweenInfo.new(0.5, Enum.EasingStyle.Back), {Size = UDim2.new(0, 0, 0, 0)}):Play()
    game:GetService("Debris"):AddItem(screenGui, 0.6)
end)

-- ✅ SMOOTH DRAGGING
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

-- INSERT Toggle
UserInputService.InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.Insert then
        screenGui.Enabled = not screenGui.Enabled
    end
end)

print("🌟 ASTRA STAR JELLY PREMIUM loaded! ✨")
