local Xerz = {
    Icons = {
        ["Home"] = "rbxassetid://138635394134543",
        ["Crosshair"] = "rbxassetid://128826705904909",
        ["Settings"] = "rbxassetid://110104900682978",
        ["Scheck"] = "rbxassetid://125834515260940",
        ["Box"] = "rbxassetid://116389200520923",
        ["Eye"] = "rbxassetid://70829415657717",
        ["Zap"] = "rbxassetid://116065554792972",
        ["Key"] = "rbxassetid://102150703754287",
        ["Gem"] = "rbxassetid://89116087127715",
        ["Link"] = "rbxassetid://80640582703367",
        ["Info"] = "rbxassetid://115433979237671",
        ["People"] = "rbxassetid://78731454631758",
        ["Rocket"] = "rbxassetid://125983293411235",
        ["Sword"] = "rbxassetid://120479974631658",
        ["Map-Pin"] = "rbxassetid://112046003587634",
        ["Webh"] = "rbxassetid://103022949626394",
        ["Logo"] = "rbxassetid://134754437419894",
    },
    Theme = {
        Main = Color3.fromRGB(5, 5, 5),
        SideBar = Color3.fromRGB(20, 20, 20),
        Accent = Color3.fromRGB(255, 255, 255),
        Dark = Color3.fromRGB(0, 0, 0),
        Text = Color3.fromRGB(255, 255, 255),
        Stroke = Color3.fromRGB(40, 40, 40)
    },
    Services = {
        TS = game:GetService("TweenService"),
        UIS = game:GetService("UserInputService"),
        CoreGui = game:GetService("CoreGui")
    }
}

local function Create(class, props)
    local obj = Instance.new(class)
    for prop, val in pairs(props) do obj[prop] = val end
    return obj
end

