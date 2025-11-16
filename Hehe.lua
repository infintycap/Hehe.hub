-- Hehe Hub by Miggysalad - Easily Toggle Features with GUI

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- Helper functions
local function notify(msg)
game.StarterGui:SetCore("SendNotification", {
Title = "Hehe Hub",
Text = msg,
Duration = 6
})
end

-- Main Frame
local gui = Instance.new("ScreenGui")
gui.IgnoreGuiInset = true
gui.Name = "HeheHub"
gui.Parent = LocalPlayer and LocalPlayer:FindFirstChild("PlayerGui") or game:GetService("StarterGui")

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0,340,0,430)
frame.Position = UDim2.new(0.05,0,0.3,0)
frame.BackgroundColor3 = Color3.fromRGB(40,40,72)
frame.Parent = gui
local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0,14)
corner.Parent = frame

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1,0,0,40)
title.BackgroundTransparency = 1
title.Text = "Hehe Hub"
title.Font = Enum.Font.GothamBold
title.TextSize = 32
title.TextColor3 = Color3.fromRGB(155,255,255)
title.Parent = frame

-- GUI Button Helper
local function addBtn(txt, ypos, callback)
local b = Instance.new("TextButton")
b.Size = UDim2.new(0.86,0,0,40)
b.Position = UDim2.new(0.07,0,0,ypos)
b.Text = txt
b.Font = Enum.Font.GothamBold
b.TextSize = 18
b.BackgroundColor3 = Color3.fromRGB(120,180,255)
b.TextColor3 = Color3.fromRGB(28,38,56)
local c = Instance.new("UICorner")
c.CornerRadius = UDim.new(0,10)
c.Parent = b
b.Parent = frame
b.MouseButton1Click:Connect(callback)
return b
end

-- ========== Feature Toggles ==========
local espEnabled, baseEspEnabled, bestEspEnabled, infiniteJump, speedEnabled, godmode, autoCollect = false, false, false, false, false, false, false

-- 1. ESP (players)
local function enableESP()
for _,p in pairs(Players:GetPlayers()) do
if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") and not p.Character.HumanoidRootPart:FindFirstChild("HeheTag") then
local tag = Instance.new("BillboardGui")
tag.Name = "HeheTag"
tag.Size = UDim2.new(0,100,0,32)
tag.AlwaysOnTop = true
tag.Adornee = p.Character.HumanoidRootPart
local text = Instance.new("TextLabel", tag)
text.Size = UDim2.new(1,0,1,0)
text.BackgroundTransparency = 1
text.Text = p.DisplayName or p.Name
text.Font = Enum.Font.GothamBold
text.TextSize = 17
text.TextColor3 = Color3.fromRGB(70,206,130)
tag.Parent = p.Character.HumanoidRootPart
end
end
end
local function disableESP()
for _,p in pairs(Players:GetPlayers()) do
if p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
local tag = p.Character.HumanoidRootPart:FindFirstChild("HeheTag")
if tag then tag:Destroy() end
end
end
end

-- 2. Base ESP
local function enableBaseESP()
for _,v in pairs(workspace:GetChildren()) do
if v:IsA("Model") and v.Name:lower():find("base") and v:FindFirstChildWhichIsA("BasePart") and not v:FindFirstChild("HeheBaseTag") then
local bill = Instance.new("BillboardGui")
bill.Name = "HeheBaseTag"
bill.Size = UDim2.new(0,120,0,36)
bill.AlwaysOnTop = true
bill.Adornee = v:FindFirstChildWhichIsA("BasePart")
local txt = Instance.new("TextLabel", bill)
txt.Size = UDim2.new(1,0,1,0)
txt.BackgroundTransparency = 1
txt.Text = "BASE: "..v.Name
txt.Font = Enum.Font.GothamBold
txt.TextSize = 15
txt.TextColor3 = Color3.fromRGB(255,200,0)
bill.Parent = v
end
end
end
local function disableBaseESP()
for _,v in pairs(workspace:GetChildren()) do
if v:IsA("Model") and v:FindFirstChild("HeheBaseTag") then
v.HeheBaseTag:Destroy()
end
end
end

