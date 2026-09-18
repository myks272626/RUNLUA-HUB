-- UI FREE BY RUNLUA HUB

local Library = {}

--// Services
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local GuiService = game:GetService("GuiService")
local CoreGui = game:GetService("CoreGui")

local LocalPlayer = Players.LocalPlayer

--// Defaults
local DefaultConfig = {
    WindowSize = Vector2.new(460, 330),
    WindowMinSize = Vector2.new(320, 240),

    SidebarWidth = 118,
    SidebarWidthCompact = 48,
    CompactBreakpoint = 480,

    HeaderHeight = 40,
    RowHeight = 34,
    RowHeightDesc = 46,
    RowSpacing = 5,
    Padding = 10,

    CornerRadius = 9,

    AnimFast = 0.15,
    AnimNormal = 0.22,
    AnimSlow = 0.35,

    MaxNotifications = 4,
    DragThreshold = 5,

    NotificationWidth = 240,
    NotificationRight = 20,
    NotificationTop = 20,
}

local DefaultTheme = {
    Background   = Color3.fromRGB(10, 16, 32),
    Surface      = Color3.fromRGB(18, 28, 50),
    SurfaceAlt   = Color3.fromRGB(24, 36, 60),
    SurfaceHover = Color3.fromRGB(30, 44, 74),

    Accent       = Color3.fromRGB(0, 132, 255),
    AccentSoft   = Color3.fromRGB(0, 90, 190),
    AccentLight  = Color3.fromRGB(90, 180, 255),

    Text         = Color3.fromRGB(232, 240, 255),
    TextMuted    = Color3.fromRGB(140, 160, 200),
    Border       = Color3.fromRGB(38, 60, 105),

    Success      = Color3.fromRGB(0, 180, 120),
    Danger       = Color3.fromRGB(220, 60, 80),
    Warning      = Color3.fromRGB(240, 180, 60),

    SwitchOff    = Color3.fromRGB(40, 52, 76),
    Shadow       = Color3.fromRGB(0, 0, 0),
    White        = Color3.fromRGB(255, 255, 255),
}

local Fonts = {
    Bold = Enum.Font.GothamBold,
    Medium = Enum.Font.GothamMedium,
    Regular = Enum.Font.Gotham,
    Black = Enum.Font.GothamBlack,
}

Library.Config = table.clone(DefaultConfig)
Library.Theme = table.clone(DefaultTheme)
Library.Fonts = Fonts

--// Utilities
local function merge(base, override)
    local out = table.clone(base)
    if override then
        for k, v in pairs(override) do
            out[k] = v
        end
    end
    return out
end

local function getViewport()
    local camera = workspace.CurrentCamera
    return camera and camera.ViewportSize or Vector2.new(1280, 720)
end

local function getSafeInset()
    local ok, inset = pcall(function()
        return GuiService:GetGuiInset()
    end)
    return ok and typeof(inset) == "Vector2" and inset or Vector2.zero
end

local function tween(obj, info, props)
    if not obj or not obj.Parent then
        return
    end
    local t = TweenService:Create(obj, info, props)
    t:Play()
    return t
end

local function corner(parent, radius)
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, radius or 7)
    c.Parent = parent
    return c
end

local function stroke(parent, color, thickness, transparency)
    local s = Instance.new("UIStroke")
    s.Color = color
    s.Thickness = thickness or 1
    s.Transparency = transparency or 0
    s.Parent = parent
    return s
end

local function padding(parent, l, r, t, b)
    local p = Instance.new("UIPadding")
    p.PaddingLeft = UDim.new(0, l or 0)
    p.PaddingRight = UDim.new(0, r or 0)
    p.PaddingTop = UDim.new(0, t or 0)
    p.PaddingBottom = UDim.new(0, b or 0)
    p.Parent = parent
    return p
end

local function textLabel(parent, props)
    local x = Instance.new("TextLabel")
    x.BackgroundTransparency = 1
    x.Text = props.Text or ""
    x.TextColor3 = props.TextColor3 or Library.Theme.Text
    x.Font = props.Font or Library.Fonts.Regular
    x.TextSize = props.TextSize or 12
    x.TextXAlignment = props.TextXAlignment or Enum.TextXAlignment.Left
    x.TextYAlignment = props.TextYAlignment or Enum.TextYAlignment.Center
    x.TextTruncate = props.TextTruncate or Enum.TextTruncate.AtEnd
    x.Size = props.Size or UDim2.new(1, 0, 1, 0)
    x.Position = props.Position or UDim2.new()
    x.Parent = parent
    return x
end

--// Icon system - GUI primitives, no emoji dependency
local Icons = {}
Library.Icons = Icons

local function iconFrame(parent, size)
    local f = Instance.new("Frame")
    f.Name = "Icon"
    f.Size = UDim2.fromOffset(size or 16, size or 16)
    f.BackgroundTransparency = 1
    f.BorderSizePixel = 0
    f.Parent = parent
    return f
end

local function bar(parent, x, y, w, h, color, rotation)
    local b = Instance.new("Frame")
    b.AnchorPoint = Vector2.new(0.5, 0.5)
    b.Position = UDim2.fromScale(x, y)
    b.Size = UDim2.fromScale(w, h)
    b.Rotation = rotation or 0
    b.BackgroundColor3 = color
    b.BorderSizePixel = 0
    b.Parent = parent
    corner(b, 1)
    return b
end

local function dot(parent, x, y, size, color)
    local d = Instance.new("Frame")
    d.AnchorPoint = Vector2.new(0.5, 0.5)
    d.Position = UDim2.fromScale(x, y)
    d.Size = UDim2.fromScale(size, size)
    d.BackgroundColor3 = color
    d.BorderSizePixel = 0
    d.Parent = parent
    corner(d, 999)
    return d
end

Icons.Home = function(parent, color)
    local f = iconFrame(parent)
    local roof = Instance.new("Frame")
    roof.AnchorPoint = Vector2.new(.5,.5)
    roof.Position = UDim2.fromScale(.5,.35)
    roof.Size = UDim2.fromScale(.75,.75)
    roof.Rotation = 45
    roof.BackgroundColor3 = color
    roof.BorderSizePixel = 0
    roof.Parent = f
    corner(roof, 2)

    local base = Instance.new("Frame")
    base.AnchorPoint = Vector2.new(.5,.5)
    base.Position = UDim2.fromScale(.5,.75)
    base.Size = UDim2.fromScale(.55,.4)
    base.BackgroundColor3 = color
    base.BorderSizePixel = 0
    base.Parent = f
    corner(base, 2)
    return f
end

Icons.Player = function(parent, color)
    local f = iconFrame(parent)
    dot(f, .5, .32, .45, color)
    local body = Instance.new("Frame")
    body.AnchorPoint = Vector2.new(.5,.5)
    body.Position = UDim2.fromScale(.5,.82)
    body.Size = UDim2.fromScale(.8,.4)
    body.BackgroundColor3 = color
    body.BorderSizePixel = 0
    body.Parent = f
    corner(body, 6)
    return f
end

