-- Hehe Hub by Miggysalad
-- GUI: Draggable, Toggle Show/Hide, Proper Base ESP

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer or Players:GetPropertyChangedSignal("LocalPlayer"):Wait() or Players.LocalPlayer

-- GUI parent handling for Delta/mobile & desktop
local function getGuiParent()
return (LocalPlayer:FindFirstChild("PlayerGui") or game:GetService("StarterGui"))
end

local gui = Instance.new("ScreenGui")
gui.Name = "HeheHub"
gui.IgnoreGuiInset = true
gui.ResetOnSpawn = false
gui.Parent = getGuiParent()

-- === Toggle Button ===
local toggleBtn = Instance.new("TextButton")
toggleBtn.Size = UDim2.new(0,44,0,44)
toggleBtn.Position = UDim2.new(0,8,0,70)
toggleBtn.BackgroundColor3 = Color3.fromRGB(49,61,99)
toggleBtn.Text = "≡"
toggleBtn.Font = Enum.Font.GothamBold
toggleBtn.TextColor3 = Color3.fromRGB(180,220,255)
toggleBtn.TextSize = 32
toggleBtn.Visible = true
local tbtnCorner = Instance.new("UICorner")
tbtnCorner.CornerRadius = UDim.new(0,12)
tbtnCorner.Parent = toggleBtn
toggleBtn.Parent = gui

-- === Main Menu Frame ===
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0,340,0,460)
frame.Position = UDim2.new(0.08,0,0.23,0)
frame.BackgroundColor3 = Color3.fromRGB(40,40,72)
frame.Visible = false
frame.Active = true
local fcorner = Instance.new("UICorner")
fcorner.CornerRadius = UDim.new(0,14)
fcorner.Parent = frame
frame.Parent = gui

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1,0,0,38)
title.BackgroundTransparency = 1
title.Text = "Hehe Hub"
title.Font = Enum.Font.GothamBold
title.TextSize = 32
title.TextColor3 = Color3.fromRGB(155,255,255)
title.Parent = frame

-- === Draggable support ===
local dragging, dragStart, startPos
frame.InputBegan:Connect(function(input)
if input.UserInputType==Enum.UserInputType.MouseButton1 then
dragging = true
dragStart = input.Position
startPos = frame.Position
input.Changed:Connect(function()
if input.UserInputState==Enum.UserInputState.End then
dragging = false
end
end)
end
end)
frame.InputChanged:Connect(function(input)
if dragging then
if input.UserInputType==Enum.UserInputType.MouseMovement or input.UserInputType==Enum.UserInputType.Touch then
local delta = input.Position - dragStart
frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset+delta.X, startPos.Y.Scale, startPos.Y.Offset+delta.Y)
end
end
end)

-- === Show/Hide Toggle ===
toggleBtn.MouseButton1Click:Connect(function()
frame.Visible = not frame.Visible
end)
-- Optional: RightShift toggles menu as well.
game:GetService("UserInputService").InputBegan:Connect(function(input, processed)
if not processed and input.KeyCode == Enum.KeyCode.RightShift then
frame.Visible = not frame.Visible
end
end)

local function notify(msg)
pcall(function()
game.StarterGui:SetCore("SendNotification", {
Title = "Hehe Hub",
Text = msg,
Duration = 6
})
end)
end

-- === Buttons Helper ===
local btnY = 44
local function addBtn(txt, callback)
local b = Instance.new("TextButton")
b.Size = UDim2.new(0.85,0,0,40)
b.Position = UDim2.new(0.07,0,0,btnY)
btnY = btnY + 48
b.Text = txt
b.Font = Enum.Font.GothamBold
b.TextSize = 18
b.BackgroundColor3 = Color3.fromRGB(120,180,255)
b.TextColor3 = Color3.fromRGB(28,38,56)
local c = Instance.new("UICorner")
c.CornerRadius = UDim.new(0,11)
c.Parent = b
b.Parent = frame
b.MouseButton1Click:Connect(callback)
return b
end

-- === Features ===
local espEnabled, baseEspEnabled, bestEspEnabled = false, false, false
local infiniteJump, speedEnabled, godmode, autoCollect = false, false, false, false

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

