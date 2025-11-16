-- Hehe Hub - Chilli Hub Style Sidebar UI

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer


---

-- Helper Functions

local function getGuiParent()
return (LocalPlayer:FindFirstChild("PlayerGui") or game:GetService("StarterGui"))
end

local function notify(msg)
pcall(function()
game.StarterGui:SetCore("SendNotification", {
Title = "Hehe Hub",
Text = msg,
Duration = 6
})
end)
end


---

-- Main ScreenGui

local gui = Instance.new("ScreenGui")
gui.Name = "HeheHubUI"
gui.IgnoreGuiInset = true
gui.ResetOnSpawn = false
gui.Parent = getGuiParent()


---

-- Main Movable Frame

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0,520,0,340)
frame.Position = UDim2.new(0.17,0,0.1,0)
frame.BackgroundColor3 = Color3.fromRGB(27,30,38)
frame.Active = true
frame.Visible = true
frame.Parent = gui
local frameCorner = Instance.new("UICorner")
frameCorner.CornerRadius = UDim.new(0,18)
frameCorner.Parent = frame


---

-- Top Bar

local topBar = Instance.new("Frame")
topBar.Size = UDim2.new(1,0,0,38)
topBar.Position = UDim2.new(0,0,0,0)
topBar.BackgroundColor3 = Color3.fromRGB(20,22,29)
topBar.Parent = frame
local topBarCorner = Instance.new("UICorner")
topBarCorner.CornerRadius = UDim.new(0,11)
topBarCorner.Parent = topBar

local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(0.7,0,1,0)
titleLabel.Position = UDim2.new(0,14,0,0)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "Steal a Brainrot - Hehe Hub"
titleLabel.Font = Enum.Font.GothamSemibold
titleLabel.TextSize = 23
titleLabel.TextColor3 = Color3.fromRGB(210,245,255)
titleLabel.TextXAlignment = Enum.TextXAlignment.Left
titleLabel.Parent = topBar

local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0,36,0,26)
closeBtn.Position = UDim2.new(1,-46,0,6)
closeBtn.Text = "✕"
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 20
closeBtn.TextColor3 = Color3.fromRGB(220,80,80)
closeBtn.BackgroundColor3 = Color3.fromRGB(20,22,29)
local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(0,8)
closeCorner.Parent = closeBtn
closeBtn.Parent = topBar
closeBtn.MouseButton1Click:Connect(function() gui.Enabled = false end)

local minimizeBtn = Instance.new("TextButton")
minimizeBtn.Size = UDim2.new(0,36,0,26)
minimizeBtn.Position = UDim2.new(1,-90,0,6)
minimizeBtn.Text = "_"
minimizeBtn.Font = Enum.Font.GothamBold
minimizeBtn.TextSize = 22
minimizeBtn.TextColor3 = Color3.fromRGB(153,167,190)
minimizeBtn.BackgroundColor3 = Color3.fromRGB(20,22,29)
local minCorner = Instance.new("UICorner")
minCorner.CornerRadius = UDim.new(0,8)
minCorner.Parent = minimizeBtn
minimizeBtn.Parent = topBar
minimizeBtn.MouseButton1Click:Connect(function() frame.Visible = not frame.Visible end)


---

-- Drag Support (TopBar Only)

