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
    WalkSpeed = 50,
    Enabled = false,
    UIHidden = false,
    Minimized = false
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

-- Заголовок (всегда видимый)
local TitleFrame = Instance.new("Frame")
TitleFrame.Size = UDim2.new(1, 0, 0, 40)
TitleFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 50)
TitleFrame.BorderSizePixel = 0
TitleFrame.Parent = MainFrame

local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 10)
TitleCorner.Parent = TitleFrame

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -40, 1, 0)
Title.Position = UDim2.new(0, 10, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "🚀 Astra v1.0"
Title.TextColor3 = Color3.fromRGB(220, 220, 255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 18
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = TitleFrame

-- Кнопка скрытия/показа
local MinimizeButton = Instance.new("TextButton")
MinimizeButton.Size = UDim2.new(0, 30, 0, 30)
MinimizeButton.Position = UDim2.new(1, -35, 0, 5)
MinimizeButton.BackgroundColor3 = Color3.fromRGB(45, 45, 65)
MinimizeButton.BorderSizePixel = 0
MinimizeButton.Text = "−"
MinimizeButton.TextColor3 = Color3.fromRGB(220, 220, 255)
MinimizeButton.Font = Enum.Font.GothamBold
MinimizeButton.TextSize = 20
MinimizeButton.Parent = TitleFrame

local MinimizeCorner = Instance.new("UICorner")
MinimizeCorner.CornerRadius = UDim.new(0, 5)
MinimizeCorner.Parent = MinimizeButton

-- Контент (будет скрываться при минимизации)
local ContentFrame = Instance.new("Frame")
ContentFrame.Name = "ContentFrame"
ContentFrame.Size = UDim2.new(1, -20, 1, -60)
ContentFrame.Position = UDim2.new(0, 10, 0, 50)
ContentFrame.BackgroundTransparency = 1
ContentFrame.Visible = true
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
SpeedTitle.Text = "Настройка скорости"
SpeedTitle.TextColor3 = Color3.fromRGB(180, 180, 220)
SpeedTitle.Font = Enum.Font.Gotham
SpeedTitle.TextSize = 14
SpeedTitle.Position = UDim2.new(0, 10, 0, 0)
SpeedTitle.TextXAlignment = Enum.TextXAlignment.Left
SpeedTitle.Parent = SpeedSection

-- Ползунок скорости (40-90)
local SpeedSlider = Instance.new("Frame")
SpeedSlider.Size = UDim2.new(1, -20, 0, 40)
SpeedSlider.Position = UDim2.new(0, 10, 0, 40)
SpeedSlider.BackgroundColor3 = Color3.fromRGB(45, 45, 65)
SpeedSlider.BorderSizePixel = 0
SpeedSlider.Parent = SpeedSection

local SliderCorner = Instance.new("UICorner")
SliderCorner.CornerRadius = UDim.new(0, 6)
SliderCorner.Parent = SpeedSlider

-- Текущее значение скорости
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

-- Заполнение ползунка
local SliderFill = Instance.new("Frame")
SliderFill.Size = UDim2.new((Config.WalkSpeed - 40) / 50, 0, 1, 0)
SliderFill.BackgroundColor3 = Color3.fromRGB(100, 150, 255)
SliderFill.BorderSizePixel = 0
SliderFill.Parent = SpeedSlider

local FillCorner = Instance.new("UICorner")
FillCorner.CornerRadius = UDim.new(0, 6)
FillCorner.Parent = SliderFill

-- Отображение диапазона
local RangeLabel = Instance.new("TextLabel")
RangeLabel.Size = UDim2.new(1, -20, 0, 20)
RangeLabel.Position = UDim2.new(0, 10, 0, 85)
RangeLabel.BackgroundTransparency = 1
RangeLabel.Text = "Диапазон: 40 - 90"
RangeLabel.TextColor3 = Color3.fromRGB(150, 150, 180)
RangeLabel.Font = Enum.Font.Gotham
RangeLabel.TextSize = 12
RangeLabel.TextXAlignment = Enum.TextXAlignment.Center
RangeLabel.Parent = SpeedSection

-- Переключатель Enable Speed Hack
local ToggleFrame = Instance.new("Frame")
ToggleFrame.Size = UDim2.new(1, 0, 0, 60)
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

-- Текст переключателя
local ToggleLabel = Instance.new("TextLabel")
ToggleLabel.Size = UDim2.new(0.7, 0, 1, 0)
ToggleLabel.Position = UDim2.new(0, 15, 0, 0)
ToggleLabel.BackgroundTransparency = 1
ToggleLabel.Text = "Enable Speed Hack"
ToggleLabel.TextColor3 = Color3.fromRGB(220, 220, 255)
ToggleLabel.Font = Enum.Font.Gotham
ToggleLabel.TextSize = 16
ToggleLabel.TextXAlignment = Enum.TextXAlignment.Left
ToggleLabel.Parent = ToggleButton

-- Квадрат для галочки
local Checkbox = Instance.new("Frame")
Checkbox.Size = UDim2.new(0, 24, 0, 24)
Checkbox.Position = UDim2.new(1, -40, 0.5, -12)
Checkbox.BackgroundColor3 = Color3.fromRGB(80, 80, 100)
Checkbox.BorderSizePixel = 0
Checkbox.Parent = ToggleButton

local CheckboxCorner = Instance.new("UICorner")
CheckboxCorner.CornerRadius = UDim.new(0, 4)
CheckboxCorner.Parent = Checkbox

-- Галочка
local Checkmark = Instance.new("ImageLabel")
Checkmark.Size = UDim2.new(0, 18, 0, 18)
Checkmark.Position = UDim2.new(0.5, -9, 0.5, -9)
Checkmark.BackgroundTransparency = 1
Checkmark.Image = "rbxassetid://7072717429" -- Белая галочка
Checkmark.ImageColor3 = Color3.fromRGB(255, 255, 255)
Checkmark.Visible = false
Checkmark.Parent = Checkbox

-- Индикатор состояния
local StatusIndicator = Instance.new("Frame")
StatusIndicator.Size = UDim2.new(0, 8, 0, 8)
StatusIndicator.Position = UDim2.new(0, 10, 1, -20)
StatusIndicator.BackgroundColor3 = Color3.fromRGB(255, 80, 80)
StatusIndicator.BorderSizePixel = 0
StatusIndicator.Parent = ToggleButton

local StatusCorner = Instance.new("UICorner")
StatusCorner.CornerRadius = UDim.new(1, 0)
StatusCorner.Parent = StatusIndicator

local StatusLabel = Instance.new("TextLabel")
StatusLabel.Size = UDim2.new(1, -25, 0, 20)
StatusLabel.Position = UDim2.new(0, 25, 1, -25)
StatusLabel.BackgroundTransparency = 1
StatusLabel.Text = "Выключено"
StatusLabel.TextColor3 = Color3.fromRGB(255, 120, 120)
StatusLabel.Font = Enum.Font.Gotham
StatusLabel.TextSize = 12
StatusLabel.TextXAlignment = Enum.TextXAlignment.Left
StatusLabel.Parent = ToggleButton

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

local function updateToggleUI()
    Checkmark.Visible = Config.Enabled
    if Config.Enabled then
        Checkbox.BackgroundColor3 = Color3.fromRGB(80, 200, 120)
        StatusIndicator.BackgroundColor3 = Color3.fromRGB(80, 200, 120)
        StatusLabel.Text = "Включено"
        StatusLabel.TextColor3 = Color3.fromRGB(120, 255, 120)
        updateWalkSpeed()
    else
        Checkbox.BackgroundColor3 = Color3.fromRGB(80, 80, 100)
        StatusIndicator.BackgroundColor3 = Color3.fromRGB(255, 80, 80)
        StatusLabel.Text = "Выключено"
        StatusLabel.TextColor3 = Color3.fromRGB(255, 120, 120)
        
        if LocalPlayer.Character then
            local humanoid = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
            if humanoid then
                humanoid.WalkSpeed = 16
            end
        end
    end
end

local function toggleWalkSpeed()
    Config.Enabled = not Config.Enabled
    updateToggleUI()
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

local function toggleMinimize()
    Config.Minimized = not Config.Minimized
    
    if Config.Minimized then
        MainFrame.Size = UDim2.new(0, 350, 0, 40)
        ContentFrame.Visible = false
        MinimizeButton.Text = "+"
        MinimizeButton.TextSize = 18
    else
        MainFrame.Size = UDim2.new(0, 350, 0, 280)
        ContentFrame.Visible = true
        MinimizeButton.Text = "−"
        MinimizeButton.TextSize = 20
    end
end

-- Обработка ползунка скорости (40-90)
SpeedSlider.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        local connection
        connection = RunService.RenderStepped:Connect(function()
            local mouse = game:GetService("Players").LocalPlayer:GetMouse()
            local relativeX = math.clamp(mouse.X - SpeedSlider.AbsolutePosition.X, 0, SpeedSlider.AbsoluteSize.X)
            local percentage = relativeX / SpeedSlider.AbsoluteSize.X
            
            Config.WalkSpeed = math.floor(40 + (percentage * 50))
            Config.WalkSpeed = math.clamp(Config.WalkSpeed, 40, 90)
            
            SpeedValue.Text = tostring(Config.WalkSpeed)
            SliderFill.Size = UDim2.new((Config.WalkSpeed - 40) / 50, 0, 1, 0)
            
            updateWalkSpeed()
        end)
        
        UIS.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                if connection then
                    connection:Disconnect()
                end
            end
        end)
    end
end)

-- Обработка кликов
ToggleButton.MouseButton1Click:Connect(toggleWalkSpeed)
HideUIToggle.MouseButton1Click:Connect(toggleUI)
MinimizeButton.MouseButton1Click:Connect(toggleMinimize)

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

-- Инициализация UI
updateToggleUI()

-- Информация при запуске
print("====================================")
print("Astra v1.0 успешно запущен!")
print("Скорость бега: " .. Config.WalkSpeed)
print("Speed Hack: " .. (Config.Enabled and "Включен" or "Выключен"))
print("Горячая клавиша скрытия: H")
print("====================================")

-- Безопасность
local function onCharacterAdded(character)
    if Config.Enabled then
        wait(0.5)
        local humanoid = character:WaitForChild("Humanoid", 2)
        if humanoid then
            humanoid.WalkSpeed = Config.WalkSpeed
        end
    end
end

if LocalPlayer.Character then
    onCharacterAdded(LocalPlayer.Character)
end

LocalPlayer.CharacterAdded:Connect(onCharacterAdded)
