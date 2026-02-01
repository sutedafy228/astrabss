-- Roblox Farm GUI Script
-- Astra v1.0

local Player = game:GetService("Players").LocalPlayer
local Mouse = Player:GetMouse()
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")

-- Настройки по умолчанию
local Settings = {
    AutoFarm = false,
    SelectedLocation = "star 1",
    FlySpeed = 9, -- От 6 до 12 (6=8, 7=16, ..., 12=56)
    EnableWalkSpeed = false,
    WalkSpeed = 60, -- От 40 до 80
    Locations = {
        ["star 1"] = Vector3.new(-412.21, 17.17, 466.99),
        ["star 2"] = Vector3.new(-436.20, 93.26, 49.28),
        ["star 3"] = Vector3.new(-200.50, 50.25, 300.75)
    }
}

-- Создание GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "AstraFarmGUI"
ScreenGui.Parent = Player:WaitForChild("PlayerGui")

-- Размер GUI (шире)
local guiWidth = 420
local guiHeight = 460

-- Сохраняем начальную позицию
local initialPosition = UDim2.new(0.5, -guiWidth/2, 0.5, -guiHeight/2)

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, guiWidth, 0, guiHeight)
MainFrame.Position = initialPosition
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
MainFrame.BorderSizePixel = 0
MainFrame.Parent = ScreenGui

-- Скругленные углы для основного фрейма
local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 15)
MainCorner.Parent = MainFrame

-- Заголовок
local TitleBar = Instance.new("Frame")
TitleBar.Size = UDim2.new(1, 0, 0, 50)
TitleBar.Position = UDim2.new(0, 0, 0, 0)
TitleBar.BackgroundColor3 = Color3.fromRGB(30, 140, 200)  -- Голубой цвет
TitleBar.BorderSizePixel = 0
TitleBar.Parent = MainFrame

-- Скругленные углы для заголовка
local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 15)
TitleCorner.Parent = TitleBar

-- Текст слева
local TitleText = Instance.new("TextLabel")
TitleText.Size = UDim2.new(0.7, 0, 1, 0)
TitleText.Position = UDim2.new(0, 15, 0, 0)
TitleText.BackgroundTransparency = 1
TitleText.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleText.Text = "Astra v1.0"
TitleText.Font = Enum.Font.GothamBold
TitleText.TextSize = 20
TitleText.TextXAlignment = Enum.TextXAlignment.Left
TitleText.Parent = TitleBar

-- Кнопка свернуть/развернуть справа
local ToggleButton = Instance.new("TextButton")
ToggleButton.Size = UDim2.new(0, 30, 0, 30)
ToggleButton.Position = UDim2.new(1, -35, 0.5, -15)
ToggleButton.BackgroundColor3 = Color3.fromRGB(50, 120, 180)
ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleButton.Text = "×"
ToggleButton.Font = Enum.Font.GothamBold
ToggleButton.TextSize = 24
ToggleButton.Parent = TitleBar

local ToggleCorner = Instance.new("UICorner")
ToggleCorner.CornerRadius = UDim.new(0, 15)
ToggleCorner.Parent = ToggleButton

-- Вкладки
local TabButtonsFrame = Instance.new("Frame")
TabButtonsFrame.Size = UDim2.new(1, -20, 0, 35)
TabButtonsFrame.Position = UDim2.new(0, 10, 0, 55)
TabButtonsFrame.BackgroundTransparency = 1
TabButtonsFrame.Parent = MainFrame

local FarmTabButton = Instance.new("TextButton")
FarmTabButton.Size = UDim2.new(0.5, -2, 1, 0)
FarmTabButton.Position = UDim2.new(0, 0, 0, 0)
FarmTabButton.BackgroundColor3 = Color3.fromRGB(50, 120, 220)
FarmTabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
FarmTabButton.Text = "Farm"
FarmTabButton.Font = Enum.Font.Gotham
FarmTabButton.TextSize = 14
FarmTabButton.Parent = TabButtonsFrame

local TabCorner1 = Instance.new("UICorner")
TabCorner1.CornerRadius = UDim.new(0, 8)
TabCorner1.Parent = FarmTabButton

local ConfigTabButton = Instance.new("TextButton")
ConfigTabButton.Size = UDim2.new(0.5, -2, 1, 0)
ConfigTabButton.Position = UDim2.new(0.5, 2, 0, 0)
ConfigTabButton.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
ConfigTabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ConfigTabButton.Text = "Config"
ConfigTabButton.Font = Enum.Font.Gotham
ConfigTabButton.TextSize = 14
ConfigTabButton.Parent = TabButtonsFrame

