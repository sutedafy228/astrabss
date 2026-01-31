-- Astra v1.0 for BeeSwarm Simulator
local Player = game:GetService("Players").LocalPlayer
local Mouse = Player:GetMouse()
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local HttpService = game:GetService("HttpService")
local TeleportService = game:GetService("TeleportService")

-- Настройки
local Settings = {
    AutoFarm = false,
    AutoSprinkler = false,
    AutoDig = false,
    MovementMode = "Walk",
    UseRemotes = true,
    UseRedCannon = false,
    UseJumpShortcuts = false,
    EnableWalkSpeed = false,
    DynamicWalkSpeed = false,
    WalkSpeed = 16,
    TargetField = "Pepper Patch",
    ConvertSettings = {Enabled = false},
    GuidingStarSettings = {Enabled = false},
    SproutSettings = {Enabled = false}
}

-- Статистика
local SessionStart = os.time()
local ServerStartTime = os.time() - math.random(3600, 86400) -- Для демонстрации
local SessionHoney = 0
local TotalHoney = 0
local HoneyHistory = {}

-- Создание GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "AstraGUI"
ScreenGui.Parent = Player:WaitForChild("PlayerGui")

-- Основной контейнер
local MainContainer = Instance.new("Frame")
MainContainer.Name = "MainContainer"
MainContainer.Size = UDim2.new(0, 900, 0, 500)
MainContainer.Position = UDim2.new(0.5, -450, 0.5, -250)
MainContainer.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
MainContainer.BorderSizePixel = 0
MainContainer.ClipsDescendants = true
MainContainer.Parent = ScreenGui

-- Верхняя панель статуса
local TopBar = Instance.new("Frame")
TopBar.Name = "TopBar"
TopBar.Size = UDim2.new(1, 0, 0, 40)
TopBar.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
TopBar.BorderSizePixel = 0
TopBar.Parent = MainContainer

local MeALabel = Instance.new("TextLabel")
MeALabel.Name = "MeALabel"
MeALabel.Size = UDim2.new(0, 100, 1, 0)
MeALabel.Position = UDim2.new(0, 10, 0, 0)
MeALabel.BackgroundTransparency = 1
MeALabel.Text = "MeA: 780"
MeALabel.TextColor3 = Color3.fromRGB(255, 255, 255)
MeALabel.Font = Enum.Font.GothamSemibold
MeALabel.TextSize = 16
MeALabel.TextXAlignment = Enum.TextXAlignment.Left
MeALabel.Parent = TopBar

local CapacityLabel = Instance.new("TextLabel")
CapacityLabel.Name = "CapacityLabel"
CapacityLabel.Size = UDim2.new(0, 100, 1, 0)
CapacityLabel.Position = UDim2.new(1, -110, 0, 0)
CapacityLabel.BackgroundTransparency = 1
CapacityLabel.Text = "48/200"
CapacityLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
CapacityLabel.Font = Enum.Font.GothamSemibold
CapacityLabel.TextSize = 16
CapacityLabel.TextXAlignment = Enum.TextXAlignment.Right
CapacityLabel.Parent = TopBar

local HoneyPerSecLabel = Instance.new("TextLabel")
HoneyPerSecLabel.Name = "HoneyPerSecLabel"
HoneyPerSecLabel.Size = UDim2.new(0, 120, 1, 0)
HoneyPerSecLabel.Position = UDim2.new(1, -230, 0, 0)
HoneyPerSecLabel.BackgroundTransparency = 1
HoneyPerSecLabel.Text = "(+4/sec)"
HoneyPerSecLabel.TextColor3 = Color3.fromRGB(100, 255, 100)
HoneyPerSecLabel.Font = Enum.Font.Gotham
HoneyPerSecLabel.TextSize = 14
HoneyPerSecLabel.TextXAlignment = Enum.TextXAlignment.Right
HoneyPerSecLabel.Visible = false
HoneyPerSecLabel.Parent = TopBar

-- Левое меню
local LeftMenu = Instance.new("Frame")
LeftMenu.Name = "LeftMenu"
LeftMenu.Size = UDim2.new(0, 180, 1, -40)
LeftMenu.Position = UDim2.new(0, 0, 0, 40)
LeftMenu.BackgroundColor3 = Color3.fromRGB(35, 35, 40)
LeftMenu.BorderSizePixel = 0
LeftMenu.Parent = MainContainer

