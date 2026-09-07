local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")
local UserInputService = game:GetService("UserInputService")

local GUI_NAME = "RUNLUA_TA_REMAKE"

pcall(function()
    if CoreGui:FindFirstChild(GUI_NAME) then
        CoreGui[GUI_NAME]:Destroy()
    end
end)

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = GUI_NAME
ScreenGui.ResetOnSpawn = false
ScreenGui.IgnoreGuiInset = true
ScreenGui.Parent = CoreGui

local function tween(obj, time, props)
    TweenService:Create(
        obj,
        TweenInfo.new(time, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
        props
    ):Play()
end

local function Notify(text)
    local Toast = Instance.new("TextLabel")
    Toast.Parent = ScreenGui
    Toast.AnchorPoint = Vector2.new(0.5, 0)
    Toast.Position = UDim2.new(0.5, 0, 0, -60)
    Toast.Size = UDim2.fromOffset(300, 42)
    Toast.BackgroundColor3 = Color3.fromRGB(245, 245, 245)
    Toast.Text = text
    Toast.TextColor3 = Color3.fromRGB(20, 20, 20)
    Toast.Font = Enum.Font.GothamBold
    Toast.TextSize = 12
    Toast.BorderSizePixel = 0

    Instance.new("UICorner", Toast).CornerRadius = UDim.new(0, 14)

    local Stroke = Instance.new("UIStroke", Toast)
    Stroke.Color = Color3.fromRGB(0, 0, 0)
    Stroke.Transparency = 0.85

    tween(Toast, 0.35, {
        Position = UDim2.new(0.5, 0, 0, 22)
    })

    task.delay(2.2, function()
        tween(Toast, 0.3, {
            Position = UDim2.new(0.5, 0, 0, -60),
            TextTransparency = 1,
            BackgroundTransparency = 1
        })
        task.wait(0.35)
        Toast:Destroy()
    end)
end

local Blur = Instance.new("Frame")
Blur.Parent = ScreenGui
Blur.Size = UDim2.fromScale(1, 1)
Blur.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Blur.BackgroundTransparency = 0.35
Blur.BorderSizePixel = 0

local Main = Instance.new("Frame")
Main.Parent = ScreenGui
Main.AnchorPoint = Vector2.new(0.5, 0.5)
Main.Position = UDim2.fromScale(0.5, 0.5)
Main.Size = UDim2.fromOffset(0, 0)
Main.BackgroundColor3 = Color3.fromRGB(245, 246, 250)
Main.BorderSizePixel = 0
Main.ClipsDescendants = true

Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 22)

local Shadow = Instance.new("ImageLabel")
Shadow.Parent = Main
Shadow.AnchorPoint = Vector2.new(0.5, 0.5)
Shadow.Position = UDim2.fromScale(0.5, 0.5)
Shadow.Size = UDim2.new(1, 70, 1, 70)
Shadow.BackgroundTransparency = 1
Shadow.Image = "rbxassetid://5028857472"
Shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
Shadow.ImageTransparency = 0.72
Shadow.ZIndex = -1

local Top = Instance.new("Frame")
Top.Parent = Main
Top.Size = UDim2.new(1, 0, 0, 74)
Top.BackgroundColor3 = Color3.fromRGB(28, 30, 40)
Top.BorderSizePixel = 0

local Accent = Instance.new("Frame")
Accent.Parent = Top
Accent.Position = UDim2.new(0, 0, 1, -4)
Accent.Size = UDim2.new(1, 0, 0, 4)
Accent.BackgroundColor3 = Color3.fromRGB(0, 190, 255)
Accent.BorderSizePixel = 0

local AccentGradient = Instance.new("UIGradient", Accent)
AccentGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 200, 255)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(140, 80, 255)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 80, 160))
})

task.spawn(function()
    while ScreenGui.Parent do
        AccentGradient.Offset = Vector2.new(-1, 0)
        tween(AccentGradient, 2.5, {
            Offset = Vector2.new(1, 0)
        })
        task.wait(2.5)
    end
end)

local Logo = Instance.new("TextLabel")
Logo.Parent = Top
Logo.Position = UDim2.fromOffset(18, 16)
Logo.Size = UDim2.fromOffset(44, 44)
Logo.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Logo.Text = "RL"
Logo.TextColor3 = Color3.fromRGB(28, 30, 40)
Logo.Font = Enum.Font.GothamBlack
Logo.TextSize = 17
Logo.BorderSizePixel = 0

Instance.new("UICorner", Logo).CornerRadius = UDim.new(0, 13)

local Title = Instance.new("TextLabel")
Title.Parent = Top
Title.Position = UDim2.fromOffset(74, 14)
Title.Size = UDim2.new(1, -125, 0, 24)
Title.BackgroundTransparency = 1
Title.Text = "RUNLUA CONTROL"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.GothamBlack
Title.TextSize = 18
Title.TextXAlignment = Enum.TextXAlignment.Left

local SubTitle = Instance.new("TextLabel")
SubTitle.Parent = Top
SubTitle.Position = UDim2.fromOffset(75, 39)
SubTitle.Size = UDim2.new(1, -125, 0, 18)
SubTitle.BackgroundTransparency = 1
SubTitle.Text = "เลือกเมนูที่ต้องการใช้งาน"
SubTitle.TextColor3 = Color3.fromRGB(180, 185, 200)
SubTitle.Font = Enum.Font.GothamMedium
SubTitle.TextSize = 11
SubTitle.TextXAlignment = Enum.TextXAlignment.Left

local Close = Instance.new("TextButton")
Close.Parent = Top
Close.Position = UDim2.new(1, -48, 0, 18)
Close.Size = UDim2.fromOffset(30, 30)
Close.BackgroundColor3 = Color3.fromRGB(255, 70, 90)
Close.Text = "X"
Close.TextColor3 = Color3.fromRGB(255, 255, 255)
Close.Font = Enum.Font.GothamBlack
Close.TextSize = 12
Close.BorderSizePixel = 0
Close.AutoButtonColor = false

Instance.new("UICorner", Close).CornerRadius = UDim.new(0, 10)

local Holder = Instance.new("Frame")
Holder.Parent = Main
Holder.Position = UDim2.fromOffset(18, 92)
Holder.Size = UDim2.new(1, -36, 1, -120)
Holder.BackgroundTransparency = 1

local List = Instance.new("UIListLayout")
List.Parent = Holder
List.Padding = UDim.new(0, 12)
List.SortOrder = Enum.SortOrder.LayoutOrder

local function MakeCard(icon, title, desc, color)
    local Card = Instance.new("TextButton")
    Card.Parent = Holder
    Card.Size = UDim2.new(1, 0, 0, 68)
    Card.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Card.Text = ""
    Card.BorderSizePixel = 0
    Card.AutoButtonColor = false

    Instance.new("UICorner", Card).CornerRadius = UDim.new(0, 16)

    local Stroke = Instance.new("UIStroke", Card)
    Stroke.Color = Color3.fromRGB(220, 225, 235)
    Stroke.Thickness = 1

    local IconBox = Instance.new("TextLabel")
    IconBox.Parent = Card
    IconBox.Position = UDim2.fromOffset(12, 12)
    IconBox.Size = UDim2.fromOffset(44, 44)
    IconBox.BackgroundColor3 = color
    IconBox.Text = icon
    IconBox.TextColor3 = Color3.fromRGB(255, 255, 255)
    IconBox.Font = Enum.Font.GothamBlack
    IconBox.TextSize = 18
    IconBox.BorderSizePixel = 0

    Instance.new("UICorner", IconBox).CornerRadius = UDim.new(0, 14)

    local CardTitle = Instance.new("TextLabel")
    CardTitle.Parent = Card
    CardTitle.Position = UDim2.fromOffset(68, 13)
    CardTitle.Size = UDim2.new(1, -95, 0, 22)
    CardTitle.BackgroundTransparency = 1
    CardTitle.Text = title
    CardTitle.TextColor3 = Color3.fromRGB(25, 25, 32)
    CardTitle.Font = Enum.Font.GothamBold
    CardTitle.TextSize = 14
    CardTitle.TextXAlignment = Enum.TextXAlignment.Left

    local CardDesc = Instance.new("TextLabel")
    CardDesc.Parent = Card
    CardDesc.Position = UDim2.fromOffset(68, 36)
    CardDesc.Size = UDim2.new(1, -95, 0, 18)
    CardDesc.BackgroundTransparency = 1
    CardDesc.Text = desc
    CardDesc.TextColor3 = Color3.fromRGB(115, 120, 130)
    CardDesc.Font = Enum.Font.Gotham
    CardDesc.TextSize = 10
    CardDesc.TextXAlignment = Enum.TextXAlignment.Left

    local Arrow = Instance.new("TextLabel")
    Arrow.Parent = Card
    Arrow.AnchorPoint = Vector2.new(1, 0.5)
    Arrow.Position = UDim2.new(1, -16, 0.5, 0)
    Arrow.Size = UDim2.fromOffset(20, 20)
    Arrow.BackgroundTransparency = 1
    Arrow.Text = ">"
    Arrow.TextColor3 = Color3.fromRGB(120, 120, 130)
    Arrow.Font = Enum.Font.GothamBlack
    Arrow.TextSize = 16

    Card.MouseEnter:Connect(function()
        tween(Card, 0.2, {
            BackgroundColor3 = Color3.fromRGB(248, 250, 255)
        })
        tween(Stroke, 0.2, {
            Color = color
        })
        tween(IconBox, 0.2, {
            Size = UDim2.fromOffset(48, 48),
            Position = UDim2.fromOffset(10, 10)
        })
    end)

    Card.MouseLeave:Connect(function()
        tween(Card, 0.2, {
            BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        })
        tween(Stroke, 0.2, {
            Color = Color3.fromRGB(220, 225, 235)
        })
        tween(IconBox, 0.2, {
            Size = UDim2.fromOffset(44, 44),
            Position = UDim2.fromOffset(12, 12)
        })
    end)

    return Card
end

local OldBtn = MakeCard(
    "V1",
    "GUI เวอร์ชั่นคุณภาพ",
    "ระบบเดิม ปรับใหม่ให้ใช้งานง่ายขึ้น",
    Color3.fromRGB(255, 130, 45)
)

local NewBtn = MakeCard(
    "V2",
    "GUI เวอร์ชั่นใหม่ Premium",
    "เมนูใหม่ ลื่นกว่าเดิม และจัดเต็มกว่า",
    Color3.fromRGB(0, 170, 255)
)

local Footer = Instance.new("TextLabel")
Footer.Parent = Main
Footer.AnchorPoint = Vector2.new(0.5, 1)
Footer.Position = UDim2.new(0.5, 0, 1, -12)
Footer.Size = UDim2.new(1, -20, 0, 16)
Footer.BackgroundTransparency = 1
Footer.Text = "X-WACK STORE"
Footer.TextColor3 = Color3.fromRGB(130, 135, 145)
Footer.Font = Enum.Font.GothamBold
Footer.TextSize = 10

local dragging = false
local dragStart
local startPos

Top.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = Main.Position

        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - dragStart
        Main.Position = UDim2.new(
            startPos.X.Scale,
            startPos.X.Offset + delta.X,
            startPos.Y.Scale,
            startPos.Y.Offset + delta.Y
        )
    end
end)

local function CloseGui()
    tween(Main, 0.25, {
        Size = UDim2.fromOffset(0, 0)
    })
    tween(Blur, 0.25, {
        BackgroundTransparency = 1
    })
    task.wait(0.28)
    ScreenGui:Destroy()
end

Close.MouseButton1Click:Connect(CloseGui)

local function RunScript(url, name)
    Notify("กำลังโหลด " .. name)
    task.wait(0.45)

    local success, err = pcall(function()
        loadstring(game:HttpGet(url))()
    end)

    if success then
        CloseGui()
    else
        Notify("โหลดไม่สำเร็จ")
        warn(err)
    end
end

OldBtn.MouseButton1Click:Connect(function()
    RunScript(
        
if not game:IsLoaded() then game.Loaded:Wait() end

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")
local StarterGui = game:GetService("StarterGui")
local CoreGui = game:GetService("CoreGui")

local Player = Players.LocalPlayer
local Camera = workspace.CurrentCamera
local Mouse = Player:GetMouse()

--==================================================
-- CLEANUP
--==================================================
pcall(function()
    local old = CoreGui:FindFirstChild("RUNLUA-HUB_STORE")
    if old then old:Destroy() end
end)

local Connections = {}
local function Track(c)
    table.insert(Connections, c)
    return c
end

local function DisconnectAll()
    for _, c in ipairs(Connections) do
        pcall(function() c:Disconnect() end)
    end
    table.clear(Connections)
end

local function Notify(text)
    pcall(function()
        StarterGui:SetCore("SendNotification", {
            Title = "RUNLUA HUB",
            Text = text,
            Duration = 3
        })
    end)
end

local function Character()
    return Player.Character
end

local function Humanoid()
    local c = Character()
    return c and c:FindFirstChildOfClass("Humanoid")
end

local function Root()
    local c = Character()
    return c and c:FindFirstChild("HumanoidRootPart")
end

--==================================================
-- UI LIBRARY
--==================================================
local Library = {}

local function Corner(obj, radius)
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, radius or 8)
    c.Parent = obj
    return c
end

local function Stroke(obj, color, transparency)
    local s = Instance.new("UIStroke")
    s.Color = color or Color3.fromRGB(0, 210, 255)
    s.Thickness = 1
    s.Transparency = transparency or 0.75
    s.Parent = obj
    return s
end

local function ShowHelp(titleText, bodyText)
    local old = CoreGui:FindFirstChild("XWACK_HELP_POPUP")
    if old then old:Destroy() end

    local gui = Instance.new("ScreenGui")
    gui.Name = "XWACK_HELP_POPUP"
    gui.ResetOnSpawn = false
    gui.IgnoreGuiInset = true
    gui.ZIndexBehavior = Enum.ZIndexBehavior.Global
    gui.Parent = CoreGui

    local shade = Instance.new("TextButton")
    shade.Size = UDim2.fromScale(1,1)
    shade.Text = ""
    shade.AutoButtonColor = false
    shade.BackgroundColor3 = Color3.new(0,0,0)
    shade.BackgroundTransparency = 0.35
    shade.BorderSizePixel = 0
    shade.ZIndex = 900
    shade.Parent = gui

    local box = Instance.new("Frame")
    box.AnchorPoint = Vector2.new(0.5,0.5)
    box.Position = UDim2.fromScale(0.5,0.5)
    box.Size = UDim2.new(0.78,0,0,190)
    box.BackgroundColor3 = Color3.fromRGB(20,22,30)
    box.BorderSizePixel = 0
    box.ZIndex = 901
    box.Parent = gui
    Corner(box,12)
    Stroke(box,Color3.fromRGB(0,210,255),0.25)

    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1,-48,0,40)
    title.Position = UDim2.fromOffset(14,4)
    title.BackgroundTransparency = 1
    title.Text = "วิธีใช้: "..tostring(titleText)
    title.TextColor3 = Color3.new(1,1,1)
    title.Font = Enum.Font.GothamBold
    title.TextSize = 15
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.ZIndex = 902
    title.Parent = box

    local body = Instance.new("TextLabel")
    body.Size = UDim2.new(1,-28,1,-58)
    body.Position = UDim2.fromOffset(14,46)
    body.BackgroundTransparency = 1
    body.Text = tostring(bodyText or "ไม่มีคำอธิบาย")
    body.TextColor3 = Color3.fromRGB(205,210,225)
    body.Font = Enum.Font.Gotham
    body.TextSize = 13
    body.TextWrapped = true
    body.TextXAlignment = Enum.TextXAlignment.Left
    body.TextYAlignment = Enum.TextYAlignment.Top
    body.ZIndex = 902
    body.Parent = box

    local close = Instance.new("TextButton")
    close.Size = UDim2.fromOffset(28,28)
    close.Position = UDim2.new(1,-36,0,8)
    close.Text = "✕"
    close.Font = Enum.Font.GothamBold
    close.TextSize = 13
    close.TextColor3 = Color3.new(1,1,1)
    close.BackgroundColor3 = Color3.fromRGB(255,55,80)
    close.BorderSizePixel = 0
    close.ZIndex = 903
    close.Parent = box
    Corner(close,7)

    close.MouseButton1Click:Connect(function() gui:Destroy() end)
    shade.MouseButton1Click:Connect(function() gui:Destroy() end)
end

local function AddHelpButton(parent, titleText, helpText, yScale, yOffset)
    if not helpText or helpText == "" then return end
    local q = Instance.new("TextButton")
    q.Name = "Help"
    q.Size = UDim2.fromOffset(24,24)
    q.Position = UDim2.new(1,-30,yScale or 0.5,yOffset or -12)
    q.Text = "?"
    q.Font = Enum.Font.GothamBold
    q.TextSize = 13
    q.TextColor3 = Color3.fromRGB(0,210,255)
    q.BackgroundColor3 = Color3.fromRGB(38,42,56)
    q.BorderSizePixel = 0
    q.ZIndex = 20
    q.Parent = parent
    Corner(q,12)
    q.MouseButton1Click:Connect(function()
        ShowHelp(titleText,helpText)
    end)
end

local function MakeDraggable(frame, handle)
    local dragging = false
    local dragInput, dragStart, startPos

    Track(handle.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = frame.Position
            Track(input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end))
        end
    end))

    Track(handle.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement
        or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end))

    Track(UIS.InputChanged:Connect(function(input)
        if dragging and input == dragInput and frame.Parent then
            local delta = input.Position - dragStart
            frame.Position = UDim2.new(
                startPos.X.Scale, startPos.X.Offset + delta.X,
                startPos.Y.Scale, startPos.Y.Offset + delta.Y
            )
        end
    end))
