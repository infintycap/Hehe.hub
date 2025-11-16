-- Hehe Hub by Miggysalad - Full Feature Menu, Animated Border, SAFE Infinite Jump

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local gui = Instance.new("ScreenGui")
gui.Name = "HeheHubUI"
gui.IgnoreGuiInset = true
gui.ResetOnSpawn = false
gui.Parent = LocalPlayer:WaitForChild("PlayerGui")

-- === Toggle Button ===
local toggleBtn = Instance.new("TextButton")
toggleBtn.Size = UDim2.new(0,48,0,48)
toggleBtn.Position = UDim2.new(0,14,0,120)
toggleBtn.BackgroundColor3 = Color3.fromRGB(49,61,99)
toggleBtn.Text = "≡"
toggleBtn.Font = Enum.Font.GothamBold
toggleBtn.TextColor3 = Color3.fromRGB(180,220,255)
toggleBtn.TextSize = 32
toggleBtn.Visible = true
toggleBtn.ZIndex = 10
local tbtnCorner = Instance.new("UICorner")
tbtnCorner.CornerRadius = UDim.new(0,12)
tbtnCorner.Parent = toggleBtn
toggleBtn.Parent = gui

-- === Main Menu Frame ===
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0,512,0,414)
frame.Position = UDim2.new(0.21,0,0.19,0)
frame.BackgroundColor3 = Color3.fromRGB(27,30,38)
frame.Visible = false
frame.Active = true
frame.ZIndex = 20
local frameCorner = Instance.new("UICorner")
frameCorner.CornerRadius = UDim.new(0,18)
frameCorner.Parent = frame
frame.Parent = gui

-- === Animated Border (Red/Green) ===
local borderThickness = 5
local border = Instance.new("Frame")
border.Size = frame.Size + UDim2.new(0,2borderThickness,0,2borderThickness)
border.Position = frame.Position - UDim2.new(0,borderThickness,0,borderThickness)
border.BackgroundTransparency = 1
border.ZIndex = frame.ZIndex + 1
border.Parent = gui

local borderTop = Instance.new("Frame")
borderTop.Size = UDim2.new(1,0,0,borderThickness)
borderTop.Position = UDim2.new(0,0,0,0)
borderTop.BackgroundColor3 = Color3.fromRGB(255,50,50)
borderTop.BorderSizePixel = 0
borderTop.ZIndex = border.ZIndex
borderTop.Parent = border

local borderBottom = borderTop:Clone()
borderBottom.Position = UDim2.new(0,0,1,-borderThickness)
borderBottom.Parent = border
local borderLeft = Instance.new("Frame")
borderLeft.Size = UDim2.new(0,borderThickness,1,0)
borderLeft.Position = UDim2.new(0,0,0,0)
borderLeft.BackgroundColor3 = Color3.fromRGB(50,255,50)
borderLeft.BorderSizePixel = 0
borderLeft.ZIndex = border.ZIndex
borderLeft.Parent = border
local borderRight = borderLeft:Clone()
borderRight.Position = UDim2.new(1,-borderThickness,0,0)
borderRight.Parent = border

-- === Border Animation ===
local hue = 0
spawn(function()
while true do
hue = (hue + 2) % 360
local redColor = Color3.fromHSV((hue/360),1,1)
local greenColor = Color3.fromHSV(((hue+120)%360/360),1,1)
borderTop.BackgroundColor3 = redColor
borderBottom.BackgroundColor3 = redColor
borderLeft.BackgroundColor3 = greenColor
borderRight.BackgroundColor3 = greenColor
wait(0.03)
end
end)
local function updateBorder()
border.Size = frame.Size + UDim2.new(0,2borderThickness,0,2borderThickness)
border.Position = frame.Position - UDim2.new(0,borderThickness,0,borderThickness)
end
frame:GetPropertyChangedSignal("Position"):Connect(updateBorder)
frame:GetPropertyChangedSignal("Size"):Connect(updateBorder)
updateBorder()