local Title = Instance.new("TextLabel")
Title.Name = "Title"
Title.Size = UDim2.new(1, 0, 0, 60)
Title.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
Title.Text = "Atlas v1.0"
Title.TextColor3 = Color3.fromRGB(220, 220, 255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 22
Title.Parent = LeftMenu

local QSearchButton = Instance.new("TextButton")
QSearchButton.Name = "QSearchButton"
QSearchButton.Size = UDim2.new(1, -20, 0, 35)
QSearchButton.Position = UDim2.new(0, 10, 0, 70)
QSearchButton.BackgroundColor3 = Color3.fromRGB(50, 50, 55)
QSearchButton.Text = "Q Search"
QSearchButton.TextColor3 = Color3.fromRGB(255, 255, 255)
QSearchButton.Font = Enum.Font.Gotham
QSearchButton.TextSize = 14
QSearchButton.Parent = LeftMenu

-- Список кнопок меню
local MenuButtons = {
    {Name = "Home", Text = "Home", Icon = "①"},
    {Name = "Farming", Text = "Farming", Icon = ""},
    {Name = "Combat", Text = "Combat", Icon = ""},
    {Name = "Quests", Text = "Quests", Icon = ""},
    {Name = "Planters", Text = "Planters", Icon = ""},
    {Name = "Toys", Text = "Toys", Icon = ""},
    {Name = "RBC", Text = "RBC", Icon = ""},
    {Name = "Webhook", Text = "Webhook", Icon = ""},
    {Name = "Config", Text = "Config", Icon = ""},
    {Name = "Debug", Text = "Debug", Icon = ""}
}

local CurrentPage = "Home"
local MenuButtonInstances = {}

for i, buttonData in ipairs(MenuButtons) do
    local MenuButton = Instance.new("TextButton")
    MenuButton.Name = buttonData.Name .. "Button"
    MenuButton.Size = UDim2.new(1, -20, 0, 35)
    MenuButton.Position = UDim2.new(0, 10, 0, 110 + (i-1) * 40)
    MenuButton.BackgroundColor3 = Color3.fromRGB(50, 50, 55)
    MenuButton.Text = (buttonData.Icon ~= "" and buttonData.Icon .. " " or "") .. buttonData.Text
    MenuButton.TextColor3 = Color3.fromRGB(200, 200, 200)
    MenuButton.Font = Enum.Font.Gotham
    MenuButton.TextSize = 14
    MenuButton.TextXAlignment = Enum.TextXAlignment.Left
    MenuButton.Parent = LeftMenu
    
    local Padding = Instance.new("UIPadding")
    Padding.PaddingLeft = UDim.new(0, 15)
    Padding.Parent = MenuButton
    
    MenuButtonInstances[buttonData.Name] = MenuButton
end

-- Правая панель контента
local ContentPanel = Instance.new("Frame")
ContentPanel.Name = "ContentPanel"
ContentPanel.Size = UDim2.new(1, -180, 1, -40)
ContentPanel.Position = UDim2.new(0, 180, 0, 40)
ContentPanel.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
ContentPanel.BorderSizePixel = 0
ContentPanel.Parent = MainContainer

-- Страница Home
local HomePage = Instance.new("ScrollingFrame")
HomePage.Name = "HomePage"
HomePage.Size = UDim2.new(1, 0, 1, 0)
HomePage.BackgroundTransparency = 1
HomePage.BorderSizePixel = 0
HomePage.ScrollBarThickness = 6
HomePage.ScrollBarImageColor3 = Color3.fromRGB(80, 80, 90)
HomePage.CanvasSize = UDim2.new(0, 0, 0, 600)
HomePage.Visible = true
HomePage.Parent = ContentPanel

local UptimeLabel = Instance.new("TextLabel")
UptimeLabel.Name = "UptimeLabel"
UptimeLabel.Size = UDim2.new(1, -40, 0, 30)
UptimeLabel.Position = UDim2.new(0, 20, 0, 20)
UptimeLabel.BackgroundTransparency = 1
UptimeLabel.Text = "Uptime: 00:00:00"
UptimeLabel.TextColor3 = Color3.fromRGB(220, 220, 255)
UptimeLabel.Font = Enum.Font.GothamSemibold
UptimeLabel.TextSize = 16
UptimeLabel.TextXAlignment = Enum.TextXAlignment.Left
UptimeLabel.Parent = HomePage

local ServerUptimeLabel = Instance.new("TextLabel")
ServerUptimeLabel.Name = "ServerUptimeLabel"
ServerUptimeLabel.Size = UDim2.new(1, -40, 0, 30)
ServerUptimeLabel.Position = UDim2.new(0, 20, 0, 60)
ServerUptimeLabel.BackgroundTransparency = 1
ServerUptimeLabel.Text = "Server Uptime: 00:00:00"
ServerUptimeLabel.TextColor3 = Color3.fromRGB(200, 200, 220)
ServerUptimeLabel.Font = Enum.Font.Gotham
ServerUptimeLabel.TextSize = 14
ServerUptimeLabel.TextXAlignment = Enum.TextXAlignment.Left
ServerUptimeLabel.Parent = HomePage

local SessionHoneyLabel = Instance.new("TextLabel")
SessionHoneyLabel.Name = "SessionHoneyLabel"
SessionHoneyLabel.Size = UDim2.new(1, -40, 0, 30)
SessionHoneyLabel.Position = UDim2.new(0, 20, 0, 120)
SessionHoneyLabel.BackgroundTransparency = 1
SessionHoneyLabel.Text = "Session Honey: 0"
SessionHoneyLabel.TextColor3 = Color3.fromRGB(220, 220, 255)
SessionHoneyLabel.Font = Enum.Font.GothamSemibold
SessionHoneyLabel.TextSize = 16
SessionHoneyLabel.TextXAlignment = Enum.TextXAlignment.Left
SessionHoneyLabel.Parent = HomePage

local HoneyPerHourLabel = Instance.new("TextLabel")
HoneyPerHourLabel.Name = "HoneyPerHourLabel"
HoneyPerHourLabel.Size = UDim2.new(1, -40, 0, 30)
HoneyPerHourLabel.Position = UDim2.new(0, 20, 0, 160)
HoneyPerHourLabel.BackgroundTransparency = 1
HoneyPerHourLabel.Text = "Honey per Hour: 0"
HoneyPerHourLabel.TextColor3 = Color3.fromRGB(200, 200, 220)
HoneyPerHourLabel.Font = Enum.Font.Gotham
HoneyPerHourLabel.TextSize = 14
HoneyPerHourLabel.TextXAlignment = Enum.TextXAlignment.Left
HoneyPerHourLabel.Parent = HomePage

local StopEverythingButton = Instance.new("TextButton")
StopEverythingButton.Name = "StopEverythingButton"
StopEverythingButton.Size = UDim2.new(1, -40, 0, 40)
StopEverythingButton.Position = UDim2.new(0, 20, 0, 220)
StopEverythingButton.BackgroundColor3 = Color3.fromRGB(200, 60, 60)
StopEverythingButton.Text = "Stop Everything"
StopEverythingButton.TextColor3 = Color3.fromRGB(255, 255, 255)
StopEverythingButton.Font = Enum.Font.GothamBold
StopEverythingButton.TextSize = 16
StopEverythingButton.Parent = HomePage

local CodexAndScriptFrame = Instance.new("Frame")
CodexAndScriptFrame.Name = "CodexAndScriptFrame"
CodexAndScriptFrame.Size = UDim2.new(1, -40, 0, 100)
CodexAndScriptFrame.Position = UDim2.new(0, 20, 0, 280)
CodexAndScriptFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 55)
CodexAndScriptFrame.BorderSizePixel = 0
CodexAndScriptFrame.Parent = HomePage

