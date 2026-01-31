-- BeeSwarm Simulator GUI Script для Xeno/Codexz инжекторов
-- Полностью рабочий GUI с перетаскиванием, Info, Farm, Settings

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local HttpService = game:GetService("HttpService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Переменные сессии и состояния
local sessionStart = tick()
local totalHoney = 0
local lastHoney = 0
local autoFarmEnabled = false
local autoDigEnabled = false
local autoSprinklerEnabled = false
local movementMode = "Tween" -- "Tween" или "Walk"
local useSpeedHack = false
local selectedLocation = "Mountain Top"

-- Получение текущего хани
local function getHoney()
    local leaderstats = player:FindFirstChild("leaderstats")
    if leaderstats then
        local honey = leaderstats:FindFirstChild("Honey")
        return honey and honey.Value or 0
    end
    return 0
end

-- Главный ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "BeeSwarmGUI"
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui

-- Перетаскиваемая кнопка входа
local entryButton = Instance.new("TextButton")
entryButton.Name = "EntryButton"
entryButton.Size = UDim2.new(0, 150, 0, 50)
entryButton.Position = UDim2.new(0, 10, 0.5, -25)
entryButton.BackgroundColor3 = Color3.fromRGB(0, 162, 255)
entryButton.Text = "🐝 BEE SWARM"
entryButton.TextColor3 = Color3.new(1,1,1)
entryButton.TextScaled = true
entryButton.Font = Enum.Font.GothamBold
entryButton.Parent = screenGui

local entryCorner = Instance.new("UICorner")
entryCorner.CornerRadius = UDim.new(0, 12)
entryCorner.Parent = entryButton

-- Главное меню
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 500, 0, 400)
mainFrame.Position = UDim2.new(0.5, -250, 0.5, -200)
mainFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
mainFrame.BorderSizePixel = 0
mainFrame.Visible = false
mainFrame.Parent = screenGui

local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 12)
mainCorner.Parent = mainFrame

-- Перетаскивание главного окна
local dragging = false
local dragStart = nil
local startPos = nil

mainFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = mainFrame.Position
    end
end)

mainFrame.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - dragStart
        mainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

-- Тень
local shadow = Instance.new("Frame")
shadow.Size = UDim2.new(1, 20, 1, 20)
shadow.Position = UDim2.new(0, -10, 0, -10)
shadow.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
shadow.BackgroundTransparency = 0.7
shadow.ZIndex = mainFrame.ZIndex - 1
shadow.Parent = mainFrame
local shadowCorner = Instance.new("UICorner")
shadowCorner.CornerRadius = UDim.new(0, 12)
shadowCorner.Parent = shadow

-- Заголовок
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -90, 0, 50)
title.Position = UDim2.new(0, 10, 0, 0)
title.BackgroundTransparency = 1
title.Text = "🐝 BeeSwarm Simulator GUI"
title.TextColor3 = Color3.new(1,1,1)
title.TextScaled = true
title.Font = Enum.Font.GothamBold
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = mainFrame

-- Кнопка закрытия
local closeButton = Instance.new("TextButton")
closeButton.Size = UDim2.new(0, 40, 0, 40)
closeButton.Position = UDim2.new(1, -50, 0, 5)
closeButton.BackgroundColor3 = Color3.fromRGB(255, 85, 85)
closeButton.Text = "✕"
closeButton.TextColor3 = Color3.new(1,1,1)
closeButton.TextScaled = true
closeButton.Font = Enum.Font.GothamBold
closeButton.Parent = mainFrame
local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(0, 8)
closeCorner.Parent = closeButton

-- Контейнер вкладок
local contentFrame = Instance.new("Frame")
contentFrame.Size = UDim2.new(1, -20, 1, -120)
contentFrame.Position = UDim2.new(0, 10, 0, 60)
contentFrame.BackgroundTransparency = 1
contentFrame.Parent = mainFrame

-- Вкладки
local tabs = {"Info", "Farm", "Settings"}
local tabButtons = {}
local tabContents = {}

