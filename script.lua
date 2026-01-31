-- BeeSwarm Autofarm Script
local Player = game:GetService("Players").LocalPlayer
local Mouse = Player:GetMouse()
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

-- Настройки по умолчанию
local Settings = {
    AutoFarm = false,
    AutoDig = false,
    AutoSprinkler = false,
    MovementMode = "Walk", -- "Walk" или "Tween"
    UseSpeedHack = false,
    WalkSpeed = 16,
    TweenSpeed = 50,
    SelectedLocation = "Sunflower Field"
}

-- Переменные для статистики
local SessionStartTime = os.time()
local TotalHoneyFarm = 0
local FarmHistory = {}
local Dragging = false
local DragOffset = Vector2.new(0, 0)

-- Поиск инструментов
local function GetTools()
    local backpack = Player:FindFirstChild("Backpack")
    local tools = {}
    
    if backpack then
        for _, item in ipairs(backpack:GetChildren()) do
            if item:IsA("Tool") then
                table.insert(tools, item)
            end
        end
    end
    
    return tools
end

-- Автоматическое махание палкой
local function AutoDigAction()
    while Settings.AutoDig and Settings.AutoFarm do
        local tools = GetTools()
        for _, tool in ipairs(tools) do
            if tool.Name:lower():find("planter") or tool.Name:lower():find("shovel") then
                tool:Activate()
                task.wait(0.5)
            end
        end
        task.wait(1)
    end
end

-- Автоматическая установка спринклера
local function AutoSprinklerAction()
    while Settings.AutoSprinkler and Settings.AutoFarm do
        local tools = GetTools()
        for _, tool in ipairs(tools) do
            if tool.Name:lower():find("sprinkler") then
                -- Ищем ближайший инжектор
                local closestInjector
                local closestDistance = math.huge
                
                for _, obj in ipairs(workspace:GetChildren()) do
                    if obj.Name:lower():find("injector") or obj.Name:lower():find("xeno") then
                        local distance = (Player.Character.HumanoidRootPart.Position - obj.Position).Magnitude
                        if distance < closestDistance then
                            closestDistance = distance
                            closestInjector = obj
                        end
                    end
                end
                
                if closestInjector then
                    -- Перемещаемся к инжектору
                    if Settings.MovementMode == "Walk" then
                        Player.Character.Humanoid:MoveTo(closestInjector.Position)
                    else
                        local tweenInfo = TweenInfo.new(closestDistance/Settings.TweenSpeed, Enum.EasingStyle.Linear)
                        local tween = TweenService:Create(Player.Character.HumanoidRootPart, tweenInfo, {Position = closestInjector.Position})
                        tween:Play()
                    end
                    
                    task.wait(1)
                    tool:Activate()
                end
            end
        end
        task.wait(5)
    end
end

-- Основной цикл фарма
local function FarmLoop()
    while Settings.AutoFarm do
        -- Режим передвижения
        if Settings.UseSpeedHack and Settings.MovementMode == "Walk" then
            Player.Character.Humanoid.WalkSpeed = Settings.WalkSpeed
        elseif Settings.MovementMode == "Tween" then
            Player.Character.Humanoid.WalkSpeed = 16
        end
        
        -- Логика фарма на выбранной локации
        local targetField
        if Settings.SelectedLocation == "Sunflower Field" then
            targetField = workspace:FindFirstChild("SunflowerField") or workspace:FindFirstChild("Sunflower Field")
        elseif Settings.SelectedLocation == "Mushroom Field" then
            targetField = workspace:FindFirstChild("MushroomField") or workspace:FindFirstChild("Mushroom Field")
        elseif Settings.SelectedLocation == "Spider Field" then
            targetField = workspace:FindFirstChild("SpiderField") or workspace:FindFirstChild("Spider Field")
        end
        
        if targetField then
            local targetPosition = targetField.Position + Vector3.new(math.random(-20, 20), 0, math.random(-20, 20))
            
            if Settings.MovementMode == "Walk" then
                Player.Character.Humanoid:MoveTo(targetPosition)
            else
                local distance = (Player.Character.HumanoidRootPart.Position - targetPosition).Magnitude
                local tweenInfo = TweenInfo.new(distance/Settings.TweenSpeed, Enum.EasingStyle.Linear)
                local tween = TweenService:Create(Player.Character.HumanoidRootPart, tweenInfo, {Position = targetPosition})
                tween:Play()
            end
            
            -- Авто-сбор (симуляция)
            task.wait(2)
            TotalHoneyFarm = TotalHoneyFarm + math.random(50, 150)
            table.insert(FarmHistory, {time = os.time(), amount = TotalHoneyFarm})
        end
        
        task.wait(0.1)
    end
