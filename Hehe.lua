-- Hehe Hub: Delta/Syn/Universal Executor Compatible
-- Minimal, fully working: Sidebar, tabs, toggles. No unsupported APIs.

local lp = game:GetService("Players").LocalPlayer
local playerGui = lp:FindFirstChildOfClass("PlayerGui")
if not playerGui then return end

local sg = Instance.new("ScreenGui")
sg.Name = "HeheHub"
sg.Parent = playerGui

-- Notification (mobile safe)
local function showNotif(msg)
local notif = Instance.new("TextLabel")
notif.Parent = sg
notif.Size = UDim2.new(0.7,0,0,38)
notif.Position = UDim2.new(0.15,0,0,10)
notif.BackgroundColor3 = Color3.fromRGB(18,22,28)
notif.TextColor3 = Color3.fromRGB(60,255,60)
notif.Font = Enum.Font.GothamBold
notif.TextSize = 20
notif.Text = msg
notif.ZIndex = 100
notif.BackgroundTransparency = 0.19
notif.BorderSizePixel = 0
notif.TextStrokeTransparency = 0.8
local c = Instance.new("UICorner", notif)
c.CornerRadius = UDim.new(0,9)
delay(4, function() notif:Destroy() end)
end
showNotif("Hehe Hub Loaded!")

-- Toggle button (hamburger style)
local tgl = Instance.new("TextButton")
tgl.Parent = sg
tgl.Size = UDim2.new(0,50,0,50)
tgl.Position = UDim2.new(0,10,0,56)
tgl.Text = "≡"
tgl.Font = Enum.Font.GothamBold
tgl.TextSize = 34
tgl.BackgroundColor3 = Color3.fromRGB(99,23,23)
tgl.TextColor3 = Color3.fromRGB(90,220,90)
local tc = Instance.new("UICorner", tgl)
tc.CornerRadius = UDim.new(0,11)

-- Main frame
local frm = Instance.new("Frame")
frm.Parent = sg
frm.Size = UDim2.new(0,350,0,370)
frm.Position = UDim2.new(0,65,0,65)
frm.BackgroundColor3 = Color3.fromRGB(20,26,40)
frm.Visible = false
local frc = Instance.new("UICorner", frm)
frc.CornerRadius = UDim.new(0,19)

tgl.MouseButton1Click:Connect(function()
frm.Visible = not frm.Visible
end)

-- Sidebar tabs
local sidebar = Instance.new("Frame")
sidebar.Parent = frm
sidebar.Size = UDim2.new(0,92,1,0)
sidebar.Position = UDim2.new(0,0,0,0)
sidebar.BackgroundColor3 = Color3.fromRGB(13,16,25)
local sdc = Instance.new("UICorner", sidebar)
sdc.CornerRadius = UDim.new(0,15)

local tabNames = {'Player','ESP','Misc'}
local tabFrames, btns = {}, {}
for i,tab in ipairs(tabNames) do
local b = Instance.new("TextButton")
b.Parent = sidebar
b.Size = UDim2.new(1,-12,0,38)
b.Position = UDim2.new(0,6,0,(i-1)48+24)
b.Text = tab
b.Font = Enum.Font.GothamSemibold
b.TextSize = 16
b.BackgroundColor3 = Color3.fromRGB(50+(i50)%160,30,55+(i*28))
b.TextColor3 = Color3.fromRGB(150,220,255)
local bc = Instance.new("UICorner", b)
bc.CornerRadius = UDim.new(0,8)
btns[tab] = b

local f = Instance.new("Frame")  
f.Parent = frm  
f.Size = UDim2.new(1,-100,1,-16)  
f.Position = UDim2.new(0,100,0,8)  
f.Visible = (i==1)  
f.BackgroundTransparency = 1  
tabFrames[tab]=f  