local TabCorner2 = Instance.new("UICorner")
TabCorner2.CornerRadius = UDim.new(0, 8)
TabCorner2.Parent = ConfigTabButton

-- Контентные области для вкладок
local TabContentFrame = Instance.new("Frame")
TabContentFrame.Size = UDim2.new(1, -20, 1, -110)
TabContentFrame.Position = UDim2.new(0, 10, 0, 95)
TabContentFrame.BackgroundTransparency = 1
TabContentFrame.Parent = MainFrame

-- Вкладка Farm
local FarmTab = Instance.new("ScrollingFrame")
FarmTab.Size = UDim2.new(1, 0, 1, 0)
FarmTab.BackgroundTransparency = 1
FarmTab.Visible = true
FarmTab.Name = "FarmTab"
FarmTab.ScrollBarThickness = 3
FarmTab.ScrollBarImageColor3 = Color3.fromRGB(80, 100, 150)
FarmTab.CanvasSize = UDim2.new(0, 0, 0, 180)
FarmTab.Parent = TabContentFrame

-- Вкладка Config
local ConfigTab = Instance.new("ScrollingFrame")
ConfigTab.Size = UDim2.new(1, 0, 1, 0)
ConfigTab.BackgroundTransparency = 1
ConfigTab.Visible = false
ConfigTab.Name = "ConfigTab"
ConfigTab.ScrollBarThickness = 3
ConfigTab.ScrollBarImageColor3 = Color3.fromRGB(80, 100, 150)
ConfigTab.CanvasSize = UDim2.new(0, 0, 0, 180)
ConfigTab.Parent = TabContentFrame

-- Флаг для свернутого состояния
local isMinimized = false

-- Функция для получения фактической скорости (6=8, 7=16, 8=24, 9=32, 10=40, 11=48, 12=56)
local function GetActualFlySpeed()
    -- Формула: (FlySpeed - 6) * 8 + 8
    -- 6 = 8, 7 = 16, 8 = 24, 9 = 32, 10 = 40, 11 = 48, 12 = 56
    return (Settings.FlySpeed - 6) * 8 + 8
end

-- Функция для получения читаемого описания скорости
local function GetSpeedDescription()
    local actualSpeed = GetActualFlySpeed()
    return string.format("%d = %d", Settings.FlySpeed, actualSpeed)
end

-- Функция для телепортации
local function TeleportToPosition(targetPosition)
    local character = Player.Character
    if not character then return false end
    
    local rootPart = character:FindFirstChild("HumanoidRootPart")
    if not rootPart then return false end
    
    local startPos = rootPart.Position
    local direction = (targetPosition - startPos).Unit
    local distance = (startPos - targetPosition).Magnitude
    
    -- Если слишком близко, просто телепортируемся
    if distance < 5 then
        rootPart.CFrame = CFrame.new(targetPosition)
        return true
    end
    
    -- Используем фактическую скорость
    local actualSpeed = GetActualFlySpeed()
    local flyDuration = distance / actualSpeed
    local startTime = tick()
    local connection
    
    -- Телепортация с постоянной скоростью
    connection = RunService.Heartbeat:Connect(function()
        local currentTime = tick()
        local elapsed = currentTime - startTime
        
        if elapsed >= flyDuration then
            -- Точное прибытие
            rootPart.CFrame = CFrame.new(targetPosition)
            connection:Disconnect()
            return
        end
        
        -- Постоянная скорость (линейное движение)
        local progress = elapsed / flyDuration
        local currentPos = startPos + (direction * distance * progress)
        
        -- Постоянный поворот в направлении движения
        local lookDirection = (targetPosition - currentPos).Unit
        if lookDirection.Magnitude > 0 then
            rootPart.CFrame = CFrame.new(currentPos, currentPos + lookDirection)
        else
            rootPart.CFrame = CFrame.new(currentPos)
        end
    end)
    
    -- Ждем завершения полета
    wait(flyDuration + 0.1)
    if connection then
        connection:Disconnect()
    end
    
    return true
end

-- Функция для настройки скорости ходьбы
local function UpdateWalkSpeed()
    local character = Player.Character
    if not character then return end
    
    local humanoid = character:FindFirstChild("Humanoid")
    if not humanoid then return end
    
    if Settings.EnableWalkSpeed then
        humanoid.WalkSpeed = Settings.WalkSpeed
    else
        -- Возвращаем стандартную скорость
        humanoid.WalkSpeed = 16
    end
