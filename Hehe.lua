-- Hehe Hub - Custom Script with 'Best Brainrot ESP' and Features

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- Toggle states
local espEnabled = false
local baseEspEnabled = false
local bestBrainrotEspEnabled = false
local infiniteJump = false
local speedEnabled = false
local godmode = false
local autoCollect = false

-- ========= ESP: Players =========
function enableESP()
for _,p in pairs(Players:GetPlayers()) do
if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") and not p.Character.HumanoidRootPart:FindFirstChild("HeheTag") then
local tag = Instance.new("BillboardGui")
tag.Name = "HeheTag"
tag.Size = UDim2.new(0,100,0,30)
tag.AlwaysOnTop = true
tag.Adornee = p.Character.HumanoidRootPart
local text = Instance.new("TextLabel", tag)
text.Size = UDim2.new(1,0,1,0)
text.BackgroundTransparency = 1
text.Text = p.DisplayName or p.Name
text.Font = Enum.Font.GothamBold
text.TextSize = 18
text.TextColor3 = Color3.fromRGB(70,206,130)
tag.Parent = p.Character.HumanoidRootPart
end
end
end
function disableESP()
for _,p in pairs(Players:GetPlayers()) do
if p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
local tag = p.Character.HumanoidRootPart:FindFirstChild("HeheTag")
if tag then tag:Destroy() end
end
end
end

-- ========= ESP: Bases =========
function enableBaseESP()
for _,v in pairs(workspace:GetChildren()) do
if v:IsA("Model") and v.Name:lower():find("base") and v:FindFirstChildWhichIsA("BasePart") and not v:FindFirstChild("HeheBaseTag") then
local bill = Instance.new("BillboardGui")
bill.Name = "HeheBaseTag"
bill.Size = UDim2.new(0,120,0,40)
bill.AlwaysOnTop = true
bill.Adornee = v:FindFirstChildWhichIsA("BasePart")
local txt = Instance.new("TextLabel", bill)
txt.Size = UDim2.new(1,0,1,0)
txt.BackgroundTransparency = 1
txt.Text = "BASE: "..v.Name
txt.Font = Enum.Font.GothamBold
txt.TextSize = 17
txt.TextColor3 = Color3.fromRGB(255,200,0)
bill.Parent = v
end
end
end
function disableBaseESP()
for _,v in pairs(workspace:GetChildren()) do
if v:IsA("Model") and v:FindFirstChild("HeheBaseTag") then
v.HeheBaseTag:Destroy()
end
end
end

-- ========= Best Brainrot ESP (highest value base) =========
function enableBestBrainrotESP()
local highestValue = 0
local bestBase = nil
for _,v in pairs(workspace:GetChildren()) do
if v:IsA("Model") and v.Name:lower():find("base") then
-- Find a NumberValue or IntValue named 'Value' or similar in the base
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
bill.Size = UDim2.new(0,160,0,45)
bill.AlwaysOnTop = true
bill.Adornee = bestBase:FindFirstChildWhichIsA("BasePart")
local txt = Instance.new("TextLabel", bill)
txt.Size = UDim2.new(1,0,1,0)
txt.BackgroundTransparency = 1
txt.Text = "HIGHEST VALUE BASE!\nValue: "..highestValue
txt.Font = Enum.Font.GothamBold
txt.TextSize = 18
txt.TextColor3 = Color3.fromRGB(255,60,60)
bill.Parent = bestBase
end
end
function disableBestBrainrotESP()
for _,v in pairs(workspace:GetChildren()) do
if v:IsA("Model") and v:FindFirstChild("HeheBestBrainrotTag") then
v.HeheBestBrainrotTag:Destroy()
end
end
end

-- ========= Feature 1: Infinite Jump =========
game:GetService("UserInputService").JumpRequest:Connect(function()
if infiniteJump and LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping")
end
end)

-- ========= Feature 2: Speed Hack =========
local defaultSpeed = 16
local fastSpeed = 50
function updateSpeed()
local h = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
if h then
h.WalkSpeed = speedEnabled and fastSpeed or defaultSpeed
end
end
LocalPlayer.CharacterAdded:Connect(updateSpeed)

-- ========= Feature 3: Godmode =========
function updateGodmode()
local h = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
if h then
h.MaxHealth = godmode and math.huge or 100
h.Health = godmode and math.huge or h.MaxHealth
end
end
LocalPlayer.CharacterAdded:Connect(updateGodmode)

-- ========= Feature 4: Auto Collect =========
function doAutoCollect()
if autoCollect and LocalPlayer.Character then
for _,drop in pairs(workspace:GetChildren()) do
if drop:IsA("Part") and drop.Name == "Money" then
drop.CFrame = LocalPlayer.Character.HumanoidRootPart.CFrame
end
end
end
end

-- ========= Feature 5: Anti AFK =========
if true then
game:GetService("VirtualUser").Touched:Connect(function()
game:GetService("VirtualUser"):ClickButton1(Vector2.new())
end)
end

-- ========= SIMPLE COMMAND MENU =========
print("Hehe Hub Loaded!")
print("Type these commands in your executor to toggle features:")
print("_G.esp_on(), _G.esp_off(), _G.baseesp_on(), _G.baseesp_off()")
print("_G.bestesp_on(), _G.bestesp_off()")
print("_G.infjump_on(), _G.infjump_off(), _G.speed_on(), _G.speed_off()")
print("_G.god_on(), _G.god_off(), _G.collect_on(), _G.collect_off()")

_G.esp_on = function()
espEnabled = true
enableESP()
end
_G.esp_off = function()
espEnabled = false
disableESP()
end
_G.baseesp_on = function()
baseEspEnabled = true
enableBaseESP()
end
_G.baseesp_off = function()
baseEspEnabled = false
disableBaseESP()
end
_G.bestesp_on = function()
bestBrainrotEspEnabled = true
enableBestBrainrotESP()
end
_G.bestesp_off = function()
bestBrainrotEspEnabled = false
disableBestBrainrotESP()
end
_G.infjump_on = function()
infiniteJump = true
end
_G.infjump_off = function()
infiniteJump = false
end
_G.speed_on = function()
speedEnabled = true
updateSpeed()
end
_G.speed_off = function()
speedEnabled = false
updateSpeed()
end
_G.god_on = function()
godmode = true
updateGodmode()
end
_G.god_off = function()
godmode = false
updateGodmode()
end
_G.collect_on = function()
autoCollect = true
while autoCollect do
doAutoCollect()
wait(1)
end
end
_G.collect_off = function()
autoCollect = false
end

-- Optionally, connect features to custom buttons or GUI later!