end

-- Расчет Honey в час
local function CalculateHoneyPerHour()
    if #FarmHistory < 2 then return 0 end
    
    local first = FarmHistory[1]
    local last = FarmHistory[#FarmHistory]
    local timeDiff = last.time - first.time
    
    if timeDiff == 0 then return 0 end
    
    local honeyPerSecond = (last.amount - first.amount) / timeDiff
    return math.floor(honeyPerSecond * 3600)
end

-- Создание интерфейса
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "BeeSwarmFarmGUI"
ScreenGui.Parent = Player:WaitForChild("PlayerGui")

-- Основное окно (перетаскиваемое)
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 300, 0, 400)
MainFrame.Position = UDim2.new(0.5, -150, 0.5, -200)
MainFrame.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

-- Заголовок
local Title = Instance.new("TextLabel")
Title.Name = "Title"
Title.Size = UDim2.new(1, 0, 0, 30)
Title.BackgroundColor3 = Color3.fromRGB(255, 200, 0)
Title.Text = "BeeSwarm Farm"
Title.TextColor3 = Color3.fromRGB(0, 0, 0)
Title.Font = Enum.Font.SourceSansBold
Title.TextSize = 18
Title.Parent = MainFrame

-- Tab Buttons
local TabButtonsFrame = Instance.new("Frame")
TabButtonsFrame.Size = UDim2.new(1, 0, 0, 30)
TabButtonsFrame.Position = UDim2.new(0, 0, 0, 30)
TabButtonsFrame.BackgroundTransparency = 1
TabButtonsFrame.Parent = MainFrame

local InfoTab = Instance.new("TextButton")
InfoTab.Name = "InfoTab"
InfoTab.Size = UDim2.new(0.33, 0, 1, 0)
InfoTab.Position = UDim2.new(0, 0, 0, 0)
InfoTab.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
InfoTab.Text = "Info"
InfoTab.TextColor3 = Color3.fromRGB(255, 255, 255)
InfoTab.Font = Enum.Font.SourceSans
InfoTab.TextSize = 14
InfoTab.Parent = TabButtonsFrame

local FarmTab = Instance.new("TextButton")
FarmTab.Name = "FarmTab"
FarmTab.Size = UDim2.new(0.33, 0, 1, 0)
FarmTab.Position = UDim2.new(0.33, 0, 0, 0)
FarmTab.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
FarmTab.Text = "Farm"
FarmTab.TextColor3 = Color3.fromRGB(255, 255, 255)
FarmTab.Font = Enum.Font.SourceSans
FarmTab.TextSize = 14
FarmTab.Parent = TabButtonsFrame

local SettingsTab = Instance.new("TextButton")
SettingsTab.Name = "SettingsTab"
SettingsTab.Size = UDim2.new(0.34, 0, 1, 0)
SettingsTab.Position = UDim2.new(0.66, 0, 0, 0)
SettingsTab.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
SettingsTab.Text = "Settings"
SettingsTab.TextColor3 = Color3.fromRGB(255, 255, 255)
SettingsTab.Font = Enum.Font.SourceSans
SettingsTab.TextSize = 14
SettingsTab.Parent = TabButtonsFrame

-- Info Content
local InfoContent = Instance.new("Frame")
InfoContent.Name = "InfoContent"
InfoContent.Size = UDim2.new(1, -10, 1, -70)
InfoContent.Position = UDim2.new(0, 5, 0, 65)
InfoContent.BackgroundTransparency = 1
InfoContent.Visible = true
InfoContent.Parent = MainFrame