Icons.ESP = function(parent, color)
    local f = iconFrame(parent)
    local eye = Instance.new("Frame")
    eye.AnchorPoint = Vector2.new(.5,.5)
    eye.Position = UDim2.fromScale(.5,.5)
    eye.Size = UDim2.fromScale(.9,.55)
    eye.BackgroundColor3 = color
    eye.BorderSizePixel = 0
    eye.Parent = f
    corner(eye, 99)

    local inner = Instance.new("Frame")
    inner.AnchorPoint = Vector2.new(.5,.5)
    inner.Position = UDim2.fromScale(.5,.5)
    inner.Size = UDim2.fromScale(.68,.42)
    inner.BackgroundColor3 = Library.Theme.Surface
    inner.BorderSizePixel = 0
    inner.Parent = eye
    corner(inner, 99)
    dot(eye,.5,.5,.3,color)
    return f
end

Icons.Float = function(parent, color)
    local f = iconFrame(parent)
    bar(f,.5,.15,.12,.28,color)
    bar(f,.5,.85,.12,.28,color)
    bar(f,.15,.5,.28,.12,color)
    bar(f,.85,.5,.28,.12,color)
    dot(f,.5,.5,.12,color)
    return f
end

Icons.Teleport = function(parent, color)
    local f = iconFrame(parent)
    bar(f,.5,.35,.5,.1,color)
    bar(f,.5,.58,.75,.1,color)
    bar(f,.5,.82,.65,.13,color)
    dot(f,.5,.15,.15,color)
    return f
end

Icons.Fling = function(parent, color)
    local f = iconFrame(parent)
    dot(f,.5,.5,.22,color)
    bar(f,.5,.12,.1,.22,color)
    bar(f,.5,.88,.1,.22,color)
    bar(f,.12,.5,.22,.1,color)
    bar(f,.88,.5,.22,.1,color)
    return f
end

Icons.Settings = function(parent, color)
    local f = iconFrame(parent)
    dot(f,.5,.5,.65,color)
    local hole = Instance.new("Frame")
    hole.AnchorPoint = Vector2.new(.5,.5)
    hole.Position = UDim2.fromScale(.5,.5)
    hole.Size = UDim2.fromScale(.28,.28)
    hole.BackgroundColor3 = Library.Theme.Surface
    hole.BorderSizePixel = 0
    hole.Parent = f
    corner(hole,99)
    for i = 0, 7 do
        local a = math.rad(i * 45)
        bar(f,.5 + math.cos(a)*.38,.5 + math.sin(a)*.38,.14,.24,color, i%2==0 and 0 or 0)
    end
    return f
end

Icons.Action = function(parent, color)
    local f = iconFrame(parent)
    bar(f,.2,.5,.32,.12,color)
    bar(f,.65,.35,.42,.12,color,-45)
    bar(f,.65,.65,.42,.12,color,45)
    return f
end

Icons.Check = function(parent, color)
    local f = iconFrame(parent)
    bar(f,.35,.58,.25,.12,color,45)
    bar(f,.65,.42,.55,.12,color,-45)
    return f
end

Icons.Warning = function(parent, color)
    local f = iconFrame(parent)
    local tri = Instance.new("Frame")
    tri.AnchorPoint = Vector2.new(.5,.5)
    tri.Position = UDim2.fromScale(.5,.5)
    tri.Size = UDim2.fromScale(.7,.7)
    tri.Rotation = 45
    tri.BackgroundColor3 = color
    tri.BorderSizePixel = 0
    tri.Parent = f
    corner(tri,2)
    dot(f,.5,.52,.1,Library.Theme.Background)
    bar(f,.5,.72,.1,.18,Library.Theme.Background)
    return f
end

Icons.Minimize = function(parent, color)
    local f = iconFrame(parent,12)
    bar(f,.5,.5,.7,.14,color)
    return f
end

Icons.Close = function(parent, color)
    local f = iconFrame(parent,12)
    bar(f,.5,.5,.7,.14,color,45)
    bar(f,.5,.5,.7,.14,color,-45)
    return f
end

--// Window
local WindowMethods = {}
local TabMethods = {}

local function connect(window, signal, callback)
    local c = signal:Connect(callback)
    table.insert(window._connections, c)
    return c
end

local function destroyChildren(parent, keep)
    for _, child in ipairs(parent:GetChildren()) do
        if not keep or not keep[child] then
            child:Destroy()
        end
    end
end

