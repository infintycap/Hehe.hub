-- Hehe Hub - Fully functional toggle hack example for Steal a Brainrot

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "HeheHubUI"
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.IgnoreGuiInset = true

local FRAME_W, FRAME_H = 600, 370
local SIDEBAR_W = 115

local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, FRAME_W, 0, FRAME_H)
mainFrame.Position = UDim2.new(0.5, -FRAME_W/2, 0.5, -FRAME_H/2)
mainFrame.BackgroundColor3 = Color3.fromRGB(32,34,38)
mainFrame.BorderSizePixel = 0
mainFrame.Parent = ScreenGui
mainFrame.Active = true
mainFrame.Draggable = true

local frameCorner = Instance.new("UICorner")
frameCorner.CornerRadius = UDim.new(0, 12)
frameCorner.Parent = mainFrame

-- Title Bar
local titleBar = Instance.new("Frame")
titleBar.Parent = mainFrame
titleBar.Size = UDim2.new(1,0,0,34)
titleBar.Position = UDim2.new(0,0,0,0)
titleBar.BackgroundColor3 = Color3.fromRGB(24,26,30)
titleBar.BorderSizePixel = 0
local titleCorner = Instance.new("UICorner")
titleCorner.CornerRadius = UDim.new(0,12)
titleCorner.Parent = titleBar

local titleLabel = Instance.new("TextLabel")
titleLabel.Name = "Title"
titleLabel.Parent = titleBar
titleLabel.Size = UDim2.new(1,0,1,0)
titleLabel.Position = UDim2.new(0,0,0,0)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "Hehe Hub"
titleLabel.Font = Enum.Font.GothamBold
titleLabel.TextSize = 22
titleLabel.TextColor3 = Color3.fromRGB(194,194,236)

-- Sidebar Tabs
local tabNames = {"Main", "Stealer", "Helper", "Player", "Finder", "Server", "Discord"}
local sidebarButtons = {}
local sidebarFrame = Instance.new("Frame")
sidebarFrame.Parent = mainFrame
sidebarFrame.Size = UDim2.new(0, SIDEBAR_W, 1, -34)
sidebarFrame.Position = UDim2.new(0,0,0,34)
sidebarFrame.BackgroundColor3 = Color3.fromRGB(27,29,33)
sidebarFrame.BorderSizePixel = 0
local sidebarCorner = Instance.new("UICorner")
sidebarCorner.CornerRadius = UDim.new(0,12)
sidebarCorner.Parent = sidebarFrame

local tabContents = {}
for i,name in ipairs(tabNames) do
local btn = Instance.new("TextButton")
btn.Parent = sidebarFrame
btn.Size = UDim2.new(1,-24,0,34)
btn.Position = UDim2.new(0,12,0,(i-1)*42+12)
btn.BackgroundColor3 = i==1 and Color3.fromRGB(40,43,54) or Color3.fromRGB(27,29,33)
btn.Text = name
btn.TextColor3 = i==1 and Color3.fromRGB(188,200,255) or Color3.fromRGB(115,120,150)
btn.Font = Enum.Font.GothamBold
btn.TextSize = 19
btn.Name = "Sidebar_"..name
local btnCorner = Instance.new("UICorner")
btnCorner.CornerRadius = UDim.new(0, 9)
btnCorner.Parent = btn
sidebarButtons[name] = btn

local content = Instance.new("Frame")  
content.Parent = mainFrame  
content.Size = UDim2.new(0, FRAME_W-SIDEBAR_W-24, 1,-60)  
content.Position = UDim2.new(0, SIDEBAR_W+12, 0, 48)  
content.BackgroundTransparency = 1  
content.Visible = (i==1) -- Only first tab visible by default  
tabContents[name] = content

end

-- Sidebar tab switching logic
for thisName,thisBtn in pairs(sidebarButtons) do
thisBtn.MouseButton1Click:Connect(function()
for tab,content in pairs(tabContents) do
content.Visible = (tab == thisName)
sidebarButtons[tab].BackgroundColor3 = tab==thisName and Color3.fromRGB(40,43,54) or Color3.fromRGB(27,29,33)
sidebarButtons[tab].TextColor3 = tab==thisName and Color3.fromRGB(188,200,255) or Color3.fromRGB(115,120,150)
end
end)
end


---

-- Helper: Add robust toggle function

function addToggle(parent, yOffset, txt, state, callback)
local btn = Instance.new("TextButton")
btn.Parent = parent
btn.Size = UDim2.new(0.44,0,0,26)
btn.Position = UDim2.new(0,0,0,yOffset)
btn.Text = txt
btn.BackgroundColor3 = Color3.fromRGB(44,48,58)
btn.Font = Enum.Font.GothamBold
btn.TextSize = 17
btn.TextColor3 = Color3.fromRGB(160,170,255)
local btnUICorner = Instance.new("UICorner")
btnUICorner.CornerRadius = UDim.new(0,7)
btnUICorner.Parent = btn

