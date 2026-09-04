-----------------------------------------------------------
-- SERVICES KHAI BÁO 1 LẦN DƯỚI CHỈ VIỆC GỌI SÀI
-----------------------------------------------------------
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")
local RunService = game:GetService("RunService")
local HttpService = game:GetService("HttpService")

local ParentGui = (gethui and gethui()) or CoreGui
local plr = Players.LocalPlayer

---------------------------
-- HÀM HỖ TRỢ BAY ĐẾN TỌA ĐỘ (TWEEN)
---------------------------
local activeTween = nil
local function TweenTo(targetCFrame)
    local char = plr.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    local hum = char and char:FindFirstChildOfClass("Humanoid")
    if not hrp or not hum then return end
    
    if activeTween then 
        pcall(function() activeTween:Cancel() end) 
    end
    
    hum.PlatformStand = true
    hrp.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
    
    local distance = (hrp.Position - targetCFrame.Position).Magnitude
    local speed = 300
    local duration = distance / speed
    if duration < 0.2 then duration = 0.2 end
    
    local tweenInfo = TweenInfo.new(duration, Enum.EasingStyle.Linear)
    activeTween = TweenService:Create(hrp, tweenInfo, {CFrame = targetCFrame})
    activeTween:Play()
    
    activeTween.Completed:Connect(function()
        hum.PlatformStand = false
        activeTween = nil
    end)
end

---------------------------
-- KIỂM TRA MAP
---------------------------
local MAP_SEAS = {
    [85211729168715] = 1,
    [79091703265657] = 2,
    [100117331123089] = 3
}

local currentSea = MAP_SEAS[game.PlaceId]
if not currentSea then
    plr:Kick("PlaceId không hợp lệ!")
    return
end

-------------------------
-- CLEANUP OLD GUI
-------------------------
pcall(function()
    if ParentGui:FindFirstChild("FatCatToggle") then ParentGui.FatCatToggle:Destroy() end
end)

-------------------------
-- THƯ VIỆN FLUENT UI
-------------------------
local success, Fluent = pcall(function()
    return loadstring(game:HttpGet("https://raw.githubusercontent.com/MR-MPC3/Fluent/master/main.lua"))()
end)

if not success or not Fluent then
    error("[Fat Cat Hub] Không thể tải Fluent UI!")
end

local Window = Fluent:CreateWindow({
    Title = "Fat Cat Hub - Tool Dev", 
    SubTitle = "Lấy Tọa Độ & Bắt Sự Kiện", 
    TabWidth = 180, 
    Theme = "Dark",
    Acrylic = false,
    Size = UDim2.fromOffset(560, 360), 
})

pcall(function()
    if Window.Root then
        Window.Root.Visible = false
    end
end)

-------------------------------------------------------
-- TOGGLE BUTTON (NÚT ẨN/HIỆN MENU & KÉO THẢ)
-------------------------------------------------------
local FatCatGui = Instance.new("ScreenGui")
FatCatGui.Name = "FatCatToggle"
FatCatGui.ResetOnSpawn = false
FatCatGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
FatCatGui.Parent = ParentGui

local FatCatButton = Instance.new("ImageButton")
FatCatButton.Name = "FatCatButton"
FatCatButton.BackgroundColor3 = Color3.fromRGB(15,15,15)
FatCatButton.BorderSizePixel = 0
FatCatButton.Position = UDim2.fromOffset(45,85)
FatCatButton.AnchorPoint = Vector2.new(.5,.5)
FatCatButton.Size = UDim2.fromOffset(50,50)
FatCatButton.Image = "rbxassetid://13717478897"
FatCatButton.AutoButtonColor = false
FatCatButton.Parent = FatCatGui

Instance.new("UICorner", FatCatButton).CornerRadius = UDim.new(1,0)

local Scale = Instance.new("UIScale", FatCatButton)
local ButtonTween = nil
local Dragging = false
local DragStart = nil
local StartPos = nil
local IsDragged = false
local AnimationId = 0

local function StopButtonTween()
    if ButtonTween then
        pcall(function() ButtonTween:Cancel() end)
        ButtonTween = nil
    end
end

local function AnimateButton(scale, time, style)
    StopButtonTween()
    ButtonTween = TweenService:Create(Scale, TweenInfo.new(time, style or Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Scale = scale})
    ButtonTween:Play()
end

local function BounceButton()
    AnimationId = AnimationId + 1
    local id = AnimationId
    AnimateButton(.82, .08)
    task.delay(.08, function()
        if id ~= AnimationId or Dragging then return end
        AnimateButton(1.08, .16, Enum.EasingStyle.Back)
        task.delay(.16, function()
            if id ~= AnimationId or Dragging then return end
            AnimateButton(1, .12)
        end)
    end)
