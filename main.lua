-- Bee Swarm Simulator Ultimate Script by Perplexity (2026)
-- PlaceId: 1537690962
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local PathfindingService = game:GetService("PathfindingService")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TeleportService = game:GetService("TeleportService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Проверка PlaceId
if game.PlaceId ~= 1537690962 then
    game.StarterGui:SetCore("SendNotification", {
        Title = "BSS Script Error";
        Text = "Это не Bee Swarm Simulator! (PlaceId: " .. game.PlaceId .. ")";
        Duration = 5;
    })
    return
end

-- Загрузка UI библиотеки (Kavo UI)
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("BSS Ultimate v1.0", "DarkTheme")

-- Config
local config = {
    movementMethod = "Tween", -- Walk или Tween
    speedHack = false,
    speedValue = 50,
    autoFarm = false,
    autoDig = false,
    farmLocation = "Sunflower Field"
}

-- Локации полей
local fields = {
    "Sunflower Field", "Mushroom Field", "Spider Field", "Clover Field",
    "Bamboo Field", "Mountain Top Field", "Strawberry Field", "Pineapple Field"
}

-- Функция поиска свободного улья
local function findFreeHive()
    local hives = workspace:FindFirstChild("Hives")
    if hives then
        for _, hive in pairs(hives:GetChildren()) do
            if hive:FindFirstChild("Owner") and hive.Owner.Value == "" then
                return hive
            end
        end
    end
    return nil
end

-- Движение к позиции
local function moveTo(position, method)
    if method == "Tween" then
        local tween = TweenService:Create(player.Character.HumanoidRootPart, 
            TweenInfo.new(2, Enum.EasingStyle.Linear), {CFrame = CFrame.new(position)})
        tween:Play()
        tween.Completed:Wait()
    else -- Walk
        local path = PathfindingService:CreatePath()
        path:ComputeAsync(player.Character.HumanoidRootPart.Position, position)
        local waypoints = path:GetWaypoints()
        for _, wp in pairs(waypoints) do
            player.Character.Humanoid:MoveTo(wp.Position)
            player.Character.Humanoid.MoveToFinished:Wait()
        end
    end
end

-- AutoFarm функция
local autoFarmConnection
local function toggleAutoFarm(state)
    config.autoFarm = state
    if state and player.Character then
        spawn(function()
            while config.autoFarm do
                -- Идём на выбранное поле
                local fieldPos = workspace.Flowers[config.farmLocation].Position
                moveTo(fieldPos, config.movementMethod)
                
                -- Собираем токены на сайте (радиус 50 studs)
                for _, token in pairs(workspace:GetChildren()) do
                    if token.Name == "Token" and (token.Position - player.Character.HumanoidRootPart.Position).Magnitude < 50 then
                        fireclickdetector(token.ClickDetector)
                    end
                end
                
                -- Проверяем рюкзак Pollen
                local pollen = player.PlayerGui:GetScreenGui("PollenGui").Pollen.Value
                if pollen >= 100 then -- Полный рюкзак
                    local hive = findFreeHive() or player.Character.Hive -- Свой улей
                    moveTo(hive.Position, config.movementMethod)
                    fireclickdetector(hive.ClickDetector) -- Сдаём E
                    wait(2)
                end
                wait(0.5)
            end
        end)
    end
end

-- AutoDig функция
local autoDigConnection
local function toggleAutoDig(state)
    config.autoDig = state
    if state then
        autoDigConnection = RunService.Heartbeat:Connect(function()
            -- Автоматический взмах палкой
            game:GetService("VirtualInputManager"):SendMouseButtonEvent(0, 0, 0, true, game, 1)
            wait(0.1)
            game:GetService("VirtualInputManager"):SendMouseButtonEvent(0, 0, 0, false, game, 1)
        end)
    else
        if autoDigConnection then autoDigConnection:Disconnect() end
    end
end

-- SpeedHack
local speedConnection
local function toggleSpeedHack(state)
    config.speedHack = state
    if state and player.Character then
        speedConnection = RunService.Heartbeat:Connect(function()
            player.Character.Humanoid.WalkSpeed = config.speedValue
        end)
    else
        if speedConnection then speedConnection:Disconnect() end
        player.Character.Humanoid.WalkSpeed = 16
    end
end

## GUI Панель
local configTab = Window:NewTab("Config")
local configSection = configTab:NewSection("Movement Method")
configSection:NewDropdown("MovementMethod", "Walk/Tween", {"Walk", "Tween"}, function(selected)
    config.movementMethod = selected
end)

local settingsTab = configTab:NewTab("Settings")
local settingsSection = settingsTab:NewSection("SpeedHack")
settingsSection:NewToggle("SpeedHack", "Enable SpeedHack", function(state)
    toggleSpeedHack(state)
end)
settingsSection:NewSlider("SpeedSlider", "Speed 40-90", 500, 40, function(s)
    config.speedValue = s
end)

local farmTab = Window:NewTab("AutoFarm")
local farmSection = farmTab:NewSection("Main")
farmSection:NewToggle("AutoFarmToggle", "AutoFarm ☐", function(state)
    toggleAutoFarm(state)
end)

farmSection:NewDropdown("FarmLocation", "Select Field", fields, function(selected)
    config.farmLocation = selected
end)

local digSection = farmTab:NewSection("AutoDig")
digSection:NewToggle("AutoDigToggle", "AutoDig ☐", function(state)
    toggleAutoDig(state)
end)

-- Инициализация: найти улей при запуске
spawn(function()
    local freeHive = findFreeHive()
    if freeHive then
        moveTo(freeHive.Position, config.movementMethod)
        wait(1)
        fireclickdetector(freeHive.ClickDetector) -- Занимаем E
    end
end)

print("BSS Ultimate Script загружен! Удачи, бро! 🐝")