-- === Top Bar (draggable) ===
local topBar = Instance.new("Frame")
topBar.Size = UDim2.new(1,0,0,38)
topBar.Position = UDim2.new(0,0,0,0)
topBar.BackgroundColor3 = Color3.fromRGB(20,22,29)
topBar.ZIndex = 21
topBar.Parent = frame
local topBarCorner = Instance.new("UICorner")
topBarCorner.CornerRadius = UDim.new(0,11)
topBarCorner.Parent = topBar
local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(0.7,0,1,0)
titleLabel.Position = UDim2.new(0,14,0,0)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "Steal a Brainrot - Hehe Hub"
titleLabel.Font = Enum.Font.GothamBold
titleLabel.TextSize = 22
titleLabel.TextColor3 = Color3.fromRGB(210,245,255)
titleLabel.TextXAlignment = Enum.TextXAlignment.Left
titleLabel.ZIndex = 22
titleLabel.Parent = topBar
local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0,38,0,26)
closeBtn.Position = UDim2.new(1,-46,0,6)
closeBtn.Text = "✕"
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 18
closeBtn.TextColor3 = Color3.fromRGB(220,80,80)
closeBtn.BackgroundColor3 = Color3.fromRGB(20,22,29)
local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(0,8)
closeCorner.Parent = closeBtn
closeBtn.ZIndex = 22
closeBtn.Parent = topBar
closeBtn.MouseButton1Click:Connect(function() frame.Visible = false border.Visible = false end)
toggleBtn.MouseButton1Click:Connect(function()
frame.Visible = not frame.Visible
border.Visible = frame.Visible
end)

-- === Dragging ===
local dragging, dragStart, startPos
topBar.InputBegan:Connect(function(input)
if input.UserInputType == Enum.UserInputType.MouseButton1 then
dragging = true
dragStart = input.Position
startPos = frame.Position
input.Changed:Connect(function()
if input.UserInputState == Enum.UserInputState.End then dragging = false end
end)
end
end)
topBar.InputChanged:Connect(function(input)
if dragging then
if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
local delta = input.Position - dragStart
frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset+delta.X, startPos.Y.Scale, startPos.Y.Offset+delta.Y)
end
end
end)

-- === Sidebar nav ===
local sidebar = Instance.new("Frame")
sidebar.Size = UDim2.new(0,140,1,-38)
sidebar.Position = UDim2.new(0,0,0,38)
sidebar.BackgroundColor3 = Color3.fromRGB(19,21,27)
sidebar.ZIndex = 20
sidebar.Parent = frame
local sideCorner = Instance.new("UICorner")
sideCorner.CornerRadius = UDim.new(0,14)
sideCorner.Parent = sidebar

local pageMap = {}
local sideList = {
"Main",
"Player",
"Base/ESP",
"Misc"
}
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
btn.ZIndex = 21
local icorn = Instance.new("UICorner")
icorn.CornerRadius = UDim.new(0,8)
icorn.Parent = btn
btn.Parent = sidebar
btn.MouseButton1Click:Connect(function()
for _,pg in pairs(pageMap) do pg.Visible = false end
pageMap[cat].Visible = true
selectedCategory = cat
for _,otherBtn in pairs(sidebar:GetChildren()) do
if otherBtn:IsA("TextButton") then otherBtn.BackgroundColor3 = Color3.fromRGB(32,36,47) end
end
btn.BackgroundColor3 = Color3.fromRGB(44,48,62)
end)
end

-- === Toggle Maker ===
local function makeToggle(parent, txt, ypos, getVar, setVar)
local box = Instance.new("Frame")
box.Size = UDim2.new(0.9,0,0,54)
box.Position = UDim2.new(0.05,0,0,ypos)
box.BackgroundColor3 = Color3.fromRGB(27,30,38)
box.ZIndex = 22
box.Parent = parent
local boxCorner = Instance.new("UICorner")
boxCorner.CornerRadius = UDim.new(0,12)
boxCorner.Parent = box