function Library:CreateWindow(options)
    options = options or {}

    local cfg = merge(DefaultConfig, options.Config)
    local theme = merge(DefaultTheme, options.Theme)

    local window = setmetatable({
        Config = cfg,
        Theme = theme,
        _connections = {},
        _tabs = {},
        _activeTab = nil,
        _alive = true,
        _hidden = false,
        _rowOrder = 0,
        _notifQueue = {},
        _notifActive = 0,
        _notifRunning = false,
    }, {__index = WindowMethods})

    -- Per-window theme is used by components through temporary library values.
    -- Keep the public Library theme synchronized for custom icon functions.
    Library.Config = cfg
    Library.Theme = theme

    local gui = Instance.new("ScreenGui")
    gui.Name = options.Name or "RUNLUA_UI"
    gui.ResetOnSpawn = false
    gui.IgnoreGuiInset = true
    gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

    local parented = pcall(function()
        gui.Parent = CoreGui
    end)
    if not parented or not gui.Parent then
        gui.Parent = LocalPlayer:WaitForChild("PlayerGui")
    end
    window.Gui = gui

    local main = Instance.new("Frame")
    main.Name = "MainFrame"
    main.AnchorPoint = Vector2.new(.5,.5)
    main.Position = UDim2.fromScale(.5,.5)
    main.Size = UDim2.fromOffset(cfg.WindowSize.X,cfg.WindowSize.Y)
    main.BackgroundColor3 = theme.Background
    main.BorderSizePixel = 0
    main.Parent = gui
    window.Main = main
    corner(main,12)
    stroke(main,theme.Accent,1.2,.55)

    local constraint = Instance.new("UISizeConstraint")
    constraint.MinSize = cfg.WindowMinSize
    constraint.Parent = main

    local scale = Instance.new("UIScale")
    scale.Parent = main
    window.Scale = scale

    local header = Instance.new("Frame")
    header.Name = "Header"
    header.Size = UDim2.new(1,0,0,cfg.HeaderHeight)
    header.BackgroundColor3 = theme.Surface
    header.BorderSizePixel = 0
    header.Parent = main
    corner(header,12)

    local cover = Instance.new("Frame")
    cover.Size = UDim2.new(1,0,0,10)
    cover.Position = UDim2.new(0,0,1,-10)
    cover.BackgroundColor3 = theme.Surface
    cover.BorderSizePixel = 0
    cover.Parent = header

    window.Header = header

    local logo = Instance.new("ImageLabel")
    logo.Name = "Logo"
    logo.Size = UDim2.fromOffset(26,26)
    logo.Position = UDim2.new(0,10,.5,-13)
    logo.BackgroundTransparency = 1
    logo.ScaleType = Enum.ScaleType.Crop
    logo.Image = options.Logo or ""
    logo.Parent = header
    corner(logo,99)
    stroke(logo,theme.Accent,1.5,.2)

    local title = textLabel(header,{
        Text = options.Title or "RUNLUA HUB",
        TextColor3 = theme.Text,
        Font = Fonts.Bold,
        TextSize = 12,
        Size = UDim2.new(0,170,0,14),
        Position = UDim2.new(0,42,0,6),
    })
    window.TitleLabel = title

    local subtitle = textLabel(header,{
        Text = options.Subtitle or "UI Library",
        TextColor3 = theme.AccentLight,
        Font = Fonts.Regular,
        TextSize = 9,
        Size = UDim2.new(0,190,0,12),
        Position = UDim2.new(0,42,0,21),
    })
    window.SubtitleLabel = subtitle

    local minBtn = Instance.new("TextButton")
    minBtn.Size = UDim2.fromOffset(24,24)
    minBtn.Position = UDim2.new(1,-60,.5,-12)
    minBtn.BackgroundColor3 = theme.SurfaceAlt
    minBtn.Text = ""
    minBtn.AutoButtonColor = false
    minBtn.Parent = header
    corner(minBtn,6)
    local minIcon = Instance.new("Frame")
    minIcon.Size = UDim2.fromScale(1,1)
    minIcon.BackgroundTransparency = 1
    minIcon.Parent = minBtn
    Icons.Minimize(minIcon,theme.Text)

    local closeBtn = Instance.new("TextButton")
    closeBtn.Size = UDim2.fromOffset(24,24)
    closeBtn.Position = UDim2.new(1,-32,.5,-12)
    closeBtn.BackgroundColor3 = theme.Danger
    closeBtn.Text = ""
    closeBtn.AutoButtonColor = false
    closeBtn.Parent = header
    corner(closeBtn,6)
    local closeIcon = Instance.new("Frame")
    closeIcon.Size = UDim2.fromScale(1,1)
    closeIcon.BackgroundTransparency = 1
    closeIcon.Parent = closeBtn
    Icons.Close(closeIcon,theme.White)

    window.MinimizeButton = minBtn
    window.CloseButton = closeBtn

    connect(window,minBtn.Activated,function()
        window:Toggle()
    end)
    connect(window,closeBtn.Activated,function()
        window:Destroy()
    end)

    for _, btn in ipairs({minBtn,closeBtn}) do
        connect(window,btn.MouseEnter,function()
            tween(btn,TweenInfo.new(cfg.AnimFast),{
                BackgroundColor3 = btn == closeBtn and Color3.fromRGB(240,90,110) or theme.SurfaceHover
            })
        end)
        connect(window,btn.MouseLeave,function()
            tween(btn,TweenInfo.new(cfg.AnimFast),{
                BackgroundColor3 = btn == closeBtn and theme.Danger or theme.SurfaceAlt
            })
        end)
    end

    --// Main layout
    local sidebar = Instance.new("Frame")
    sidebar.Name = "Sidebar"
    sidebar.Size = UDim2.new(0,cfg.SidebarWidth,1,-(cfg.HeaderHeight+12))
    sidebar.Position = UDim2.new(0,8,0,cfg.HeaderHeight+4)
    sidebar.BackgroundColor3 = theme.Surface
    sidebar.BorderSizePixel = 0
    sidebar.Parent = main
    corner(sidebar,9)
    stroke(sidebar,theme.Border,1,.6)
    window.Sidebar = sidebar

    local sideLayout = Instance.new("UIListLayout")
    sideLayout.SortOrder = Enum.SortOrder.LayoutOrder
    sideLayout.Padding = UDim.new(0,4)
    sideLayout.Parent = sidebar
    padding(sidebar,5,5,6,6)

    local content = Instance.new("Frame")
    content.Name = "Content"
    content.Size = UDim2.new(1,-(cfg.SidebarWidth+24),1,-(cfg.HeaderHeight+12))
    content.Position = UDim2.new(0,cfg.SidebarWidth+16,0,cfg.HeaderHeight+4)
    content.BackgroundTransparency = 1
    content.ClipsDescendants = false
    content.Parent = main
    window.Content = content

    local pages = Instance.new("Folder")
    pages.Name = "Pages"
    pages.Parent = content
    window.Pages = pages

    local notifications = Instance.new("Frame")
    notifications.Name = "Notifications"
    notifications.BackgroundTransparency = 1
    notifications.Size = UDim2.new(0,cfg.NotificationWidth,1,-40)
    notifications.Position = UDim2.new(1,-cfg.NotificationWidth-cfg.NotificationRight,0,cfg.NotificationTop)
    notifications.Parent = gui

    local nLayout = Instance.new("UIListLayout")
    nLayout.SortOrder = Enum.SortOrder.LayoutOrder
    nLayout.Padding = UDim.new(0,6)
    nLayout.HorizontalAlignment = Enum.HorizontalAlignment.Right
    nLayout.VerticalAlignment = Enum.VerticalAlignment.Top
    nLayout.Parent = notifications
    window.Notifications = notifications

    --// Dragging
    do
        local dragging = false
        local dragStart
        local startPos
        local dragInput

        local function clamp(pos)
            local vp = getViewport()
            local inset = getSafeInset()
            local w,h = main.AbsoluteSize.X,main.AbsoluteSize.Y

            local x = pos.X.Offset + pos.X.Scale * vp.X
            local y = pos.Y.Offset + pos.Y.Scale * vp.Y

            local minX,maxX = -w+60,vp.X-60
            local minY,maxY = inset.Y,vp.Y-40

            if maxX < minX then maxX = minX end
            if maxY < minY then maxY = minY end

            return UDim2.fromOffset(
                math.clamp(x,minX,maxX),
                math.clamp(y,minY,maxY)
            )
        end

        connect(window,header.InputBegan,function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1
                or input.UserInputType == Enum.UserInputType.Touch then
                dragging = true
                dragStart = input.Position
                startPos = main.Position
                dragInput = input

                local c
                c = input.Changed:Connect(function()
                    if input.UserInputState == Enum.UserInputState.End then
                        dragging = false
                        dragInput = nil
                        if c then c:Disconnect() end
                    end
                end)
            end
        end)

        connect(window,UserInputService.InputChanged,function(input)
            if not dragging or not main.Parent then return end
            if input == dragInput and (
                input.UserInputType == Enum.UserInputType.MouseMovement
                or input.UserInputType == Enum.UserInputType.Touch
            ) then
                local delta = input.Position - dragStart
                main.Position = clamp(UDim2.new(
                    startPos.X.Scale,startPos.X.Offset+delta.X,
                    startPos.Y.Scale,startPos.Y.Offset+delta.Y
                ))
            end
        end)
    end

    --// Responsive
    local function computeScale()
        local vp = getViewport()
        local inset = getSafeInset()
        local sx = (vp.X-inset.X-30)/cfg.WindowSize.X
        local sy = (vp.Y-inset.Y-30)/cfg.WindowSize.Y
        return math.max(.55,math.min(1,sx,sy))
    end

    function window:_updateResponsive()
        if not self._alive then return end

        local vp = getViewport()
        local compact = vp.X < cfg.CompactBreakpoint
        self._compact = compact

        local sw = compact and cfg.SidebarWidthCompact or cfg.SidebarWidth

        sidebar.Size = UDim2.new(0,sw,1,-(cfg.HeaderHeight+12))
        content.Size = UDim2.new(1,-(sw+24),1,-(cfg.HeaderHeight+12))
        content.Position = UDim2.new(0,sw+16,0,cfg.HeaderHeight+4)

        scale.Scale = computeScale()

        for _, tab in ipairs(self._tabs) do
            if tab.Label then
                tab.Label.Visible = not compact
            end
            if tab.IconHolder then
                tab.IconHolder.Position = compact
                    and UDim2.new(.5,-8,.5,-8)
                    or UDim2.new(0,10,.5,-8)
            end
        end
    end

    connect(window,workspace:GetPropertyChangedSignal("CurrentCamera"),function()
        task.defer(function()
            window:_updateResponsive()
        end)
    end)

    if workspace.CurrentCamera then
        connect(window,workspace.CurrentCamera:GetPropertyChangedSignal("ViewportSize"),function()
            window:_updateResponsive()
        end)
    end

    window:_updateResponsive()

    function window:_selectTab(tab)
        if not tab or not self._alive then return end

        for _, t in ipairs(self._tabs) do
            local active = t == tab
            t.Page.Visible = active

            if active then
                tween(t.Button,TweenInfo.new(cfg.AnimFast),{BackgroundColor3=theme.Accent})
                tween(t.Indicator,TweenInfo.new(cfg.AnimFast),{BackgroundTransparency=0})
                t.Label.TextColor3 = theme.White
                for _, c in ipairs(t.IconHolder:GetChildren()) do
                    if c:IsA("Frame") then
                        c.BackgroundColor3 = theme.White
                        for _, s in ipairs(c:GetChildren()) do
                            if s:IsA("Frame") then s.BackgroundColor3 = theme.White end
                        end
                    end
                end
            else
                tween(t.Button,TweenInfo.new(cfg.AnimFast),{BackgroundColor3=theme.SurfaceAlt})
                tween(t.Indicator,TweenInfo.new(cfg.AnimFast),{BackgroundTransparency=1})
                t.Label.TextColor3 = theme.TextMuted
                for _, c in ipairs(t.IconHolder:GetChildren()) do
                    if c:IsA("Frame") then
                        c.BackgroundColor3 = theme.TextMuted
                        for _, s in ipairs(c:GetChildren()) do
                            if s:IsA("Frame") then s.BackgroundColor3 = theme.TextMuted end
                        end
                    end
                end
            end
        end

        self._activeTab = tab
        if tab.OnSelected then
            task.spawn(tab.OnSelected)
        end
    end

    --// Notification worker
    function window:Notify(opts)
        if not self._alive then return end
        opts = opts or {}

        table.insert(self._notifQueue,{
            Title = opts.Title or "Notification",
            Message = opts.Message or "",
            Duration = opts.Duration or 3,
            Color = opts.Color or theme.Accent,
            Icon = opts.Icon or Icons.Home,
        })

        if self._notifRunning then return end
        self._notifRunning = true

        task.spawn(function()
            while #self._notifQueue > 0 and self._alive and notifications.Parent do
                local data = table.remove(self._notifQueue,1)

                if self._notifActive >= cfg.MaxNotifications then
                    for _, child in ipairs(notifications:GetChildren()) do
                        if child:IsA("Frame") then
                            child:Destroy()
                            self._notifActive = math.max(0,self._notifActive-1)
                            break
                        end
                    end
                end

                local card = Instance.new("Frame")
                card.Size = UDim2.new(1,0,0,48)
                card.BackgroundColor3 = theme.Surface
                card.BackgroundTransparency = 1
                card.BorderSizePixel = 0
                card.Parent = notifications
                corner(card,cfg.CornerRadius)

                local s = stroke(card,data.Color,1.5,1)

                local accent = Instance.new("Frame")
                accent.Size = UDim2.new(0,3,.7,0)
                accent.Position = UDim2.new(0,0,.15,0)
                accent.BackgroundColor3 = data.Color
                accent.BorderSizePixel = 0
                accent.Parent = card
                corner(accent,99)

                local ih = Instance.new("Frame")
                ih.Size = UDim2.fromOffset(16,16)
                ih.Position = UDim2.new(0,10,0,16)
                ih.BackgroundTransparency = 1
                ih.Parent = card
                pcall(data.Icon,ih,data.Color)

                textLabel(card,{
                    Text=data.Title,
                    TextColor3=theme.Text,
                    Font=Fonts.Bold,
                    TextSize=12,
                    Size=UDim2.new(1,-38,0,15),
                    Position=UDim2.new(0,34,0,7),
                })

                textLabel(card,{
                    Text=data.Message,
                    TextColor3=theme.TextMuted,
                    Font=Fonts.Regular,
                    TextSize=10,
                    Size=UDim2.new(1,-38,0,14),
                    Position=UDim2.new(0,34,0,24),
                })

                self._notifActive += 1

                tween(card,TweenInfo.new(cfg.AnimNormal),{BackgroundTransparency=0})
                tween(s,TweenInfo.new(cfg.AnimNormal),{Transparency=.4})

                task.delay(data.Duration,function()
                    if card.Parent then
                        tween(card,TweenInfo.new(cfg.AnimNormal),{BackgroundTransparency=1})
                        tween(s,TweenInfo.new(cfg.AnimNormal),{Transparency=1})
                        task.delay(cfg.AnimNormal,function()
                            if card.Parent then card:Destroy() end
                            self._notifActive = math.max(0,self._notifActive-1)
                        end)
                    end
                end)
            end
            self._notifRunning = false
        end)
    end

    --// Show / hide / toggle
    function window:Show()
        if not self._alive then return end
        self._hidden = false
        main.Visible = true
        scale.Scale = computeScale()*.9
        tween(scale,TweenInfo.new(cfg.AnimNormal,Enum.EasingStyle.Back,Enum.EasingDirection.Out),{
            Scale=computeScale()
        })
    end

    function window:Hide()
        if not self._alive then return end
        self._hidden = true
        tween(scale,TweenInfo.new(cfg.AnimNormal,Enum.EasingStyle.Quad,Enum.EasingDirection.In),{
            Scale=math.max(.01,computeScale()*.88)
        })
        task.delay(cfg.AnimNormal,function()
            if self._alive and self._hidden then
                main.Visible = false
            end
        end)
    end

    function window:Toggle()
        if self._hidden or not main.Visible then
            self:Show()
        else
            self:Hide()
        end
    end

    function window:SetTitle(value)
        title.Text = tostring(value or "")
    end

    function window:SetSubtitle(value)
        subtitle.Text = tostring(value or "")
    end

    function window:SetLogo(value)
        logo.Image = tostring(value or "")
    end

    function window:Destroy()
        if not self._alive then return end
        self._alive = false
        for _, c in ipairs(self._connections) do
            pcall(function() c:Disconnect() end)
        end
        table.clear(self._connections)
        if gui then gui:Destroy() end
    end

    return window
