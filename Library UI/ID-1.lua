local RUNLUA = {}
RUNLUA.__index = RUNLUA

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")

local LocalPlayer = Players.LocalPlayer

local THEME = {
	Background = Color3.fromRGB(15, 16, 22),
	Topbar = Color3.fromRGB(20, 22, 30),
	Sidebar = Color3.fromRGB(18, 19, 26),
	Element = Color3.fromRGB(22, 24, 34),
	Element2 = Color3.fromRGB(28, 30, 44),
	Accent = Color3.fromRGB(0, 225, 255),
	AccentDark = Color3.fromRGB(0, 120, 215),
	Text = Color3.fromRGB(235, 238, 245),
	SubText = Color3.fromRGB(160, 165, 180),
	Stroke = Color3.fromRGB(35, 38, 55),
	Off = Color3.fromRGB(45, 48, 65),
	Danger = Color3.fromRGB(220, 50, 50)
}

local function Corner(parent, radius)
	local object = Instance.new("UICorner")
	object.CornerRadius = UDim.new(0, radius or 6)
	object.Parent = parent
	return object
end

local function Stroke(parent, color, thickness)
	local object = Instance.new("UIStroke")
	object.Color = color or THEME.Stroke
	object.Thickness = thickness or 1
	object.Parent = parent
	return object
end

local function Tween(object, properties, time)
	local tween = TweenService:Create(
		object,
		TweenInfo.new(time or 0.18, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
		properties
	)
	tween:Play()
	return tween
end

local function MakeDraggable(handle, object)
	local dragging = false
	local dragInput
	local dragStart
	local startPosition

	handle.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1
			or input.UserInputType == Enum.UserInputType.Touch then

			dragging = true
			dragStart = input.Position
			startPosition = object.Position
		end
	end)

	handle.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement
			or input.UserInputType == Enum.UserInputType.Touch then
			dragInput = input
		end
	end)

	UserInputService.InputChanged:Connect(function(input)
		if input == dragInput and dragging then
			local delta = input.Position - dragStart

			object.Position = UDim2.new(
				startPosition.X.Scale,
				startPosition.X.Offset + delta.X,
				startPosition.Y.Scale,
				startPosition.Y.Offset + delta.Y
			)
		end
	end)

	UserInputService.InputEnded:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1
			or input.UserInputType == Enum.UserInputType.Touch then
			dragging = false
		end
	end)
end

