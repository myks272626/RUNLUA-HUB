--// ============================================================
--// RUNLUA HUB - RANDOM 1 PLAYER SERVER FINDER
--// ผู้สร้าง / เครดิต: RUNLUA HUB
--// แก้เพิ่ม:
--// 1) ย้ายเซิฟแล้วรัน Main-GUI-2.lua อัตโนมัติ
--// 2) หาเซิฟเรื่อยๆ จนกว่าจะเจอ
--// ============================================================

local HttpService = game:GetService("HttpService")
local TweenService = game:GetService("TweenService")
local TeleportService = game:GetService("TeleportService")
local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local StarterGui = game:GetService("StarterGui")

local LocalPlayer = Players.LocalPlayer

local DISCORD_LINK = "https://discord.gg/y3SESh44C8"

local AUTO_RUN_SCRIPT = [[
task.wait(3)
loadstring(game:HttpGet("https://raw.githubusercontent.com/wackshopr-tech/script-roblox-all/refs/heads/main/Main-GUI-2.lua", true))()
]]

--// ============================================================
--// QUEUE ON TELEPORT
--// ============================================================

local queueTeleport =
    queue_on_teleport
    or queueonteleport
    or (syn and syn.queue_on_teleport)
    or (fluxus and fluxus.queue_on_teleport)

local function QueueAutoRun()
    if queueTeleport then
        pcall(function()
            queueTeleport(AUTO_RUN_SCRIPT)
        end)
        return true
    end

    return false
end

--// ============================================================
--// REQUEST
--// ============================================================

local requestFunc =
    (syn and syn.request)
    or (http and http.request)
    or http_request
    or (fluxus and fluxus.request)
    or request

if not requestFunc then
    error("Executor นี้ไม่รองรับ HTTP Request")
end

--// ============================================================
--// ลบ GUI เก่า
--// ============================================================

pcall(function()
    if CoreGui:FindFirstChild("RUNLUA_SERVER_FINDER") then
        CoreGui.RUNLUA_SERVER_FINDER:Destroy()
    end
end)

--// ============================================================
--// คัดลอก Discord อัตโนมัติ
--// ============================================================

local copied = false

pcall(function()
    local clipboard = setclipboard or toclipboard
    if clipboard then
        clipboard(DISCORD_LINK)
        copied = true
    end
end)

--// ============================================================
--// GUI
--// ============================================================

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "RUNLUA_SERVER_FINDER"
ScreenGui.ResetOnSpawn = false
ScreenGui.IgnoreGuiInset = true
ScreenGui.Parent = CoreGui

local Overlay = Instance.new("Frame")
Overlay.Size = UDim2.fromScale(1, 1)
Overlay.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Overlay.BackgroundTransparency = 1
Overlay.Parent = ScreenGui

local Main = Instance.new("Frame")
Main.AnchorPoint = Vector2.new(0.5, 0.5)
Main.Position = UDim2.fromScale(0.5, 0.5)
Main.Size = UDim2.fromOffset(0, 0)
Main.BackgroundColor3 = Color3.fromRGB(12, 12, 16)
Main.BorderSizePixel = 0
Main.ClipsDescendants = true
Main.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 18)
MainCorner.Parent = Main

local Stroke = Instance.new("UIStroke")
Stroke.Color = Color3.fromRGB(150, 70, 255)
Stroke.Thickness = 2
Stroke.Transparency = 0.2
Stroke.Parent = Main

local Gradient = Instance.new("UIGradient")
Gradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(25, 16, 38)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(12, 12, 16)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(15, 20, 38))
})
Gradient.Rotation = 45
Gradient.Parent = Main

local Title = Instance.new("TextLabel")
Title.BackgroundTransparency = 1
Title.Position = UDim2.new(0, 20, 0, 15)
Title.Size = UDim2.new(1, -40, 0, 35)
Title.Font = Enum.Font.GothamBold
Title.Text = "RUNLUA HUB"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 24
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = Main