end

FatCatButton.InputBegan:Connect(function(input)
    if input.UserInputType ~= Enum.UserInputType.MouseButton1 and input.UserInputType ~= Enum.UserInputType.Touch then return end
    Dragging = true
    IsDragged = false
    DragStart = input.Position
    StartPos = FatCatButton.Position
    AnimationId = AnimationId + 1
    AnimateButton(.88, .12)
end)

UserInputService.InputChanged:Connect(function(input)
    if not Dragging then return end
    if input.UserInputType ~= Enum.UserInputType.MouseMovement and input.UserInputType ~= Enum.UserInputType.Touch then return end
    local delta = input.Position - DragStart
    if delta.Magnitude > 6 then IsDragged = true end
    if IsDragged then
        FatCatButton.Position = UDim2.new(StartPos.X.Scale, StartPos.X.Offset + delta.X, StartPos.Y.Scale, StartPos.Y.Offset + delta.Y)
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if not Dragging then return end
    if input.UserInputType ~= Enum.UserInputType.MouseButton1 and input.UserInputType ~= Enum.UserInputType.Touch then return end
    Dragging = false
    AnimationId = AnimationId + 1
    AnimateButton(1.08, .18, Enum.EasingStyle.Back)
    local id = AnimationId
    task.delay(.18, function()
        if id ~= AnimationId or Dragging then return end
        AnimateButton(1, .12)
    end)
end)

local MenuVisible = false
FatCatButton.Activated:Connect(function()
    if IsDragged then
        IsDragged = false
        return
    end
    BounceButton()
    MenuVisible = not MenuVisible
    pcall(function()
        if Window and Window.Root then Window.Root.Visible = MenuVisible end
    end)
end)

---------------------
-- CÁC TABS CHÍNH
---------------------
local TabDefinitions = {
    {"PlayerPos", "Lấy Tọa Độ Nhân Vật", "user"},
    {"MobPos", "Lấy Tọa Độ Quái", "swords"},
    {"NPCPos", "Lấy Tọa Độ NPC", "map-pin"},
    {"EventListener", "Bắt Sự Kiện", "activity"}
}

local Tabs = {}
for _, tab in ipairs(TabDefinitions) do
    local ok, result = pcall(Window.AddTab, Window, {Title = tab[2], Icon = tab[3]})
    if not ok or not result then
        result = Window:AddTab({Title = tab[2]})
    end
    Tabs[tab[1]] = result
end

-------------------------------------------------------
-- BIẾN TOÀN CỤC CHO EVENT HOOK
-------------------------------------------------------
local isHookActive = false
local oldNamecall
local eventCallbackUI = nil -- Hàm dùng để đẩy dữ liệu lên Tab UI

oldNamecall = hookmetamethod(game, "__namecall", newcclosure(function(self, ...)
    local method = getnamecallmethod()
    local methodLower = string.lower(tostring(method))

    if isHookActive and (methodLower == "invokeserver" or methodLower == "fireserver") then
        if self.Name == "CommF_" or self.Name == "CommE" then
            local args = {...}
            
            -- 1. In ra Console F9 như cũ
            warn("----------------------------------------")
            warn("🎯 [BẮT ĐƯỢC NPC]: " .. self.Name .. " | Method: " .. method)
            local formattedText = "Remote: " .. self.Name .. " | Method: " .. method .. "\nArgs: "
            
            for i, arg in ipairs(args) do
                local argStr = tostring(arg)
                print(string.format("    👉 Tham số [%d] (%s) = %s", i, typeof(arg), argStr))
                formattedText = formattedText .. "\n[" .. i .. "] (" .. typeof(arg) .. ") = " .. argStr
            end
            warn("----------------------------------------")

            -- 2. Đẩy trực tiếp lên UI nếu có callback
            if eventCallbackUI then
                task.spawn(function()
                    eventCallbackUI(self.Name, formattedText, args)
                end)
            end
        end
    end

    return oldNamecall(self, ...)
end))