-- 2. Base ESP -- improved (looks for models named 'base' or containing 'base', highlights all parts with a Billboard)
local function enableBaseESP()
for _,v in pairs(workspace:GetChildren()) do
if v:IsA("Model") and (v.Name:lower():find("base") or v.Name:lower():find("house")) then
local bpList = {}
-- search all baseparts, prefer HumanoidRootPart, else everything
for _,bp in pairs(v:GetChildren()) do
if bp:IsA("BasePart") then table.insert(bpList, bp) end
end
if v:FindFirstChild("HumanoidRootPart") then table.insert(bpList, v.HumanoidRootPart) end
if #bpList > 0 and not v:FindFirstChild("HeheBaseTag") then
for _,bp in pairs(bpList) do
local bill = Instance.new("BillboardGui")
bill.Name = "HeheBaseTag"
bill.Size = UDim2.new(0,120,0,36)
bill.AlwaysOnTop = true
bill.Adornee = bp
local txt = Instance.new("TextLabel", bill)
txt.Size = UDim2.new(1,0,1,0)
txt.BackgroundTransparency = 1
txt.Text = "BASE: "..(v.Name)
txt.Font = Enum.Font.GothamBold
txt.TextSize = 15
txt.TextColor3 = Color3.fromRGB(255,200,0)
bill.Parent = bp
end
end
end
end
end
local function disableBaseESP()
-- remove ALL HeheBaseTag billboard GUIs from ALL workspace/model parts
for _,v in pairs(workspace:GetChildren()) do
if v:IsA("Model") then
for _,bp in pairs(v:GetChildren()) do
if bp:IsA("BasePart") and bp:FindFirstChild("HeheBaseTag") then bp.HeheBaseTag:Destroy() end
end
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
if bestBase then
for _,bp in pairs(bestBase:GetChildren()) do
if bp:IsA("BasePart") then
local bill = Instance.new("BillboardGui")
bill.Name = "HeheBestBrainrotTag"
bill.Size = UDim2.new(0,170,0,40)
bill.AlwaysOnTop = true
bill.Adornee = bp
local txt = Instance.new("TextLabel", bill)
txt.Size = UDim2.new(1,0,1,0)
txt.BackgroundTransparency = 1
txt.Text = "HIGHEST VALUE BASE\nValue: "..highestValue
txt.Font = Enum.Font.GothamBold
txt.TextSize = 15
txt.TextColor3 = Color3.fromRGB(255,70,70)
bill.Parent = bp
end
end
end
end
local function disableBestBrainrotESP()
for _,v in pairs(workspace:GetChildren()) do
if v:IsA("Model") then
for _,bp in pairs(v:GetChildren()) do
if bp:IsA("BasePart") and bp:FindFirstChild("HeheBestBrainrotTag") then bp.HeheBestBrainrotTag:Destroy() end
end
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
spawn(function()
while true do
if autoCollect then
doAutoCollect()
end
wait(0.6)
end
end)

-- 8. Anti AFK (always on)
pcall(function()
game:GetService("VirtualUser").Touched:Connect(function()
game:GetService("VirtualUser"):ClickButton1(Vector2.new())
end)
end)

-- === GUI Buttons ===
addBtn("Enable Player ESP", function()
espEnabled = true
enableESP()
notify("Player ESP Enabled!")
end)
addBtn("Disable Player ESP", function()
espEnabled = false
disableESP()
notify("Player ESP Disabled!")
end)
addBtn("Enable Base ESP", function()
baseEspEnabled = true
enableBaseESP()
notify("Base ESP Enabled!")
end)
addBtn("Disable Base ESP", function()
baseEspEnabled = false
disableBaseESP()
notify("Base ESP Disabled!")
end)
addBtn("Enable Best Brainrot ESP", function()
bestEspEnabled = true
enableBestBrainrotESP()
notify("Best Brainrot ESP Enabled!")
end)
addBtn("Disable Best Brainrot ESP", function()
bestEspEnabled = false
disableBestBrainrotESP()
notify("Best Brainrot ESP Disabled!")
end)
addBtn("Toggle Infinite Jump", function()
infiniteJump = not infiniteJump
notify("Infinite Jump "..(infiniteJump and "Enabled!" or "Disabled!"))
end)
addBtn("Toggle Speed Hack", function()
speedEnabled = not speedEnabled
updateSpeed()
notify("Speed Hack "..(speedEnabled and "Enabled!" or "Disabled!"))
end)
addBtn("Toggle Godmode", function()
godmode = not godmode
updateGodmode()
notify("Godmode "..(godmode and "Enabled!" or "Disabled!"))
end)
addBtn("Toggle Auto Collect", function()
autoCollect = not autoCollect
notify("Auto Collect "..(autoCollect and "Enabled!" or "Disabled!"))
end)

notify("Hehe Hub Loaded! Click the ≡ button for menu. Frame is movable.")

-- End