local SubTitle = Instance.new("TextLabel")
SubTitle.BackgroundTransparency = 1
SubTitle.Position = UDim2.new(0, 20, 0, 50)
SubTitle.Size = UDim2.new(1, -40, 0, 22)
SubTitle.Font = Enum.Font.Gotham
SubTitle.Text = "ระบบสุ่มค้นหาเซิร์ฟเวอร์ 1 คน"
SubTitle.TextColor3 = Color3.fromRGB(165, 165, 180)
SubTitle.TextSize = 13
SubTitle.TextXAlignment = Enum.TextXAlignment.Left
SubTitle.Parent = Main

local StatusBox = Instance.new("Frame")
StatusBox.Position = UDim2.new(0, 20, 0, 85)
StatusBox.Size = UDim2.new(1, -40, 0, 85)
StatusBox.BackgroundColor3 = Color3.fromRGB(20, 20, 27)
StatusBox.BorderSizePixel = 0
StatusBox.Parent = Main

local StatusCorner = Instance.new("UICorner")
StatusCorner.CornerRadius = UDim.new(0, 12)
StatusCorner.Parent = StatusBox

local StatusStroke = Instance.new("UIStroke")
StatusStroke.Color = Color3.fromRGB(80, 80, 105)
StatusStroke.Transparency = 0.4
StatusStroke.Parent = StatusBox

local Status = Instance.new("TextLabel")
Status.BackgroundTransparency = 1
Status.Position = UDim2.new(0, 15, 0, 10)
Status.Size = UDim2.new(1, -30, 1, -20)
Status.Font = Enum.Font.GothamMedium
Status.Text = "กำลังเริ่มระบบ..."
Status.TextColor3 = Color3.fromRGB(230, 230, 240)
Status.TextSize = 15
Status.TextWrapped = true
Status.Parent = StatusBox

local Footer = Instance.new("TextLabel")
Footer.BackgroundTransparency = 1
Footer.Position = UDim2.new(0, 20, 1, -35)
Footer.Size = UDim2.new(1, -40, 0, 20)
Footer.Font = Enum.Font.Gotham
Footer.Text = "สร้างโดย RUNLUA HUB"
Footer.TextColor3 = Color3.fromRGB(120, 120, 140)
Footer.TextSize = 11
Footer.Parent = Main

local ProgressBG = Instance.new("Frame")
ProgressBG.Position = UDim2.new(0, 20, 0, 185)
ProgressBG.Size = UDim2.new(1, -40, 0, 6)
ProgressBG.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
ProgressBG.BorderSizePixel = 0
ProgressBG.Parent = Main

local ProgressCorner = Instance.new("UICorner")
ProgressCorner.CornerRadius = UDim.new(1, 0)
ProgressCorner.Parent = ProgressBG

local Progress = Instance.new("Frame")
Progress.Size = UDim2.new(0, 0, 1, 0)
Progress.BackgroundColor3 = Color3.fromRGB(150, 70, 255)
Progress.BorderSizePixel = 0
Progress.Parent = ProgressBG

local ProgressCorner2 = Instance.new("UICorner")
ProgressCorner2.CornerRadius = UDim.new(1, 0)
ProgressCorner2.Parent = Progress

--// ============================================================
--// เปิด GUI แบบ Animation
--// ============================================================

TweenService:Create(
    Overlay,
    TweenInfo.new(0.25),
    {BackgroundTransparency = 0.55}
):Play()