for i, tabName in ipairs(tabs) do
    -- Кнопка вкладки
    local tabButton = Instance.new("TextButton")
    tabButton.Size = UDim2.new(0.33, -4, 0, 40)
    tabButton.Position = UDim2.new((i-1)*0.333, 2, 0, 0)
    tabButton.BackgroundColor3 = (i == 1) and Color3.fromRGB(70, 130, 255) or Color3.fromRGB(50, 50, 60)
    tabButton.Text = tabName
    tabButton.TextColor3 = Color3.new(1,1,1)
    tabButton.TextScaled = true
    tabButton.Font = Enum.Font.GothamBold
    tabButton.Parent = contentFrame
    tabButtons[tabName] = tabButton
    
    local tabCorner = Instance.new("UICorner")
    tabCorner.CornerRadius = UDim.new(0, 8)
    tabCorner.Parent = tabButton
    
    -- Контент вкладки
    local tabContent = Instance.new("Frame")
    tabContent.Size = UDim2.new(1, 0, 1, -50)
    tabContent.Position = UDim2.new(0, 0, 0, 50)
    tabContent.BackgroundTransparency = 1
    tabContent.Visible = (i == 1)
    tabContent.Parent = contentFrame
    tabContents[tabName] = tabContent
    
    -- Функция переключения вкладок
    tabButton.MouseButton1Click:Connect(function()
        for name, btn in pairs(tabButtons) do
            btn.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
        end
        tabButton.BackgroundColor3 = Color3.fromRGB(70, 130, 255)
        
        for name, cont in pairs(tabContents) do
            cont.Visible = (name == tabName)
        end
    end)
end

-- === INFO ВКЛАДКА ===
local infoContent = tabContents["Info"]

-- Время сессии
local sessionLabel = Instance.new("TextLabel")
sessionLabel.Size = UDim2.new(1, -20, 0, 40)
sessionLabel.Position = UDim2.new(0, 10, 0, 10)
sessionLabel.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
sessionLabel.Text = "Сессия: 00:00:00"
sessionLabel.TextColor3 = Color3.new(1,1,1)
sessionLabel.TextScaled = true
sessionLabel.Font = Enum.Font.Gotham
sessionLabel.Parent = infoContent
local sessionCorner = Instance.new("UICorner")
sessionCorner.CornerRadius = UDim.new(0, 8)
sessionCorner.Parent = sessionLabel

-- Хани в час
local honeyPerHourLabel = Instance.new("TextLabel")
honeyPerHourLabel.Size = UDim2.new(1, -20, 0, 40)
honeyPerHourLabel.Position = UDim2.new(0, 10, 0, 60)
honeyPerHourLabel.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
honeyPerHourLabel.Text = "Honey/час: 0"
honeyPerHourLabel.TextColor3 = Color3.new(1,1,1)
honeyPerHourLabel.TextScaled = true
honeyPerHourLabel.Font = Enum.Font.Gotham
honeyPerHourLabel.Parent = infoContent
local honeyCorner = Instance.new("UICorner")
honeyCorner.CornerRadius = UDim.new(0, 8)
honeyCorner.Parent = honeyPerHourLabel

-- === FARM ВКЛАДКА ===
local farmContent = tabContents["Farm"]

local autoFarmToggle = Instance.new("TextButton")
autoFarmToggle.Size = UDim2.new(1, -20, 0, 50)
autoFarmToggle.Position = UDim2.new(0, 10, 0, 10)
autoFarmToggle.BackgroundColor3 = Color3.fromRGB(76, 175, 80)
autoFarmToggle.Text = "✅ AutoFarm: ВЫКЛ"
autoFarmToggle.TextColor3 = Color3.new(1,1,1)
autoFarmToggle.TextScaled = true
autoFarmToggle.Font = Enum.Font.GothamBold
autoFarmToggle.Parent = farmContent
local farmCorner = Instance.new("UICorner")
farmCorner.CornerRadius = UDim.new(0, 8)
farmCorner.Parent = autoFarmToggle

local autoDigToggle = Instance.new("TextButton")
autoDigToggle.Size = UDim2.new(1, -20, 0, 50)
autoDigToggle.Position = UDim2.new(0, 10, 0, 70)
autoDigToggle.BackgroundColor3 = Color3.fromRGB(255, 193, 7)
autoDigToggle.Text = "⛏️ AutoDig: ВЫКЛ"
autoDigToggle.TextColor3 = Color3.new(1,1,1)
autoDigToggle.TextScaled = true
autoDigToggle.Font = Enum.Font.GothamBold
autoDigToggle.Parent = farmContent
local digCorner = Instance.new("UICorner")
digCorner.CornerRadius = UDim.new(0, 8)
digCorner.Parent = autoDigToggle

local autoSprinklerToggle = Instance.new("TextButton")
autoSprinklerToggle.Size = UDim2.new(1, -20, 0, 50)
autoSprinklerToggle.Position = UDim2.new(0, 10, 0, 130)
autoSprinklerToggle.BackgroundColor3 = Color3.fromRGB(255, 193, 7)
autoSprinklerToggle.Text = "💧 AutoSprinkler: ВЫКЛ"
autoSprinklerToggle.TextColor3 = Color3.new(1,1,1)
autoSprinklerToggle.TextScaled = true
autoSprinklerToggle.Font = Enum.Font.GothamBold
autoSprinklerToggle.Parent = farmContent
local sprinklerCorner = Instance.new("UICorner")
sprinklerCorner.CornerRadius = UDim.new(0, 8)
sprinklerCorner.Parent = autoSprinklerToggle