function RUNLUA:Loading(settings)
	settings = settings or {}

	local title = settings.Title or "RUNLUA HUB"
	local text = settings.Text or "กำลังโหลดระบบ..."
	local duration = settings.Duration or 1.2

	local old = CoreGui:FindFirstChild("RUNLUA_Loading")
	if old then
		old:Destroy()
	end

	local gui = Instance.new("ScreenGui")
	gui.Name = "RUNLUA_Loading"
	gui.ResetOnSpawn = false
	gui.IgnoreGuiInset = true
	gui.Parent = CoreGui

	local frame = Instance.new("Frame")
	frame.Size = UDim2.new(0, 330, 0, 150)
	frame.Position = UDim2.new(0.5, -165, 0.5, -75)
	frame.BackgroundColor3 = THEME.Background
	frame.BorderSizePixel = 0
	frame.Parent = gui
	Corner(frame, 10)
	Stroke(frame, THEME.Accent, 1.4)

	local titleLabel = Instance.new("TextLabel")
	titleLabel.Size = UDim2.new(1, -20, 0, 42)
	titleLabel.Position = UDim2.new(0, 10, 0, 10)
	titleLabel.BackgroundTransparency = 1
	titleLabel.Text = "⚡ " .. title .. " ⚡"
	titleLabel.TextColor3 = THEME.Text
	titleLabel.TextSize = 19
	titleLabel.Font = Enum.Font.GothamBold
	titleLabel.Parent = frame

	local status = Instance.new("TextLabel")
	status.Size = UDim2.new(1, -20, 0, 25)
	status.Position = UDim2.new(0, 10, 0, 52)
	status.BackgroundTransparency = 1
	status.Text = text
	status.TextColor3 = THEME.Accent
	status.TextSize = 12
	status.Font = Enum.Font.Gotham
	status.Parent = frame

	local barBackground = Instance.new("Frame")
	barBackground.Size = UDim2.new(1, -50, 0, 7)
	barBackground.Position = UDim2.new(0, 25, 1, -37)
	barBackground.BackgroundColor3 = THEME.Off
	barBackground.BorderSizePixel = 0
	barBackground.Parent = frame
	Corner(barBackground, 100)

	local fill = Instance.new("Frame")
	fill.Size = UDim2.new(0, 0, 1, 0)
	fill.BackgroundColor3 = THEME.Accent
	fill.BorderSizePixel = 0
	fill.Parent = barBackground
	Corner(fill, 100)

	TweenService:Create(
		fill,
		TweenInfo.new(duration, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
		{Size = UDim2.new(1, 0, 1, 0)}
	):Play()

	task.wait(duration + 0.1)

	Tween(frame, {
		BackgroundTransparency = 1
	}, 0.2)

	task.wait(0.2)
	gui:Destroy()
end

function RUNLUA:CreateWindow(settings)
	settings = settings or {}

	local title = settings.Title or "RUNLUA HUB"
	local subtitle = settings.Subtitle or "Ultimate Library"
	local width = settings.Width or 520
	local height = settings.Height or 320

	local old = CoreGui:FindFirstChild("RUNLUA_HUB_UI")
	if old then
		old:Destroy()
	end

	local ScreenGui = Instance.new("ScreenGui")
	ScreenGui.Name = "RUNLUA_HUB_UI"
	ScreenGui.ResetOnSpawn = false
	ScreenGui.IgnoreGuiInset = true
	ScreenGui.Parent = CoreGui

	local MainFrame = Instance.new("Frame")
	MainFrame.Name = "MainFrame"
	MainFrame.Size = UDim2.new(0, width, 0, height)
	MainFrame.Position = UDim2.new(0.5, -(width / 2), 0.5, -(height / 2))
	MainFrame.BackgroundColor3 = THEME.Background
	MainFrame.BorderSizePixel = 0
	MainFrame.ClipsDescendants = true
	MainFrame.Parent = ScreenGui
	Corner(MainFrame, 9)
	Stroke(MainFrame, THEME.Stroke, 1)

	local TopBar = Instance.new("Frame")
	TopBar.Size = UDim2.new(1, 0, 0, 40)
	TopBar.BackgroundColor3 = THEME.Topbar
	TopBar.BorderSizePixel = 0
	TopBar.Parent = MainFrame

	local Title = Instance.new("TextLabel")
	Title.Size = UDim2.new(1, -90, 1, 0)
	Title.Position = UDim2.new(0, 12, 0, 0)
	Title.BackgroundTransparency = 1
	Title.Text = "⚡ " .. title .. " | " .. subtitle
	Title.TextColor3 = THEME.Text
	Title.TextSize = 14
	Title.Font = Enum.Font.GothamBold
	Title.TextXAlignment = Enum.TextXAlignment.Left
	Title.Parent = TopBar

	local Close = Instance.new("TextButton")
	Close.Size = UDim2.new(0, 29, 0, 25)
	Close.Position = UDim2.new(1, -36, 0.5, -12)
	Close.BackgroundColor3 = THEME.Danger
	Close.Text = "✕"
	Close.TextColor3 = Color3.new(1, 1, 1)
	Close.TextSize = 12
	Close.Font = Enum.Font.GothamBold
	Close.AutoButtonColor = false
	Close.Parent = TopBar
	Corner(Close, 5)

	Close.MouseButton1Click:Connect(function()
		MainFrame.Visible = false
	end)

	MakeDraggable(TopBar, MainFrame)

	local ToggleButton = Instance.new("TextButton")
	ToggleButton.Name = "RUNLUA_Toggle"
	ToggleButton.Size = UDim2.new(0, 44, 0, 44)
	ToggleButton.Position = UDim2.new(0, 15, 0.5, -22)
	ToggleButton.BackgroundColor3 = THEME.Topbar
	ToggleButton.Text = "R"
	ToggleButton.TextColor3 = THEME.Accent
	ToggleButton.TextSize = 18
	ToggleButton.Font = Enum.Font.GothamBold
	ToggleButton.AutoButtonColor = false
	ToggleButton.Parent = ScreenGui
	Corner(ToggleButton, 100)
	Stroke(ToggleButton, THEME.Accent, 1.5)

	MakeDraggable(ToggleButton, ToggleButton)

	local clickStart

	ToggleButton.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1
			or input.UserInputType == Enum.UserInputType.Touch then
			clickStart = input.Position
		end
	end)

	ToggleButton.InputEnded:Connect(function(input)
		if (
			input.UserInputType == Enum.UserInputType.MouseButton1
			or input.UserInputType == Enum.UserInputType.Touch
		) and clickStart then

			local distance = (input.Position - clickStart).Magnitude

			if distance < 8 then
				MainFrame.Visible = not MainFrame.Visible
			end
		end
	end)

	local Sidebar = Instance.new("Frame")
	Sidebar.Size = UDim2.new(0, 130, 1, -40)
	Sidebar.Position = UDim2.new(0, 0, 0, 40)
	Sidebar.BackgroundColor3 = THEME.Sidebar
	Sidebar.BorderSizePixel = 0
	Sidebar.Parent = MainFrame

	local SidePadding = Instance.new("UIPadding")
	SidePadding.PaddingTop = UDim.new(0, 8)
	SidePadding.PaddingLeft = UDim.new(0, 6)
	SidePadding.PaddingRight = UDim.new(0, 6)
	SidePadding.Parent = Sidebar

	local SideLayout = Instance.new("UIListLayout")
	SideLayout.Padding = UDim.new(0, 5)
	SideLayout.SortOrder = Enum.SortOrder.LayoutOrder
	SideLayout.Parent = Sidebar

	local ContentArea = Instance.new("Frame")
	ContentArea.Size = UDim2.new(1, -130, 1, -40)
	ContentArea.Position = UDim2.new(0, 130, 0, 40)
	ContentArea.BackgroundTransparency = 1
	ContentArea.Parent = MainFrame

	local Window = {}
	local Tabs = {}
	local selectedTab

	function Window:Tab(name)
		local button = Instance.new("TextButton")
		button.Size = UDim2.new(1, 0, 0, 33)
		button.BackgroundColor3 = THEME.Element
		button.Text = "  " .. name
		button.TextColor3 = THEME.SubText
		button.TextSize = 11
		button.Font = Enum.Font.GothamMedium
		button.TextXAlignment = Enum.TextXAlignment.Left
		button.AutoButtonColor = false
		button.Parent = Sidebar
		Corner(button, 6)

		local page = Instance.new("ScrollingFrame")
		page.Size = UDim2.new(1, -16, 1, -16)
		page.Position = UDim2.new(0, 8, 0, 8)
		page.BackgroundTransparency = 1
		page.BorderSizePixel = 0
		page.ScrollBarThickness = 3
		page.ScrollBarImageColor3 = THEME.Accent
		page.CanvasSize = UDim2.new()
		page.Visible = false
		page.Parent = ContentArea

		local padding = Instance.new("UIPadding")
		padding.PaddingBottom = UDim.new(0, 5)
		padding.Parent = page

		local layout = Instance.new("UIListLayout")
		layout.SortOrder = Enum.SortOrder.LayoutOrder
		layout.Padding = UDim.new(0, 6)
		layout.Parent = page

		layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
			page.CanvasSize = UDim2.new(
				0,
				0,
				0,
				layout.AbsoluteContentSize.Y + 10
			)
		end)

		local Tab = {}

		local function Select()
			for _, data in ipairs(Tabs) do
				data.Page.Visible = false

				Tween(data.Button, {
					BackgroundColor3 = THEME.Element,
					TextColor3 = THEME.SubText
				}, 0.12)
			end

			page.Visible = true

			Tween(button, {
				BackgroundColor3 = THEME.AccentDark,
				TextColor3 = THEME.Text
			}, 0.12)

			selectedTab = Tab
		end

		button.MouseButton1Click:Connect(Select)

		table.insert(Tabs, {
			Button = button,
			Page = page,
			Tab = Tab
		})

		function Tab:Select()
			Select()
		end

		function Tab:Label(text)
			local Label = Instance.new("TextLabel")
			Label.Size = UDim2.new(1, 0, 0, 29)
			Label.BackgroundColor3 = THEME.Element
			Label.BackgroundTransparency = 0.25
			Label.Text = "  " .. text
			Label.TextColor3 = THEME.SubText
			Label.TextSize = 11
			Label.Font = Enum.Font.Gotham
			Label.TextWrapped = true
			Label.TextXAlignment = Enum.TextXAlignment.Left
			Label.Parent = page
			Corner(Label, 6)

			return Label
		end

		function Tab:Section(text)
			local Section = Instance.new("TextLabel")
			Section.Size = UDim2.new(1, 0, 0, 24)
			Section.BackgroundTransparency = 1
			Section.Text = text
			Section.TextColor3 = THEME.Accent
			Section.TextSize = 11
			Section.Font = Enum.Font.GothamBold
			Section.TextXAlignment = Enum.TextXAlignment.Left
			Section.Parent = page

			return Section
		end

		function Tab:Button(settings)
			settings = settings or {}

			local callback = settings.Callback or function() end

			local buttonObject = Instance.new("TextButton")
			buttonObject.Size = UDim2.new(1, 0, 0, 34)
			buttonObject.BackgroundColor3 = THEME.Element2
			buttonObject.Text = settings.Title or "Button"
			buttonObject.TextColor3 = THEME.Accent
			buttonObject.TextSize = 11
			buttonObject.Font = Enum.Font.GothamMedium
			buttonObject.AutoButtonColor = false
			buttonObject.Parent = page
			Corner(buttonObject, 6)

			buttonObject.MouseEnter:Connect(function()
				Tween(buttonObject, {
					BackgroundColor3 = Color3.fromRGB(35, 38, 54)
				}, 0.12)
			end)

			buttonObject.MouseLeave:Connect(function()
				Tween(buttonObject, {
					BackgroundColor3 = THEME.Element2
				}, 0.12)
			end)

			buttonObject.MouseButton1Click:Connect(function()
				Tween(buttonObject, {
					BackgroundColor3 = THEME.AccentDark
				}, 0.08)

				task.delay(0.1, function()
					Tween(buttonObject, {
						BackgroundColor3 = THEME.Element2
					}, 0.12)
				end)

				task.spawn(callback)
			end)

			return buttonObject
		end

		function Tab:Toggle(settings)
			settings = settings or {}

			local state = settings.Default == true
			local callback = settings.Callback or function() end

			local frame = Instance.new("Frame")
			frame.Size = UDim2.new(1, 0, 0, 38)
			frame.BackgroundColor3 = THEME.Element
			frame.BorderSizePixel = 0
			frame.Parent = page
			Corner(frame, 6)

			local label = Instance.new("TextLabel")
			label.Size = UDim2.new(1, -60, 1, 0)
			label.Position = UDim2.new(0, 10, 0, 0)
			label.BackgroundTransparency = 1
			label.Text = settings.Title or "Toggle"
			label.TextColor3 = THEME.Text
			label.TextSize = 11
			label.Font = Enum.Font.GothamMedium
			label.TextXAlignment = Enum.TextXAlignment.Left
			label.Parent = frame

			local toggle = Instance.new("TextButton")
			toggle.Size = UDim2.new(0, 38, 0, 20)
			toggle.Position = UDim2.new(1, -47, 0.5, -10)
			toggle.BackgroundColor3 = state and THEME.Accent or THEME.Off
			toggle.Text = ""
			toggle.AutoButtonColor = false
			toggle.Parent = frame
			Corner(toggle, 100)

			local circle = Instance.new("Frame")
			circle.Size = UDim2.new(0, 16, 0, 16)
			circle.Position = state
				and UDim2.new(1, -18, 0.5, -8)
				or UDim2.new(0, 2, 0.5, -8)

			circle.BackgroundColor3 = Color3.new(1, 1, 1)
			circle.Parent = toggle
			Corner(circle, 100)

			local Object = {}

			local function Set(value, invoke)
				state = value == true

				Tween(toggle, {
					BackgroundColor3 = state and THEME.Accent or THEME.Off
				}, 0.15)

				Tween(circle, {
					Position = state
						and UDim2.new(1, -18, 0.5, -8)
						or UDim2.new(0, 2, 0.5, -8)
				}, 0.15)

				if invoke ~= false then
					task.spawn(callback, state)
				end
			end

			toggle.MouseButton1Click:Connect(function()
				Set(not state, true)
			end)

			frame.InputBegan:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1
					or input.UserInputType == Enum.UserInputType.Touch then
					Set(not state, true)
				end
			end)

			function Object:Set(value)
				Set(value, true)
			end

			function Object:Get()
				return state
			end

			return Object
		end

		function Tab:Slider(settings)
			settings = settings or {}

			local minimum = settings.Min or 0
			local maximum = settings.Max or 100
			local default = math.clamp(settings.Default or minimum, minimum, maximum)
			local callback = settings.Callback or function() end
			local rounding = settings.Rounding or 0

			local value = default

			local frame = Instance.new("Frame")
			frame.Size = UDim2.new(1, 0, 0, 50)
			frame.BackgroundColor3 = THEME.Element
			frame.BorderSizePixel = 0
			frame.Parent = page
			Corner(frame, 6)

			local label = Instance.new("TextLabel")
			label.Size = UDim2.new(1, -65, 0, 22)
			label.Position = UDim2.new(0, 10, 0, 2)
			label.BackgroundTransparency = 1
			label.Text = settings.Title or "Slider"
			label.TextColor3 = THEME.Text
			label.TextSize = 11
			label.Font = Enum.Font.GothamMedium
			label.TextXAlignment = Enum.TextXAlignment.Left
			label.Parent = frame

			local valueLabel = Instance.new("TextLabel")
			valueLabel.Size = UDim2.new(0, 55, 0, 22)
			valueLabel.Position = UDim2.new(1, -60, 0, 2)
			valueLabel.BackgroundTransparency = 1
			valueLabel.Text = tostring(default)
			valueLabel.TextColor3 = THEME.Accent
			valueLabel.TextSize = 11
			valueLabel.Font = Enum.Font.GothamBold
			valueLabel.Parent = frame

			local slider = Instance.new("Frame")
			slider.Size = UDim2.new(1, -20, 0, 7)
			slider.Position = UDim2.new(0, 10, 0, 32)
			slider.BackgroundColor3 = THEME.Off
			slider.BorderSizePixel = 0
			slider.Active = true
			slider.Parent = frame
			Corner(slider, 100)

			local fill = Instance.new("Frame")
			fill.Size = UDim2.new(
				(default - minimum) / (maximum - minimum),
				0,
				1,
				0
			)
			fill.BackgroundColor3 = THEME.Accent
			fill.BorderSizePixel = 0
			fill.Parent = slider
			Corner(fill, 100)

			local knob = Instance.new("Frame")
			knob.AnchorPoint = Vector2.new(0.5, 0.5)
			knob.Size = UDim2.new(0, 13, 0, 13)
			knob.Position = UDim2.new(
				(default - minimum) / (maximum - minimum),
				0,
				0.5,
				0
			)
			knob.BackgroundColor3 = Color3.new(1, 1, 1)
			knob.BorderSizePixel = 0
			knob.Parent = slider
			Corner(knob, 100)

			local sliding = false

			local function Round(number)
				if rounding <= 0 then
					return math.floor(number + 0.5)
				end

				local power = 10 ^ rounding
				return math.floor(number * power + 0.5) / power
			end

			local function SetFromPercentage(percent, invoke)
				percent = math.clamp(percent, 0, 1)

				value = Round(
					minimum + ((maximum - minimum) * percent)
				)

				valueLabel.Text = tostring(value)

				Tween(fill, {
					Size = UDim2.new(percent, 0, 1, 0)
				}, 0.05)

				Tween(knob, {
					Position = UDim2.new(percent, 0, 0.5, 0)
				}, 0.05)

				if invoke ~= false then
					task.spawn(callback, value)
				end
			end

			local function Update(input)
				if slider.AbsoluteSize.X <= 0 then
					return
				end

				local percentage = (
					input.Position.X - slider.AbsolutePosition.X
				) / slider.AbsoluteSize.X

				SetFromPercentage(percentage, true)
			end

			slider.InputBegan:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1
					or input.UserInputType == Enum.UserInputType.Touch then

					sliding = true
					Update(input)
				end
			end)

			UserInputService.InputChanged:Connect(function(input)
				if sliding and (
					input.UserInputType == Enum.UserInputType.MouseMovement
						or input.UserInputType == Enum.UserInputType.Touch
				) then
					Update(input)
				end
			end)

			UserInputService.InputEnded:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1
					or input.UserInputType == Enum.UserInputType.Touch then
					sliding = false
				end
			end)

			local Object = {}

			function Object:Set(newValue)
				newValue = math.clamp(newValue, minimum, maximum)

				local percentage =
					(newValue - minimum) / (maximum - minimum)

				SetFromPercentage(percentage, true)
			end

			function Object:Get()
				return value
			end

			return Object
		end

		function Tab:Input(settings)
			settings = settings or {}

			local callback = settings.Callback or function() end

			local frame = Instance.new("Frame")
			frame.Size = UDim2.new(1, 0, 0, 54)
			frame.BackgroundColor3 = THEME.Element
			frame.BorderSizePixel = 0
			frame.Parent = page
			Corner(frame, 6)

			local label = Instance.new("TextLabel")
			label.Size = UDim2.new(1, -20, 0, 20)
			label.Position = UDim2.new(0, 10, 0, 2)
			label.BackgroundTransparency = 1
			label.Text = settings.Title or "Input"
			label.TextColor3 = THEME.Text
			label.TextSize = 11
			label.Font = Enum.Font.GothamMedium
			label.TextXAlignment = Enum.TextXAlignment.Left
			label.Parent = frame

			local box = Instance.new("TextBox")
			box.Size = UDim2.new(1, -20, 0, 25)
			box.Position = UDim2.new(0, 10, 0, 24)
			box.BackgroundColor3 = Color3.fromRGB(32, 35, 50)
			box.BorderSizePixel = 0
			box.Text = settings.Default or ""
			box.PlaceholderText = settings.Placeholder or "พิมพ์ข้อความ..."
			box.PlaceholderColor3 = Color3.fromRGB(110, 115, 130)
			box.TextColor3 = THEME.Accent
			box.TextSize = 11
			box.Font = Enum.Font.Gotham
			box.ClearTextOnFocus = false
			box.Parent = frame
			Corner(box, 5)

			box.FocusLost:Connect(function(enterPressed)
				task.spawn(callback, box.Text, enterPressed)
			end)

			local Object = {}

			function Object:Set(text)
				box.Text = tostring(text)
			end

			function Object:Get()
				return box.Text
			end

			return Object
		end

		function Tab:Paragraph(settings)
			settings = settings or {}

			local frame = Instance.new("Frame")
			frame.Size = UDim2.new(1, 0, 0, settings.Height or 66)
			frame.BackgroundColor3 = THEME.Element
			frame.BorderSizePixel = 0
			frame.Parent = page
			Corner(frame, 6)

			local titleLabel = Instance.new("TextLabel")
			titleLabel.Size = UDim2.new(1, -20, 0, 22)
			titleLabel.Position = UDim2.new(0, 10, 0, 5)
			titleLabel.BackgroundTransparency = 1
			titleLabel.Text = settings.Title or "RUNLUA HUB"
			titleLabel.TextColor3 = THEME.Accent
			titleLabel.TextSize = 11
			titleLabel.Font = Enum.Font.GothamBold
			titleLabel.TextXAlignment = Enum.TextXAlignment.Left
			titleLabel.Parent = frame

			local content = Instance.new("TextLabel")
			content.Size = UDim2.new(1, -20, 1, -30)
			content.Position = UDim2.new(0, 10, 0, 27)
			content.BackgroundTransparency = 1
			content.Text = settings.Content or ""
			content.TextColor3 = THEME.SubText
			content.TextSize = 10
			content.Font = Enum.Font.Gotham
			content.TextWrapped = true
			content.TextXAlignment = Enum.TextXAlignment.Left
			content.TextYAlignment = Enum.TextYAlignment.Top
			content.Parent = frame

			return frame
		end

		if #Tabs == 1 then
			Select()
		end

		return Tab
	end

	function Window:ToggleUI()
		MainFrame.Visible = not MainFrame.Visible
	end

	function Window:SetVisible(value)
		MainFrame.Visible = value == true
	end

	function Window:Destroy()
		ScreenGui:Destroy()
	end

	function Window:SetTitle(newTitle)
		Title.Text = "⚡ " .. tostring(newTitle)
	end

	return Window
end

getgenv().RUNLUA_LIBRARY = RUNLUA

return RUNLUA