TweenService:Create(
    Main,
    TweenInfo.new(0.55, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
    {Size = UDim2.fromOffset(390, 250)}
):Play()

--// ============================================================
--// แจ้งเตือน Clipboard
--// ============================================================

task.delay(0.7, function()
    pcall(function()
        StarterGui:SetCore("SendNotification", {
            Title = "RUNLUA HUB",
            Text = copied and "คัดลอกลิงก์ Discord แล้ว ✅" or "Executor นี้ไม่รองรับการคัดลอก Clipboard",
            Duration = 5
        })
    end)
end)

--// ============================================================
--// API
--// ============================================================

local function FetchServers(cursor)
    local url =
        "https://games.roblox.com/v1/games/"
        .. game.PlaceId
        .. "/servers/Public?sortOrder=Asc&limit=100"

    if cursor then
        url = url .. "&cursor=" .. HttpService:UrlEncode(cursor)
    end

    local success, response = pcall(function()
        return requestFunc({
            Url = url,
            Method = "GET"
        })
    end)

    if not success or not response then
        return nil
    end

    local body = response.Body or response.body
    if not body then
        return nil
    end

    local decodeSuccess, data = pcall(function()
        return HttpService:JSONDecode(body)
    end)

    if decodeSuccess then
        return data
    end

    return nil
end

--// ============================================================
--// ค้นหาเซิร์ฟเวอร์ที่มี "1 คนเท่านั้น"
--// ============================================================

local function FindOnePlayerServers(round)
    local foundServers = {}
    local cursor = nil
    local pages = 0

    repeat
        pages += 1

        Status.Text =
            "🔍 กำลังสแกนเซิร์ฟเวอร์...\nรอบที่ "
            .. round
            .. " | หน้าที่ "
            .. pages

        TweenService:Create(
            Progress,
            TweenInfo.new(0.25),
            {
                Size = UDim2.new(math.min(pages / 10, 1), 0, 1, 0)
            }
        ):Play()

        local data = FetchServers(cursor)

        if not data or not data.data then
            Status.Text = "⚠️ โหลดรายชื่อเซิร์ฟเวอร์ไม่สำเร็จ\nกำลังลองใหม่..."
            task.wait(2)
            break
        end

        for _, server in ipairs(data.data) do
            if server.playing == 1 and server.id ~= game.JobId then
                table.insert(foundServers, server)
            end
        end

        cursor = data.nextPageCursor
        task.wait(0.15)

    until not cursor

    return foundServers
end

--// ============================================================
--// RANDOM SERVER + LOOP หาเรื่อยๆ
--// ============================================================

task.spawn(function()
    task.wait(1)

    local round = 0

    while true do
        round += 1

        Progress.BackgroundColor3 = Color3.fromRGB(150, 70, 255)
        Progress.Size = UDim2.new(0, 0, 1, 0)

        Status.Text =
            "🔍 กำลังหาเซิร์ฟเวอร์ที่มีผู้เล่น 1 คน...\nรอบที่ "
            .. round

        local servers = FindOnePlayerServers(round)

        if #servers > 0 then
            local randomServer = servers[math.random(1, #servers)]

            local queued = QueueAutoRun()

            Status.Text =
                "✅ พบเซิร์ฟเวอร์ 1 คน "
                .. #servers
                .. " เซิร์ฟ\n🎲 กำลังย้ายเซิร์ฟเวอร์..."
                .. (queued and "\n✅ ตั้งค่ารันสคริปต์หลังย้ายแล้ว" or "\n⚠️ Executor ไม่รองรับ queue_on_teleport")

            Progress.BackgroundColor3 = Color3.fromRGB(70, 255, 140)

            TweenService:Create(
                Progress,
                TweenInfo.new(0.3),
                {Size = UDim2.new(1, 0, 1, 0)}
            ):Play()

            task.wait(1.5)

            local success, err = pcall(function()
                TeleportService:TeleportToPlaceInstance(
                    game.PlaceId,
                    randomServer.id,
                    LocalPlayer
                )
            end)

            if not success then
                Status.Text =
                    "❌ ย้ายเซิร์ฟเวอร์ไม่สำเร็จ\n"
                    .. tostring(err)
                    .. "\nกำลังหาเซิร์ฟใหม่..."

                Progress.BackgroundColor3 = Color3.fromRGB(255, 70, 70)
                task.wait(3)
            else
                break
            end
        else
            Status.Text =
                "❌ ยังไม่พบเซิร์ฟเวอร์ที่มี 1 คน\nกำลังหาใหม่เรื่อยๆ..."

            Progress.BackgroundColor3 = Color3.fromRGB(255, 170, 60)

            task.wait(5)
        end
    end
end)