-- Выбор локации
local locationLabel = Instance.new("TextLabel")
locationLabel.Size = UDim2.new(1, -20, 0, 30)
locationLabel.Position = UDim2.new(0, 10, 0, 200)
locationLabel.BackgroundTransparency = 1
locationLabel.Text = "🎯 Локация:"
locationLabel.TextColor3 = Color3.new(1,1,1)
locationLabel.TextScaled = true
locationLabel.Font = Enum.Font.GothamBold
locationLabel.TextXAlignment = Enum.TextXAlignment.Left
locationLabel.Parent = farmContent

local locations = {"Mountain Top", "Pepper Patch", "Strawberry Field", "Pine Tree Forest"}
local locationButtons = {}

for i, loc in ipairs(locations) do
    local locBtn = Instance.new("TextButton")
    locBtn.Size = UDim2.new(0.48, -5, 0, 35)
    locBtn.Position = UDim2.new((i-1)*0.5, (i-1)%2*5 + 10, 0, 240)
    locBtn.BackgroundColor3 = (loc == selectedLocation) and Color3.fromRGB(70, 130, 255) or Color3.fromRGB(50, 50, 60)
    locBtn.Text = loc
    locBtn.TextColor3 = Color3.new(1,1,1)
    locBtn.TextScaled = true
    locBtn.Font = Enum.Font.Gotham
    locBtn.Parent = farmContent
    locationButtons[loc] = locBtn
    
    local locCorner = Instance.new("UICorner")
    locCorner.CornerRadius = UDim.new(0, 8)
    locCorner.Parent = locBtn
    
    locBtn.MouseButton1Click:Connect(function()
        selectedLocation = loc
        for name, btn in pairs(locationButtons) do
            btn.BackgroundColor3 = (name == loc) and Color3.fromRGB(70, 130, 255) or Color3.fromRGB(50, 50, 60)
        end
    end)
end

-- === SETTINGS ВКЛАДКА ===
local settingsContent = tabContents["Settings"]

local movementLabel = Instance.new("TextLabel")
movementLabel.Size = UDim2.new(1, -20, 0, 30)
movementLabel.Position = UDim2.new(0, 10, 0, 10)
movementLabel.BackgroundTransparency = 1
movementLabel.Text = "🚀 Movement Mode:"
movementLabel.TextColor3 = Color3.new(1,1,1)
movementLabel.TextScaled = true
movementLabel.Font = Enum.Font.GothamBold
movementLabel.TextXAlignment = Enum.TextXAlignment.Left
movementLabel.Parent = settingsContent

local tweenBtn = Instance.new("TextButton")
tweenBtn.Size = UDim2.new(0.48, -5, 0, 40)
tweenBtn.Position = UDim2.new(0, 10, 0, 45)
tweenBtn.BackgroundColor3 = Color3.fromRGB(70, 130, 255)
tweenBtn.Text = "Tween"
tweenBtn.TextColor3 = Color3.new(1,1,1)
tweenBtn.TextScaled = true
tweenBtn.Font = Enum.Font.GothamBold
tweenBtn.Parent = settingsContent

local walkBtn = Instance.new("TextButton")
walkBtn.Size = UDim2.new(0.48, -5, 0, 40)
walkBtn.Position = UDim2.new(0.52, 5, 0, 45)
walkBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
walkBtn.Text = "Walk"
walkBtn.TextColor3 = Color3.new(1,1,1)
walkBtn.TextScaled = true
walkBtn.Font = Enum.Font.GothamBold
walkBtn.Parent = settingsContent

local speedHackToggle = Instance.new("TextButton")
speedHackToggle.Size = UDim2.new(1, -20, 0, 50)
speedHackToggle.Position = UDim2.new(0, 10, 0, 100)
speedHackToggle.BackgroundColor3 = Color3.fromRGB(255, 193, 7)
speedHackToggle.Text = "⚡ Use SpeedHack: ВЫКЛ"
speedHackToggle.TextColor3 = Color3.new(1,1,1)
speedHackToggle.TextScaled = true
speedHackToggle.Font = Enum.Font.GothamBold
speedHackToggle.Parent = settingsContent
local speedCorner = Instance.new("UICorner")
speedCorner.CornerRadius = UDim.new(0, 8)
speedCorner.Parent = speedHackToggle