end

-- Функция для фарминга
local function StartAutoFarm()
    local farmThread = coroutine.create(function()
        while Settings.AutoFarm do
            local targetPosition = Settings.Locations[Settings.SelectedLocation]
            
            print(string.format("✈️ Летим к точке: %s (скорость: %d)", 
                Settings.SelectedLocation, GetActualFlySpeed()))
            local success = TeleportToPosition(targetPosition)
            
            if success then
                print("✅ Прибыли на точку")
                
                -- Имитация фарминга (3 секунды)
                wait(3)
                
                -- Автоматический переход на следующую точку
                local locationsList = {"star 1", "star 2", "star 3"}
                local currentIndex = table.find(locationsList, Settings.SelectedLocation) or 1
                local nextIndex = currentIndex % #locationsList + 1
                Settings.SelectedLocation = locationsList[nextIndex]
                UpdateUI()
            else
                print("❌ Ошибка при перемещении")
            end
            
            wait(0.5)
        end
    end)
    
    coroutine.resume(farmThread)
end

-- Создание элементов с тонкими кнопками
local function CreateButton(text, position, parent, height)
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(1, 0, 0, height or 38)  -- Тонкие кнопки
    button.Position = position
    button.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.Text = text
    button.Font = Enum.Font.Gotham
    button.TextSize = 14
    button.Parent = parent
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = button
    
    return button
end

local function CreateLabel(text, position, parent)
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, 0, 0, 25)
    label.Position = position
    label.BackgroundTransparency = 1
    label.TextColor3 = Color3.fromRGB(200, 200, 220)
    label.Text = text
    label.Font = Enum.Font.Gotham
    label.TextSize = 13
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = parent
    return label
end

local function CreateTextBox(defaultValue, position, parent, placeholder, height)
    local textBox = Instance.new("TextBox")
    textBox.Size = UDim2.new(1, 0, 0, height or 35)  -- Тонкие поля ввода
    textBox.Position = position
    textBox.BackgroundColor3 = Color3.fromRGB(35, 35, 55)
    textBox.TextColor3 = Color3.fromRGB(255, 255, 255)
    textBox.Text = tostring(defaultValue)
    textBox.Font = Enum.Font.Gotham
    textBox.TextSize = 14
    textBox.PlaceholderText = placeholder or "Enter value"
    textBox.PlaceholderColor3 = Color3.fromRGB(150, 150, 150)
    textBox.Parent = parent
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = textBox
    
    return textBox
end

-- Элементы вкладки Farm
local AutoFarmToggle = CreateButton("AutoFarm: OFF", UDim2.new(0, 0, 0, 0), FarmTab, 40)

local LocationLabel = CreateLabel("Target Location:", UDim2.new(0, 0, 0, 50), FarmTab)
local LocationDropdown = CreateButton("star 1 ▼", UDim2.new(0, 0, 0, 75), FarmTab, 40)

-- Элементы вкладки Config
local SpeedHackToggle = CreateButton("Speed Hack: OFF", UDim2.new(0, 0, 0, 0), ConfigTab, 40)

local FlySpeedLabel = CreateLabel("Tween Speed:", UDim2.new(0, 0, 0, 50), ConfigTab)
local FlySpeedBox = CreateTextBox(Settings.FlySpeed, UDim2.new(0, 0, 0, 75), ConfigTab, "6-12", 40)

local SpeedDescriptionLabel = CreateLabel(GetSpeedDescription(), UDim2.new(0, 0, 0, 120), ConfigTab)
SpeedDescriptionLabel.TextColor3 = Color3.fromRGB(180, 200, 255)
SpeedDescriptionLabel.TextSize = 12

local WalkSpeedLabel = CreateLabel("Walk Speed (40-80):", UDim2.new(0, 0, 0, 150), ConfigTab)
local WalkSpeedBox = CreateTextBox(Settings.WalkSpeed, UDim2.new(0, 0, 0, 175), ConfigTab, "40-80", 40)
WalkSpeedLabel.Visible = false
WalkSpeedBox.Visible = false