local CodexLabel = Instance.new("TextLabel")
CodexLabel.Name = "CodexLabel"
CodexLabel.Size = UDim2.new(1, 0, 0, 30)
CodexLabel.BackgroundTransparency = 1
CodexLabel.Text = "Codex Andr"
CodexLabel.TextColor3 = Color3.fromRGB(180, 180, 255)
CodexLabel.Font = Enum.Font.GothamSemibold
CodexLabel.TextSize = 15
CodexLabel.TextXAlignment = Enum.TextXAlignment.Left
CodexLabel.Parent = CodexAndScriptFrame

local UIPadding1 = Instance.new("UIPadding")
UIPadding1.PaddingLeft = UDim.new(0, 10)
UIPadding1.Parent = CodexLabel

local ScriptExecuteLabel = Instance.new("TextLabel")
ScriptExecuteLabel.Name = "ScriptExecuteLabel"
ScriptExecuteLabel.Size = UDim2.new(1, 0, 0, 30)
ScriptExecuteLabel.Position = UDim2.new(0, 0, 0, 40)
ScriptExecuteLabel.BackgroundTransparency = 1
ScriptExecuteLabel.Text = "Script Execute"
ScriptExecuteLabel.TextColor3 = Color3.fromRGB(180, 180, 255)
ScriptExecuteLabel.Font = Enum.Font.GothamSemibold
ScriptExecuteLabel.TextSize = 15
ScriptExecuteLabel.TextXAlignment = Enum.TextXAlignment.Left
ScriptExecuteLabel.Parent = CodexAndScriptFrame

local UIPadding2 = Instance.new("UIPadding")
UIPadding2.PaddingLeft = UDim.new(0, 10)
UIPadding2.Parent = ScriptExecuteLabel

-- Страница Farming
local FarmingPage = Instance.new("ScrollingFrame")
FarmingPage.Name = "FarmingPage"
FarmingPage.Size = UDim2.new(1, 0, 1, 0)
FarmingPage.BackgroundTransparency = 1
FarmingPage.BorderSizePixel = 0
FarmingPage.ScrollBarThickness = 6
FarmingPage.ScrollBarImageColor3 = Color3.fromRGB(80, 80, 90)
FarmingPage.CanvasSize = UDim2.new(0, 0, 0, 800)
FarmingPage.Visible = false
FarmingPage.Parent = ContentPanel

-- Field Selection
local FieldFrame = Instance.new("Frame")
FieldFrame.Name = "FieldFrame"
FieldFrame.Size = UDim2.new(1, -40, 0, 60)
FieldFrame.Position = UDim2.new(0, 20, 0, 20)
FieldFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 55)
FieldFrame.BorderSizePixel = 0
FieldFrame.Parent = FarmingPage

local FieldLabel = Instance.new("TextLabel")
FieldLabel.Name = "FieldLabel"
FieldLabel.Size = UDim2.new(0.3, 0, 1, 0)
FieldLabel.BackgroundTransparency = 1
FieldLabel.Text = "Field:"
FieldLabel.TextColor3 = Color3.fromRGB(220, 220, 255)
FieldLabel.Font = Enum.Font.GothamSemibold
FieldLabel.TextSize = 16
FieldLabel.TextXAlignment = Enum.TextXAlignment.Left
FieldLabel.Parent = FieldFrame

local UIPadding3 = Instance.new("UIPadding")
UIPadding3.PaddingLeft = UDim.new(0, 10)
UIPadding3.Parent = FieldLabel

local FieldDropdown = Instance.new("TextButton")
FieldDropdown.Name = "FieldDropdown"
FieldDropdown.Size = UDim2.new(0.7, -20, 0.6, 0)
FieldDropdown.Position = UDim2.new(0.3, 10, 0.2, 0)
FieldDropdown.BackgroundColor3 = Color3.fromRGB(60, 60, 65)
FieldDropdown.Text = Settings.TargetField
FieldDropdown.TextColor3 = Color3.fromRGB(255, 255, 255)
FieldDropdown.Font = Enum.Font.Gotham
FieldDropdown.TextSize = 14
FieldDropdown.Parent = FieldFrame

-- Основные функции фарма
local AutofarmFrame = Instance.new("Frame")
AutofarmFrame.Name = "AutofarmFrame"
AutofarmFrame.Size = UDim2.new(1, -40, 0, 150)
AutofarmFrame.Position = UDim2.new(0, 20, 0, 100)
AutofarmFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 55)
AutofarmFrame.BorderSizePixel = 0
AutofarmFrame.Parent = FarmingPage

local AutofarmTitle = Instance.new("TextLabel")
AutofarmTitle.Name = "AutofarmTitle"
AutofarmTitle.Size = UDim2.new(1, 0, 0, 40)
AutofarmTitle.BackgroundTransparency = 1
AutofarmTitle.Text = "Farming"
AutofarmTitle.TextColor3 = Color3.fromRGB(220, 220, 255)
AutofarmTitle.Font = Enum.Font.GothamSemibold
AutofarmTitle.TextSize = 18
AutofarmTitle.TextXAlignment = Enum.TextXAlignment.Left
AutofarmTitle.Parent = AutofarmFrame

local UIPadding4 = Instance.new("UIPadding")
UIPadding4.PaddingLeft = UDim.new(0, 10)
UIPadding4.Parent = AutofarmTitle

-- Autofarm Toggle
local AutofarmToggle = Instance.new("TextButton")
AutofarmToggle.Name = "AutofarmToggle"
AutofarmToggle.Size = UDim2.new(1, -20, 0, 35)
AutofarmToggle.Position = UDim2.new(0, 10, 0, 50)
AutofarmToggle.BackgroundColor3 = Color3.fromRGB(60, 60, 65)
AutofarmToggle.Text = "[ ] Autofarm"
AutofarmToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
AutofarmToggle.Font = Enum.Font.Gotham
AutofarmToggle.TextSize = 14
AutofarmToggle.TextXAlignment = Enum.TextXAlignment.Left
AutofarmToggle.Parent = AutofarmFrame

