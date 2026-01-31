-- Astra v1.0 - Ultimate Edition
-- by Script Developer

-- Основные переменные
local UIS = game:GetService("UserInputService")
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer

-- Конфигурация
local Config = {
    WalkSpeed = 50,
    JumpPower = 80,
    MasterEnabled = false,
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
MainFrame.Size = UDim2.new(0, 320, 0, 280)
MainFrame.Position = UDim2.new(0.5, -160, 0.5, -140)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.ClipsDescendants = true
MainFrame.Parent = ScreenGui

-- Скругление углов
local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 10)
UICorner.Parent = MainFrame

-- Тень
local UIStroke = Instance.new("UIStroke")
UIStroke.Color = Color3.fromRGB(40, 40, 60)
UIStroke.Thickness = 2
UIStroke.Parent = MainFrame

-- Заголовок (всегда видимый)
local TitleFrame = Instance.new("Frame")
TitleFrame.Size = UDim2.new(1, 0, 0, 35)
TitleFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 40)
TitleFrame.BorderSizePixel = 0
TitleFrame.Parent = MainFrame

local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 10)
TitleCorner.Parent = TitleFrame

-- Название
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -70, 1, 0)
Title.Position = UDim2.new(0, 10, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "Astra v1.0"
Title.TextColor3 = Color3.fromRGB(220, 220, 255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 14
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = TitleFrame

-- Кнопка минимизации
local MinimizeButton = Instance.new("TextButton")
MinimizeButton.Size = UDim2.new(0, 25, 0, 25)
MinimizeButton.Position = UDim2.new(1, -60, 0.5, -12.5)
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

-- Кнопка закрытия
local CloseButton = Instance.new("TextButton")
CloseButton.Size = UDim2.new(0, 25, 0, 25)
CloseButton.Position = UDim2.new(1, -30, 0.5, -12.5)
CloseButton.BackgroundColor3 = Color3.fromRGB(200, 60, 60)
CloseButton.BorderSizePixel = 0
CloseButton.Text = "×"
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.Font = Enum.Font.GothamBold
CloseButton.TextSize = 18
CloseButton.Parent = TitleFrame

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 4)
CloseCorner.Parent = CloseButton

-- Контент (будет скрываться с анимацией)
local ContentFrame = Instance.new("Frame")
ContentFrame.Name = "ContentFrame"
ContentFrame.Size = UDim2.new(1, -20, 0, 230)
ContentFrame.Position = UDim2.new(0, 10, 0, 45)
ContentFrame.BackgroundTransparency = 1
ContentFrame.Visible = true
ContentFrame.Parent = MainFrame

-- Главный переключатель
local MasterSection = Instance.new("Frame")
MasterSection.Size = UDim2.new(1, 0, 0, 50)
MasterSection.BackgroundColor3 = Color3.fromRGB(25, 25, 40)
MasterSection.BorderSizePixel = 0
MasterSection.Parent = ContentFrame

local MasterCorner = Instance.new("UICorner")
MasterCorner.CornerRadius = UDim.new(0, 8)
MasterCorner.Parent = MasterSection

-- Надпись главного переключателя
local MasterLabel = Instance.new("TextLabel")
MasterLabel.Size = UDim2.new(0.6, 0, 1, 0)
MasterLabel.Position = UDim2.new(0, 15, 0, 0)
MasterLabel.BackgroundTransparency = 1
MasterLabel.Text = "MASTER ENABLE"
MasterLabel.TextColor3 = Color3.fromRGB(220, 220, 255)
MasterLabel.Font = Enum.Font.GothamBold
MasterLabel.TextSize = 13
MasterLabel.TextXAlignment = Enum.TextXAlignment.Left
MasterLabel.Parent = MasterSection

-- Главный чекбокс
local MasterCheckbox = Instance.new("TextButton")
MasterCheckbox.Size = UDim2.new(0, 30, 0, 30)
MasterCheckbox.Position = UDim2.new(1, -40, 0.5, -15)
MasterCheckbox.BackgroundColor3 = Config.MasterEnabled and Color3.fromRGB(80, 200, 120) or Color3.fromRGB(80, 80, 100)
MasterCheckbox.BorderSizePixel = 0
MasterCheckbox.Text = ""
MasterCheckbox.Parent = MasterSection

local MasterCheckCorner = Instance.new("UICorner")
MasterCheckCorner.CornerRadius = UDim.new(0, 5)
MasterCheckCorner.Parent = MasterCheckbox

local MasterCheckmark = Instance.new("TextLabel")
MasterCheckmark.Size = UDim2.new(1, 0, 1, 0)
MasterCheckmark.BackgroundTransparency = 1
MasterCheckmark.Text = "✓"
MasterCheckmark.TextColor3 = Color3.white
MasterCheckmark.Font = Enum.Font.GothamBold
MasterCheckmark.TextSize = 18
MasterCheckmark.Visible = Config.MasterEnabled
MasterCheckmark.Parent = MasterCheckbox

-- Раздел скорости
local SpeedSection = Instance.new("Frame")
SpeedSection.Size = UDim2.new(1, 0, 0, 80)
SpeedSection.Position = UDim2.new(0, 0, 0, 60)
SpeedSection.BackgroundColor3 = Color3.fromRGB(25, 25, 40)
SpeedSection.BorderSizePixel = 0
SpeedSection.Parent = ContentFrame

local SpeedCorner = Instance.new("UICorner")
SpeedCorner.CornerRadius = UDim.new(0, 8)
SpeedCorner.Parent = SpeedSection

-- Заголовок скорости
local SpeedTitle = Instance.new("TextLabel")
SpeedTitle.Size = UDim2.new(1, 0, 0, 25)
SpeedTitle.BackgroundTransparency = 1
SpeedTitle.Text = "WALK SPEED"
SpeedTitle.TextColor3 = Color3.fromRGB(180, 180, 220)
SpeedTitle.Font = Enum.Font.GothamBold
SpeedTitle.TextSize = 12
SpeedTitle.Position = UDim2.new(0, 15, 0, 0)
SpeedTitle.TextXAlignment = Enum.TextXAlignment.Left
SpeedTitle.Parent = SpeedSection

-- Поле ввода скорости
local SpeedInputFrame = Instance.new("Frame")
SpeedInputFrame.Size = UDim2.new(1, -30, 0, 35)
SpeedInputFrame.Position = UDim2.new(0, 15, 0, 30)
SpeedInputFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 55)
SpeedInputFrame.BorderSizePixel = 0
SpeedInputFrame.Parent = SpeedSection