----------------------------
-- BUILD UI 
----------------------------
function BuildUI()
    -------------------------------------------------------
    -- TAB 1: LẤY TỌA ĐỘ NHÂN VẬT
    -------------------------------------------------------
    local PlayerTab = Tabs["PlayerPos"]
    local createdElements = {} 
    local posCount = 0
    local isFrozen = false
    local freezeConnection = nil
    local frozenPosition = nil

    PlayerTab:AddToggle("FreezeToggle", {
        Title = "Đóng Băng Vị Trí Nhân Vật",
        Default = false,
        Callback = function(state)
            isFrozen = state
            local char = plr.Character
            local hrp = char and char:FindFirstChild("HumanoidRootPart")

            if isFrozen then
                if hrp then frozenPosition = hrp.Position end
                freezeConnection = RunService.RenderStepped:Connect(function()
                    if isFrozen and hrp and frozenPosition then
                        local currentRot = hrp.CFrame - hrp.Position
                        hrp.CFrame = CFrame.new(frozenPosition) * currentRot
                        hrp.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
                    end
                end)
                Fluent:Notify({ Title = "Đã Đóng Băng", Content = "Nhân vật đứng yên!", Duration = 2 })
            else
                if freezeConnection then
                    freezeConnection:Disconnect()
                    freezeConnection = nil
                end
                frozenPosition = nil
                Fluent:Notify({ Title = "Đã Mở Khóa", Content = "Nhân vật di chuyển bình thường!", Duration = 2 })
            end
        end
    })

    PlayerTab:AddButton({
        Title = "Lấy Tọa Độ Nhân Vật Và Góc Quay",
        Description = "Tạo một bảng lưu CFrame chuẩn xác không làm tròn",
        Callback = function()
            local char = plr.Character
            local hrp = char and char:FindFirstChild("HumanoidRootPart")
            if not hrp then return end

            posCount = posCount + 1
            local cf = hrp.CFrame
            local x, y, z, r00, r01, r02, r10, r11, r12, r20, r21, r22 = cf:GetComponents()
            local fullCFrameStr = string.format("CFrame.new(%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)", tostring(x), tostring(y), tostring(z), tostring(r00), tostring(r01), tostring(r02), tostring(r10), tostring(r11), tostring(r12), tostring(r20), tostring(r21), tostring(r22))

            local paragraphBox = PlayerTab:AddParagraph({ Title = "Tọa Độ : " .. posCount, Content = fullCFrameStr })
            table.insert(createdElements, paragraphBox)

            local copyButton = PlayerTab:AddButton({
                Title = "Sao chép",
                Callback = function()
                    if setclipboard then
                        setclipboard(fullCFrameStr)
                        Fluent:Notify({ Title = "Thành công", Content = "Đã sao chép Tọa Độ : " .. posCount, Duration = 3 })
                    end
                end
            })
            table.insert(createdElements, copyButton)
        end
    })

    PlayerTab:AddButton({
        Title = "Xóa Tọa Độ",
        Description = "Xóa toàn bộ các bảng tọa độ đã tạo bên dưới",
        Callback = function()
            for _, element in ipairs(createdElements) do pcall(function() element:Destroy() end) end
            createdElements = {}
            posCount = 0
            Fluent:Notify({ Title = "Thông báo", Content = "Đã xóa danh sách!", Duration = 2 })
        end
    })

    -------------------------------------------------------
    -- TAB 2: LẤY TỌA ĐỘ QUÁI
    -------------------------------------------------------
    local MobTab = Tabs["MobPos"]
    local mobCreatedElements = {}
    local mobPosCount = 0
    local targetMobName = ""

    MobTab:AddInput("MobNameInput", {
        Title = "Nhập Tên Quái",
        Placeholder = "Nhập tên quái...",
        Callback = function(value) targetMobName = value end
    })

    MobTab:AddButton({
        Title = "Lấy Tọa Độ Quái",
        Callback = function()
            if targetMobName == "" then return end
            local foundMobs = {}

            local function scanFolder(parent)
                for _, obj in ipairs(parent:GetChildren()) do
                    if obj:IsA("Model") and string.find(string.lower(obj.Name), string.lower(targetMobName)) then
                        local hrp = obj:FindFirstChild("HumanoidRootPart") or obj.PrimaryPart
                        local hum = obj:FindFirstChildOfClass("Humanoid")
                        if hrp and hum and hum.Health > 0 then
                            table.insert(foundMobs, { Name = obj.Name, Part = hrp })
                        end
                    end
                end
            end

            if workspace:FindFirstChild("Enemies") then scanFolder(workspace.Enemies) end
            scanFolder(workspace)

            if #foundMobs == 0 then
                Fluent:Notify({ Title = "Không Tìm Thấy", Content = "Không tìm thấy quái!", Duration = 3 })
                return
            end

            for _, mob in ipairs(foundMobs) do
                mobPosCount = mobPosCount + 1
                local pos = mob.Part.Position
                local posStr = string.format("CFrame.new(%s, %s, %s)", tostring(pos.X), tostring(pos.Y), tostring(pos.Z))

                local paragraphBox = MobTab:AddParagraph({ Title = mob.Name .. " [" .. mobPosCount .. "]", Content = posStr })
                table.insert(mobCreatedElements, paragraphBox)

                local copyButton = MobTab:AddButton({
                    Title = "Sao chép",
                    Callback = function() if setclipboard then setclipboard(posStr) end end
                })
                table.insert(mobCreatedElements, copyButton)

                local flyButton = MobTab:AddButton({
                    Title = "Bay đến đây",
                    Callback = function() TweenTo(CFrame.new(pos)) end
                })
                table.insert(mobCreatedElements, flyButton)
            end

            local sumPos = Vector3.new(0, 0, 0)
            for _, mob in ipairs(foundMobs) do sumPos = sumPos + mob.Part.Position end
            local centerPos = sumPos / #foundMobs
            local monCfStr = string.format("MonCF = CFrame.new(%s, %s, %s)", tostring(centerPos.X), tostring(centerPos.Y), tostring(centerPos.Z))

            local centerParagraph = MobTab:AddParagraph({ Title = "Tọa Độ Trung Tâm Bãi (MonCF)", Content = monCfStr })
            table.insert(mobCreatedElements, centerParagraph)

            local copyCenterBtn = MobTab:AddButton({
                Title = "Sao chép MonCF",
                Callback = function() if setclipboard then setclipboard(monCfStr) end end
            })
            table.insert(mobCreatedElements, copyCenterBtn)

            local flyCenterBtn = MobTab:AddButton({
                Title = "Bay đến tâm bãi",
                Callback = function() TweenTo(CFrame.new(centerPos)) end
            })
            table.insert(mobCreatedElements, flyCenterBtn)
        end
    })

    MobTab:AddButton({
        Title = "Xóa Tọa Độ Quái",
        Callback = function()
            for _, element in ipairs(mobCreatedElements) do pcall(function() element:Destroy() end) end
            mobCreatedElements = {}
            mobPosCount = 0
        end
    })

    -------------------------------------------------------
    -- TAB 3: LẤY TỌA ĐỘ NPC
    -------------------------------------------------------
    local NpcTab = Tabs["NPCPos"]
    local npcCreatedElements = {}
    local npcPosCount = 0
    local targetNpcName = ""

    NpcTab:AddInput("NpcNameInput", {
        Title = "Nhập Tên NPC / Vật Thể",
        Placeholder = "Nhập tên...",
        Callback = function(value) targetNpcName = value end
    })

    NpcTab:AddButton({
        Title = "Lấy Tọa Độ NPC",
        Callback = function()
            if targetNpcName == "" then return end
            local foundNpcs = {}
            local checkedPositions = {}

            for _, obj in ipairs(workspace:GetDescendants()) do
                if string.find(string.lower(obj.Name), string.lower(targetNpcName)) then
                    local pos = nil
                    if obj:IsA("Model") then
                        pcall(function() pos = obj:GetPivot().Position end)
                    elseif obj:IsA("BasePart") then
                        pos = obj.Position
                    end

                    if pos then
                        local posKey = math.floor(pos.X / 5) .. "," .. math.floor(pos.Y / 5) .. "," .. math.floor(pos.Z / 5)
                        if not checkedPositions[posKey] then
                            checkedPositions[posKey] = true
                            table.insert(foundNpcs, { Name = obj.Name, Position = pos })
                        end
                    end
                end
            end

            for _, npc in ipairs(foundNpcs) do
                npcPosCount = npcPosCount + 1
                local pos = npc.Position
                local posStr = string.format("CFrame.new(%s, %s, %s)", tostring(pos.X), tostring(pos.Y), tostring(pos.Z))

                local paragraphBox = NpcTab:AddParagraph({ Title = npc.Name .. " [" .. npcPosCount .. "]", Content = posStr })
                table.insert(npcCreatedElements, paragraphBox)

                local copyButton = NpcTab:AddButton({
                    Title = "Sao chép",
                    Callback = function() if setclipboard then setclipboard(posStr) end end
                })
                table.insert(npcCreatedElements, copyButton)

                local flyButton = NpcTab:AddButton({
                    Title = "Bay đến đây",
                    Callback = function() TweenTo(CFrame.new(pos)) end
                })
                table.insert(npcCreatedElements, flyButton)
            end
        end
    })

    NpcTab:AddButton({
        Title = "Xóa Tọa Độ NPC",
        Callback = function()
            for _, element in ipairs(npcCreatedElements) do pcall(function() element:Destroy() end) end
            npcCreatedElements = {}
            npcPosCount = 0
        end
    })

    -------------------------------------------------------
    -- TAB 4: BẮT SỰ KIỆN NPC (REMOTE SPY UI + CONSOLE)
    -------------------------------------------------------
    local EventTab = Tabs["EventListener"]
    local eventCreatedElements = {}
    local eventCount = 0

    EventTab:AddToggle("HookToggle", {
        Title = "Bật Hook Namecall (CommF_ / CommE)",
        Description = "Vừa in Console vừa hiển thị bảng trực tiếp trên UI khi tương tác NPC",
        Default = false,
        Callback = function(state)
            isHookActive = state
            if isHookActive then
                Fluent:Notify({
                    Title = "Hook Namecall",
                    Content = "Đã BẬT! Tương tác NPC sẽ hiển thị kết quả ở dưới.",
                    Duration = 3
                })
            else
                Fluent:Notify({
                    Title = "Hook Namecall",
                    Content = "Đã TẮT bắt sự kiện!",
                    Duration = 3
                })
            end
        end
    })

    -- BẢNG HIỂN THỊ KẾT QUẢ SỰ KIỆN TRỰC TIẾP TRÊN GIAO DIỆN (NẰM NGAY DƯỚI TOGGLE)
    local EventLogParagraph = EventTab:AddParagraph({
        Title = "Bảng Hiển Thị Sự Kiện (Live Log)",
        Content = "Chưa có sự kiện nào được bắt. Hãy bật Toggle phía trên và tương tác với NPC!"
    })
    table.insert(eventCreatedElements, EventLogParagraph)

    EventTab:AddButton({
        Title = "Xóa Lịch Sử Sự Kiện",
        Callback = function()
            for _, element in ipairs(eventCreatedElements) do 
                if element ~= EventLogParagraph then
                    pcall(function() element:Destroy() end) 
                end
            end
            eventCreatedElements = {EventLogParagraph}
            eventCount = 0
            EventLogParagraph:SetDesc("Đã dọn sạch bảng sự kiện!")
            EventLogParagraph:SetTitle("Bảng Hiển Thị Sự Kiện (Live Log)")
            Fluent:Notify({ Title = "Thông báo", Content = "Đã dọn sạch bảng sự kiện!", Duration = 2 })
        end
    })