local UIPadding5 = Instance.new("UIPadding")
UIPadding5.PaddingLeft = UDim.new(0, 10)
UIPadding5.Parent = AutofarmToggle

-- AutoSprinkler Toggle
local AutoSprinklerToggle = Instance.new("TextButton")
AutoSprinklerToggle.Name = "AutoSprinklerToggle"
AutoSprinklerToggle.Size = UDim2.new(1, -20, 0, 35)
AutoSprinklerToggle.Position = UDim2.new(0, 10, 0, 90)
AutoSprinklerToggle.BackgroundColor3 = Color3.fromRGB(60, 60, 65)
AutoSprinklerToggle.Text = "[ ] AutoSprinkler"
AutoSprinklerToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
AutoSprinklerToggle.Font = Enum.Font.Gotham
AutoSprinklerToggle.TextSize = 14
AutoSprinklerToggle.TextXAlignment = Enum.TextXAlignment.Left
AutoSprinklerToggle.Parent = AutofarmFrame

local UIPadding6 = Instance.new("UIPadding")
UIPadding6.PaddingLeft = UDim.new(0, 10)
UIPadding6.Parent = AutoSprinklerToggle

-- AutoDig Toggle
local AutoDigToggle = Instance.new("TextButton")
AutoDigToggle.Name = "AutoDigToggle"
AutoDigToggle.Size = UDim2.new(1, -20, 0, 35)
AutoDigToggle.Position = UDim2.new(0, 10, 0, 130)
AutoDigToggle.BackgroundColor3 = Color3.fromRGB(60, 60, 65)
AutoDigToggle.Text = "[ ] AutoDig"
AutoDigToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
AutoDigToggle.Font = Enum.Font.Gotham
AutoDigToggle.TextSize = 14
AutoDigToggle.TextXAlignment = Enum.TextXAlignment.Left
AutoDigToggle.Parent = AutofarmFrame

local UIPadding7 = Instance.new("UIPadding")
UIPadding7.PaddingLeft = UDim.new(0, 10)
UIPadding7.Parent = AutoDigToggle

-- Movement Settings Frame
local MovementSettingsFrame = Instance.new("Frame")
MovementSettingsFrame.Name = "MovementSettingsFrame"
MovementSettingsFrame.Size = UDim2.new(1, -40, 0, 200)
MovementSettingsFrame.Position = UDim2.new(0, 20, 0, 270)
MovementSettingsFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 55)
MovementSettingsFrame.BorderSizePixel = 0
MovementSettingsFrame.Parent = FarmingPage

local MovementTitle = Instance.new("TextLabel")
MovementTitle.Name = "MovementTitle"
MovementTitle.Size = UDim2.new(1, 0, 0, 40)
MovementTitle.BackgroundTransparency = 1
MovementTitle.Text = "Movement"
MovementTitle.TextColor3 = Color3.fromRGB(220, 220, 255)
MovementTitle.Font = Enum.Font.GothamSemibold
MovementTitle.TextSize = 18
MovementTitle.TextXAlignment = Enum.TextXAlignment.Left
MovementTitle.Parent = MovementSettingsFrame

local UIPadding8 = Instance.new("UIPadding")
UIPadding8.PaddingLeft = UDim.new(0, 10)
UIPadding8.Parent = MovementTitle

-- Use Remotes Toggle
local UseRemotesToggle = Instance.new("TextButton")
UseRemotesToggle.Name = "UseRemotesToggle"
UseRemotesToggle.Size = UDim2.new(1, -20, 0, 35)
UseRemotesToggle.Position = UDim2.new(0, 10, 0, 50)
UseRemotesToggle.BackgroundColor3 = Color3.fromRGB(60, 60, 65)
UseRemotesToggle.Text = "[ ] Use Remotes"
UseRemotesToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
UseRemotesToggle.Font = Enum.Font.Gotham
UseRemotesToggle.TextSize = 14
UseRemotesToggle.TextXAlignment = Enum.TextXAlignment.Left
UseRemotesToggle.Parent = MovementSettingsFrame

local UIPadding9 = Instance.new("UIPadding")
UIPadding9.PaddingLeft = UDim.new(0, 10)
UIPadding9.Parent = UseRemotesToggle

-- Movement Mode
local MovementModeToggle = Instance.new("TextButton")
MovementModeToggle.Name = "MovementModeToggle"
MovementModeToggle.Size = UDim2.new(1, -20, 0, 35)
MovementModeToggle.Position = UDim2.new(0, 10, 0, 90)
MovementModeToggle.BackgroundColor3 = Color3.fromRGB(60, 60, 65)
MovementModeToggle.Text = "[>] Movement: Walk"
MovementModeToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
MovementModeToggle.Font = Enum.Font.Gotham
MovementModeToggle.TextSize = 14
MovementModeToggle.TextXAlignment = Enum.TextXAlignment.Left
MovementModeToggle.Parent = MovementSettingsFrame

local UIPadding10 = Instance.new("UIPadding")
UIPadding10.PaddingLeft = UDim.new(0, 10)
UIPadding10.Parent = MovementModeToggle

-- Copy Discord Button
local CopyDiscordButton = Instance.new("TextButton")
CopyDiscordButton.Name = "CopyDiscordButton"
CopyDiscordButton.Size = UDim2.new(1, -20, 0, 35)
CopyDiscordButton.Position = UDim2.new(0, 10, 0, 130)
CopyDiscordButton.BackgroundColor3 = Color3.fromRGB(80, 80, 200)
CopyDiscordButton.Text = "Copy Discord"
CopyDiscordButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CopyDiscordButton.Font = Enum.Font.Gotham
CopyDiscordButton.TextSize = 14
CopyDiscordButton.Parent = MovementSettingsFrame

-- Дополнительные настройки движения
local AdditionalMovementFrame = Instance.new("Frame")
AdditionalMovementFrame.Name = "AdditionalMovementFrame"
AdditionalMovementFrame.Size = UDim2.new(1, -40, 0, 180)
AdditionalMovementFrame.Position = UDim2.new(0, 20, 0, 490)
AdditionalMovementFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 55)
AdditionalMovementFrame.BorderSizePixel = 0
AdditionalMovementFrame.Parent = FarmingPage

