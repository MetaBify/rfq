local u1 = nil
local str = nil
local u10 = nil
warn("[ASTRALGUARD] - priv.lua auth patch active")

if bypass_mode == "Automatic" then
	local t1 = {}
	local u4 = true
	local u5 = nil

	u5 = hookmetamethod(game, "__namecall", function(p1, ...)
		local t2 = { ... }
		local v174 = getnamecallmethod()

		if u4 then
			if v174 ~= "FireServer" and (v174 ~= "InvokeServer" or t2[1] == "Ping") then
				return u5(p1, ...)
			end

			t1[tostring(t2[1])] = (t1[tostring(t2[1])] or 1) + 1

			return "Pong"
		end

		return u5(p1, ...)
	end)

	for _ = 1, 100 do
		task.spawn(function()
			error("[ASTRAL-LUA]: {ANTICHEAT} | SIMULATING ANTICHEAT FLAGS | (CLIENT)")
			error("[ASTRAL-LUA]: {ANTICHEAT} | SIMULATING ANTICHEAT FLAGS | (SERVER)")
		end)
	end

	task.wait()
	u4 = false

	for k, v in pairs(t1) do
		if v > 90 then
			str = tostring(k)
			print(k, v)
		end
	end

	if not str then
		str = "Pong"
		warn("[ASTRAL-LUA]: {ANTICHEAT} | SKIPPED ASTRAL-AC RECOMPILE CHECK")
	else
		warn("[ASTRAL-LUA]: {ANTICHEAT} | SUCCESSFULY INJECTED (ASTRAL-AC) ON THE GAME ENVIRONMENT | {CLIENT}")
	end

	hookmetamethod(game, "__namecall", u5)
elseif bypass_mode == "Manual" then
	u1 = hookmetamethod(game, "__namecall", function(p2, ...)
		local v176 = getnamecallmethod()

		if (v176 == "FireServer" or v176 == "InvokeServer") and bypass_mode == "Manual" then
			for _, v in pairs({ ... }) do
				if typeof(v) == "buffer" then
					warn("zzznig")

					return 5
				end
			end
		end

		return u1(p2, ...)
	end)
end

loadstring(game:HttpGet("https://github.com/hvh-boss/Lone-Survival/raw/refs/heads/main/id.lua"))()

local timestamp = tick()

