-- Hehe-hub for Steal a Brainrot
-- Special features for InfinityCap, universal for all!

local specialUser = "infinitycap" -- your username

local lp = game:GetService("Players").LocalPlayer
local pg = lp:FindFirstChildOfClass("PlayerGui")
if not pg then return end
local sg = Instance.new("ScreenGui")
sg.Name = "HeheHub"
sg.Parent = pg

local btn = Instance.new("TextButton", sg)
btn.Size = UDim2.new(0,50,0,44)
btn.Position = UDim2.new(0,12,0,63)
btn.Text = "≡"
btn.BackgroundColor3 = Color3.fromRGB(100,16,26)
btn.TextColor3 = Color3.fromRGB(90,220,90)
btn.Font = Enum.Font.GothamBold
btn.TextSize = 38

local frm = Instance.new("Frame", sg)
frm.Size = UDim2.new(0,320,0,190)
frm.Position = UDim2.new(0,62,0,100)
frm.BackgroundColor3 = Color3.fromRGB(24,32,38)
frm.Visible = false
local uicorner = Instance.new("UICorner", frm)
uicorner.CornerRadius = UDim.new(0, 18)

btn.MouseButton1Click:Connect(function() frm.Visible = not frm.Visible end)

local title = Instance.new("TextLabel", frm)
title.Size = UDim2.new(1,0,0,32)
title.Position = UDim2.new(0,0,0,0)
title.BackgroundTransparency = 1
title.Text = "Hehe-hub"
title.Font = Enum.Font.GothamBold
title.TextSize = 22
title.TextColor3 = Color3.fromRGB(90,220,90)
title.TextXAlignment = Enum.TextXAlignment.Left

local closeBtn = Instance.new("TextButton", frm)
closeBtn.Size = UDim2.new(0,32,0,25)
closeBtn.Position = UDim2.new(1,-40,0,3)
closeBtn.Text = "X"
closeBtn.TextColor3 = Color3.fromRGB(255,100,100)
closeBtn.TextSize = 20
closeBtn.Font = Enum.Font.GothamBold
closeBtn.BackgroundColor3 = Color3.fromRGB(70,23,23)
closeBtn.MouseButton1Click:Connect(function() frm.Visible=false end)

-- Simple tab buttons for organization
local tabs = {"Main","Stealer","Helper","Player","Server","Discord"}
local tabframes = {}
for i,txt in ipairs(tabs) do
local b = Instance.new("TextButton", frm)
b.Size = UDim2.new(0,62,0,21)
b.Position = UDim2.new(0,12,0,38+(i-1)26)
b.Text = txt
b.Font = Enum.Font.GothamSemibold
b.TextSize = 13
b.BackgroundColor3 = Color3.fromRGB(44+(i22)%90,30,60+(i*26))
b.TextColor3 = Color3.fromRGB(140,220,255)
tabframes[txt] = Instance.new("Frame", frm)
tabframes[txt].Size = UDim2.new(0,190,0,102)
tabframes[txt].Position = UDim2.new(0,98,0,44)
tabframes[txt].BackgroundColor3 = Color3.fromRGB(34,38,60)
local fc = Instance.new("UICorner", tabframes[txt]) fc.CornerRadius = UDim.new(0,12)
tabframes[txt].Visible = i==1
b.MouseButton1Click:Connect(function()
for _,fr in pairs(tabframes) do fr.Visible=false end
tabframes[txt].Visible=true
end)
end

-- Universal simple toggle function
local function makeToggle(parent,txt,pos,onf,offf)
local t = Instance.new("TextButton", parent)
t.Size = UDim2.new(0,160,0,22)
t.Position = UDim2.new(0,13,0,pos)
t.Text = txt.." [OFF]"
t.BackgroundColor3 = Color3.fromRGB(48,50,68)
local ts = false
t.MouseButton1Click:Connect(function()
ts = not ts
t.Text = txt..(ts and " [ON]" or " [OFF]")
if ts and onf then onf() end
if not ts and offf then offf() end
end)
end

-- === Main tab: Anti AFK
makeToggle(tabframes["Main"],"Anti AFK",11,function()
if tabframes["Main"]._afk then return end
tabframes["Main"]._afk=true
tabframes["Main"]._afkConn=game:GetService("RunService").Heartbeat:Connect(function()
pcall(function()
game:GetService("VirtualUser"):CaptureController()
game:GetService("VirtualUser"):ClickButton1(Vector2.new())
end)
end)
end,function()
if tabframes["Main"]._afkConn then tabframes["Main"]._afkConn:Disconnect(); tabframes["Main"]._afkConn=nil end
tabframes["Main"]._afk=false
end)

makeToggle(tabframes["Main"],"Auto Lock Base",36,function()
-- Example template, SABR needs real RemoteEvent!
local rem = game:GetService("ReplicatedStorage"):FindFirstChild("LockBase")
if rem then rem:FireServer() end
end)