local AdditionalMovementTitle = Instance.new("TextLabel")
AdditionalMovementTitle.Name = "AdditionalMovementTitle"
AdditionalMovementTitle.Size = UDim2.new(1, 0, 0, 40)
AdditionalMovementTitle.BackgroundTransparency = 1
AdditionalMovementTitle.Text = "Movement"
AdditionalMovementTitle.TextColor3 = Color3.fromRGB(220, 220, 255)
AdditionalMovementTitle.Font = Enum.Font.GothamSemibold
AdditionalMovementTitle.TextSize = 18
AdditionalMovementTitle.TextXAlignment = Enum.TextXAlignment.Left
AdditionalMovementTitle.Parent = AdditionalMovementFrame

local UIPadding11 = Instance.new("UIPadding")
UIPadding11.PaddingLeft = UDim.new(0, 10)
UIPadding11.Parent = AdditionalMovementTitle

-- Use Red Cannon Toggle
local UseRedCannonToggle = Instance.new("TextButton")
UseRedCannonToggle.Name = "UseRedCannonToggle"
UseRedCannonToggle.Size = UDim2.new(1, -20, 0, 35)
UseRedCannonToggle.Position = UDim2.new(0, 10, 0, 50)
UseRedCannonToggle.BackgroundColor3 = Color3.fromRGB(60, 60, 65)
UseRedCannonToggle.Text = "[ ] Use Red Cannon"
UseRedCannonToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
UseRedCannonToggle.Font = Enum.Font.Gotham
UseRedCannonToggle.TextSize = 14
UseRedCannonToggle.TextXAlignment = Enum.TextXAlignment.Left
UseRedCannonToggle.Parent = AdditionalMovementFrame

local UIPadding12 = Instance.new("UIPadding")
UIPadding12.PaddingLeft = UDim.new(0, 10)
UIPadding12.Parent = UseRedCannonToggle

-- Use Jump Shortcuts Toggle
local UseJumpShortcutsToggle = Instance.new("TextButton")
UseJumpShortcutsToggle.Name = "UseJumpShortcutsToggle"
UseJumpShortcutsToggle.Size = UDim2.new(1, -20, 0, 35)
UseJumpShortcutsToggle.Position = UDim2.new(0, 10, 0, 90)
UseJumpShortcutsToggle.BackgroundColor3 = Color3.fromRGB(60, 60, 65)
UseJumpShortcutsToggle.Text = "[ ] Use Jump Shortcuts"
UseJumpShortcutsToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
UseJumpShortcutsToggle.Font = Enum.Font.Gotham
UseJumpShortcutsToggle.TextSize = 14
UseJumpShortcutsToggle.TextXAlignment = Enum.TextXAlignment.Left
UseJumpShortcutsToggle.Parent = AdditionalMovementFrame

local UIPadding13 = Instance.new("UIPadding")
UIPadding13.PaddingLeft = UDim.new(0, 10)
UIPadding13.Parent = UseJumpShortcutsToggle

-- Enable Walk Speed Toggle
local EnableWalkSpeedToggle = Instance.new("TextButton")
EnableWalkSpeedToggle.Name = "EnableWalkSpeedToggle"
EnableWalkSpeedToggle.Size = UDim2.new(1, -20, 0, 35)
EnableWalkSpeedToggle.Position = UDim2.new(0, 10, 0, 130)
EnableWalkSpeedToggle.BackgroundColor3 = Color3.fromRGB(60, 60, 65)
EnableWalkSpeedToggle.Text = "[ ] Enable Walk Speed"
EnableWalkSpeedToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
EnableWalkSpeedToggle.Font = Enum.Font.Gotham
EnableWalkSpeedToggle.TextSize = 14
EnableWalkSpeedToggle.TextXAlignment = Enum.TextXAlignment.Left
EnableWalkSpeedToggle.Parent = AdditionalMovementFrame

local UIPadding14 = Instance.new("UIPadding")
UIPadding14.PaddingLeft = UDim.new(0, 10)
UIPadding14.Parent = EnableWalkSpeedToggle

-- Walk Speed Settings
local WalkSpeedFrame = Instance.new("Frame")
WalkSpeedFrame.Name = "WalkSpeedFrame"
WalkSpeedFrame.Size = UDim2.new(1, -40, 0, 120)
WalkSpeedFrame.Position = UDim2.new(0, 20, 0, 690)
WalkSpeedFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 55)
WalkSpeedFrame.BorderSizePixel = 0
WalkSpeedFrame.Parent = FarmingPage

local WalkSpeedTitle = Instance.new("TextLabel")
WalkSpeedTitle.Name = "WalkSpeedTitle"
WalkSpeedTitle.Size = UDim2.new(1, 0, 0, 40)
WalkSpeedTitle.BackgroundTransparency = 1
WalkSpeedTitle.Text = "Walk Speed"
WalkSpeedTitle.TextColor3 = Color3.fromRGB(220, 220, 255)
WalkSpeedTitle.Font = Enum.Font.GothamSemibold
WalkSpeedTitle.TextSize = 18
WalkSpeedTitle.TextXAlignment = Enum.TextXAlignment.Left
WalkSpeedTitle.Parent = WalkSpeedFrame

local UIPadding15 = Instance.new("UIPadding")
UIPadding15.PaddingLeft = UDim.new(0, 10)
UIPadding15.Parent = WalkSpeedTitle

local WalkSpeedWarning = Instance.new("TextLabel")
WalkSpeedWarning.Name = "WalkSpeedWarning"
WalkSpeedWarning.Size = UDim2.new(1, -20, 0, 40)
WalkSpeedWarning.Position = UDim2.new(0, 10, 0, 50)
WalkSpeedWarning.BackgroundTransparency = 1
WalkSpeedWarning.Text = "Speeds above 70 and 8 are not recommended"
WalkSpeedWarning.TextColor3 = Color3.fromRGB(255, 100, 100)
WalkSpeedWarning.Font = Enum.Font.Gotham
WalkSpeedWarning.TextSize = 12
WalkSpeedWarning.TextWrapped = true
WalkSpeedWarning.Parent = WalkSpeedFrame