local SpeedInputCorner = Instance.new("UICorner")
SpeedInputCorner.CornerRadius = UDim.new(0, 6)
SpeedInputCorner.Parent = SpeedInputFrame

local SpeedTextBox = Instance.new("TextBox")
SpeedTextBox.Size = UDim2.new(1, -10, 1, 0)
SpeedTextBox.Position = UDim2.new(0, 5, 0, 0)
SpeedTextBox.BackgroundTransparency = 1
SpeedTextBox.Text = tostring(Config.WalkSpeed)
SpeedTextBox.TextColor3 = Color3.fromRGB(220, 220, 255)
SpeedTextBox.Font = Enum.Font.Gotham
SpeedTextBox.TextSize = 14
SpeedTextBox.PlaceholderText = "40-90"
SpeedTextBox.TextXAlignment = Enum.TextXAlignment.Left
SpeedTextBox.Parent = SpeedInputFrame

local SpeedRangeLabel = Instance.new("TextLabel")
SpeedRangeLabel.Size = UDim2.new(1, -30, 0, 15)
SpeedRangeLabel.Position = UDim2.new(0, 15, 0, 70)
SpeedRangeLabel.BackgroundTransparency = 1
SpeedRangeLabel.Text = "Range: 40-90 (Auto-correct)"
SpeedRangeLabel.TextColor3 = Color3.fromRGB(150, 150, 180)
SpeedRangeLabel.Font = Enum.Font.Gotham
SpeedRangeLabel.TextSize = 10
SpeedRangeLabel.TextXAlignment = Enum.TextXAlignment.Left
SpeedRangeLabel.Parent = SpeedSection

-- Раздел прыжка
local JumpSection = Instance.new("Frame")
JumpSection.Size = UDim2.new(1, 0, 0, 80)
JumpSection.Position = UDim2.new(0, 0, 0, 150)
JumpSection.BackgroundColor3 = Color3.fromRGB(25, 25, 40)
JumpSection.BorderSizePixel = 0
JumpSection.Parent = ContentFrame

local JumpCorner = Instance.new("UICorner")
JumpCorner.CornerRadius = UDim.new(0, 8)
JumpCorner.Parent = JumpSection

-- Заголовок прыжка
local JumpTitle = Instance.new("TextLabel")
JumpTitle.Size = UDim2.new(1, 0, 0, 25)
JumpTitle.BackgroundTransparency = 1
JumpTitle.Text = "JUMP POWER"
JumpTitle.TextColor3 = Color3.fromRGB(180, 180, 220)
JumpTitle.Font = Enum.Font.GothamBold
JumpTitle.TextSize = 12
JumpTitle.Position = UDim2.new(0, 15, 0, 0)
JumpTitle.TextXAlignment = Enum.TextXAlignment.Left
JumpTitle.Parent = JumpSection

