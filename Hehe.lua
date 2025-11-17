-- Hehe Hub: Universal Executor-compatible Script
-- Sidebar, Draggable, Toggle, Animated Border, All Features, Mobile/PC Compatible

local lp = game:GetService("Players").LocalPlayer
local sg
-- Robust GUI parenting for any executor/platform
pcall(function()
sg = Instance.new("ScreenGui")
sg.Name = "HeheHub"
sg.IgnoreGuiInset = true
sg.ResetOnSpawn = false
sg.Parent = lp:FindFirstChild("PlayerGui") or game:GetService("CoreGui") or game:GetService("StarterGui")
end)

-- Notify loaded (works everywhere!)
pcall(function()
game.StarterGui:SetCore("SendNotification", {Title="Hehe Hub", Text="Loaded!", Duration=5})
end)

-- Toggle button
local tgl = Instance.new("TextButton", sg)
tgl.Size = UDim2.new(0,50,0,50)
tgl.Position = UDim2.new(0,12,0,48)
tgl.Text = "≡"
tgl.Font = Enum.Font.GothamBold
tgl.TextSize = 38
tgl.BackgroundColor3 = Color3.fromRGB(99,23,23)
tgl.TextColor3 = Color3.fromRGB(90,220,90)
local tc = Instance.new("UICorner", tgl)
tc.CornerRadius = UDim.new(0,10)

-- Main frame
local frm = Instance.new("Frame", sg)
frm.Size = UDim2.new(0,370,0,392)
frm.Position = UDim2.new(0,70,0,58)
frm.BackgroundColor3 = Color3.fromRGB(20,26,40)
frm.Visible = false
frm.ZIndex = 10
local frc = Instance.new("UICorner", frm)
frc.CornerRadius = UDim.new(0,22)

-- Animated border ("GIF effect")
local bd = Instance.new("Frame", sg)
bd.Size = frm.Size + UDim2.new(0,8,0,8)
bd.Position = frm.Position - UDim2.new(0,4,0,4)
bd.BackgroundTransparency = 1
bd.ZIndex = frm.ZIndex + 1
bd.Visible = false
local bdt = Instance.new("UIStroke", bd)
bdt.Thickness = 7
spawn(function()
local h=0
while true do
h = (h+3)%360
bdt.Color = Color3.fromHSV(h/360,1,1)
wait(0.03)
end
end)
frm:GetPropertyChangedSignal("Position"):Connect(function()
bd.Position = frm.Position - UDim2.new(0,4,0,4)
end)
frm:GetPropertyChangedSignal("Size"):Connect(function()
bd.Size = frm.Size + UDim2.new(0,8,0,8)
end)

-- Toggle button logic
tgl.MouseButton1Click:Connect(function()
frm.Visible = not frm.Visible
bd.Visible = frm.Visible
end)

-- Sidebar tabs
local sidebar = Instance.new("Frame", frm)
sidebar.Size = UDim2.new(0,92,1,0)
sidebar.Position = UDim2.new(0,0,0,0)
sidebar.BackgroundColor3 = Color3.fromRGB(13,16,25)
local sdc = Instance.new("UICorner", sidebar)
sdc.CornerRadius = UDim.new(0,15)

local tabNames = {'Player', 'Base/ESP', 'Misc'}
local tabFrames, btns = {}, {}
for i,tab in ipairs(tabNames) do
local b = Instance.new("TextButton", sidebar)
b.Size = UDim2.new(1,-12,0,38)
b.Position = UDim2.new(0,6,0,(i-1)48+24)
b.Text = tab
b.Font = Enum.Font.GothamSemibold
b.TextSize = 16
b.BackgroundColor3 = Color3.fromRGB(40+(i50)%180,30,55+(i*30))
b.TextColor3 = Color3.fromRGB(150,220,255)
local bc = Instance.new("UICorner", b)
bc.CornerRadius = UDim.new(0,8)
btns[tab] = b

local f = Instance.new("Frame", frm)  
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

