-- Astra v1.0
-- by Script Developer

local Astra = {
    Version = "1.0",
    Name = "Astra"
}

-- Основные переменные
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- Конфигурация
local Config = {
    WalkSpeed = 30,
    Enabled = false,
    UIHidden = false
}

-- Создание интерфейса
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "AstraUI"
ScreenGui.Parent = game:GetService("CoreGui") or LocalPlayer:WaitForChild("PlayerGui")

-- Основной фрейм
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 350, 0, 280)
MainFrame.Position = UDim2.new(0.5, -175, 0.5, -140)
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

-- Скругление углов
local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 10)
UICorner.Parent = MainFrame

-- Тень
local UIStroke = Instance.new("UIStroke")
UIStroke.Color = Color3.fromRGB(60, 60, 80)
UIStroke.Thickness = 2
UIStroke.Parent = MainFrame

-- Заголовок
local TitleFrame = Instance.new("Frame")
TitleFrame.Size = UDim2.new(1, 0, 0, 40)
TitleFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 50)
TitleFrame.BorderSizePixel = 0
TitleFrame.Parent = MainFrame

local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 10)
TitleCorner.Parent = TitleFrame

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 1, 0)
Title.BackgroundTransparency = 1
Title.Text = "🚀 Astra v1.0"
Title.TextColor3 = Color3.fromRGB(220, 220, 255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 18
Title.Parent = TitleFrame

-- Кнопка скрытия
local HideButton = Instance.new("TextButton")
HideButton.Size = UDim2.new(0, 30, 0, 30)
HideButton.Position = UDim2.new(1, -35, 0, 5)
HideButton.BackgroundColor3 = Color3.fromRGB(45, 45, 65)
HideButton.BorderSizePixel = 0
HideButton.Text = "─"
HideButton.TextColor3 = Color3.fromRGB(220, 220, 255)
HideButton.Font = Enum.Font.GothamBold
HideButton.TextSize = 16
HideButton.Parent = TitleFrame

local HideCorner = Instance.new("UICorner")
HideCorner.CornerRadius = UDim.new(0, 5)
HideCorner.Parent = HideButton

-- Контент
local ContentFrame = Instance.new("Frame")
ContentFrame.Size = UDim2.new(1, -20, 1, -60)
ContentFrame.Position = UDim2.new(0, 10, 0, 50)
ContentFrame.BackgroundTransparency = 1
ContentFrame.Parent = MainFrame

-- Настройка скорости
local SpeedSection = Instance.new("Frame")
SpeedSection.Size = UDim2.new(1, 0, 0, 120)
SpeedSection.BackgroundColor3 = Color3.fromRGB(35, 35, 50)
SpeedSection.BorderSizePixel = 0
SpeedSection.Parent = ContentFrame

local SpeedCorner = Instance.new("UICorner")
SpeedCorner.CornerRadius = UDim.new(0, 8)
SpeedCorner.Parent = SpeedSection

local SpeedTitle = Instance.new("TextLabel")
SpeedTitle.Size = UDim2.new(1, 0, 0, 30)
SpeedTitle.BackgroundTransparency = 1
SpeedTitle.Text = "Скорость бега"
SpeedTitle.TextColor3 = Color3.fromRGB(180, 180, 220)
SpeedTitle.Font = Enum.Font.Gotham
SpeedTitle.TextSize = 14
SpeedTitle.Position = UDim2.new(0, 10, 0, 0)
SpeedTitle.TextXAlignment = Enum.TextXAlignment.Left
SpeedTitle.Parent = SpeedSection

-- Ползунок скорости
local SpeedSlider = Instance.new("Frame")
SpeedSlider.Size = UDim2.new(1, -20, 0, 40)
SpeedSlider.Position = UDim2.new(0, 10, 0, 40)
SpeedSlider.BackgroundColor3 = Color3.fromRGB(45, 45, 65)
SpeedSlider.BorderSizePixel = 0
SpeedSlider.Parent = SpeedSection

local SliderCorner = Instance.new("UICorner")
SliderCorner.CornerRadius = UDim.new(0, 6)
SliderCorner.Parent = SpeedSlider

local SpeedValue = Instance.new("TextLabel")
SpeedValue.Size = UDim2.new(0, 60, 1, 0)
SpeedValue.Position = UDim2.new(1, -65, 0, 0)
SpeedValue.BackgroundColor3 = Color3.fromRGB(80, 120, 200)
SpeedValue.Text = tostring(Config.WalkSpeed)
SpeedValue.TextColor3 = Color3.white
SpeedValue.Font = Enum.Font.GothamBold
SpeedValue.TextSize = 16
SpeedValue.Parent = SpeedSlider

local ValueCorner = Instance.new("UICorner")
ValueCorner.CornerRadius = UDim.new(0, 6)
ValueCorner.Parent = SpeedValue

local SliderFill = Instance.new("Frame")
SliderFill.Size = UDim2.new((Config.WalkSpeed - 30) / 60, 0, 1, 0)
SliderFill.BackgroundColor3 = Color3.fromRGB(100, 150, 255)
SliderFill.BorderSizePixel = 0
SliderFill.Parent = SpeedSlider

local FillCorner = Instance.new("UICorner")
FillCorner.CornerRadius = UDim.new(0, 6)
FillCorner.Parent = SliderFill

-- Кнопка включения
local ToggleFrame = Instance.new("Frame")
ToggleFrame.Size = UDim2.new(1, 0, 0, 50)
ToggleFrame.Position = UDim2.new(0, 0, 0, 130)
ToggleFrame.BackgroundTransparency = 1
ToggleFrame.Parent = ContentFrame

local ToggleButton = Instance.new("TextButton")
ToggleButton.Size = UDim2.new(1, 0, 1, 0)
ToggleButton.BackgroundColor3 = Color3.fromRGB(45, 45, 65)
ToggleButton.BorderSizePixel = 0
ToggleButton.Text = ""
ToggleButton.Parent = ToggleFrame

local ToggleCorner = Instance.new("UICorner")
ToggleCorner.CornerRadius = UDim.new(0, 8)
ToggleCorner.Parent = ToggleButton

local ToggleLabel = Instance.new("TextLabel")
ToggleLabel.Size = UDim2.new(0.7, 0, 1, 0)
ToggleLabel.Position = UDim2.new(0, 15, 0, 0)
ToggleLabel.BackgroundTransparency = 1
ToggleLabel.Text = "Enable Walk Speed"
ToggleLabel.TextColor3 = Color3.fromRGB(220, 220, 255)
ToggleLabel.Font = Enum.Font.Gotham
ToggleLabel.TextSize = 16
ToggleLabel.TextXAlignment = Enum.TextXAlignment.Left
ToggleLabel.Parent = ToggleButton

local ToggleSwitch = Instance.new("Frame")
ToggleSwitch.Size = UDim2.new(0, 40, 0, 20)
ToggleSwitch.Position = UDim2.new(1, -50, 0.5, -10)
ToggleSwitch.BackgroundColor3 = Color3.fromRGB(80, 80, 100)
ToggleSwitch.BorderSizePixel = 0
ToggleSwitch.Parent = ToggleButton

local SwitchCorner = Instance.new("UICorner")
SwitchCorner.CornerRadius = UDim.new(1, 0)
SwitchCorner.Parent = ToggleSwitch

local ToggleCircle = Instance.new("Frame")
ToggleCircle.Size = UDim2.new(0, 16, 0, 16)
ToggleCircle.Position = UDim2.new(0, 2, 0, 2)
ToggleCircle.BackgroundColor3 = Color3.fromRGB(220, 220, 255)
ToggleCircle.BorderSizePixel = 0
ToggleCircle.Parent = ToggleSwitch

local CircleCorner = Instance.new("UICorner")
CircleCorner.CornerRadius = UDim.new(1, 0)
CircleCorner.Parent = ToggleCircle

-- Кнопка скрытия интерфейса
local HideUIToggle = Instance.new("TextButton")
HideUIToggle.Size = UDim2.new(1, 0, 0, 40)
HideUIToggle.Position = UDim2.new(0, 0, 1, -40)
HideUIToggle.BackgroundColor3 = Color3.fromRGB(80, 120, 200)
HideUIToggle.BorderSizePixel = 0
HideUIToggle.Text = "Скрыть интерфейс (H)"
HideUIToggle.TextColor3 = Color3.white
HideUIToggle.Font = Enum.Font.GothamBold
HideUIToggle.TextSize = 14
HideUIToggle.Parent = ContentFrame

local HideUICorner = Instance.new("UICorner")
HideUICorner.CornerRadius = UDim.new(0, 8)
HideUICorner.Parent = HideUIToggle

-- Функции
local function updateWalkSpeed()
    if Config.Enabled and LocalPlayer.Character then
        local humanoid = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            humanoid.WalkSpeed = Config.WalkSpeed
        end
    end
end

local function toggleWalkSpeed()
    Config.Enabled = not Config.Enabled
    
    if Config.Enabled then
        ToggleSwitch.BackgroundColor3 = Color3.fromRGB(80, 200, 120)
        ToggleCircle.Position = UDim2.new(1, -18, 0, 2)
        updateWalkSpeed()
    else
        ToggleSwitch.BackgroundColor3 = Color3.fromRGB(80, 80, 100)
        ToggleCircle.Position = UDim2.new(0, 2, 0, 2)
        
        if LocalPlayer.Character then
            local humanoid = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
            if humanoid then
                humanoid.WalkSpeed = 16
            end
        end
    end
end

local function toggleUI()
    Config.UIHidden = not Config.UIHidden
    MainFrame.Visible = not Config.UIHidden
    
    if Config.UIHidden then
        HideUIToggle.Text = "Показать интерфейс (H)"
    else
        HideUIToggle.Text = "Скрыть интерфейс (H)"
    end
end

-- Обработка кликов
SpeedSlider.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        local connection
        connection = RunService.RenderStepped:Connect(function()
            local mouse = game:GetService("Players").LocalPlayer:GetMouse()
            local relativeX = math.clamp(mouse.X - SpeedSlider.AbsolutePosition.X, 0, SpeedSlider.AbsoluteSize.X)
            local percentage = relativeX / SpeedSlider.AbsoluteSize.X
            
            Config.WalkSpeed = math.floor(30 + (percentage * 60))
            Config.WalkSpeed = math.clamp(Config.WalkSpeed, 30, 90)
            
            SpeedValue.Text = tostring(Config.WalkSpeed)
            SliderFill.Size = UDim2.new((Config.WalkSpeed - 30) / 60, 0, 1, 0)
            
            updateWalkSpeed()
        end)
        
        UIS.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                connection:Disconnect()
            end
        end)
    end
end)

ToggleButton.MouseButton1Click:Connect(toggleWalkSpeed)
HideUIToggle.MouseButton1Click:Connect(toggleUI)
HideButton.MouseButton1Click:Connect(toggleUI)

-- Горячие клавиши
UIS.InputBegan:Connect(function(input, processed)
    if not processed then
        if input.KeyCode == Enum.KeyCode.H then
            toggleUI()
        end
    end
end)

-- Автоматическое обновление скорости при возрождении
LocalPlayer.CharacterAdded:Connect(function()
    if Config.Enabled then
        wait(0.5)
        updateWalkSpeed()
    end
end)

-- Информация при запуске
print("====================================")
print("Astra v1.0 успешно запущен!")
print("Скорость бега: " .. Config.WalkSpeed)
print("Включено: " .. tostring(Config.Enabled))
print("Горячая клавиша скрытия: H")
print("====================================")