-- 3. Best Brainrot ESP (highest value base)
local function enableBestBrainrotESP()
local highestValue, bestBase = 0, nil
for _,v in pairs(workspace:GetChildren()) do
if v:IsA("Model") and v.Name:lower():find("base") then
local val = v:FindFirstChild("Value") or v:FindFirstChildWhichIsA("NumberValue") or v:FindFirstChildWhichIsA("IntValue")
if val and val.Value > highestValue then
highestValue = val.Value
bestBase = v
end
end
end
-- Remove old ESP
for _,v in pairs(workspace:GetChildren()) do
if v:IsA("Model") and v:FindFirstChild("HeheBestBrainrotTag") then
v.HeheBestBrainrotTag:Destroy()
end
end
if bestBase and bestBase:FindFirstChildWhichIsA("BasePart") then
local bill = Instance.new("BillboardGui")
bill.Name = "HeheBestBrainrotTag"
bill.Size = UDim2.new(0,170,0,40)
bill.AlwaysOnTop = true
bill.Adornee = bestBase:FindFirstChildWhichIsA("BasePart")
local txt = Instance.new("TextLabel", bill)
txt.Size = UDim2.new(1,0,1,0)
txt.BackgroundTransparency = 1
txt.Text = "HIGHEST VALUE BASE\nValue: "..highestValue
txt.Font = Enum.Font.GothamBold
txt.TextSize = 15
txt.TextColor3 = Color3.fromRGB(255,70,70)
bill.Parent = bestBase
end
end
local function disableBestBrainrotESP()
for _,v in pairs(workspace:GetChildren()) do
if v:IsA("Model") and v:FindFirstChild("HeheBestBrainrotTag") then
v.HeheBestBrainrotTag:Destroy()
end
end
end

-- 4. Infinite Jump
game:GetService("UserInputService").JumpRequest:Connect(function()
if infiniteJump and LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping")
end
end)

-- 5. Speed Hack
local defaultSpeed, fastSpeed = 16, 45
local function updateSpeed()
local h = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
if h then h.WalkSpeed = speedEnabled and fastSpeed or defaultSpeed end
end
LocalPlayer.CharacterAdded:Connect(updateSpeed)

-- 6. Godmode (simple)
local function updateGodmode()
local h = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
if h then
h.MaxHealth = godmode and math.huge or 100
h.Health = godmode and math.huge or h.MaxHealth
end
end
LocalPlayer.CharacterAdded:Connect(updateGodmode)

-- 7. Auto Collect (money)
local function doAutoCollect()
if autoCollect and LocalPlayer.Character then
for _,drop in pairs(workspace:GetChildren()) do
if drop:IsA("Part") and drop.Name == "Money" then
drop.CFrame = LocalPlayer.Character.HumanoidRootPart.CFrame
end
end
end
end

-- 8. Anti AFK (always on)
pcall(function()
game:GetService("VirtualUser").Touched:Connect(function()
game:GetService("VirtualUser"):ClickButton1(Vector2.new())
end)
end)

-- === GUI Buttons ===
addBtn("Enable Player ESP", 52, function()
espEnabled = true
enableESP()
notify("Player ESP Enabled!")
end)
addBtn("Disable Player ESP", 100, function()
espEnabled = false
disableESP()
notify("Player ESP Disabled!")
end)
addBtn("Enable Base ESP", 148, function()
baseEspEnabled = true
enableBaseESP()
notify("Base ESP Enabled!")
end)
addBtn("Disable Base ESP", 196, function()
baseEspEnabled = false
disableBaseESP()
notify("Base ESP Disabled!")
end)
addBtn("Enable Best Brainrot ESP", 244, function()
bestEspEnabled = true
enableBestBrainrotESP()
notify("Best Brainrot ESP Enabled!")
end)
addBtn("Disable Best Brainrot ESP", 292, function()
bestEspEnabled = false
disableBestBrainrotESP()
notify("Best Brainrot ESP Disabled!")
end)
addBtn("Toggle Infinite Jump", 340, function()
infiniteJump = not infiniteJump
notify("Infinite Jump "..(infiniteJump and "Enabled!" or "Disabled!"))
end)
addBtn("Toggle Speed Hack", 388, function()
speedEnabled = not speedEnabled
updateSpeed()
notify("Speed Hack "..(speedEnabled and "Enabled!" or "Disabled!"))
end)
addBtn("Toggle Godmode", 436, function()
godmode = not godmode
updateGodmode()
notify("Godmode "..(godmode and "Enabled!" or "Disabled!"))
end)

-- For auto collect, run in background while enabled!
spawn(function()
while true do
if autoCollect then
doAutoCollect()
end
wait(0.6)
end
end)
addBtn("Toggle Auto Collect", 484, function()
autoCollect = not autoCollect
notify("Auto Collect "..(autoCollect and "Enabled!" or "Disabled!"))
end)

notify("Hehe Hub Loaded! Use the GUI to enable features.")

-- Optional: Drag UI support for Delta
local dragging, dragInput, dragStart, startPos
frame.InputBegan:Connect(function(input)
if input.UserInputType == Enum.UserInputType.MouseButton1 then
dragging = true
dragStart = input.Position
startPos = frame.Position
input.Changed:Connect(function()
if input.UserInputState == Enum.UserInputState.End then
dragging = false
end
end)
end
end)
frame.InputChanged:Connect(function(input)
if dragging then
if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
local delta = input.Position - dragStart
frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end
end
end)