local lbl = Instance.new("TextLabel")  
lbl.Size = UDim2.new(0.6,0,1,0)  
lbl.Position = UDim2.new(0,14,0,0)  
lbl.BackgroundTransparency = 1  
lbl.Text = txt  
lbl.Font = Enum.Font.GothamSemibold  
lbl.TextSize = 17  
lbl.TextColor3 = Color3.fromRGB(210,220,227)  
lbl.TextXAlignment = Enum.TextXAlignment.Left  
lbl.ZIndex = 22  
lbl.Parent = box  

local tog = Instance.new("TextButton")  
tog.Size = UDim2.new(0,34,0,22)  
tog.Position = UDim2.new(1,-52,0.5,-11)  
tog.BackgroundColor3 = Color3.fromRGB(58,79,120)  
tog.Text = ""  
tog.ZIndex = 22  
local tc = Instance.new("UICorner")  
tc.CornerRadius = UDim.new(0,9)  
tc.Parent = tog  
tog.Parent = box  

local function updateCol()  
    tog.BackgroundColor3 = getVar() and Color3.fromRGB(45,205,135) or Color3.fromRGB(58,79,120)  
end  
tog.MouseButton1Click:Connect(function()  
    setVar(not getVar())  
    updateCol()  
end)  
updateCol()

end

-- === Feature Variables ===
local antiAfk          = false
local autoLockBase     = false
local autoCollect      = false
local stealUpstairs    = false
local desync           = false
local autoKickOnSteal  = false
local autoDestroyTurrets = false
local xray             = false
local timerEsp         = false
local playerEsp        = false
local highestValueEsp  = false
local antiRagdoll      = false
local infiniteJump     = false
local autoLoadScript   = false

-- === Feature Logic ===
-- 1. Anti AFK
spawn(function()
while true do
if antiAfk then
pcall(function()
game:GetService("VirtualUser"):CaptureController()
game:GetService("VirtualUser"):ClickButton1(Vector2.new())
end)
end
wait(20)
end
end)
-- 2. Auto Lock Base (example)
spawn(function()
while true do
if autoLockBase then
local base = workspace:FindFirstChild("Base") or workspace:FindFirstChildWhichIsA("Model")
if base and base:FindFirstChild("Lock") then
base.Lock.Value = true
end
end
wait(2)
end
end)
-- 3. Auto Collect Money
spawn(function()
while true do
if autoCollect and LocalPlayer.Character then
for _,drop in pairs(workspace:GetChildren()) do
if drop:IsA("Part") and drop.Name == "Money" then
drop.CFrame = LocalPlayer.Character.HumanoidRootPart.CFrame
end
end
end
wait(0.6)
end
end)
-- 4. Steal Upstairs (example)
local function doStealUpstairs()
if stealUpstairs and LocalPlayer.Character and workspace:FindFirstChild("UpstairsSteal") then
LocalPlayer.Character.HumanoidRootPart.CFrame = workspace.UpstairsSteal.CFrame
end
end

-- 5. Desync (simple version)
local function doDesync()
if desync and LocalPlayer.Character then
LocalPlayer.Character.HumanoidRootPart.CFrame = LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0,10,0)
end
end

-- 6. Auto Kick on Steal (example)
local function checkAutoKickOnSteal()
if autoKickOnSteal and workspace:FindFirstChild("Stolen") then
LocalPlayer:Kick("You stole and have been kicked! (Auto Kick)")
end
end