-- Popup для выбора локации
local LocationPopup = Instance.new("Frame")
LocationPopup.Size = UDim2.new(0.9, 0, 0, 160)
LocationPopup.Position = UDim2.new(0.05, 0, 0.5, -80)
LocationPopup.BackgroundColor3 = Color3.fromRGB(35, 35, 50)
LocationPopup.Visible = false
LocationPopup.Parent = MainFrame

local PopupCorner = Instance.new("UICorner")
PopupCorner.CornerRadius = UDim.new(0, 12)
PopupCorner.Parent = LocationPopup

local PopupTitle = Instance.new("TextLabel")
PopupTitle.Size = UDim2.new(1, 0, 0, 40)
PopupTitle.Position = UDim2.new(0, 0, 0, 0)
PopupTitle.BackgroundColor3 = Color3.fromRGB(45, 45, 65)
PopupTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
PopupTitle.Text = "Select Location"
PopupTitle.Font = Enum.Font.GothamBold
PopupTitle.TextSize = 16
PopupTitle.Parent = LocationPopup

-- Кнопки локаций
local locationButtons = {}
local yOffset = 45
for locationName, _ in pairs(Settings.Locations) do
    local button = CreateButton(locationName, UDim2.new(0.05, 0, 0, yOffset), LocationPopup, 35)
    button.Size = UDim2.new(0.9, 0, 0, 35)
    locationButtons[locationName] = button
    yOffset = yOffset + 45
end

-- Функции обновления интерфейса
local function UpdateUI()
    -- Обновляем кнопку AutoFarm
    if Settings.AutoFarm then
        AutoFarmToggle.Text = "AutoFarm: ON"
        AutoFarmToggle.BackgroundColor3 = Color3.fromRGB(40, 180, 80)
    else
        AutoFarmToggle.Text = "AutoFarm: OFF"
        AutoFarmToggle.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
    end
    
    -- Обновляем выбранную локацию
    LocationDropdown.Text = Settings.SelectedLocation .. " ▼"
    
    -- Обновляем Speed Hack
    if Settings.EnableWalkSpeed then
        SpeedHackToggle.Text = "Speed Hack: ON"
        SpeedHackToggle.BackgroundColor3 = Color3.fromRGB(40, 180, 80)
    else
        SpeedHackToggle.Text = "Speed Hack: OFF"
        SpeedHackToggle.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
    end
    
    -- Обновляем Fly Speed
    FlySpeedBox.Text = tostring(Settings.FlySpeed)
    SpeedDescriptionLabel.Text = GetSpeedDescription()
    
    -- Показываем/скрываем поле скорости ходьбы
    WalkSpeedLabel.Visible = Settings.EnableWalkSpeed
    WalkSpeedBox.Visible = Settings.EnableWalkSpeed
    if Settings.EnableWalkSpeed then
        WalkSpeedBox.Text = tostring(Settings.WalkSpeed)
    end
    
    -- Обновляем скорость ходьбы в игре
    UpdateWalkSpeed()
end

-- Функция проверки и применения скорости
local function ApplySpeedValue(textBox, minValue, maxValue, callback)
    local text = textBox.Text
    local number = tonumber(text)
    
    if number then
        number = math.floor(number) -- Целое число
        number = math.clamp(number, minValue, maxValue)
        callback(number)
        textBox.Text = tostring(number)
        UpdateUI()
    else
        -- Если не число, возвращаем предыдущее значение
        textBox.Text = tostring(callback())
    end
end

-- Анимация для кнопки свернуть/развернуть
ToggleButton.MouseEnter:Connect(function()
    TweenService:Create(
        ToggleButton,
        TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
        {BackgroundColor3 = Color3.fromRGB(70, 150, 210)}
    ):Play()
end)

ToggleButton.MouseLeave:Connect(function()
    TweenService:Create(
        ToggleButton,
        TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
        {BackgroundColor3 = Color3.fromRGB(50, 120, 180)}
    ):Play()
end)

-- Функция для сворачивания/разворачивания GUI
local function ToggleMinimize()
    if isMinimized then
        -- Разворачиваем
        isMinimized = false
        ToggleButton.Text = "×"
        
        local tween = TweenService:Create(
            MainFrame,
            TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
            {
                Size = UDim2.new(0, guiWidth, 0, guiHeight)
            }
        )
        
        -- Показываем контент
        TabButtonsFrame.Visible = true
        TabContentFrame.Visible = true
        
        tween:Play()
    else
        -- Сворачиваем
        isMinimized = true
        ToggleButton.Text = "+"
        
        -- Скрываем контент и попап
        TabButtonsFrame.Visible = false
        TabContentFrame.Visible = false
        LocationPopup.Visible = false
        
        local tween = TweenService:Create(
            MainFrame,
            TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
            {
                Size = UDim2.new(0, guiWidth, 0, 50) -- Только заголовок
            }
        )
        
        tween:Play()
    end
