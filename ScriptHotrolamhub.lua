-----------------------------------------------------------
-- SERVICES KHAI BÁO 1 LẦN DƯỚI CHỈ VIỆC GỌI SÀI
-----------------------------------------------------------
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")
local RunService = game:GetService("RunService")

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
    local speed = 300 -- Tốc độ bay (studs/s) - có thể tăng giảm tùy ý
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
    error("[Fat Cat Hub] Không thể tải Fluent UI! Hãy kiểm tra lại kết nối mạng hoặc Executor")
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
                if hrp then
                    frozenPosition = hrp.Position
                end

                freezeConnection = RunService.RenderStepped:Connect(function()
                    if isFrozen and hrp and frozenPosition then
                        local currentRot = hrp.CFrame - hrp.Position
                        hrp.CFrame = CFrame.new(frozenPosition) * currentRot
                        hrp.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
                    end
                end)

                Fluent:Notify({
                    Title = "Đã Đóng Băng Vị Trí",
                    Content = "Nhân vật đứng yên, góc quay xoay tự do!",
                    Duration = 2
                })
            else
                if freezeConnection then
                    freezeConnection:Disconnect()
                    freezeConnection = nil
                end
                frozenPosition = nil

                Fluent:Notify({
                    Title = "Đã Mở Khóa",
                    Content = "Nhân vật di chuyển bình thường!",
                    Duration = 2
                })
            end
        end
    })

    PlayerTab:AddButton({
        Title = "Lấy Tọa Độ Nhân Vật Và Góc Quay",
        Description = "Tạo một bảng lưu CFrame chuẩn xác không làm tròn",
        Callback = function()
            local char = plr.Character
            local hrp = char and char:FindFirstChild("HumanoidRootPart")
            if not hrp then
                Fluent:Notify({
                    Title = "Lỗi",
                    Content = "Không tìm thấy HumanoidRootPart của nhân vật!",
                    Duration = 3
                })
                return
            end

            posCount = posCount + 1
            local cf = hrp.CFrame
            local x, y, z, r00, r01, r02, r10, r11, r12, r20, r21, r22 = cf:GetComponents()
            
            local fullCFrameStr = string.format(
                "CFrame.new(%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)",
                tostring(x), tostring(y), tostring(z),
                tostring(r00), tostring(r01), tostring(r02),
                tostring(r10), tostring(r11), tostring(r12),
                tostring(r20), tostring(r21), tostring(r22)
            )

            local paragraphBox = PlayerTab:AddParagraph({
                Title = "Tọa Độ : " .. posCount,
                Content = fullCFrameStr
            })
            table.insert(createdElements, paragraphBox)

            local copyButton = PlayerTab:AddButton({
                Title = "Sao chép",
                Callback = function()
                    if setclipboard then
                        setclipboard(fullCFrameStr)
                        Fluent:Notify({
                            Title = "Thành công",
                            Content = "Đã sao chép Tọa Độ : " .. posCount,
                            Duration = 3
                        })
                    else
                        Fluent:Notify({
                            Title = "Lỗi",
                            Content = "Executor không hỗ trợ setclipboard!",
                            Duration = 3
                        })
                    end
                end
            })
            table.insert(createdElements, copyButton)

            Fluent:Notify({
                Title = "Thành công",
                Content = "Đã tạo bảng Tọa Độ : " .. posCount,
                Duration = 2
            })
        end
    })

    PlayerTab:AddButton({
        Title = "Xóa Tọa Độ",
        Description = "Xóa toàn bộ các bảng tọa độ đã tạo bên dưới",
        Callback = function()
            for _, element in ipairs(createdElements) do
                pcall(function() element:Destroy() end)
            end
            createdElements = {}
            posCount = 0

            Fluent:Notify({
                Title = "Thông báo",
                Content = "Đã xóa toàn bộ danh sách tọa độ!",
                Duration = 2
            })
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
        Default = "",
        Placeholder = "Nhập tên quái cần tìm (VD: Bandit)...",
        Numeric = false,
        Finished = false,
        Callback = function(value)
            targetMobName = value
        end
    })

    MobTab:AddButton({
        Title = "Lấy Tọa Độ Quái",
        Description = "Tìm tất cả quái khớp tên, lấy tọa độ từng con và tính tọa độ tâm (MonCF)",
        Callback = function()
            if targetMobName == "" then
                Fluent:Notify({
                    Title = "Lỗi",
                    Content = "Vui lòng nhập tên quái trước!",
                    Duration = 3
                })
                return
            end

            local foundMobs = {}

            local function scanFolder(parent)
                for _, obj in ipairs(parent:GetChildren()) do
                    if obj:IsA("Model") and string.find(string.lower(obj.Name), string.lower(targetMobName)) then
                        local hrp = obj:FindFirstChild("HumanoidRootPart") or obj:FindFirstChild("Head") or obj.PrimaryPart
                        local hum = obj:FindFirstChildOfClass("Humanoid")
                        if hrp and hum and hum.Health > 0 then
                            table.insert(foundMobs, {
                                Name = obj.Name,
                                Part = hrp
                            })
                        end
                    end
                end
            end

            local enemiesFolder = workspace:FindFirstChild("Enemies")
            if enemiesFolder then
                scanFolder(enemiesFolder)
            end
            scanFolder(workspace)

            if #foundMobs == 0 then
                Fluent:Notify({
                    Title = "Không Tìm Thấy",
                    Content = "Không tìm thấy con quái nào khớp với tên: " .. targetMobName,
                    Duration = 3
                })
                return
            end

            for _, mob in ipairs(foundMobs) do
                mobPosCount = mobPosCount + 1
                local pos = mob.Part.Position
                local posStr = string.format("CFrame.new(%s, %s, %s)", tostring(pos.X), tostring(pos.Y), tostring(pos.Z))

                local paragraphBox = MobTab:AddParagraph({
                    Title = mob.Name .. " [" .. mobPosCount .. "]",
                    Content = posStr
                })
                table.insert(mobCreatedElements, paragraphBox)

                local copyButton = MobTab:AddButton({
                    Title = "Sao chép",
                    Callback = function()
                        if setclipboard then
                            setclipboard(posStr)
                            Fluent:Notify({
                                Title = "Thành công",
                                Content = "Đã sao chép tọa độ: " .. posStr,
                                Duration = 3
                            })
                        else
                            Fluent:Notify({
                                Title = "Lỗi",
                                Content = "Executor không hỗ trợ setclipboard!",
                                Duration = 3
                            })
                        end
                    end
                })
                table.insert(mobCreatedElements, copyButton)

                -- THÊM NÚT BAY ĐẾN ĐÂY NẰM DƯỚI NÚT SAO CHÉP
                local flyButton = MobTab:AddButton({
                    Title = "Bay đến đây",
                    Callback = function()
                        Fluent:Notify({
                            Title = "Đang di chuyển",
                            Content = "Đang bay đến " .. mob.Name,
                            Duration = 2
                        })
                        TweenTo(CFrame.new(pos))
                    end
                })
                table.insert(mobCreatedElements, flyButton)
            end

            local sumPos = Vector3.new(0, 0, 0)
            for _, mob in ipairs(foundMobs) do
                sumPos = sumPos + mob.Part.Position
            end
            local centerPos = sumPos / #foundMobs
            local monCfStr = string.format("MonCF = CFrame.new(%s, %s, %s)", tostring(centerPos.X), tostring(centerPos.Y), tostring(centerPos.Z))

            local centerParagraph = MobTab:AddParagraph({
                Title = "Tọa Độ Trung Tâm Bãi (MonCF)",
                Content = monCfStr
            })
            table.insert(mobCreatedElements, centerParagraph)

            local copyCenterBtn = MobTab:AddButton({
                Title = "Sao chép",
                Callback = function()
                    if setclipboard then
                        setclipboard(monCfStr)
                        Fluent:Notify({
                            Title = "Thành công",
                            Content = "Đã sao chép MonCF của bãi!",
                            Duration = 3
                        })
                    else
                        Fluent:Notify({
                            Title = "Lỗi",
                            Content = "Executor không hỗ trợ setclipboard!",
                            Duration = 3
                        })
                    end
                end
            })
            table.insert(mobCreatedElements, copyCenterBtn)

            -- NÚT BAY ĐẾN TÂM BÃI CHO MONCF
            local flyCenterBtn = MobTab:AddButton({
                Title = "Bay đến tâm bãi",
                Callback = function()
                    Fluent:Notify({
                        Title = "Đang di chuyển",
                        Content = "Đang bay đến tâm bãi quái",
                        Duration = 2
                    })
                    TweenTo(CFrame.new(centerPos))
                end
            })
            table.insert(mobCreatedElements, flyCenterBtn)

            Fluent:Notify({
                Title = "Thành công",
                Content = "Đã tìm thấy " .. #foundMobs .. " con quái và tính tọa độ tâm!",
                Duration = 3
            })
        end
    })

    MobTab:AddButton({
        Title = "Xóa Tọa Độ Quái",
        Description = "Xóa toàn bộ các bảng tọa độ quái đã tạo bên dưới",
        Callback = function()
            for _, element in ipairs(mobCreatedElements) do
                pcall(function() element:Destroy() end)
            end
            mobCreatedElements = {}
            mobPosCount = 0

            Fluent:Notify({
                Title = "Thông báo",
                Content = "Đã xóa toàn bộ danh sách tọa độ quái!",
                Duration = 2
            })
        end
    })

    -------------------------------------------------------
    -- TAB 3: LẤY TỌA ĐỘ NPC & VẬT THỂ
    -------------------------------------------------------
    local NpcTab = Tabs["NPCPos"]

    local npcCreatedElements = {}
    local npcPosCount = 0
    local targetNpcName = ""

    NpcTab:AddInput("NpcNameInput", {
        Title = "Nhập Tên NPC / Vật Thể",
        Default = "",
        Placeholder = "Nhập tên cần tìm (VD: Set Home Point)...",
        Numeric = false,
        Finished = false,
        Callback = function(value)
            targetNpcName = value
        end
    })

    NpcTab:AddButton({
        Title = "Lấy Tọa Độ NPC",
        Description = "Tìm tất cả NPC/Vật thể khớp tên trên toàn bản đồ (Hỗ trợ cả Model và Part)",
        Callback = function()
            if targetNpcName == "" then
                Fluent:Notify({
                    Title = "Lỗi",
                    Content = "Vui lòng nhập tên cần tìm trước!",
                    Duration = 3
                })
                return
            end

            local foundNpcs = {}
            local checkedPositions = {}

            for _, obj in ipairs(workspace:GetDescendants()) do
                if string.find(string.lower(obj.Name), string.lower(targetNpcName)) then
                    local pos = nil

                    if obj:IsA("Model") then
                        local successPivot, pivotPos = pcall(function()
                            return obj:GetPivot().Position
                        end)
                        if successPivot and pivotPos then
                            pos = pivotPos
                        else
                            local part = obj:FindFirstChildWhichIsA("BasePart")
                            if part then pos = part.Position end
                        end
                    elseif obj:IsA("BasePart") then
                        pos = obj.Position
                    end

                    if pos then
                        local posKey = math.floor(pos.X / 5) .. "," .. math.floor(pos.Y / 5) .. "," .. math.floor(pos.Z / 5)
                        if not checkedPositions[posKey] then
                            checkedPositions[posKey] = true
                            table.insert(foundNpcs, {
                                Name = obj.Name,
                                Position = pos
                            })
                        end
                    end
                end
            end

            if #foundNpcs == 0 then
                Fluent:Notify({
                    Title = "Không Tìm Thấy",
                    Content = "Không tìm thấy đối tượng nào khớp với tên: " .. targetNpcName,
                    Duration = 3
                })
                return
            end

            for _, npc in ipairs(foundNpcs) do
                npcPosCount = npcPosCount + 1
                local pos = npc.Position
                local posStr = string.format("CFrame.new(%s, %s, %s)", tostring(pos.X), tostring(pos.Y), tostring(pos.Z))

                local paragraphBox = NpcTab:AddParagraph({
                    Title = npc.Name .. " [" .. npcPosCount .. "]",
                    Content = posStr
                })
                table.insert(npcCreatedElements, paragraphBox)

                local copyButton = NpcTab:AddButton({
                    Title = "Sao chép",
                    Callback = function()
                        if setclipboard then
                            setclipboard(posStr)
                            Fluent:Notify({
                                Title = "Thành công",
                                Content = "Đã sao chép tọa độ: " .. posStr,
                                Duration = 3
                            })
                        else
                            Fluent:Notify({
                                Title = "Lỗi",
                                Content = "Executor không hỗ trợ setclipboard!",
                                Duration = 3
                            })
                        end
                    end
                })
                table.insert(npcCreatedElements, copyButton)

                -- THÊM NÚT BAY ĐẾN ĐÂY NẰM DƯỚI NÚT SAO CHÉP Ở TAB NPC
                local flyButton = NpcTab:AddButton({
                    Title = "Bay đến đây",
                    Callback = function()
                        Fluent:Notify({
                            Title = "Đang di chuyển",
                            Content = "Đang bay đến " .. npc.Name,
                            Duration = 2
                        })
                        TweenTo(CFrame.new(pos))
                    end
                })
                table.insert(npcCreatedElements, flyButton)
            end

            Fluent:Notify({
                Title = "Thành công",
                Content = "Đã quét và tìm thấy " .. #foundNpcs .. " kết quả trên toàn bản đồ!",
                Duration = 3
            })
        end
    })

    NpcTab:AddButton({
        Title = "Xóa Tọa Độ NPC",
        Description = "Xóa toàn bộ các bảng tọa độ đã tạo bên dưới",
        Callback = function()
            for _, element in ipairs(npcCreatedElements) do
                pcall(function() element:Destroy() end)
            end
            npcCreatedElements = {}
            npcPosCount = 0

            Fluent:Notify({
                Title = "Thông báo",
                Content = "Đã xóa toàn bộ danh sách tọa độ!",
                Duration = 2
            })
        end
    })