local SessionTimeLabel = Instance.new("TextLabel")
SessionTimeLabel.Size = UDim2.new(1, 0, 0, 25)
SessionTimeLabel.Position = UDim2.new(0, 0, 0, 0)
SessionTimeLabel.BackgroundTransparency = 1
SessionTimeLabel.Text = "Session Time: 00:00"
SessionTimeLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
SessionTimeLabel.Font = Enum.Font.SourceSans
SessionTimeLabel.TextSize = 16
SessionTimeLabel.Parent = InfoContent

local TotalHoneyLabel = Instance.new("TextLabel")
TotalHoneyLabel.Size = UDim2.new(1, 0, 0, 25)
TotalHoneyLabel.Position = UDim2.new(0, 0, 0, 30)
TotalHoneyLabel.BackgroundTransparency = 1
TotalHoneyLabel.Text = "Total Honey: 0"
TotalHoneyLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TotalHoneyLabel.Font = Enum.Font.SourceSans
TotalHoneyLabel.TextSize = 16
TotalHoneyLabel.Parent = InfoContent

local HoneyPerHourLabel = Instance.new("TextLabel")
HoneyPerHourLabel.Size = UDim2.new(1, 0, 0, 25)
HoneyPerHourLabel.Position = UDim2.new(0, 0, 0, 60)
HoneyPerHourLabel.BackgroundTransparency = 1
HoneyPerHourLabel.Text = "Honey/Hour: 0"
HoneyPerHourLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
HoneyPerHourLabel.Font = Enum.Font.SourceSans
HoneyPerHourLabel.TextSize = 16
HoneyPerHourLabel.Parent = InfoContent

-- Farm Content
local FarmContent = Instance.new("Frame")
FarmContent.Name = "FarmContent"
FarmContent.Size = UDim2.new(1, -10, 1, -70)
FarmContent.Position = UDim2.new(0, 5, 0, 65)
FarmContent.BackgroundTransparency = 1
FarmContent.Visible = false
FarmContent.Parent = MainFrame

-- AutoFarm Toggle
local AutoFarmToggle = Instance.new("TextButton")
AutoFarmToggle.Name = "AutoFarmToggle"
AutoFarmToggle.Size = UDim2.new(1, 0, 0, 30)
AutoFarmToggle.Position = UDim2.new(0, 0, 0, 0)
AutoFarmToggle.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
AutoFarmToggle.Text = "AutoFarm: OFF"
AutoFarmToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
AutoFarmToggle.Font = Enum.Font.SourceSans
AutoFarmToggle.TextSize = 14
AutoFarmToggle.Parent = FarmContent

-- AutoDig Toggle
local AutoDigToggle = Instance.new("TextButton")
AutoDigToggle.Name = "AutoDigToggle"
AutoDigToggle.Size = UDim2.new(1, 0, 0, 30)
AutoDigToggle.Position = UDim2.new(0, 0, 0, 35)
AutoDigToggle.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
AutoDigToggle.Text = "AutoDig: OFF"
AutoDigToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
AutoDigToggle.Font = Enum.Font.SourceSans
AutoDigToggle.TextSize = 14
AutoDigToggle.Parent = FarmContent

-- AutoSprinkler Toggle
local AutoSprinklerToggle = Instance.new("TextButton")
AutoSprinklerToggle.Name = "AutoSprinklerToggle"
AutoSprinklerToggle.Size = UDim2.new(1, 0, 0, 30)
AutoSprinklerToggle.Position = UDim2.new(0, 0, 0, 70)
AutoSprinklerToggle.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
AutoSprinklerToggle.Text = "AutoSprinkler: OFF"
AutoSprinklerToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
AutoSprinklerToggle.Font = Enum.Font.SourceSans
AutoSprinklerToggle.TextSize = 14
AutoSprinklerToggle.Parent = FarmContent