function Xerz:Tween(obj, time, prop)
    local info = TweenInfo.new(time, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
    local anim = self.Services.TS:Create(obj, info, prop)
    anim:Play()
    return anim
end

function Xerz:MakeDraggable(gui)
    local dragging
    local dragInput
    local dragStart
    local startPos
    local dragTouchObject

    gui.InputBegan:Connect(function(input)
        if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then
            dragging = true
            dragTouchObject = input
            dragStart = input.Position
            startPos = gui.Position

            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                    dragTouchObject = nil
                end
            end)
        end
    end)

    gui.InputChanged:Connect(function(input)
        if (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            dragInput = input
        end
    end)

    self.Services.UIS.InputChanged:Connect(function(input)
        if input == dragTouchObject and dragging then
            local delta = input.Position - dragStart
            self.Services.TS:Create(gui, TweenInfo.new(0.1, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
            }):Play()
        end
    end)
end

function Xerz:CreateWindow(Name)
    local Screen = Create("ScreenGui", {
        Name = "XERZ_ENGINE",
        Parent = self.Services.CoreGui,
        IgnoreGuiInset = true
    })

    local ShadowHolder = Create("Frame", {
        Name = "ShadowHolder",
        Parent = Screen,
        BackgroundTransparency = 1,
        Size = UDim2.new(0, 465, 0, 290),
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.new(0.5, 0, 0.5, 0)
    })
    Create("UICorner", {CornerRadius = UDim.new(0, 8), Parent = ShadowHolder})

    local DropShadow = Create("ImageLabel", {
        Name = "DropShadow",
        Parent = ShadowHolder,
        AnchorPoint = Vector2.new(0.5, 0.5),
        BackgroundTransparency = 1,
        Position = UDim2.new(0.5, 0, 0.5, 0), 
        Size = UDim2.new(1, 55, 1, 55),
        ZIndex = 0,
        Image = "rbxassetid://100288537660010",
        ImageColor3 = self.Theme.Dark,
        ImageTransparency = 0.5,
        ScaleType = Enum.ScaleType.Slice,
        SliceCenter = Rect.new(49, 49, 450, 450)
    })
    Create("UICorner", {CornerRadius = UDim.new(0, 8), Parent = DropShadow})

    self:MakeDraggable(ShadowHolder)

    local Main = Create("Frame", {
        Name = "Main",
        Parent = ShadowHolder,
        BackgroundColor3 = self.Theme.Main,
        Size = UDim2.new(0, 465, 0, 290),
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.new(0.5, 0, 0.5, 0),
        ClipsDescendants = true,
        ZIndex = 1
    })
    Create("UICorner", {CornerRadius = UDim.new(0, 8), Parent = Main})

    local SideBar = Create("ScrollingFrame", {
        Name = "SideBar",
        Parent = Main,
        Size = UDim2.new(0, 40, 1, -47),
        Position = UDim2.new(0, 1.5, 0, 45),
        BackgroundColor3 = self.Theme.SideBar,
        BackgroundTransparency = 1,
        ClipsDescendants = true,
        ZIndex = 11,
        CanvasSize = UDim2.new(0, 0, 0, 0),
        AutomaticCanvasSize = Enum.AutomaticSize.Y,
        ScrollBarThickness = 0,
        BackgroundTransparency = 1,
        ScrollBarImageTransparency = 1
    })
    Create("UICorner", {CornerRadius = UDim.new(0, 8), Parent = SideBar})

    Create("UIListLayout", {
        Parent = SideBar,
        Padding = UDim.new(0, 8),
        HorizontalAlignment = Enum.HorizontalAlignment.Center,
        SortOrder = Enum.SortOrder.LayoutOrder
    })

    Create("UIPadding", {
        Parent = SideBar,
        PaddingTop = UDim.new(0, 8)
    })

    local SideDivider = Create("Frame", {
        Name = "SideDivider",
        Parent = Main,
        Size = UDim2.new(0, 1, 1, 0),
        Position = UDim2.new(0, 45, 0, 0),
        BackgroundColor3 = self.Theme.Stroke,
        BorderSizePixel = 0,
        BackgroundTransparency = 0,
        ZIndex = 2
    })

    local Header = Create("Frame", {
        Name = "Header",
        Parent = Main,
        Size = UDim2.new(1, 0, 0, 40),
        BackgroundColor3 = self.Theme.Main,
        ZIndex = 3
    })
    Create("UICorner", {CornerRadius = UDim.new(0, 8), Parent = Header})

    local Divider = Create("Frame", {
        Name = "Divider",
        Parent = Main,
        Size = UDim2.new(1, 0, 0, 1),
        Position = UDim2.new(0, 0, 0, 40),
        BackgroundColor3 = self.Theme.Stroke,
        BorderSizePixel = 0,
        BackgroundTransparency = 0,
        ZIndex = 4
    })

    local TitleLabel = Create("TextLabel", {
        Parent = Header,
        Size = UDim2.new(1, -60, 1, 0),
        Position = UDim2.new(0, 10, 0, 0),
        BackgroundTransparency = 1,
        Text = Name:upper(),
        TextColor3 = self.Theme.Text,
        Font = "GothamBold",
        TextSize = 14,
        TextXAlignment = "Left",
        ZIndex = 3
    })

    local PageFolder = Create("Frame", {
        Name = "PageFolder",
        Parent = Main,
        Size = UDim2.new(1, -50, 1, -60),
        Position = UDim2.new(0, 48, 0, 50),
        BackgroundTransparency = 1
    })

    local OpenBtn = Create("TextButton", {
        Name = "OpenBtn",
        Parent = Screen,
        Size = UDim2.new(0, 45, 0, 45),
        Position = UDim2.new(0, 20, 0.5, -22),
        BackgroundColor3 = self.Theme.Main,
        Text = "X",
        TextColor3 = self.Theme.Accent,
        Font = "GothamBold",
        TextSize = 20,
        Visible = false,
        ZIndex = 100
    })
    Create("UICorner", {CornerRadius = UDim.new(1, 0), Parent = OpenBtn})
    Create("UIStroke", {Color = self.Theme.Accent, Thickness = 1.5, Parent = OpenBtn})

    local CloseBtn = Create("TextButton", {
        Name = "CloseBtn",
        Parent = Main,
        Size = UDim2.new(0, 24, 0, 24),
        Position = UDim2.new(1, -32, 0, 8),
        BackgroundTransparency = 1,
        Text = "",
        ZIndex = 50
    })

    local CloseIcon = Create("ImageLabel", {
        Name = "Icon",
        Parent = CloseBtn,
        Size = UDim2.new(0, 16, 0, 16),
        Position = UDim2.new(0.5, 0, 0.5, 0),
        AnchorPoint = Vector2.new(0.5, 0.5),
        BackgroundTransparency = 1,
        Image = "rbxassetid://110131341615523",
        ImageColor3 = self.Theme.Accent,
        ScaleType = Enum.ScaleType.Fit,
        ZIndex = 51
    })

    local MiniBtn = Create("TextButton", {
        Name = "MiniBtn",
        Parent = Main,
        Size = UDim2.new(0, 24, 0, 24),
        Position = UDim2.new(1, -60, 0, 8),
        BackgroundTransparency = 1,
        Text = "",
        ZIndex = 50
    })

    local MiniIcon = Create("ImageLabel", {
        Name = "Icon",
        Parent = MiniBtn,
        Size = UDim2.new(0, 16, 0, 16),
        Position = UDim2.new(0.5, 0, 0.5, 0),
        AnchorPoint = Vector2.new(0.5, 0.5),
        BackgroundTransparency = 1,
        Image = "rbxassetid://115762243559136",
        ImageColor3 = self.Theme.Accent,
        ScaleType = Enum.ScaleType.Fit,
        ZIndex = 51
    })

    local ExpandBtn = Create("TextButton", {
        Name = "ExpandBtn",
        Parent = Main,
        Size = UDim2.new(0, 24, 0, 24),
        Position = UDim2.new(1, -90, 0, 8),
        BackgroundTransparency = 1,
        Text = "",
        ZIndex = 50
    })

    local ExpandIcon = Create("ImageLabel", {
        Name = "Icon",
        Parent = ExpandBtn,
        Size = UDim2.new(0, 15, 0, 15),
        Position = UDim2.new(0.5, 0, 0.5, 0),
        AnchorPoint = Vector2.new(0.5, 0.5),
        BackgroundTransparency = 1,
        Image = "rbxassetid://131703639269177",
        ImageColor3 = self.Theme.Accent,
        ScaleType = Enum.ScaleType.Fit,
        ZIndex = 51
    })

local IsExpanded = false

ExpandBtn.MouseButton1Click:Connect(function()
    IsExpanded = not IsExpanded
    
    local TargetMain = IsExpanded and UDim2.new(0, 600, 0, 400) or UDim2.new(0, 465, 0, 290)
    local TargetShadow = IsExpanded and UDim2.new(0, 600, 0, 400) or UDim2.new(0, 465, 0, 290)
    
    self:Tween(Main, 0.3, {Size = TargetMain})
    self:Tween(ShadowHolder, 0.3, {Size = TargetShadow})
    
    self:Tween(ExpandIcon, 0.3, {Rotation = IsExpanded and 180 or 0})
end)

    local ConfirmFrame = Create("Frame", {
        Name = "ConfirmFrame",
        Parent = Main,
        Size = UDim2.new(1, 0, 1, 0),
        Position = UDim2.new(0, 0, 1, 0),
        BackgroundColor3 = Color3.fromRGB(10, 10, 10),
        BackgroundTransparency = 0.2,
        ZIndex = 100,
        Visible = false
    })
    Create("UICorner", {CornerRadius = UDim.new(0, 8), Parent = ConfirmFrame})

    local WarnTitle = Create("TextLabel", {
        Parent = ConfirmFrame,
        Size = UDim2.new(1, 0, 0, 30),
        Position = UDim2.new(0, 0, 0.3, 0),
        BackgroundTransparency = 1,
        Text = "ARE YOU SURE?",
        TextColor3 = self.Theme.Text,
        Font = "GothamBold",
        TextSize = 16,
        ZIndex = 101
    })

    local function CreateConfirmBtn(text, pos, color, callback)
      local btn = Create("TextButton", {
        Parent = ConfirmFrame,
        Size = UDim2.new(0, 100, 0, 35),
        Position = pos,
        BackgroundColor3 = color,
        Text = text,
        TextColor3 = Color3.fromRGB(255, 255, 255),
        Font = "GothamBold",
        TextSize = 14,
        ZIndex = 101
    })
    Create("UICorner", {CornerRadius = UDim.new(0, 6), Parent = btn})
    btn.MouseButton1Click:Connect(callback)
    return btn
end

CreateConfirmBtn("CLOSE", UDim2.new(0.5, 5, 0.5, 0), Color3.fromRGB(255, 0, 0), function()
    Xerz:Tween(Main, 0.2, {Size = UDim2.new(0, 0, 0, 0), BackgroundTransparency = 1})
    task.wait(0.2)
    Screen:Destroy()
end)

CreateConfirmBtn("CANCEL", UDim2.new(0.5, -105, 0.5, 0), Color3.fromRGB(40, 40, 40), function()
    Xerz:Tween(ConfirmFrame, 0.3, {Position = UDim2.new(0, 0, 1, 0)})
    task.wait(0.3)
    ConfirmFrame.Visible = false
end)

    CloseBtn.MouseButton1Click:Connect(function()
    ConfirmFrame.Visible = true
    Xerz:Tween(ConfirmFrame, 0.4, {Position = UDim2.new(0, 0, 0, 0)})
end)

    MiniBtn.MouseButton1Click:Connect(function()
        ShadowHolder.Visible = false
        OpenBtn.Visible = true
    end)

    OpenBtn.MouseButton1Click:Connect(function()
        ShadowHolder.Visible = true
        OpenBtn.Visible = false
    end)

    local ToggleKey = Enum.KeyCode.LeftAlt

Xerz.Services.UIS.InputBegan:Connect(function(input, gpe)
    if not gpe and input.KeyCode == ToggleKey then
        ShadowHolder.Visible = not ShadowHolder.Visible
    end
end)

    local Window = {
        Main = Main,
        SideBar = SideBar,
        PageFolder = PageFolder,
        CurrentPage = nil
    }

    function Window:CreateTab(IconName)
    local IconID = Xerz.Icons[IconName or "Home"] or ""

    local TabBtn = Create("TextButton", {
        Name = IconName.."_Btn",
        Parent = self.SideBar,
        Size = UDim2.new(1, 0, 0, 35),
        BackgroundTransparency = 1,
        Text = "",
        ZIndex = 50
    })

    local TabIcon = Create("ImageLabel", {
        Name = "Icon",
        Parent = TabBtn,
        Size = UDim2.new(0, 20, 0, 20),
        Position = UDim2.new(0.5, 0, 0.5, 0),
        AnchorPoint = Vector2.new(0.5, 0.5),
        BackgroundTransparency = 1,
        Image = IconID,
        ImageColor3 = Color3.fromRGB(150, 150, 150),
        ZIndex = 51
    })

    local Page = Create("ScrollingFrame", {
        Name = IconName.."_Page",
        Parent = self.PageFolder,
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundTransparency = 1,
        Visible = false,
        ScrollBarThickness = 0,
        CanvasSize = UDim2.new(0, 0, 0, 0),
        AutomaticCanvasSize = "Y"
    })
    
    Create("UIListLayout", {
        Parent = Page,
        Padding = UDim.new(0, 7),
        HorizontalAlignment = "Center",
        SortOrder = Enum.SortOrder.LayoutOrder
    })

    Create("UIPadding", {
        Parent = Page,
        PaddingTop = UDim.new(0, 2),
        PaddingLeft = UDim.new(0, 5),
        PaddingRight = UDim.new(0, 5)
    })

    local Indicator = Create("Frame", {
        Name = "Indicator",
        Parent = TabBtn,
        Size = UDim2.new(0, 2, 0, 0),
        Position = UDim2.new(0, 2, 0.5, 0),
        AnchorPoint = Vector2.new(0, 0.5),
        BackgroundColor3 = Xerz.Theme.Accent,
        BorderSizePixel = 0,
        BackgroundTransparency = 1
    })
    Create("UICorner", {CornerRadius = UDim.new(0, 8), Parent = Indicator})

TabBtn.MouseButton1Click:Connect(function()
    if Window.CurrentPage then Window.CurrentPage.Visible = false end
    
    for _, v in pairs(self.SideBar:GetChildren()) do
        if v:IsA("TextButton") then
            if v:FindFirstChild("Icon") then
                Xerz:Tween(v.Icon, 0.2, {ImageColor3 = Color3.fromRGB(150, 150, 150)})
            end
            if v:FindFirstChild("Indicator") then
                Xerz:Tween(v.Indicator, 0.2, {Size = UDim2.new(0, 2, 0, 0), BackgroundTransparency = 1})
            end
        end
    end
    
    Window.CurrentPage = Page
    Page.Visible = true
    
    Xerz:Tween(TabIcon, 0.2, {ImageColor3 = Xerz.Theme.Accent})
    Xerz:Tween(Indicator, 0.25, {Size = UDim2.new(0, 2, 0, 18), BackgroundTransparency = 0})
end)

if Window.CurrentPage == nil then
    Window.CurrentPage = Page
    Page.Visible = true
    TabIcon.ImageColor3 = Xerz.Theme.Accent
    Indicator.Size = UDim2.new(0, 2, 0, 18)
    Indicator.BackgroundTransparency = 0
end

    local Tab = {
        Instance = Page
    }

    function Tab:AddButton(text, callback)
        return Elements:NewButton(Page, text, callback)
    end

    function Tab:AddToggle(text, default, callback)
        return Elements:NewToggle(Page, text, default, callback, icon)
    end

    return Tab
end

    return Window
end

Elements = {}

function Elements:NewButton(parent, text, callback)
    local SelectedKey = nil
    local Binding = false
    
    local ButtonFrame = Create("Frame", {
        Name = text.."_Btn",
        Parent = parent,
        Size = UDim2.new(1, -10, 0, 38),
        BackgroundColor3 = Xerz.Theme.SideBar,
        ZIndex = 60
    })
    Create("UICorner", {CornerRadius = UDim.new(0, 6), Parent = ButtonFrame})
    Create("UIStroke", {Color = Xerz.Theme.Stroke, Thickness = 1, Parent = ButtonFrame})

    local BtnText = Create("TextLabel", {
        Parent = ButtonFrame,
        Size = UDim2.new(1, -110, 1, 0),
        Position = UDim2.new(0, 12, 0, 0),
        BackgroundTransparency = 1,
        Text = text,
        TextColor3 = Xerz.Theme.Text,
        Font = "GothamMedium",
        TextSize = 13,
        TextXAlignment = "Left",
        ZIndex = 62
    })

    local ClickBtn = Create("TextButton", {
        Parent = ButtonFrame,
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundTransparency = 1,
        Text = "",
        ZIndex = 65
    })

    local IconLabel = Create("ImageLabel", {
        Parent = ButtonFrame,
        Size = UDim2.new(0, 18, 0, 18),
        Position = UDim2.new(1, -26, 0.5, 0),
        AnchorPoint = Vector2.new(0, 0.5),
        BackgroundTransparency = 1,
        Image = "rbxassetid://93705744092948",
        ImageColor3 = Xerz.Theme.Accent,
        ZIndex = 62
    })

    local KeyBox = Create("Frame", {
        Name = "KeyBox",
        Parent = ButtonFrame,
        Size = UDim2.new(0, 50, 0, 22),
        Position = UDim2.new(1, -82, 0.5, 0),
        AnchorPoint = Vector2.new(0, 0.5),
        BackgroundColor3 = Color3.fromRGB(30, 30, 30),
        ZIndex = 62
    })
    Create("UICorner", {CornerRadius = UDim.new(0, 4), Parent = KeyBox})
    
    local KeyText = Create("TextLabel", {
        Parent = KeyBox,
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundTransparency = 1,
        Text = "NONE",
        TextColor3 = Color3.fromRGB(150, 150, 150),
        Font = "GothamBold",
        TextSize = 10,
        ZIndex = 63
    })

    ClickBtn.MouseButton2Click:Connect(function()
        Binding = true
        KeyText.Text = "..."
        KeyText.TextColor3 = Xerz.Theme.Accent
    end)

    Xerz.Services.UIS.InputBegan:Connect(function(input, gpe)
        if gpe then return end -- No activar si escribes en el chat
        
        if Binding then
            if input.UserInputType == Enum.UserInputType.Keyboard then
                SelectedKey = input.KeyCode
                KeyText.Text = SelectedKey.Name:upper()
                Binding = false
                KeyText.TextColor3 = Color3.fromRGB(150, 150, 150)
            end
        elseif SelectedKey and input.KeyCode == SelectedKey then
            Xerz:Tween(ButtonFrame, 0.1, {BackgroundColor3 = Xerz.Theme.Accent})
            callback()
            task.wait(0.1)
            Xerz:Tween(ButtonFrame, 0.1, {BackgroundColor3 = Xerz.Theme.SideBar})
        end
    end)

    ClickBtn.MouseButton1Down:Connect(function()
        Xerz:Tween(ButtonFrame, 0.1, {BackgroundColor3 = Xerz.Theme.Stroke})
    end)

    ClickBtn.MouseButton1Up:Connect(function()
        Xerz:Tween(ButtonFrame, 0.1, {BackgroundColor3 = Xerz.Theme.SideBar})
        callback()
    end)

    return ButtonFrame
end

function Elements:NewToggle(parent, text, default, callback, icon)
    local Toggled = default or false
    local SelectedKey = nil
    local Binding = false
    
    local ToggleFrame = Create("Frame", {
        Name = text.."_Toggle",
        Parent = parent,
        Size = UDim2.new(1, -10, 0, 38),
        BackgroundColor3 = Xerz.Theme.SideBar,
        ZIndex = 60
    })
    Create("UICorner", {CornerRadius = UDim.new(0, 6), Parent = ToggleFrame})
    Create("UIStroke", {Color = Xerz.Theme.Stroke, Thickness = 1, Parent = ToggleFrame})

    local ToggleText = Create("TextLabel", {
        Parent = ToggleFrame,
        Size = UDim2.new(1, -110, 1, 0),
        Position = UDim2.new(0, 12, 0, 0),
        BackgroundTransparency = 1,
        Text = text,
        TextColor3 = Xerz.Theme.Text,
        Font = "GothamMedium",
        TextSize = 13,
        TextXAlignment = "Left",
        ZIndex = 62
    })

    local Switch = Create("Frame", {
        Parent = ToggleFrame,
        Size = UDim2.new(0, 32, 0, 18),
        Position = UDim2.new(1, -40, 0.5, 0),
        AnchorPoint = Vector2.new(0, 0.5),
        BackgroundColor3 = Toggled and Xerz.Theme.Accent or Color3.fromRGB(40, 40, 40),
        ZIndex = 62
    })
    Create("UICorner", {CornerRadius = UDim.new(1, 0), Parent = Switch})

    local Circle = Create("Frame", {
        Parent = Switch,
        Size = UDim2.new(0, 12, 0, 12),
        Position = Toggled and UDim2.new(1, -15, 0.5, 0) or UDim2.new(0, 3, 0.5, 0),
        AnchorPoint = Vector2.new(0, 0.5),
        BackgroundColor3 = Toggled and Xerz.Theme.Main or Color3.fromRGB(200, 200, 200),
        ZIndex = 63
    })
    Create("UICorner", {CornerRadius = UDim.new(1, 0), Parent = Circle})

    local KeyBox = Create("Frame", {
        Parent = ToggleFrame,
        Size = UDim2.new(0, 50, 0, 22),
        Position = UDim2.new(1, -95, 0.5, 0),
        AnchorPoint = Vector2.new(0, 0.5),
        BackgroundColor3 = Color3.fromRGB(30, 30, 30),
        ZIndex = 62
    })
    Create("UICorner", {CornerRadius = UDim.new(0, 4), Parent = KeyBox})
    
    local KeyText = Create("TextLabel", {
        Parent = KeyBox,
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundTransparency = 1,
        Text = "NONE",
        TextColor3 = Color3.fromRGB(150, 150, 150),
        Font = "GothamBold",
        TextSize = 9,
        ZIndex = 63
    })

    local ClickBtn = Create("TextButton", {
        Parent = ToggleFrame,
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundTransparency = 1,
        Text = "",
        ZIndex = 65
    })

    local function Fire()
        Toggled = not Toggled
        local TargetPos = Toggled and UDim2.new(1, -15, 0.5, 0) or UDim2.new(0, 3, 0.5, 0)
        local ColorBg = Toggled and Xerz.Theme.Accent or Color3.fromRGB(40, 40, 40)
        local ColorCircle = Toggled and Xerz.Theme.Main or Color3.fromRGB(200, 200, 200)
        
        Xerz:Tween(Circle, 0.2, {Position = TargetPos, BackgroundColor3 = ColorCircle})
        Xerz:Tween(Switch, 0.2, {BackgroundColor3 = ColorBg})
        
        callback(Toggled)
    end

    ClickBtn.MouseButton2Click:Connect(function()
        Binding = true
        KeyText.Text = "..."
        KeyText.TextColor3 = Xerz.Theme.Accent
    end)

    ClickBtn.MouseButton1Click:Connect(Fire)

    Xerz.Services.UIS.InputBegan:Connect(function(input, gpe)
        if gpe then return end
        if Binding then
            if input.UserInputType == Enum.UserInputType.Keyboard then
                SelectedKey = input.KeyCode
                KeyText.Text = SelectedKey.Name:upper()
                Binding = false
                KeyText.TextColor3 = Color3.fromRGB(150, 150, 150)
            end
        elseif SelectedKey and input.KeyCode == SelectedKey then
            Fire()
        end
    end)

    return ToggleFrame
end

local Lib = Xerz:CreateWindow("Xerz Lib v2")
local MainTab = Lib:CreateTab("Home")
local SettingsTab = Lib:CreateTab("Settings")

MainTab:AddButton("Test Button", function()
    print("Funciona perfectamente!")
end)

MainTab:AddToggle("Auto Farm", false, function(state)
    if state then
        print("Farm Activado")
    else
        print("Farm Desactivado")
    end
end
