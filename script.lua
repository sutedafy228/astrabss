-- Astra v1.0 Enhanced
-- by Script Developer

-- Основные переменные
local UIS = game:GetService("UserInputService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- Конфигурация
local Config = {
    WalkSpeed = 50,
    JumpPower = 80,
    SpeedEnabled = false,
    JumpEnabled = false,
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
MainFrame.Size = UDim2.new(0, 350, 0, 320)
MainFrame.Position = UDim2.new(0.5, -175, 0.5, -160)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
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
UIStroke.Color = Color3.fromRGB(50, 50, 70)
UIStroke.Thickness = 2
UIStroke.Parent = MainFrame

-- Заголовок
local TitleFrame = Instance.new("Frame")
TitleFrame.Size = UDim2.new(1, 0, 0, 40)
TitleFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
TitleFrame.BorderSizePixel = 0
TitleFrame.Parent = MainFrame

local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 10)
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
MinimizeButton.Size = UDim2.new(0, 30, 0, 30)
MinimizeButton.Position = UDim2.new(1, -35, 0.5, -15)
MinimizeButton.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
MinimizeButton.BorderSizePixel = 0
MinimizeButton.Text = "-"
MinimizeButton.TextColor3 = Color3.fromRGB(220, 220, 255)
MinimizeButton.Font = Enum.Font.GothamBold
MinimizeButton.TextSize = 20
MinimizeButton.Parent = TitleFrame

local MinimizeCorner = Instance.new("UICorner")
MinimizeCorner.CornerRadius = UDim.new(0, 5)
MinimizeCorner.Parent = MinimizeButton

-- Контент
local ContentFrame = Instance.new("Frame")
ContentFrame.Name = "ContentFrame"
ContentFrame.Size = UDim2.new(1, -20, 0, 260)
ContentFrame.Position = UDim2.new(0, 10, 0, 50)
ContentFrame.BackgroundTransparency = 1
ContentFrame.Visible = true
ContentFrame.Parent = MainFrame

-- Раздел скорости
local SpeedSection = Instance.new("Frame")
SpeedSection.Size = UDim2.new(1, 0, 0, 100)
SpeedSection.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
SpeedSection.BorderSizePixel = 0
SpeedSection.Parent = ContentFrame

local SpeedCorner = Instance.new("UICorner")
SpeedCorner.CornerRadius = UDim.new(0, 8)
SpeedCorner.Parent = SpeedSection

-- Заголовок скорости
local SpeedTitle = Instance.new("TextLabel")
SpeedTitle.Size = UDim2.new(1, 0, 0, 30)
SpeedTitle.BackgroundTransparency = 1
SpeedTitle.Text = "WALK SPEED"
SpeedTitle.TextColor3 = Color3.fromRGB(180, 180, 220)
SpeedTitle.Font = Enum.Font.GothamBold
SpeedTitle.TextSize = 14
SpeedTitle.Position = UDim2.new(0, 15, 0, 0)
SpeedTitle.TextXAlignment = Enum.TextXAlignment.Left
SpeedTitle.Parent = SpeedSection

-- Поле ввода скорости
local SpeedInputFrame = Instance.new("Frame")
SpeedInputFrame.Size = UDim2.new(1, -30, 0, 40)
SpeedInputFrame.Position = UDim2.new(0, 15, 0, 35)
SpeedInputFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
SpeedInputFrame.BorderSizePixel = 0
SpeedInputFrame.Parent = SpeedSection

local SpeedInputCorner = Instance.new("UICorner")
SpeedInputCorner.CornerRadius = UDim.new(0, 6)
SpeedInputCorner.Parent = SpeedInputFrame

local SpeedTextBox = Instance.new("TextBox")
SpeedTextBox.Size = UDim2.new(0.7, 0, 1, 0)
SpeedTextBox.Position = UDim2.new(0, 10, 0, 0)
SpeedTextBox.BackgroundTransparency = 1
SpeedTextBox.Text = tostring(Config.WalkSpeed)
SpeedTextBox.TextColor3 = Color3.fromRGB(220, 220, 255)
SpeedTextBox.Font = Enum.Font.Gotham
SpeedTextBox.TextSize = 16
SpeedTextBox.PlaceholderText = "40-90"
SpeedTextBox.TextXAlignment = Enum.TextXAlignment.Left
SpeedTextBox.Parent = SpeedInputFrame

local SpeedApplyButton = Instance.new("TextButton")
SpeedApplyButton.Size = UDim2.new(0.25, 0, 0.7, 0)
SpeedApplyButton.Position = UDim2.new(0.73, 0, 0.15, 0)
SpeedApplyButton.BackgroundColor3 = Color3.fromRGB(70, 110, 190)
SpeedApplyButton.BorderSizePixel = 0
SpeedApplyButton.Text = "APPLY"
SpeedApplyButton.TextColor3 = Color3.white
SpeedApplyButton.Font = Enum.Font.GothamBold
SpeedApplyButton.TextSize = 12
SpeedApplyButton.Parent = SpeedInputFrame

local ApplyCorner = Instance.new("UICorner")
ApplyCorner.CornerRadius = UDim.new(0, 4)
ApplyCorner.Parent = SpeedApplyButton

-- Включение скорости
local SpeedToggleFrame = Instance.new("Frame")
SpeedToggleFrame.Size = UDim2.new(1, -30, 0, 30)
SpeedToggleFrame.Position = UDim2.new(0, 15, 0, 80)
SpeedToggleFrame.BackgroundTransparency = 1
SpeedToggleFrame.Parent = SpeedSection

local SpeedToggleLabel = Instance.new("TextLabel")
SpeedToggleLabel.Size = UDim2.new(0.6, 0, 1, 0)
SpeedToggleLabel.BackgroundTransparency = 1
SpeedToggleLabel.Text = "Enable Speed"
SpeedToggleLabel.TextColor3 = Color3.fromRGB(200, 200, 230)
SpeedToggleLabel.Font = Enum.Font.Gotham
SpeedToggleLabel.TextSize = 12
SpeedToggleLabel.TextXAlignment = Enum.TextXAlignment.Left
SpeedToggleLabel.Parent = SpeedToggleFrame

local SpeedCheckbox = Instance.new("TextButton")
SpeedCheckbox.Size = UDim2.new(0, 20, 0, 20)
SpeedCheckbox.Position = UDim2.new(1, -25, 0.5, -10)
SpeedCheckbox.BackgroundColor3 = Config.SpeedEnabled and Color3.fromRGB(80, 200, 120) or Color3.fromRGB(80, 80, 100)
SpeedCheckbox.BorderSizePixel = 0
SpeedCheckbox.Text = ""
SpeedCheckbox.Parent = SpeedToggleFrame

local SpeedCheckCorner = Instance.new("UICorner")
SpeedCheckCorner.CornerRadius = UDim.new(0, 3)
SpeedCheckCorner.Parent = SpeedCheckbox

local SpeedCheckmark = Instance.new("TextLabel")
SpeedCheckmark.Size = UDim2.new(1, 0, 1, 0)
SpeedCheckmark.BackgroundTransparency = 1
SpeedCheckmark.Text = "✓"
SpeedCheckmark.TextColor3 = Color3.white
SpeedCheckmark.Font = Enum.Font.GothamBold
SpeedCheckmark.TextSize = 14
SpeedCheckmark.Visible = Config.SpeedEnabled
SpeedCheckmark.Parent = SpeedCheckbox

-- Раздел прыжка
local JumpSection = Instance.new("Frame")
JumpSection.Size = UDim2.new(1, 0, 0, 100)
JumpSection.Position = UDim2.new(0, 0, 0, 110)
JumpSection.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
JumpSection.BorderSizePixel = 0
JumpSection.Parent = ContentFrame

local JumpCorner = Instance.new("UICorner")
JumpCorner.CornerRadius = UDim.new(0, 8)
JumpCorner.Parent = JumpSection

-- Заголовок прыжка
local JumpTitle = Instance.new("TextLabel")
JumpTitle.Size = UDim2.new(1, 0, 0, 30)
JumpTitle.BackgroundTransparency = 1
JumpTitle.Text = "JUMP POWER"
JumpTitle.TextColor3 = Color3.fromRGB(180, 180, 220)
JumpTitle.Font = Enum.Font.GothamBold
JumpTitle.TextSize = 14
JumpTitle.Position = UDim2.new(0, 15, 0, 0)
JumpTitle.TextXAlignment = Enum.TextXAlignment.Left
JumpTitle.Parent = JumpSection

-- Поле ввода прыжка
local JumpInputFrame = Instance.new("Frame")
JumpInputFrame.Size = UDim2.new(1, -30, 0, 40)
JumpInputFrame.Position = UDim2.new(0, 15, 0, 35)
JumpInputFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
JumpInputFrame.BorderSizePixel = 0
JumpInputFrame.Parent = JumpSection

local JumpInputCorner = Instance.new("UICorner")
JumpInputCorner.CornerRadius = UDim.new(0, 6)
JumpInputCorner.Parent = JumpInputFrame

local JumpTextBox = Instance.new("TextBox")
JumpTextBox.Size = UDim2.new(0.7, 0, 1, 0)
JumpTextBox.Position = UDim2.new(0, 10, 0, 0)
JumpTextBox.BackgroundTransparency = 1
JumpTextBox.Text = tostring(Config.JumpPower)
JumpTextBox.TextColor3 = Color3.fromRGB(220, 220, 255)
JumpTextBox.Font = Enum.Font.Gotham
JumpTextBox.TextSize = 16
JumpTextBox.PlaceholderText = "60-100"
JumpTextBox.TextXAlignment = Enum.TextXAlignment.Left
JumpTextBox.Parent = JumpInputFrame

local JumpApplyButton = Instance.new("TextButton")
JumpApplyButton.Size = UDim2.new(0.25, 0, 0.7, 0)
JumpApplyButton.Position = UDim2.new(0.73, 0, 0.15, 0)
JumpApplyButton.BackgroundColor3 = Color3.fromRGB(70, 110, 190)
JumpApplyButton.BorderSizePixel = 0
JumpApplyButton.Text = "APPLY"
JumpApplyButton.TextColor3 = Color3.white
JumpApplyButton.Font = Enum.Font.GothamBold
JumpApplyButton.TextSize = 12
JumpApplyButton.Parent = JumpInputFrame

local JumpApplyCorner = Instance.new("UICorner")
JumpApplyCorner.CornerRadius = UDim.new(0, 4)
JumpApplyCorner.Parent = JumpApplyButton

-- Включение прыжка
local JumpToggleFrame = Instance.new("Frame")
JumpToggleFrame.Size = UDim2.new(1, -30, 0, 30)
JumpToggleFrame.Position = UDim2.new(0, 15, 0, 80)
JumpToggleFrame.BackgroundTransparency = 1
JumpToggleFrame.Parent = JumpSection

local JumpToggleLabel = Instance.new("TextLabel")
JumpToggleLabel.Size = UDim2.new(0.6, 0, 1, 0)
JumpToggleLabel.BackgroundTransparency = 1
JumpToggleLabel.Text = "Enable Jump"
JumpToggleLabel.TextColor3 = Color3.fromRGB(200, 200, 230)
JumpToggleLabel.Font = Enum.Font.Gotham
JumpToggleLabel.TextSize = 12
JumpToggleLabel.TextXAlignment = Enum.TextXAlignment.Left
JumpToggleLabel.Parent = JumpToggleFrame

local JumpCheckbox = Instance.new("TextButton")
JumpCheckbox.Size = UDim2.new(0, 20, 0, 20)
JumpCheckbox.Position = UDim2.new(1, -25, 0.5, -10)
JumpCheckbox.BackgroundColor3 = Config.JumpEnabled and Color3.fromRGB(80, 200, 120) or Color3.fromRGB(80, 80, 100)
JumpCheckbox.BorderSizePixel = 0
JumpCheckbox.Text = ""
JumpCheckbox.Parent = JumpToggleFrame

local JumpCheckCorner = Instance.new("UICorner")
JumpCheckCorner.CornerRadius = UDim.new(0, 3)
JumpCheckCorner.Parent = JumpCheckbox

local JumpCheckmark = Instance.new("TextLabel")
JumpCheckmark.Size = UDim2.new(1, 0, 1, 0)
JumpCheckmark.BackgroundTransparency = 1
JumpCheckmark.Text = "✓"
JumpCheckmark.TextColor3 = Color3.white
JumpCheckmark.Font = Enum.Font.GothamBold
JumpCheckmark.TextSize = 14
JumpCheckmark.Visible = Config.JumpEnabled
JumpCheckmark.Parent = JumpCheckbox

-- Кнопка скрытия интерфейса
local HideButton = Instance.new("TextButton")
HideButton.Size = UDim2.new(1, 0, 0, 35)
HideButton.Position = UDim2.new(0, 0, 0, 220)
HideButton.BackgroundColor3 = Color3.fromRGB(70, 110, 190)
HideButton.BorderSizePixel = 0
HideButton.Text = "HIDE INTERFACE (H)"
HideButton.TextColor3 = Color3.white
HideButton.Font = Enum.Font.GothamBold
HideButton.TextSize = 12
HideButton.Parent = ContentFrame

local HideCorner = Instance.new("UICorner")
HideCorner.CornerRadius = UDim.new(0, 6)
HideCorner.Parent = HideButton

-- Функции
local function updateSpeed()
    if Config.SpeedEnabled and LocalPlayer.Character then
        local humanoid = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            humanoid.WalkSpeed = Config.WalkSpeed
        end
    else
        if LocalPlayer.Character then
            local humanoid = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
            if humanoid then
                humanoid.WalkSpeed = 16
            end
        end
    end
end

local function updateJump()
    if Config.JumpEnabled and LocalPlayer.Character then
        local humanoid = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            humanoid.JumpPower = Config.JumpPower
        end
    else
        if LocalPlayer.Character then
            local humanoid = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
            if humanoid then
                humanoid.JumpPower = 50
            end
        end
    end
end

local function updateAll()
    updateSpeed()
    updateJump()
end

-- Обновление UI скорости
local function updateSpeedUI()
    if Config.SpeedEnabled then
        SpeedCheckbox.BackgroundColor3 = Color3.fromRGB(80, 200, 120)
        SpeedCheckmark.Visible = true
    else
        SpeedCheckbox.BackgroundColor3 = Color3.fromRGB(80, 80, 100)
        SpeedCheckmark.Visible = false
    end
    updateSpeed()
end

-- Обновление UI прыжка
local function updateJumpUI()
    if Config.JumpEnabled then
        JumpCheckbox.BackgroundColor3 = Color3.fromRGB(80, 200, 120)
        JumpCheckmark.Visible = true
    else
        JumpCheckbox.BackgroundColor3 = Color3.fromRGB(80, 80, 100)
        JumpCheckmark.Visible = false
    end
    updateJump()
end

-- Переключение скорости
local function toggleSpeed()
    Config.SpeedEnabled = not Config.SpeedEnabled
    updateSpeedUI()
end

-- Переключение прыжка
local function toggleJump()
    Config.JumpEnabled = not Config.JumpEnabled
    updateJumpUI()
end

-- Минимизация
local function toggleMinimize()
    Config.Minimized = not Config.Minimized
    
    if Config.Minimized then
        MainFrame.Size = UDim2.new(0, 350, 0, 40)
        ContentFrame.Visible = false
        MinimizeButton.Text = "+"
    else
        MainFrame.Size = UDim2.new(0, 350, 0, 320)
        ContentFrame.Visible = true
        MinimizeButton.Text = "-"
    end
end

-- Скрытие интерфейса
local function toggleUI()
    Config.UIHidden = not Config.UIHidden
    MainFrame.Visible = not Config.UIHidden
    
    if Config.UIHidden then
        HideButton.Text = "SHOW INTERFACE (H)"
    else
        HideButton.Text = "HIDE INTERFACE (H)"
    end
end

-- Применение скорости
SpeedApplyButton.MouseButton1Click:Connect(function()
    local text = SpeedTextBox.Text
    local num = tonumber(text)
    
    if num and num >= 40 and num <= 90 then
        Config.WalkSpeed = math.floor(num)
        SpeedTextBox.Text = tostring(Config.WalkSpeed)
        updateSpeed()
        
        -- Анимация кнопки
        SpeedApplyButton.Text = "✓"
        wait(0.5)
        SpeedApplyButton.Text = "APPLY"
    else
        local original = SpeedTextBox.Text
        SpeedTextBox.Text = "INVALID!"
        SpeedTextBox.TextColor3 = Color3.fromRGB(255, 100, 100)
        wait(1)
        SpeedTextBox.Text = original
        SpeedTextBox.TextColor3 = Color3.fromRGB(220, 220, 255)
    end
end)

-- Применение прыжка
JumpApplyButton.MouseButton1Click:Connect(function()
    local text = JumpTextBox.Text
    local num = tonumber(text)
    
    if num and num >= 60 and num <= 100 then
        Config.JumpPower = math.floor(num)
        JumpTextBox.Text = tostring(Config.JumpPower)
        updateJump()
        
        -- Анимация кнопки
        JumpApplyButton.Text = "✓"
        wait(0.5)
        JumpApplyButton.Text = "APPLY"
    else
        local original = JumpTextBox.Text
        JumpTextBox.Text = "INVALID!"
        JumpTextBox.TextColor3 = Color3.fromRGB(255, 100, 100)
        wait(1)
        JumpTextBox.Text = original
        JumpTextBox.TextColor3 = Color3.fromRGB(220, 220, 255)
    end
end)

-- Обработка Enter в текстовых полях
SpeedTextBox.FocusLost:Connect(function()
    SpeedApplyButton:MouseButton1Click()
end)

JumpTextBox.FocusLost:Connect(function()
    JumpApplyButton:MouseButton1Click()
end)

-- Обработка кликов
SpeedCheckbox.MouseButton1Click:Connect(toggleSpeed)
JumpCheckbox.MouseButton1Click:Connect(toggleJump)
HideButton.MouseButton1Click:Connect(toggleUI)
MinimizeButton.MouseButton1Click:Connect(toggleMinimize)

-- Горячие клавиши
UIS.InputBegan:Connect(function(input, processed)
    if not processed and input.KeyCode == Enum.KeyCode.H then
        toggleUI()
    end
end)

-- Автоматическое обновление при возрождении
local function onCharacterAdded(character)
    wait(0.5)
    updateAll()
end

if LocalPlayer.Character then
    spawn(function()
        onCharacterAdded(LocalPlayer.Character)
    end)
end

LocalPlayer.CharacterAdded:Connect(onCharacterAdded)

-- Инициализация UI
updateSpeedUI()
updateJumpUI()

-- Консольный вывод
print("======================================")
print("⚡ ASTRA v1.0 ENHANCED")
print("======================================")
print("Walk Speed: " .. Config.WalkSpeed .. " (" .. (Config.SpeedEnabled and "ENABLED" or "DISABLED") .. ")")
print("Jump Power: " .. Config.JumpPower .. " (" .. (Config.JumpEnabled and "ENABLED" or "DISABLED") .. ")")
print("Hide Interface: H key")
print("Minimize: +/- button")
print("======================================")

-- Очистка при уничтожении
game:GetService("UserInputService").InputBegan:Connect(function(input, processed)
    if not processed and input.KeyCode == Enum.KeyCode.P then
        ScreenGui:Destroy()
        if LocalPlayer.Character then
            local humanoid = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
            if humanoid then
                humanoid.WalkSpeed = 16
                humanoid.JumpPower = 50
            end
        end
        print("Astra v1.0 unloaded")
    end
end)