makeToggle(tabframes["Main"],"Auto Collect",61,function()
-- Example: Tele "money" to you
for _,v in pairs(workspace:GetChildren()) do
if v:IsA("Part") and v.Name:lower():find("money") then
v.CFrame = lp.Character and lp.Character:FindFirstChild("HumanoidRootPart") and lp.Character.HumanoidRootPart.CFrame or v.CFrame
end
end
end)

-- === Stealer tab (examples)
makeToggle(tabframes["Stealer"],"Steal Upstairs",11,function()
-- Tele you up - template
if lp.Character and lp.Character:FindFirstChild("HumanoidRootPart") then
lp.Character.HumanoidRootPart.CFrame = CFrame.new(0,150,0)
end
end)
makeToggle(tabframes["Stealer"],"Desync",36,function()
if lp.Character and lp.Character:FindFirstChildOfClass("Humanoid") then
lp.Character.HumanoidRootPart.Anchored = true
wait(1)
lp.Character.HumanoidRootPart.Anchored = false
end
end)
makeToggle(tabframes["Stealer"],"Auto Destroy Turret",61,function()
for _,t in pairs(workspace:GetChildren()) do
if t.Name:lower():find("turret") then t:Destroy() end
end
end)

-- === Helper tab: ESP (universal + user-specific)
makeToggle(tabframes["Helper"],"Your Base ESP",11,function()
-- Highlights only YOUR base if your user is InfinityCap
for _,b in pairs(workspace:GetChildren()) do
if b:IsA("BasePart") and b.Name:lower():find(specialUser:lower()) then
b.BrickColor = BrickColor.new("Bright green")
end
end
end,function()
for _,b in pairs(workspace:GetChildren()) do
if b.BrickColor == BrickColor.new("Bright green") then b.BrickColor = BrickColor.new("Medium stone grey") end
end
end)

makeToggle(tabframes["Helper"],"Player ESP (Billboard)",36,function()
local Pls = game:GetService("Players")
for _,p in pairs(Pls:GetPlayers()) do
if p~=lp and p.Character and p.Character:FindFirstChild("HumanoidRootPart")
and not p.Character.HumanoidRootPart:FindFirstChild("NameESP") then
local g = Instance.new("BillboardGui")
g.Name = "NameESP"
g.Size = UDim2.new(0,100,0,30)
g.AlwaysOnTop = true
g.Adornee = p.Character.HumanoidRootPart
g.Parent = p.Character.HumanoidRootPart
local lbl = Instance.new("TextLabel",g)
lbl.Size = UDim2.new(1,0,1,0)
lbl.BackgroundTransparency = 1
lbl.Text = p.DisplayName or p.Name
lbl.Font = Enum.Font.GothamBold
lbl.TextSize = 16
lbl.TextColor3 = Color3.fromRGB(70,206,130)
lbl.TextStrokeTransparency = 0.5
end
end
end,function()
local Pls = game:GetService("Players")
for _,p in pairs(Pls:GetPlayers()) do
if p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
local g = p.Character.HumanoidRootPart:FindFirstChild("NameESP")
if g then g:Destroy() end
end
end
end)

-- === Player tab: Infinite jump, speed boost
makeToggle(tabframes["Player"],"Infinite Jump",11,function()
if tabframes["Player"]._ij then return end
tabframes["Player"]._ij = game:GetService("UserInputService").JumpRequest:Connect(function()
if lp.Character and lp.Character:FindFirstChildOfClass("Humanoid") then
lp.Character:FindFirstChildOfClass("Humanoid"):ChangeState(Enum.HumanoidStateType.Jumping)
end
end)
end,function()
if tabframes["Player"]._ij then tabframes["Player"]._ij:Disconnect(); tabframes["Player"]._ij=nil end
end)

makeToggle(tabframes["Player"],"Speed Boost",36,function()
if lp.Character and lp.Character:FindFirstChild("Humanoid") then lp.Character.Humanoid.WalkSpeed = 40 end
end, function()
if lp.Character and lp.Character:FindFirstChild("Humanoid") then lp.Character.Humanoid.WalkSpeed = 16 end
end)

-- === Server tab: Server hop
makeToggle(tabframes["Server"],"Auto Server Hop",11,function()
local r = game:GetService("TeleportService")
r:Teleport(game.PlaceId)
end)

-- === Discord tab: text
local ds = Instance.new("TextLabel",tabframes["Discord"])
ds.Size = UDim2.new(1,0,1,0)
ds.Position = UDim2.new(0,0,0,0)
ds.BackgroundTransparency = 1
ds.Text = "Discord: coming soon!"
ds.Font = Enum.Font.GothamBold
ds.TextSize = 18
ds.TextColor3 = Color3.fromRGB(90,220,90)
ds.TextXAlignment = Enum.TextXAlignment.Center
