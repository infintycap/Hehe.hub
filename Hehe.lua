-- Hehe-hub UI framework for Steal a Brainrot and more
-- Universal executor/mobile/Delta safe
local lp = game:GetService("Players").LocalPlayer
local pg = lp:FindFirstChildOfClass("PlayerGui")
if not pg then return end
local sg = Instance.new("ScreenGui")
sg.Name = "HeheHub"
sg.Parent = pg

-- === Main Frame & Animated Border ===
local frm = Instance.new("Frame", sg)
frm.Size = UDim2.new(0, 410, 0, 380)
frm.Position = UDim2.new(0, 70, 0, 90)
frm.BackgroundColor3 = Color3.fromRGB(24, 32, 38)
frm.Visible = false
frm.Active = true
local frc = Instance.new("UICorner", frm)
frc.CornerRadius = UDim.new(0, 19)

local borderFrame = Instance.new("Frame", sg)
borderFrame.Size = frm.Size + UDim2.new(0,11,0,11)
borderFrame.Position = frm.Position - UDim2.new(0,5,0,5)
borderFrame.BackgroundTransparency = 1
borderFrame.ZIndex = frm.ZIndex + 3
borderFrame.Visible = false
local borderStroke = Instance.new("UIStroke", borderFrame)
borderStroke.Thickness = 5
borderStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
spawn(function()
local t = 0
while true do
t = t + 1
-- Circling red-green
local h = (math.sin(t/17)+1)/2*0.33 -- 0: red, ~0.33: green
borderStroke.Color = Color3.fromHSV(h,1,1)
wait(0.04)
end
end)
frm:GetPropertyChangedSignal("Position"):Connect(function()
borderFrame.Position = frm.Position - UDim2.new(0,5,0,5)
end)
frm:GetPropertyChangedSignal("Size"):Connect(function()
borderFrame.Size = frm.Size + UDim2.new(0,11,0,11)
end)

-- === Menu Bar ===
local topBar = Instance.new("Frame", frm)
topBar.Size = UDim2.new(1,0,0,33)
topBar.Position = UDim2.new(0,0,0,0)
topBar.BackgroundColor3 = Color3.fromRGB(28,36,48)
topBar.ZIndex = frm.ZIndex+2
local tbCor = Instance.new("UICorner", topBar)
tbCor.CornerRadius = UDim.new(0,16)
local titleLbl = Instance.new("TextLabel", topBar)
titleLbl.Size = UDim2.new(1,-55, 1,0)
titleLbl.Position = UDim2.new(0,18,0,0)
titleLbl.Text = "Hehe-hub"
titleLbl.Font = Enum.Font.GothamBold
titleLbl.TextSize = 22
titleLbl.TextColor3 = Color3.fromRGB(90,220,90)
titleLbl.BackgroundTransparency = 1
titleLbl.TextXAlignment = Enum.TextXAlignment.Left

local closeBtn = Instance.new("TextButton", topBar)
closeBtn.Size = UDim2.new(0,32,0,25)
closeBtn.Position = UDim2.new(1,-40,0.5,-12)
closeBtn.Text = "X"
closeBtn.TextColor3 = Color3.fromRGB(255,100,100)
closeBtn.TextSize = 21
closeBtn.Font = Enum.Font.GothamBold
closeBtn.BackgroundColor3 = Color3.fromRGB(70,23,23)
local closeCor = Instance.new("UICorner", closeBtn)
closeCor.CornerRadius = UDim.new(0,8)
closeBtn.MouseButton1Click:Connect(function()
frm.Visible = false
borderFrame.Visible = false
end)

-- === Hamburger Toggle Button ===
local tglBtn = Instance.new("TextButton", sg)
tglBtn.Size = UDim2.new(0,44,0,44)
tglBtn.Position = UDim2.new(0,14,0,38)
tglBtn.Text = "≡"
tglBtn.Font = Enum.Font.GothamBold
tglBtn.TextSize = 38
tglBtn.BackgroundColor3 = Color3.fromRGB(100,16,26)
tglBtn.TextColor3 = Color3.fromRGB(90,220,90)
local tc = Instance.new("UICorner", tglBtn)
tc.CornerRadius = UDim.new(0,14)
tglBtn.MouseButton1Click:Connect(function()
frm.Visible = not frm.Visible
borderFrame.Visible = frm.Visible
end)