function u10(p3, p4, p5)
	if not p4 then
		p4 = {}
	end

	if not p5 then
		p5 = {}
	end

	if not p5[p3] then
		p5[p3] = true

		for _, v in pairs(p3) do
			p4[#p4 + 1] = v

			if type(v) == "table" then
				u10(v, p4, p5)
			end
		end

		return p4
	end

	return p4
end

local function u11(p6)
	local ok, _ = pcall(function()
		debug.getupvalues(p6, 1)
	end)

	return ok
end
local function v12(p7)
	local v189 = not iscclosure(p7)
	local v190 = islclosure(p7)
	local v191 = u11(p7)

	if v189 ~= v190 or (v189 ~= v191 or v190 ~= v191 or v190 ~= v189) then
		return nil
	end

	return v189
end

local _, _ = pcall(function()
	isreadonly(0)
end)
local _, _ = pcall(function()
	iscclosure(0)
end)
local _, _ = pcall(function()
	islclosure(0)
end)
local v19 = 3259 + 12

for _, v in ipairs(u10(getgenv())) do
	if typeof(v) == "function" then
		if v12(v) ~= nil then
		end
	end
end

for _, v in ipairs(u10(getrenv())) do
	if typeof(v) == "function" then
		if v12(v) ~= nil then
		end
	end
end

for _, v in ipairs(u10(getgc())) do
	if typeof(v) == "function" then
		if v12(v) == nil then
		end
	end
end

for _, v in ipairs(u10(getregistry())) do
	if typeof(v) == "function" then
		if v12(v) ~= nil then
		end
	end
end

local v28 = v19 + 12

workspace:GetServerTimeNow()
wait()
workspace:GetServerTimeNow()

if isreadonly(os) then
	if not isreadonly(math) then
	end
end

if spawn == getrenv().spawn and os.time == getrenv().os.time then
	if os.Date == getrenv().os.Date then
	end
end

local v29 = v28 + 8
local v30 = true
local v31 = getgc(true)

for i = 1, #v31 do
	if v31 == v31[i] then
		v30 = not v30
	end
end

local v33 = v29 + 49 + 4
local v34 = nil
local v35 = true
local v36 = getgc(true)

for i = 1, #v36 do
	local v38 = false
	local v39 = rawget(v36, i)

	if type(v39) ~= "table" then
		v38 = true
	elseif not rawget(v39, "GenericFunction") then
		v38 = true
	elseif not getrawmetatable(v39) and not getmetatable(v39) then
		if v39._LOADED then
			if not v39.FloatCurveKey then
				v38 = true
			else
				v35 = not v35
				v34 = v39
			end
		else
			v38 = true
		end
	else
		v38 = true
	end

	if not v38 then
		break
	end
end

local v40 = v33 + 20

if not v34 then
	v34 = {}
end

local _ = #v34
local v42 = getgc(true)

wait()

local v43 = v40 + 1
local v44 = getgc(true)
local _ = #v44
local v46 = true
local v47 = true

for i = 1, #v44 do
	local v49 = v44[i]

	if type(v49) == "table" and v42 == rawget(v49, 1) then
		v47 = not v47
	end

	if v49 == v44 then
		v46 = not v46
	end
end

local v50 = v43 + 2

setmetatable({ v44 }, {
	__mode = "v"
})
wait()

local _, _ = next(v34)
local v53 = v50 + 12

rconsoleclear()

local _ = #getgc(true)
local u55 = (v53 - 115) / 2
local s1 = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"

local function u57(p8)
	return (p8:gsub(".", function(p9)
		local s2 = ""
		local v682 = p9:byte()

		for i = 8, 1, -1 do
			s2 = s2 .. (v682 % 2 ^ i - v682 % 2 ^ (i - 1) > 0 and "1" or "0")
		end

		return s2
	end) .. "0000"):gsub("%d%d%d?%d?%d?%d?", function(p10)
		if #p10 < 6 then
			return ""
		end

		local n1 = 0

		for i = 1, 6 do
			n1 = n1 + (p10:sub(i, i) == "1" and 2 ^ (6 - i) or 0)
		end

		return s1:sub(n1 + 1, n1 + 1)
	end) .. ({
		"",
		"==",
		"="
	})[#p8 % 3 + 1]
end
local function u58(p11)
	return string.gsub(p11, "[^" .. s1 .. "=]", ""):gsub(".", function(p12)
		if p12 ~= "=" then
			local s3 = ""
			local v689 = s1:find(p12) - 1

			for i = 6, 1, -1 do
				s3 = s3 .. (v689 % 2 ^ i - v689 % 2 ^ (i - 1) > 0 and "1" or "0")
			end

			return s3
		end

		return ""
	end):gsub("%d%d%d?%d?%d?%d?%d?%d?", function(p13)
		if #p13 == 8 then
			local n2 = 0

			for i = 1, 8 do
				n2 = n2 + (p13:sub(i, i) == "1" and 2 ^ (8 - i) or 0)
			end

			return string.char(n2)
		end

		return ""
	end)
end
local function u59(p14, p15, p16, p17, p18, p19, p20, p21)

	local s4 = ""
	local v203 = u58(p20)

	for i = 0, v203:len() - 1 do
		local v205 = v203:sub(i + 1)
		local v206 = v203.sub(v203.sub(p21, i % v203.len(p21) - 1, -1), i % v203.len(p21) - 1, -1)
		local v207 = if v203.len(v206) >= v203.len(p21) then v203.sub(v206, i % v203.len(p21), i % v203.len(p21)) else v203.sub(v206, 1, 1)

		s4 = s4 .. v203.char(v203.byte(v205) - v203.byte(v207))
	end

	return s4
end

function Hex(p22)
	return string.gsub(p22, ".", function(p23)
		return string.format("%02x", string.byte(p23))
	end)
end

local function u60(p24)
	return (p24:gsub("..", function(p25)
		return string.char(tonumber(p25, 16))
	end))
end
local function u61(p26)
	return table.concat({
		p26:sub(1, 8),
		p26:sub(9, 12),
		p26:sub(13, 16),
		p26:sub(17, 20),
		p26:sub(21, 32)
	}, "-")
end

function str_guid(p27)
	u55 = u55 + 50

	local v225 = u58(p27)
	local v226 = Hex(v225)
	local t3 = {}

	for i = 1, #v226, 32 do
		local v229 = v226:sub(i, i + 31)
		local v230 = v229 .. string.rep("0", 32 - #v229)

		table.insert(t3, u61(v230))
	end

	return table.concat(t3, ".")
end
function guid_str(p28)
	u55 = u55 + 32

	local v232 = p28:gsub("[%.-]", "")
	local v233 = u60(v232)

	return u57(v233:gsub("%z+$", ""))
end

local u62 = (function(p29)
	u55 = u55 - 65

	local n3 = 1970
	local v236 = math.floor(p29 / 86400)
	local v237 = math.floor(p29 % 86400 / 3600)

	while v236 >= 365 + (n3 % 4 == 0 and (not (n3 % 100 == 0 and n3 % 400 ~= 0) and 1) or 0) do
		v236 = v236 - (365 + (n3 % 4 == 0 and ((n3 % 100 ~= 0 or n3 % 400 == 0) and 1) or 0))
		n3 = n3 + 1
	end

	local n4 = 1
	local t4 = {
		31,
		28 + (n3 % 4 == 0 and (not (n3 % 100 == 0 and n3 % 400 ~= 0) and 1) or 0),
		31,
		30,
		31,
		30,
		31,
		31,
		30,
		31,
		30,
		31
	}

	while v236 >= t4[n4] do
		v236 = v236 - t4[n4]
		n4 = n4 + 1
	end

	return {
		year = n3,
		month = n4,
		day = v236 + 1,
		hour = v237
	}
end)(workspace:GetServerTimeNow())
local s5 = "ASTRAL.LUA V1.2"
local s6 = "ASTRAL.LUA"
local _workspace = workspace
local CurrentCamera = _workspace.CurrentCamera

getgenv().Utilities = {
	Options_Utility = {
		PrimaryPart = "HumanoidRootPart",
		Humanoid = "Humanoid"
	},
	Connections = {}
}
getgenv().Settings = {
	Movement = {
		Bhop = {
			Enabled = false,
			AutobhopDelay = 0,
			Speed = 10
		},
		WalkSpeed = {
			Enabled = false,
			Value = 17
		},
		JumpPower = {
			Enabled = false,
			Value = 50
		},
		AntiAim = {
			Enabled = false,
			Type = "Jitter",
			Yaw = 20
		}
	},
	LegitBot = {
		Enabled = false,
		Fov = 90,
		FieldOfView = false,
		Smoothness = 100,
		Hitbox = "Head",
		Type = "Lock",
		Keybind = "E",
		Teamcheck = false,
		Wallcheck = false,
		MaxDistance = 5000,
		Line = false
	},
	Ragebot = {
		Enabled = false,
		Autohit = false,
		Wallcheck = false,
		Maxdist = 5000,
		BodyPart = "Head"
	},
	Triggerbot = {
		Enabled = false,
		ReactionTime = 0.1,
		TeamCheck = false
	},
	Visuals = {
		Text = {
			Enabled = false,
			Outline = false,
			Distance = false,
			Health = false,
			Name = false,
			Offset = 15,
			TextColor = Color3.fromRGB(255, 255, 255),
			Transparency = 0.5,
			TextSize = 30
		},
		Box = {},
		Line = {
			Enabled = false,
			StartFrom = "Top",
			Thickness = 1,
			Transparency = 0.6,
			Color = Color3.fromRGB(255, 255, 255)
		},
		Chams = {
			Enabled = false,
			Filled = false,
			Transparency = 0.7,
			OutlineTransparency = 0.7,
			Color = Color3.fromRGB(255, 255, 255)
		},
		Client = {
			Bullet = {
				Enabled = false,
				Color = Color3.fromRGB(0, 0, 255),
				Transparency = 0.7,
				Material = "ForceField",
				Lifetime = 0.5,
				Type = "2d"
			},
			FieldOfView = {
				Enabled = false,
				Value = 90
			}
		},
		World = {
			Ambient = {
				Enabled = false,
				Color = Color3.fromRGB(255, 255, 255)
			},
			Brightness = {
				Enabled = false,
				Slider = 2
			},
			ColorShift_Bottom = {
				Enabled = false,
				Color = Color3.fromRGB(255, 255, 255)
			},
			ColorShift_Top = {
				Enabled = false,
				Color = Color3.fromRGB(255, 255, 255)
			},
			OutdoorAmbient = {
				Enabled = false,
				Color = Color3.fromRGB(255, 255, 255)
			},
			Shadow = {
				Enabled = true,
				Softness = 1
			}
		},
		Viewmodel = {
			Size = 0.25,
			SizeEnabled = true,
			Enabled = false,
			Color = Color3.fromRGB(1, 255, 1),
			Material = Enum.Material.ForceField,
			Transparency = 0.5,
			Tools = {
				Size = 1,
				Color = Color3.fromRGB(1, 1, 255),
				Material = Enum.Material.Neon,
				Transparency = 0.8,
				Enabled = false
			}
		}
	}
}
getgenv().tools = {
	Godmode = {
		Enabled = false
	},
	Autofarm = {
		Enabled = false,
		Frequency = 0.6
	},
	Building = {
		Enabled = false,
		Unbreakable = false,
		Offset = 0
	},
	Anticheat = {
		Enabled = true
	},
	Teleport = {
		Offset = 0,
		MaxIteration = 500,
		Timer = 0.1,
		TimerCheck = 3,
		Monument = "Airfield",
		Pos = Vector3.new(0, 0, 0),
		Type = "State"
	}
}
getgenv().Hitbox = {
	Enabled = false,
	Hitbox = "HumanoidRootPart",
	Size = 25
}

local _Hitbox = Hitbox
local _tools = tools

getgenv().Services = {}
getgenv().Tracer = {}
getgenv().Text = {}
getgenv().Chams = Instance.new("Folder")

local _Utilities = Utilities
local _Services = Services
local _Tracer = Tracer
local _Text = Text
local _Chams = Chams
local _Settings = Settings
local drawing = Drawing.new("Circle")

drawing.Radius = _Settings.LegitBot.Fov
drawing.Color = Color3.new(255, 255, 255)
drawing.Filled = false
drawing.NumSides = 360
drawing.Position = Vector2.new(CurrentCamera.ViewportSize.X, CurrentCamera.ViewportSize.Y)
drawing.Transparency = 1
drawing.Thickness = 2
drawing.Visible = _Settings.LegitBot.FieldOfView

local drawing2 = Drawing.new("Line")

drawing2.Thickness = 1
drawing2.Transparency = 0.7
drawing2.Color = Color3.fromRGB(255, 255, 255)
_Chams.Parent = game:GetService("CoreGui")
_Chams.Name = "Chams"
setrawmetatable(_Services, {
	__index = function(_, p31)
		local p31_2 = game:GetService(p31)

		if p31_2 then
			return p31_2
		end

		error("Service " .. p31 .. " does not exist.")
	end
})

local Items = nil
local lib = {}
local clone = nil
local lib2 = {}

pcall(function()
	Items = _Services.ReplicatedStorage.Modules.Client.Config.Items
	lib = require(Items)
	clone = Items:Clone()
	clone.Name = "AstralStats"
	lib2 = require(clone)
end)

if not Items then
	warn("[ASTRALGUARD] - item config unavailable; continuing UI load")
end

function _Utilities.log(p32, p33, p34)
	warn(string.format("[%s]: {%s} | %s | (%s) ", "ASTRAL-LUA", p32, p33, p34))
end
function _Utilities.editVal(p35, p36, p37)
	for k, v in pairs(p35) do
		if type(v) == "table" then
			_Utilities.editVal(v, p36, p37)
		elseif tostring(k):lower():find(p36:lower()) then
			p35[k] = p37
		end
	end
end
function _Utilities.resetVal()
	for k in pairs(lib) do
		lib[k] = nil
	end

	for k, v in pairs(lib2) do
		lib[k] = v
	end
end
function _Utilities.GetPlayer(p38)
	return _Services.Players:FindFirstChild(p38)
end
function _Utilities.GetLocalPlayer()
	return _Services.Players.LocalPlayer
end

local u92 = _Utilities.GetLocalPlayer()

function _Utilities.GetSelectedItem()
	local Hotbar = u92.PlayerGui.UI.Ingame.Inventory.Hotbar

	for _, v in pairs(Hotbar:GetChildren()) do
		if (v.Name == "1" or v.Name == "2" or v.Name == "3" or v.Name == "4" or v.Name == "5" or v.Name == "6") and v.BackgroundColor3 == Color3.fromRGB(26, 108, 162) then
			return v
		end
	end
end
function _Utilities.GetCharacter(p39)
	local playerFolder = _workspace:FindFirstChild("Players")

	if not playerFolder then
		return nil
	end

	return playerFolder:FindFirstChild(p39)
end
function _Utilities.GetPlayers()
	return (_Services.Players:GetPlayers())
end
function _Utilities.GetTeam(p40)
	local v262 = _Utilities.GetPlayer(p40)

	if v262 then
		return v262.TeamColor
	end

	return nil
end
function _Utilities.GetHumanoid(p41)
	local v264 = _Utilities.GetPlayer(p41)
	if not v264 then
		return nil
	end

	local v265 = _Utilities.GetCharacter(v264.Name)

	if not v265 then
		return
	end

	return (v265:FindFirstChild(_Utilities.Options_Utility.Humanoid))
end
function _Utilities.GetPlayerPrimary(p42)
	local v267 = _Utilities.GetPlayer(p42)
	if not v267 then
		return nil
	end

	local v268 = _Utilities.GetCharacter(v267.Name)

	if not v268 then
		return nil
	end

	return (v268:FindFirstChild(_Utilities.Options_Utility.PrimaryPart))
end
function _Utilities.GetHealth(p43)
	local v270 = _Utilities.GetHumanoid(p43)

	if v270 then
		return v270.Health
	end

	return nil
end
function _Utilities.DistanceBetweenPlayers(p44, p45)
	local v273 = _Utilities.GetCharacter(p44.Name)
	local v274 = _Utilities.GetCharacter(p45.Name)

	if v273 and v274 then
		local _UtilitiesOptions_UtilityPrimaryPart = v273:FindFirstChild(_Utilities.Options_Utility.PrimaryPart)
		local _UtilitiesOptions_UtilityPrimaryPart2 = v274:FindFirstChild(_Utilities.Options_Utility.PrimaryPart)

		if _UtilitiesOptions_UtilityPrimaryPart and _UtilitiesOptions_UtilityPrimaryPart2 then
			return (_UtilitiesOptions_UtilityPrimaryPart.Position - _UtilitiesOptions_UtilityPrimaryPart2.Position).Magnitude
		end
	end

	return Vector3.zero
end
function _Utilities.IsVisible(p46, p47)
	local localPlayer = _Utilities.GetLocalPlayer()
	local v279 = localPlayer and _Utilities.GetCharacter(localPlayer.Name)

	if p47 and v279 and p47:FindFirstChild("HumanoidRootPart") then
		local v280 = p47.HumanoidRootPart.Position - p46
		local raycastParams = RaycastParams.new()

		raycastParams.FilterDescendantsInstances = {
			CurrentCamera,
			v279
		}
		raycastParams.FilterType = Enum.RaycastFilterType.Blacklist
		raycastParams.IgnoreWater = true

		local raycastResult = _workspace:Raycast(p46, v280, raycastParams)

		return raycastResult == nil or raycastResult.Instance:IsDescendantOf(p47)
	end

	return false
end
function _Utilities.WorldToScreen(p48)
	local v284, v285 = CurrentCamera:WorldToViewportPoint(p48)

	return Vector2.new(v284.X, v284.Y), v285
end
function _Utilities.ClosestToMouseRadius(p49, p50, p51)
	local v289 = nil
	local huge = math.huge
	local v291 = _Utilities.GetPlayers()
	local v292 = u92
	local Mouse = v292:GetMouse()

	for _, v in pairs(v291) do
		if v ~= v292 then
			local v296 = not p49 or _Utilities.GetTeam(v.Name) ~= _Utilities.GetTeam(v292.Name)
			local vector3 = Vector3.new(0, 0, 0)
			local v298 = nil
			local v299 = _Utilities.GetPlayerPrimary(v292.Name)

			if _Utilities.GetCharacter(v.Name) then
				v298 = _Utilities.GetCharacter(v.Name)
			end

			if v299 then
				vector3 = v299.Position
			end

			local v300 = not p50 or _Utilities.IsVisible(vector3, v298)
			local v301 = _Utilities.GetPlayerPrimary(v.Name)

			if v301 then
				local v302, v303 = _Utilities.WorldToScreen(v301.Position)

				if v303 then
					local Magnitude = (Vector2.new(Mouse.X, Mouse.Y + 55) - v302).Magnitude

					if Magnitude <= p51 and v296 and v300 and Magnitude < huge then
						huge = Magnitude
						v289 = v
					end
				end
			end
		end
	end

	return v289, huge
end
function _Utilities.SetCamPos(p52, p53)
	local CurrentCameraCFrame = CurrentCamera.CFrame
	local cFrame = CFrame.new(CurrentCamera.CFrame.Position, p52)

	if p53 ~= 1 then
		CurrentCamera.CFrame = CurrentCameraCFrame:Lerp(cFrame, p53)
	else
		CurrentCamera.CFrame = cFrame
	end
end
function _Utilities.beam(p54, p55)
	local Part = Instance.new("Part", _workspace)

	Part.Anchored = true
	Part.CanCollide = false
	Part.Material = _Settings.Visuals.Client.Bullet.Material
	Part.Color = _Settings.Visuals.Client.Bullet.Color
	Part.Size = Vector3.new(0.1, 0.1, (p54 - p55).magnitude)
	Part.CFrame = CFrame.new(p54, p55) * CFrame.new(0, -0.5, -Part.Size.Z / 2)

	return Part
end
function _Utilities.UpdateChams(p56)
	if _Settings.Visuals.Chams.Enabled then
		local v313 = _Utilities.GetCharacter(p56.Name)

		if _Chams:FindFirstChild(p56.Name) then
			local p56Name = _Chams:FindFirstChild(p56.Name)

			p56Name.OutlineTransparency = _Settings.Visuals.Chams.OutlineTransparency
			p56Name.FillTransparency = _Settings.Visuals.Chams.Transparency
			p56Name.FillColor = _Settings.Visuals.Chams.Color
			p56Name.OutlineColor = _Settings.Visuals.Chams.Color
			p56Name.Adornee = v313
			p56Name.Name = p56.Name
		end

		if v313 and not _Chams:FindFirstChild(p56.Name) then
			local Highlight = Instance.new("Highlight")

			Highlight.Parent = _Chams
			Highlight.OutlineTransparency = _Settings.Visuals.Chams.OutlineTransparency
			Highlight.FillTransparency = _Settings.Visuals.Chams.Transparency
			Highlight.FillColor = _Settings.Visuals.Chams.Color
			Highlight.OutlineColor = _Settings.Visuals.Chams.Color
			Highlight.Parent = _Chams
			Highlight.Adornee = v313
			Highlight.Name = p56.Name
		end

		return
	end
end
function _Utilities.UpdateText(p57)
	local v317 = _Text[p57.Name]

	if not p57 then
		if v317 then
			v317.Visible = false
		end

		return
	end

	if not _Settings.Visuals.Text.Enabled then
		if v317 then
			v317.Visible = false
		end

		return
	end

	local v318 = _Utilities.GetPlayerPrimary(p57.Name)

	if v318 then
		local v319, v320 = _Utilities.WorldToScreen(v318.Position)

		if not _Text[p57.Name] then
			local drawing3 = Drawing.new("Text")

			_Text[p57.Name] = drawing3
			drawing3.Center = true
			drawing3.Size = _Settings.Visuals.Text.TextSize
			drawing3.Outline = _Settings.Visuals.Text.Outline
			drawing3.Color = _Settings.Visuals.Text.TextColor
			drawing3.Transparency = _Settings.Visuals.Text.Transparency
			drawing3.Font = Drawing.Fonts.UI
		end

		local s7 = ""
		local s8 = ""
		local s9 = ""

		if v320 then
			local v325 = _Text[p57.Name]

			v325.Visible = true
			v325.Center = true
			v325.Size = _Settings.Visuals.Text.TextSize
			v325.Outline = _Settings.Visuals.Text.Outline
			v325.Color = _Settings.Visuals.Text.TextColor
			v325.Transparency = _Settings.Visuals.Text.Transparency
			v325.Font = Drawing.Fonts.UI
			v325.Position = Vector2.new(v319.X, v319.Y - _Settings.Visuals.Text.Offset - 10)

			if _Settings.Visuals.Text.Name then
				s7 = p57.Name
			end

			if _Settings.Visuals.Text.Distance then
				local v326 = u92

				s8 = "STUD: [" .. tostring(math.floor(_Utilities.DistanceBetweenPlayers(v326, p57))) .. "]"
			end

			if _Settings.Visuals.Text.Health then
				s9 = tostring(_Utilities.GetHealth(p57.Name))
			end

			v325.Text = "[" .. s9 .. "]" .. " " .. s7 .. " " .. s8
		else
			_Text[p57.Name].Visible = false
		end

		return
	end

	if v317 then
		v317.Visible = false
	end
end
function _Utilities.UpdateTracer(p58)
	local v328 = _Tracer[p58.Name]

	if not _Settings.Visuals.Line.Enabled then
		if v328 then
			v328.Visible = false
		end

		return
	end

	local v329 = _Utilities.GetPlayerPrimary(p58.Name)

	if v329 then
		local v330, v331 = _Utilities.WorldToScreen(v329.Position)

		if not v328 then
			v328 = Drawing.new("Line")
			_Tracer[p58.Name] = v328
			v328.Thickness = _Settings.Visuals.Line.Thickness
			v328.Transparency = _Settings.Visuals.Line.Transparency
			v328.Color = _Settings.Visuals.Line.Color
		end

		if v331 then
			v328.Visible = true

			if _Settings.Visuals.Line.StartFrom ~= "Top" then
				if _Settings.Visuals.Line.StartFrom ~= "Bottom" then
					if _Settings.Visuals.Line.StartFrom == "Mouse" then
						local Mouse = u92:GetMouse()

						v328.From = Vector2.new(Mouse.X, Mouse.Y + 55)
					end
				else
					v328.From = Vector2.new(CurrentCamera.ViewportSize.X / 2, CurrentCamera.ViewportSize.Y)
				end
			else
				v328.From = Vector2.new(CurrentCamera.ViewportSize.X / 2, 0)
			end

			v328.To = v330
		else
			v328.Visible = false
		end

		return
	end

	if v328 then
		v328.Visible = false
	end
end

local v93 = _Utilities.GetCharacter(_Utilities.GetLocalPlayer().Name)
local clone2 = nil
local clone3 = nil

if v93 then
	v93.Archivable = true

	clone2 = v93:Clone()
	clone3 = v93:Clone()
	local cloneParent = _workspace:FindFirstChild("Players") or _workspace

	clone2.Parent = cloneParent
	clone3.Parent = cloneParent
end

local s10 = "https://raw.githubusercontent.com/ScriptSkiddie69/LinoriaLib/main/"
local u97 = loadstring(game:HttpGet(s10 .. "Library.lua"))()
local v98 = loadstring(game:HttpGet(s10 .. "addons/ThemeManager.lua"))()
local v99 = loadstring(game:HttpGet(s10 .. "addons/SaveManager.lua"))()
local v100 = u97:CreateWindow({
	Title = "ASTRAL.LUA - PRIVATE",
	Center = true,
	AutoShow = true,
	TabPadding = 8,
	MenuFadeTime = 0.2
})
local t5 = {
	Main = v100:AddTab("Main"),
	Misc = v100:AddTab("Exploit"),
	Movement = v100:AddTab("Movement"),
	Visuals = v100:AddTab("Visuals"),
	["UI Settings"] = v100:AddTab("UI Settings")
}
local v102 = t5.Main:AddLeftGroupbox("Legit bot")
local v103 = t5.Main:AddLeftGroupbox("Trigger bot")
local v104 = t5.Main:AddRightGroupbox("Hitbox Expander")
local v105 = t5.Main:AddRightGroupbox("Fire rate")
local v106 = t5.Misc:AddRightGroupbox("Exploit")
local v107 = t5.Misc:AddLeftGroupbox("Misc")
local v108 = t5.Misc:AddLeftGroupbox("Spawn Item")
local v109 = t5.Misc:AddLeftGroupbox("Autofarm")
local v110 = t5.Movement:AddLeftGroupbox("Bunny hop")
local v111 = t5.Movement:AddRightGroupbox("Anti Aim")
local v112 = t5.Visuals:AddLeftGroupbox("Text esp")
local v113 = t5.Visuals:AddRightGroupbox("Tracer esp")
local v114 = t5.Visuals:AddLeftGroupbox("Chams esp")
local v115 = t5.Visuals:AddRightTabbox()
local v116 = v115:AddTab("World")
local v117 = v115:AddTab("Client")

v102:AddToggle("AimbotEnabled", {
	Text = "Enabled",
	Default = false,
	Tooltip = "Enables silent aim/aimlock",
	Callback = function(p59)
		_Settings.LegitBot.Enabled = p59
	end
}):AddKeyPicker("LegitbotKeybind", {
	Default = "MB2",
	SyncToggleState = false,
	Mode = "Hold",
	Text = "Legit Bot",
	NoUI = false,
	Callback = function(p60)
		_Settings.LegitBot.Keybind = p60
	end,
	ChangedCallback = function(p61)
		_Settings.LegitBot.Keybind = p61
	end
})
v102:AddDropdown("LegitbotHitbox", {
	Values = {
		"Head",
		"HumanoidRootPart"
	},
	Default = 1,
	Multi = false,
	Text = "Hitbox",
	Tooltip = "Target lock of the silent aim/aimlock",
	Callback = function(p62)
		_Settings.LegitBot.Hitbox = p62
	end
})
v102:AddDropdown("LegitbotType", {
	Values = {
		"Lock",
		"Silent"
	},
	Default = 1,
	Multi = false,
	Text = "Hitbox",
	Tooltip = "Types of legitbot",
	Callback = function(p63)
		_Settings.LegitBot.Type = p63
	end
})
v102:AddSlider("LegitbotSmoothness", {
	Text = "Smoothness",
	Default = 100,
	Min = 1,
	Max = 100,
	Rounding = 1,
	Compact = false,
	Callback = function(p64)
		_Settings.LegitBot.Smoothness = p64 / 100
	end
})
v102:AddToggle("LegitBotLine", {
	Text = "Target line",
	Default = false,
	Tooltip = "Makes a line on the legitbot taret",
	Callback = function(p65)
		_Settings.LegitBot.Line = p65
	end
})
v102:AddLabel("Field Of View")
v102:AddToggle("LegitBotFov", {
	Text = "Enabled",
	Default = false,
	Tooltip = "Makes LegitBot FOV Visible",
	Callback = function(p66)
		_Settings.LegitBot.FieldOfView = p66
	end
})
v102:AddSlider("LegitBotFovValue", {
	Text = "Amount: ",
	Default = 90,
	Min = 1,
	Max = 360,
	Rounding = 1,
	Compact = false,
	Callback = function(p67)
		_Settings.LegitBot.Fov = p67
	end
})
v102:AddLabel("Team check")
v102:AddToggle("LegitBotTeamCheck", {
	Text = "Enabled",
	Default = false,
	Tooltip = "Makes LegitBot Targets enemy only",
	Callback = function(p68)
		_Settings.LegitBot.Teamcheck = p68
	end
})
v102:AddLabel("Wall check")
v102:AddToggle("LegitBotWallCheck", {
	Text = "Enabled",
	Default = false,
	Tooltip = "Makes LegitBot Targets visible enemy only",
	Callback = function(p69)
		_Settings.LegitBot.Wallcheck = p69
	end
})
v103:AddToggle("TriggerbotEnabled", {
	Text = "Enabled",
	Default = false,
	Tooltip = "Enables triggerbot",
	Callback = function(p70)
		_Settings.Triggerbot.Enabled = p70
	end
})
v103:AddToggle("TriggerbotEnabled", {
	Text = "Team check",
	Default = false,
	Tooltip = "Only fires at enemies",
	Callback = function(p71)
		_Settings.Triggerbot.Teamcheck = p71
	end
})
v103:AddSlider("TriggerbotReaction", {
	Text = "Reaction time",
	Default = 1,
	Min = 0,
	Max = 100,
	Rounding = 1,
	Compact = false,
	Callback = function(p72)
		_Settings.Triggerbot.ReactionTime = p72 / 100
	end
})
v104:AddToggle("HitboxEnabled", {
	Text = "Enabled",
	Default = false,
	Tooltip = "Expands hitbox",
	Callback = function(p73)
		_Hitbox.Enabled = p73
	end
})
v104:AddDropdown("HitboxOptions", {
	Values = {
		"HumanoidRootPart",
		"Head"
	},
	Default = 1,
	Multi = false,
	Text = "Hitbox",
	Tooltip = "Whitelists things that can be farmed",
	Callback = function(p74)
		_Hitbox.Hitbox = p74
	end
})
v104:AddSlider("HitboxSize", {
	Text = "Hitbox size",
	Default = 25,
	Min = 1,
	Max = 100,
	Rounding = 1,
	Compact = false,
	Callback = function(p75)
		_Hitbox.Size = p75
	end
})

local t6 = {
	Enabled = false,
	Range = 20
}

v104:AddLabel("Melee aura")
v104:AddToggle("MeleeEnabled", {
	Text = "Enabled",
	Default = false,
	Tooltip = "Hits anything in range ( put melee at slot 5)",
	Callback = function(p76)
		t6.Enabled = p76
	end
})
v104:AddSlider("MeleeDist", {
	Text = "Aura distance",
	Default = 20,
	Min = 1,
	Max = 100,
	Rounding = 1,
	Compact = false,
	Callback = function(p77)
		t6.Range = p77
	end
})

local t7 = {
	FireRate = {
		Enabled = false,
		Value = 6000
	},
	Spread = {
		Enabled = false,
		Value = 0
	},
	Reload = {
		Enabled = false,
		Value = 0
	},
	MaxAmmo = {
		Enabled = false,
		Value = 60
	}
}

v105:AddToggle("FireRate", {
	Text = "Enabled",
	Default = false,
	Tooltip = "Modifies your gun firerate",
	Callback = function(p78)
		t7.FireRate.Enabled = p78

		if p78 then
			_Utilities.editVal(lib, "RPM", t7.FireRate.Value)
		end
	end
})
v105:AddSlider("FirerateValue", {
	Text = "Value",
	Default = 6000,
	Min = 1,
	Max = 6000,
	Rounding = 1,
	Compact = false,
	Callback = function(p79)
		t7.FireRate.Value = p79

		if t7.FireRate.Enabled then
			_Utilities.editVal(lib, "RPM", t7.FireRate.Value)
		end
	end
})
v105:AddLabel("Spread")
v105:AddToggle("Spread", {
	Text = "Enabled",
	Default = false,
	Tooltip = "Modifies your gun spread",
	Callback = function(p80)
		t7.Spread.Enabled = p80

		if p80 then
			_Utilities.editVal(lib, "Spread", t7.FireRate.Value)
		end
	end
})
v105:AddSlider("SpreadVal", {
	Text = "Value",
	Default = 0,
	Min = 0,
	Max = 50,
	Rounding = 1,
	Compact = false,
	Callback = function(p81)
		t7.Spread.Value = p81

		if t7.Spread.Enabled then
			_Utilities.editVal(lib, "Spread", t7.FireRate.Value)
		end
	end
})
v105:AddLabel("Auto reload")
v105:AddToggle("ReloadEnabled", {
	Text = "Enabled",
	Default = false,
	Tooltip = "Auto reloads your gun",
	Callback = function(p82)
		t7.Reload.Enabled = p82
	end
})
v106:AddToggle("ACBypass", {
	Text = "Anticheat bypass",
	Default = true,
	Tooltip = "Bypasses the serversided anticheat",
	Callback = function(p83)
		_tools.Anticheat.Enabled = p83
	end
})

local n5 = 0.15
local n6 = 0.15

v106:AddButton({
	Text = "Bruteforce building",
	Func = function()
		local v358 = _Utilities.GetLocalPlayer()

		_Utilities.GetCharacter(v358.Name)

		local v359 = _Utilities.GetHumanoid(v358.Name)

		if v359 then
			local Target = v358:GetMouse().Target
			local v361 = nil
			local ParentParent = nil

			if Target.Parent.Parent.Name ~= "Doors" then
				if Target.Parent.Parent.Parent.Name == "Doors" then
					ParentParent = Target.Parent.Parent
				end
			else
				ParentParent = Target.Parent
			end

			for _, v in pairs(ParentParent:GetDescendants()) do
				if v.Name == "Authorized" then
					v361 = v

					break
				end
			end

			local t8 = {
				"Drown Tick",
				false,
				-(v359.MaxHealth - v359.Health) / 5,
				nil
			}

			game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("RemoteEvent"):FireServer(unpack(t8))

			local n7 = 1000

			for _ = 1, 2250 do
				if not v359 then
					return
				end

				local UserId = v361:FindFirstChild(v358.UserId)

				if UserId then
					u97:Notify("BRUTEFORCED! Code lock is in between: " .. tostring(n7) .. "-" .. tostring(n7 - 4) .. " (if doesnt work try removing 1-5 or adding 1-5 numbers)", 8)
					_Utilities.log("BRUTEFORCED", "Codelock is in between: " .. tostring(n7) .. "-" .. tostring(n7 - 4), "(SERVER)")

					return
				end

				for _ = 1, 4 do
					UserId = v361:FindFirstChild(v358.UserId)

					if UserId then
						u97:Notify("BRUTEFORCED! Code lock is in between: " .. tostring(n7) .. "-" .. tostring(n7 - 4) .. " (if doesnt work try removing 1-5 or adding 1-5 numbers)", 8)
						_Utilities.log("BRUTEFORCED", "Codelock is in between: " .. tostring(n7) .. "-" .. tostring(n7 - 4), "(SERVER)")

						break
					end

					n7 = n7 + 1
					game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("RemoteEvent"):FireServer(unpack({
						"Try Unlock Lock",
						false,
						ParentParent,
						n7,
						24,
						43,
						23,
						2,
						17,
						25,
						35,
						24,
						7,
						48,
						45,
						40,
						48,
						34,
						7,
						42,
						20,
						9,
						38,
						41,
						31,
						50,
						10,
						17,
						14,
						44,
						6,
						14,
						48,
						40,
						15,
						34,
						41,
						9,
						28,
						11,
						24,
						27,
						38,
						8,
						39,
						23,
						20,
						42,
						2
					}))
					task.wait(n5)
				end

				if not UserId then
					local t9 = {
						"Drown Tick",
						false,
						-(v359.MaxHealth - v359.Health) / 7,
						nil
					}

					game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("RemoteEvent"):FireServer(unpack(t9))
				end

				task.wait(n6)
			end

			return
		end
	end,
	DoubleClick = false,
	Tooltip = "Bruteforces the building on your cursor ( DISABLE GODMODE )"
})
v106:AddSlider("HopSpeed", {
	Text = "Bruteforce hopspeed",
	Default = 15,
	Min = 0,
	Max = 100,
	Rounding = 1,
	Compact = false,
	Callback = function(p84)
		n5 = p84 / 100
	end
})
v106:AddSlider("AntiKickz", {
	Text = "Bruteforce heal speed",
	Default = 15,
	Min = 0,
	Max = 100,
	Rounding = 1,
	Compact = false,
	Callback = function(p85)
		n6 = p85 / 100
	end
})
v106:AddToggle("CustomBuilding", {
	Text = "Hidden building hp",
	Default = false,
	Tooltip = "Makes you be able to place building without the hp",
	Callback = function(p86)
		_tools.Building.Unbreakable = p86
	end
})
v106:AddLabel("God mode")
v106:AddToggle("GodMode", {
	Text = "Enabled",
	Default = false,
	Tooltip = "Makes u unkillable basically",
	Callback = function(p87)
		_tools.Godmode.Enabled = p87
		game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("RemoteEvent"):FireServer(unpack({
			"Drown Tick",
			false,
			1,
			nil
		}))
	end
})
v106:AddLabel("Semi noclip")

local u122 = false

v106:AddToggle("SemiNoclips", {
	Text = "Enabled",
	Default = false,
	Tooltip = "Semi-noclips to bases",
	Callback = function(p88)
		u122 = p88
	end
}):AddKeyPicker("SemiNoclip", {
	Default = "Z",
	SyncToggleState = false,
	Mode = "Toggle",
	Text = "Semi Noclip",
	NoUI = false,
	Callback = function(_)
		local v377 = _Utilities.GetLocalPlayer()
		local v378 = _Utilities.GetCharacter(v377.Name)

		if v378 then
			local Humanoid = v378:FindFirstChildWhichIsA("Humanoid")

			if Humanoid and Humanoid.RootPart then
				local _ = _workspace.CurrentCamera

				Humanoid.Sit = true
				task.wait(0.1)
				Humanoid.RootPart.CFrame = Humanoid.RootPart.CFrame * CFrame.Angles(-math.pi * 0.5, 0, 0)

				for _, v in ipairs(Humanoid:GetPlayingAnimationTracks()) do
					v:Stop()
				end

				return
			end

			return
		end
	end,
	ChangedCallback = function(_)
	end
})
v106:AddLabel("Better noclip")

local u123 = false
local vector3 = Vector3.new(0, 0, 0)
local n8 = 5

v106:AddToggle("NoclipBetter", {
	Text = "Enabled",
	Default = false,
	Tooltip = "Noclips to bases",
	Callback = function(p91)
		u123 = p91

		if not clone3 then
			u123 = false
			return
		end

		if not p91 then
			if clone3:FindFirstChild("NoclipVisual") then
				clone3.NoclipVisual:Destroy()
			end
		else
			local Highlight = Instance.new("Highlight")

			Highlight.Enabled = true
			Highlight.Parent = clone3
			Highlight.Adornee = clone3
			Highlight.Name = "NoclipVisual"
		end
	end
}):AddKeyPicker("BetterNoclipK", {
	Default = "X",
	SyncToggleState = false,
	Mode = "Toggle",
	Text = "Better noclip",
	NoUI = false,
	Callback = function(_)
		local v387 = _Utilities.GetCharacter(u92.Name)
		local u388 = _Utilities.GetPlayerPrimary(u92.Name)
		local Humanoid = v387:FindFirstChild("Humanoid")

		if u123 then
			getgenv().state = Enum.HumanoidStateType.Jumping;
			(function(p93)
				local u698 = u388
				local n9 = 0

				while not (n9 >= 0.5) do
					local v700 = u698

					n9 = not (v700.Position.Y > p93.Y) and 0 or n9 + 0.1
					v700.Velocity = Vector3.new(0, 50, 0)
					task.wait(0.1)
				end

				task.spawn(function()
					task.wait(1)
					game:GetService("RunService"):UnbindFromRenderStep("bypass")
					u698.CFrame = p93
				end)
				game:GetService("RunService"):BindToRenderStep("bypass", Enum.RenderPriority.First.Value, function()
					Humanoid:ChangeState(getgenv().state)
					u698.CFrame = p93
				end)
			end)(vector3)
		end
	end,
	ChangedCallback = function(_)
	end
})
v106:AddSlider("OffsetBeterNoclip", {
	Text = "Offset",
	Default = 5,
	Min = 0,
	Max = 50,
	Rounding = 1,
	Compact = false,
	Callback = function(p95)
		n8 = p95
	end
})
v106:AddLabel("Teleport exploit")

local function u126(p96)
	if p96 == "Airfield" then
		return Vector3.new(588, 261, 281)
	end

	if p96 == "Bunker" then
		return Vector3.new(-203, 197, -2005)
	end

	if p96 ~= "Military" then
		return Vector3.new(0, 0, 0)
	end

	return Vector3.new(543, 58, 2994)
end

v106:AddButton({
	Text = "Teleport to camera",
	Func = function()
		local u393 = _Utilities.GetCharacter(u92.Name)
		local u394 = _Utilities.GetPlayerPrimary(u92.Name)
		local Humanoid = u393:FindFirstChild("Humanoid")

		if _tools.Teleport.Type == "Vector" then
			if not u394 then
				return
			end

			local Position = u394.Position
			local Pos = _tools.Teleport.Pos
			local v398 = (function(p97, p98, p99)
				local v704 = p98 - p97
				local raycastResult = nil
				local n10 = 0

				for i = 1, p99 do
					n10 = i

					local raycastParams = RaycastParams.new()

					raycastParams.FilterDescendantsInstances = { u393 }
					raycastParams.FilterType = Enum.RaycastFilterType.Blacklist
					raycastResult = _workspace:Raycast(p97 + Vector3.new(0, i, 0), v704, raycastParams)

					if not raycastResult then
						return {
							FinalIteration = n10,
							Hit = raycastResult
						}
					end
				end

				return {
					FinalIteration = n10,
					Hit = raycastResult
				}
			end)(Position, Pos, _tools.Teleport.MaxIteration)
			local v399 = u394.Position.Y + v398.FinalIteration + _tools.Teleport.Offset
			local n11 = 0
			local g403 = nil
			local v402

			repeat
				local g401 = false

				v402 = u394

				if v399 > v402.Position.Y then
					v402.Velocity = Vector3.new(0, 50, 0)
					n11 = 0
					g403 = true
				end

				if not g403 then
					n11 = n11 + _tools.Teleport.Timer
					v402.Velocity = Vector3.new(0, 50, 0)
				end

				if g403 or not (n11 >= _tools.Teleport.TimerCheck) then
					g403 = false
					task.wait(_tools.Teleport.Timer)
					g401 = true
				end
			until not g401

			v402.Velocity = Vector3.new(0, 0, 0)

			for _ = 1, 10 do
				u394.CFrame = CFrame.new(Pos.X, u394.Position.Y, Pos.Z)
				task.wait(0.1)
			end
		else
			if not Humanoid then
				return
			end;

			(function(p100)
				local v710 = u394
				local _ = v710.Position
				local n12 = 0

				while true do
					if v710.Position.Y < p100.Y then
						v710.Velocity = Vector3.new(0, 50, 0)

						local v713 = p100.Position.Y - v710.Position.Y

						print("Progress: " .. tostring(v713) .. " studs away")
						n12 = 0
					else
						n12 = n12 + _tools.Teleport.Timer
						v710.Velocity = Vector3.new(0, 50, 0)

						if n12 >= 1 then
							v710.Velocity = Vector3.new(0, 0, 0)
							warn("Teleporting.. ")

							local n13 = 0

							while not (n13 >= _tools.Teleport.TimerCheck) do
								n13 = n13 + 0.05
								v710.CFrame = p100

								for _ = 1, 2 do
									hum:ChangeState(Enum.HumanoidStateType.Jumping)
									task.wait()
								end
							end

							return
						end
					end

					task.wait(0.1)
				end
			end)(CurrentCamera.CFrame)
		end
	end,
	DoubleClick = false,
	Tooltip = "Teleports the character to the camera position"
})
v106:AddButton({
	Text = "Teleport to position",
	Func = function()
		local u405 = _Utilities.GetCharacter(u92.Name)
		local u406 = _Utilities.GetPlayerPrimary(u92.Name)
		local Humanoid = u405:FindFirstChild("Humanoid")
		local g408 = nil

		repeat
			if g408 or _tools.Teleport.Type ~= "Vector" then
				if not g408 then
					if not Humanoid then
						return
					end;

					(function(p101)
						local v725 = u406
						local _ = v725.Position
						local n14 = 0

						while true do
							if v725.Position.Y < p101.Y then
								v725.Velocity = Vector3.new(0, 50, 0)

								local v728 = p101.Position.Y - v725.Position.Y

								print("Progress: " .. tostring(v728) .. " studs away")
								n14 = 0
							else
								n14 = n14 + _tools.Teleport.Timer
								v725.Velocity = Vector3.new(0, 50, 0)

								if n14 >= 1 then
									v725.Velocity = Vector3.new(0, 0, 0)
									warn("Teleporting.. ")

									local n15 = 0

									while not (n15 >= _tools.Teleport.TimerCheck) do
										n15 = n15 + 0.05
										v725.CFrame = p101

										for _ = 1, 2 do
											hum:ChangeState(Enum.HumanoidStateType.Jumping)
											task.wait()
										end
									end

									return
								end
							end

							task.wait(0.1)
						end
					end)(CFrame.new(_tools.Teleport.Pos))
				end

				g408 = false

				return
			end

			if not u406 then
				return
			end

			local Position = u406.Position
			local Pos = _tools.Teleport.Pos
			local v411 = (function(p102, p103, p104)
				local v719 = p103 - p102
				local raycastResult = nil
				local n16 = 0

				for i = 1, p104 do
					n16 = i

					local raycastParams = RaycastParams.new()

					raycastParams.FilterDescendantsInstances = { u405 }
					raycastParams.FilterType = Enum.RaycastFilterType.Blacklist
					raycastResult = _workspace:Raycast(p102 + Vector3.new(0, i, 0), v719, raycastParams)

					if not raycastResult then
						return {
							FinalIteration = n16,
							Hit = raycastResult
						}
					end
				end

				return {
					FinalIteration = n16,
					Hit = raycastResult
				}
			end)(Position, Pos, _tools.Teleport.MaxIteration)
			local v412 = u406.Position.Y + v411.FinalIteration + _tools.Teleport.Offset
			local n17 = 0

			while true do
				local v414 = u406

				if v412 > v414.Position.Y then
					v414.Velocity = Vector3.new(0, 50, 0)
					n17 = 0
				else
					n17 = n17 + _tools.Teleport.Timer
					v414.Velocity = Vector3.new(0, 50, 0)

					if n17 >= _tools.Teleport.TimerCheck then
						v414.Velocity = Vector3.new(0, 0, 0)

						for _ = 1, 10 do
							u406.CFrame = CFrame.new(Pos.X, u406.Position.Y, Pos.Z)
							task.wait(0.1)
						end

						g408 = true
					end
				end

				if g408 then
					break
				end

				task.wait(_tools.Teleport.Timer)
			end
		until not g408
	end,
	DoubleClick = false,
	Tooltip = "Teleports the character to the given position"
})
v106:AddLabel("Teleport to monument")
v106:AddButton({
	Text = "Teleport to monument",
	Func = function()
		local u416 = _Utilities.GetCharacter(u92.Name)
		local u417 = _Utilities.GetPlayerPrimary(u92.Name)
		local u418 = _Utilities.GetHumanoid(u92.Name)

		if not u417 and not u418 then
			return
		end

		local g419 = nil

		repeat
			if g419 or _tools.Teleport.Type ~= "Vector" then
				if not g419 then
					if not u418 then
						return
					end;

					(function(p105)
						local v740 = u417
						local _ = v740.Position
						local n18 = 0

						while true do
							if v740.Position.Y < p105.Y then
								v740.Velocity = Vector3.new(0, 50, 0)

								local v743 = p105.Position.Y - v740.Position.Y

								print("Progress: " .. tostring(v743) .. " studs away")
								n18 = 0
							else
								n18 = n18 + _tools.Teleport.Timer
								v740.Velocity = Vector3.new(0, 50, 0)

								if n18 >= 1 then
									v740.Velocity = Vector3.new(0, 0, 0)
									warn("Teleporting.. ")

									local n19 = 0

									while not (n19 >= _tools.Teleport.TimerCheck) do
										n19 = n19 + 0.05
										v740.CFrame = p105

										for _ = 1, 2 do
											u418:ChangeState(Enum.HumanoidStateType.Jumping)
											task.wait()
										end
									end

									return
								end
							end

							task.wait(0.1)
						end
					end)(CFrame.new(u126(_tools.Teleport.Monument)))
				end

				g419 = false

				return
			end

			local Position = u417.Position
			local v421 = u126(_tools.Teleport.Monument)
			local v422 = (function(p106, p107, p108)
				local v734 = p107 - p106
				local raycastResult = nil
				local n20 = 0

				for i = 1, p108 do
					n20 = i

					local raycastParams = RaycastParams.new()

					raycastParams.FilterDescendantsInstances = { u416 }
					raycastParams.FilterType = Enum.RaycastFilterType.Blacklist
					raycastResult = _workspace:Raycast(p106 + Vector3.new(0, i, 0), v734, raycastParams)

					if not raycastResult then
						return {
							FinalIteration = n20,
							Hit = raycastResult
						}
					end
				end

				return {
					FinalIteration = n20,
					Hit = raycastResult
				}
			end)(Position, v421, _tools.Teleport.MaxIteration)
			local v423 = u417.Position.Y + v422.FinalIteration + _tools.Teleport.Offset
			local n21 = 0

			while true do
				local v425 = u417

				if v423 > v425.Position.Y then
					v425.Velocity = Vector3.new(0, 50, 0)
					n21 = 0
				else
					n21 = n21 + _tools.Teleport.Timer
					v425.Velocity = Vector3.new(0, 50, 0)

					if n21 >= _tools.Teleport.TimerCheck then
						v425.Velocity = Vector3.new(0, 0, 0)

						for _ = 1, 10 do
							u417.CFrame = CFrame.new(v421.X, u417.Position.Y, v421.Z)
							task.wait(0.1)
						end

						g419 = true
					end
				end

				if g419 then
					break
				end

				task.wait(_tools.Teleport.Timer)
			end
		until not g419
	end,
	DoubleClick = false,
	Tooltip = "Teleports the character to the given monument"
})
v106:AddDropdown("TpBypassType", {
	Values = {
		"State",
		"Vector"
	},
	Default = 1,
	Multi = false,
	Text = "Bypass type",
	Tooltip = "The bypass type it will use ( state is the best )",
	Callback = function(p109)
		_tools.Teleport.Type = p109
	end
})
v106:AddDropdown("MonumentType", {
	Values = {
		"Airfield",
		"Bunker",
		"Military"
	},
	Default = 1,
	Multi = false,
	Text = "Monument type",
	Tooltip = "The monument to teleport to",
	Callback = function(p110)
		_tools.Teleport.Monument = p110
	end
})
v106:AddInput("TeleportPos", {
	Default = "Position",
	Numeric = false,
	Finished = false,
	Text = "Position",
	Tooltip = "Position to teleport to (VECTOR)",
	Placeholder = "0,0,0",
	Callback = function(p111)
		_tools.Teleport.Pos = p111
	end
})
v106:AddSlider("YOffsset", {
	Text = "Y Offset",
	Default = 0,
	Min = 0,
	Max = 2000,
	Rounding = 1,
	Compact = false,
	Callback = function(p112)
		_tools.Teleport.Offset = p112
	end
})
v106:AddSlider("MaxIteration", {
	Text = "Max iteration",
	Default = 500,
	Min = 0,
	Max = 1000,
	Rounding = 1,
	Compact = false,
	Callback = function(p113)
		_tools.Teleport.MaxIteration = p113
	end
})
v106:AddSlider("Timer", {
	Text = "Timer",
	Default = 0.1,
	Min = 0,
	Max = 1,
	Rounding = 1,
	Compact = false,
	Callback = function(p114)
		_tools.Teleport.Timer = p114
	end
})
v106:AddSlider("MaxIteration", {
	Text = "Timer check",
	Default = 3,
	Min = 0,
	Max = 5,
	Rounding = 1,
	Compact = false,
	Callback = function(p115)
		_tools.Teleport.TimerCheck = p115
	end
})
v107:AddLabel("Custom building")
v107:AddToggle("CustomBuilding", {
	Text = "Enabled",
	Default = false,
	Tooltip = "Custom building (Rotate (r), Tilt (t))",
	Callback = function(p116)
		_tools.Building.Enabled = p116
	end
})
v107:AddSlider("CustomBuildingOffset", {
	Text = "Custom building Y offset (-) ",
	Default = 0,
	Min = 0,
	Max = 30,
	Rounding = 1,
	Compact = false,
	Callback = function(p117)
		_tools.Building.Offset = p117
	end
})
v107:AddLabel("Autofarm")
v107:AddToggle("Autofarm", {
	Text = "Enabled",
	Default = false,
	Tooltip = "Autofarm on selected types (put tool on slot 6)",
	Callback = function(p118)
		_tools.Autofarm.Enabled = p118
	end
})
v107:AddSlider("AutofarmFrequency", {
	Text = "Frequency",
	Default = 10,
	Min = 1,
	Max = 100,
	Rounding = 1,
	Compact = false,
	Callback = function(p119)
		_tools.Autofarm.Frequency = p119 / 10
	end
})
v107:AddDropdown("Autofarmoptions", {
	Values = {
		"Tree",
		"Brimstone Ore",
		"Stone Ore",
		"Iron Ore",
		"Cloth"
	},
	Default = 1,
	Multi = true,
	Text = "Whitelist",
	Tooltip = "Whitelists things that can be farmed",
	Callback = function(_)
	end
})

local u127 = loadstring(game:HttpGet("https://github.com/hvh-boss/Lone-Survival/raw/refs/heads/main/id.lua"))()

local function u128(p121)
	local Contents = require(game:GetService("ReplicatedStorage").Modules.Client.Inventory.Inventory).MyInventory.Contents
	local t10 = {}
	local n22 = 0

	for k, v in pairs(Contents) do
		for _, v2 in pairs(v) do
			if v2 == p121 then
				t10[k] = k
				n22 = v.Quantity
			end
		end
	end

	return t10, uid, n22
end

function max_craft(p122, p123)
	local huge = math.huge

	for k, v in pairs(p123) do
		local v452 = p122[k] or 0
		local v453 = math.floor(v452 / v)

		if v453 < huge then
			huge = v453
		end
	end

	return huge
end

local function u129(p124)
	local t11 = {
		"Drop Item",
		false,
		game.Players.LocalPlayer:GetAttribute("InventoryId"),
		tostring(p124),
		false,
		false,
		CFrame.new(2534.936767578125, 19.476598739624023, -2651.9931640625, -0.3713858127593994, 0.719866156578064, -0.5864003300666809, -5.646684542170988E-08, 0.6315711140632629, 0.7753180265426636, 0.9284786581993103, 0.28794217109680176, -0.23455652594566345),
		35,
		26
	}

	game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("RemoteEvent"):FireServer(unpack(t11))
end
local function u130(p125)
	local v457, _ = u128(p125)

	for _, v in pairs(v457) do
		local t12 = {
			"Drop Item",
			false,
			game.Players.LocalPlayer:GetAttribute("InventoryId"),
			tostring(v),
			false,
			false,
			CFrame.new(2534.936767578125, 19.476598739624023, -2651.9931640625, -0.3713858127593994, 0.719866156578064, -0.5864003300666809, -5.646684542170988E-08, 0.6315711140632629, 0.7753180265426636, 0.9284786581993103, 0.28794217109680176, -0.23455652594566345),
			35,
			26
		}

		game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("RemoteEvent"):FireServer(unpack(t12))
	end
end
local function u131(p126, p127, p128, p129)
	local v466, _ = u128(p126)
	local str2 = tostring(math.random(p127, p128))

	for _, v in pairs(v466) do
		local t13 = {
			"Move Item",
			false,
			{
				FromContainerId = game.Players.LocalPlayer:GetAttribute("InventoryId"),
				FromSlot = tostring(v),
				SplitAmount = p129,
				ToSlot = str2,
				ToContainerId = game.Players.LocalPlayer:GetAttribute("InventoryId")
			},
			CFrame.new(-1521.513916015625, 98.92546844482422, -529.195068359375, -0.30212387442588806, -0.3019603490829468, 0.9041798114776611, 0, 0.9485046863555908, 0.31676313281059265, -0.9532686471939087, 0.09570170193910599, -0.2865659296512604),
			48,
			6
		}

		game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("RemoteEvent"):FireServer(unpack(t13))
	end
end

function craft_item(p130, p131, p132, p133, p134)
	local Item = u127[p130].Item

	for _ = 1, p131 do
		local t14 = {
			"Reserve Craft",
			false,
			tostring(Item),
			p132
		}
		local u481 = game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("RemoteFunction"):InvokeServer(unpack(t14))

		if not p133 then
			local t15 = {
				"Remove Craft",
				false,
				u481,
				15,
				18
			}

			game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("RemoteEvent"):FireServer(unpack(t15))
		else
			task.spawn(function()
				task.wait(p134)

				local t16 = {
					"Craft - Item Processed",
					false,
					u481,
					12,
					18
				}

				game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("RemoteEvent"):FireServer(unpack(t16))
			end)
		end
	end
end

local function u132(p135, p136)
	local _ = u127[p135].Item
	local t17 = {}
	local t18 = {}
	local t19 = {}

	for k, v in pairs(u127[p135].Recipes) do
		t17[k] = k
		u131(tostring(v), 60 + k, 60 + k, 1 / 0)

		local _, _, v493 = u128(tostring(v))

		t18[tostring(v)] = v493
		t19[tostring(v)] = u127[p135].Required
	end

	local v494 = max_craft(t18, t19)

	print(v494)
	task.wait(0.5)

	for _ = 1, p136 do
		craft_item(p135, 1, v494, u127[p135].c, u127[p135].w)
		u130(p135)
	end

	task.wait(0.5)

	for i = 1, 10 do
		if t17[i] then
			task.wait(1)
			u129(60 + i)
		end
	end
end

local n23 = 10
local s11 = "Wood"

v108:AddButton({
	Text = "Spawn item",
	Func = function()
		u132(s11, n23)
	end,
	DoubleClick = false,
	Tooltip = "Spawns item using spawn type"
})
v108:AddInput("ITEMTOSPAWNS", {
	Default = "Wood",
	Numeric = false,
	Finished = false,
	Text = "Item name",
	Tooltip = "Item to spawn",
	Placeholder = "Wood",
	Callback = function(p137)
		s11 = p137
	end
})
v108:AddSlider("SpawnIteration", {
	Text = "Iteration",
	Default = 10,
	Min = 1,
	Max = 100,
	Rounding = 0,
	Compact = false,
	Callback = function(p138)
		n23 = p138
	end
})

local s12 = "Tree"
local n24 = 6
local n25 = 10
local n26 = 5000

local function u139(p139)
	local v500 = _Utilities.GetPlayerPrimary(u92.Name)

	if not v500 then
		return
	end

	local PartBoundsInBox = _workspace:GetPartBoundsInBox(v500.CFrame, Vector3.new(n26, 1000, n26), nil)
	local v502 = nil
	local huge = math.huge

	for _, v in pairs(PartBoundsInBox) do
		if v.Parent.Name:match(p139) and v.Name ~= "Marker" and v.Parent:GetAttribute("YieldLeft") and v.Parent:GetAttribute("YieldLeft") > 500 then
			local v506 = v500.Position - v.Position
			local v507 = v506.X ^ 2 + v506.Y ^ 2 + v506.Z ^ 2

			if v507 < huge then
				huge = v507
				v502 = v
			end
		end
	end

	return v502, huge
end
local function u140(p140, p141)
	getgenv().enabled = p141

	local v510 = _Utilities.GetPlayerPrimary(u92.Name)

	if v510 then
		local CFrame2 = v510.CFrame

		while getgenv().enabled do
			local v512, _ = u139(p140)

			v510.CFrame = v512.CFrame

			for _ = 1, n25 do
				local t20 = {
					"Melee Hit",
					false,
					v512,
					CFrame.new(-2326.426025390625, 87.04510498046875, 499.3544921875, -0.746397852897644, 0.01643068715929985, 0.6652970910072327, -9.313225746154785E-10, 0.9996951818466187, -0.024689236655831337, -0.6654999852180481, -0.01842799410223961, -0.7461703419685364),
					Enum.Material.Wood,
					n24,
					false,
					v512.Parent,
					nil,
					[10] = false,
					[11] = 43,
					[12] = 30,
					[13] = 17,
					[14] = 7,
					[15] = 3,
					[16] = 25,
					[17] = 21,
					[18] = 12,
					[19] = 49,
					[20] = 36,
					[21] = 15,
					[22] = 50,
					[23] = 45,
					[24] = 41,
					[25] = 26,
					[26] = 26,
					[27] = 46,
					[28] = 29,
					[29] = 25,
					[30] = 45,
					[31] = 46,
					[32] = 34,
					[33] = 43,
					[34] = 32,
					[35] = 40,
					[36] = 46,
					[37] = 41,
					[38] = 12,
					[39] = 41,
					[40] = 1,
					[41] = 21,
					[42] = 7,
					[43] = 40,
					[44] = 6,
					[45] = 8
				}

				game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("RemoteEvent"):FireServer(unpack(t20))
				task.wait()
			end
		end

		v510.CFrame = CFrame2

		return
	end
end

v109:AddToggle("Enabledd", {
	Text = "Enabled",
	Default = false,
	Tooltip = "Enables the autofarm",
	Callback = function(p142)
		u140(s12, p142)
	end
})
v109:AddDropdown("AutofarmDropdown", {
	Values = {
		"Tree",
		"Stone",
		"Iron",
		"Brimstone"
	},
	Default = 1,
	Multi = false,
	Text = "Type",
	Tooltip = "Type of resources to farm",
	Callback = function(p143)
		s12 = p143
	end
})
v109:AddSlider("SlotS", {
	Text = "Slot",
	Default = 6,
	Min = 1,
	Max = 6,
	Rounding = 0,
	Compact = false,
	Callback = function(p144)
		n24 = p144
	end
})
v109:AddSlider("DelayZ", {
	Text = "Delay",
	Default = 10,
	Min = 1,
	Max = 100,
	Rounding = 10,
	Compact = false,
	Callback = function(p145)
		n25 = p145
	end
})
v109:AddSlider("ScanSize", {
	Text = "Scan size",
	Default = 5000,
	Min = 1,
	Max = 50000,
	Rounding = 10,
	Compact = false,
	Callback = function(p146)
		n26 = p146
	end
})
v110:AddToggle("AutoBhop", {
	Text = "Enabled",
	Default = false,
	Tooltip = "Enables bunny hop",
	Callback = function(p147)
		_Settings.Movement.Bhop.Enabled = p147
	end
})
v110:AddSlider("BhopDelay", {
	Text = "Bunnyhop delay",
	Default = 0,
	Min = 0,
	Max = 200,
	Rounding = 1,
	Compact = false,
	Callback = function(p148)
		_Settings.Movement.Bhop.AutobhopDelay = p148
	end
})
v110:AddSlider("BhopSpeed", {
	Text = "Strafe speed",
	Default = 10,
	Min = 0,
	Max = 1000,
	Rounding = 1,
	Compact = false,
	Callback = function(p149)
		_Settings.Movement.Bhop.Value = p149
	end
})
v110:AddLabel("Walk speed")
v110:AddToggle("WalkSpeedEnabled", {
	Text = "Enabled",
	Default = false,
	Tooltip = "Enables walkspeed",
	Callback = function(p150)
		_Settings.Movement.WalkSpeed.Enabled = p150
	end
})
v110:AddSlider("WalkSpeedSpeed", {
	Text = "Walk speed",
	Default = 17,
	Min = 0,
	Max = 200,
	Rounding = 1,
	Compact = false,
	Callback = function(p151)
		_Settings.Movement.WalkSpeed.Value = p151
	end
})
v110:AddLabel("Jump Jower")
v110:AddToggle("JumpPowerEnabled", {
	Text = "Enabled",
	Default = false,
	Tooltip = "Enables Jumppower",
	Callback = function(p152)
		_Settings.Movement.JumpPower.Enabled = p152
	end
})
v110:AddSlider("JumpPowrPower", {
	Text = "Jump Power",
	Default = 50,
	Min = 0,
	Max = 200,
	Rounding = 1,
	Compact = false,
	Callback = function(p153)
		_Settings.Movement.JumpPower.Value = p153
	end
})
v111:AddToggle("AntiAimEnabled", {
	Text = "Enabled",
	Default = false,
	Tooltip = "Enables anti aim",
	Callback = function(p154)
		_Settings.Movement.AntiAim.Enabled = p154
	end
})
v111:AddDropdown("AntiAimYaw", {
	Values = {
		"Jitter",
		"Spin",
		"Backward",
		"Target",
		"Freeze"
	},
	Default = 1,
	Multi = false,
	Text = "Yaw",
	Tooltip = "The yaw of anti aim",
	Callback = function(p155)
		_Settings.Movement.AntiAim.Type = p155
	end
})
v111:AddSlider("AntiAimYawOffset", {
	Text = "Yaw Offset",
	Default = 180,
	Min = 0,
	Max = 360,
	Rounding = 1,
	Compact = false,
	Callback = function(p156)
		_Settings.Movement.AntiAim.Yaw = p156
	end
})
v112:AddToggle("TextEnabled", {
	Text = "Enabled",
	Default = false,
	Tooltip = "Enables text esp",
	Callback = function(p157)
		_Settings.Visuals.Text.Enabled = p157
	end
})
v112:AddToggle("TextOutline", {
	Text = "Outline",
	Default = false,
	Tooltip = "Displays outline",
	Callback = function(p158)
		_Settings.Visuals.Text.Outline = p158
	end
})
v112:AddToggle("TextName", {
	Text = "Display name",
	Default = false,
	Tooltip = "Displays name",
	Callback = function(p159)
		_Settings.Visuals.Text.Name = p159
	end
})
v112:AddToggle("TextHealth", {
	Text = "Display health",
	Default = false,
	Tooltip = "Displays health",
	Callback = function(p160)
		_Settings.Visuals.Text.Health = p160
	end
})
v112:AddToggle("TextDistance", {
	Text = "Display distance",
	Default = false,
	Tooltip = "Displays distance",
	Callback = function(p161)
		_Settings.Visuals.Text.Distance = p161
	end
})
v112:AddSlider("TextOffset", {
	Text = "Offset: ",
	Default = 15,
	Min = 1,
	Max = 50,
	Rounding = 1,
	Compact = false,
	Callback = function(p162)
		_Settings.Visuals.Text.Offset = p162
	end
})
v112:AddLabel("Text Color"):AddColorPicker("tTextColor", {
	Default = Color3.fromRGB(255, 255, 255),
	Title = "Text Color",
	Transparency = 0,
	Callback = function(p163)
		_Settings.Visuals.Text.TextColor = p163
	end
})
v112:AddSlider("TextTransparency", {
	Text = "Transparency: ",
	Default = 8,
	Min = 1,
	Max = 10,
	Rounding = 1,
	Compact = false,
	Callback = function(p164)
		_Settings.Visuals.Text.Transparency = p164 / 10
	end
})
v112:AddSlider("TextSize", {
	Text = "Text size: ",
	Default = 30,
	Min = 1,
	Max = 50,
	Rounding = 1,
	Compact = false,
	Callback = function(p165)
		_Settings.Visuals.Text.TextSize = p165
	end
})
v114:AddToggle("ChamsEspEnabled", {
	Text = "Enabled",
	Default = false,
	Tooltip = "Displays chams",
	Callback = function(p166)
		_Settings.Visuals.Chams.Enabled = p166
	end
}):AddColorPicker("Chams color", {
	Default = Color3.fromRGB(255, 255, 255),
	Title = "Chams color",
	Transparency = 0,
	Callback = function(p167)
		_Settings.Visuals.Chams.Color = p167

		local v542 = _Utilities.GetPlayers()

		for _, v in pairs(v542) do
			_Utilities.UpdateChams(v)
		end
	end
})
v114:AddSlider("ChamsTransparency", {
	Text = "Transparency: ",
	Default = 7,
	Min = 1,
	Max = 10,
	Rounding = 1,
	Compact = false,
	Callback = function(p168)
		_Settings.Visuals.Chams.Transparency = p168 / 10

		local v546 = _Utilities.GetPlayers()

		for _, v in pairs(v546) do
			_Utilities.UpdateChams(v)
		end
	end
})
v114:AddLabel("Bullet tracer")
v114:AddToggle("BulletTracer", {
	Text = "Enabled",
	Default = false,
	Tooltip = "Visualize bullet tracer",
	Callback = function(p169)
		_Settings.Visuals.Client.Bullet.Enabled = p169
	end
}):AddColorPicker("BulletColor", {
	Default = Color3.new(0, 0, 1),
	Title = "Bullet Color",
	Transparency = 0,
	Callback = function(p170)
		_Settings.Visuals.Client.Bullet.Color = p170
	end
})
v114:AddDropdown("MyDropdown", {
	Values = {
		"2d",
		"3d"
	},
	Default = 1,
	Multi = false,
	Text = "Bullet type",
	Tooltip = "The bullet tracer type: (3d: physical, 2d: drawing library)",
	Callback = function(p171)
		_Settings.Visuals.Client.Bullet.Type = p171
	end
})
v114:AddSlider("BulletLifetime", {
	Text = "Lifetime",
	Default = 0.5,
	Min = 0,
	Max = 10,
	Rounding = 1,
	Compact = false,
	Callback = function(p172)
		_Settings.Visuals.Client.Bullet.Lifetime = p172
	end
})
v114:AddSlider("BulletTransparency", {
	Text = "Transparency",
	Default = 0.7,
	Min = 0,
	Max = 1,
	Rounding = 1,
	Compact = false,
	Callback = function(p173)
		_Settings.Visuals.Client.Bullet.Transparency = p173
	end
})
v113:AddToggle("TracerEnabled", {
	Text = "Enabled",
	Default = false,
	Tooltip = "Enables tracer",
	Callback = function(p174)
		_Settings.Visuals.Line.Enabled = p174
	end
}):AddColorPicker("Tracer color", {
	Default = Color3.new(1, 1, 1),
	Title = "Line color",
	Transparency = 0,
	Callback = function(p175)
		_Settings.Visuals.Line.Color = p175
	end
})
v113:AddDropdown("TracerOption", {
	Values = {
		"Top",
		"Mouse",
		"Bottom"
	},
	Default = 1,
	Multi = false,
	Text = "Tracer offset",
	Tooltip = "Selects an offset",
	Callback = function(p176)
		_Settings.Visuals.Line.StartFrom = p176
	end
})
v113:AddSlider("TracerTransparency", {
	Text = "Transparency",
	Default = 6,
	Min = 1,
	Max = 10,
	Rounding = 1,
	Compact = false,
	Callback = function(p177)
		_Settings.Visuals.Line.Transparency = p177 / 10
	end
})
v113:AddSlider("TracerThickness", {
	Text = "Thickness",
	Default = 1,
	Min = 1,
	Max = 5,
	Rounding = 1,
	Compact = false,
	Callback = function(p178)
		_Settings.Visuals.Line.Thickness = p178
	end
})
v116:AddLabel("Ambient")
v116:AddToggle("AmbientEnabled", {
	Text = "Enabled",
	Default = false,
	Tooltip = "Enables ambient",
	Callback = function(p179)
		_Settings.Visuals.World.Ambient.Enabled = p179
	end
})
v116:AddLabel("Ambient color"):AddColorPicker("AmbientColor", {
	Default = Color3.new(1, 1, 1),
	Title = "Ambient color",
	Transparency = 0,
	Callback = function(p180)
		_Settings.Visuals.World.Ambient.Color = p180
	end
})
v116:AddLabel("Outdoor Ambient")
v116:AddToggle("OutdoorAmbientEnabled", {
	Text = "Enabled",
	Default = false,
	Tooltip = "Enables ambient",
	Callback = function(p181)
		_Settings.Visuals.World.OutdoorAmbient.Enabled = p181
	end
}):AddColorPicker("OutdoorAmbientColor", {
	Default = Color3.new(1, 1, 1),
	Title = "Outdoor ambient color",
	Transparency = 0,
	Callback = function(p182)
		_Settings.Visuals.World.OutdoorAmbient.Color = p182
	end
})
v116:AddLabel("Colorshift - Top")
v116:AddToggle("ColorshiftTopEnabled", {
	Text = "Enabled",
	Default = false,
	Tooltip = "Enables ambient",
	Callback = function(p183)
		_Settings.Visuals.World.ColorShift_Top.Enabled = p183
	end
}):AddColorPicker("ColorshiftTopColor", {
	Default = Color3.new(1, 1, 1),
	Title = "Colorshift top color",
	Transparency = 0,
	Callback = function(p184)
		_Settings.Visuals.World.ColorShift_Top.Color = p184
	end
})
v116:AddLabel("Colorshift - Bottom")
v116:AddToggle("ColorshiftbottomEnabled", {
	Text = "Enabled",
	Default = false,
	Tooltip = "Enables Colorshift",
	Callback = function(p185)
		_Settings.Visuals.World.ColorShift_Bottom.Enabled = p185
	end
}):AddColorPicker("ColorshiftBotColor", {
	Default = Color3.new(1, 1, 1),
	Title = "Colorshift bottom color",
	Transparency = 0,
	Callback = function(p186)
		_Settings.Visuals.World.ColorShift_Bottom.Color = p186
	end
})
v117:AddLabel("Field Of View")
v117:AddToggle("FieldOfViewEnabled", {
	Text = "Enabled",
	Default = false,
	Tooltip = "Enables field of view",
	Callback = function(p187)
		_Settings.Visuals.Client.FieldOfView.Enabled = p187
	end
})
v117:AddSlider("FieldOfViewValue", {
	Text = "Value",
	Default = 90,
	Min = 0,
	Max = 120,
	Rounding = 1,
	Compact = false,
	Callback = function(p188)
		_Settings.Visuals.Client.FieldOfView.Value = p188
	end
})
v117:AddLabel("Arm viewmodel modifier")
v117:AddToggle("ViewmodelEnabled", {
	Text = "Enabled",
	Default = false,
	Tooltip = "Enables arm viewmodel customizer",
	Callback = function(p189)
		_Settings.Visuals.Viewmodel.Enabled = p189
	end
}):AddColorPicker("Viewmodel color", {
	Default = Color3.new(0, 0, 1),
	Title = "Arm color",
	Transparency = 0,
	Callback = function(p190)
		_Settings.Visuals.Viewmodel.Color = p190
	end
})
v117:AddLabel("Size offset")
v117:AddToggle("ViewmodelEnabledddd", {
	Text = "Enabled",
	Default = true,
	Tooltip = "Enables viewmodel size offset",
	Callback = function(p191)
		_Settings.Visuals.Viewmodel.SizeEnabled = p191
	end
})
v117:AddSlider("ViewmodelSizeee", {
	Text = "Viewmodel size (divided by 100)",
	Default = 25,
	Min = 0,
	Max = 100,
	Rounding = 1,
	Compact = false,
	Callback = function(p192)
		_Settings.Visuals.Viewmodel.Size = p192 / 100
	end
})
v117:AddDropdown("ViewmodelMaterial", {
	Values = {
		"ForceField",
		"Plastic",
		"Glass",
		"Neon"
	},
	Default = 1,
	Multi = false,
	Text = "Arm Material",
	Tooltip = "Viewmodel material type",
	Callback = function(p193)
		_Settings.Visuals.Viewmodel.Material = Enum.Material[p193]
	end
})
v117:AddSlider("ViewmodelTransparency", {
	Text = "Arm Transparency",
	Default = 5,
	Min = 1,
	Max = 10,
	Rounding = 1,
	Compact = false,
	Callback = function(p194)
		_Settings.Visuals.Viewmodel.Transparency = p194 / 10
	end
})
v117:AddLabel("Tool viewmodel modifier")
v117:AddToggle("ViewmodelEnabledd", {
	Text = "Enabled",
	Default = false,
	Tooltip = "Enables tool viewmodel customizer",
	Callback = function(p195)
		_Settings.Visuals.Viewmodel.Tools.Enabled = p195
	end
}):AddColorPicker("Viewmodel colorr", {
	Default = Color3.new(0, 0, 1),
	Title = "Tool color",
	Transparency = 0,
	Callback = function(p196)
		_Settings.Visuals.Viewmodel.Tools.Color = p196
	end
})
v117:AddDropdown("ViewmodelMateriall", {
	Values = {
		"ForceField",
		"Plastic",
		"Glass",
		"Neon"
	},
	Default = 4,
	Multi = false,
	Text = "Arm Material",
	Tooltip = "Viewmodel material type",
	Callback = function(p197)
		_Settings.Visuals.Viewmodel.Tools.Material = Enum.Material[p197]
	end
})
v117:AddSlider("ViewmodelTransparency", {
	Text = "Tool Transparency",
	Default = 5,
	Min = 1,
	Max = 10,
	Rounding = 1,
	Compact = false,
	Callback = function(p198)
		_Settings.Visuals.Viewmodel.Tools.Transparency = p198 / 10
	end
})

local u141 = _Utilities.GetHumanoid(_Utilities.GetLocalPlayer().Name)
local n27 = 0
local u143 = true
local timestamp2 = tick()

if u141 then
	u143 = true
	n27 = u141.Health
	timestamp2 = tick()
	u141.HealthChanged:Connect(function(p199)
		if not u143 and tick() - timestamp2 > 1.3 then
			_Utilities.log("RESOLVING", "Resolved frozen variable!", "CLIENT")
			timestamp2 = tick()
			u143 = true
		end

		if p199 < n27 then
			local v580 = n27 - p199

			_Utilities.log("RESOLVING", "Attempting to resolve health: " .. tostring(v580), "SERVER")

			if _tools.Godmode.Enabled and u143 and u141.Health ~= 0 then
				u143 = false

				local t21 = {
					"Drown Tick",
					false,
					-(u141.MaxHealth - u141.Health) / 5,
					nil
				}

				game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("RemoteEvent"):FireServer(unpack(t21))
			end
		elseif p199 > n27 then
			timestamp2 = tick()
			u143 = true
			_Utilities.log("RESOLVED", "Successfully resolved health!", "SERVER")
		end

		n27 = p199
	end)
end

_Utilities.GetLocalPlayer().CharacterAdded:Connect(function(character)
	local Humanoid = character:WaitForChild("Humanoid", 20)

	if character:FindFirstChild("Humanoid") then
		n27 = 0
		u143 = true
		n27 = Humanoid.Health
		timestamp2 = tick()
		Humanoid.HealthChanged:Connect(function(p200)
			if not u143 and tick() - timestamp2 > 1.3 then
				_Utilities.log("RESOLVING", "Resolved frozen variable!", "CLIENT")
				timestamp2 = tick()
				u143 = true
			end

			if p200 < n27 then
				local v748 = n27 - p200

				_Utilities.log("RESOLVING", "Attempting to resolve health: " .. tostring(v748), "SERVER")

				if _tools.Godmode.Enabled and u143 and Humanoid.Health ~= 0 then
					local t22 = {
						"Drown Tick",
						false,
						-(Humanoid.MaxHealth - Humanoid.Health) / 5,
						nil
					}

					game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("RemoteEvent"):FireServer(unpack(t22))
					u143 = false
				end
			elseif p200 >= n27 then
				timestamp2 = tick()
				u143 = true
				_Utilities.log("RESOLVED", "Successfully resolved health!", "SERVER")
			end

			n27 = p200
		end)
	end
end)

local cFrame = CFrame.new(0, 0, 0)
local u146 = _workspace

_Utilities.Connections.CamChildAdded = CurrentCamera.ChildAdded:Connect(function(child)
	if (child.Name ~= "Model" or child.Name ~= "Viewmodel") and child.PrimaryPart then
		u146 = child

		if u146:FindFirstChildWhichIsA("MeshPart") then
			cFrame = u146:FindFirstChildWhichIsA("MeshPart").CFrame
		end
	end
end)

local u147 = nil
local u148 = nil

_Utilities.Connections.CamDescendantAdded = CurrentCamera.DescendantAdded:Connect(function(descendant)
	if descendant:IsA("Model") and descendant.Name == "Viewmodel" then
		u147 = descendant

		if _Settings.Visuals.Viewmodel.SizeEnabled then
			descendant:ScaleTo(_Settings.Visuals.Viewmodel.Size)
		end
	end

	if u147 and descendant:IsDescendantOf(u147) then
		if descendant:IsA("Model") then
			u148 = descendant
		end

		if (descendant:IsA("BasePart") or descendant:IsA("MeshPart")) and _Settings.Visuals.Viewmodel.Enabled and descendant.Transparency ~= 1 then
			descendant.Color = _Settings.Visuals.Viewmodel.Color
			descendant.Transparency = _Settings.Visuals.Viewmodel.Transparency
			descendant.Material = _Settings.Visuals.Viewmodel.Material
		end
	end

	if u148 and descendant:IsDescendantOf(u148) and _Settings.Visuals.Viewmodel.Tools.Enabled then
		if not descendant:IsA("MeshPart") and (not descendant:IsA("BasePart") or descendant.Transparency == 1) then
			if descendant:IsA("SurfaceAppearance") then
				descendant:Destroy()
			end
		else
			descendant.Color = _Settings.Visuals.Viewmodel.Tools.Color
			descendant.Transparency = _Settings.Visuals.Viewmodel.Tools.Transparency
			descendant.Material = _Settings.Visuals.Viewmodel.Tools.Material
		end
	end
end)

local n28 = 60
local n29 = 60
local u151 = false
local u152 = false

_Services.UserInputService.InputBegan:Connect(function(input, p201)
	if not p201 then
		if _tools.Building.Enabled and input.UserInputType == Enum.UserInputType.MouseButton1 then
			local Name = CurrentCamera:FindFirstChild(u146.Name)

			if Name then
				if u146:FindFirstChildWhichIsA("MeshPart") then
					cFrame = u146:FindFirstChildWhichIsA("MeshPart").CFrame
				end

				local t23 = {
					"Place Object",
					false,
					Name.Name,
					"cf",
					nil,
					[7] = false
				}

				game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("RemoteFunction"):InvokeServer(unpack(t23))
			end
		end

		if input.KeyCode ~= Enum.KeyCode.R then
			if input.KeyCode == Enum.KeyCode.T then
				u152 = true
			end
		else
			u151 = true
		end

		return
	end
end)
_Services.UserInputService.InputEnded:Connect(function(input)
	if input.KeyCode == Enum.KeyCode.R then
		u151 = false
	elseif input.KeyCode == Enum.KeyCode.T then
		u152 = false
	end
end)
_Services.Players.PlayerRemoving:Connect(function(player)
	if _Tracer[player.Name] then
		_Tracer[player.Name]:Destroy()
		_Tracer[player.Name] = nil
	end

	if _Text[player.Name] then
		_Text[player.Name]:Destroy()
		_Text[player.Name] = nil
	end
end)
if clone2 and clone3 and clone2:FindFirstChild("HumanoidRootPart") and clone3:FindFirstChild("HumanoidRootPart") and clone3:FindFirstChild("Humanoid") then
	clone2.Name = "so tuff"
	clone2.Parent = _workspace
	clone3.Name = "Visualiziariaroro"
	clone3.Humanoid.PlatformStand = true
	clone3.HumanoidRootPart.Anchored = true
	clone2.HumanoidRootPart.Anchored = true
	clone2.HumanoidRootPart.CanCollide = false
else
	clone2 = nil
	clone3 = nil
	warn("[ASTRALGUARD] - clone visuals unavailable; skipping clone setup")
end

for _, v in pairs(CurrentCamera:GetDescendants()) do
	if v:IsA("BasePart") or v:IsA("MeshPart") then
		v.CanQuery = false
	end
end

if clone2 then
	for _, v in pairs(clone2:GetChildren()) do
		if v.Name ~= "HumanoidRootPart" and v.Name ~= "Humanoid" then
			v:Destroy()
		end
	end
end

if clone3 then
	for _, v in pairs(clone3:GetChildren()) do
		if v:IsA("BasePart") or v:IsA("MeshPart") or v:IsA("Humanoid") then
			if v:IsA("BasePart") or v:IsA("MeshPart") then
				v.CanCollide = false
			end
		else
			v:Destroy()
		end
	end
end

_Utilities.Connections.LegitBot = _Services.RunService.RenderStepped:Connect(function()
	local v592 = u92
	local Mouse = v592:GetMouse()

	drawing.Position = Vector2.new(Mouse.X, Mouse.Y + 60)
	drawing.Radius = _Settings.LegitBot.Fov
	drawing.Visible = _Settings.LegitBot.FieldOfView

	if not _Settings.LegitBot.Enabled then
		drawing2.Visible = false
	end

	local v594 = _Utilities.ClosestToMouseRadius(_Settings.LegitBot.Teamcheck, _Settings.LegitBot.Wallcheck, _Settings.LegitBot.Fov)

	if not v594 then
		drawing2.Visible = false
	else
		getgenv().ClosestToMousePlayer = v594

		local _SettingsLegitBotHitbox = _Utilities.GetCharacter(v594.Name):FindFirstChild(_Settings.LegitBot.Hitbox)

		if _SettingsLegitBotHitbox then
			getgenv().ClosestToMousePlayerHitbox = _SettingsLegitBotHitbox

			local v596, v597 = _Utilities.WorldToScreen(_SettingsLegitBotHitbox.Position)

			if v597 then
				drawing2.Visible = true
				drawing2.from = Vector2.new(Mouse.X, Mouse.Y + 55)
				drawing2.to = v596
			else
				drawing2.Visible = false
			end

			if Options.LegitbotKeybind:GetState() then
				if _Settings.LegitBot.Type == "Lock" then
					_Utilities.SetCamPos(_SettingsLegitBotHitbox.Position, _Settings.LegitBot.Smoothness)
				elseif _Settings.LegitBot.Type == "Silent" then
				end
			end
		else
			drawing2.Visible = false
		end
	end

	if _Hitbox.Enabled then
		local playerFolder = _workspace:FindFirstChild("Players")

		if playerFolder then
			for _, v in pairs(playerFolder:GetChildren()) do
				if v.Name ~= _Utilities.GetLocalPlayer().Name and v:FindFirstChild(_Hitbox.Hitbox) then
					v:FindFirstChild(_Hitbox.Hitbox).Transparency = 0.5
					v:FindFirstChild(_Hitbox.Hitbox).Size = Vector3.new(_Hitbox.Size, _Hitbox.Size, _Hitbox.Size)
					v:FindFirstChild(_Hitbox.Hitbox).CanCollide = false
				end
			end
		end
	end

	if t7.Reload.Enabled then
		local v600 = _Utilities.GetSelectedItem()

		if v600 then
			local t24 = {
				"Weapon Reload",
				false,
				tonumber(v600.Name),
				"\255\255\255\255",
				17,
				31,
				47,
				15,
				2,
				36,
				27,
				33,
				13,
				31,
				11,
				20,
				19,
				15,
				46,
				27,
				19,
				10,
				9,
				1,
				12,
				36,
				37,
				36,
				32,
				3,
				4,
				26,
				12,
				5,
				8,
				2
			}

			game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("RemoteEvent"):FireServer(unpack(t24))
		end
	end

	if clone2 and clone2:FindFirstChild("HumanoidRootPart") then
		if not _Settings.LegitBot.Enabled or _Settings.LegitBot.Type ~= "Silent" then
			clone2.HumanoidRootPart.Size = Vector3.new(0, 0, 0)
		else

			local HumanoidRootPart = clone2.HumanoidRootPart
			local CurrentCameraCFrame = CurrentCamera.CFrame

			HumanoidRootPart.Size = Vector3.new(50, 50, 3)
			HumanoidRootPart.Anchored = true

			local v604 = CurrentCameraCFrame.LookVector * 8

			HumanoidRootPart.CFrame = CFrame.new(CurrentCameraCFrame.Position + v604, CurrentCameraCFrame.Position + v604 + CurrentCameraCFrame.LookVector)
		end
	end

	local v605 = _Utilities.GetPlayerPrimary(v592.Name)

	if u123 then
		if not v605 or not clone3 or not clone3:FindFirstChild("HumanoidRootPart") then
			return
		end

		local v606 = v605.CFrame.LookVector * n8
		local v607 = v605.CFrame + v606

		vector3 = v607
		clone3.HumanoidRootPart.CFrame = v607
	elseif v605 and clone3 and clone3:FindFirstChild("HumanoidRootPart") then
		local v608 = v605.CFrame.LookVector * 10000
		local v609 = v605.CFrame + v608

		vector3 = v609
		clone3.HumanoidRootPart.CFrame = v609
	end
end)

local t25 = {
	Ambient = _Services.Lighting.Ambient,
	OutdoorAmbient = _Services.Lighting.Ambient,
	Colorshift_Top = _Services.Lighting.ColorShift_Top,
	Colorshift_Bottom = _Services.Lighting.ColorShift_Bottom,
	FieldOfView = CurrentCamera.FieldOfView
}

_Utilities.Connections.Visuals = _Services.RunService.RenderStepped:Connect(function(dt)
	local v611 = _Utilities.GetPlayers()

	for _, v in pairs(v611) do
		if v ~= u92 then
			if not _Settings.Visuals.Chams.Enabled then
				if _Chams:FindFirstChild(v.Name) then
					_Chams:FindFirstChild(v.Name):Destroy()
				end
			else
				_Utilities.UpdateChams(v)
			end

			_Utilities.UpdateText(v)
			_Utilities.UpdateTracer(v)
		end
	end

	if _Settings.Visuals.Client.FieldOfView.Enabled then
		CurrentCamera.FieldOfView = _Settings.Visuals.Client.FieldOfView.Value
	elseif CurrentCamera.FieldOfView ~= t25.FieldOfView then
		CurrentCamera.FieldOfView = t25.FieldOfView
	end

	if _Settings.Visuals.World.Ambient.Enabled then
		_Services.Lighting.Ambient = _Settings.Visuals.World.Ambient.Color
	else
		_Services.Lighting.Ambient = t25.Ambient
	end

	if not _Settings.Visuals.World.OutdoorAmbient.Enabled then
		_Services.Lighting.OutdoorAmbient = t25.OutdoorAmbient
	else
		_Services.Lighting.OutdoorAmbient = _Settings.Visuals.World.OutdoorAmbient.Color
	end

	if not _Settings.Visuals.World.ColorShift_Bottom.Enabled then
		_Services.Lighting.ColorShift_Bottom = t25.Colorshift_Bottom
	else
		_Services.Lighting.ColorShift_Bottom = _Settings.Visuals.World.ColorShift_Bottom.Color
	end

	if _Settings.Visuals.World.ColorShift_Top.Enabled then
		_Services.Lighting.ColorShift_Top = _Settings.Visuals.World.ColorShift_Top.Color
	else
		_Services.Lighting.ColorShift_Top = t25.Colorshift_Top
	end

	if _tools.Building.Enabled and u146 then
		if u151 then
			local PrimaryPart = u146.PrimaryPart

			PrimaryPart.CFrame = PrimaryPart.CFrame * CFrame.Angles(0, math.rad(n28 * dt), 0)
		end

		if u152 then
			local PrimaryPart = u146.PrimaryPart

			PrimaryPart.CFrame = PrimaryPart.CFrame * CFrame.Angles(math.rad(n29 * dt), 0, 0)
		end

		if u146 then
			cFrame = u146.PrimaryPart.CFrame
		end
	end
end)

local timestamp3 = tick()
local UserInputService = _Services.UserInputService

_Utilities.Connections.Movement = _Services.RunService.Heartbeat:Connect(function()
	local v616 = _Utilities.GetCharacter(u92.Name)

	if v616 then
		local v617 = _Utilities.GetHumanoid(u92.Name)

		if v617 then
			local v618 = _Utilities.GetPlayerPrimary(u92.Name)

			if not v618 then
				return
			end

			if _Settings.Movement.Bhop.Enabled and UserInputService:IsKeyDown(Enum.KeyCode.Space) then
				if v616 and v617 and v618 then
					if v618.Velocity.Y < 5 and v617:GetState() ~= Enum.HumanoidStateType.Freefall and tick() - timestamp3 > _Settings.Movement.Bhop.AutobhopDelay then
						timestamp3 = tick()
						v618.Velocity = v618.Velocity + Vector3.new(0, 35, 0)
					end

					local n30 = 0

					if UserInputService:IsKeyDown("A") then
						n30 = 90
					end

					if UserInputService:IsKeyDown("S") then
						n30 = 180
					end

					if UserInputService:IsKeyDown("D") then
						n30 = 270
					end

					if UserInputService:IsKeyDown("A") and UserInputService:IsKeyDown("W") then
						n30 = 45
					end

					if UserInputService:IsKeyDown("D") and UserInputService:IsKeyDown("W") then
						n30 = 315
					end

					if UserInputService:IsKeyDown("D") and UserInputService:IsKeyDown("S") then
						n30 = 225
					end

					if UserInputService:IsKeyDown("A") and UserInputService:IsKeyDown("S") then
						n30 = 145
					end

					local _, v621, _ = CurrentCamera.CFrame:ToOrientation()
					local v623 = CFrame.new(CurrentCamera.CFrame.Position) * CFrame.Angles(0, v621, 0) * CFrame.Angles(0, math.rad(n30), 0)

					v618.CFrame = v618.CFrame + Vector3.new(v623.LookVector.X, 0, v623.LookVector.Z) * _Settings.Movement.Bhop.Value / 50
				end
			end

			if _Settings.Movement.JumpPower.Enabled then
				v617.JumpPower = _Settings.Movement.JumpPower.Value
			end

			if _Settings.Movement.WalkSpeed.Enabled then
				v617.WalkSpeed = _Settings.Movement.WalkSpeed.Value
			end

			if not _Settings.Movement.AntiAim.Enabled then
				if v617.AutoRotate == false then
					v617.AutoRotate = true
				end
			elseif _Settings.Movement.AntiAim.Type == "None" then
				if v617.AutoRotate == false then
					v617.AutoRotate = true
				end
			elseif _Settings.Movement.AntiAim.Type == "Jitter" then
				if v617.AutoRotate == true then
					v617.AutoRotate = false
				end

				v618.CFrame = v618.CFrame * CFrame.Angles(0, math.rad(math.random(0, _Settings.Movement.AntiAim.Yaw)), 0)
			elseif _Settings.Movement.AntiAim.Type ~= "Spin" then
				if _Settings.Movement.AntiAim.Type == "Freeze" then
					if v617.AutoRotate == true then
						v617.AutoRotate = false
					end
				elseif _Settings.Movement.AntiAim.Type ~= "Target" then
					if _Settings.Movement.AntiAim.Type == "Backward" then
						if v617.AutoRotate == true then
							v617.AutoRotate = false
						end

						local CurrentCameraCFrame = CurrentCamera.CFrame
						local vector3_2 = Vector3.new(CurrentCameraCFrame.LookVector.X, 0, CurrentCameraCFrame.LookVector.Z)

						v618.CFrame = CFrame.new(v618.Position, v618.Position + -vector3_2) * CFrame.Angles(0, _Settings.Movement.AntiAim.Yaw, 0)
					end
				else
					if v617.AutoRotate == true then
						v617.AutoRotate = false
					end

					local huge = math.huge
					local vector3_3 = nil

					for _, v in pairs(game:GetService("Players"):GetPlayers()) do
						_Utilities.GetCharacter(v.Name)

						local v630 = _Utilities.GetPlayerPrimary(v.Name)

						if v ~= u92 and v618 and v630 then
							local Magnitude = (v618.Position - v630.Position).Magnitude

							if Magnitude < huge then
								huge = Magnitude

								local Unit = (v618.Position - v630.Position).Unit

								vector3_3 = Vector3.new(-Unit.X, 0, -Unit.Z)
								v618.CFrame = CFrame.new(v618.Position, v618.Position + vector3_3) * CFrame.Angles(0, math.rad(_Settings.Movement.AntiAim.Yaw), 0)
							end
						end
					end

					if vector3_3 ~= nil then
						v618.CFrame = CFrame.new(v618.Position, v618.Position + vector3_3) * CFrame.Angles(0, math.rad(_Settings.Movement.AntiAim.Yaw), 0)
					end
				end
			else
				if v617.AutoRotate == true then
					v617.AutoRotate = false
				end

				v618.CFrame = v618.CFrame * CFrame.Angles(0, math.rad(_Settings.Movement.AntiAim.Yaw), 0)
			end

			return
		end

		return
	end
end)

local timestamp4 = tick()

tick()

local n31 = 0

_Utilities.Connections.Remotes = _Services.RunService.RenderStepped:Connect(function()
	n31 = u92:GetAttribute("LastPing")

	if t6.Enabled then
		local v633 = _Utilities.GetPlayerPrimary(_Utilities.GetLocalPlayer().Name)
		local playerFolder = _workspace:FindFirstChild("Players")

		if v633 and playerFolder then
			local cFrame2 = CFrame.new(v633.Position)
			local vector3_4 = Vector3.new(t6.Range, t6.Range, t6.Range)
			local PartBoundsInBox = _workspace:GetPartBoundsInBox(cFrame2, vector3_4)

			for _, v in pairs(PartBoundsInBox) do
				if not v:IsDescendantOf(v633.Parent) and v:IsDescendantOf(playerFolder) and v.Name == "Head" then
					local t26 = {
						"Melee Hit",
						false,
						v,
						v.CFrame,
						Enum.Material.Plastic,
						5,
						true,
						v.Parent,
						nil,
						[10] = false,
						[11] = 19,
						[12] = 30,
						[13] = 20,
						[14] = 17,
						[15] = 46,
						[16] = 8,
						[17] = 30,
						[18] = 32,
						[19] = 36,
						[20] = 14,
						[21] = 37,
						[22] = 19,
						[23] = 28,
						[24] = 36,
						[25] = 48,
						[26] = 33,
						[27] = 23,
						[28] = 39,
						[29] = 15,
						[30] = 45,
						[31] = 10,
						[32] = 40,
						[33] = 12,
						[34] = 19,
						[35] = 12,
						[36] = 50,
						[37] = 44,
						[38] = 50,
						[39] = 3,
						[40] = 16,
						[41] = 8
					}

					game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("RemoteEvent"):FireServer(unpack(t26))
				end
			end
		end
	end

	if _tools.Autofarm.Enabled and (_tools.Autofarm.Frequency == 1 or tick() - timestamp4 >= _tools.Autofarm.Frequency) then
		timestamp4 = tick()

		local v640 = _Utilities.GetPlayerPrimary(_Utilities.GetLocalPlayer().Name)

		if v640 then
			local cFrame3 = CFrame.new(v640.Position)
			local vector3_5 = Vector3.new(8, 8, 8)
			local PartBoundsInBox = _workspace:GetPartBoundsInBox(cFrame3, vector3_5)

			for _, v in pairs(PartBoundsInBox) do
				if not v.Parent:IsDescendantOf(_workspace.Ignored) then
					for k, _ in pairs(Options.Autofarmoptions.Value) do
						if k == "Cloth" and string.match(v.Parent.Name, k) then
							local t27 = {
								"Pickup Cloth Plant",
								false,
								v.Parent,
								22,
								1,
								nil
							}

							game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("RemoteEvent"):FireServer(unpack(t27))
						end

						if string.match(v.Parent.Name, k) and k ~= "Cloth" then
							local t28 = {
								"Melee Hit",
								false,
								v.Parent.PrimaryPart,
								CFrame.new(2972.951171875, 38.21372985839844, -1657.814208984375, 0.7463709115982056, -0.016416961327195168, -0.665327787399292, 1.862645149230957E-09, 0.9996958374977112, -0.024667484685778618, 0.6655303239822388, 0.018411090597510338, 0.7461437582969666),
								Enum.Material.Wood,
								6,
								false,
								v.Parent,
								nil,
								nil,
								[10] = not string.match(v.Parent.Name, "Ore"),
								[11] = 32,
								[12] = 23,
								[13] = 24,
								[14] = 24,
								[15] = 24,
								[16] = 48
							}

							game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("RemoteEvent"):FireServer(unpack(t28))
						end
					end
				end
			end
		end
	end
end)

local _ = _Services.LogService
local _ = _Services.ContentProvider

getgenv().val = 0 / 0
hookmetamethod(game, "__namecall", u1)

local u166 = nil

u166 = hookmetamethod(game, "__namecall", function(p202, ...)
	local v651 = getnamecallmethod(true)

	if v651 == "GetAttribute" then
		local t29 = { ... }

		getcallingscript()

		if typeof(t29[1]) == "string" and t29[1] == "PlayerSettingsProcessed" then
			_Utilities.log("ANTICHEAT", "Spoofed CLIENT ENV", "CLIENT")

			return true
		end
	end

	if v651 == "InvokeServer" then
		local t30 = { ... }

		if getgenv().bypass_mode == "Manual" then
			for _, v in pairs(t30) do
				if typeof(v) == "buffer" then
					return
				end
			end
		end

		if t30[1] == "Check Player Settings" then
			return
		end

		if t30[1] == str then
			_Utilities.log("SPOOFED", "SUCCESSFULY SPOOFED LONE AC WITH ASTRAL-AC", "CLIENT")

			return
		end

		if _tools.Anticheat.Enabled and tostring(n31) ~= "nan" then
			if t30[1] == "Ping" and not u97.Unloaded then
				_Utilities.log("SPOOFED", "Spoofed SERVER velocity", "SERVER")
				t30[4] = 0 / 0

				return u166(p202, unpack(t30))
			end
		elseif _tools.Anticheat.Enabled and t30[1] == "Ping" and tostring(n31) == "nan" then
			return "Pong"
		end

		if t30[1] == "Place Object" and not u97.Unloaded then
			if not _tools.Building.Enabled then
				if _tools.Building.Unbreakable then
					t30[5] = game.Lighting
				end

				return u166(p202, unpack(t30))
			end

			if t30[8] == "\255\255" and _tools.Building.Unbreakable then
				t30[5] = game.Lighting
			end

			t30[4] = cFrame - Vector3.new(0, _tools.Building.Offset, 0)

			if _tools.Building.Unbreakable then
				t30[5] = game.Lighting
			end

			return u166(p202, unpack(t30))
		end
	end

	if v651 == "FireServer" then
		local t31 = { ... }

		if tostring(p202) == "RemoteEvent" then
			if bypass_mode == "Manual" then
				for _, v in pairs(t31) do
					if typeof(v) == "buffer" then
						return
					end
				end
			end

			if t31[1] == "Check Player Settings" then
				warn("oh yeahh")

				return task.wait(9000000000)
			end

			if t31[1] == str then
				_Utilities.log("SPOOFED", "SUCCESSFULY SPOOFED LONE AC WITH ASTRAL-AC", "CLIENT")

				return
			end

			if t31[1] == "TFD" and not u97.Unloaded then
				return
			end

			if t31[1] == "Simulate Projectile" and _Settings.LegitBot.Enabled and _Settings.LegitBot.Type == "Silent" and not u97.Unloaded and getgenv().ClosestToMousePlayer and getgenv().ClosestToMousePlayerHitbox then
				local Unit = (getgenv().ClosestToMousePlayerHitbox.Position - CurrentCamera.CFrame.Position).Unit
				local _ = CurrentCamera.CFrame.Position + Unit * 10000

				for k, v in pairs(t31) do
					if k ~= "Hit" then
						if typeof(v) == "table" then
							for k2, _ in pairs(v) do
								if k2 == "Hit" then
									v[k2] = getgenv().ClosestToMousePlayerHitbox
								end
							end
						end
					else
						t31[k] = getgenv().ClosestToMousePlayerHitbox
					end
				end

				return u166(p202, unpack(t31))
			end

			if t31[1] == "Create Projectile" then
				if _Settings.LegitBot.Enabled and _Settings.LegitBot.Type == "Silent" and not u97.Unloaded and getgenv().ClosestToMousePlayer and getgenv().ClosestToMousePlayerHitbox then
					local _ = (getgenv().ClosestToMousePlayerHitbox.Position - CurrentCamera.CFrame.Position).Unit
					local v666 = Vector3.new(0, -10000, 0) + _workspace.CurrentCamera.CFrame.Position

					for k, v in pairs(t31) do
						if k == "HitVector" then
							t31[k] = v666
						elseif typeof(v) == "table" then
							for k3, _ in pairs(v) do
								if k3 == "HitVector" then
									v[k3] = v666
								end
							end
						end
					end
				end

				if _Settings.Visuals.Client.Bullet.Enabled and not u97.Unloaded then
					local vector3_6 = Vector3.new(0, 0, 0)

					if _Settings.LegitBot.Enabled and _Settings.LegitBot.Type == "Silent" then
						if getgenv().ClosestToMousePlayer and getgenv().ClosestToMousePlayerHitbox then
							vector3_6 = getgenv().ClosestToMousePlayerHitbox.Position
						end
					else
						for k, v in pairs(t31) do
							if k == "HitVector" then
								vector3_6 = v
							elseif typeof(v) == "table" then
								for k4, v3 in pairs(v) do
									if k4 == "HitVector" then
										vector3_6 = v3
									end
								end
							end
						end
					end

					if vector3_6 and typeof(vector3_6) == "Vector3" then
						if _Settings.Visuals.Client.Bullet.Type == "3d" then
							task.spawn(function()
								local v750 = _Utilities.beam(CurrentCamera.CFrame.p, vector3_6)
								local BulletLifetime = _Settings.Visuals.Client.Bullet.Lifetime

								v750.Transparency = _Settings.Visuals.Client.Bullet.Transparency

								for i = 1, 60 * BulletLifetime do
									wait()
									v750.Transparency = i / (60 * BulletLifetime)
								end

								wait(BulletLifetime)
								v750:Destroy()
							end)
						else
							task.spawn(function()
								local v753 = _Utilities.GetCharacter(_Utilities.GetLocalPlayer().Name)

								if not v753 then
									return
								end

								local Head = v753:FindFirstChild("Head")

								if Head then
									local BulletLifetime = _Settings.Visuals.Client.Bullet.Lifetime
									local drawing4 = Drawing.new("Line")

									drawing4.Visible = true
									drawing4.Color = _Settings.Visuals.Client.Bullet.Color
									drawing4.Thickness = 2
									drawing4.Transparency = _Settings.Visuals.Client.Bullet.Transparency

									local HeadPosition = Head.Position
									local u758 = vector3_6
									local timestamp5 = tick()
									local connection = nil

									connection = _Services.RunService.RenderStepped:Connect(function()
										if tick() - timestamp5 > BulletLifetime then
											drawing4:Remove()
											connection:Disconnect()

											return
										end

										local v761, _ = CurrentCamera:WorldToViewportPoint(HeadPosition)
										local v763, _ = CurrentCamera:WorldToViewportPoint(u758)

										drawing4.From = Vector2.new(v761.X, v761.Y)
										drawing4.To = Vector2.new(v763.X, v763.Y)
									end)

									return
								end
							end)
						end
					end
				end

				return u166(p202, unpack(t31))
			end
		end
	end

	return u166(p202, ...)
end)
u97:SetWatermarkVisibility(true)

local timestamp6 = tick()
local n32 = 0
local n33 = 60
local connection = game:GetService("RunService").RenderStepped:Connect(function()
	n32 = n32 + 1

	if tick() - timestamp6 >= 1 then
		n33 = n32
		timestamp6 = tick()
		n32 = 0
	end

	u97:SetWatermark((s5 .. " | %s fps | %s ms"):format(math.floor(n33), math.floor(game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValue())))
end)

u97.KeybindFrame.Visible = true
u97:OnUnload(function()
	connection:Disconnect()

	for _, v in pairs(_Utilities.Connections) do
		v:Disconnect()
	end

	getgenv().Tools = {}
	getgenv().Settings = {}

	for _, v in pairs(_Utilities.GetPlayers()) do
		if _Tracer[v.Name] then
			_Tracer[v.Name]:Destroy()
			_Tracer[v.Name] = nil
		end

		if _Text[v.Name] then
			_Text[v.Name]:Destroy()
			_Text[v.Name] = nil
		end
	end

	drawing:Destroy()
	drawing2:Destroy()
	u97.Unloaded = true
end)

local v171 = t5["UI Settings"]:AddLeftGroupbox("Menu")

v171:AddButton("Unload", function()
	u97:Unload()
end)
v171:AddLabel("Menu bind"):AddKeyPicker("MenuKeybind", {
	Default = "End",
	NoUI = true,
	Text = "Menu keybind"
})
u97.ToggleKeybind = Options.MenuKeybind
v98:SetLibrary(u97)
v99:SetLibrary(u97)
v99:IgnoreThemeSettings()
v99:SetIgnoreIndexes({ "MenuKeybind" })
v98:SetFolder(s6)
v99:SetFolder(s6 .. "/Saves")
v99:BuildConfigSection(t5["UI Settings"])
v98:ApplyToTab(t5["UI Settings"])
v99:LoadAutoloadConfig()
warn("[ASTRALGUARD] - Loading..")
warn("LOADED! | Took " .. tostring(tick() - timestamp) .. " seconds to fully load")

return