end

function Library:NewWindow(title)
    local Gui = Instance.new("ScreenGui")
    Gui.Name = "RUNLUA-HUB"
    Gui.ResetOnSpawn = false
    Gui.IgnoreGuiInset = false
    Gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    Gui.Parent = CoreGui

    local Main = Instance.new("Frame")
    Main.Name = "RUNLUA_HUB_MainFrame"
    Main.Size = UDim2.fromOffset(500, 330)
    Main.Position = UDim2.new(0.5, -250, 0.5, -165)
    Main.BackgroundColor3 = Color3.fromRGB(15, 16, 22)
    Main.BorderSizePixel = 0
    Main.ClipsDescendants = false
    Main.Parent = Gui
    Corner(Main, 11)

    local mainStroke = Stroke(Main, Color3.fromRGB(0,210,255), 0.25)
    mainStroke.Thickness = 1.3

    local gradient = Instance.new("UIGradient")
    gradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(0,210,255)),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255,0,130)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(0,210,255))
    })
    gradient.Parent = mainStroke

    task.spawn(function()
        local r = 0
        while Gui.Parent do
            task.wait(0.04)
            r = (r + 2) % 360
            gradient.Rotation = r
        end
    end)

    local TitleBar = Instance.new("Frame")
    TitleBar.Size = UDim2.new(1,0,0,38)
    TitleBar.BackgroundColor3 = Color3.fromRGB(20,22,30)
    TitleBar.BorderSizePixel = 0
    TitleBar.Parent = Main
    Corner(TitleBar, 10)

    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(1,-80,1,0)
    Title.Position = UDim2.fromOffset(14,0)
    Title.BackgroundTransparency = 1
    Title.Text = title
    Title.TextColor3 = Color3.new(1,1,1)
    Title.Font = Enum.Font.GothamBold
    Title.TextSize = 14
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.Parent = TitleBar

    local Close = Instance.new("TextButton")
    Close.Size = UDim2.fromOffset(24,24)
    Close.Position = UDim2.new(1,-32,0,7)
    Close.Text = "✕"
    Close.Font = Enum.Font.GothamBold
    Close.TextSize = 12
    Close.TextColor3 = Color3.new(1,1,1)
    Close.BackgroundColor3 = Color3.fromRGB(255,45,75)
    Close.BorderSizePixel = 0
    Close.Parent = TitleBar
    Corner(Close,6)

    --==================================================
    -- LOGO TOGGLE BUTTON (แทนปุ่ม W/X เดิม)
    --==================================================
    local Mini = Instance.new("ImageButton")
    Mini.Name = "TogglePill"
    Mini.BackgroundTransparency = 1
    Mini.BorderSizePixel = 0
    Mini.ClipsDescendants = true
    Mini.ZIndex = 10
    Mini.AutoButtonColor = false
    Mini.AnchorPoint = Vector2.new(0.5, 1)
    Mini.Position = UDim2.new(0.1, 10, 0.25, 5)
    Mini.Size = UDim2.fromOffset(54, 54)
    Mini.Visible = true
    Mini.ImageTransparency = 0.05
    Mini.ScaleType = Enum.ScaleType.Crop
    Mini.Parent = Gui

    local MiniCorner = Instance.new("UICorner")
    MiniCorner.CornerRadius = UDim.new(0, 6)
    MiniCorner.Parent = Mini

    local MiniStroke = Instance.new("UIStroke")
    MiniStroke.Color = Color3.fromRGB(0, 210, 255)
    MiniStroke.Thickness = 2.5
    MiniStroke.Parent = Mini

    -- โหลดโลโก้จาก URL และ cache ไว้ในเครื่อง ถ้า executor รองรับ
    task.spawn(function()
        pcall(function()
            local imageUrl = "https://i.postimg.cc/cJKhRc1r/IMG-20260904-201616-447.png"
            local fileName = "RUNLUA.png"

            if isfile and writefile and readfile and getcustomasset then
                if not isfile(fileName) then
                    local imgData = game:HttpGet(imageUrl)
                    if imgData and #imgData > 0 then
                        writefile(fileName, imgData)
                    end
                end

                if isfile(fileName) then
                    Mini.Image = getcustomasset(fileName)
                else
                    Mini.Image = imageUrl
                end
            else
                Mini.Image = imageUrl
            end
        end)
    end)

    MakeDraggable(Mini, Mini)

    local function UpdateMiniStroke()
        TweenService:Create(MiniStroke, TweenInfo.new(0.15), {
            Color = Main.Visible
                and Color3.fromRGB(0, 210, 255)
                or Color3.fromRGB(200, 10, 40)
        }):Play()
    end

    Track(Mini.MouseButton1Click:Connect(function()
        Main.Visible = not Main.Visible
        UpdateMiniStroke()
    end))

    UpdateMiniStroke()

    local Sidebar = Instance.new("Frame")
    Sidebar.Size = UDim2.new(0,135,1,-46)
    Sidebar.Position = UDim2.fromOffset(4,42)
    Sidebar.BackgroundColor3 = Color3.fromRGB(18,19,26)
    Sidebar.BorderSizePixel = 0
    Sidebar.Parent = Main
    Corner(Sidebar,8)

    local TabList = Instance.new("ScrollingFrame")
    TabList.Size = UDim2.new(1,-6,1,-8)
    TabList.Position = UDim2.fromOffset(3,4)
    TabList.BackgroundTransparency = 1
    TabList.BorderSizePixel = 0
    TabList.ScrollBarThickness = 2
    TabList.AutomaticCanvasSize = Enum.AutomaticSize.Y
    TabList.CanvasSize = UDim2.new()
    TabList.Parent = Sidebar

    local tabLayout = Instance.new("UIListLayout")
    tabLayout.Padding = UDim.new(0,4)
    tabLayout.Parent = TabList

    local Content = Instance.new("Frame")
    Content.Size = UDim2.new(1,-149,1,-46)
    Content.Position = UDim2.fromOffset(145,42)
    Content.BackgroundTransparency = 1
    Content.Parent = Main

    local tabs = {}
    local Window = {}

    function Window:NewTab(name, icon)
        local TabButton = Instance.new("TextButton")
        TabButton.Size = UDim2.new(1,0,0,31)
        TabButton.BackgroundColor3 = Color3.fromRGB(24,26,36)
        TabButton.BackgroundTransparency = 0.55
        TabButton.BorderSizePixel = 0
        TabButton.Text = "  "..(icon or "").."  "..name
        TabButton.TextColor3 = Color3.fromRGB(175,180,195)
        TabButton.Font = Enum.Font.GothamBold
        TabButton.TextSize = 12
        TabButton.TextXAlignment = Enum.TextXAlignment.Left
        TabButton.Parent = TabList
        Corner(TabButton,6)
        local ts = Stroke(TabButton, Color3.fromRGB(0,210,255), 1)

        local Page = Instance.new("ScrollingFrame")
        Page.Size = UDim2.new(1,-4,1,0)
        Page.BackgroundTransparency = 1
        Page.BorderSizePixel = 0
        Page.ScrollBarThickness = 2
        Page.ScrollBarImageColor3 = Color3.fromRGB(0,210,255)
        Page.AutomaticCanvasSize = Enum.AutomaticSize.Y
        Page.CanvasSize = UDim2.new()
        Page.Visible = false
        Page.Parent = Content

        local layout = Instance.new("UIListLayout")
        layout.Padding = UDim.new(0,6)
        layout.Parent = Page

        local pad = Instance.new("UIPadding")
        pad.PaddingBottom = UDim.new(0,8)
        pad.Parent = Page

        local function Select()
            for _, t in ipairs(tabs) do
                t.Page.Visible = false
                t.Button.BackgroundTransparency = 0.55
                t.Button.TextColor3 = Color3.fromRGB(175,180,195)
                t.Stroke.Transparency = 1
            end
            Page.Visible = true
            TabButton.BackgroundTransparency = 0
            TabButton.TextColor3 = Color3.new(1,1,1)
            ts.Transparency = 0
        end

        Track(TabButton.MouseButton1Click:Connect(Select))
        table.insert(tabs,{Button=TabButton,Page=Page,Stroke=ts})

        if #tabs == 1 then task.defer(Select) end

        local Tab = {}

        function Tab:NewLabel(text)
            local L = Instance.new("TextLabel")
            L.Size = UDim2.new(1,-6,0,26)
            L.BackgroundTransparency = 1
            L.Text = text
            L.TextColor3 = Color3.fromRGB(120,180,255)
            L.Font = Enum.Font.GothamBold
            L.TextSize = 12
            L.TextXAlignment = Enum.TextXAlignment.Left
            L.Parent = Page
            return L
        end

        function Tab:NewButton(text, callback, helpText)
            local B = Instance.new("TextButton")
            B.Size = UDim2.new(1,-6,0,34)
            B.BackgroundColor3 = Color3.fromRGB(24,27,38)
            B.BorderSizePixel = 0
            B.Text = "   "..text
            B.TextColor3 = Color3.fromRGB(240,242,250)
            B.Font = Enum.Font.GothamMedium
            B.TextSize = 12
            B.TextXAlignment = Enum.TextXAlignment.Left
            B.Parent = Page
            Corner(B,7)
            Stroke(B, Color3.fromRGB(0,210,255), 0.82)

            AddHelpButton(B,text,helpText,0.5,-12)

            Track(B.MouseButton1Click:Connect(function()
                if callback then
                    local ok, err = pcall(callback)
                    if not ok then warn("[Runlua] "..tostring(err)) end
                end
            end))
            return B
        end

        -- ปรับปรุง NewToggle + Slider ในตัวเดียวกัน
        function Tab:NewToggle(text, default, callback, helpText, sliderConfig)
            local state = default == true

            local Container = Instance.new("Frame")
            Container.Size = UDim2.new(1, -6, 0, 38)
            Container.BackgroundTransparency = 1
            Container.Parent = Page

            local containerLayout = Instance.new("UIListLayout")
            containerLayout.SortOrder = Enum.SortOrder.LayoutOrder
            containerLayout.Padding = UDim.new(0, 4)
            containerLayout.Parent = Container

            local Holder = Instance.new("TextButton")
            Holder.Size = UDim2.new(1, 0, 0, 38)
            Holder.BackgroundColor3 = Color3.fromRGB(24,27,38)
            Holder.BorderSizePixel = 0
            Holder.Text = ""
            Holder.LayoutOrder = 1
            Holder.Parent = Container
            Corner(Holder,7)
            Stroke(Holder, Color3.fromRGB(0,210,255), 0.82)

            local L = Instance.new("TextLabel")
            L.Size = UDim2.new(1,-72,1,0)
            L.Position = UDim2.fromOffset(10,0)
            L.BackgroundTransparency = 1
            L.Text = text
            L.TextColor3 = Color3.fromRGB(240,242,250)
            L.Font = Enum.Font.GothamMedium
            L.TextSize = 12
            L.TextXAlignment = Enum.TextXAlignment.Left
            L.Parent = Holder

            local Switch = Instance.new("Frame")
            Switch.Size = UDim2.fromOffset(48,22)
            Switch.Position = UDim2.new(1,-88,0.5,-11)
            Switch.BackgroundColor3 = state and Color3.fromRGB(0,180,130) or Color3.fromRGB(60,64,76)
            Switch.BorderSizePixel = 0
            Switch.Parent = Holder
            Corner(Switch,11)

            local Dot = Instance.new("Frame")
            Dot.Size = UDim2.fromOffset(18,18)
            Dot.Position = state and UDim2.fromOffset(28,2) or UDim2.fromOffset(2,2)
            Dot.BackgroundColor3 = Color3.new(1,1,1)
            Dot.BorderSizePixel = 0
            Dot.Parent = Switch
            Corner(Dot,9)

            AddHelpButton(Holder,text,helpText,0.5,-12)

            local SliderObj = nil

            local function UpdateContainerSize()
                local totalY = 38
                if SliderObj and SliderObj.Holder.Visible then
                    totalY = totalY + 4 + SliderObj.Holder.Size.Y.Offset
                end
                Container.Size = UDim2.new(1, -6, 0, totalY)
            end

            local function Render()
                TweenService:Create(Switch,TweenInfo.new(.15),{
                    BackgroundColor3 = state and Color3.fromRGB(0,180,130) or Color3.fromRGB(60,64,76)
                }):Play()
                TweenService:Create(Dot,TweenInfo.new(.15),{
                    Position = state and UDim2.fromOffset(28,2) or UDim2.fromOffset(2,2)
                }):Play()

                if SliderObj then
                    SliderObj.Holder.Visible = state
                    UpdateContainerSize()
                end
            end

            local function Set(v)
                state = v == true
                Render()
                if callback then
                    local ok, err = pcall(callback,state)
                    if not ok then warn("[Runlua Toggle] "..tostring(err)) end
                end
            end

            Track(Holder.MouseButton1Click:Connect(function()
                Set(not state)
            end))

            -- หากมี Slider ในระบบ: เส้นลาก + ปุ่มลาก + ช่องกรอกตัวเลข
            if sliderConfig then
                local minValue = tonumber(sliderConfig.min) or 0
                local maxValue = tonumber(sliderConfig.max) or 100
                local increment = tonumber(sliderConfig.increment) or 1
                local value = math.clamp(tonumber(sliderConfig.default) or minValue, minValue, maxValue)

                local SHolder = Instance.new("Frame")
                SHolder.Size = UDim2.new(1, 0, 0, 62)
                SHolder.BackgroundColor3 = Color3.fromRGB(18, 20, 29)
                SHolder.BorderSizePixel = 0
                SHolder.LayoutOrder = 2
                SHolder.Visible = state
                SHolder.Parent = Container
                Corner(SHolder, 7)
                Stroke(SHolder, Color3.fromRGB(0,180,255), 0.9)

                local SL = Instance.new("TextLabel")
                SL.Size = UDim2.new(1, -92, 0, 24)
                SL.Position = UDim2.fromOffset(10, 3)
                SL.BackgroundTransparency = 1
                SL.Text = sliderConfig.text or "ปรับค่า"
                SL.TextColor3 = Color3.fromRGB(180, 190, 210)
                SL.Font = Enum.Font.Gotham
                SL.TextSize = 11
                SL.TextXAlignment = Enum.TextXAlignment.Left
                SL.Parent = SHolder

                local InputBox = Instance.new("TextBox")
                InputBox.Size = UDim2.fromOffset(72, 24)
                InputBox.Position = UDim2.new(1, -82, 0, 3)
                InputBox.BackgroundColor3 = Color3.fromRGB(28, 31, 43)
                InputBox.BorderSizePixel = 0
                InputBox.ClearTextOnFocus = false
                InputBox.Text = tostring(value)
                InputBox.PlaceholderText = tostring(minValue).."-"..tostring(maxValue)
                InputBox.TextColor3 = Color3.fromRGB(0, 210, 255)
                InputBox.PlaceholderColor3 = Color3.fromRGB(105, 115, 135)
                InputBox.Font = Enum.Font.GothamBold
                InputBox.TextSize = 11
                InputBox.Parent = SHolder
                Corner(InputBox, 6)
                Stroke(InputBox, Color3.fromRGB(0,180,255), 0.82)

                local SBar = Instance.new("Frame")
                SBar.Size = UDim2.new(1, -32, 0, 6)
                SBar.Position = UDim2.new(0, 16, 1, -18)
                SBar.BackgroundColor3 = Color3.fromRGB(45, 50, 65)
                SBar.BorderSizePixel = 0
                SBar.Active = true
                SBar.Parent = SHolder
                Corner(SBar, 3)

                local SFill = Instance.new("Frame")
                SFill.BackgroundColor3 = Color3.fromRGB(0, 180, 255)
                SFill.BorderSizePixel = 0
                SFill.Parent = SBar
                Corner(SFill, 3)

                local Knob = Instance.new("Frame")
                Knob.AnchorPoint = Vector2.new(0.5, 0.5)
                Knob.Size = UDim2.fromOffset(16, 16)
                Knob.BackgroundColor3 = Color3.fromRGB(235, 245, 255)
                Knob.BorderSizePixel = 0
                Knob.ZIndex = 3
                Knob.Parent = SBar
                Corner(Knob, 8)
                Stroke(Knob, Color3.fromRGB(0,180,255), 0.25)

                local dragging = false

                local function RoundToIncrement(v)
                    if increment <= 0 then return v end
                    return math.floor((v / increment) + 0.5) * increment
                end

                local function FormatValue(v)
                    if increment >= 1 then return tostring(math.floor(v + 0.5)) end
                    local txt = string.format("%.3f", v)
                    txt = txt:gsub("0+$", ""):gsub("%.$", "")
                    return txt
                end

                local function SRender()
                    local range = maxValue - minValue
                    local alpha = range ~= 0 and ((value - minValue) / range) or 0
                    alpha = math.clamp(alpha, 0, 1)
                    SFill.Size = UDim2.new(alpha, 0, 1, 0)
                    Knob.Position = UDim2.new(alpha, 0, 0.5, 0)
                    InputBox.Text = FormatValue(value)
                end

                local function ApplyValue(newValue, fireCallback)
                    newValue = tonumber(newValue)
                    if not newValue then
                        SRender()
                        return
                    end
                    value = math.clamp(RoundToIncrement(newValue), minValue, maxValue)
                    SRender()
                    if fireCallback ~= false and sliderConfig.callback then
                        local ok, err = pcall(sliderConfig.callback, value)
                        if not ok then warn("[RUNLUA Slider] "..tostring(err)) end
                    end
                end

                local function SetFromX(x)
                    if SBar.AbsoluteSize.X <= 0 then return end
                    local alpha = math.clamp((x - SBar.AbsolutePosition.X) / SBar.AbsoluteSize.X, 0, 1)
                    ApplyValue(minValue + (maxValue - minValue) * alpha, true)
                end

                Track(SBar.InputBegan:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                        dragging = true
                        SetFromX(input.Position.X)
                    end
                end))

                Track(Knob.InputBegan:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                        dragging = true
                    end
                end))

                Track(UIS.InputChanged:Connect(function(input)
                    if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
                        SetFromX(input.Position.X)
                    end
                end))

                Track(UIS.InputEnded:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                        dragging = false
                    end
                end))

                Track(InputBox.FocusLost:Connect(function()
                    ApplyValue(InputBox.Text, true)
                end))

                SRender()
                SliderObj = {Holder = SHolder, SetValue = ApplyValue, GetValue = function() return value end}
                UpdateContainerSize()
            end

            return {Set = Set, Get = function() return state end}
        end

        return Tab
    end

    MakeDraggable(Main,TitleBar)

    -- Resize
    local Resize = Instance.new("TextButton")
    Resize.AnchorPoint = Vector2.new(1,1)
    Resize.Position = UDim2.new(1,-5,1,-5)
    Resize.Size = UDim2.fromOffset(24,24)
    Resize.Text = "↘"
    Resize.Font = Enum.Font.GothamBold
    Resize.TextSize = 15
    Resize.TextColor3 = Color3.fromRGB(0,210,255)
    Resize.BackgroundColor3 = Color3.fromRGB(28,31,43)
    Resize.BorderSizePixel = 0
    Resize.ZIndex = 50
    Resize.Parent = Main
    Corner(Resize,6)

    local resizing, resizeInput, startPos, startSize = false,nil,nil,nil

    Track(Resize.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then
            resizing = true
            resizeInput = input
            startPos = input.Position
            startSize = Main.AbsoluteSize
        end
    end))

    Track(Resize.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement
        or input.UserInputType == Enum.UserInputType.Touch then
            resizeInput = input
        end
    end))

    Track(UIS.InputChanged:Connect(function(input)
        if resizing and input == resizeInput then
            local d = input.Position-startPos
            local vp = Camera and Camera.ViewportSize or Vector2.new(1920,1080)
            Main.Size = UDim2.fromOffset(
                math.clamp(startSize.X+d.X,340,math.min(900,vp.X-15)),
                math.clamp(startSize.Y+d.Y,230,math.min(650,vp.Y-15))
            )
        end
    end))

    Track(UIS.InputEnded:Connect(function(input)
        if input == resizeInput
        or input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then
            resizing = false
            resizeInput = nil
        end
    end))

    Track(Close.MouseButton1Click:Connect(function()
        DisconnectAll()
        Gui:Destroy()
    end))

    return Window