-- === Sidebar ===
local sidebar = Instance.new("Frame", frm)
sidebar.Size = UDim2.new(0,92,1,-33)
sidebar.Position = UDim2.new(0,0,0,33)
sidebar.BackgroundColor3 = Color3.fromRGB(14,18,26)
local sdc = Instance.new("UICorner", sidebar)
sdc.CornerRadius = UDim.new(0,15)

local sectionNames = {"Main","Stealer","Helper","Player","Finder","Server","Discord"}
local sectionFrames, btns = {}, {}
for i,sec in ipairs(sectionNames) do
local b = Instance.new("TextButton")
b.Parent = sidebar
b.Size = UDim2.new(1,-12,0,31)
b.Position = UDim2.new(0,6,0,(i-1)39+17)
b.Text = sec
b.Font = Enum.Font.GothamSemibold
b.TextSize = 15
b.BackgroundColor3 = Color3.fromRGB(44+(i22)%90,30,60+(i*26))
b.TextColor3 = Color3.fromRGB(140,220,255)
local bc = Instance.new("UICorner", b)
bc.CornerRadius = UDim.new(0,8)
btns[sec] = b

local f = Instance.new("Frame")  
f.Parent = frm  
f.Size = UDim2.new(1,-100,1,-55)  
f.Position = UDim2.new(0,100,0,45)  
f.Visible = (i==1)  
f.BackgroundTransparency = 0  
f.BackgroundColor3 = Color3.fromRGB(34,38,60)  
local fc = Instance.new("UICorner", f)  
fc.CornerRadius = UDim.new(0,14)  
sectionFrames[sec]=f  

b.MouseButton1Click:Connect(function()  
    for _,t in pairs(sectionFrames) do t.Visible=false end  
    f.Visible=true  
    for _,bb in pairs(btns) do bb.BackgroundColor3=Color3.fromRGB(44,30,60) end  
    b.BackgroundColor3=Color3.fromRGB(66,99,54)  
end)

end

-- === Universal Toggle Creator ===
local function makeToggle(parent,txt,ypos,name,funcOn,funcOff)
local tgFrame = Instance.new("Frame",parent)
tgFrame.Size = UDim2.new(0.88,0,0,34)
tgFrame.Position = UDim2.new(0,18,0,ypos)
tgFrame.BackgroundColor3 = Color3.fromRGB(48,50,68)
local tgc = Instance.new("UICorner", tgFrame)
tgc.CornerRadius = UDim.new(0,9)
local lbl = Instance.new("TextLabel", tgFrame)
lbl.Size = UDim2.new(0.7,0,1,0)
lbl.Position = UDim2.new(0,8,0,0)
lbl.Text = txt
lbl.Font = Enum.Font.GothamSemibold
lbl.TextSize = 13
lbl.TextColor3 = Color3.fromRGB(240,240,245)
lbl.BackgroundTransparency = 1
lbl.TextXAlignment = Enum.TextXAlignment.Left
local tbtn = Instance.new("TextButton", tgFrame)
tbtn.Size = UDim2.new(0,30,0,18)
tbtn.Position = UDim2.new(1,-44,0.5,-9)
tbtn.BackgroundColor3 = Color3.fromRGB(60,90,140)
tbtn.Text = ""
local tc = Instance.new("UICorner", tbtn)
tc.CornerRadius = UDim.new(0,8)
local toggled=false
local function update() tbtn.BackgroundColor3 = toggled and Color3.fromRGB(30,220,70) or Color3.fromRGB(60,90,140) end
tbtn.MouseButton1Click:Connect(function()
toggled = not toggled
update()
if toggled and funcOn then funcOn() end
if not toggled and funcOff then funcOff() end
end)
update()
end

-- === Main Section Toggles ===
local mainFrame = sectionFrames["Main"]
local y = 18
makeToggle(mainFrame,"Anti AFK",y,"antiafk",function()
spawn(function()
while true do
pcall(function()
game:GetService("VirtualUser"):CaptureController()
game:GetService("VirtualUser"):ClickButton1(Vector2.new())
end)
wait(16)
end
end)
end)
y = y+36
makeToggle(mainFrame,"Auto Lock Base",y,"autolockbase",function() end)
y = y+36
makeToggle(mainFrame,"Auto Collect",y,"autocollect",function() end)