local dragging, dragStart, startPos
topBar.InputBegan:Connect(function(input)
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
topBar.InputChanged:Connect(function(input)
if dragging then
if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
local delta = input.Position - dragStart
frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end
end
end)


---

-- Sidebar (Category List)

local sidebar = Instance.new("Frame")
sidebar.Size = UDim2.new(0,140,1,-38)
sidebar.Position = UDim2.new(0,0,0,38)
sidebar.BackgroundColor3 = Color3.fromRGB(19,21,27)
sidebar.Parent = frame
local sideCorner = Instance.new("UICorner")
sideCorner.CornerRadius = UDim.new(0,14)
sideCorner.Parent = sidebar

local sideList = {
"Main",
"Stealer",
"Helper",
"Player",
"Finder",
"Server",
"Discord"
}
local pageMap = {}

local selectedCategory = nil
local yPos = 18
for _,cat in ipairs(sideList) do
local btn = Instance.new("TextButton")
btn.Size = UDim2.new(0.85,0,0,35)
btn.Position = UDim2.new(0.075,0,0,yPos)
yPos = yPos + 41
btn.Text = cat
btn.Font = Enum.Font.GothamSemibold
btn.TextSize = 17
btn.BackgroundColor3 = Color3.fromRGB(32,36,47)
btn.TextColor3 = Color3.fromRGB(155,200,255)
local icorn = Instance.new("UICorner")
icorn.CornerRadius = UDim.new(0,8)
icorn.Parent = btn
btn.Parent = sidebar
-- Category selection
btn.MouseButton1Click:Connect(function()
for _,pg in pairs(pageMap) do pg.Visible = false end
pageMap[cat].Visible = true
selectedCategory = cat
-- Active highlight
for _,otherBtn in pairs(sidebar:GetChildren()) do
if otherBtn:IsA("TextButton") then
otherBtn.BackgroundColor3 = Color3.fromRGB(32,36,47)
end
end
btn.BackgroundColor3 = Color3.fromRGB(44,48,62)
end)
end


---

-- Pages (Content for Each Category)

-- Helper to make toggles
local function makeToggle(parent, txt, ypos, variable, actionOn, actionOff)
local box = Instance.new("Frame")
box.Size = UDim2.new(0.92,0,0,58)
box.Position = UDim2.new(0.03,0,0,ypos)
box.BackgroundColor3 = Color3.fromRGB(27,30,38)
box.Parent = parent
local boxCorner = Instance.new("UICorner")
boxCorner.CornerRadius = UDim.new(0,12)
boxCorner.Parent = box

local lbl = Instance.new("TextLabel")  
lbl.Size = UDim2.new(0.55,0,1,0)  
lbl.Position = UDim2.new(0,12,0,0)  
lbl.BackgroundTransparency = 1  
lbl.Text = txt  
lbl.Font = Enum.Font.GothamSemibold  
lbl.TextSize = 17  
lbl.TextColor3 = Color3.fromRGB(210,220,227)  
lbl.TextXAlignment = Enum.TextXAlignment.Left  
lbl.Parent = box  

local tog = Instance.new("TextButton")  
tog.Size = UDim2.new(0,38,0,27)  
tog.Position = UDim2.new(1,-54,0.5,-13)  
tog.BackgroundColor3 = Color3.fromRGB(58,79,120)  
tog.Text = ""  
local tc = Instance.new("UICorner")  
tc.CornerRadius = UDim.new(0,11)  
tc.Parent = tog  
tog.Parent = box  

local on = false  
local function updateCol()  
    tog.BackgroundColor3 = on and Color3.fromRGB(45,205,135) or Color3.fromRGB(58,79,120)  
end  
tog.MouseButton1Click:Connect(function()  
    on = not on  
    updateCol()  
    if on then actionOn(); else actionOff(); end  
end)  
updateCol()

end

-- Main Page (welcome/etc)
local mainPg = Instance.new("Frame")
mainPg.Size = UDim2.new(1,-145,1,-38)
mainPg.Position = UDim2.new(0,145,0,38)
mainPg.Visible = true
mainPg.BackgroundTransparency = 1
mainPg.Parent = frame
pageMap["Main"] = mainPg
local mainLbl = Instance.new("TextLabel")
mainLbl.Size = UDim2.new(1,0,0,50)
mainLbl.Position = UDim2.new(0,0,0,40)
mainLbl.BackgroundTransparency = 1
mainLbl.Text = "Welcome to Hehe Hub!\nSelect a category for hacks."
mainLbl.Font = Enum.Font.GothamBold
mainLbl.TextSize = 22
mainLbl.TextColor3 = Color3.fromRGB(155,255,255)
mainLbl.Parent = mainPg

-- Stealer Page (placeholder)
local stealerPg = Instance.new("Frame")
stealerPg.Size = UDim2.new(1,-145,1,-38)
stealerPg.Position = UDim2.new(0,145,0,38)
stealerPg.Visible = false
stealerPg.BackgroundTransparency = 1
stealerPg.Parent = frame
pageMap["Stealer"] = stealerPg
local stealerLbl = Instance.new("TextLabel")
stealerLbl.Size = UDim2.new(1,0,0,40)
stealerLbl.Position = UDim2.new(0,0,0,16)
stealerLbl.BackgroundTransparency = 1
stealerLbl.Text = "Stealer related functions will go here."
stealerLbl.Font = Enum.Font.Gotham
stealerLbl.TextSize = 18
stealerLbl.TextColor3 = Color3.fromRGB(180,220,255)
stealerLbl.Parent = stealerPg

-- Helper Page (placeholder)
local helperPg = Instance.new("Frame")
helperPg.Size = UDim2.new(1,-145,1,-38)
helperPg.Position = UDim2.new(0,145,0,38)
helperPg.Visible = false
helperPg.BackgroundTransparency = 1
helperPg.Parent = frame
pageMap["Helper"] = helperPg
local helperLbl = Instance.new("TextLabel")
helperLbl.Size = UDim2.new(1,0,0,40)
helperLbl.Position = UDim2.new(0,0,0,16)
helperLbl.BackgroundTransparency = 1
helperLbl.Text = "Helper functions go here."
helperLbl.Font = Enum.Font.Gotham
helperLbl.TextSize = 18
helperLbl.TextColor3 = Color3.fromRGB(180,220,255)
helperLbl.Parent = helperPg

-- Player Page (actual hacks)
local playerPg = Instance.new("Frame")
playerPg.Size = UDim2.new(1,-145,1,-38)
playerPg.Position = UDim2.new(0,145,0,38)
playerPg.Visible = false
playerPg.BackgroundTransparency = 1
playerPg.Parent = frame
pageMap["Player"] = playerPg

-- Finder Page (placeholder)
local finderPg = Instance.new("Frame")
finderPg.Size = UDim2.new(1,-145,1,-38)
finderPg.Position = UDim2.new(0,145,0,38)
finderPg.Visible = false
finderPg.BackgroundTransparency = 1
finderPg.Parent = frame
pageMap["Finder"] = finderPg
local finderLbl = Instance.new("TextLabel")
finderLbl.Size = UDim2.new(1,0,0,40)
finderLbl.Position = UDim2.new(0,0,0,16)
finderLbl.BackgroundTransparency = 1
finderLbl.Text = "Finder Page Placeholder"
finderLbl.Font = Enum.Font.Gotham
finderLbl.TextSize = 18
finderLbl.TextColor3 = Color3.fromRGB(180,220,255)
finderLbl.Parent = finderPg

-- Server Page (placeholder)
local serverPg = Instance.new("Frame")
serverPg.Size = UDim2.new(1,-145,1,-38)
serverPg.Position = UDim2.new(0,145,0,38)
serverPg.Visible = false
serverPg.BackgroundTransparency = 1
serverPg.Parent = frame
pageMap["Server"] = serverPg
local serverLbl = Instance.new("TextLabel")
serverLbl.Size = UDim2.new(1,0,0,40)
serverLbl.Position = UDim2.new(0,0,0,16)
serverLbl.BackgroundTransparency = 1
serverLbl.Text = "Server Page Placeholder"
serverLbl.Font = Enum.Font.Gotham
serverLbl.TextSize = 18
serverLbl.TextColor3 = Color3.fromRGB(180,220,255)
serverLbl.Parent = serverPg

-- Discord Page (placeholder)
local discordPg = Instance.new("Frame")
discordPg.Size = UDim2.new(1,-145,1,-38)
discordPg.Position = UDim2.new(0,145,0,38)
discordPg.Visible = false
discordPg.BackgroundTransparency = 1
discordPg.Parent = frame
pageMap["Discord"] = discordPg
local discordLbl = Instance.new("TextLabel")
discordLbl.Size = UDim2.new(1,0,0,40)
discordLbl.Position = UDim2.new(0,0,0,16)
discordLbl.BackgroundTransparency = 1
discordLbl.Text = "Join the Discord for support!"
discordLbl.Font = Enum.Font.Gotham
discordLbl.TextSize = 18
discordLbl.TextColor3 = Color3.fromRGB(180,220,255)
discordLbl.Parent = discordPg


---

-- Player Page Toggles (Real Features)

local espEnabled, baseEspEnabled, bestEspEnabled, infiniteJump, speedEnabled, godmode, autoCollect = false, false, false, false, false, false, false

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

local function enableBaseESP()
for _,v in pairs(workspace:GetChildren()) do
if v:IsA("Model") and (v.Name:lower():find("base")) then
local bpList = {}
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
for _,v in pairs(workspace:GetChildren()) do
if v:IsA("Model") then
for _,bp in pairs(v:GetChildren()) do
if bp:IsA("BasePart") and bp:FindFirstChild("HeheBaseTag") then bp.HeheBaseTag:Destroy() end
end
end
end
end

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
for _,v in pairs(workspace:GetChildren()) do
if v:IsA("Model") then
for _,bp in pairs(v:GetChildren()) do
if bp:IsA("BasePart") and bp:FindFirstChild("HeheBestBrainrotTag") then bp.HeheBestBrainrotTag:Destroy() end
end
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

game:GetService("UserInputService").JumpRequest:Connect(function()
if infiniteJump and LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping")
end
end)

local defaultSpeed, fastSpeed = 16, 45
local function updateSpeed()
local h = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
if h then h.WalkSpeed = speedEnabled and fastSpeed or defaultSpeed end
end
LocalPlayer.CharacterAdded:Connect(updateSpeed)

local function updateGodmode()
local h = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
if h then
h.MaxHealth = godmode and math.huge or 100
h.Health = godmode and math.huge or h.MaxHealth
end
end
LocalPlayer.CharacterAdded:Connect(updateGodmode)

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
wait(0.5)
end
end)