-- Drag (universal style for desktop/mobile)
frm.Active=true
local dragging=false
local dragStart,frameStart
frm.InputBegan:Connect(function(input)
if input.UserInputType==Enum.UserInputType.MouseButton1 then
dragging=true
dragStart = input.Position
frameStart = frm.Position
input.Changed:Connect(function()
if input.UserInputState==Enum.UserInputState.End then dragging=false end
end)
end
end)
frm.InputChanged:Connect(function(input)
if dragging and (input.UserInputType==Enum.UserInputType.MouseMovement or input.UserInputType==Enum.UserInputType.Touch) then
local d = input.Position-dragStart
frm.Position = UDim2.new(frameStart.X.Scale, frameStart.X.Offset+d.X, frameStart.Y.Scale, frameStart.Y.Offset+d.Y)
bd.Position = frm.Position-UDim2.new(0,4,0,4)
end
end)

-- === Universal toggles helper ===
local featureVars = {}
local function makeToggle(parent, txt, ypos, name, onFunc, offFunc)
local box = Instance.new("Frame", parent)
box.Size = UDim2.new(1,-16,0,46)
box.Position = UDim2.new(0,8,0,ypos)
box.BackgroundColor3 = Color3.fromRGB(31,34,48)
local bc = Instance.new("UICorner", box)
bc.CornerRadius = UDim.new(0,12)
local lbl = Instance.new("TextLabel", box)
lbl.Size = UDim2.new(0.55,0,1,0)
lbl.Position = UDim2.new(0,10,0,0)
lbl.Text = txt
lbl.Font = Enum.Font.GothamSemibold
lbl.TextSize = 15
lbl.TextColor3 = Color3.fromRGB(220,220,240)
lbl.BackgroundTransparency =1
lbl.TextXAlignment=Enum.TextXAlignment.Left

local tog = Instance.new("TextButton", box)  
tog.Size=UDim2.new(0,32,0,20)  
tog.Position=UDim2.new(1,-42,0.5,-10)  
tog.BackgroundColor3=Color3.fromRGB(60,90,140)  
tog.Text=""  
local tc=Instance.new("UICorner", tog)  
tc.CornerRadius=UDim.new(0,9)  
featureVars[name]=false  

local function upd()  
    tog.BackgroundColor3 = featureVars[name] and Color3.fromRGB(30,220,70) or Color3.fromRGB(60,90,140)  
end  
tog.MouseButton1Click:Connect(function()  
    featureVars[name]=not featureVars[name]  
    if featureVars[name] and onFunc then onFunc() elseif not featureVars[name] and offFunc then offFunc() end  
    upd()  
end)  
upd()  
return function() return featureVars[name] end

end

-- === Features Implementation ===
-- Safe anti-afk (works everywhere!)
local py=18
makeToggle(tabFrames.Player,"Anti AFK",py,"antiafk",function()
spawn(function()
while featureVars.antiafk do
pcall(function()
game:GetService("VirtualUser"):CaptureController()
game:GetService("VirtualUser"):ClickButton1(Vector2.new())
end)
wait(20)
end
end)
end)
py=py+54
makeToggle(tabFrames.Player,"Infinite Jump (safe)",py,"infjump",function()
game:GetService("UserInputService").JumpRequest:Connect(function()
if featureVars.infjump and lp.Character and lp.Character:FindFirstChildOfClass("Humanoid") then
local h=lp.Character:FindFirstChildOfClass("Humanoid")
h:ChangeState(Enum.HumanoidStateType.Jumping)
end
end)
end)
py=py+54
makeToggle(tabFrames.Player,"Auto Collect",py,"autocollect",function()
spawn(function()
while featureVars.autocollect and lp.Character do
for _,drop in pairs(workspace:GetChildren()) do
if drop:IsA("Part") and drop.Name == "Money" then
drop.CFrame=lp.Character.HumanoidRootPart.CFrame
end
end
wait(0.6)
end
end)
end)
py=py+54
makeToggle(tabFrames.Player,"Anti Ragdoll",py,"antiragdoll",function()
spawn(function()
while featureVars.antiragdoll and lp.Character and lp.Character:FindFirstChildOfClass("Humanoid") do
lp.Character:FindFirstChildOfClass("Humanoid").PlatformStand=false
lp.Character:FindFirstChildOfClass("Humanoid").BreakJointsOnDeath=false
wait(0.8)
end
end)
end)