end

--==================================================
-- FEATURE STATE
--==================================================
local State = {
    Fly = false,
    FlySpeed = 60,
    InfiniteJump = false,
    Speed = false,
    WalkSpeed = 100,
    ClickTP = false,
    Noclip = false,
    Invisible = false,
    God = false,
    Aimbot = false,
    FOV = 20,
    KillAura = false,
    KillRange = 100,
    Hitbox = false,
    HitboxSize = 20,
    FPSBoost = false,
    Fullbright = false,
    Brightness = 2,
    ClockTime = 13,
    ESPPlayers = false,
    ESPNPC = false,
    CarSpeed = 150,
    CarSpeedEnabled = false,
    PullPlayers = false,
    Blackhole = false
}

--==================================================
-- BACKUPS
--==================================================
local OriginalCollision = {}
local OriginalTransparency = {}
local OriginalHitbox = {}
local LightingBackup = {
    Brightness = Lighting.Brightness,
    ClockTime = Lighting.ClockTime,
    GlobalShadows = Lighting.GlobalShadows,
    FogStart = Lighting.FogStart,
    FogEnd = Lighting.FogEnd,
    Ambient = Lighting.Ambient,
    OutdoorAmbient = Lighting.OutdoorAmbient
}

--==================================================
-- FLY - บินตามทิศทางกล้อง
-- หันขึ้น = บินขึ้น / หันลง = บินลง
-- รองรับทั้ง PC + มือถือ
--==================================================
local FlyBV, FlyBG

local function StopFly()
    if FlyBV then
        FlyBV:Destroy()
        FlyBV = nil
    end

    if FlyBG then
        FlyBG:Destroy()
        FlyBG = nil
    end

    local h = Humanoid()
    if h then
        h.PlatformStand = false
    end
end

local function StartFly()
    StopFly()

    local root, hum = Root(), Humanoid()
    if not root or not hum then return end

    FlyBV = Instance.new("BodyVelocity")
    FlyBV.Name = "XWACK_FlyVelocity"
    FlyBV.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
    FlyBV.P = 10000
    FlyBV.Velocity = Vector3.zero
    FlyBV.Parent = root

    FlyBG = Instance.new("BodyGyro")
    FlyBG.Name = "XWACK_FlyGyro"
    FlyBG.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
    FlyBG.P = 50000
    FlyBG.D = 1000
    FlyBG.CFrame = root.CFrame
    FlyBG.Parent = root

    hum.PlatformStand = true
end

Track(RunService.RenderStepped:Connect(function()
    if not State.Fly then
        return
    end

    local root, hum = Root(), Humanoid()
    if not root or not hum or not Camera then
        return
    end

    if not FlyBV or FlyBV.Parent ~= root or
       not FlyBG or FlyBG.Parent ~= root then
        StartFly()
        return
    end

    hum.PlatformStand = true

    local move = hum.MoveDirection
    local speed = State.FlySpeed or 50

    -- ทิศของกล้องแบบ 3D
    -- LookVector มีแกน Y อยู่ด้วย
    -- เพราะงั้นหันขึ้น/ลงแล้วบินตามได้
    local camCF = Camera.CFrame
    local look = camCF.LookVector
    local right = camCF.RightVector

    -- ตรวจว่ากำลังเดินไปข้างหน้า/หลัง/ซ้าย/ขวา
    -- แปลง MoveDirection เป็น local direction ของกล้อง
    local flatLook = Vector3.new(look.X, 0, look.Z)
    local flatRight = Vector3.new(right.X, 0, right.Z)

    if flatLook.Magnitude > 0.001 then
        flatLook = flatLook.Unit
    end

    if flatRight.Magnitude > 0.001 then
        flatRight = flatRight.Unit
    end

    local forwardAmount = 0
    local rightAmount = 0

    if move.Magnitude > 0.01 then
        forwardAmount = move:Dot(flatLook)
        rightAmount = move:Dot(flatRight)
    end

    -- บินตามมุมกล้องจริง
    local flyDirection =
        (look * forwardAmount) +
        (right * rightAmount)

    -- PC: Space บินขึ้นตรงๆ เพิ่มเติม
    if UIS:IsKeyDown(Enum.KeyCode.Space) then
        flyDirection += Vector3.new(0, 1, 0)
    end

    -- PC: Ctrl / C บินลงตรงๆ เพิ่มเติม
    if UIS:IsKeyDown(Enum.KeyCode.LeftControl)
    or UIS:IsKeyDown(Enum.KeyCode.RightControl)
    or UIS:IsKeyDown(Enum.KeyCode.C) then
        flyDirection += Vector3.new(0, -1, 0)
    end

    -- ป้องกันแนวทแยงเร็วเกิน FlySpeed
    if flyDirection.Magnitude > 1 then
        flyDirection = flyDirection.Unit
    end

    FlyBV.Velocity = flyDirection * speed

    -- ตัวละครหันตามกล้อง
    FlyBG.CFrame = camCF
end))

--==================================================
-- INFINITE JUMP
--==================================================
Track(UIS.JumpRequest:Connect(function()
    if State.InfiniteJump then
        local hum = Humanoid()
        if hum then
            hum:ChangeState(Enum.HumanoidStateType.Jumping)
        end
    end
end))

--==================================================
-- SPEED + NOCLIP + GOD
--==================================================
Track(RunService.Stepped:Connect(function()
    local char = Character()
    local hum = Humanoid()

    if hum and State.Speed then
        hum.WalkSpeed = State.WalkSpeed
    end

    if char and State.Noclip then
        for _,obj in ipairs(char:GetDescendants()) do
            if obj:IsA("BasePart") then
                if OriginalCollision[obj] == nil then
                    OriginalCollision[obj] = obj.CanCollide
                end
                obj.CanCollide = false
            end
        end
    end

    if hum and State.God then
        pcall(function()
            hum.BreakJointsOnDeath = false
            hum.RequiresNeck = false
            if hum.MaxHealth < 1e9 then hum.MaxHealth = 1e9 end
            if hum.Health < hum.MaxHealth then hum.Health = hum.MaxHealth end
        end)
    end
end))

local function RestoreCollision()
    for obj,v in pairs(OriginalCollision) do
        if obj and obj.Parent then pcall(function() obj.CanCollide=v end) end
    end
    table.clear(OriginalCollision)
end

--==================================================
-- CLICK TP TOOL
--==================================================
local ClickTool

local function RemoveClickTool()
    if ClickTool then pcall(function() ClickTool:Destroy() end) end
    ClickTool=nil
    local backpack = Player:FindFirstChildOfClass("Backpack")
    if backpack then
        local t = backpack:FindFirstChild("RUNLUA-HUB Click TP")
        if t then t:Destroy() end
    end
    local char = Character()
    if char then
        local t = char:FindFirstChild(" Click TP")
        if t then t:Destroy() end
    end
end

local function GiveClickTool()
    RemoveClickTool()
    local t = Instance.new("Tool")
    t.Name = "RUNLUA-HUB Click TP"
    t.RequiresHandle = false
    t.CanBeDropped = false

    Track(t.Activated:Connect(function()
        if not State.ClickTP then return end
        local root = Root()
        if root and Mouse and Mouse.Hit then
            root.CFrame = CFrame.new(Mouse.Hit.Position + Vector3.new(0,3,0))
        end
    end))

    t.Parent = Player:WaitForChild("Backpack")
    ClickTool=t
end

--==================================================
-- INVISIBLE (LOCAL VISUAL)
--==================================================
local function SetInvisible(on)
    local char = Character()
    if not char then return end

    if on then
        for _,obj in ipairs(char:GetDescendants()) do
            if obj:IsA("BasePart") or obj:IsA("Decal") then
                if OriginalTransparency[obj] == nil then
                    OriginalTransparency[obj] = obj.Transparency
                end
                obj.Transparency = 1
            end
        end
    else
        for obj,v in pairs(OriginalTransparency) do
            if obj and obj.Parent then pcall(function() obj.Transparency=v end) end
        end
        table.clear(OriginalTransparency)
    end
end

--==================================================
-- AIMBOT
--==================================================
local AimCircle
pcall(function()
    if Drawing then
        AimCircle = Drawing.new("Circle")
        AimCircle.Thickness = 1.5
        AimCircle.NumSides = 45
        AimCircle.Filled = false
        AimCircle.Transparency = 0.8
        AimCircle.Color = Color3.fromRGB(0,170,255)
        AimCircle.Visible = false
    end
end)

local function FOVRadius()
    local vp = Camera.ViewportSize
    return math.min(vp.X,vp.Y)/2*(State.FOV/100)
end

local function GetAimTarget()
    local vp = Camera.ViewportSize
    local center = Vector2.new(vp.X/2,vp.Y/2)
    local best,bestDist=nil,math.huge

    for _,p in ipairs(Players:GetPlayers()) do
        if p ~= Player and p.Character then
            local head = p.Character:FindFirstChild("Head")
            local hum = p.Character:FindFirstChildOfClass("Humanoid")
            if head and hum and hum.Health > 0 then
                local pos,onScreen = Camera:WorldToViewportPoint(head.Position)
                if onScreen then
                    local dist=(Vector2.new(pos.X,pos.Y)-center).Magnitude
                    if dist <= FOVRadius() and dist < bestDist then
                        best=head
                        bestDist=dist
                    end
                end
            end
        end
    end
    return best
end

Track(RunService.RenderStepped:Connect(function()
    if AimCircle then
        AimCircle.Position = Vector2.new(Camera.ViewportSize.X/2,Camera.ViewportSize.Y/2)
        AimCircle.Radius = FOVRadius()
        AimCircle.Visible = State.Aimbot
    end

    if State.Aimbot then
        local target=GetAimTarget()
        if target then
            Camera.CFrame=CFrame.lookAt(Camera.CFrame.Position,target.Position)
        end
    end
end))

--==================================================
-- KILL AURA NPC
--==================================================
local function IsPlayerCharacter(model)
    return Players:GetPlayerFromCharacter(model) ~= nil
end

Track(RunService.Heartbeat:Connect(function()
    if not State.KillAura then return end
    local myRoot = Root()
    if not myRoot then return end

    for _,obj in ipairs(workspace:GetDescendants()) do
        if obj:IsA("Humanoid") and obj.Health > 0 then
            local model=obj.Parent
            if model and model:IsA("Model") and not IsPlayerCharacter(model) then
                local root=model:FindFirstChild("HumanoidRootPart") or model:FindFirstChild("Torso") or model:FindFirstChild("UpperTorso")
                if root and (root.Position-myRoot.Position).Magnitude <= State.KillRange then
                    pcall(function()
                        obj.Health=0
                    end)
                end
            end
        end
    end
end))

--==================================================
-- HITBOX
--==================================================
local function ResetHitbox()
    for part,data in pairs(OriginalHitbox) do
        if part and part.Parent then
            pcall(function()
                part.Size=data.Size
                part.Transparency=data.Transparency
                part.CanCollide=data.CanCollide
                part.Material=data.Material
            end)
        end
    end
    table.clear(OriginalHitbox)
end

Track(RunService.Heartbeat:Connect(function()
    if not State.Hitbox then return end

    for _,p in ipairs(Players:GetPlayers()) do
        if p ~= Player and p.Character then
            local hrp=p.Character:FindFirstChild("HumanoidRootPart")
            if hrp then
                if not OriginalHitbox[hrp] then
                    OriginalHitbox[hrp]={
                        Size=hrp.Size,
                        Transparency=hrp.Transparency,
                        CanCollide=hrp.CanCollide,
                        Material=hrp.Material
                    }
                end
                hrp.Size=Vector3.new(State.HitboxSize,State.HitboxSize,State.HitboxSize)
                hrp.Transparency=.65
                hrp.CanCollide=false
                hrp.Material=Enum.Material.Neon
            end
        end
    end
end))

--==================================================
-- FPS BOOST
--==================================================
local FPSBackup={}
local function ApplyFPSBoost(on)
    if on then
        for _,v in ipairs(game:GetDescendants()) do
            if v:IsA("BasePart") then
                if not FPSBackup[v] then
                    FPSBackup[v]={Material=v.Material,CastShadow=v.CastShadow}
                end
                v.Material=Enum.Material.SmoothPlastic
                v.CastShadow=false
            elseif v:IsA("ParticleEmitter") or v:IsA("Trail") or v:IsA("Smoke")
            or v:IsA("Fire") or v:IsA("Sparkles") then
                if FPSBackup[v]==nil then FPSBackup[v]=v.Enabled end
                v.Enabled=false
            end
        end
        Lighting.GlobalShadows=false
        pcall(function() settings().Rendering.QualityLevel=Enum.QualityLevel.Level01 end)
    else
        for v,data in pairs(FPSBackup) do
            if v and v.Parent then
                pcall(function()
                    if v:IsA("BasePart") then
                        v.Material=data.Material
                        v.CastShadow=data.CastShadow
                    elseif typeof(data)=="boolean" then
                        v.Enabled=data
                    end
                end)
            end
        end
        table.clear(FPSBackup)
        Lighting.GlobalShadows=LightingBackup.GlobalShadows
    end
end

--==================================================
-- FULLBRIGHT
--==================================================
local function ApplyLighting()
    if State.Fullbright then
        Lighting.FogStart=100000
        Lighting.FogEnd=100000
        Lighting.Brightness=State.Brightness
        Lighting.ClockTime=State.ClockTime
        Lighting.GlobalShadows=false
        Lighting.Ambient=Color3.fromRGB(180,180,180)
        Lighting.OutdoorAmbient=Color3.fromRGB(180,180,180)
    else
        for k,v in pairs(LightingBackup) do
            pcall(function() Lighting[k]=v end)
        end
    end
end

--==================================================
-- ESP
--==================================================
local function ClearESP(tag)
    for _,v in ipairs(workspace:GetDescendants()) do
        if v.Name==tag and (v:IsA("Highlight") or v:IsA("BillboardGui")) then
            v:Destroy()
        end
    end
end

local function AddHighlight(model,tag,outlineColor)
    if not model or model:FindFirstChild(tag) then return end
    local h=Instance.new("Highlight")
    h.Name=tag
    h.Adornee=model
    h.FillTransparency=.72
    h.OutlineTransparency=0
    h.OutlineColor=outlineColor or Color3.new(1,1,1)
    h.DepthMode=Enum.HighlightDepthMode.AlwaysOnTop
    h.Parent=model
end