-- 7. Auto Destroy Turrets
spawn(function()
while true do
if autoDestroyTurrets then
for _,obj in pairs(workspace:GetChildren()) do
if obj.Name:lower():find("turret") and obj:IsA("Model") then
obj:Destroy()
end
end
end
wait(3)
end
end)
-- 8. X-Ray bases (Transparency)
local function setXRay(state)
for _,model in pairs(workspace:GetChildren()) do
if model:IsA("Model") and model.Name:lower():find("base") then
for _,bp in pairs(model:GetDescendants()) do
if bp:IsA("BasePart") then
bp.LocalTransparencyModifier = state and 0.7 or 0
end
end
end
end
end
-- 9. Timer ESP (shows timer on bases)
local function setTimerEsp(state)
for _,model in pairs(workspace:GetChildren()) do
if model:IsA("Model") and model.Name:lower():find("base") then
-- Remove old timer ESP
for _,bp in pairs(model:GetChildren()) do
if bp:IsA("BasePart") and bp:FindFirstChild("HeheTimerTag") then bp.HeheTimerTag:Destroy() end
end
if state then
for _,bp in pairs(model:GetChildren()) do
if bp:IsA("BasePart") then
local bill = Instance.new("BillboardGui")
bill.Name = "HeheTimerTag"
bill.Size = UDim2.new(0,120,0,28)
bill.AlwaysOnTop = true
bill.Adornee = bp
local txt = Instance.new("TextLabel", bill)
txt.Size = UDim2.new(1,0,1,0)
txt.BackgroundTransparency = 1
local timerValue = model:FindFirstChild("Timer") and model.Timer.Value or "?"
txt.Text = "Timer: "..timerValue
txt.Font = Enum.Font.GothamBold
txt.TextSize = 13
txt.TextColor3 = Color3.fromRGB(255,200,100)
bill.Parent = bp
end
end
end
end
end
end
-- 10. Player ESP
local function setPlayerEsp(state)
for _,p in pairs(Players:GetPlayers()) do
if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
local tag = p.Character.HumanoidRootPart:FindFirstChild("HehePlayerTag")
if state and not tag then
local bill = Instance.new("BillboardGui")
bill.Name = "HehePlayerTag"
bill.Size = UDim2.new(0,100,0,24)
bill.AlwaysOnTop = true
bill.Adornee = p.Character.HumanoidRootPart
local txt = Instance.new("TextLabel", bill)
txt.Size = UDim2.new(1,0,1,0)
txt.BackgroundTransparency = 1
txt.Text = p.DisplayName or p.Name
txt.Font = Enum.Font.GothamBold
txt.TextSize = 16
txt.TextColor3 = Color3.fromRGB(96,255,96)
bill.Parent = p.Character.HumanoidRootPart
elseif not state and tag then
tag:Destroy()
end
end
end
end
-- 11. Highest Value Brainrot ESP
local function setHighestValueEsp(state)
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
-- Remove old tag
for _,v in pairs(workspace:GetChildren()) do
if v:IsA("Model") then
for _,bp in pairs(v:GetChildren()) do
if bp:IsA("BasePart") and bp:FindFirstChild("HeheBestBrainrotTag") then bp.HeheBestBrainrotTag:Destroy() end
end
end
end
if state and bestBase then
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
-- 12. Anti Ragdoll
spawn(function()
while true do
if antiRagdoll and LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
LocalPlayer.Character:FindFirstChildOfClass("Humanoid").PlatformStand = false
LocalPlayer.Character:FindFirstChildOfClass("Humanoid").BreakJointsOnDeath = false
end
wait(0.5)
end
end)
-- 13. Infinite Jump (safe)
game:GetService("UserInputService").JumpRequest:Connect(function()
if infiniteJump and LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
local h = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
h:ChangeState(Enum.HumanoidStateType.Physics)
h:ChangeState(Enum.HumanoidStateType.Jumping)
h:SetStateEnabled(Enum.HumanoidStateType.Freefall,false) -- prevent falling to death
h:SetStateEnabled(Enum.HumanoidStateType.Jumping,true)
end
end)
-- 14. Auto Load Script toggle (example)
if autoLoadScript then
local autoFunc = function()
print("Auto loading script!")
-- You can add your own script loader here
end
autoFunc()
end

-- Hooks to update ESP toggles when variable changes
local updateHooks = {
playerEsp = setPlayerEsp,
highestValueEsp = setHighestValueEsp,
timerEsp = setTimerEsp,
xray = setXRay
}