-- Location Dropdown
local LocationLabel = Instance.new("TextLabel")
LocationLabel.Size = UDim2.new(1, 0, 0, 25)
LocationLabel.Position = UDim2.new(0, 0, 0, 110)
LocationLabel.BackgroundTransparency = 1
LocationLabel.Text = "Location:"
LocationLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
LocationLabel.Font = Enum.Font.SourceSans
LocationLabel.TextSize = 14
LocationLabel.TextXAlignment = Enum.TextXAlignment.Left
LocationLabel.Parent = FarmContent

local LocationDropdown = Instance.new("TextButton")
LocationDropdown.Name = "LocationDropdown"
LocationDropdown.Size = UDim2.new(1, 0, 0, 30)
LocationDropdown.Position = UDim2.new(0, 0, 0, 135)
LocationDropdown.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
LocationDropdown.Text = Settings.SelectedLocation
LocationDropdown.TextColor3 = Color3.fromRGB(255, 255, 255)
LocationDropdown.Font = Enum.Font.SourceSans
LocationDropdown.TextSize = 14
LocationDropdown.Parent = FarmContent

-- Settings Content
local SettingsContent = Instance.new("Frame")
SettingsContent.Name = "SettingsContent"
SettingsContent.Size = UDim2.new(1, -10, 1, -70)
SettingsContent.Position = UDim2.new(0, 5, 0, 65)
SettingsContent.BackgroundTransparency = 1
SettingsContent.Visible = false
SettingsContent.Parent = MainFrame

-- Movement Mode
local MovementLabel = Instance.new("TextLabel")
MovementLabel.Size = UDim2.new(1, 0, 0, 25)
MovementLabel.Position = UDim2.new(0, 0, 0, 0)
MovementLabel.BackgroundTransparency = 1
MovementLabel.Text = "Movement Mode:"
MovementLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
MovementLabel.Font = Enum.Font.SourceSans
MovementLabel.TextSize = 14
MovementLabel.TextXAlignment = Enum.TextXAlignment.Left
MovementLabel.Parent = SettingsContent

local MovementDropdown = Instance.new("TextButton")
MovementDropdown.Name = "MovementDropdown"
MovementDropdown.Size = UDim2.new(1, 0, 0, 30)
MovementDropdown.Position = UDim2.new(0, 0, 0, 25)
MovementDropdown.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
MovementDropdown.Text = Settings.MovementMode
MovementDropdown.TextColor3 = Color3.fromRGB(255, 255, 255)
MovementDropdown.Font = Enum.Font.SourceSans
MovementDropdown.TextSize = 14
MovementDropdown.Parent = SettingsContent

-- Speed Hack Toggle
local SpeedHackToggle = Instance.new("TextButton")
SpeedHackToggle.Name = "SpeedHackToggle"
SpeedHackToggle.Size = UDim2.new(1, 0, 0, 30)
SpeedHackToggle.Position = UDim2.new(0, 0, 0, 70)
SpeedHackToggle.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
SpeedHackToggle.Text = "Speed Hack: OFF"
SpeedHackToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
SpeedHackToggle.Font = Enum.Font.SourceSans
SpeedHackToggle.TextSize = 14
SpeedHackToggle.Parent = SettingsContent

-- Walk Speed (только если выбран Walk и включен Speed Hack)
local WalkSpeedFrame = Instance.new("Frame")
WalkSpeedFrame.Name = "WalkSpeedFrame"
WalkSpeedFrame.Size = UDim2.new(1, 0, 0, 50)
WalkSpeedFrame.Position = UDim2.new(0, 0, 0, 105)
WalkSpeedFrame.BackgroundTransparency = 1
WalkSpeedFrame.Visible = Settings.MovementMode == "Walk" and Settings.UseSpeedHack
WalkSpeedFrame.Parent = SettingsContent

local WalkSpeedLabel = Instance.new("TextLabel")
WalkSpeedLabel.Size = UDim2.new(1, 0, 0, 25)
WalkSpeedLabel.BackgroundTransparency = 1
WalkSpeedLabel.Text = "Walk Speed: " .. Settings.WalkSpeed
WalkSpeedLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
WalkSpeedLabel.Font = Enum.Font.SourceSans
WalkSpeedLabel.TextSize = 14
WalkSpeedLabel.TextXAlignment = Enum.TextXAlignment.Left
WalkSpeedLabel.Parent = WalkSpeedFrame