local toggleCircle = Instance.new("Frame")  
toggleCircle.Parent = btn  
toggleCircle.Size = UDim2.new(0,28,0,16)  
toggleCircle.Position = UDim2.new(1,-32,0.5,-8)  
toggleCircle.BackgroundColor3 = Color3.fromRGB(64,70,110)  
local togUIC = Instance.new("UICorner")  
togUIC.CornerRadius = UDim.new(0,8)  
togUIC.Parent = toggleCircle  

local isOn = state  
local innerDot = Instance.new("Frame")  
innerDot.Parent = toggleCircle  
innerDot.Size = UDim2.new(0.55,0,0.9,0)  
innerDot.Position = UDim2.new(isOn and 0.45 or 0.05,0,0.05,0)  
innerDot.BackgroundColor3 = isOn and Color3.fromRGB(70,206,130) or Color3.fromRGB(39,46,60)  
innerDot.BorderSizePixel = 0  
local dotCorner = Instance.new("UICorner")  
dotCorner.CornerRadius = UDim.new(0,7)  
dotCorner.Parent = innerDot  

btn.MouseButton1Click:Connect(function()  
    isOn = not isOn  
    innerDot.Position = UDim2.new(isOn and 0.45 or 0.05,0,0.05,0)  
    innerDot.BackgroundColor3 = isOn and Color3.fromRGB(70,206,130) or Color3.fromRGB(39,46,60)  
    if callback then  
        callback(isOn)  
    end  
end)  
return btn

end


---

-- Main Tab (Auto Lock Base)

local mainTab = tabContents["Main"]
local mainYOffset = 114

addToggle(mainTab,mainYOffset,"Auto Lock Base",false,function(lockState)
-- Sample for Steal a Brainrot - Auto Lock your base doors
-- Find base doors (update part name for your game!)
for _,v in pairs(workspace:GetChildren()) do
if v:IsA("Model") and v.Name:lower():find("base") and v:FindFirstChild("Door") then
v.Door.CanCollide = lockState
v.Door.Transparency = lockState and 0 or 0.5
end
end
print("Auto Lock Base:", lockState)
end)


---

-- Helper Tab (Your Base ESP toggle as example)

local helperTab = tabContents["Helper"]
addToggle(helperTab,70,"Your Base ESP",false,function(espState)
-- Simple ESP: highlights all bases and displays their name above them, ON/OFF
for _,v in pairs(workspace:GetChildren()) do
if v:IsA("Model") and v.Name:lower():find("base") then
if espState then
if not v:FindFirstChild("HeheBaseESP") then
local bill = Instance.new("BillboardGui")
bill.Name = "HeheBaseESP"
bill.Size = UDim2.new(0,120,0,34)
bill.AlwaysOnTop = true
bill.Adornee = v:FindFirstChild("HumanoidRootPart") or v.PrimaryPart or v:FindFirstChildWhichIsA("BasePart")
local txt = Instance.new("TextLabel")
txt.Parent = bill
txt.Size = UDim2.new(1,0,1,0)
txt.BackgroundTransparency = 1
txt.Font = Enum.Font.GothamBold
txt.TextSize = 18
txt.TextColor3 = Color3.fromRGB(70,206,130)
txt.Text = v.Name
bill.Parent = v
end
else
if v:FindFirstChild("HeheBaseESP") then
v.HeheBaseESP:Destroy()
end
end
end
end
print("Base ESP:", espState)
end)


---

-- Player Tab (Infinity Jump real script)

local playerTab = tabContents["Player"]
local infiniteJumpActive = false
addToggle(playerTab,42,"Infinity Jump",false,function(val)
infiniteJumpActive = val
_G.InfiniteJumpEnabledHehe = infiniteJumpActive
end)
game:GetService("UserInputService").JumpRequest:Connect(function()
if _G.InfiniteJumpEnabledHehe then
local humanoid = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
if humanoid then humanoid:ChangeState("Jumping") end
end
end)


---

-- Bounce-in entrance animation

local function bounceIn(frame)
local dur = 0.46
local overshoot = 42
local centerY = 0.5
local goal1 = {Position = UDim2.new(0.5, -FRAME_W/2, centerY, -overshoot)}
local tween1 = TweenService:Create(frame, TweenInfo.new(dur, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), goal1)
local goal2 = {Position = UDim2.new(0.5, -FRAME_W/2, centerY, overshoot/3)}
local tween2 = TweenService:Create(frame, TweenInfo.new(dur/2, Enum.EasingStyle.Quad, Enum.EasingDirection.In), goal2)
local goal3 = {Position = UDim2.new(0.5, -FRAME_W/2, centerY, 0)}
local tween3 = TweenService:Create(frame, TweenInfo.new(dur/2.1, Enum.EasingStyle.Quad), goal3)

tween1:Play()  
tween1.Completed:Wait()  
tween2:Play()  
tween2.Completed:Wait()  
tween3:Play()

end
spawn(function() bounceIn(mainFrame) end)

-- RightShift to toggle UI
UserInputService.InputBegan:Connect(function(input, processed)
if not processed and input.KeyCode == Enum.KeyCode.RightShift then
mainFrame.Visible = not mainFrame.Visible
end
end)

print("Hehe Hub loaded! Double jump, base ESP, auto lock base all work!")