local function EnsureBillboard(model, adornee, tag, text, color)
    if not model or not adornee then return nil end
    local bb = model:FindFirstChild(tag)
    if not bb then
        bb = Instance.new("BillboardGui")
        bb.Name = tag
        bb.Size = UDim2.fromOffset(190,36)
        bb.StudsOffset = Vector3.new(0,3,0)
        bb.AlwaysOnTop = true
        bb.MaxDistance = math.huge
        bb.Adornee = adornee
        bb.Parent = model

        local label = Instance.new("TextLabel")
        label.Name = "ข้อความ"
        label.Size = UDim2.fromScale(1,1)
        label.BackgroundTransparency = 1
        label.TextStrokeTransparency = 0.25
        label.Font = Enum.Font.GothamBold
        label.TextSize = 13
        label.Parent = bb
    end
    local label = bb:FindFirstChild("ข้อความ")
    if label then
        label.Text = text or ""
        label.TextColor3 = color or Color3.new(1,1,1)
    end
    return bb
end

Track(RunService.Heartbeat:Connect(function()
    local myRoot = Root()

    if State.ESPPlayers then
        for _,p in ipairs(Players:GetPlayers()) do
            if p~=Player and p.Character then
                local head = p.Character:FindFirstChild("Head")
                local proot = p.Character:FindFirstChild("HumanoidRootPart")
                AddHighlight(p.Character,"XWACK_ESP_PLAYER",Color3.fromRGB(255,220,0))
                EnsureBillboard(
                    p.Character,
                    head or proot,
                    "XWACK_ESP_PLAYER_LABEL",
                    p.Name,
                    Color3.fromRGB(255,220,0)
                )
            end
        end
    end

    if State.ESPNPC then
        for _,m in ipairs(workspace:GetDescendants()) do
            if m:IsA("Model") and m:FindFirstChildOfClass("Humanoid") and not Players:GetPlayerFromCharacter(m) then
                local nroot = m:FindFirstChild("HumanoidRootPart") or m:FindFirstChild("Torso") or m:FindFirstChild("UpperTorso")
                local hum = m:FindFirstChildOfClass("Humanoid")
                if nroot and hum and hum.Health > 0 then
                    AddHighlight(m,"XWACK_ESP_NPC",Color3.fromRGB(255,255,255))
                    local dist = myRoot and math.floor((nroot.Position-myRoot.Position).Magnitude) or 0
                    EnsureBillboard(
                        m,
                        nroot,
                        "XWACK_ESP_NPC_LABEL",
                        (m.Name ~= "" and m.Name or "NPC").."  ["..dist.." เมตร]",
                        Color3.fromRGB(255,255,255)
                    )
                end
            end
        end
    end
end))

--==================================================
-- TOOL GIVER IN SAME UI
--==================================================
local FoundToolNames={}
local function FindTools()
    local list={}
    local seen={}
    for _,v in ipairs(game:GetDescendants()) do
        if v:IsA("Tool") and not seen[v.Name] then
            seen[v.Name]=true
            table.insert(list,v)
        end
    end
    table.sort(list,function(a,b) return a.Name:lower()<b.Name:lower() end)
    return list
end

local function CloneTool(tool)
    if not tool then return end
    local ok,clone=pcall(function() return tool:Clone() end)
    if ok and clone then
        clone.Parent=Player:WaitForChild("Backpack")
        Notify("เสก "..tool.Name.." แล้ว")
    end
end

--==================================================
-- CAR SPEED
--==================================================
local LastVehicle, OriginalVehicleMaxSpeed

local function StopCarSpeed()
    if LastVehicle and LastVehicle.Parent and OriginalVehicleMaxSpeed then
        pcall(function() LastVehicle.MaxSpeed = OriginalVehicleMaxSpeed end)
    end
    LastVehicle = nil
    OriginalVehicleMaxSpeed = nil
end

Track(RunService.Heartbeat:Connect(function()
    if not State.CarSpeedEnabled then return end
    local hum = Humanoid()
    if not hum then return end
    local seat = hum.SeatPart

    if seat and seat:IsA("VehicleSeat") then
        if LastVehicle ~= seat then
            StopCarSpeed()
            LastVehicle = seat
            OriginalVehicleMaxSpeed = seat.MaxSpeed
        end

        pcall(function()
            seat.MaxSpeed = State.CarSpeed
            if seat.Throttle ~= 0 then
                local y = seat.AssemblyLinearVelocity.Y
                local dir = seat.CFrame.LookVector * (seat.Throttle * State.CarSpeed)
                seat.AssemblyLinearVelocity = Vector3.new(dir.X,y,dir.Z)
            end
        end)
    end
end))

--==================================================
-- PULL PLAYERS
--==================================================
local SpawnTimes = {}
local PULL_SPAWN_DELAY = 6

local function TrackSpawn(plr)
    plr.CharacterAdded:Connect(function()
        SpawnTimes[plr] = tick()
    end)
end

for _,p in ipairs(Players:GetPlayers()) do TrackSpawn(p) end
Track(Players.PlayerAdded:Connect(TrackSpawn))

Track(RunService.RenderStepped:Connect(function()
    if not State.PullPlayers then return end
    local root = Root()
    if not root then return end

    local destination = root.Position + root.CFrame.LookVector * 5
    for _,other in ipairs(Players:GetPlayers()) do
        if other ~= Player and other.Character then
            local oroot = other.Character:FindFirstChild("HumanoidRootPart")
            local ohum = other.Character:FindFirstChildOfClass("Humanoid")
            if oroot and ohum and ohum.Health > 0 then
                local spawned = SpawnTimes[other]
                if not spawned or tick() - spawned >= PULL_SPAWN_DELAY then
                    pcall(function()
                        other.Character:PivotTo(CFrame.new(destination))
                    end)
                end
            end
        end
    end
end))

--==================================================
-- BLACKHOLE
--==================================================
local BHFolder, BHPart, BHTarget
local BHDescConnection
local BHControlled = {}

local function StopBlackhole()
    if BHDescConnection then
        BHDescConnection:Disconnect()
        BHDescConnection = nil
    end
    for part,data in pairs(BHControlled) do
        if part and part.Parent then
            pcall(function()
                part.CanCollide = data.CanCollide
                part.CustomPhysicalProperties = data.CustomPhysicalProperties
                for _,name in ipairs({"XWACK_BH_Torque","XWACK_BH_Align","XWACK_BH_Att"}) do
                    local x = part:FindFirstChild(name)
                    if x then x:Destroy() end
                end
            end)
        end
    end
    table.clear(BHControlled)
    if BHFolder then BHFolder:Destroy() end
    BHFolder,BHPart,BHTarget = nil,nil,nil
end

local function ForceBlackholePart(v)
    if not State.Blackhole then return end
    if not v:IsA("BasePart") or v.Anchored or BHControlled[v] then return end
    if v:IsDescendantOf(Character() or workspace) then
        if Character() and v:IsDescendantOf(Character()) then return end
    end
    if v.Parent and (v.Parent:FindFirstChildOfClass("Humanoid") or v.Name == "Handle") then return end

    BHControlled[v] = {
        CanCollide = v.CanCollide,
        CustomPhysicalProperties = v.CustomPhysicalProperties
    }

    pcall(function()
        v.CanCollide = false
        v.CustomPhysicalProperties = PhysicalProperties.new(0,0,0,0,0)

        local att = Instance.new("Attachment")
        att.Name = "XWACK_BH_Att"
        att.Parent = v

        local torque = Instance.new("Torque")
        torque.Name = "XWACK_BH_Torque"
        torque.Torque = Vector3.new(100000,100000,100000)
        torque.Attachment0 = att
        torque.Parent = v

        local align = Instance.new("AlignPosition")
        align.Name = "XWACK_BH_Align"
        align.MaxForce = 9e15
        align.MaxVelocity = math.huge
        align.Responsiveness = 200
        align.Attachment0 = att
        align.Attachment1 = BHTarget
        align.Parent = v
    end)
end

local function StartBlackhole()
    StopBlackhole()
    local root = Root()
    if not root then return end

    BHFolder = Instance.new("Folder")
    BHFolder.Name = "XWACK_BLACKHOLE"
    BHFolder.Parent = workspace

    BHPart = Instance.new("Part")
    BHPart.Name = "Target"
    BHPart.Anchored = true
    BHPart.CanCollide = false
    BHPart.Transparency = 1
    BHPart.Size = Vector3.new(1,1,1)
    BHPart.Parent = BHFolder

    BHTarget = Instance.new("Attachment")
    BHTarget.Parent = BHPart

    pcall(function()
        if sethiddenproperty then
            sethiddenproperty(Player,"SimulationRadius",math.huge)
        end
    end)

    for _,v in ipairs(workspace:GetDescendants()) do
        ForceBlackholePart(v)
    end

    BHDescConnection = workspace.DescendantAdded:Connect(function(v)
        if State.Blackhole then ForceBlackholePart(v) end
    end)
end

Track(RunService.RenderStepped:Connect(function()
    if State.Blackhole and BHPart then
        local root = Root()
        if root then
            BHPart.CFrame = root.CFrame * CFrame.new(0,0,-50)
        end
    end
end))

--==================================================
-- CHARACTER RESPAWN
--==================================================
Track(Player.CharacterAdded:Connect(function()
    task.wait(1)
    if State.Fly then StartFly() end
    if State.ClickTP then GiveClickTool() end
    if State.Invisible then SetInvisible(true) end
end))

--==================================================
-- BUILD UI
--==================================================
local Window=Library:NewWindow("RUNLUA-HUB STORE  |  SINGLE UI V4")

local MainTab=Window:NewTab("หลัก","🏠")
local AttackTab=Window:NewTab("โจมตี","⚔️")
local ToolTab=Window:NewTab("เครื่องมือ","🔧")
local FunTab=Window:NewTab("แกล้ง","🤡")
local EyeTab=Window:NewTab("ดวงตาเทพ","👁️")

MainTab:NewLabel("การเคลื่อนที่ / ตัวละคร")

MainTab:NewToggle("✈️ บิน",false,function(v)
    State.Fly=v
    if v then StartFly() else StopFly() end
end,"เปิดแล้วใช้ปุ่มเดินเพื่อบังคับทิศทาง กด Space เพื่อบินขึ้น และ Ctrl/C เพื่อบินลง ปรับความเร็วได้จากแถบด้านล่าง", {
    text = "ความเร็วบิน", min = 20, max = 300, default = 60,
    callback = function(v) State.FlySpeed = v end
})

MainTab:NewToggle("🦘 กระโดดไม่จำกัด",false,function(v)
    State.InfiniteJump=v
end,"เมื่อเปิด สามารถกดกระโดดซ้ำกลางอากาศได้")

MainTab:NewToggle("🏃 วิ่งเร็ว",false,function(v)
    State.Speed=v
    if not v then
        local h=Humanoid()
        if h then h.WalkSpeed=16 end
    end
end,"เปิดเพื่อบังคับความเร็วเดินตามค่าที่ตั้งในแถบ ความเร็วเดิน ด้านล่าง", {
    text = "ความเร็วเดิน", min = 16, max = 500, default = 100,
    callback = function(v) State.WalkSpeed = v end
})

MainTab:NewToggle("🖱️ วาร์ปตามจุดที่กด",false,function(v)
    State.ClickTP=v
    if v then GiveClickTool() else RemoveClickTool() end
end,"เปิดแล้วจะมี Tool ชื่อ RUNLUA-HUB Click TP ในกระเป๋า ถือ Tool แล้วแตะ/คลิกจุดที่ต้องการวาร์ป")

MainTab:NewToggle("🚪 เดินทะลุกำแพง",false,function(v)
    State.Noclip=v
    if not v then RestoreCollision() end
end,"เปิดเพื่อปิดการชนของชิ้นส่วนตัวละคร ทำให้เดินผ่านกำแพงหรือวัตถุบางชนิดได้")

MainTab:NewToggle("👻 หายตัว",false,function(v)
    State.Invisible=v
    SetInvisible(v)
end,"ซ่อนชิ้นส่วนตัวละครฝั่งเครื่องคุณ เหมาะกับการซ่อนภาพตัวละครในหน้าจอของคุณ บางเกมอาจไม่ซิงก์ให้คนอื่นเห็น")

MainTab:NewToggle("🛡️ โหมดอมตะ บางแมพ",false,function(v)
    State.God=v
end,"พยายามรักษาเลือดไว้สูงสุดและป้องกันการตายแบบ Humanoid บางเกมใช้ระบบเลือดฝั่งเซิร์ฟเวอร์จึงอาจไม่สำเร็จ")

AttackTab:NewLabel("ระบบต่อสู้")

AttackTab:NewToggle("🎯 ล็อคหัวผู้เล่น",false,function(v)
    State.Aimbot=v
end,"เมื่อเปิด กล้องจะหันไปยังศีรษะผู้เล่นที่อยู่ใกล้กลางจอที่สุดภายในขอบเขต FOV", {
    text = "ขอบเขตล็อคหัว (FOV)", min = 5, max = 100, default = 20,
    callback = function(v) State.FOV = v end
})

AttackTab:NewToggle("💀 ฆ่าบอทใกล้ตัว",false,function(v)
    State.KillAura=v
end,"พยายามตั้งเลือด NPC ที่อยู่ในระยะให้เป็น 0 ใช้ได้เฉพาะเกมที่ยอมให้ฝั่ง Client เปลี่ยนค่า Humanoid", {
    text = "ระยะฆ่าบอท", min = 10, max = 500, default = 100,
    callback = function(v) State.KillRange = v end
})

AttackTab:NewToggle("📦 ขยาย Hitbox ผู้เล่น",false,function(v)
    State.Hitbox=v
    if not v then ResetHitbox() end
end,"ขยาย HumanoidRootPart ของผู้เล่นอื่น เพื่อทำให้พื้นที่โดนกว้างขึ้น ปิดแล้วจะพยายามคืนค่าขนาดเดิม", {
    text = "ขนาด Hitbox", min = 2, max = 100, default = 20,
    callback = function(v) State.HitboxSize = v end
})

ToolTab:NewLabel("ประสิทธิภาพ / แสง")

ToolTab:NewToggle("🚀 ลดกราฟิก เพิ่ม FPS",false,function(v)
    State.FPSBoost=v
    ApplyFPSBoost(v)
end,"ลด Material เงา Particle และเอฟเฟกต์บางส่วนเพื่อช่วยลดภาระการเรนเดอร์ ปิดแล้วจะพยายามคืนค่าที่บันทึกไว้")

ToolTab:NewToggle("💡 ทำแมพสว่าง",false,function(v)
    State.Fullbright=v
    ApplyLighting()
end,"เปิดเพื่อใช้ค่าความสว่างและเวลาที่ตั้งด้านล่าง พร้อมลดหมอก", {
    text = "ความสว่าง", min = 0, max = 10, default = 2,
    callback = function(v)
        State.Brightness = v
        ApplyLighting()
    end
})

ToolTab:NewLabel("รถ")

ToolTab:NewToggle("🚗 เพิ่มความเร็วรถ",false,function(v)
    State.CarSpeedEnabled=v
    if not v then StopCarSpeed() end
end,"นั่ง VehicleSeat แล้วเปิด ระบบจะบังคับ MaxSpeed และความเร็วรถต่อเนื่องตามค่าด้านล่าง", {
    text = "ความเร็วรถ", min = 20, max = 500, default = 150,
    callback = function(v) State.CarSpeed = v end
})

ToolTab:NewLabel("หยิบของเร็ว | E")

local InstantPromptEnabled = false
local OriginalHoldDuration = {}

ToolTab:NewToggle("🥅 หยิบของเร็ว | E", false, function(state)
    InstantPromptEnabled = state

    if state then
        -- เปิด: ทำ ProximityPrompt ที่มีอยู่ทั้งหมดให้กดทันที
        for _, prompt in ipairs(game:GetService("Workspace"):GetDescendants()) do
            if prompt:IsA("ProximityPrompt") then
                if OriginalHoldDuration[prompt] == nil then
                    OriginalHoldDuration[prompt] = prompt.HoldDuration
                end

                prompt.HoldDuration = 0
            end
        end
    else
        -- ปิด: คืนค่า HoldDuration เดิม
        for prompt, oldDuration in pairs(OriginalHoldDuration) do
            if prompt and prompt.Parent then
                prompt.HoldDuration = oldDuration
            end
        end

        table.clear(OriginalHoldDuration)
    end
end, "เปิดแล้วสิ่งที่ต้องกด E หรือกดค้าง จะกดได้ทันที / ปิดแล้วคืนค่าดีเลย์เดิม")


ToolTab:NewLabel("เสกของ / Tool Giver")
ToolTab:NewButton("🔄 สแกนของในแมพ",function()
    local tools=FindTools()
    local added=0
    for _,tool in ipairs(tools) do
        if not FoundToolNames[tool.Name] then
            FoundToolNames[tool.Name]=true
            added+=1
            ToolTab:NewButton("🎒 เสก "..tool.Name,function()
                CloneTool(tool)
            end,"กดเพื่อ Clone Tool ชื่อนี้เข้า Backpack ของคุณ ใช้ได้เฉพาะ Tool ที่มีอยู่และ Clone ได้จากฝั่ง Client")
        end
    end
    Notify("พบของใหม่ "..added.." รายการ")
end,"สแกน Tool ที่มีอยู่ในเกม แล้วเพิ่มรายการของไว้ในแท็บนี้โดยตรง ไม่สร้าง UI แยก")

EyeTab:NewLabel("มองผู้เล่น / NPC")

EyeTab:NewToggle("👁️ มองทะลุ ผู้เล่น",false,function(v)
    State.ESPPlayers=v
    if not v then
        ClearESP("XWACK_ESP_PLAYER")
        ClearESP("XWACK_ESP_PLAYER_LABEL")
    end
end,"แสดงเส้นขอบสีเหลืองและชื่อผู้เล่น แม้มีสิ่งกีดขวาง")