local DynamicWalkSpeedToggle = Instance.new("TextButton")
DynamicWalkSpeedToggle.Name = "DynamicWalkSpeedToggle"
DynamicWalkSpeedToggle.Size = UDim2.new(1, -20, 0, 35)
DynamicWalkSpeedToggle.Position = UDim2.new(0, 10, 0, 90)
DynamicWalkSpeedToggle.BackgroundColor3 = Color3.fromRGB(60, 60, 65)
DynamicWalkSpeedToggle.Text = "[ ] Dynamic Walk Speed"
DynamicWalkSpeedToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
DynamicWalkSpeedToggle.Font = Enum.Font.Gotham
DynamicWalkSpeedToggle.TextSize = 14
DynamicWalkSpeedToggle.TextXAlignment = Enum.TextXAlignment.Left
DynamicWalkSpeedToggle.Parent = WalkSpeedFrame

local UIPadding16 = Instance.new("UIPadding")
UIPadding16.PaddingLeft = UDim.new(0, 10)
UIPadding16.Parent = DynamicWalkSpeedToggle

-- Создание остальных страниц (упрощенно)
local function CreatePage(name)
    local page = Instance.new("ScrollingFrame")
    page.Name = name .. "Page"
    page.Size = UDim2.new(1, 0, 1, 0)
    page.BackgroundTransparency = 1
    page.BorderSizePixel = 0
    page.ScrollBarThickness = 6
    page.ScrollBarImageColor3 = Color3.fromRGB(80, 80, 90)
    page.CanvasSize = UDim2.new(0, 0, 0, 600)
    page.Visible = false
    page.Parent = ContentPanel
    
    local title = Instance.new("TextLabel")
    title.Name = name .. "Title"
    title.Size = UDim2.new(1, -40, 0, 40)
    title.Position = UDim2.new(0, 20, 0, 20)
    title.BackgroundTransparency = 1
    title.Text = name
    title.TextColor3 = Color3.fromRGB(220, 220, 255)
    title.Font = Enum.Font.GothamSemibold
    title.TextSize = 22
    title.Parent = page
    
    return page
end

-- Создаем остальные страницы
local CombatPage = CreatePage("Combat")
local QuestsPage = CreatePage("Quests")
local PlantersPage = CreatePage("Planters")
local ToysPage = CreatePage("Toys")
local RBCPage = CreatePage("RBC")
local WebhookPage = CreatePage("Webhook")
local ConfigPage = CreatePage("Config")
local DebugPage = CreatePage("Debug")

-- Логика переключения страниц
local function SwitchPage(pageName)
    -- Скрываем все страницы
    HomePage.Visible = false
    FarmingPage.Visible = false
    CombatPage.Visible = false
    QuestsPage.Visible = false
    PlantersPage.Visible = false
    ToysPage.Visible = false
    RBCPage.Visible = false
    WebhookPage.Visible = false
    ConfigPage.Visible = false
    DebugPage.Visible = false
    
    -- Сбрасываем цвета всех кнопок
    for _, button in pairs(MenuButtonInstances) do
        button.BackgroundColor3 = Color3.fromRGB(50, 50, 55)
        button.TextColor3 = Color3.fromRGB(200, 200, 200)
    end
    
    -- Показываем нужную страницу
    if pageName == "Home" then
        HomePage.Visible = true
        MenuButtonInstances["Home"].BackgroundColor3 = Color3.fromRGB(80, 80, 200)
        MenuButtonInstances["Home"].TextColor3 = Color3.fromRGB(255, 255, 255)
    elseif pageName == "Farming" then
        FarmingPage.Visible = true
        MenuButtonInstances["Farming"].BackgroundColor3 = Color3.fromRGB(80, 80, 200)
        MenuButtonInstances["Farming"].TextColor3 = Color3.fromRGB(255, 255, 255)
    elseif pageName == "Combat" then
        CombatPage.Visible = true
        MenuButtonInstances["Combat"].BackgroundColor3 = Color3.fromRGB(80, 80, 200)
        MenuButtonInstances["Combat"].TextColor3 = Color3.fromRGB(255, 255, 255)
    elseif pageName == "Quests" then
        QuestsPage.Visible = true
        MenuButtonInstances["Quests"].BackgroundColor3 = Color3.fromRGB(80, 80, 200)
        MenuButtonInstances["Quests"].TextColor3 = Color3.fromRGB(255, 255, 255)
    elseif pageName == "Planters" then
        PlantersPage.Visible = true
        MenuButtonInstances["Planters"].BackgroundColor3 = Color3.fromRGB(80, 80, 200)
        MenuButtonInstances["Planters"].TextColor3 = Color3.fromRGB(255, 255, 255)
    elseif pageName == "Toys" then
        ToysPage.Visible = true
        MenuButtonInstances["Toys"].BackgroundColor3 = Color3.fromRGB(80, 80, 200)
        MenuButtonInstances["Toys"].TextColor3 = Color3.fromRGB(255, 255, 255)
    elseif pageName == "RBC" then
        RBCPage.Visible = true
        MenuButtonInstances["RBC"].BackgroundColor3 = Color3.fromRGB(80, 80, 200)
        MenuButtonInstances["RBC"].TextColor3 = Color3.fromRGB(255, 255, 255)
    elseif pageName == "Webhook" then
        WebhookPage.Visible = true
        MenuButtonInstances["Webhook"].BackgroundColor3 = Color3.fromRGB(80, 80, 200)
        MenuButtonInstances["Webhook"].TextColor3 = Color3.fromRGB(255, 255, 255)
    elseif pageName == "Config" then
        ConfigPage.Visible = true
        MenuButtonInstances["Config"].BackgroundColor3 = Color3.fromRGB(80, 80, 200)
        MenuButtonInstances["Config"].TextColor3 = Color3.fromRGB(255, 255, 255)
    elseif pageName == "Debug" then
        DebugPage.Visible = true
        MenuButtonInstances["Debug"].BackgroundColor3 = Color3.fromRGB(80, 80, 200)
        MenuButtonInstances["Debug"].TextColor3 = Color3.fromRGB(255, 255, 255)
    end
    
    CurrentPage = pageName