-- Поле ввода прыжка
local JumpInputFrame = Instance.new("Frame")
JumpInputFrame.Size = UDim2.new(1, -30, 0, 35)
JumpInputFrame.Position = UDim2.new(0, 15, 0, 30)
JumpInputFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 55)
JumpInputFrame.BorderSizePixel = 0
JumpInputFrame.Parent = JumpSection

local JumpInputCorner = Instance.new("UICorner")
JumpInputCorner.CornerRadius = UDim.new(0, 6)
JumpInputCorner.Parent = JumpInputFrame

local JumpTextBox = Instance.new("TextBox")
JumpTextBox.Size = UDim2.new(1, -10, 1, 0)
JumpTextBox.Position = UDim2.new(0, 5, 0, 0)
JumpTextBox.BackgroundTransparency = 1
JumpTextBox.Text = tostring(Config.JumpPower)
JumpTextBox.TextColor3 = Color3.fromRGB(220, 220, 255)
JumpTextBox.Font = Enum.Font.Gotham
JumpTextBox.TextSize = 14
JumpTextBox.PlaceholderText = "50-150"
JumpTextBox.TextXAlignment = Enum.TextXAlignment.Left
JumpTextBox.Parent = JumpInputFrame

local JumpRangeLabel = Instance.new("TextLabel")
JumpRangeLabel.Size = UDim2.new(1, -30, 0, 15)
JumpRangeLabel.Position = UDim2.new(0, 15, 0, 70)
JumpRangeLabel.BackgroundTransparency = 1
JumpRangeLabel.Text = "Range: 50-150 (Auto-correct)"
JumpRangeLabel.TextColor3 = Color3.fromRGB(150, 150, 180)
JumpRangeLabel.Font = Enum.Font.Gotham
JumpRangeLabel.TextSize = 10
JumpRangeLabel.TextXAlignment = Enum.TextXAlignment.Left
JumpRangeLabel.Parent = JumpSection

-- Функции
local function updateCharacterStats()
    if not Config.MasterEnabled or not LocalPlayer.Character then
        return
    end
    
    local humanoid = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
    if humanoid then
        -- Авто-коррекция скорости
        if Config.WalkSpeed < 40 then
            Config.WalkSpeed = 40
            SpeedTextBox.Text = "40"
        elseif Config.WalkSpeed > 90 then
            Config.WalkSpeed = 90
            SpeedTextBox.Text = "90"
        end
        
        -- Авто-коррекция прыжка
        if Config.JumpPower < 50 then
            Config.JumpPower = 50
            JumpTextBox.Text = "50"
        elseif Config.JumpPower > 150 then
            Config.JumpPower = 150
            JumpTextBox.Text = "150"
        end
        
        -- Применение значений
        humanoid.WalkSpeed = Config.WalkSpeed
        humanoid.JumpPower = Config.JumpPower
    end
end

local function resetCharacterStats()
    if LocalPlayer.Character then
        local humanoid = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            humanoid.WalkSpeed = 16
            humanoid.JumpPower = 50
        end
    end
end

local function updateMasterUI()
    if Config.MasterEnabled then
        MasterCheckbox.BackgroundColor3 = Color3.fromRGB(80, 200, 120)
        MasterCheckmark.Visible = true
        updateCharacterStats()
    else
        MasterCheckbox.BackgroundColor3 = Color3.fromRGB(80, 80, 100)
        MasterCheckmark.Visible = false
        resetCharacterStats()
    end
end

local function toggleMaster()
    Config.MasterEnabled = not Config.MasterEnabled
    updateMasterUI()
end

-- Обработка ввода скорости
SpeedTextBox.FocusLost:Connect(function()
    local text = SpeedTextBox.Text
    local num = tonumber(text)
    
    if num then
        -- Авто-коррекция
        if num < 40 then
            num = 40
        elseif num > 90 then
            num = 90
        end
        
        Config.WalkSpeed = math.floor(num)
        SpeedTextBox.Text = tostring(Config.WalkSpeed)
        updateCharacterStats()
    else
        SpeedTextBox.Text = tostring(Config.WalkSpeed)
    end
end)