EyeTab:NewToggle("🤖 มองทะลุ NPC ",false,function(v)
    State.ESPNPC=v
    if not v then
        ClearESP("XWACK_ESP_NPC")
        ClearESP("XWACK_ESP_NPC_LABEL")
    end
end,"ค้นหา Model ที่มี Humanoid แต่ไม่ใช่ผู้เล่น แล้วแสดงเส้นขอบ ชื่อ และระยะทาง")

FunTab:NewLabel("ระบบแกล้ง")

FunTab:NewToggle("🧲 ดึงผู้เล่นมาใกล้ตัว",false,function(v)
    State.PullPlayers=v
end,"พยายามย้ายตัวละครผู้เล่นอื่นมาไว้ด้านหน้าคุณประมาณ 5 Stud ระบบจะข้ามผู้เล่นที่เพิ่งเกิดประมาณ 6 วินาที")

FunTab:NewToggle("🕳️ หลุมดำดูดของ",false,function(v)
    State.Blackhole=v
    if v then StartBlackhole() else StopBlackhole() end
end,"ดึงชิ้นส่วนฟิสิกส์ที่ไม่ Anchored และไม่ใช่ตัวละครเข้าหาจุดด้านหน้าคุณประมาณ 50 Stud บางเกมอาจไม่ซิงก์เพราะ Network Ownership")

--==================================================
-- ฟังก์ชันที่ต้องเรียกต้นฉบับโดยตรง
--==================================================
local function SafeLoad(url)
    local ok,err=pcall(function()
        local src=game:HttpGet(url)
        local fn=loadstring(src)
        if fn then fn() end
    end)
    if not ok then
        Notify("โหลดไม่สำเร็จ")
        warn(err)
    end
end

FunTab:NewButton("💥 ชนผู้เล่นกระเด็น",function()
    SafeLoad("https://raw.githubusercontent.com/wackshopr-tech/script-roblox-all/refs/heads/main/SCRIPT-ALL-BY-WACK-SHOP/FLINGCORE/FLINGCORE.lua")
end,"ต้นฉบับไฟล์นี้ถูกเข้ารหัส/Obfuscate จึงเรียกต้นฉบับโดยตรงเมื่อกด")

FunTab:NewToggle("👕 ถอดเสื้อผ้า หีนมใหญ่", false, function(v)
    if v then
        loadstring(game:HttpGet(
            "https://raw.githubusercontent.com/clemonlang/clemon_roclothes/refs/heads/main/ClemonRC.lua"
        ))()
    end
end, "เปิด Clemon RoClothes")

FunTab:NewToggle("🤚 ชักว่าว", false, function(v)
    local Players = game:GetService("Players")
    local player = Players.LocalPlayer

    if v then
        local char = player.Character or player.CharacterAdded:Wait()
        local hum = char:FindFirstChildOfClass("Humanoid")
        if not hum then return end

        -- ตรวจว่าเป็น R6 หรือยัง
        if hum.RigType ~= Enum.HumanoidRigType.R6 then
            warn("กำลังเปลี่ยนเป็น R6...")

            -- พยายามเปลี่ยน Avatar เป็น R6
            local desc = hum:GetAppliedDescription()

            local success = pcall(function()
                player:LoadCharacterWithHumanoidDescription(
                    desc,
                    Enum.HumanoidRigType.R6
                )
            end)

            if not success then
                warn("ไม่สามารถเปลี่ยนเป็น R6 จากฝั่ง Client ได้")
                return
            end

            -- รอตัวละครใหม่
            char = player.CharacterAdded:Wait()
            hum = char:WaitForChild("Humanoid")
        end

        -- ตอนนี้ต้องเป็น R6 แล้วค่อยเล่น Animation
        if hum.RigType == Enum.HumanoidRigType.R6 then
            local anim = Instance.new("Animation")
            anim.AnimationId = "rbxassetid://72042024"

            getgenv().FunTrack = hum:LoadAnimation(anim)
            getgenv().FunTrack.Looped = true
            getgenv().FunTrack:Play()
        end

    else
        if getgenv().FunTrack then
            getgenv().FunTrack:Stop()
            getgenv().FunTrack = nil
        end
    end
end, "เปิด = เช็ก R6 แล้วเล่นว่าว / ปิด = หยุด")

FunTab:NewButton("🧱 เครื่องมือ F3X",function()
    SafeLoad("https://pastebin.com/raw/FZmTykdY")
end,"กดเพื่อโหลดเครื่องมือ F3X จากแหล่งเดิม")

ToolTab:NewLabel("เครื่องมือคำสั่ง")

ToolTab:NewButton("⌨️ แป้นพิมพ์บนหน้าจอ",function()
    SafeLoad("https://raw.githubusercontent.com/Xxtan31/Ata/main/deltakeyboardcrack.txt")
end,"เปิดแป้นพิมพ์เสริมของสคริปต์ต้นฉบับ ฟังก์ชันนี้จำเป็นต้องมีหน้าต่างของตัวเองเพื่อใช้เป็นคีย์บอร์ด")

ToolTab:NewButton("🚀 เข้าเซิร์ฟเวอร์คนน้อย",function()
    SafeLoad("https://raw.githubusercontent.com/runluahub-create/All-map/refs/heads/main/Low%20Population%20Server%20Finder")
end,"จะเข้าเซิฟเวอร์ทีีมีคนน้อยใช้งานได้ทุกแมพ")

ToolTab:NewButton("♾️ Infinite Yield",function()
    SafeLoad("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source")
end,"กดแล้วเปิด Infinite Yield ของเดิมทันที ตามที่กำหนดไว้ ไม่ถูกย้ายคำสั่งเข้ามาใน UI หลัก")

ToolTab:NewButton("💻 Quirky CMD",function()
    SafeLoad("https://gist.github.com/someunknowndude/38cecea5be9d75cb743eac8b1eaf6758/raw")
end,"กดแล้วเปิด Quirky CMD ของเดิมทันที ตามที่กำหนดไว้")

Notify("RUNLUA-HUB UI โหลดเสร็จแล้ว!")
print("RUNLUA-HUB UI READY")

    )
end)

NewBtn.MouseButton1Click:Connect(function()
    RunScript(
        
if not game:IsLoaded() then game.Loaded:Wait() end

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")
local StarterGui = game:GetService("StarterGui")
local CoreGui = game:GetService("CoreGui")

local Player = Players.LocalPlayer
local Camera = workspace.CurrentCamera
local Mouse = Player:GetMouse()

--==================================================
-- CLEANUP
--==================================================
pcall(function()
    local old = CoreGui:FindFirstChild("RUNLUA-HUB_STORE")
    if old then old:Destroy() end
end)

local Connections = {}
local function Track(c)
    table.insert(Connections, c)
    return c
end

local function DisconnectAll()
    for _, c in ipairs(Connections) do
        pcall(function() c:Disconnect() end)
    end
    table.clear(Connections)
end

local function Notify(text)
    pcall(function()
        StarterGui:SetCore("SendNotification", {
            Title = "RUNLUA HUB",
            Text = text,
            Duration = 3
        })
    end)
end

local function Character()
    return Player.Character
end

local function Humanoid()
    local c = Character()
    return c and c:FindFirstChildOfClass("Humanoid")
end

local function Root()
    local c = Character()
    return c and c:FindFirstChild("HumanoidRootPart")
end

--==================================================
-- UI LIBRARY
--==================================================
local Library = {}

local function Corner(obj, radius)
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, radius or 8)
    c.Parent = obj
    return c
end

local function Stroke(obj, color, transparency)
    local s = Instance.new("UIStroke")
    s.Color = color or Color3.fromRGB(0, 210, 255)
    s.Thickness = 1
    s.Transparency = transparency or 0.75
    s.Parent = obj
    return s
end

local function ShowHelp(titleText, bodyText)
    local old = CoreGui:FindFirstChild("XWACK_HELP_POPUP")
    if old then old:Destroy() end

    local gui = Instance.new("ScreenGui")
    gui.Name = "XWACK_HELP_POPUP"
    gui.ResetOnSpawn = false
    gui.IgnoreGuiInset = true
    gui.ZIndexBehavior = Enum.ZIndexBehavior.Global
    gui.Parent = CoreGui

    local shade = Instance.new("TextButton")
    shade.Size = UDim2.fromScale(1,1)
    shade.Text = ""
    shade.AutoButtonColor = false
    shade.BackgroundColor3 = Color3.new(0,0,0)
    shade.BackgroundTransparency = 0.35
    shade.BorderSizePixel = 0
    shade.ZIndex = 900
    shade.Parent = gui

    local box = Instance.new("Frame")
    box.AnchorPoint = Vector2.new(0.5,0.5)
    box.Position = UDim2.fromScale(0.5,0.5)
    box.Size = UDim2.new(0.78,0,0,190)
    box.BackgroundColor3 = Color3.fromRGB(20,22,30)
    box.BorderSizePixel = 0
    box.ZIndex = 901
    box.Parent = gui
    Corner(box,12)
    Stroke(box,Color3.fromRGB(0,210,255),0.25)

    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1,-48,0,40)
    title.Position = UDim2.fromOffset(14,4)
    title.BackgroundTransparency = 1
    title.Text = "วิธีใช้: "..tostring(titleText)
    title.TextColor3 = Color3.new(1,1,1)
    title.Font = Enum.Font.GothamBold
    title.TextSize = 15
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.ZIndex = 902
    title.Parent = box

    local body = Instance.new("TextLabel")
    body.Size = UDim2.new(1,-28,1,-58)
    body.Position = UDim2.fromOffset(14,46)
    body.BackgroundTransparency = 1
    body.Text = tostring(bodyText or "ไม่มีคำอธิบาย")
    body.TextColor3 = Color3.fromRGB(205,210,225)
    body.Font = Enum.Font.Gotham
    body.TextSize = 13
    body.TextWrapped = true
    body.TextXAlignment = Enum.TextXAlignment.Left
    body.TextYAlignment = Enum.TextYAlignment.Top
    body.ZIndex = 902
    body.Parent = box

    local close = Instance.new("TextButton")
    close.Size = UDim2.fromOffset(28,28)
    close.Position = UDim2.new(1,-36,0,8)
    close.Text = "✕"
    close.Font = Enum.Font.GothamBold
    close.TextSize = 13
    close.TextColor3 = Color3.new(1,1,1)
    close.BackgroundColor3 = Color3.fromRGB(255,55,80)
    close.BorderSizePixel = 0
    close.ZIndex = 903
    close.Parent = box
    Corner(close,7)

    close.MouseButton1Click:Connect(function() gui:Destroy() end)
    shade.MouseButton1Click:Connect(function() gui:Destroy() end)
end

local function AddHelpButton(parent, titleText, helpText, yScale, yOffset)
    if not helpText or helpText == "" then return end
    local q = Instance.new("TextButton")
    q.Name = "Help"
    q.Size = UDim2.fromOffset(24,24)
    q.Position = UDim2.new(1,-30,yScale or 0.5,yOffset or -12)
    q.Text = "?"
    q.Font = Enum.Font.GothamBold
    q.TextSize = 13
    q.TextColor3 = Color3.fromRGB(0,210,255)
    q.BackgroundColor3 = Color3.fromRGB(38,42,56)
    q.BorderSizePixel = 0
    q.ZIndex = 20
    q.Parent = parent
    Corner(q,12)
    q.MouseButton1Click:Connect(function()
        ShowHelp(titleText,helpText)
    end)
end

local function MakeDraggable(frame, handle)
    local dragging = false
    local dragInput, dragStart, startPos

    Track(handle.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = frame.Position
            Track(input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end))
        end
    end))

    Track(handle.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement
        or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end))

    Track(UIS.InputChanged:Connect(function(input)
        if dragging and input == dragInput and frame.Parent then
            local delta = input.Position - dragStart
            frame.Position = UDim2.new(
                startPos.X.Scale, startPos.X.Offset + delta.X,
                startPos.Y.Scale, startPos.Y.Offset + delta.Y
            )
        end
    end))
end