end

-- Подключение кнопок меню
for name, button in pairs(MenuButtonInstances) do
    button.MouseButton1Click:Connect(function()
        SwitchPage(name)
    end)
end

-- Функции тогглов
local function UpdateToggle(button, value)
    button.Text = (value and "[✓]" or "[ ]") .. button.Text:sub(4)
end

-- Autofarm логика
AutofarmToggle.MouseButton1Click:Connect(function()
    Settings.AutoFarm = not Settings.AutoFarm
    UpdateToggle(AutofarmToggle, Settings.AutoFarm)
    AutofarmToggle.BackgroundColor3 = Settings.AutoFarm and Color3.fromRGB(80, 80, 200) or Color3.fromRGB(60, 60, 65)
    
    if Settings.AutoFarm then
        StartAutoFarm()
    else
        StopAutoFarm()
    end
end)

AutoSprinklerToggle.MouseButton1Click:Connect(function()
    Settings.AutoSprinkler = not Settings.AutoSprinkler
    UpdateToggle(AutoSprinklerToggle, Settings.AutoSprinkler)
    AutoSprinklerToggle.BackgroundColor3 = Settings.AutoSprinkler and Color3.fromRGB(80, 80, 200) or Color3.fromRGB(60, 60, 65)
    
    if Settings.AutoSprinkler then
        StartAutoSprinkler()
    else
        StopAutoSprinkler()
    end
end)

AutoDigToggle.MouseButton1Click:Connect(function()
    Settings.AutoDig = not Settings.AutoDig
    UpdateToggle(AutoDigToggle, Settings.AutoDig)
    AutoDigToggle.BackgroundColor3 = Settings.AutoDig and Color3.fromRGB(80, 80, 200) or Color3.fromRGB(60, 60, 65)
    
    if Settings.AutoDig then
        StartAutoDig()
    else
        StopAutoDig()
    end
end)

-- Настройки движения
UseRemotesToggle.MouseButton1Click:Connect(function()
    Settings.UseRemotes = not Settings.UseRemotes
    UpdateToggle(UseRemotesToggle, Settings.UseRemotes)
    UseRemotesToggle.BackgroundColor3 = Settings.UseRemotes and Color3.fromRGB(80, 80, 200) or Color3.fromRGB(60, 60, 65)
end)

MovementModeToggle.MouseButton1Click:Connect(function()
    if Settings.MovementMode == "Walk" then
        Settings.MovementMode = "Tween"
    else
        Settings.MovementMode = "Walk"
    end
    MovementModeToggle.Text = "[>] Movement: " .. Settings.MovementMode
end)

CopyDiscordButton.MouseButton1Click:Connect(function()
    -- Копирование Discord ссылки в буфер обмена
    if setclipboard then
        setclipboard("https://discord.gg/astra")
        CopyDiscordButton.Text = "Copied!"
        task.wait(1)
        CopyDiscordButton.Text = "Copy Discord"
    end
end)

-- Дополнительные настройки движения
UseRedCannonToggle.MouseButton1Click:Connect(function()
    Settings.UseRedCannon = not Settings.UseRedCannon
    UpdateToggle(UseRedCannonToggle, Settings.UseRedCannon)
    UseRedCannonToggle.BackgroundColor3 = Settings.UseRedCannon and Color3.fromRGB(80, 80, 200) or Color3.fromRGB(60, 60, 65)
end)

UseJumpShortcutsToggle.MouseButton1Click:Connect(function()
    Settings.UseJumpShortcuts = not Settings.UseJumpShortcuts
    UpdateToggle(UseJumpShortcutsToggle, Settings.UseJumpShortcuts)
    UseJumpShortcutsToggle.BackgroundColor3 = Settings.UseJumpShortcuts and Color3.fromRGB(80, 80, 200) or Color3.fromRGB(60, 60, 65)
end)

EnableWalkSpeedToggle.MouseButton1Click:Connect(function()
    Settings.EnableWalkSpeed = not Settings.EnableWalkSpeed
    UpdateToggle(EnableWalkSpeedToggle, Settings.EnableWalkSpeed)
    EnableWalkSpeedToggle.BackgroundColor3 = Settings.EnableWalkSpeed and Color3.fromRGB(80, 80, 200) or Color3.fromRGB(60, 60, 65)
    
    if Settings.EnableWalkSpeed then
        Player.Character.Humanoid.WalkSpeed = Settings.WalkSpeed
    else
        Player.Character.Humanoid.WalkSpeed = 16
    end
end)

DynamicWalkSpeedToggle.MouseButton1Click:Connect(function()
    Settings.DynamicWalkSpeed = not Settings.DynamicWalkSpeed
    UpdateToggle(DynamicWalkSpeedToggle, Settings.DynamicWalkSpeed)
    DynamicWalkSpeedToggle.BackgroundColor3 = Settings.DynamicWalkSpeed and Color3.fromRGB(80, 80, 200) or Color3.fromRGB(60, 60, 65)
end)

-- Выбор поля
FieldDropdown.MouseButton1Click:Connect(function()
    local fields = {"Sunflower Field", "Dandelion Field", "Sunflower Field", "Mushroom Field", "Blue Flower Field", "Clover Field", "Spider Field", "Strawberry Field", "Bamboo Field", "Pineapple Patch", "Stump Field", "Cactus Field", "Pumpkin Patch", "Pine Tree Forest", "Rose Field", "Mountain Top Field", "Coconut Field", "Pepper Patch"}
    local currentIndex = table.find(fields, Settings.TargetField) or 1
    local nextIndex = currentIndex % #fields + 1
    Settings.TargetField = fields[nextIndex]
    FieldDropdown.Text = Settings.TargetField
end)