-- ESP tab toggles
local ey=18
makeToggle(tabFrames["Base/ESP"],"Player ESP",ey,"playeresp",function()
for _,p in pairs(game.Players:GetPlayers()) do
if p~=lp and p.Character and p.Character:FindFirstChild("HumanoidRootPart") and not p.Character.HumanoidRootPart:FindFirstChild("HeheTag") then
local tag=Instance.new("BillboardGui")
tag.Name="HeheTag" tag.Size=UDim2.new(0,100,0,34) tag.AlwaysOnTop=true
tag.Adornee=p.Character.HumanoidRootPart
local tx=Instance.new("TextLabel",tag)
tx.Size=UDim2.new(1,0,1,0) tx.BackgroundTransparency=1 tx.Text=p.DisplayName or p.Name
tx.Font=Enum.Font.GothamBold tx.TextSize=16 tx.TextColor3=Color3.fromRGB(70,206,130)
tag.Parent=p.Character.HumanoidRootPart
end
end
end,function()
for _,p in pairs(game.Players:GetPlayers()) do
if p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
local tag=p.Character.HumanoidRootPart:FindFirstChild("HeheTag") if tag then tag:Destroy() end
end
end
end)
ey=ey+54
makeToggle(tabFrames["Base/ESP"],"Base ESP",ey,"baseesp",function()
for _,v in pairs(workspace:GetChildren()) do
if v:IsA("Model") and v.Name:lower():find("base") then
for _,bp in pairs(v:GetChildren()) do
if bp:IsA("BasePart") and not bp:FindFirstChild("HeheBaseTag") then
local tag=Instance.new("BillboardGui")
tag.Name="HeheBaseTag" tag.Size=UDim2.new(0,100,0,32) tag.AlwaysOnTop=true
tag.Adornee=bp
local tx=Instance.new("TextLabel",tag)
tx.Size=UDim2.new(1,0,1,0) tx.BackgroundTransparency=1 tx.Text="BASE: "..v.Name
tx.Font=Enum.Font.GothamBold tx.TextSize=13 tx.TextColor3=Color3.fromRGB(255,200,0)
tag.Parent=bp
end
end
end
end
end,function()
for _,v in pairs(workspace:GetChildren()) do
if v:IsA("Model") and v.Name:lower():find("base") then
for _,bp in pairs(v:GetChildren()) do
if bp:IsA("BasePart") then local tag=bp:FindFirstChild("HeheBaseTag") if tag then tag:Destroy() end end
end
end
end
end)
ey=ey+54
makeToggle(tabFrames["Base/ESP"],"Best Brainrot ESP",ey,"bestesp",function()
local best=nil;local maxval=0
for _,v in pairs(workspace:GetChildren()) do
if v:IsA("Model") and v.Name:lower():find("base") then
local val = v:FindFirstChild("Value") or v:FindFirstChildWhichIsA("NumberValue") or v:FindFirstChildWhichIsA("IntValue")
if val and val.Value>maxval then best=v;maxval=val.Value end
end
end
if best then
for _,bp in pairs(best:GetChildren()) do
if bp:IsA("BasePart") and not bp:FindFirstChild("HeheBestTag") then
local tag=Instance.new("BillboardGui")
tag.Name="HeheBestTag" tag.Size=UDim2.new(0,110,0,30) tag.AlwaysOnTop=true tag.Adornee=bp
local tx=Instance.new("TextLabel",tag)
tx.Size=UDim2.new(1,0,1,0) tx.BackgroundTransparency=1 tx.Text="BEST BASE ("..maxval..")"
tx.Font=Enum.Font.GothamBold tx.TextSize=13 tx.TextColor3=Color3.fromRGB(255,60,60)
tag.Parent=bp
end
end
end
end,function() -- cleanup
for _,v in pairs(workspace:GetChildren()) do
if v:IsA("Model") and v.Name:lower():find("base") then
for _,bp in pairs(v:GetChildren()) do
if bp:IsA("BasePart") then local tag=bp:FindFirstChild("HeheBestTag") if tag then tag:Destroy() end end
end
end
end
end)

-- Misc tab: sample toggle
local my=18
makeToggle(tabFrames.Misc,"Auto Load Script (demo)",my,"autoload",function()
print("Auto-load is On; add script here!")
end)
my=my+54
makeToggle(tabFrames.Misc,"Animated Border On/Off",my,"borderon",function() bd.Visible=true end,function() bd.Visible=false end)

-- End file