end

--// TAB
function WindowMethods:CreateTab(options)
    options = options or {}

    local cfg,theme = self.Config,self.Theme
    self._rowOrder += 1

    local name = options.Name or "Tab"
    local page = Instance.new("ScrollingFrame")
    page.Name = name.."Page"
    page.Size = UDim2.fromScale(1,1)
    page.BackgroundTransparency = 1
    page.BorderSizePixel = 0
    page.ScrollBarThickness = 3
    page.ScrollBarImageColor3 = theme.Accent
    page.AutomaticCanvasSize = Enum.AutomaticSize.Y
    page.CanvasSize = UDim2.new()
    page.Visible = false
    page.Parent = self.Pages
    padding(page,4,6,4,6)

    local layout = Instance.new("UIListLayout")
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    layout.Padding = UDim.new(0,5)
    layout.Parent = page

    local btn = Instance.new("TextButton")
    btn.Name = "Tab_"..name
    btn.Size = UDim2.new(1,0,0,32)
    btn.BackgroundColor3 = theme.SurfaceAlt
    btn.Text = ""
    btn.AutoButtonColor = false
    btn.LayoutOrder = #self._tabs+1
    btn.Parent = self.Sidebar
    corner(btn,6)

    local indicator = Instance.new("Frame")
    indicator.Size = UDim2.new(0,3,.5,0)
    indicator.Position = UDim2.new(0,.0,.25,0)
    indicator.BackgroundColor3 = theme.AccentLight
    indicator.BackgroundTransparency = 1
    indicator.BorderSizePixel = 0
    indicator.Parent = btn
    corner(indicator,99)

    local iconHolder = Instance.new("Frame")
    iconHolder.Size = UDim2.fromOffset(16,16)
    iconHolder.Position = UDim2.new(0,10,.5,-8)
    iconHolder.BackgroundTransparency = 1
    iconHolder.Parent = btn

    local iconDraw = options.Icon or Icons.Home
    pcall(iconDraw,iconHolder,theme.TextMuted)

    local label = textLabel(btn,{
        Text=name,
        TextColor3=theme.TextMuted,
        Font=Fonts.Medium,
        TextSize=11,
        Size=UDim2.new(1,-36,1,0),
        Position=UDim2.new(0,32,0,0),
    })

    local tab = setmetatable({
        Window=self,
        Name=name,
        Page=page,
        Button=btn,
        Indicator=indicator,
        IconHolder=iconHolder,
        Label=label,
        OnSelected=options.OnSelected,
        _order=0,
    },{__index=TabMethods})

    table.insert(self._tabs,tab)

    connect(self,btn.MouseEnter,function()
        if self._activeTab ~= tab then
            tween(btn,TweenInfo.new(cfg.AnimFast),{BackgroundColor3=theme.SurfaceHover})
        end
    end)
    connect(self,btn.MouseLeave,function()
        if self._activeTab ~= tab then
            tween(btn,TweenInfo.new(cfg.AnimFast),{BackgroundColor3=theme.SurfaceAlt})
        end
    end)
    connect(self,btn.Activated,function()
        self:_selectTab(tab)
    end)

    if #self._tabs == 1 then
        self:_selectTab(tab)
    end

    return tab