end

-- Обработчики событий вкладок
FarmTabButton.MouseButton1Click:Connect(function()
    FarmTab.Visible = true
    ConfigTab.Visible = false
    FarmTabButton.BackgroundColor3 = Color3.fromRGB(50, 120, 220)
    ConfigTabButton.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
end)

ConfigTabButton.MouseButton1Click:Connect(function()
    FarmTab.Visible = false
    ConfigTab.Visible = true
    FarmTabButton.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
    ConfigTabButton.BackgroundColor3 = Color3.fromRGB(50, 120, 220)
end)

AutoFarmToggle.MouseButton1Click:Connect(function()
    Settings.AutoFarm = not Settings.AutoFarm
    UpdateUI()
    
    if Settings.AutoFarm then
        StartAutoFarm()
    end
end)

SpeedHackToggle.MouseButton1Click:Connect(function()
    Settings.EnableWalkSpeed = not Settings.EnableWalkSpeed
    UpdateUI()
end)

LocationDropdown.MouseButton1Click:Connect(function()
    if not isMinimized then
        LocationPopup.Visible = not LocationPopup.Visible
    end
end)

for locationName, button in pairs(locationButtons) do
    button.MouseButton1Click:Connect(function()
        Settings.SelectedLocation = locationName
        LocationPopup.Visible = false
        UpdateUI()
    end)
end

-- Обработка Fly Speed Box
FlySpeedBox.FocusLost:Connect(function()
    ApplySpeedValue(FlySpeedBox, 6, 12, function(value)
        if value then
            Settings.FlySpeed = value
        end
        return Settings.FlySpeed
    end)
end)

-- Обработка Walk Speed Box
WalkSpeedBox.FocusLost:Connect(function()
    ApplySpeedValue(WalkSpeedBox, 40, 80, function(value)
        if value then
            Settings.WalkSpeed = value
        end
        return Settings.WalkSpeed
    end)
end)

-- Кнопка свернуть/развернуть
ToggleButton.MouseButton1Click:Connect(function()
    ToggleMinimize()
end)

-- Закрытие попапа при клике вне его
UserInputService.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        local mousePos = Vector2.new(Mouse.X, Mouse.Y)
        
        if LocationPopup.Visible and not isMinimized then
            local absPos = LocationPopup.AbsolutePosition
            local size = LocationPopup.AbsoluteSize
            if not (mousePos.X >= absPos.X and mousePos.X <= absPos.X + size.X and
                    mousePos.Y >= absPos.Y and mousePos.Y <= absPos.Y + size.Y) then
                LocationPopup.Visible = false
            end
        end
    end
end)

-- Перемещение GUI через заголовок (работает в обоих состояниях)
local dragging = false
local dragStart
local startPos

local function startDragging(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position
        
        -- Обработка окончания перетаскивания
        local connection
        connection = input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
                connection:Disconnect()
            end
        end)
    end
end

local function updateDragging(input)
    if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - dragStart
        local newPosition = UDim2.new(
            startPos.X.Scale, 
            startPos.X.Offset + delta.X,
            startPos.Y.Scale, 
            startPos.Y.Offset + delta.Y
        )
        
        MainFrame.Position = newPosition
    end
end

-- Подключаем события для заголовка
TitleBar.InputBegan:Connect(startDragging)
TitleBar.InputChanged:Connect(updateDragging)

-- Также позволяем перетаскивать за текст заголовка
TitleText.InputBegan:Connect(startDragging)
TitleText.InputChanged:Connect(updateDragging)

-- Инициализация UI
UpdateUI()

-- Обновляем скорость ходьбы при появлении персонажа
Player.CharacterAdded:Connect(function()
    wait(1) -- Ждем загрузки персонажа
    UpdateWalkSpeed()
end)

print("✅ Astra v1.0 загружен!")
print("📊 Вкладки:")
print("   Farm - AutoFarm и выбор точек")
print("   Config - Speed Hack и Tween Speed")
print("⚡ Система скорости:")
print("   6=8, 7=16, 8=24, 9=32, 10=40, 11=48, 12=56")
print("🎯 Широкий интерфейс с тонкими кнопками")