b.MouseButton1Click:Connect(function()  
    for _,t in pairs(tabFrames) do t.Visible=false end  
    f.Visible=true  
    for _,bb in pairs(btns) do bb.BackgroundColor3=Color3.fromRGB(40,30,70) end  
    b.BackgroundColor3=Color3.fromRGB(60,120,80)  
end)

end

-- Dragging (universal/mobile friendly)
frm.Active = true
frm.Selectable = true
local dragging = false
local dragStart, frameStart
frm.InputBegan:Connect(function(input)
if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
dragging = true
dragStart = input.Position
frameStart = frm.Position
input.Changed:Connect(function()
if input.UserInputState == Enum.UserInputState.End then dragging = false end
end)
end
end)
frm.InputChanged:Connect(function(input)
if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
local delta = input.Position - dragStart
frm.Position = UDim2.new(frameStart.X.Scale, frameStart.X.Offset + delta.X, frameStart.Y.Scale, frameStart.Y.Offset + delta.Y)
end
end)

local featureVars = {}

-- Toggle maker (for feature switches)
local function makeToggle(parent, txt, ypos, name, onFunc, offFunc)
local box = Instance.new("Frame")
box.Parent = parent
box.Size = UDim2.new(1,-16,0,46)
box.Position = UDim2.new(0,8,0,ypos)
box.BackgroundColor3 = Color3.fromRGB(31,34,48)
local bc = Instance.new("UICorner", box)
bc.CornerRadius = UDim.new(0,11)
local lbl = Instance.new("TextLabel", box)
lbl.Size = UDim2.new(0.55,0,1,0)
lbl.Position = UDim2.new(0,12,0,0)
lbl.Text = txt
lbl.Font = Enum.Font.GothamSemibold
lbl.TextSize = 15
lbl.TextColor3 = Color3.fromRGB(220,220,240)
lbl.BackgroundTransparency = 1
lbl.TextXAlignment = Enum.TextXAlignment.Left

local tog = Instance.new("TextButton", box)  
tog.Size = UDim2.new(0,32,0,20)  
tog.Position = UDim2.new(1,-44,0.5,-10)  
tog.BackgroundColor3 = Color3.fromRGB(60,90,140)  
tog.Text = ""  
local tc = Instance.new("UICorner", tog)  
tc.CornerRadius = UDim.new(0,9)  
featureVars[name]=false  

local function upd()  
    tog.BackgroundColor3 = featureVars[name] and Color3.fromRGB(30,220,70) or Color3.fromRGB(60,90,140)  
end  
tog.MouseButton1Click:Connect(function()  
    featureVars[name] = not featureVars[name]  
    if featureVars[name] and onFunc then onFunc() elseif not featureVars[name] and offFunc then offFunc() end  
    upd()  
end)  
upd()

end

-- === Features Implementation ===

-- Player tab toggles: Anti AFK, Infinite Jump, Auto Collect, Anti Ragdoll
local py=19
makeToggle(tabFrames.Player,"Anti AFK",py,"antiafk",function()
featureVars.antiafkActive = spawn(function()
while featureVars.antiafk do
pcall(function()
game:GetService("VirtualUser"):CaptureController()
game:GetService("VirtualUser"):ClickButton1(Vector2.new())
end)
wait(20)
end
end)
end,function()
featureVars.antiafk = false
end)
py=py+48
makeToggle(tabFrames.Player,"Infinite Jump (safe)",py,"infjump",function()
if featureVars._ijCon then return end
featureVars._ijCon = game:GetService("UserInputService").JumpRequest:Connect(function()
if featureVars.infjump and lp.Character and lp.Character:FindFirstChildOfClass("Humanoid") then
lp.Character:FindFirstChildOfClass("Humanoid"):ChangeState(Enum.HumanoidStateType.Jumping)
end
end)
end,function()
if featureVars._ijCon then featureVars._ijCon:Disconnect(); featureVars._ijCon = nil end
end)
py=py+48
makeToggle(tabFrames.Player,"Auto Collect (Money)",py,"autocollect",function()
featureVars.autocollectActive = spawn(function()
while featureVars.autocollect and lp.Character do
for _,drop in pairs(workspace:GetChildren()) do
if drop:IsA("Part") and drop.Name == "Money" then
drop.CFrame = lp.Character.HumanoidRootPart.CFrame
end
end
wait(0.7)
end
end)
end,function()
featureVars.autocollect = false
end)
py=py+48
makeToggle(tabFrames.Player,"Anti Ragdoll",py,"antiragdoll",function()
featureVars.antiragdollActive = spawn(function()
while featureVars.antiragdoll and lp.Character and lp.Character:FindFirstChildOfClass("Humanoid") do
local h = lp.Character:FindFirstChildOfClass("Humanoid")
h.PlatformStand = false
h.BreakJointsOnDeath = false
wait(0.8)
end
end)
end,function()
featureVars.antiragdoll = false
end)