end

--// Generic row
local function makeRow(tab, options, defaultHeight)
    local theme,cfg = tab.Window.Theme,tab.Window.Config
    options = options or {}
    tab._order += 1

    local row = Instance.new("Frame")
    row.Size = UDim2.new(1,0,0,options.Height or defaultHeight)
    row.BackgroundColor3 = options.BackgroundColor or theme.Surface
    row.BorderSizePixel = 0
    row.LayoutOrder = options.Order or tab._order
    row.Parent = tab.Page
    corner(row,7)
    stroke(row,options.BorderColor or theme.Border,1,.5)
    return row
end

--// SECTION
function TabMethods:Section(options)
    options = options or {}
    local theme,cfg = self.Window.Theme,self.Window.Config
    self._order += 1

    local section = Instance.new("Frame")
    section.Name = options.Name or "Section"
    section.BackgroundTransparency = 1
    section.Size = UDim2.new(1,0,0,0)
    section.AutomaticSize = Enum.AutomaticSize.Y
    section.LayoutOrder = options.Order or self._order
    section.Parent = self.Page

    local layout = Instance.new("UIListLayout")
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    layout.Padding = UDim.new(0,cfg.RowSpacing)
    layout.Parent = section

    if options.Title then
        textLabel(section,{
            Text=options.Title,
            TextColor3=theme.TextMuted,
            Font=Fonts.Bold,
            TextSize=10,
            Size=UDim2.new(1,0,0,18),
            Position=UDim2.new(),
        })
    end

    return section
end

--// DIVIDER
function TabMethods:Divider(options)
    options = options or {}
    local theme = self.Window.Theme
    self._order += 1

    local holder = Instance.new("Frame")
    holder.Size = UDim2.new(1,0,0,10)
    holder.BackgroundTransparency = 1
    holder.LayoutOrder = options.Order or self._order
    holder.Parent = self.Page

    local line = Instance.new("Frame")
    line.AnchorPoint = Vector2.new(.5,.5)
    line.Position = UDim2.fromScale(.5,.5)
    line.Size = UDim2.new(1,-16,0,1)
    line.BackgroundColor3 = theme.Border
    line.BackgroundTransparency = .4
    line.BorderSizePixel = 0
    line.Parent = holder

    return holder
end

--// LABEL
function TabMethods:Label(options)
    options = options or {}
    local theme = self.Window.Theme

    local row = makeRow(self,options,options.Description and self.Window.Config.RowHeightDesc or self.Window.Config.RowHeight)

    local iconHolder = Instance.new("Frame")
    iconHolder.Size = UDim2.fromOffset(16,16)
    iconHolder.Position = UDim2.new(0,10,.5,-8)
    iconHolder.BackgroundTransparency = 1
    iconHolder.Parent = row

    pcall(options.Icon or Icons.Action,iconHolder,options.Color or theme.Accent)

    textLabel(row,{
        Text=options.Name or options.Text or "Label",
        TextColor3=theme.Text,
        Font=Fonts.Medium,
        TextSize=12,
        Size=UDim2.new(1,-38,0,15),
        Position=UDim2.new(0,34,options.Description and 5 or 0,0),
    })

    if options.Description then
        textLabel(row,{
            Text=options.Description,
            TextColor3=theme.TextMuted,
            Font=Fonts.Regular,
            TextSize=10,
            Size=UDim2.new(1,-44,0,14),
            Position=UDim2.new(0,34,0,22),
        })
    end

    return row
end

--// BUTTON
function TabMethods:Button(options)
    options = options or {}
    local theme,cfg = self.Window.Theme,self.Window.Config
    local color = options.Color or theme.Accent

    local row = makeRow(self,options,options.Description and cfg.RowHeightDesc or cfg.RowHeight)

    local accent = Instance.new("Frame")
    accent.Size = UDim2.new(0,3,.6,0)
    accent.Position = UDim2.new(0,0,.2,0)
    accent.BackgroundColor3 = color
    accent.BorderSizePixel = 0
    accent.Parent = row
    corner(accent,99)

    local iconHolder = Instance.new("Frame")
    iconHolder.Size = UDim2.fromOffset(16,16)
    iconHolder.Position = UDim2.new(0,10,.5,-8)
    iconHolder.BackgroundTransparency = 1
    iconHolder.Parent = row
    pcall(options.Icon or Icons.Action,iconHolder,color)

    local title = textLabel(row,{
        Text=options.Name or "Button",
        TextColor3=theme.Text,
        Font=Fonts.Bold,
        TextSize=12,
        Size=UDim2.new(1,-44,0,14),
        Position=UDim2.new(0,34,options.Description and 5 or 0,0),
    })

    if options.Description then
        textLabel(row,{
            Text=options.Description,
            TextColor3=theme.TextMuted,
            Font=Fonts.Regular,
            TextSize=10,
            Size=UDim2.new(1,-44,0,14),
            Position=UDim2.new(0,34,0,20),
        })
    end

    local click = Instance.new("TextButton")
    click.Size = UDim2.fromScale(1,1)
    click.BackgroundTransparency = 1
    click.Text = ""
    click.AutoButtonColor = false
    click.Parent = row

    connect(self.Window,click.MouseEnter,function()
        tween(row,TweenInfo.new(cfg.AnimFast),{BackgroundColor3=theme.SurfaceHover})
    end)
    connect(self.Window,click.MouseLeave,function()
        tween(row,TweenInfo.new(cfg.AnimFast),{BackgroundColor3=theme.Surface})
    end)
    connect(self.Window,click.Activated,function()
        tween(click,TweenInfo.new(.08),{BackgroundTransparency=.6})
        task.delay(.1,function()
            if click.Parent then tween(click,TweenInfo.new(.15),{BackgroundTransparency=1}) end
        end)
        if options.Callback then
            task.spawn(function()
                pcall(options.Callback)
            end)
        end
    end)

    return {
        Instance=row,
        SetText=function(_,v) title.Text=tostring(v) end,
    }