-- === Page definitions
-- Main Page
local mainPg = Instance.new("Frame")
mainPg.Size = UDim2.new(1,-145,1,-38)
mainPg.Position = UDim2.new(0,145,0,38)
mainPg.Visible = true
mainPg.BackgroundTransparency = 1
mainPg.ZIndex = 18
mainPg.Parent = frame
pageMap["Main"] = mainPg
local mainLbl = Instance.new("TextLabel")
mainLbl.Size = UDim2.new(1,0,0,50)
mainLbl.Position = UDim2.new(0,0,0,60)
mainLbl.BackgroundTransparency = 1
mainLbl.Text = "Welcome to Hehe Hub!\nAll game hacks in one menu.\nGreen/Red border = animated!"
mainLbl.Font = Enum.Font.GothamBold
mainLbl.TextSize = 22
mainLbl.TextColor3 = Color3.fromRGB(155,255,155)
mainLbl.ZIndex = 18
mainLbl.Parent = mainPg

-- Player
local pp = Instance.new("Frame")
pp.Size = UDim2.new(1,-145,1,-38)
pp.Position = UDim2.new(0,145,0,38)
pp.Visible = false
pp.BackgroundTransparency = 1
pp.ZIndex = 20
pp.Parent = frame
pageMap["Player"] = pp
local py = 26
makeToggle(pp,"Anti AFK",py,function() return antiAfk end,function(v) antiAfk = v end)
py = py + 62
makeToggle(pp,"Auto Lock Base",py,function() return autoLockBase end,function(v) autoLockBase = v end)
py = py + 62
makeToggle(pp,"Auto Collect Money",py,function() return autoCollect end,function(v) autoCollect = v end)
py = py + 62
makeToggle(pp,"Steal Upstairs",py,function() return stealUpstairs end,function(v) stealUpstairs = v doStealUpstairs() end)
py = py + 62
makeToggle(pp,"Desync",py,function() return desync end,function(v) desync = v doDesync() end)
py = py + 62
makeToggle(pp,"Auto Kick on Steal",py,function() return autoKickOnSteal end,function(v) autoKickOnSteal = v checkAutoKickOnSteal() end)
py = py + 62
makeToggle(pp,"Auto Destroy Turrets",py,function() return autoDestroyTurrets end,function(v) autoDestroyTurrets = v end)
py = py + 62
makeToggle(pp,"Anti Ragdoll",py,function() return antiRagdoll end,function(v) antiRagdoll = v end)
py = py + 62
makeToggle(pp,"Infinite Jump",py,function() return infiniteJump end,function(v) infiniteJump = v end)

-- Base/ESP
local ep = Instance.new("Frame")
ep.Size = UDim2.new(1,-145,1,-38)
ep.Position = UDim2.new(0,145,0,38)
ep.Visible = false
ep.BackgroundTransparency = 1
ep.ZIndex = 20
ep.Parent = frame
pageMap["Base/ESP"] = ep
local ey = 26
makeToggle(ep,"Player ESP",ey,function() return playerEsp end,function(v) playerEsp = v updateHooks.playerEsp(v) end)
ey = ey + 62
makeToggle(ep,"Highest Value Brainrot ESP",ey,function() return highestValueEsp end,function(v) highestValueEsp = v updateHooks.highestValueEsp(v) end)
ey = ey + 62
makeToggle(ep,"Timer ESP (on bases)",ey,function() return timerEsp end,function(v) timerEsp = v updateHooks.timerEsp(v) end)
ey = ey + 62
makeToggle(ep,"X-ray Bases",ey,function() return xray end,function(v) xray = v updateHooks.xray(v) end)

-- Misc
local mp = Instance.new("Frame")
mp.Size = UDim2.new(1,-145,1,-38)
mp.Position = UDim2.new(0,145,0,38)
mp.Visible = false
mp.BackgroundTransparency = 1
mp.ZIndex = 20
mp.Parent = frame
pageMap["Misc"] = mp
local my = 26
makeToggle(mp,"Auto Load Script",my,function() return autoLoadScript end,function(v) autoLoadScript=v end)

-- Default page
for cat,pg in pairs(pageMap) do pg.Visible = (cat=="Main") end
selectedCategory = "Main"
for btn in sidebar:GetChildren() do
if btn:IsA("TextButton") and btn.Text=="Main" then btn.BackgroundColor3 = Color3.fromRGB(44,48,62) end
end

-- End of Hehe.lua