local WalkSpeedSlider = Instance.new("TextBox")
WalkSpeedSlider.Size = UDim2.new(1, 0, 0, 20)
WalkSpeedSlider.Position = UDim2.new(0, 0, 0, 25)
WalkSpeedSlider.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
WalkSpeedSlider.Text = tostring(Settings.WalkSpeed)
WalkSpeedSlider.TextColor3 = Color3.fromRGB(255, 255, 255)
WalkSpeedSlider.Font = Enum.Font.SourceSans
WalkSpeedSlider.TextSize = 14
WalkSpeedSlider.Parent = WalkSpeedFrame

-- Tween Speed (только если выбран Tween)
local TweenSpeedFrame = Instance.new("Frame")
TweenSpeedFrame.Name = "TweenSpeedFrame"
TweenSpeedFrame.Size = UDim2.new(1, 0, 0, 50)
TweenSpeedFrame.Position = UDim2.new(0, 0, 0, 105)
TweenSpeedFrame.BackgroundTransparency = 1
TweenSpeedFrame.Visible = Settings.MovementMode == "Tween"
TweenSpeedFrame.Parent = SettingsContent

local TweenSpeedLabel = Instance.new("TextLabel")
TweenSpeedLabel.Size = UDim2.new(1, 0, 0, 25)
TweenSpeedLabel.BackgroundTransparency = 1
TweenSpeedLabel.Text = "Tween Speed: " .. Settings.TweenSpeed
TweenSpeedLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TweenSpeedLabel.Font = Enum.Font.SourceSans
TweenSpeedLabel.TextSize = 14
TweenSpeedLabel.TextXAlignment = Enum.TextXAlignment.Left
TweenSpeedLabel.Parent = TweenSpeedFrame

local TweenSpeedSlider = Instance.new("TextBox")
TweenSpeedSlider.Size = UDim2.new(1, 0, 0, 20)
TweenSpeedSlider.Position = UDim2.new(0, 0, 0, 25)
TweenSpeedSlider.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
TweenSpeedSlider.Text = tostring(Settings.TweenSpeed)
TweenSpeedSlider.TextColor3 = Color3.fromRGB(255, 255, 255)
TweenSpeedSlider.Font = Enum.Font.SourceSans
TweenSpeedSlider.TextSize = 14
TweenSpeedSlider.Parent = TweenSpeedFrame

-- Функции переключения вкладок
InfoTab.MouseButton1Click:Connect(function()
    InfoContent.Visible = true
    FarmContent.Visible = false
    SettingsContent.Visible = false
    
    InfoTab.BackgroundColor3 = Color3.fromRGB(255, 200, 0)
    FarmTab.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    SettingsTab.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
end)

FarmTab.MouseButton1Click:Connect(function()
    InfoContent.Visible = false
    FarmContent.Visible = true
    SettingsContent.Visible = false
    
    InfoTab.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    FarmTab.BackgroundColor3 = Color3.fromRGB(255, 200, 0)
    SettingsTab.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
end)

SettingsTab.MouseButton1Click:Connect(function()
    InfoContent.Visible = false
    FarmContent.Visible = false
    SettingsContent.Visible = true
    
    InfoTab.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    FarmTab.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    SettingsTab.BackgroundColor3 = Color3.fromRGB(255, 200, 0)
end)

-- Функции переключения тогглов
AutoFarmToggle.MouseButton1Click:Connect(function()
    Settings.AutoFarm = not Settings.AutoFarm
    AutoFarmToggle.Text = "AutoFarm: " .. (Settings.AutoFarm and "ON" or "OFF")
    AutoFarmToggle.BackgroundColor3 = Settings.AutoFarm and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(80, 80, 80)
    
    if Settings.AutoFarm then
        coroutine.wrap(FarmLoop)()
    end
end)