end

--// TOGGLE
function TabMethods:Toggle(options)
    options = options or {}
    local theme,cfg = self.Window.Theme,self.Window.Config
    local state = options.Default == true
    local row = makeRow(self,options,options.Description and cfg.RowHeightDesc or cfg.RowHeight)

    local iconHolder = Instance.new("Frame")
    iconHolder.Size = UDim2.fromOffset(16,16)
    iconHolder.Position = UDim2.new(0,8,.5,-8)
    iconHolder.BackgroundTransparency = 1
    iconHolder.Parent = row
    pcall(options.Icon or Icons.Settings,iconHolder,theme.TextMuted)

    local title = textLabel(row,{
        Text=options.Name or "Toggle",
        TextColor3=theme.Text,
        Font=Fonts.Medium,
        TextSize=12,
        Size=UDim2.new(1,-96,0,14),
        Position=UDim2.new(0,32,options.Description and 7 or 0,0),
    })

    if options.Description then
        textLabel(row,{
            Text=options.Description,
            TextColor3=theme.TextMuted,
            Font=Fonts.Regular,
            TextSize=10,
            Size=UDim2.new(1,-96,0,14),
            Position=UDim2.new(0,32,0,22),
        })
    end

    local switch = Instance.new("Frame")
    switch.Name="Switch"
    switch.Size=UDim2.fromOffset(34,18)
    switch.Position=UDim2.new(1,-42,.5,-9)
    switch.BackgroundColor3=theme.SwitchOff
    switch.BorderSizePixel=0
    switch.Parent=row
    corner(switch,99)

    local knob=Instance.new("Frame")
    knob.Name="Knob"
    knob.Size=UDim2.fromOffset(12,12)
    knob.Position=UDim2.new(0,3,.5,-6)
    knob.BackgroundColor3=Color3.fromRGB(150,160,180)
    knob.BorderSizePixel=0
    knob.Parent=switch
    corner(knob,99)

    local function paint(animate)
        local onPos = UDim2.new(1,-15,.5,-6)
        local offPos = UDim2.new(0,3,.5,-6)
        local bg = state and theme.Accent or theme.SwitchOff
        local kc = state and theme.White or Color3.fromRGB(150,160,180)

        if animate then
            tween(knob,TweenInfo.new(cfg.AnimNormal,Enum.EasingStyle.Quad),{
                Position=state and onPos or offPos,
                BackgroundColor3=kc
            })
            tween(switch,TweenInfo.new(cfg.AnimNormal,Enum.EasingStyle.Quad),{
                BackgroundColor3=bg
            })
        else
            knob.Position=state and onPos or offPos
            knob.BackgroundColor3=kc
            switch.BackgroundColor3=bg
        end

        local ic = state and theme.AccentLight or theme.TextMuted
        for _,c in ipairs(iconHolder:GetChildren()) do
            if c:IsA("Frame") then
                c.BackgroundColor3=ic
                for _,s in ipairs(c:GetChildren()) do
                    if s:IsA("Frame") then s.BackgroundColor3=ic end
                end
            end
        end
    end

    paint(false)

    local click=Instance.new("TextButton")
    click.Size=UDim2.fromScale(1,1)
    click.BackgroundTransparency=1
    click.Text=""
    click.AutoButtonColor=false
    click.Parent=row

    connect(self.Window,click.MouseEnter,function()
        tween(row,TweenInfo.new(cfg.AnimFast),{BackgroundColor3=theme.SurfaceHover})
    end)
    connect(self.Window,click.MouseLeave,function()
        tween(row,TweenInfo.new(cfg.AnimFast),{BackgroundColor3=theme.Surface})
    end)
    connect(self.Window,click.Activated,function()
        state=not state
        paint(true)
        if options.Callback then task.spawn(function() pcall(options.Callback,state) end) end
    end)

    local api={}
    api.Instance=row
    api.Get=function() return state end
    api.Set=function(_,value,fire)
        value=value==true
        if state~=value then
            state=value
            paint(true)
            if fire and options.Callback then
                task.spawn(function() pcall(options.Callback,state) end)
            end
        elseif fire and options.Callback then
            task.spawn(function() pcall(options.Callback,state) end)
        end
    end
    api.SetValue=api.Set
    return api
end

--// SLIDER
function TabMethods:Slider(options)
    options=options or {}
    local theme,cfg=self.Window.Theme,self.Window.Config
    local min=tonumber(options.Min) or 0
    local max=tonumber(options.Max) or 100
    local value=math.clamp(tonumber(options.Default) or min,min,max)
    local decimals=tonumber(options.Decimals) or 0

    local row=makeRow(self,options,options.Description and 58 or 48)

    textLabel(row,{
        Text=options.Name or "Slider",
        TextColor3=theme.Text,
        Font=Fonts.Medium,
        TextSize=12,
        Size=UDim2.new(1,-80,0,15),
        Position=UDim2.new(0,12,0,5),
    })

    local valueLabel=textLabel(row,{
        Text="",
        TextColor3=theme.AccentLight,
        Font=Fonts.Bold,
        TextSize=11,
        TextXAlignment=Enum.TextXAlignment.Right,
        Size=UDim2.new(0,55,0,15),
        Position=UDim2.new(1,-67,0,5),
    })

    local trackFrame=Instance.new("Frame")
    trackFrame.Size=UDim2.new(1,-24,0,5)
    trackFrame.Position=UDim2.new(0,12,1,-14)
    trackFrame.BackgroundColor3=theme.SwitchOff
    trackFrame.BorderSizePixel=0
    trackFrame.Parent=row
    corner(trackFrame,99)

    local fill=Instance.new("Frame")
    fill.Size=UDim2.fromScale(0,1)
    fill.BackgroundColor3=theme.Accent
    fill.BorderSizePixel=0
    fill.Parent=trackFrame
    corner(fill,99)

    local knob=Instance.new("Frame")
    knob.Size=UDim2.fromOffset(12,12)
    knob.AnchorPoint=Vector2.new(.5,.5)
    knob.BackgroundColor3=theme.White
    knob.BorderSizePixel=0
    knob.Parent=trackFrame
    corner(knob,99)

    local hit=Instance.new("TextButton")
    hit.Size=UDim2.new(1,0,0,28)
    hit.Position=UDim2.new(0,0,1,-27)
    hit.BackgroundTransparency=1
    hit.Text=""
    hit.Parent=row

    local dragging=false

    local function format(v)
        if decimals<=0 then return tostring(math.floor(v+.5)) end
        return string.format("%."..decimals.."f",v)
    end

    local function set(v,fire,animate)
        value=math.clamp(v,min,max)
        local alpha=(value-min)/(max-min == 0 and 1 or max-min)
        valueLabel.Text=format(value)
        local info=TweenInfo.new(animate and cfg.AnimFast or 0)
        tween(fill,info,{Size=UDim2.fromScale(alpha,1)})
        tween(knob,info,{Position=UDim2.fromScale(alpha,.5)})
        if fire and options.Callback then
            task.spawn(function() pcall(options.Callback,value) end)
        end
    end

    local function fromInput(pos)
        local alpha=math.clamp((pos.X-trackFrame.AbsolutePosition.X)/trackFrame.AbsoluteSize.X,0,1)
        local raw=min+(max-min)*alpha
        local mult=10^decimals
        set(math.floor(raw*mult+.5)/mult,true,true)
    end

    connect(self.Window,hit.InputBegan,function(input)
        if input.UserInputType==Enum.UserInputType.MouseButton1
            or input.UserInputType==Enum.UserInputType.Touch then
            dragging=true
            fromInput(input.Position)
        end
    end)
    connect(self.Window,UserInputService.InputChanged,function(input)
        if dragging and (input.UserInputType==Enum.UserInputType.MouseMovement or input.UserInputType==Enum.UserInputType.Touch) then
            fromInput(input.Position)
        end
    end)
    connect(self.Window,UserInputService.InputEnded,function(input)
        if input.UserInputType==Enum.UserInputType.MouseButton1 or input.UserInputType==Enum.UserInputType.Touch then
            dragging=false
        end
    end)

    set(value,false,false)

    return {
        Instance=row,
        Get=function() return value end,
        Set=function(_,v,fire) set(tonumber(v) or min,fire~=false,true) end,
    }