-- === Stealer Section Toggles ===
local stFrame = sectionFrames["Stealer"]
local sy = 18
makeToggle(stFrame,"Steal Upstairs",sy,"stealupstairs",function() end)
sy = sy+36
makeToggle(stFrame,"Desync",sy,"desync",function() end)
sy = sy+36
makeToggle(stFrame,"Auto Destroy Turret",sy,"destroyturret",function() end)
sy = sy+36
makeToggle(stFrame,"Auto Steal Turret",sy,"autostealturret",function() end)
sy = sy+36
makeToggle(stFrame,"Auto Steal Best Brainrot",sy,"autostealbest",function() end)
sy = sy+36
makeToggle(stFrame,"Best Brainrot Only for Auto Steal",sy,"onlybestautosteal",function() end)
sy = sy+36
makeToggle(stFrame,"Steal Nearest",sy,"stealnearest",function() end)
sy = sy+36
makeToggle(stFrame,"Auto Kick on Steal",sy,"autokickonsteal",function() end)

-- === Helper Section Toggles ===
local hFrame = sectionFrames["Helper"]
local hy = 18
makeToggle(hFrame,"X-ray",hy,"xray",function() end)
hy = hy+36
makeToggle(hFrame,"Your Base ESP",hy,"baseesp",function() end)
hy = hy+36
makeToggle(hFrame,"Highest Value Brainrot ESP",hy,"valueesp",function() end)
hy = hy+36
makeToggle(hFrame,"Timer ESP All Bases",hy,"timeresp",function() end)
hy = hy+36
makeToggle(hFrame,"Player ESP",hy,"playeresp",function() end)

-- === Player Section Toggles ===
local plyFrame = sectionFrames["Player"]
local py = 18
makeToggle(plyFrame,"Infinite Jump",py,"infjump",
function()
if plyFrame._ijCon then return end
plyFrame._ijCon = game:GetService("UserInputService").JumpRequest:Connect(function()
if plyFrame._ijOn and lp.Character and lp.Character:FindFirstChildOfClass("Humanoid") then
lp.Character:FindFirstChildOfClass("Humanoid"):ChangeState(Enum.HumanoidStateType.Jumping)
end
end)
plyFrame._ijOn = true
end,
function()
plyFrame._ijOn = false
if plyFrame._ijCon then plyFrame._ijCon:Disconnect(); plyFrame._ijCon=nil end
end
)
py = py+36
makeToggle(plyFrame,"Speed Boost UI",py,"speedboost",function() end)
py = py+36
makeToggle(plyFrame,"Anti Ragdoll",py,"antiragdoll",function()
spawn(function()
while true do
if lp.Character and lp.Character:FindFirstChildOfClass("Humanoid") then
local h = lp.Character:FindFirstChildOfClass("Humanoid")
h.PlatformStand = false; h.BreakJointsOnDeath = false
end
wait(0.9)
end
end)
end)

-- === Server Section Toggles ===
local svFrame = sectionFrames["Server"]
local svy = 18
makeToggle(svFrame,"Auto Server Hop",svy,"serverhop",function() end)

-- === Discord Section ===
local dsFrame = sectionFrames["Discord"]
local dsLbl = Instance.new("TextLabel", dsFrame)
dsLbl.Size = UDim2.new(1,0,1,-14)
dsLbl.Position = UDim2.new(0,0,0,7)
dsLbl.BackgroundTransparency = 1
dsLbl.Text = "My Discord link: coming soon!"
dsLbl.Font = Enum.Font.GothamBold
dsLbl.TextSize = 18
dsLbl.TextColor3 = Color3.fromRGB(90,220,90)
dsLbl.TextXAlignment = Enum.TextXAlignment.Center

-- === Dragging support ===
frm.InputBegan:Connect(function(input)
if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
local dragPos = input.Position
local framePos = frm.Position
local dragging = true
input.Changed:Connect(function()
if input.UserInputState == Enum.UserInputState.End then dragging = false end
end)
frm.InputChanged:Connect(function(inp)
if dragging and (inp.UserInputType == Enum.UserInputType.MouseMovement or inp.UserInputType == Enum.UserInputType.Touch) then
local delta = inp.Position - dragPos
frm.Position = UDim2.new(framePos.X.Scale, framePos.X.Offset+delta.X, framePos.Y.Scale, framePos.Y.Offset+delta.Y)
borderFrame.Position = frm.Position - UDim2.new(0,5,0,5)
end
end)
end
end)