-- ESP tab: simple toggles (no advanced/broken APIs)
local ey=19
makeToggle(tabFrames.ESP,"Player ESP (simple)",ey,"playeresp",function()
for _,p in pairs(game.Players:GetPlayers()) do
if p~=lp and p.Character and p.Character:FindFirstChild("HumanoidRootPart") and not p.Character.HumanoidRootPart:FindFirstChild("HeheTag") then
local tag = Instance.new("BillboardGui")
tag.Name = "HeheTag"
tag.Size = UDim2.new(0,100,0,34)
tag.AlwaysOnTop = true
tag.Adornee = p.Character.HumanoidRootPart
local tx = Instance.new("TextLabel", tag)
tx.Size = UDim2.new(1,0,1,0)
tx.BackgroundTransparency = 1
tx.Text = p.DisplayName or p.Name
tx.Font = Enum.Font.GothamBold
tx.TextSize = 16
tx.TextColor3 = Color3.fromRGB(70,206,130)
tag.Parent = p.Character.HumanoidRootPart
end
end
end,function()
for _,p in pairs(game.Players:GetPlayers()) do
if p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
local tag = p.Character.HumanoidRootPart:FindFirstChild("HeheTag")
if tag then tag:Destroy() end
end
end
end)
ey=ey+48
makeToggle(tabFrames.ESP,"Base ESP",ey,"baseesp",function()
for _,v in pairs(workspace:GetChildren()) do
if v:IsA("Model") and v.Name:lower():find("base") then
for _,bp in pairs(v:GetChildren()) do
if bp:IsA("BasePart") and not bp:FindFirstChild("HeheBaseTag") then
local tag = Instance.new("BillboardGui")
tag.Name = "HeheBaseTag"
tag.Size = UDim2.new(0,96,0,28)
tag.AlwaysOnTop = true
tag.Adornee = bp
local tx = Instance.new("TextLabel", tag)
tx.Size = UDim2.new(1,0,1,0)
tx.BackgroundTransparency = 1
tx.Text = "BASE: "..v.Name
tx.Font = Enum.Font.GothamBold
tx.TextSize = 13
tx.TextColor3 = Color3.fromRGB(255,200,0)
tag.Parent = bp
end
end
end
end
end,function()
for _,v in pairs(workspace:GetChildren()) do
if v:IsA("Model") and v.Name:lower():find("base") then
for _,bp in pairs(v:GetChildren()) do
if bp:IsA("BasePart") then
local tag = bp:FindFirstChild("HeheBaseTag")
if tag then tag:Destroy() end
end
end
end
end
end)

-- Misc tab: Show working notification
local my=19
makeToggle(tabFrames.Misc,"Auto Load (demo)",my,"autoload",function()
showNotif("Auto-load ON. Add your extras here!")
end)
my=my+48
makeToggle(tabFrames.Misc,"Say 'Hi' in Chat",my,"hichat",function()
game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer("Hehe Hub is working!","All")
end)

-- END: Expand with more safe features if you want.