end

--// DROPDOWN
function TabMethods:Dropdown(options)
    options=options or {}
    local theme,cfg=self.Window.Theme,self.Window.Config
    local values=options.Values or options.Options or {}
    local selected=options.Default
    local opened=false

    local row=makeRow(self,options,options.Description and 58 or 46)
    row.ClipsDescendants=false

    textLabel(row,{
        Text=options.Name or "Dropdown",
        TextColor3=theme.Text,
        Font=Fonts.Medium,
        TextSize=12,
        Size=UDim2.new(1,-145,0,15),
        Position=UDim2.new(0,12,options.Description and 5 or 0,0),
    })

    if options.Description then
        textLabel(row,{
            Text=options.Description,
            TextColor3=theme.TextMuted,
            Font=Fonts.Regular,
            TextSize=10,
            Size=UDim2.new(1,-150,0,14),
            Position=UDim2.new(0,12,0,22),
        })
    end

    local select=Instance.new("TextButton")
    select.Size=UDim2.new(0,120,0,28)
    select.Position=UDim2.new(1,-132,.5,-14)
    select.BackgroundColor3=theme.SurfaceAlt
    select.TextColor3=theme.Text
    select.Font=Fonts.Medium
    select.TextSize=10
    select.Text=selected ~= nil and tostring(selected) or "Select"
    select.AutoButtonColor=false
    select.Parent=row
    corner(select,6)

    local list=Instance.new("Frame")
    list.Visible=false
    list.ZIndex=20
    list.Size=UDim2.new(0,120,0,0)
    list.AutomaticSize=Enum.AutomaticSize.Y
    list.Position=UDim2.new(1,-132,1,4)
    list.BackgroundColor3=theme.Surface
    list.BorderSizePixel=0
    list.Parent=row
    corner(list,6)
    stroke(list,theme.Border,1,.35)

    local listLayout=Instance.new("UIListLayout")
    listLayout.SortOrder=Enum.SortOrder.LayoutOrder
    listLayout.Padding=UDim.new(0,2)
    listLayout.Parent=list
    padding(list,4,4,4,4)

    local function close()
        opened=false
        list.Visible=false
    end

    local function rebuild()
        for _,c in ipairs(list:GetChildren()) do
            if c:IsA("TextButton") then c:Destroy() end
        end
        for i,v in ipairs(values) do
            local b=Instance.new("TextButton")
            b.Size=UDim2.new(1,0,0,26)
            b.LayoutOrder=i
            b.BackgroundColor3=theme.SurfaceAlt
            b.Text=tostring(v)
            b.TextColor3=theme.Text
            b.Font=Fonts.Medium
            b.TextSize=10
            b.AutoButtonColor=false
            b.ZIndex=21
            b.Parent=list
            corner(b,5)
            connect(self.Window,b.Activated,function()
                selected=v
                select.Text=tostring(v)
                close()
                if options.Callback then task.spawn(function() pcall(options.Callback,v) end) end
            end)
        end
    end

    rebuild()

    connect(self.Window,select.Activated,function()
        opened=not opened
        list.Visible=opened
    end)

    return {
        Instance=row,
        Get=function() return selected end,
        Set=function(_,v,fire)
            selected=v
            select.Text=v~=nil and tostring(v) or "Select"
            if fire and options.Callback then task.spawn(function() pcall(options.Callback,v) end) end
        end,
        Refresh=function(_,newValues)
            values=newValues or {}
            rebuild()
        end,
        Close=close,
    }
end

--// TEXTBOX
function TabMethods:Textbox(options)
    options=options or {}
    local theme,cfg=self.Window.Theme,self.Window.Config
    local row=makeRow(self,options,options.Description and 58 or 46)

    textLabel(row,{
        Text=options.Name or "Textbox",
        TextColor3=theme.Text,
        Font=Fonts.Medium,
        TextSize=12,
        Size=UDim2.new(1,-150,0,15),
        Position=UDim2.new(0,12,options.Description and 5 or 0,0),
    })

    if options.Description then
        textLabel(row,{
            Text=options.Description,
            TextColor3=theme.TextMuted,
            Font=Fonts.Regular,
            TextSize=10,
            Size=UDim2.new(1,-150,0,14),
            Position=UDim2.new(0,12,0,22),
        })
    end

    local box=Instance.new("TextBox")
    box.Size=UDim2.new(0,125,0,28)
    box.Position=UDim2.new(1,-137,.5,-14)
    box.BackgroundColor3=theme.SurfaceAlt
    box.BorderSizePixel=0
    box.TextColor3=theme.Text
    box.PlaceholderColor3=theme.TextMuted
    box.Font=Fonts.Regular
    box.TextSize=10
    box.ClearTextOnFocus=options.ClearOnFocus == true
    box.PlaceholderText=options.Placeholder or ""
    box.Text=tostring(options.Default or "")
    box.TextXAlignment=Enum.TextXAlignment.Left
    box.Parent=row
    corner(box,6)
    padding(box,8,8,0,0)

    connect(self.Window,box.FocusLost,function(enter)
        if options.Callback then
            task.spawn(function() pcall(options.Callback,box.Text,enter) end)
        end
    end)

    return {
        Instance=row,
        Get=function() return box.Text end,
        Set=function(_,v,fire)
            box.Text=tostring(v or "")
            if fire and options.Callback then task.spawn(function() pcall(options.Callback,box.Text,false) end) end
        end,
        TextBox=box,
    }
end