-- Обработка ввода прыжка
JumpTextBox.FocusLost:Connect(function()
    local text = JumpTextBox.Text
    local num = tonumber(text)
    
    if num then
        -- Авто-коррекция
        if num < 50 then
            num = 50
        elseif num > 150 then
            num = 150
        end
        
        Config.JumpPower = math.floor(num)
        JumpTextBox.Text = tostring(Config.JumpPower)
        updateCharacterStats()
    else
        JumpTextBox.Text = tostring(Config.JumpPower)
    end
end)

-- Минимизация с анимацией
local function toggleMinimize()
    if Config.Minimized then
        -- Показываем с анимацией
        Config.Minimized = false
        MinimizeButton.Text = "-"
        
        -- Анимация появления
        ContentFrame.Visible = true
        local tween = TweenService:Create(
            ContentFrame,
            TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
            {Position = UDim2.new(0, 10, 0, 45)}
        )
        tween:Play()
        
        -- Анимация размера
        local sizeTween = TweenService:Create(
            MainFrame,
            TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
            {Size = UDim2.new(0, 320, 0, 280)}
        )
        sizeTween:Play()
    else
        -- Скрываем с анимацией
        Config.Minimized = true
        MinimizeButton.Text = "+"
        
        -- Анимация скрытия
        local tween = TweenService:Create(
            ContentFrame,
            TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
            {Position = UDim2.new(0, 10, 0, -230)}
        )
        tween:Play()
        
        -- Анимация размера
        local sizeTween = TweenService:Create(
            MainFrame,
            TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
            {Size = UDim2.new(0, 320, 0, 35)}
        )
        
        sizeTween.Completed:Connect(function()
            ContentFrame.Visible = false
        end)
        sizeTween:Play()
    end
end

-- Полное закрытие скрипта
local function closeScript()
    -- Анимация исчезновения
    local tween = TweenService:Create(
        MainFrame,
        TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
        {Size = UDim2.new(0, 0, 0, 0), Position = UDim2.new(0.5, 0, 0.5, 0)}
    )
    tween:Play()
    
    tween.Completed:Connect(function()
        -- Восстанавливаем стандартные значения
        resetCharacterStats()
        
        -- Уничтожаем интерфейс
        ScreenGui:Destroy()
        
        -- Сообщение в консоль
        print("======================================")
        print("Astra v1.0 закрыт")
        print("Скорость и прыжок сброшены")
        print("======================================")
    end)
end

-- Обработка кликов
MasterCheckbox.MouseButton1Click:Connect(toggleMaster)
MinimizeButton.MouseButton1Click:Connect(toggleMinimize)
CloseButton.MouseButton1Click:Connect(closeScript)

-- Горячие клавиши
UIS.InputBegan:Connect(function(input, processed)
    if not processed then
        if input.KeyCode == Enum.KeyCode.M then
            toggleMinimize()
        elseif input.KeyCode == Enum.KeyCode.Q then
            closeScript()
        end
    end
end)

-- Автоматическое обновление при возрождении
local function onCharacterAdded(character)
    wait(0.5)
    if Config.MasterEnabled then
        updateCharacterStats()
    end
end

if LocalPlayer.Character then
    spawn(function()
        onCharacterAdded(LocalPlayer.Character)
    end)
end

LocalPlayer.CharacterAdded:Connect(onCharacterAdded)

-- Инициализация UI
updateMasterUI()

-- Консольный вывод
print("======================================")
print("⚡ ASTRA v1.0 - ULTIMATE EDITION")
print("======================================")
print("Master Enable: " .. (Config.MasterEnabled and "ON" or "OFF"))
print("Walk Speed: " .. Config.WalkSpeed .. " (40-90, auto-correct)")
print("Jump Power: " .. Config.JumpPower .. " (50-150, auto-correct)")
print("======================================")
print("Управление:")
print("- Минимизация: кнопка [-] или клавиша M")
print("- Закрыть: кнопка [×] или клавиша Q")
print("======================================")

-- Автоматическое применение при изменении текста
SpeedTextBox:GetPropertyChangedSignal("Text"):Connect(function()
    if SpeedTextBox.Text ~= "" then
        local num = tonumber(SpeedTextBox.Text)
        if num then
            Config.WalkSpeed = num
            if Config.MasterEnabled then
                updateCharacterStats()
            end
        end
    end
end)

JumpTextBox:GetPropertyChangedSignal("Text"):Connect(function()
    if JumpTextBox.Text ~= "" then
        local num = tonumber(JumpTextBox.Text)
        if num then
            Config.JumpPower = num
            if Config.MasterEnabled then
                updateCharacterStats()
            end
        end
    end
end)