-- Gán hàm callback để nhận dữ liệu từ hook truyền lên UI
    eventCallbackUI = function(remoteName, contentStr, argsTable)
        eventCount = eventCount + 1
        local currentId = eventCount
        
        -- Tạo đoạn mã Lua mẫu để gọi lại Remote đó
        local luaCallCode = 'game:GetService("ReplicatedStorage"):GetService("Remotes"):FindFirstChild("'..remoteName..'"):InvokeServer('
        for i, v in ipairs(argsTable) do
            if type(v) == "string" then
                luaCallCode = luaCallCode .. '"' .. tostring(v) .. '"'
            else
                luaCallCode = luaCallCode .. tostring(v)
            end
            if i < #argsTable then
                luaCallCode = luaCallCode .. ", "
            end
        end
        luaCallCode = luaCallCode .. ")"

        -- Dùng task.defer để an toàn luồng khi tương tác với UI
        task.defer(function()
            pcall(function()
                -- Cập nhật trực tiếp nội dung lên Paragraph Live Log chính
                EventLogParagraph:SetTitle("Sự Kiện Mới Nhất #" .. currentId .. " (" .. remoteName .. ")")
                EventLogParagraph:SetDesc(contentStr)
            end)

            -- Thêm Paragraph hiển thị chi tiết trong UI
            local paragraph = EventTab:AddParagraph({
                Title = "Lịch Sử #" .. currentId .. " (" .. remoteName .. ")",
                Content = contentStr
            })
            table.insert(eventCreatedElements, paragraph)

            -- Nút sao chép dòng lệnh tái tạo sự kiện
            local copyBtn = EventTab:AddButton({
                Title = "Sao chép mã lệnh gọi lại (Args) #" .. currentId,
                Callback = function()
                    if setclipboard then
                        setclipboard(luaCallCode)
                        Fluent:Notify({ Title = "Thành công", Content = "Đã sao chép lệnh sự kiện #" .. currentId, Duration = 2 })
                    end
                end
            })
            table.insert(eventCreatedElements, copyBtn)
        end)
    end
end

BuildUI()

---------------------------------------
-- KHỞI CHẠY MENU
---------------------------------------
Fluent:Notify({
    Title = "Fat Cat Hub",
    Content = "Tải Xong - Tool Dev đã sẵn sàng!",
    Duration = 5
})