function Library:NewWindow(title)
    local Gui = Instance.new("ScreenGui")
    Gui.Name = "RUNLUA-HUB"
    Gui.ResetOnSpawn = false
    Gui.IgnoreGuiInset = false
    Gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    Gui.Parent = CoreGui

    local Main = Instance.new("Frame")
    Main.Name = "RUNLUA_HUB_MainFrame"
    Main.Size = UDim2.fromOffset(500, 330)
    Main.Position = UDim2.new(0.5, -250, 0.5, -165)
    Main.BackgroundColor3 = Color3.fromRGB(15, 16, 22)
    Main.BorderSizePixel = 0
    Main.ClipsDescendants = false
    Main.Parent = Gui
    Corner(Main, 11)

    local mainStroke = Stroke(Main, Color3.fromRGB(0,210,255), 0.25)
    mainStroke.Thickness = 1.3

    local gradient = Instance.new("UIGradient")
    gradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(0,210,255)),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255,0,130)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(0,210,255))
    })
    gradient.Parent = mainStroke

    task.spawn(function()
        local r = 0
        while Gui.Parent do
            task.wait(0.04)
            r = (r + 2) % 360
            gradient.Rotation = r
        end
    end)

    local TitleBar = Instance.new("Frame")
    TitleBar.Size = UDim2.new(1,0,0,38)
    TitleBar.BackgroundColor3 = Color3.fromRGB(20,22,30)
    TitleBar.BorderSizePixel = 0
    TitleBar.Parent = Main
    Corner(TitleBar, 10)

    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(1,-80,1,0)
    Title.Position = UDim2.fromOffset(14,0)
    Title.BackgroundTransparency = 1
    Title.Text = title
    Title.TextColor3 = Color3.new(1,1,1)
    Title.Font = Enum.Font.GothamBold
    Title.TextSize = 14
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.Parent = TitleBar

    local Close = Instance.new("TextButton")
    Close.Size = UDim2.fromOffset(24,24)
    Close.Position = UDim2.new(1,-32,0,7)
    Close.Text = "✕"
    Close.Font = Enum.Font.GothamBold
    Close.TextSize = 12
    Close.TextColor3 = Color3.new(1,1,1)
    Close.BackgroundColor3 = Color3.fromRGB(255,45,75)
    Close.BorderSizePixel = 0
    Close.Parent = TitleBar
    Corner(Close,6)

    --==================================================
    -- LOGO TOGGLE BUTTON (แทนปุ่ม W/X เดิม)
    --==================================================
    local Mini = Instance.new("ImageButton")
    Mini.Name = "TogglePill"
    Mini.BackgroundTransparency = 1
    Mini.BorderSizePixel = 0
    Mini.ClipsDescendants = true
    Mini.ZIndex = 10
    Mini.AutoButtonColor = false
    Mini.AnchorPoint = Vector2.new(0.5, 1)
    Mini.Position = UDim2.new(0.1, 10, 0.25, 5)
    Mini.Size = UDim2.fromOffset(54, 54)
    Mini.Visible = true
    Mini.ImageTransparency = 0.05
    Mini.ScaleType = Enum.ScaleType.Crop
    Mini.Parent = Gui

    local MiniCorner = Instance.new("UICorner")
    MiniCorner.CornerRadius = UDim.new(0, 6)
    MiniCorner.Parent = Mini

    local MiniStroke = Instance.new("UIStroke")
    MiniStroke.Color = Color3.fromRGB(0, 210, 255)
    MiniStroke.Thickness = 2.5
    MiniStroke.Parent = Mini

    -- โหลดโลโก้จาก URL และ cache ไว้ในเครื่อง ถ้า executor รองรับ
    task.spawn(function()
        pcall(function()
            local imageUrl = "https://i.postimg.cc/cJKhRc1r/IMG-20260904-201616-447.png"
            local fileName = "RUNLUA.png"

            if isfile and writefile and readfile and getcustomasset then
                if not isfile(fileName) then
                    local imgData = game:HttpGet(imageUrl)
                    if imgData and #imgData > 0 then
                        writefile(fileName, imgData)
                    end
                end

                if isfile(fileName) then
                    Mini.Image = getcustomasset(fileName)
                else
                    Mini.Image = imageUrl
                end
            else
                Mini.Image = imageUrl
            end
        end)
    end)

    MakeDraggable(Mini, Mini)

    local function UpdateMiniStroke()
        TweenService:Create(MiniStroke, TweenInfo.new(0.15), {
            Color = Main.Visible
                and Color3.fromRGB(0, 210, 255)
                or Color3.fromRGB(200, 10, 40)
        }):Play()
    end

    Track(Mini.MouseButton1Click:Connect(function()
        Main.Visible = not Main.Visible
        UpdateMiniStroke()
    end))

    UpdateMiniStroke()

    local Sidebar = Instance.new("Frame")
    Sidebar.Size = UDim2.new(0,135,1,-46)
    Sidebar.Position = UDim2.fromOffset(4,42)
    Sidebar.BackgroundColor3 = Color3.fromRGB(18,19,26)
    Sidebar.BorderSizePixel = 0
    Sidebar.Parent = Main
    Corner(Sidebar,8)

    local TabList = Instance.new("ScrollingFrame")
    TabList.Size = UDim2.new(1,-6,1,-8)
    TabList.Position = UDim2.fromOffset(3,4)
    TabList.BackgroundTransparency = 1
    TabList.BorderSizePixel = 0
    TabList.ScrollBarThickness = 2
    TabList.AutomaticCanvasSize = Enum.AutomaticSize.Y
    TabList.CanvasSize = UDim2.new()
    TabList.Parent = Sidebar

    local tabLayout = Instance.new("UIListLayout")
    tabLayout.Padding = UDim.new(0,4)
    tabLayout.Parent = TabList

    local Content = Instance.new("Frame")
    Content.Size = UDim2.new(1,-149,1,-46)
    Content.Position = UDim2.fromOffset(145,42)
    Content.BackgroundTransparency = 1
    Content.Parent = Main

    local tabs = {}
    local Window = {}

    function Window:NewTab(name, icon)
        local TabButton = Instance.new("TextButton")
        TabButton.Size = UDim2.new(1,0,0,31)
        TabButton.BackgroundColor3 = Color3.fromRGB(24,26,36)
        TabButton.BackgroundTransparency = 0.55
        TabButton.BorderSizePixel = 0
        TabButton.Text = "  "..(icon or "").."  "..name
        TabButton.TextColor3 = Color3.fromRGB(175,180,195)
        TabButton.Font = Enum.Font.GothamBold
        TabButton.TextSize = 12
        TabButton.TextXAlignment = Enum.TextXAlignment.Left
        TabButton.Parent = TabList
        Corner(TabButton,6)
        local ts = Stroke(TabButton, Color3.fromRGB(0,210,255), 1)

        local Page = Instance.new("ScrollingFrame")
        Page.Size = UDim2.new(1,-4,1,0)
        Page.BackgroundTransparency = 1
        Page.BorderSizePixel = 0
        Page.ScrollBarThickness = 2
        Page.ScrollBarImageColor3 = Color3.fromRGB(0,210,255)
        Page.AutomaticCanvasSize = Enum.AutomaticSize.Y
        Page.CanvasSize = UDim2.new()
        Page.Visible = false
        Page.Parent = Content

        local layout = Instance.new("UIListLayout")
        layout.Padding = UDim.new(0,6)
        layout.Parent = Page

        local pad = Instance.new("UIPadding")
        pad.PaddingBottom = UDim.new(0,8)
        pad.Parent = Page

        local function Select()
            for _, t in ipairs(tabs) do
                t.Page.Visible = false
                t.Button.BackgroundTransparency = 0.55
                t.Button.TextColor3 = Color3.fromRGB(175,180,195)
                t.Stroke.Transparency = 1
            end
            Page.Visible = true
            TabButton.BackgroundTransparency = 0
            TabButton.TextColor3 = Color3.new(1,1,1)
            ts.Transparency = 0
        end

        Track(TabButton.MouseButton1Click:Connect(Select))
        table.insert(tabs,{Button=TabButton,Page=Page,Stroke=ts})

        if #tabs == 1 then task.defer(Select) end

        local Tab = {}

        function Tab:NewLabel(text)
            local L = Instance.new("TextLabel")
            L.Size = UDim2.new(1,-6,0,26)
            L.BackgroundTransparency = 1
            L.Text = text
            L.TextColor3 = Color3.fromRGB(120,180,255)
            L.Font = Enum.Font.GothamBold
            L.TextSize = 12
            L.TextXAlignment = Enum.TextXAlignment.Left
            L.Parent = Page
            return L
        end

        function Tab:NewButton(text, callback, helpText)
            local B = Instance.new("TextButton")
            B.Size = UDim2.new(1,-6,0,34)
            B.BackgroundColor3 = Color3.fromRGB(24,27,38)
            B.BorderSizePixel = 0
            B.Text = "   "..text
            B.TextColor3 = Color3.fromRGB(240,242,250)
            B.Font = Enum.Font.GothamMedium
            B.TextSize = 12
            B.TextXAlignment = Enum.TextXAlignment.Left
            B.Parent = Page
            Corner(B,7)
            Stroke(B, Color3.fromRGB(0,210,255), 0.82)

            AddHelpButton(B,text,helpText,0.5,-12)

            Track(B.MouseButton1Click:Connect(function()
                if callback then
                    local ok, err = pcall(callback)
                    if not ok then warn("[Runlua] "..tostring(err)) end
                end
            end))
            return B
        end

        -- ปรับปรุง NewToggle + Slider ในตัวเดียวกัน
        function Tab:NewToggle(text, default, callback, helpText, sliderConfig)
            local state = default == true

            local Container = Instance.new("Frame")
            Container.Size = UDim2.new(1, -6, 0, 38)
            Container.BackgroundTransparency = 1
            Container.Parent = Page

            local containerLayout = Instance.new("UIListLayout")
            containerLayout.SortOrder = Enum.SortOrder.LayoutOrder
            containerLayout.Padding = UDim.new(0, 4)
            containerLayout.Parent = Container

            local Holder = Instance.new("TextButton")
            Holder.Size = UDim2.new(1, 0, 0, 38)
            Holder.BackgroundColor3 = Color3.fromRGB(24,27,38)
            Holder.BorderSizePixel = 0
            Holder.Text = ""
            Holder.LayoutOrder = 1
            Holder.Parent = Container
            Corner(Holder,7)
            Stroke(Holder, Color3.fromRGB(0,210,255), 0.82)

            local L = Instance.new("TextLabel")
            L.Size = UDim2.new(1,-72,1,0)
            L.Position = UDim2.fromOffset(10,0)
            L.BackgroundTransparency = 1
            L.Text = text
            L.TextColor3 = Color3.fromRGB(240,242,250)
            L.Font = Enum.Font.GothamMedium
            L.TextSize = 12
            L.TextXAlignment = Enum.TextXAlignment.Left
            L.Parent = Holder

            local Switch = Instance.new("Frame")
            Switch.Size = UDim2.fromOffset(48,22)
            Switch.Position = UDim2.new(1,-88,0.5,-11)
            Switch.BackgroundColor3 = state and Color3.fromRGB(0,180,130) or Color3.fromRGB(60,64,76)
            Switch.BorderSizePixel = 0
            Switch.Parent = Holder
            Corner(Switch,11)

            local Dot = Instance.new("Frame")
            Dot.Size = UDim2.fromOffset(18,18)
            Dot.Position = state and UDim2.fromOffset(28,2) or UDim2.fromOffset(2,2)
            Dot.BackgroundColor3 = Color3.new(1,1,1)
            Dot.BorderSizePixel = 0
            Dot.Parent = Switch
            Corner(Dot,9)

            AddHelpButton(Holder,text,helpText,0.5,-12)

            local SliderObj = nil

            local function UpdateContainerSize()
                local totalY = 38
                if SliderObj and SliderObj.Holder.Visible then
                    totalY = totalY + 4 + SliderObj.Holder.Size.Y.Offset
                end
                Container.Size = UDim2.new(1, -6, 0, totalY)
            end

            local function Render()
                TweenService:Create(Switch,TweenInfo.new(.15),{
                    BackgroundColor3 = state and Color3.fromRGB(0,180,130) or Color3.fromRGB(60,64,76)
                }):Play()
                TweenService:Create(Dot,TweenInfo.new(.15),{
                    Position = state and UDim2.fromOffset(28,2) or UDim2.fromOffset(2,2)
                }):Play()

                if SliderObj then
                    SliderObj.Holder.Visible = state
                    UpdateContainerSize()
                end
            end

            local function Set(v)
                state = v == true
                Render()
                if callback then
                    local ok, err = pcall(callback,state)
                    if not ok then warn("[Runlua Toggle] "..tostring(err)) end
                end
            end

            Track(Holder.MouseButton1Click:Connect(function()
                Set(not state)
            end))

            -- หากมี Slider ในระบบ: เส้นลาก + ปุ่มลาก + ช่องกรอกตัวเลข
            if sliderConfig then
                local minValue = tonumber(sliderConfig.min) or 0
                local maxValue = tonumber(sliderConfig.max) or 100
                local increment = tonumber(sliderConfig.increment) or 1
                local value = math.clamp(tonumber(sliderConfig.default) or minValue, minValue, maxValue)

                local SHolder = Instance.new("Frame")
                SHolder.Size = UDim2.new(1, 0, 0, 62)
                SHolder.BackgroundColor3 = Color3.fromRGB(18, 20, 29)
                SHolder.BorderSizePixel = 0
                SHolder.LayoutOrder = 2
                SHolder.Visible = state
                SHolder.Parent = Container
                Corner(SHolder, 7)
                Stroke(SHolder, Color3.fromRGB(0,180,255), 0.9)

                local SL = Instance.new("TextLabel")
                SL.Size = UDim2.new(1, -92, 0, 24)
                SL.Position = UDim2.fromOffset(10, 3)
                SL.BackgroundTransparency = 1
                SL.Text = sliderConfig.text or "ปรับค่า"
                SL.TextColor3 = Color3.fromRGB(180, 190, 210)
                SL.Font = Enum.Font.Gotham
                SL.TextSize = 11
                SL.TextXAlignment = Enum.TextXAlignment.Left
                SL.Parent = SHolder

                local InputBox = Instance.new("TextBox")
                InputBox.Size = UDim2.fromOffset(72, 24)
                InputBox.Position = UDim2.new(1, -82, 0, 3)
                InputBox.BackgroundColor3 = Color3.fromRGB(28, 31, 43)
                InputBox.BorderSizePixel = 0
                InputBox.ClearTextOnFocus = false
                InputBox.Text = tostring(value)
                InputBox.PlaceholderText = tostring(minValue).."-"..tostring(maxValue)
                InputBox.TextColor3 = Color3.fromRGB(0, 210, 255)
                InputBox.PlaceholderColor3 = Color3.fromRGB(105, 115, 135)
                InputBox.Font = Enum.Font.GothamBold
                InputBox.TextSize = 11
                InputBox.Parent = SHolder
                Corner(InputBox, 6)
                Stroke(InputBox, Color3.fromRGB(0,180,255), 0.82)

                local SBar = Instance.new("Frame")
                SBar.Size = UDim2.new(1, -32, 0, 6)
                SBar.Position = UDim2.new(0, 16, 1, -18)
                SBar.BackgroundColor3 = Color3.fromRGB(45, 50, 65)
                SBar.BorderSizePixel = 0
                SBar.Active = true
                SBar.Parent = SHolder
                Corner(SBar, 3)

                local SFill = Instance.new("Frame")
                SFill.BackgroundColor3 = Color3.fromRGB(0, 180, 255)
                SFill.BorderSizePixel = 0
                SFill.Parent = SBar
                Corner(SFill, 3)

                local Knob = Instance.new("Frame")
                Knob.AnchorPoint = Vector2.new(0.5, 0.5)
                Knob.Size = UDim2.fromOffset(16, 16)
                Knob.BackgroundColor3 = Color3.fromRGB(235, 245, 255)
                Knob.BorderSizePixel = 0
                Knob.ZIndex = 3
                Knob.Parent = SBar
                Corner(Knob, 8)
                Stroke(Knob, Color3.fromRGB(0,180,255), 0.25)

                local dragging = false

                local function RoundToIncrement(v)
                    if increment <= 0 then return v end
                    return math.floor((v / increment) + 0.5) * increment
                end

                local function FormatValue(v)
                    if increment >= 1 then return tostring(math.floor(v + 0.5)) end
                    local txt = string.format("%.3f", v)
                    txt = txt:gsub("0+$", ""):gsub("%.$", "")
                    return txt
                end

                local function SRender()
                    local range = maxValue - minValue
                    local alpha = range ~= 0 and ((value - minValue) / range) or 0
                    alpha = math.clamp(alpha, 0, 1)
                    SFill.Size = UDim2.new(alpha, 0, 1, 0)
                    Knob.Position = UDim2.new(alpha, 0, 0.5, 0)
                    InputBox.Text = FormatValue(value)
                end

                local function ApplyValue(newValue, fireCallback)
                    newValue = tonumber(newValue)
                    if not newValue then
                        SRender()
                        return
                    end
                    value = math.clamp(RoundToIncrement(newValue), minValue, maxValue)
                    SRender()
                    if fireCallback ~= false and sliderConfig.callback then
                        local ok, err = pcall(sliderConfig.callback, value)
                        if not ok then warn("[RUNLUA Slider] "..tostring(err)) end
                    end
                end

                local function SetFromX(x)
                    if SBar.AbsoluteSize.X <= 0 then return end
                    local alpha = math.clamp((x - SBar.AbsolutePosition.X) / SBar.AbsoluteSize.X, 0, 1)
                    ApplyValue(minValue + (maxValue - minValue) * alpha, true)
                end

                Track(SBar.InputBegan:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                        dragging = true
                        SetFromX(input.Position.X)
                    end
                end))

                Track(Knob.InputBegan:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                        dragging = true
                    end
                end))

                Track(UIS.InputChanged:Connect(function(input)
                    if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
                        SetFromX(input.Position.X)
                    end
                end))

                Track(UIS.InputEnded:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                        dragging = false
                    end
                end))

                Track(InputBox.FocusLost:Connect(function()
                    ApplyValue(InputBox.Text, true)
                end))

                SRender()
                SliderObj = {Holder = SHolder, SetValue = ApplyValue, GetValue = function() return value end}
                UpdateContainerSize()
            end

            return {Set = Set, Get = function() return state end}
        end

        return Tab
    end

    MakeDraggable(Main,TitleBar)

    -- Resize
    local Resize = Instance.new("TextButton")
    Resize.AnchorPoint = Vector2.new(1,1)
    Resize.Position = UDim2.new(1,-5,1,-5)
    Resize.Size = UDim2.fromOffset(24,24)
    Resize.Text = "↘"
    Resize.Font = Enum.Font.GothamBold
    Resize.TextSize = 15
    Resize.TextColor3 = Color3.fromRGB(0,210,255)
    Resize.BackgroundColor3 = Color3.fromRGB(28,31,43)
    Resize.BorderSizePixel = 0
    Resize.ZIndex = 50
    Resize.Parent = Main
    Corner(Resize,6)

    local resizing, resizeInput, startPos, startSize = false,nil,nil,nil

    Track(Resize.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then
            resizing = true
            resizeInput = input
            startPos = input.Position
            startSize = Main.AbsoluteSize
        end
    end))

    Track(Resize.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement
        or input.UserInputType == Enum.UserInputType.Touch then
            resizeInput = input
        end
    end))

    Track(UIS.InputChanged:Connect(function(input)
        if resizing and input == resizeInput then
            local d = input.Position-startPos
            local vp = Camera and Camera.ViewportSize or Vector2.new(1920,1080)
            Main.Size = UDim2.fromOffset(
                math.clamp(startSize.X+d.X,340,math.min(900,vp.X-15)),
                math.clamp(startSize.Y+d.Y,230,math.min(650,vp.Y-15))
            )
        end
    end))

    Track(UIS.InputEnded:Connect(function(input)
        if input == resizeInput
        or input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then
            resizing = false
            resizeInput = nil
        end
    end))

    Track(Close.MouseButton1Click:Connect(function()
        DisconnectAll()
        Gui:Destroy()
    end))

    return Window
end

--==================================================
-- FEATURE STATE
--==================================================
local State = {
    Fly = false,
    FlySpeed = 60,
    InfiniteJump = false,
    Speed = false,
    WalkSpeed = 100,
    ClickTP = false,
    Noclip = false,
    Invisible = false,
    God = false,
    Aimbot = false,
    FOV = 20,
    KillAura = false,
    KillRange = 100,
    Hitbox = false,
    HitboxSize = 20,
    FPSBoost = false,
    Fullbright = false,
    Brightness = 2,
    ClockTime = 13,
    ESPPlayers = false,
    ESPNPC = false,
    CarSpeed = 150,
    CarSpeedEnabled = false,
    PullPlayers = false,
    Blackhole = false
}

--==================================================
-- BACKUPS
--==================================================
local OriginalCollision = {}
local OriginalTransparency = {}
local OriginalHitbox = {}
local LightingBackup = {
    Brightness = Lighting.Brightness,
    ClockTime = Lighting.ClockTime,
    GlobalShadows = Lighting.GlobalShadows,
    FogStart = Lighting.FogStart,
    FogEnd = Lighting.FogEnd,
    Ambient = Lighting.Ambient,
    OutdoorAmbient = Lighting.OutdoorAmbient
}

--==================================================
-- FLY - บินตามทิศทางกล้อง
-- หันขึ้น = บินขึ้น / หันลง = บินลง
-- รองรับทั้ง PC + มือถือ
--==================================================
local FlyBV, FlyBG

local function StopFly()
    if FlyBV then
        FlyBV:Destroy()
        FlyBV = nil
    end

    if FlyBG then
        FlyBG:Destroy()
        FlyBG = nil
    end

    local h = Humanoid()
    if h then
        h.PlatformStand = false
    end
end

local function StartFly()
    StopFly()

    local root, hum = Root(), Humanoid()
    if not root or not hum then return end

    FlyBV = Instance.new("BodyVelocity")
    FlyBV.Name = "XWACK_FlyVelocity"
    FlyBV.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
    FlyBV.P = 10000
    FlyBV.Velocity = Vector3.zero
    FlyBV.Parent = root

    FlyBG = Instance.new("BodyGyro")
    FlyBG.Name = "XWACK_FlyGyro"
    FlyBG.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
    FlyBG.P = 50000
    FlyBG.D = 1000
    FlyBG.CFrame = root.CFrame
    FlyBG.Parent = root

    hum.PlatformStand = true
end