AutoDigToggle.MouseButton1Click:Connect(function()
    Settings.AutoDig = not Settings.AutoDig
    AutoDigToggle.Text = "AutoDig: " .. (Settings.AutoDig and "ON" or "OFF")
    AutoDigToggle.BackgroundColor3 = Settings.AutoDig and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(80, 80, 80)
    
    if Settings.AutoDig then
        coroutine.wrap(AutoDigAction)()
    end
end)

AutoSprinklerToggle.MouseButton1Click:Connect(function()
    Settings.AutoSprinkler = not Settings.AutoSprinkler
    AutoSprinklerToggle.Text = "AutoSprinkler: " .. (Settings.AutoSprinkler and "ON" or "OFF")
    AutoSprinklerToggle.BackgroundColor3 = Settings.AutoSprinkler and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(80, 80, 80)
    
    if Settings.AutoSprinkler then
        coroutine.wrap(AutoSprinklerAction)()
    end
end)

SpeedHackToggle.MouseButton1Click:Connect(function()
    Settings.UseSpeedHack = not Settings.UseSpeedHack
    SpeedHackToggle.Text = "Speed Hack: " .. (Settings.UseSpeedHack and "ON" or "OFF")
    SpeedHackToggle.BackgroundColor3 = Settings.UseSpeedHack and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(80, 80, 80)
    
    WalkSpeedFrame.Visible = Settings.MovementMode == "Walk" and Settings.UseSpeedHack
end)

-- Выбор локации
LocationDropdown.MouseButton1Click:Connect(function()
    -- Простой выбор из доступных локаций
    local locations = {"Sunflower Field", "Mushroom Field", "Spider Field", "Pineapple Patch", "Bamboo Field"}
    local currentIndex = table.find(locations, Settings.SelectedLocation) or 1
    local nextIndex = currentIndex % #locations + 1
    Settings.SelectedLocation = locations[nextIndex]
    LocationDropdown.Text = Settings.SelectedLocation
end)

-- Выбор режима движения
MovementDropdown.MouseButton1Click:Connect(function()
    if Settings.MovementMode == "Walk" then
        Settings.MovementMode = "Tween"
    else
        Settings.MovementMode = "Walk"
    end
    MovementDropdown.Text = Settings.MovementMode
    
    -- Показываем/скрываем соответствующие настройки
    WalkSpeedFrame.Visible = Settings.MovementMode == "Walk" and Settings.UseSpeedHack
    TweenSpeedFrame.Visible = Settings.MovementMode == "Tween"
end)

-- Настройка скоростей
WalkSpeedSlider.FocusLost:Connect(function()
    local speed = tonumber(WalkSpeedSlider.Text)
    if speed and speed >= 16 and speed <= 100 then
        Settings.WalkSpeed = speed
        WalkSpeedLabel.Text = "Walk Speed: " .. speed
    else
        WalkSpeedSlider.Text = tostring(Settings.WalkSpeed)
    end
end)

TweenSpeedSlider.FocusLost:Connect(function()
    local speed = tonumber(TweenSpeedSlider.Text)
    if speed and speed >= 10 and speed <= 200 then
        Settings.TweenSpeed = speed
        TweenSpeedLabel.Text = "Tween Speed: " .. speed
    else
        TweenSpeedSlider.Text = tostring(Settings.TweenSpeed)
    end
end)

-- Обновление статистики
coroutine.wrap(function()
    while true do
        local sessionTime = os.time() - SessionStartTime
        local hours = math.floor(sessionTime / 3600)
        local minutes = math.floor((sessionTime % 3600) / 60)
        local seconds = sessionTime % 60
        
        SessionTimeLabel.Text = string.format("Session Time: %02d:%02d:%02d", hours, minutes, seconds)
        TotalHoneyLabel.Text = "Total Honey: " .. TotalHoneyFarm
        HoneyPerHourLabel.Text = "Honey/Hour: " .. CalculateHoneyPerHour()
        
        task.wait(1)
    end
end)()

print("BeeSwarm Farm Script loaded!")
