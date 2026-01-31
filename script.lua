-- Bee Swarm Simulator UI Script
-- LocalScript / Executor

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()

-- ===== SESSION DATA =====
local startTime = tick()
local startHoney = player.leaderstats.Honey.Value

-- ===== GUI =====
local gui = Instance.new("ScreenGui", player.PlayerGui)
gui.Name = "BeeSwarmUI"

-- Open Button
local openBtn = Instance.new("TextButton", gui)
openBtn.Size = UDim2.fromOffset(120, 40)
openBtn.Position = UDim2.fromOffset(50, 200)
openBtn.Text = "Open"
openBtn.BackgroundColor3 = Color3.fromRGB(255, 200, 0)
openBtn.Draggable = true
openBtn.Active = true

-- Main Frame
local main = Instance.new("Frame", gui)
main.Size = UDim2.fromOffset(400, 300)
main.Position = UDim2.fromScale(0.5, 0.5)
main.AnchorPoint = Vector2.new(0.5, 0.5)
main.Visible = false
main.BackgroundColor3 = Color3.fromRGB(30, 30, 30)

openBtn.MouseButton1Click:Connect(function()
	main.Visible = not main.Visible
end)

-- ===== TABS =====
local tabs = {"Info", "Farm", "Settings"}
local pages = {}

for i, name in ipairs(tabs) do
	local btn = Instance.new("TextButton", main)
	btn.Text = name
	btn.Size = UDim2.new(1/#tabs, 0, 0, 30)
	btn.Position = UDim2.new((i-1)/#tabs, 0, 0, 0)

	local page = Instance.new("Frame", main)
	page.Size = UDim2.new(1, 0, 1, -30)
	page.Position = UDim2.fromOffset(0, 30)
	page.Visible = false
	pages[name] = page

	btn.MouseButton1Click:Connect(function()
		for _, p in pairs(pages) do p.Visible = false end
		page.Visible = true
	end)
end

pages.Info.Visible = true

-- ===== INFO =====
local infoLabel = Instance.new("TextLabel", pages.Info)
infoLabel.Size = UDim2.new(1, -20, 1, -20)
infoLabel.Position = UDim2.fromOffset(10, 10)
infoLabel.TextWrapped = true
infoLabel.TextYAlignment = Top
infoLabel.TextColor3 = Color3.new(1,1,1)
infoLabel.BackgroundTransparency = 1

RunService.RenderStepped:Connect(function()
	local elapsed = tick() - startTime
	local currentHoney = player.leaderstats.Honey.Value
	local gained = currentHoney - startHoney
	local perHour = elapsed > 0 and math.floor(gained / elapsed * 3600) or 0

	infoLabel.Text =
		"Session Time: " .. math.floor(elapsed) .. " sec\n" ..
		"Honey Gained: " .. gained .. "\n" ..
		"Honey / Hour: " .. perHour
end)

-- ===== FARM =====
local autoFarm = false
local autoDig = false
local autoSprinkler = false
local selectedField = "None"

local function toggle(text, y, callback)
	local btn = Instance.new("TextButton", pages.Farm)
	btn.Size = UDim2.fromOffset(200, 30)
	btn.Position = UDim2.fromOffset(10, y)
	btn.Text = text .. ": OFF"

	btn.MouseButton1Click:Connect(function()
		callback(btn)
	end)
end

toggle("AutoFarm", 10, function(btn)
	autoFarm = not autoFarm
	btn.Text = "AutoFarm: " .. (autoFarm and "ON" or "OFF")
end)

toggle("AutoDig", 50, function(btn)
	autoDig = not autoDig
	btn.Text = "AutoDig: " .. (autoDig and "ON" or "OFF")
end)

toggle("AutoSprinkler", 90, function(btn)
	autoSprinkler = not autoSprinkler
	btn.Text = "AutoSprinkler: " .. (autoSprinkler and "ON" or "OFF")
end)

-- ===== SETTINGS =====
local movementMode = "Tween"
local speedHack = false

local moveBtn = Instance.new("TextButton", pages.Settings)
moveBtn.Size = UDim2.fromOffset(200, 30)
moveBtn.Position = UDim2.fromOffset(10, 10)
moveBtn.Text = "Movement: Tween"

moveBtn.MouseButton1Click:Connect(function()
	movementMode = movementMode == "Tween" and "Walk" or "Tween"
	moveBtn.Text = "Movement: " .. movementMode
end)

local speedBtn = Instance.new("TextButton", pages.Settings)
speedBtn.Size = UDim2.fromOffset(200, 30)
speedBtn.Position = UDim2.fromOffset(10, 50)
speedBtn.Text = "SpeedHack: OFF"

speedBtn.MouseButton1Click:Connect(function()
	if movementMode == "Walk" then
		speedHack = not speedHack
		speedBtn.Text = "SpeedHack: " .. (speedHack and "ON" or "OFF")
	end
end)

-- ===== AUTO DIG =====
task.spawn(function()
	while task.wait(0.2) do
		if autoDig then
			game:GetService("VirtualUser"):Button1Down(Vector2.new(), workspace.CurrentCamera.CFrame)
			task.wait(0.05)
			game:GetService("VirtualUser"):Button1Up(Vector2.new(), workspace.CurrentCamera.CFrame)
		end
	end
end)

-- ===== AUTO SPRINKLER =====
task.spawn(function()
	while task.wait(5) do
		if autoSprinkler then
			for _, tool in pairs(player.Backpack:GetChildren()) do
				if tool.Name:lower():find("sprinkler") then
					tool.Parent = character
					tool:Activate()
					break
				end
			end
		end
	end
end)