Track(RunService.RenderStepped:Connect(function()
    if not State.Fly then
        return
    end

    local root, hum = Root(), Humanoid()
    if not root or not hum or not Camera then
        return
    end

    if not FlyBV or FlyBV.Parent ~= root or
       not FlyBG or FlyBG.Parent ~= root then
        StartFly()
        return
    end

    hum.PlatformStand = true

    local move = hum.MoveDirection
    local speed = State.FlySpeed or 50

    -- ทิศของกล้องแบบ 3D
    -- LookVector มีแกน Y อยู่ด้วย
    -- เพราะงั้นหันขึ้น/ลงแล้วบินตามได้
    local camCF = Camera.CFrame
    local look = camCF.LookVector
    local right = camCF.RightVector

    -- ตรวจว่ากำลังเดินไปข้างหน้า/หลัง/ซ้าย/ขวา
    -- แปลง MoveDirection เป็น local direction ของกล้อง
    local flatLook = Vector3.new(look.X, 0, look.Z)
    local flatRight = Vector3.new(right.X, 0, right.Z)

    if flatLook.Magnitude > 0.001 then
        flatLook = flatLook.Unit
    end

    if flatRight.Magnitude > 0.001 then
        flatRight = flatRight.Unit
    end

    local forwardAmount = 0
    local rightAmount = 0

    if move.Magnitude > 0.01 then
        forwardAmount = move:Dot(flatLook)
        rightAmount = move:Dot(flatRight)
    end

    -- บินตามมุมกล้องจริง
    local flyDirection =
        (look * forwardAmount) +
        (right * rightAmount)

    -- PC: Space บินขึ้นตรงๆ เพิ่มเติม
    if UIS:IsKeyDown(Enum.KeyCode.Space) then
        flyDirection += Vector3.new(0, 1, 0)
    end

    -- PC: Ctrl / C บินลงตรงๆ เพิ่มเติม
    if UIS:IsKeyDown(Enum.KeyCode.LeftControl)
    or UIS:IsKeyDown(Enum.KeyCode.RightControl)
    or UIS:IsKeyDown(Enum.KeyCode.C) then
        flyDirection += Vector3.new(0, -1, 0)
    end

    -- ป้องกันแนวทแยงเร็วเกิน FlySpeed
    if flyDirection.Magnitude > 1 then
        flyDirection = flyDirection.Unit
    end

    FlyBV.Velocity = flyDirection * speed

    -- ตัวละครหันตามกล้อง
    FlyBG.CFrame = camCF
end))

--==================================================
-- INFINITE JUMP
--==================================================
Track(UIS.JumpRequest:Connect(function()
    if State.InfiniteJump then
        local hum = Humanoid()
        if hum then
            hum:ChangeState(Enum.HumanoidStateType.Jumping)
        end
    end
end))

--==================================================
-- SPEED + NOCLIP + GOD
--==================================================
Track(RunService.Stepped:Connect(function()
    local char = Character()
    local hum = Humanoid()

    if hum and State.Speed then
        hum.WalkSpeed = State.WalkSpeed
    end

    if char and State.Noclip then
        for _,obj in ipairs(char:GetDescendants()) do
            if obj:IsA("BasePart") then
                if OriginalCollision[obj] == nil then
                    OriginalCollision[obj] = obj.CanCollide
                end
                obj.CanCollide = false
            end
        end
    end

    if hum and State.God then
        pcall(function()
            hum.BreakJointsOnDeath = false
            hum.RequiresNeck = false
            if hum.MaxHealth < 1e9 then hum.MaxHealth = 1e9 end
            if hum.Health < hum.MaxHealth then hum.Health = hum.MaxHealth end
        end)
    end
end))

local function RestoreCollision()
    for obj,v in pairs(OriginalCollision) do
        if obj and obj.Parent then pcall(function() obj.CanCollide=v end) end
    end
    table.clear(OriginalCollision)
end

--==================================================
-- CLICK TP TOOL
--==================================================
local ClickTool

local function RemoveClickTool()
    if ClickTool then pcall(function() ClickTool:Destroy() end) end
    ClickTool=nil
    local backpack = Player:FindFirstChildOfClass("Backpack")
    if backpack then
        local t = backpack:FindFirstChild("RUNLUA-HUB Click TP")
        if t then t:Destroy() end
    end
    local char = Character()
    if char then
        local t = char:FindFirstChild(" Click TP")
        if t then t:Destroy() end
    end
end

local function GiveClickTool()
    RemoveClickTool()
    local t = Instance.new("Tool")
    t.Name = "RUNLUA-HUB Click TP"
    t.RequiresHandle = false
    t.CanBeDropped = false

    Track(t.Activated:Connect(function()
        if not State.ClickTP then return end
        local root = Root()
        if root and Mouse and Mouse.Hit then
            root.CFrame = CFrame.new(Mouse.Hit.Position + Vector3.new(0,3,0))
        end
    end))

    t.Parent = Player:WaitForChild("Backpack")
    ClickTool=t
end

--==================================================
-- INVISIBLE (LOCAL VISUAL)
--==================================================
local function SetInvisible(on)
    local char = Character()
    if not char then return end

    if on then
        for _,obj in ipairs(char:GetDescendants()) do
            if obj:IsA("BasePart") or obj:IsA("Decal") then
                if OriginalTransparency[obj] == nil then
                    OriginalTransparency[obj] = obj.Transparency
                end
                obj.Transparency = 1
            end
        end
    else
        for obj,v in pairs(OriginalTransparency) do
            if obj and obj.Parent then pcall(function() obj.Transparency=v end) end
        end
        table.clear(OriginalTransparency)
    end
end

--==================================================
-- AIMBOT
--==================================================
local AimCircle
pcall(function()
    if Drawing then
        AimCircle = Drawing.new("Circle")
        AimCircle.Thickness = 1.5
        AimCircle.NumSides = 45
        AimCircle.Filled = false
        AimCircle.Transparency = 0.8
        AimCircle.Color = Color3.fromRGB(0,170,255)
        AimCircle.Visible = false
    end
end)

local function FOVRadius()
    local vp = Camera.ViewportSize
    return math.min(vp.X,vp.Y)/2*(State.FOV/100)
end

local function GetAimTarget()
    local vp = Camera.ViewportSize
    local center = Vector2.new(vp.X/2,vp.Y/2)
    local best,bestDist=nil,math.huge

    for _,p in ipairs(Players:GetPlayers()) do
        if p ~= Player and p.Character then
            local head = p.Character:FindFirstChild("Head")
            local hum = p.Character:FindFirstChildOfClass("Humanoid")
            if head and hum and hum.Health > 0 then
                local pos,onScreen = Camera:WorldToViewportPoint(head.Position)
                if onScreen then
                    local dist=(Vector2.new(pos.X,pos.Y)-center).Magnitude
                    if dist <= FOVRadius() and dist < bestDist then
                        best=head
                        bestDist=dist
                    end
                end
            end
        end
    end
    return best
end

Track(RunService.RenderStepped:Connect(function()
    if AimCircle then
        AimCircle.Position = Vector2.new(Camera.ViewportSize.X/2,Camera.ViewportSize.Y/2)
        AimCircle.Radius = FOVRadius()
        AimCircle.Visible = State.Aimbot
    end

    if State.Aimbot then
        local target=GetAimTarget()
        if target then
            Camera.CFrame=CFrame.lookAt(Camera.CFrame.Position,target.Position)
        end
    end
end))

--==================================================
-- KILL AURA NPC
--==================================================
local function IsPlayerCharacter(model)
    return Players:GetPlayerFromCharacter(model) ~= nil
end

Track(RunService.Heartbeat:Connect(function()
    if not State.KillAura then return end
    local myRoot = Root()
    if not myRoot then return end

    for _,obj in ipairs(workspace:GetDescendants()) do
        if obj:IsA("Humanoid") and obj.Health > 0 then
            local model=obj.Parent
            if model and model:IsA("Model") and not IsPlayerCharacter(model) then
                local root=model:FindFirstChild("HumanoidRootPart") or model:FindFirstChild("Torso") or model:FindFirstChild("UpperTorso")
                if root and (root.Position-myRoot.Position).Magnitude <= State.KillRange then
                    pcall(function()
                        obj.Health=0
                    end)
                end
            end
        end
    end
end))

--==================================================
-- HITBOX
--==================================================
local function ResetHitbox()
    for part,data in pairs(OriginalHitbox) do
        if part and part.Parent then
            pcall(function()
                part.Size=data.Size
                part.Transparency=data.Transparency
                part.CanCollide=data.CanCollide
                part.Material=data.Material
            end)
        end
    end
    table.clear(OriginalHitbox)
end

Track(RunService.Heartbeat:Connect(function()
    if not State.Hitbox then return end

    for _,p in ipairs(Players:GetPlayers()) do
        if p ~= Player and p.Character then
            local hrp=p.Character:FindFirstChild("HumanoidRootPart")
            if hrp then
                if not OriginalHitbox[hrp] then
                    OriginalHitbox[hrp]={
                        Size=hrp.Size,
                        Transparency=hrp.Transparency,
                        CanCollide=hrp.CanCollide,
                        Material=hrp.Material
                    }
                end
                hrp.Size=Vector3.new(State.HitboxSize,State.HitboxSize,State.HitboxSize)
                hrp.Transparency=.65
                hrp.CanCollide=false
                hrp.Material=Enum.Material.Neon
            end
        end
    end
end))

--==================================================
-- FPS BOOST
--==================================================
local FPSBackup={}
local function ApplyFPSBoost(on)
    if on then
        for _,v in ipairs(game:GetDescendants()) do
            if v:IsA("BasePart") then
                if not FPSBackup[v] then
                    FPSBackup[v]={Material=v.Material,CastShadow=v.CastShadow}
                end
                v.Material=Enum.Material.SmoothPlastic
                v.CastShadow=false
            elseif v:IsA("ParticleEmitter") or v:IsA("Trail") or v:IsA("Smoke")
            or v:IsA("Fire") or v:IsA("Sparkles") then
                if FPSBackup[v]==nil then FPSBackup[v]=v.Enabled end
                v.Enabled=false
            end
        end
        Lighting.GlobalShadows=false
        pcall(function() settings().Rendering.QualityLevel=Enum.QualityLevel.Level01 end)
    else
        for v,data in pairs(FPSBackup) do
            if v and v.Parent then
                pcall(function()
                    if v:IsA("BasePart") then
                        v.Material=data.Material
                        v.CastShadow=data.CastShadow
                    elseif typeof(data)=="boolean" then
                        v.Enabled=data
                    end
                end)
            end
        end
        table.clear(FPSBackup)
        Lighting.GlobalShadows=LightingBackup.GlobalShadows
    end
end

--==================================================
-- FULLBRIGHT
--==================================================
local function ApplyLighting()
    if State.Fullbright then
        Lighting.FogStart=100000
        Lighting.FogEnd=100000
        Lighting.Brightness=State.Brightness
        Lighting.ClockTime=State.ClockTime
        Lighting.GlobalShadows=false
        Lighting.Ambient=Color3.fromRGB(180,180,180)
        Lighting.OutdoorAmbient=Color3.fromRGB(180,180,180)
    else
        for k,v in pairs(LightingBackup) do
            pcall(function() Lighting[k]=v end)
        end
    end
end

--==================================================
-- ESP
--==================================================
local function ClearESP(tag)
    for _,v in ipairs(workspace:GetDescendants()) do
        if v.Name==tag and (v:IsA("Highlight") or v:IsA("BillboardGui")) then
            v:Destroy()
        end
    end
end

local function AddHighlight(model,tag,outlineColor)
    if not model or model:FindFirstChild(tag) then return end
    local h=Instance.new("Highlight")
    h.Name=tag
    h.Adornee=model
    h.FillTransparency=.72
    h.OutlineTransparency=0
    h.OutlineColor=outlineColor or Color3.new(1,1,1)
    h.DepthMode=Enum.HighlightDepthMode.AlwaysOnTop
    h.Parent=model
end

local function EnsureBillboard(model, adornee, tag, text, color)
    if not model or not adornee then return nil end
    local bb = model:FindFirstChild(tag)
    if not bb then
        bb = Instance.new("BillboardGui")
        bb.Name = tag
        bb.Size = UDim2.fromOffset(190,36)
        bb.StudsOffset = Vector3.new(0,3,0)
        bb.AlwaysOnTop = true
        bb.MaxDistance = math.huge
        bb.Adornee = adornee
        bb.Parent = model

        local label = Instance.new("TextLabel")
        label.Name = "ข้อความ"
        label.Size = UDim2.fromScale(1,1)
        label.BackgroundTransparency = 1
        label.TextStrokeTransparency = 0.25
        label.Font = Enum.Font.GothamBold
        label.TextSize = 13
        label.Parent = bb
    end
    local label = bb:FindFirstChild("ข้อความ")
    if label then
        label.Text = text or ""
        label.TextColor3 = color or Color3.new(1,1,1)
    end
    return bb
end

Track(RunService.Heartbeat:Connect(function()
    local myRoot = Root()

    if State.ESPPlayers then
        for _,p in ipairs(Players:GetPlayers()) do
            if p~=Player and p.Character then
                local head = p.Character:FindFirstChild("Head")
                local proot = p.Character:FindFirstChild("HumanoidRootPart")
                AddHighlight(p.Character,"XWACK_ESP_PLAYER",Color3.fromRGB(255,220,0))
                EnsureBillboard(
                    p.Character,
                    head or proot,
                    "XWACK_ESP_PLAYER_LABEL",
                    p.Name,
                    Color3.fromRGB(255,220,0)
                )
            end
        end
    end

    if State.ESPNPC then
        for _,m in ipairs(workspace:GetDescendants()) do
            if m:IsA("Model") and m:FindFirstChildOfClass("Humanoid") and not Players:GetPlayerFromCharacter(m) then
                local nroot = m:FindFirstChild("HumanoidRootPart") or m:FindFirstChild("Torso") or m:FindFirstChild("UpperTorso")
                local hum = m:FindFirstChildOfClass("Humanoid")
                if nroot and hum and hum.Health > 0 then
                    AddHighlight(m,"XWACK_ESP_NPC",Color3.fromRGB(255,255,255))
                    local dist = myRoot and math.floor((nroot.Position-myRoot.Position).Magnitude) or 0
                    EnsureBillboard(
                        m,
                        nroot,
                        "XWACK_ESP_NPC_LABEL",
                        (m.Name ~= "" and m.Name or "NPC").."  ["..dist.." เมตร]",
                        Color3.fromRGB(255,255,255)
                    )
                end
            end
        end
    end
end))

--==================================================
-- TOOL GIVER IN SAME UI
--==================================================
local FoundToolNames={}
local function FindTools()
    local list={}
    local seen={}
    for _,v in ipairs(game:GetDescendants()) do
        if v:IsA("Tool") and not seen[v.Name] then
            seen[v.Name]=true
            table.insert(list,v)
        end
    end
    table.sort(list,function(a,b) return a.Name:lower()<b.Name:lower() end)
    return list
end

local function CloneTool(tool)
    if not tool then return end
    local ok,clone=pcall(function() return tool:Clone() end)
    if ok and clone then
        clone.Parent=Player:WaitForChild("Backpack")
        Notify("เสก "..tool.Name.." แล้ว")
    end
end

--==================================================
-- CAR SPEED
--==================================================
local LastVehicle, OriginalVehicleMaxSpeed

local function StopCarSpeed()
    if LastVehicle and LastVehicle.Parent and OriginalVehicleMaxSpeed then
        pcall(function() LastVehicle.MaxSpeed = OriginalVehicleMaxSpeed end)
    end
    LastVehicle = nil
    OriginalVehicleMaxSpeed = nil
end

Track(RunService.Heartbeat:Connect(function()
    if not State.CarSpeedEnabled then return end
    local hum = Humanoid()
    if not hum then return end
    local seat = hum.SeatPart

    if seat and seat:IsA("VehicleSeat") then
        if LastVehicle ~= seat then
            StopCarSpeed()
            LastVehicle = seat
            OriginalVehicleMaxSpeed = seat.MaxSpeed
        end

        pcall(function()
            seat.MaxSpeed = State.CarSpeed
            if seat.Throttle ~= 0 then
                local y = seat.AssemblyLinearVelocity.Y
                local dir = seat.CFrame.LookVector * (seat.Throttle * State.CarSpeed)
                seat.AssemblyLinearVelocity = Vector3.new(dir.X,y,dir.Z)
            end
        end)
    end
end))

--==================================================
-- PULL PLAYERS
--==================================================
local SpawnTimes = {}
local PULL_SPAWN_DELAY = 6

local function TrackSpawn(plr)
    plr.CharacterAdded:Connect(function()
        SpawnTimes[plr] = tick()
    end)
end

for _,p in ipairs(Players:GetPlayers()) do TrackSpawn(p) end
Track(Players.PlayerAdded:Connect(TrackSpawn))

Track(RunService.RenderStepped:Connect(function()
    if not State.PullPlayers then return end
    local root = Root()
    if not root then return end

    local destination = root.Position + root.CFrame.LookVector * 5
    for _,other in ipairs(Players:GetPlayers()) do
        if other ~= Player and other.Character then
            local oroot = other.Character:FindFirstChild("HumanoidRootPart")
            local ohum = other.Character:FindFirstChildOfClass("Humanoid")
            if oroot and ohum and ohum.Health > 0 then
                local spawned = SpawnTimes[other]
                if not spawned or tick() - spawned >= PULL_SPAWN_DELAY then
                    pcall(function()
                        other.Character:PivotTo(CFrame.new(destination))
                    end)
                end
            end
        end
    end
end))

--==================================================
-- BLACKHOLE
--==================================================
local BHFolder, BHPart, BHTarget
local BHDescConnection
local BHControlled = {}

local function StopBlackhole()
    if BHDescConnection then
        BHDescConnection:Disconnect()
        BHDescConnection = nil
    end
    for part,data in pairs(BHControlled) do
        if part and part.Parent then
            pcall(function()
                part.CanCollide = data.CanCollide
                part.CustomPhysicalProperties = data.CustomPhysicalProperties
                for _,name in ipairs({"XWACK_BH_Torque","XWACK_BH_Align","XWACK_BH_Att"}) do
                    local x = part:FindFirstChild(name)
                    if x then x:Destroy() end
                end
            end)
        end
    end
    table.clear(BHControlled)
    if BHFolder then BHFolder:Destroy() end
    BHFolder,BHPart,BHTarget = nil,nil,nil