-- Anti AFK
pcall(function()
game:GetService("VirtualUser").Touched:Connect(function()
game:GetService("VirtualUser"):ClickButton1(Vector2.new())
end)
end)


---

-- Player Page: Add feature toggles

local py = 24
makeToggle(playerPg, "Player ESP", py, espEnabled, function() espEnabled = true; enableESP(); end, function() espEnabled = false; disableESP(); end)
py = py + 62
makeToggle(playerPg, "Base ESP",   py, baseEspEnabled, function() baseEspEnabled = true; enableBaseESP(); end, function() baseEspEnabled = false; disableBaseESP(); end)
py = py + 62
makeToggle(playerPg, "Best Brainrot ESP", py, bestEspEnabled, function() bestEspEnabled = true; enableBestBrainrotESP(); end, function() bestEspEnabled = false; disableBestBrainrotESP(); end)
py = py + 62
makeToggle(playerPg, "Infinity Jump",py, infiniteJump, function() infiniteJump=true; end, function() infiniteJump=false; end)
py = py + 62
makeToggle(playerPg, "Speed Hack",  py, speedEnabled, function() speedEnabled=true;updateSpeed(); end, function() speedEnabled=false;updateSpeed(); end)
py = py + 62
makeToggle(playerPg, "Godmode",     py, godmode, function() godmode=true;updateGodmode(); end, function() godmode=false;updateGodmode(); end)
py = py + 62
makeToggle(playerPg, "Auto Collect",py, autoCollect, function() autoCollect=true; end, function() autoCollect=false; end)


---

-- Initialization

-- Show just Main on load
for cat,pg in pairs(pageMap) do pg.Visible = (cat=="Main") end
selectedCategory = "Main"
-- Highlight Main on load
for btn in sidebar:GetChildren() do
if btn:IsA("TextButton") and btn.Text=="Main" then
btn.BackgroundColor3 = Color3.fromRGB(44,48,62)
end
end

notify("Hehe Hub loaded!\nSidebar, draggable, toggles, Chilli style.")