--// KEYBIND
function TabMethods:Keybind(options)
    options=options or {}
    local theme,cfg=self.Window.Theme,self.Window.Config
    local current=options.Default
    local listening=false

    local row=makeRow(self,options,options.Description and cfg.RowHeightDesc or cfg.RowHeight)

    textLabel(row,{
        Text=options.Name or "Keybind",
        TextColor3=theme.Text,
        Font=Fonts.Medium,
        TextSize=12,
        Size=UDim2.new(1,-140,0,15),
        Position=UDim2.new(0,12,options.Description and 5 or 0,0),
    })

    if options.Description then
        textLabel(row,{
            Text=options.Description,
            TextColor3=theme.TextMuted,
            Font=Fonts.Regular,
            TextSize=10,
            Size=UDim2.new(1,-140,0,14),
            Position=UDim2.new(0,12,0,22),
        })
    end

    local keyButton=Instance.new("TextButton")
    keyButton.Size=UDim2.fromOffset(115,28)
    keyButton.Position=UDim2.new(1,-127,.5,-14)
    keyButton.BackgroundColor3=theme.SurfaceAlt
    keyButton.TextColor3=theme.Text
    keyButton.Font=Fonts.Bold
    keyButton.TextSize=10
    keyButton.AutoButtonColor=false
    keyButton.Parent=row
    corner(keyButton,6)

    local function keyName(k)
        return k and k.Name or "None"
    end
    keyButton.Text=keyName(current)

    connect(self.Window,keyButton.Activated,function()
        listening=not listening
        keyButton.Text=listening and "Press key..." or keyName(current)
    end)

    connect(self.Window,UserInputService.InputBegan,function(input,processed)
        if not self.Window._alive then return end

        if listening then
            if input.UserInputType==Enum.UserInputType.Keyboard then
                current=input.KeyCode
                listening=false
                keyButton.Text=keyName(current)
                if options.Changed then task.spawn(function() pcall(options.Changed,current) end) end
            end
            return
        end

        if processed then return end
        if current and input.KeyCode==current and options.Callback then
            task.spawn(function() pcall(options.Callback,current) end)
        end
    end)

    return {
        Instance=row,
        Get=function() return current end,
        Set=function(_,key)
            current=key
            keyButton.Text=keyName(current)
            if options.Changed then task.spawn(function() pcall(options.Changed,current) end) end
        end,
    }
end

--// PLAYER LIST
function TabMethods:PlayerList(options)
    options=options or {}
    local theme=self.Window.Theme
    local height=options.Height or 170
    local wrapper=Instance.new("Frame")
    wrapper.Name="PlayerList"
    wrapper.Size=UDim2.new(1,0,0,height)
    wrapper.BackgroundTransparency=1
    wrapper.LayoutOrder=options.Order or (self._order+1)
    wrapper.Parent=self.Page
    self._order += 1

    local scroll=Instance.new("ScrollingFrame")
    scroll.Size=UDim2.fromScale(1,1)
    scroll.BackgroundTransparency=1
    scroll.BorderSizePixel=0
    scroll.ScrollBarThickness=3
    scroll.ScrollBarImageColor3=theme.Accent
    scroll.AutomaticCanvasSize=Enum.AutomaticSize.Y
    scroll.CanvasSize=UDim2.new()
    scroll.Parent=wrapper

    local layout=Instance.new("UIListLayout")
    layout.SortOrder=Enum.SortOrder.LayoutOrder
    layout.Padding=UDim.new(0,4)
    layout.Parent=scroll
    padding(scroll,2,5,0,0)

    local selected=nil
    local cardConnections={}

    local function clearConnections()
        for _,c in ipairs(cardConnections) do pcall(function() c:Disconnect() end) end
        table.clear(cardConnections)
    end

    local function rebuild()
        if not wrapper.Parent then return end
        clearConnections()
        for _,c in ipairs(scroll:GetChildren()) do
            if c:IsA("Frame") then c:Destroy() end
        end

        local list=Players:GetPlayers()
        table.sort(list,function(a,b)
            return (a.DisplayName or a.Name)<(b.DisplayName or b.Name)
        end)

        for i,player in ipairs(list) do
            if player ~= LocalPlayer then
                local card=Instance.new("Frame")
                card.Size=UDim2.new(1,-5,0,36)
                card.BackgroundColor3=(selected==player) and (options.AccentColor or theme.Accent) or theme.SurfaceAlt
                card.BorderSizePixel=0
                card.LayoutOrder=i
                card.Parent=scroll
                corner(card,6)
                stroke(card,theme.Border,1,.5)

                local avatar=Instance.new("ImageLabel")
                avatar.Size=UDim2.fromOffset(26,26)
                avatar.Position=UDim2.new(0,5,.5,-13)
                avatar.BackgroundColor3=theme.Background
                avatar.BorderSizePixel=0
                avatar.Image="rbxthumb://type=AvatarHeadShot&id="..player.UserId.."&w=150&h=150"
                avatar.Parent=card
                corner(avatar,99)

                textLabel(card,{
                    Text=player.DisplayName,
                    TextColor3=theme.Text,
                    Font=Fonts.Bold,
                    TextSize=11,
                    Size=UDim2.new(1,-42,0,14),
                    Position=UDim2.new(0,36,0,3),
                })
                textLabel(card,{
                    Text="@"..player.Name,
                    TextColor3=theme.TextMuted,
                    Font=Fonts.Regular,
                    TextSize=9,
                    Size=UDim2.new(1,-42,0,12),
                    Position=UDim2.new(0,36,0,18),
                })

                local click=Instance.new("TextButton")
                click.Size=UDim2.fromScale(1,1)
                click.BackgroundTransparency=1
                click.Text=""
                click.Parent=card

                table.insert(cardConnections,click.Activated:Connect(function()
                    selected=player
                    rebuild()
                    if options.OnSelect then task.spawn(function() pcall(options.OnSelect,player) end) end
                end))
            end
        end
    end

    rebuild()

    local api={
        Instance=wrapper,
        Refresh=rebuild,
        Get=function() return selected end,
        Clear=function()
            selected=nil
            rebuild()
        end,
    }

    -- Auto refresh when players join/leave.
    table.insert(self.Window._connections,Players.PlayerAdded:Connect(rebuild))
    table.insert(self.Window._connections,Players.PlayerRemoving:Connect(function(p)
        if selected==p then selected=nil end
        rebuild()
    end))

    return api
end

--// Convenience aliases
WindowMethods.Tab = WindowMethods.CreateTab
TabMethods.AddToggle = TabMethods.Toggle
TabMethods.AddButton = TabMethods.Button
TabMethods.AddLabel = TabMethods.Label
TabMethods.AddSection = TabMethods.Section
TabMethods.AddDivider = TabMethods.Divider
TabMethods.AddSlider = TabMethods.Slider
TabMethods.AddDropdown = TabMethods.Dropdown
TabMethods.AddTextbox = TabMethods.Textbox
TabMethods.AddKeybind = TabMethods.Keybind
TabMethods.AddPlayerList = TabMethods.PlayerList

--// Public helper: standalone component table for advanced users
Library.Components = {
    -- Components are intentionally created through a Tab so they share
    -- the window lifecycle, theme and connection cleanup.
    CreateToggle = function(tab, opts) return tab:Toggle(opts) end,
    CreateButton = function(tab, opts) return tab:Button(opts) end,
    CreateLabel = function(tab, opts) return tab:Label(opts) end,
    CreateSection = function(tab, opts) return tab:Section(opts) end,
    CreateDivider = function(tab, opts) return tab:Divider(opts) end,
    CreateSlider = function(tab, opts) return tab:Slider(opts) end,
    CreateDropdown = function(tab, opts) return tab:Dropdown(opts) end,
    CreateTextbox = function(tab, opts) return tab:Textbox(opts) end,
    CreateKeybind = function(tab, opts) return tab:Keybind(opts) end,
    CreatePlayerList = function(tab, opts) return tab:PlayerList(opts) end,
}

return Library