-------------------------------------------------------
    -- TAB 4: BẮT SỰ KIỆN NPC (CHỐNG TREO GIAO DIỆN 100%)
    -------------------------------------------------------
    local EventTab = Tabs["EventListener"]

    local isListening = false
    local eventCreatedElements = {}
    local eventCount = 0

    -- Hàm đọc tham số an toàn, không ngắt luồng game
    local function safeSerialize(val)
        local t = typeof(val)
        if t == "string" then return string.format("%q", val)
        elseif t == "number" or t == "boolean" then return tostring(val)
        elseif t == "Instance" then return "game." .. val:GetFullName()
        elseif t == "CFrame" then 
            local p = val.Position
            return string.format("CFrame.new(%.2f, %.2f, %.2f)", p.X, p.Y, p.Z)
        elseif t == "Vector3" then 
            return string.format("Vector3.new(%.2f, %.2f, %.2f)", val.X, val.Y, val.Z)
        elseif t == "table" then
            local str = "{"
            for k, v in pairs(val) do
                str = str .. tostring(k) .. "=" .. safeSerialize(v) .. ", "
            end
            return str .. "}"
        else
            return "nil"
        end
    end

    local oldNamecall
    local hookSuccess = false

    if hookmetamethod and getnamecallmethod then
        local success, _ = pcall(function()
            oldNamecall = hookmetamethod(game, "__namecall", newcclosure(function(self, ...)
                local method = getnamecallmethod()
                local lowerMethod = string.lower(tostring(method))

                -- Bóc tách dữ liệu hoàn toàn trong luồng riêng biệt (task.spawn)
                if isListening and not checkcaller() and (lowerMethod == "invokeserver" or lowerMethod == "fireserver") then
                    local args = {...}
                    local selfObj = self
                    
                    task.spawn(function()
                        pcall(function()
                            local formattedArgs = {}
                            for _, v in ipairs(args) do
                                table.insert(formattedArgs, safeSerialize(v))
                            end
                            local argsStr = table.concat(formattedArgs, ", ")
                            local remotePath = "game." .. selfObj:GetFullName()
                            local correctMethod = (lowerMethod == "invokeserver" and "InvokeServer") or "FireServer"
                            local fullCode = string.format("%s:%s(%s)", remotePath, correctMethod, argsStr)

                            print("[FatCat Spy]: " .. fullCode)

                            if eventCount < 25 then
                                eventCount = eventCount + 1
                                local paragraphBox = EventTab:AddParagraph({
                                    Title = string.format("Sự Kiện [%d]: %s", eventCount, selfObj.Name),
                                    Content = fullCode
                                })
                                table.insert(eventCreatedElements, paragraphBox)

                                local copyBtn = EventTab:AddButton({
                                    Title = "Sao chép Code [" .. eventCount .. "]",
                                    Callback = function()
                                        if setclipboard then
                                            setclipboard(fullCode)
                                            Fluent:Notify({Title = "Thành công", Content = "Đã copy code Remote NPC!", Duration = 2})
                                        end
                                    end
                                })
                                table.insert(eventCreatedElements, copyBtn)
                            end
                        end)
                    end)
                end

                -- Trả về luồng chính cho game ngay lập tức
                return oldNamecall(self, ...)
            end))
        end)
        if success then hookSuccess = true end
    end

    -- Toggle Bật/Tắt
    EventTab:AddToggle("EventListenerToggle", {
        Title = "Bật / Tắt Bắt Sự Kiện NPC",
        Default = false,
        Callback = function(state)
            if not hookSuccess then
                Fluent:Notify({
                    Title = "Lỗi Executor",
                    Content = "Executor không hỗ trợ hookmetamethod!",
                    Duration = 4
                })
                return
            end

            isListening = state
            Fluent:Notify({
                Title = isListening and "Đã Bật Lắng Nghe" or "Đã Tắt Lắng Nghe",
                Content = isListening and "Lại nói chuyện với NPC bình thường để lấy Remote!" or "Đã dừng bắt tín hiệu.",
                Duration = 3
            })
        end
    })

    -- Nút Xóa danh sách
    EventTab:AddButton({
        Title = "Xóa Bảng Lịch Sử Sự Kiện",
        Description = "Xóa danh sách để bắt đợt NPC mới",
        Callback = function()
            for _, element in ipairs(eventCreatedElements) do
                pcall(function() element:Destroy() end)
            end
            eventCreatedElements = {}
            eventCount = 0

            Fluent:Notify({
                Title = "Thông báo",
                Content = "Đã xóa sạch lịch sử!",
                Duration = 2
            })
        end
    })
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
