-- Astra v1.0 - Fixed Version
-- by Script Developer

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
ScreenGui.Parent = game.CoreGui

-- Основной фрейм
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 320, 0, 260)
MainFrame.Position = UDim2.new(0.5, -160, 0.5, -130)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.ClipsDescendants = true
MainFrame.Parent = ScreenGui

-- Скругление углов
local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 8)
UICorner.Parent = MainFrame

-- Тень
local UIStroke = Instance.new("UIStroke")
UIStroke.Color = Color3.fromRGB(50, 50, 70)
UIStroke.Thickness = 2
UIStroke.Parent = MainFrame

-- Заголовок (всегда видимый)
local TitleFrame = Instance.new("Frame")
TitleFrame.Size = UDim2.new(1, 0, 0, 35)
TitleFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
TitleFrame.BorderSizePixel = 0
TitleFrame.Parent = MainFrame

local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 8)
TitleCorner.Parent = TitleFrame

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -40, 1, 0)
Title.Position = UDim2.new(0, 10, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "⚡ Astra v1.0"
Title.TextColor3 = Color3.fromRGB(220, 220, 255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 16
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = TitleFrame

-- Кнопка скрытия/показа
local MinimizeButton = Instance.new("TextButton")
MinimizeButton.Size = UDim2.new(0, 25, 0, 25)
MinimizeButton.Position = UDim2.new(1, -30, 0.5, -12.5)
MinimizeButton.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
MinimizeButton.BorderSizePixel = 0
MinimizeButton.Text = "-"
MinimizeButton.TextColor3 = Color3.fromRGB(220, 220, 255)
MinimizeButton.Font = Enum.Font.GothamBold
MinimizeButton.TextSize = 18
MinimizeButton.Parent = TitleFrame

local MinimizeCorner = Instance.new("UICorner")
MinimizeCorner.CornerRadius = UDim.new(0, 4)
MinimizeCorner.Parent = MinimizeButton

-- Контент (будет скрываться при минимизации)
local ContentFrame = Instance.new("Frame")
ContentFrame.Name = "ContentFrame"
ContentFrame.Size = UDim2.new(1, -20, 0, 200)
ContentFrame.Position = UDim2.new(0, 10, 0, 45)
ContentFrame.BackgroundTransparency = 1
ContentFrame.Visible = true
ContentFrame.Parent = MainFrame

-- Раздел настройки скорости
local SpeedSection = Instance.new("Frame")
SpeedSection.Size = UDim2.new(1, 0, 0, 90)
SpeedSection.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
SpeedSection.BorderSizePixel = 0
SpeedSection.Parent = ContentFrame

local SpeedCorner = Instance.new("UICorner")
SpeedCorner.CornerRadius = UDim.new(0, 6)
SpeedCorner.Parent = SpeedSection

-- Заголовок скорости
local SpeedTitle = Instance.new("TextLabel")
SpeedTitle.Size = UDim2.new(1, 0, 0, 25)
SpeedTitle.BackgroundTransparency = 1
SpeedTitle.Text = "SPEED SETTINGS"
SpeedTitle.TextColor3 = Color3.fromRGB(180, 180, 220)
SpeedTitle.Font = Enum.Font.GothamBold
SpeedTitle.TextSize = 12
SpeedTitle.Position = UDim2.new(0, 10, 0, 0)
SpeedTitle.TextXAlignment = Enum.TextXAlignment.Left
SpeedTitle.Parent = SpeedSection

-- Ползунок скорости (40-90)
local SpeedSliderBack = Instance.new("Frame")
SpeedSliderBack.Size = UDim2.new(1, -20, 0, 30)
SpeedSliderBack.Position = UDim2.new(0, 10, 0, 30)
SpeedSliderBack.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
SpeedSliderBack.BorderSizePixel = 0
SpeedSliderBack.Parent = SpeedSection

local SliderBackCorner = Instance.new("UICorner")
SliderBackCorner.CornerRadius = UDim.new(0, 4)
SliderBackCorner.Parent = SpeedSliderBack

-- Заполнение ползунка
local SliderFill = Instance.new("Frame")
SliderFill.Size = UDim2.new((Config.WalkSpeed - 40) / 50, 0, 1, 0)
SliderFill.BackgroundColor3 = Color3.fromRGB(100, 150, 255)
SliderFill.BorderSizePixel = 0
SliderFill.ZIndex = 2
SliderFill.Parent = SpeedSliderBack

local FillCorner = Instance.new("UICorner")
FillCorner.CornerRadius = UDim.new(0, 4)
FillCorner.Parent = SliderFill

-- Значение скорости
local SpeedValue = Instance.new("TextLabel")
SpeedValue.Size = UDim2.new(0, 50, 0, 30)
SpeedValue.Position = UDim2.new(1, -55, 0, 0)
SpeedValue.BackgroundColor3 = Color3.fromRGB(70, 110, 190)
SpeedValue.Text = tostring(Config.WalkSpeed)
SpeedValue.TextColor3 = Color3.white
SpeedValue.Font = Enum.Font.GothamBold
SpeedValue.TextSize = 14
SpeedValue.ZIndex = 3
SpeedValue.Parent = SpeedSliderBack

local ValueCorner = Instance.new("UICorner")
ValueCorner.CornerRadius = UDim.new(0, 4)
ValueCorner.Parent = SpeedValue

-- Диапазон
local RangeLabel = Instance.new("TextLabel")
RangeLabel.Size = UDim2.new(1, -20, 0, 20)
RangeLabel.Position = UDim2.new(0, 10, 0, 65)
RangeLabel.BackgroundTransparency = 1
RangeLabel.Text = "Range: 40 - 90"
RangeLabel.TextColor3 = Color3.fromRGB(150, 150, 180)
RangeLabel.Font = Enum.Font.Gotham
RangeLabel.TextSize = 11
RangeLabel.TextXAlignment = Enum.TextXAlignment.Center
RangeLabel.Parent = SpeedSection

-- Переключатель Enable Speed Hack
local ToggleSection = Instance.new("Frame")
ToggleSection.Size = UDim2.new(1, 0, 0, 70)
ToggleSection.Position = UDim2.new(0, 0, 0, 100)
ToggleSection.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
ToggleSection.BorderSizePixel = 0
ToggleSection.Parent = ContentFrame

local ToggleCorner = Instance.new("UICorner")
ToggleCorner.CornerRadius = UDim.new(0, 6)
ToggleCorner.Parent = ToggleSection

-- Кнопка переключения
local ToggleButton = Instance.new("TextButton")
ToggleButton.Size = UDim2.new(1, -20, 0, 50)
ToggleButton.Position = UDim2.new(0, 10, 0.5, -25)
ToggleButton.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
ToggleButton.BorderSizePixel = 0
ToggleButton.Text = ""
ToggleButton.Parent = ToggleSection

local ToggleBtnCorner = Instance.new("UICorner")
ToggleBtnCorner.CornerRadius = UDim.new(0, 4)
ToggleBtnCorner.Parent = ToggleButton

-- Текст переключателя
local ToggleLabel = Instance.new("TextLabel")
ToggleLabel.Size = UDim2.new(0.7, 0, 1, 0)
ToggleLabel.Position = UDim2.new(0, 15, 0, 0)
ToggleLabel.BackgroundTransparency = 1
ToggleLabel.Text = "ENABLE SPEED HACK"
ToggleLabel.TextColor3 = Color3.fromRGB(220, 220, 255)
ToggleLabel.Font = Enum.Font.GothamBold
ToggleLabel.TextSize = 13
ToggleLabel.TextXAlignment = Enum.TextXAlignment.Left
ToggleLabel.Parent = ToggleButton

-- Чекбокс
local Checkbox = Instance.new("Frame")
Checkbox.Size = UDim2.new(0, 20, 0, 20)
Checkbox.Position = UDim2.new(1, -30, 0.5, -10)
Checkbox.BackgroundColor3 = Config.Enabled and Color3.fromRGB(80, 200, 120) or Color3.fromRGB(80, 80, 100)
Checkbox.BorderSizePixel = 0
Checkbox.Parent = ToggleButton

local CheckboxCorner = Instance.new("UICorner")
CheckboxCorner.CornerRadius = UDim.new(0, 3)
CheckboxCorner.Parent = Checkbox

-- Галочка
local Checkmark = Instance.new("TextLabel")
Checkmark.Size = UDim2.new(1, 0, 1, 0)
Checkmark.BackgroundTransparency = 1
Checkmark.Text = "✓"
Checkmark.TextColor3 = Color3.fromRGB(255, 255, 255)
Checkmark.Font = Enum.Font.GothamBold
Checkmark.TextSize = 14
Checkmark.Visible = Config.Enabled
Checkmark.Parent = Checkbox

-- Статус
local StatusLabel = Instance.new("TextLabel")
StatusLabel.Size = UDim2.new(1, -20, 0, 15)
StatusLabel.Position = UDim2.new(0, 10, 0, 55)
StatusLabel.BackgroundTransparency = 1
StatusLabel.Text = Config.Enabled and "STATUS: ACTIVE" or "STATUS: INACTIVE"
StatusLabel.TextColor3 = Config.Enabled and Color3.fromRGB(120, 255, 120) or Color3.fromRGB(255, 120, 120)
StatusLabel.Font = Enum.Font.Gotham
StatusLabel.TextSize = 10
StatusLabel.TextXAlignment = Enum.TextXAlignment.Center
StatusLabel.Parent = ToggleSection

-- Кнопка скрытия интерфейса
local HideButton = Instance.new("TextButton")
HideButton.Size = UDim2.new(1, 0, 0, 30)
HideButton.Position = UDim2.new(0, 0, 0, 180)
HideButton.BackgroundColor3 = Color3.fromRGB(70, 110, 190)
HideButton.BorderSizePixel = 0
HideButton.Text = "HIDE INTERFACE (H)"
HideButton.TextColor3 = Color3.white
HideButton.Font = Enum.Font.GothamBold
HideButton.TextSize = 12
HideButton.Parent = ContentFrame

local HideCorner = Instance.new("UICorner")
HideCorner.CornerRadius = UDim.new(0, 4)
HideCorner.Parent = HideButton

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
    if Config.Enabled then
        Checkbox.BackgroundColor3 = Color3.fromRGB(80, 200, 120)
        Checkmark.Visible = true
        StatusLabel.Text = "STATUS: ACTIVE"
        StatusLabel.TextColor3 = Color3.fromRGB(120, 255, 120)
        updateWalkSpeed()
    else
        Checkbox.BackgroundColor3 = Color3.fromRGB(80, 80, 100)
        Checkmark.Visible = false
        StatusLabel.Text = "STATUS: INACTIVE"
        StatusLabel.TextColor3 = Color3.fromRGB(255, 120, 120)
        
        -- Возвращаем стандартную скорость
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

local function toggleMinimize()
    Config.Minimized = not Config.Minimized
    
    if Config.Minimized then
        MainFrame.Size = UDim2.new(0, 320, 0, 35)
        ContentFrame.Visible = false
        MinimizeButton.Text = "+"
    else
        MainFrame.Size = UDim2.new(0, 320, 0, 260)
        ContentFrame.Visible = true
        MinimizeButton.Text = "-"
    end
end

local function toggleUI()
    Config.UIHidden = not Config.UIHidden
    MainFrame.Visible = not Config.UIHidden
    
    if Config.UIHidden then
        HideButton.Text = "SHOW INTERFACE (H)"
    else
        HideButton.Text = "HIDE INTERFACE (H)"
    end
end

-- Обработка ползунка скорости
local isDragging = false
SpeedSliderBack.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        isDragging = true
        
        local connection
        connection = RunService.RenderStepped:Connect(function()
            if not isDragging then
                connection:Disconnect()
                return
            end
            
            local mouse = LocalPlayer:GetMouse()
            local sliderPos = SpeedSliderBack.AbsolutePosition.X
            local sliderWidth = SpeedSliderBack.AbsoluteSize.X
            local mouseX = math.clamp(mouse.X, sliderPos, sliderPos + sliderWidth)
            
            local percentage = (mouseX - sliderPos) / sliderWidth
            Config.WalkSpeed = math.floor(40 + (percentage * 50))
            Config.WalkSpeed = math.clamp(Config.WalkSpeed, 40, 90)
            
            SpeedValue.Text = tostring(Config.WalkSpeed)
            SliderFill.Size = UDim2.new((Config.WalkSpeed - 40) / 50, 0, 1, 0)
            
            updateWalkSpeed()
        end)
        
        UIS.InputEnded:Connect(function(endInput)
            if endInput.UserInputType == Enum.UserInputType.MouseButton1 then
                isDragging = false
                if connection then
                    connection:Disconnect()
                end
            end
        end)
    end
end)

-- Обработка кликов
ToggleButton.MouseButton1Click:Connect(toggleWalkSpeed)
HideButton.MouseButton1Click:Connect(toggleUI)
MinimizeButton.MouseButton1Click:Connect(toggleMinimize)

-- Горячие клавиши
UIS.InputBegan:Connect(function(input, processed)
    if not processed and input.KeyCode == Enum.KeyCode.H then
        toggleUI()
    end
end)

-- Автоматическое обновление скорости
local function onCharacterAdded(character)
    wait(0.2)
    if Config.Enabled then
        local humanoid = character:WaitForChild("Humanoid", 1)
        if humanoid then
            humanoid.WalkSpeed = Config.WalkSpeed
        end
    end
end

if LocalPlayer.Character then
    spawn(function()
        onCharacterAdded(LocalPlayer.Character)
    end)
end

LocalPlayer.CharacterAdded:Connect(onCharacterAdded)

-- Обновление UI при запуске
updateToggleUI()

-- Консольный вывод
print("======================================")
print("ASTRA v1.0 LOADED SUCCESSFULLY!")
print("Current Speed: " .. Config.WalkSpeed)
print("Speed Hack: " .. (Config.Enabled and "ENABLED" or "DISABLED"))
print("Hide Interface: H key")
print("======================================")

-- Функция для безопасного выхода
game:GetService("UserInputService").InputBegan:Connect(function(input, processed)
    if not processed and input.KeyCode == Enum.KeyCode.P then
        -- Выход из скрипта
        ScreenGui:Destroy()
        if LocalPlayer.Character then
            local humanoid = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
            if humanoid then
                humanoid.WalkSpeed = 16
            end
        end
        print("Astra v1.0 unloaded")
    end
end)