-- Stop Everything Button
StopEverythingButton.MouseButton1Click:Connect(function()
    Settings.AutoFarm = false
    Settings.AutoSprinkler = false
    Settings.AutoDig = false
    
    UpdateToggle(AutofarmToggle, false)
    UpdateToggle(AutoSprinklerToggle, false)
    UpdateToggle(AutoDigToggle, false)
    
    AutofarmToggle.BackgroundColor3 = Color3.fromRGB(60, 60, 65)
    AutoSprinklerToggle.BackgroundColor3 = Color3.fromRGB(60, 60, 65)
    AutoDigToggle.BackgroundColor3 = Color3.fromRGB(60, 60, 65)
    
    StopAutoFarm()
    StopAutoSprinkler()
    StopAutoDig()
    
    StopEverythingButton.Text = "Stopped!"
    task.wait(1)
    StopEverythingButton.Text = "Stop Everything"
end)

-- Системные функции
local AutoFarmCoroutine
local AutoSprinklerCoroutine
local AutoDigCoroutine

function StartAutoFarm()
    if AutoFarmCoroutine then
        coroutine.close(AutoFarmCoroutine)
    end
    
    AutoFarmCoroutine = coroutine.create(function()
        while Settings.AutoFarm do
            -- Логика автоматического фарма
            if Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
                -- Симуляция сбора меда
                SessionHoney = SessionHoney + math.random(10, 50)
                TotalHoney = TotalHoney + math.random(10, 50)
                table.insert(HoneyHistory, {time = os.time(), amount = SessionHoney})
                
                -- Обновление показателя в секунду
                if #HoneyHistory > 10 then
                    local last10 = HoneyHistory[#HoneyHistory].amount - HoneyHistory[#HoneyHistory-10].amount
                    HoneyPerSecLabel.Text = "(+" .. math.floor(last10/10) .. "/sec)"
                    HoneyPerSecLabel.Visible = true
                end
                
                -- Обновление емкости
                local current = math.random(40, 200)
                CapacityLabel.Text = current .. "/200"
            end
            task.wait(1)
        end
    end)
    coroutine.resume(AutoFarmCoroutine)
end

function StopAutoFarm()
    if AutoFarmCoroutine then
        coroutine.close(AutoFarmCoroutine)
        AutoFarmCoroutine = nil
    end
end

function StartAutoSprinkler()
    if AutoSprinklerCoroutine then
        coroutine.close(AutoSprinklerCoroutine)
    end
    
    AutoSprinklerCoroutine = coroutine.create(function()
        while Settings.AutoSprinkler do
            -- Логика автоматической установки спринклеров
            task.wait(5)
        end
    end)
    coroutine.resume(AutoSprinklerCoroutine)
end

function StopAutoSprinkler()
    if AutoSprinklerCoroutine then
        coroutine.close(AutoSprinklerCoroutine)
        AutoSprinklerCoroutine = nil
    end
end

function StartAutoDig()
    if AutoDigCoroutine then
        coroutine.close(AutoDigCoroutine)
    end
    
    AutoDigCoroutine = coroutine.create(function()
        while Settings.AutoDig do
            -- Логика автоматического копания
            task.wait(2)
        end
    end)
    coroutine.resume(AutoDigCoroutine)
end

function StopAutoDig()
    if AutoDigCoroutine then
        coroutine.close(AutoDigCoroutine)
        AutoDigCoroutine = nil
    end
end

-- Обновление статистики
coroutine.wrap(function()
    while true do
        -- Uptime
        local uptime = os.time() - SessionStart
        local hours = math.floor(uptime / 3600)
        local minutes = math.floor((uptime % 3600) / 60)
        local seconds = uptime % 60
        UptimeLabel.Text = string.format("Uptime: %02d:%02d:%02d", hours, minutes, seconds)
        
        -- Server Uptime
        local serverUptime = os.time() - ServerStartTime
        local sHours = math.floor(serverUptime / 3600)
        local sMinutes = math.floor((serverUptime % 3600) / 60)
        local sSeconds = serverUptime % 60
        ServerUptimeLabel.Text = string.format("Server Uptime: %02d:%02d:%02d", sHours, sMinutes, sSeconds)
        
        -- Honey Stats
        SessionHoneyLabel.Text = "Session Honey: " .. SessionHoney
        
        -- Calculate Honey per Hour
        if #HoneyHistory >= 2 then
            local timeDiff = os.time() - HoneyHistory[1].time
            if timeDiff > 0 then
                local honeyPerSecond = SessionHoney / timeDiff
                local honeyPerHour = math.floor(honeyPerSecond * 3600)
                HoneyPerHourLabel.Text = "Honey per Hour: " .. honeyPerHour
            end
        end
        
        task.wait(1)
    end
end)()

-- Q Search Button
QSearchButton.MouseButton1Click:Connect(function()
    -- Функция поиска квеста
    QSearchButton.Text = "Searching..."
    QSearchButton.BackgroundColor3 = Color3.fromRGB(80, 80, 200)
    task.wait(1)
    QSearchButton.Text = "Q Search"
    QSearchButton.BackgroundColor3 = Color3.fromRGB(50, 50, 55)
end)

-- Начальная настройка
UpdateToggle(AutofarmToggle, Settings.AutoFarm)
UpdateToggle(AutoSprinklerToggle, Settings.AutoSprinkler)
UpdateToggle(AutoDigToggle, Settings.AutoDig)
UpdateToggle(UseRemotesToggle, Settings.UseRemotes)
UpdateToggle(UseRedCannonToggle, Settings.UseRedCannon)
UpdateToggle(UseJumpShortcutsToggle, Settings.UseJumpShortcuts)
UpdateToggle(EnableWalkSpeedToggle, Settings.EnableWalkSpeed)
UpdateToggle(DynamicWalkSpeedToggle, Settings.DynamicWalkSpeed)

SwitchPage("Home")

print("Astra v1.0 loaded successfully!")
print("Discord: https://discord.gg/astra")