end

local function ForceBlackholePart(v)
    if not State.Blackhole then return end
    if not v:IsA("BasePart") or v.Anchored or BHControlled[v] then return end
    if v:IsDescendantOf(Character() or workspace) then
        if Character() and v:IsDescendantOf(Character()) then return end
    end
    if v.Parent and (v.Parent:FindFirstChildOfClass("Humanoid") or v.Name == "Handle") then return end

    BHControlled[v] = {
        CanCollide = v.CanCollide,
        CustomPhysicalProperties = v.CustomPhysicalProperties
    }

    pcall(function()
        v.CanCollide = false
        v.CustomPhysicalProperties = PhysicalProperties.new(0,0,0,0,0)

        local att = Instance.new("Attachment")
        att.Name = "XWACK_BH_Att"
        att.Parent = v

        local torque = Instance.new("Torque")
        torque.Name = "XWACK_BH_Torque"
        torque.Torque = Vector3.new(100000,100000,100000)
        torque.Attachment0 = att
        torque.Parent = v

        local align = Instance.new("AlignPosition")
        align.Name = "XWACK_BH_Align"
        align.MaxForce = 9e15
        align.MaxVelocity = math.huge
        align.Responsiveness = 200
        align.Attachment0 = att
        align.Attachment1 = BHTarget
        align.Parent = v
    end)
end

local function StartBlackhole()
    StopBlackhole()
    local root = Root()
    if not root then return end

    BHFolder = Instance.new("Folder")
    BHFolder.Name = "XWACK_BLACKHOLE"
    BHFolder.Parent = workspace

    BHPart = Instance.new("Part")
    BHPart.Name = "Target"
    BHPart.Anchored = true
    BHPart.CanCollide = false
    BHPart.Transparency = 1
    BHPart.Size = Vector3.new(1,1,1)
    BHPart.Parent = BHFolder

    BHTarget = Instance.new("Attachment")
    BHTarget.Parent = BHPart

    pcall(function()
        if sethiddenproperty then
            sethiddenproperty(Player,"SimulationRadius",math.huge)
        end
    end)

    for _,v in ipairs(workspace:GetDescendants()) do
        ForceBlackholePart(v)
    end

    BHDescConnection = workspace.DescendantAdded:Connect(function(v)
        if State.Blackhole then ForceBlackholePart(v) end
    end)
end

Track(RunService.RenderStepped:Connect(function()
    if State.Blackhole and BHPart then
        local root = Root()
        if root then
            BHPart.CFrame = root.CFrame * CFrame.new(0,0,-50)
        end
    end
end))

--==================================================
-- CHARACTER RESPAWN
--==================================================
Track(Player.CharacterAdded:Connect(function()
    task.wait(1)
    if State.Fly then StartFly() end
    if State.ClickTP then GiveClickTool() end
    if State.Invisible then SetInvisible(true) end
end))

--==================================================
-- BUILD UI
--==================================================
local Window=Library:NewWindow("RUNLUA-HUB STORE  |  SINGLE UI V4")

local MainTab=Window:NewTab("หลัก","🏠")
local AttackTab=Window:NewTab("โจมตี","⚔️")
local ToolTab=Window:NewTab("เครื่องมือ","🔧")
local FunTab=Window:NewTab("แกล้ง","🤡")
local EyeTab=Window:NewTab("ดวงตาเทพ","👁️")

MainTab:NewLabel("การเคลื่อนที่ / ตัวละคร")

MainTab:NewToggle("✈️ บิน",false,function(v)
    State.Fly=v
    if v then StartFly() else StopFly() end
end,"เปิดแล้วใช้ปุ่มเดินเพื่อบังคับทิศทาง กด Space เพื่อบินขึ้น และ Ctrl/C เพื่อบินลง ปรับความเร็วได้จากแถบด้านล่าง", {
    text = "ความเร็วบิน", min = 20, max = 300, default = 60,
    callback = function(v) State.FlySpeed = v end
})

MainTab:NewToggle("🦘 กระโดดไม่จำกัด",false,function(v)
    State.InfiniteJump=v
end,"เมื่อเปิด สามารถกดกระโดดซ้ำกลางอากาศได้")

MainTab:NewToggle("🏃 วิ่งเร็ว",false,function(v)
    State.Speed=v
    if not v then
        local h=Humanoid()
        if h then h.WalkSpeed=16 end
    end
end,"เปิดเพื่อบังคับความเร็วเดินตามค่าที่ตั้งในแถบ ความเร็วเดิน ด้านล่าง", {
    text = "ความเร็วเดิน", min = 16, max = 500, default = 100,
    callback = function(v) State.WalkSpeed = v end
})

MainTab:NewToggle("🖱️ วาร์ปตามจุดที่กด",false,function(v)
    State.ClickTP=v
    if v then GiveClickTool() else RemoveClickTool() end
end,"เปิดแล้วจะมี Tool ชื่อ RUNLUA-HUB Click TP ในกระเป๋า ถือ Tool แล้วแตะ/คลิกจุดที่ต้องการวาร์ป")

MainTab:NewToggle("🚪 เดินทะลุกำแพง",false,function(v)
    State.Noclip=v
    if not v then RestoreCollision() end
end,"เปิดเพื่อปิดการชนของชิ้นส่วนตัวละคร ทำให้เดินผ่านกำแพงหรือวัตถุบางชนิดได้")

MainTab:NewToggle("👻 หายตัว",false,function(v)
    State.Invisible=v
    SetInvisible(v)
end,"ซ่อนชิ้นส่วนตัวละครฝั่งเครื่องคุณ เหมาะกับการซ่อนภาพตัวละครในหน้าจอของคุณ บางเกมอาจไม่ซิงก์ให้คนอื่นเห็น")

MainTab:NewToggle("🛡️ โหมดอมตะ บางแมพ",false,function(v)
    State.God=v
end,"พยายามรักษาเลือดไว้สูงสุดและป้องกันการตายแบบ Humanoid บางเกมใช้ระบบเลือดฝั่งเซิร์ฟเวอร์จึงอาจไม่สำเร็จ")

AttackTab:NewLabel("ระบบต่อสู้")

AttackTab:NewToggle("🎯 ล็อคหัวผู้เล่น",false,function(v)
    State.Aimbot=v
end,"เมื่อเปิด กล้องจะหันไปยังศีรษะผู้เล่นที่อยู่ใกล้กลางจอที่สุดภายในขอบเขต FOV", {
    text = "ขอบเขตล็อคหัว (FOV)", min = 5, max = 100, default = 20,
    callback = function(v) State.FOV = v end
})

AttackTab:NewToggle("💀 ฆ่าบอทใกล้ตัว",false,function(v)
    State.KillAura=v
end,"พยายามตั้งเลือด NPC ที่อยู่ในระยะให้เป็น 0 ใช้ได้เฉพาะเกมที่ยอมให้ฝั่ง Client เปลี่ยนค่า Humanoid", {
    text = "ระยะฆ่าบอท", min = 10, max = 500, default = 100,
    callback = function(v) State.KillRange = v end
})

AttackTab:NewToggle("📦 ขยาย Hitbox ผู้เล่น",false,function(v)
    State.Hitbox=v
    if not v then ResetHitbox() end
end,"ขยาย HumanoidRootPart ของผู้เล่นอื่น เพื่อทำให้พื้นที่โดนกว้างขึ้น ปิดแล้วจะพยายามคืนค่าขนาดเดิม", {
    text = "ขนาด Hitbox", min = 2, max = 100, default = 20,
    callback = function(v) State.HitboxSize = v end
})

ToolTab:NewLabel("ประสิทธิภาพ / แสง")

ToolTab:NewToggle("🚀 ลดกราฟิก เพิ่ม FPS",false,function(v)
    State.FPSBoost=v
    ApplyFPSBoost(v)
end,"ลด Material เงา Particle และเอฟเฟกต์บางส่วนเพื่อช่วยลดภาระการเรนเดอร์ ปิดแล้วจะพยายามคืนค่าที่บันทึกไว้")

ToolTab:NewToggle("💡 ทำแมพสว่าง",false,function(v)
    State.Fullbright=v
    ApplyLighting()
end,"เปิดเพื่อใช้ค่าความสว่างและเวลาที่ตั้งด้านล่าง พร้อมลดหมอก", {
    text = "ความสว่าง", min = 0, max = 10, default = 2,
    callback = function(v)
        State.Brightness = v
        ApplyLighting()
    end
})

ToolTab:NewLabel("รถ")

ToolTab:NewToggle("🚗 เพิ่มความเร็วรถ",false,function(v)
    State.CarSpeedEnabled=v
    if not v then StopCarSpeed() end
end,"นั่ง VehicleSeat แล้วเปิด ระบบจะบังคับ MaxSpeed และความเร็วรถต่อเนื่องตามค่าด้านล่าง", {
    text = "ความเร็วรถ", min = 20, max = 500, default = 150,
    callback = function(v) State.CarSpeed = v end
})

ToolTab:NewLabel("หยิบของเร็ว | E")

local InstantPromptEnabled = false
local OriginalHoldDuration = {}

ToolTab:NewToggle("🥅 หยิบของเร็ว | E", false, function(state)
    InstantPromptEnabled = state

    if state then
        -- เปิด: ทำ ProximityPrompt ที่มีอยู่ทั้งหมดให้กดทันที
        for _, prompt in ipairs(game:GetService("Workspace"):GetDescendants()) do
            if prompt:IsA("ProximityPrompt") then
                if OriginalHoldDuration[prompt] == nil then
                    OriginalHoldDuration[prompt] = prompt.HoldDuration
                end

                prompt.HoldDuration = 0
            end
        end
    else
        -- ปิด: คืนค่า HoldDuration เดิม
        for prompt, oldDuration in pairs(OriginalHoldDuration) do
            if prompt and prompt.Parent then
                prompt.HoldDuration = oldDuration
            end
        end

        table.clear(OriginalHoldDuration)
    end
end, "เปิดแล้วสิ่งที่ต้องกด E หรือกดค้าง จะกดได้ทันที / ปิดแล้วคืนค่าดีเลย์เดิม")


ToolTab:NewLabel("เสกของ / Tool Giver")
ToolTab:NewButton("🔄 สแกนของในแมพ",function()
    local tools=FindTools()
    local added=0
    for _,tool in ipairs(tools) do
        if not FoundToolNames[tool.Name] then
            FoundToolNames[tool.Name]=true
            added+=1
            ToolTab:NewButton("🎒 เสก "..tool.Name,function()
                CloneTool(tool)
            end,"กดเพื่อ Clone Tool ชื่อนี้เข้า Backpack ของคุณ ใช้ได้เฉพาะ Tool ที่มีอยู่และ Clone ได้จากฝั่ง Client")
        end
    end
    Notify("พบของใหม่ "..added.." รายการ")
end,"สแกน Tool ที่มีอยู่ในเกม แล้วเพิ่มรายการของไว้ในแท็บนี้โดยตรง ไม่สร้าง UI แยก")

EyeTab:NewLabel("มองผู้เล่น / NPC")

EyeTab:NewToggle("👁️ มองทะลุ ผู้เล่น",false,function(v)
    State.ESPPlayers=v
    if not v then
        ClearESP("XWACK_ESP_PLAYER")
        ClearESP("XWACK_ESP_PLAYER_LABEL")
    end
end,"แสดงเส้นขอบสีเหลืองและชื่อผู้เล่น แม้มีสิ่งกีดขวาง")

EyeTab:NewToggle("🤖 มองทะลุ NPC ",false,function(v)
    State.ESPNPC=v
    if not v then
        ClearESP("XWACK_ESP_NPC")
        ClearESP("XWACK_ESP_NPC_LABEL")
    end
end,"ค้นหา Model ที่มี Humanoid แต่ไม่ใช่ผู้เล่น แล้วแสดงเส้นขอบ ชื่อ และระยะทาง")

FunTab:NewLabel("ระบบแกล้ง")

FunTab:NewToggle("🧲 ดึงผู้เล่นมาใกล้ตัว",false,function(v)
    State.PullPlayers=v
end,"พยายามย้ายตัวละครผู้เล่นอื่นมาไว้ด้านหน้าคุณประมาณ 5 Stud ระบบจะข้ามผู้เล่นที่เพิ่งเกิดประมาณ 6 วินาที")

FunTab:NewToggle("🕳️ หลุมดำดูดของ",false,function(v)
    State.Blackhole=v
    if v then StartBlackhole() else StopBlackhole() end
end,"ดึงชิ้นส่วนฟิสิกส์ที่ไม่ Anchored และไม่ใช่ตัวละครเข้าหาจุดด้านหน้าคุณประมาณ 50 Stud บางเกมอาจไม่ซิงก์เพราะ Network Ownership")

--==================================================
-- ฟังก์ชันที่ต้องเรียกต้นฉบับโดยตรง
--==================================================
local function SafeLoad(url)
    local ok,err=pcall(function()
        local src=game:HttpGet(url)
        local fn=loadstring(src)
        if fn then fn() end
    end)
    if not ok then
        Notify("โหลดไม่สำเร็จ")
        warn(err)
    end
end

FunTab:NewButton("💥 ชนผู้เล่นกระเด็น",function()
    SafeLoad("https://raw.githubusercontent.com/wackshopr-tech/script-roblox-all/refs/heads/main/SCRIPT-ALL-BY-WACK-SHOP/FLINGCORE/FLINGCORE.lua")
end,"ต้นฉบับไฟล์นี้ถูกเข้ารหัส/Obfuscate จึงเรียกต้นฉบับโดยตรงเมื่อกด")

FunTab:NewToggle("👕 ถอดเสื้อผ้า หีนมใหญ่", false, function(v)
    if v then
        loadstring(game:HttpGet(
            "https://raw.githubusercontent.com/clemonlang/clemon_roclothes/refs/heads/main/ClemonRC.lua"
        ))()
    end
end, "เปิด Clemon RoClothes")

FunTab:NewToggle("🤚 ชักว่าว", false, function(v)
    local Players = game:GetService("Players")
    local player = Players.LocalPlayer

    if v then
        local char = player.Character or player.CharacterAdded:Wait()
        local hum = char:FindFirstChildOfClass("Humanoid")
        if not hum then return end

        -- ตรวจว่าเป็น R6 หรือยัง
        if hum.RigType ~= Enum.HumanoidRigType.R6 then
            warn("กำลังเปลี่ยนเป็น R6...")

            -- พยายามเปลี่ยน Avatar เป็น R6
            local desc = hum:GetAppliedDescription()

            local success = pcall(function()
                player:LoadCharacterWithHumanoidDescription(
                    desc,
                    Enum.HumanoidRigType.R6
                )
            end)

            if not success then
                warn("ไม่สามารถเปลี่ยนเป็น R6 จากฝั่ง Client ได้")
                return
            end

            -- รอตัวละครใหม่
            char = player.CharacterAdded:Wait()
            hum = char:WaitForChild("Humanoid")
        end

        -- ตอนนี้ต้องเป็น R6 แล้วค่อยเล่น Animation
        if hum.RigType == Enum.HumanoidRigType.R6 then
            local anim = Instance.new("Animation")
            anim.AnimationId = "rbxassetid://72042024"

            getgenv().FunTrack = hum:LoadAnimation(anim)
            getgenv().FunTrack.Looped = true
            getgenv().FunTrack:Play()
        end

    else
        if getgenv().FunTrack then
            getgenv().FunTrack:Stop()
            getgenv().FunTrack = nil
        end
    end
end, "เปิด = เช็ก R6 แล้วเล่นว่าว / ปิด = หยุด")

FunTab:NewButton("🧱 เครื่องมือ F3X",function()
    SafeLoad("https://pastebin.com/raw/FZmTykdY")
end,"กดเพื่อโหลดเครื่องมือ F3X จากแหล่งเดิม")

ToolTab:NewLabel("เครื่องมือคำสั่ง")

ToolTab:NewButton("⌨️ แป้นพิมพ์บนหน้าจอ",function()
    SafeLoad("https://raw.githubusercontent.com/Xxtan31/Ata/main/deltakeyboardcrack.txt")
end,"เปิดแป้นพิมพ์เสริมของสคริปต์ต้นฉบับ ฟังก์ชันนี้จำเป็นต้องมีหน้าต่างของตัวเองเพื่อใช้เป็นคีย์บอร์ด")

ToolTab:NewButton("🚀 เข้าเซิร์ฟเวอร์คนน้อย",function()
    SafeLoad("https://raw.githubusercontent.com/runluahub-create/All-map/refs/heads/main/Low%20Population%20Server%20Finder")
end,"จะเข้าเซิฟเวอร์ทีีมีคนน้อยใช้งานได้ทุกแมพ")

ToolTab:NewButton("♾️ Infinite Yield",function()
    SafeLoad("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source")
end,"กดแล้วเปิด Infinite Yield ของเดิมทันที ตามที่กำหนดไว้ ไม่ถูกย้ายคำสั่งเข้ามาใน UI หลัก")

ToolTab:NewButton("💻 Quirky CMD",function()
    SafeLoad("https://gist.github.com/someunknowndude/38cecea5be9d75cb743eac8b1eaf6758/raw")
end,"กดแล้วเปิด Quirky CMD ของเดิมทันที ตามที่กำหนดไว้")

Notify("RUNLUA-HUB UI โหลดเสร็จแล้ว!")
print("RUNLUA-HUB UI READY")

    )
end)

task.wait(0.05)
tween(Main, 0.45, {
    Size = UDim2.fromOffset(410, 295)
})

Notify("เปิด RUNLUA CONTROL แล้ว")