-- Обработчики кнопок
entryButton.MouseButton1Click:Connect(function()
    mainFrame.Visible = not mainFrame.Visible
    entryButton.Text = mainFrame.Visible and "🐝 СКРЫТЬ" or "🐝 BEE SWARM"
end)

closeButton.MouseButton1Click:Connect(function()
    mainFrame.Visible = false
    entryButton.Text = "🐝 BEE SWARM"
end)

-- Movement Mode переключение
tweenBtn.MouseButton1Click:Connect(function()
    movementMode = "Tween"
    tweenBtn.BackgroundColor3 = Color3.fromRGB(70, 130, 255)
    walkBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
end)

walkBtn.MouseButton1Click:Connect(function()
    movementMode = "Walk"
    tweenBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
    walkBtn.BackgroundColor3 = Color3.fromRGB(70, 130, 255)
end)

-- AutoFarm Toggle
autoFarmToggle.MouseButton1Click:Connect(function()
    autoFarmEnabled = not autoFarmEnabled
    autoFarmToggle.Text = autoFarmEnabled and "✅ AutoFarm: ВКЛ" or "❌ AutoFarm: ВЫКЛ"
    autoFarmToggle.BackgroundColor3 = autoFarmEnabled and Color3.fromRGB(76, 175, 80) or Color3.fromRGB(255, 85, 85)
end)

-- AutoDig Toggle
autoDigToggle.MouseButton1Click:Connect(function()
    autoDigEnabled = not autoDigEnabled
    autoDigToggle.Text = autoDigEnabled and "✅ AutoDig: ВКЛ" or "❌ AutoDig: ВЫКЛ"
    autoDigToggle.BackgroundColor3 = autoDigEnabled and Color3.fromRGB(76, 175, 80) or Color3.fromRGB(255, 193, 7)
end)

-- AutoSprinkler Toggle
autoSprinklerToggle.MouseButton1Click:Connect(function()
    autoSprinklerEnabled = not autoSprinklerEnabled
    autoSprinklerToggle.Text = autoSprinklerEnabled and "✅ AutoSprinkler: ВКЛ" or "❌ AutoSprinkler: ВЫКЛ"
    autoSprinklerToggle.BackgroundColor3 = autoSprinklerEnabled and Color3.fromRGB(76, 175, 80) or Color3.fromRGB(255, 193, 7)
end)

-- SpeedHack Toggle
speedHackToggle.MouseButton1Click:Connect(function()
    useSpeedHack = not useSpeedHack
    speedHackToggle.Text = useSpeedHack and "⚡ Use SpeedHack: ВКЛ" or "⚡ Use SpeedHack: ВЫКЛ"
    speedHackToggle.BackgroundColor3 = useSpeedHack and Color3.fromRGB(76, 175, 80) or Color3.fromRGB(255, 193, 7)
    
    local character = player.Character
    if character then
        local humanoid = character:FindFirstChild("Humanoid")
        if humanoid then
            humanoid.WalkSpeed = useSpeedHack and 100 or 16
        end
    end
end)

-- Обновление статистики сессии
spawn(function()
    while wait(1) do
        local currentHoney = getHoney()
        local sessionTime = tick() - sessionStart
        local hours = sessionTime / 3600
        local honeyPerHour = math.floor(((currentHoney - lastHoney) / sessionTime) * 3600)
        
        -- Форматирование времени
        local h = math.floor(sessionTime / 3600)
        local m = math.floor((sessionTime % 3600) / 60)
        local s = math.floor(sessionTime % 60)
        sessionLabel.Text = string.format("Сессия: %02d:%02d:%02d", h, m, s)
        honeyPerHourLabel.Text = string.format("Honey/час: %s", honeyPerHour > 0 and tostring(honeyPerHour) or "0")
        
        lastHoney = currentHoney
        totalHoney = currentHoney
    end
end)

-- Основной цикл фарма (базовая реализация)
spawn(function()
    while wait(0.1) do
        if autoFarmEnabled then
            -- Тупо пример - добавь реальную логику телепорта и сбора
            print("AutoFarm работает в", selectedLocation)
        end
        
        if autoDigEnabled then
            -- Автоматический взмах палкой (имитация)
            local tool = player.Character and player.Character:FindFirstChildOfClass("Tool")
            if tool then
                tool:Activate()
            end
        end
        
        if autoSprinklerEnabled then
            -- Авто спринклер (имитация)
            print("Установка спринклера...")
        end
    end
end)

print("🐝 BeeSwarm GUI загружен! Используй Xeno или Codexz для инжекта.")
