-- cleansecond.lua
-- Full pretty-named output from obfuscated second.lua.
-- Auth, UI loader links, and settings were reconstructed from bytecode constants plus decompiler output.
-- Remaining body keeps decompiler labels where semantic names cannot be proven safely.
-- Links recovered:
--   https://pastefy.app/uOruVA9d/raw
--   https://raw.githubusercontent.com/ScriptSkiddie69/LinoriaLib/main/
--   https://raw.githubusercontent.com/ScriptSkiddie69/LinoriaLib/main/Library.lua
--   https://raw.githubusercontent.com/ScriptSkiddie69/LinoriaLib/main/addons/ThemeManager.lua
--   https://raw.githubusercontent.com/ScriptSkiddie69/LinoriaLib/main/addons/SaveManager.lua

local RecoveredLinks = {
  "https://pastefy.app/uOruVA9d/raw",
  "https://raw.githubusercontent.com/ScriptSkiddie69/LinoriaLib/main/",
  "https://raw.githubusercontent.com/ScriptSkiddie69/LinoriaLib/main/Library.lua",
  "https://raw.githubusercontent.com/ScriptSkiddie69/LinoriaLib/main/addons/ThemeManager.lua",
  "https://raw.githubusercontent.com/ScriptSkiddie69/LinoriaLib/main/addons/SaveManager.lua",
}

local AuthConfig = getgenv().AuthConfig or {}
-- Auth modes:
--   Disabled: auth is stripped and always passes.
--   StaticKey: reserved for a future external/site key check.
--   LocalToken: old recovered local token/HWID gate, for research only.
AuthConfig.Enabled = false
AuthConfig.Method = AuthConfig.Method or "Disabled"
AuthConfig.Key = AuthConfig.Key or "68686367-6868-709c-96af-6d9c68950000"
AuthConfig.DevKey = AuthConfig.DevKey or AuthConfig.Key
AuthConfig.BypassMode = AuthConfig.BypassMode or "Manual"
AuthConfig.LogOutput = AuthConfig.LogOutput or false
AuthConfig.State = AuthConfig.State or Enum.HumanoidStateType.Jumping
AuthConfig.ExpectedLocalToken = AuthConfig.ExpectedLocalToken or "OTFhZWM2MDA6MTpmZjliMTA0OA=="
getgenv().AuthConfig = AuthConfig

local RemoteSources = getgenv().RemoteSources or {}
RemoteSources.ItemRecipeModule = RemoteSources.ItemRecipeModule or "https://pastefy.app/uOruVA9d/raw"
RemoteSources.UiLibraryBase = RemoteSources.UiLibraryBase or "https://raw.githubusercontent.com/ScriptSkiddie69/LinoriaLib/main/"
RemoteSources.UiLibrary = RemoteSources.UiLibrary or (RemoteSources.UiLibraryBase .. "Library.lua")
RemoteSources.UiThemeManager = RemoteSources.UiThemeManager or (RemoteSources.UiLibraryBase .. "addons/ThemeManager.lua")
RemoteSources.UiSaveManager = RemoteSources.UiSaveManager or (RemoteSources.UiLibraryBase .. "addons/SaveManager.lua")
getgenv().RemoteSources = RemoteSources

local function loadRemoteSource(name)
  local url = assert(RemoteSources[name], "missing RemoteSources." .. tostring(name))
  return loadstring(game:HttpGet(url))()
end

local u1 = nil
local str = nil
local u10 = nil

warn("[ASTRALGUARD] - priv.lua auth patch active")

AuthConfig.ActiveKey = (AuthConfig.Enabled and AuthConfig.Method ~= "Disabled") and AuthConfig.Key or AuthConfig.DevKey

local function setAuthEnv(name, value)
  getgenv()[name] = value
  if type(_G) == "table" then
    _G[name] = value
  end
  if type(shared) == "table" then
    shared[name] = value
  end
end

setAuthEnv("key", AuthConfig.ActiveKey)
setAuthEnv("bypass_mode", AuthConfig.BypassMode)
setAuthEnv("log_output", AuthConfig.LogOutput)
setAuthEnv("state", AuthConfig.State)

--// do not use Automatic unless you know what you are doing, it will cause a lot of errors in the console and may cause some performance issues, use Manual if you want to bypass the anticheat without any errors or performance issues but it may not work on some servers
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
          warn("buffer remote blocked")
          return 5
        end
      end
    end

    return u1(p2, ...)
  end)
end

local UiLibraryLinks = {
  Library = RemoteSources.UiLibrary,
  ThemeManager = RemoteSources.UiThemeManager,
  SaveManager = RemoteSources.UiSaveManager,
}

local function loadUiLibraries()
  local Library = loadRemoteSource("UiLibrary")
  local ThemeManager = loadRemoteSource("UiThemeManager")
  local SaveManager = loadRemoteSource("UiSaveManager")
  return Library, ThemeManager, SaveManager
end

local RecoveredUIControls = {
  { method = "AddToggle", id = "AimbotEnabled", text = "Enabled" },
  { method = "AddKeyPicker", id = "LegitbotKeybind", text = "LegitbotKeybind" },
  { method = "AddDropdown", id = "LegitbotHitbox", text = "LegitbotHitbox" },
  { method = "AddDropdown", id = "LegitbotType", text = "LegitbotType" },
  { method = "AddToggle", id = "LegitBotLine", text = "Enabled" },
  { method = "AddToggle", id = "TriggerbotEnabled", text = "Enabled" },
  { method = "AddToggle", id = "TriggerbotEnabled", text = "TriggerbotEnabled" },
  { method = "AddToggle", id = "HitboxEnabled", text = "Enabled" },
  { method = "AddDropdown", id = "HitboxOptions", text = "HitboxOptions" },
  { method = "AddLabel", id = "Melee aura", text = "Melee aura" },
  { method = "AddToggle", id = "MeleeEnabled", text = "Enabled" },
  { method = "AddToggle", id = "FireRate", text = "Enabled" },
  { method = "AddToggle", id = "ACBypass", text = "ACBypass" },
  { method = "AddButton", id = "Bruteforce building", text = "Bruteforce building" },
  { method = "AddSlider", id = "HopSpeed", text = "Enabled" },
  { method = "AddLabel", id = "Semi noclip", text = "Semi noclip" },
  { method = "AddToggle", id = "SemiNoclips", text = "Enabled" },
  { method = "AddKeyPicker", id = "SemiNoclip", text = "SemiNoclip" },
  { method = "AddLabel", id = "Better noclip", text = "Better noclip" },
  { method = "AddToggle", id = "NoclipBetter", text = "Enabled" },
  { method = "AddKeyPicker", id = "BetterNoclipK", text = "BetterNoclipK" },
  { method = "AddLabel", id = "Teleport exploit", text = "Teleport exploit" },
  { method = "AddButton", id = "Teleport to camera", text = "Teleport to camera" },
  { method = "AddButton", id = "Teleport to position", text = "Teleport to position" },
  { method = "AddLabel", id = "Teleport to monument", text = "Teleport to monument" },
  { method = "AddDropdown", id = "TpBypassType", text = "TpBypassType" },
  { method = "AddDropdown", id = "MonumentType", text = "MonumentType" },
  { method = "AddInput", id = "TeleportPos", text = "Enabled" },
  { method = "AddToggle", id = "CustomBuilding", text = "Enabled" },
  { method = "AddDropdown", id = "Autofarmoptions", text = "Autofarmoptions" },
  { method = "AddButton", id = "Spawn item", text = "Spawn item" },
  { method = "AddInput", id = "ITEMTOSPAWNS", text = "ITEMTOSPAWNS" },
  { method = "AddLabel", id = "Grab dropped item", text = "Grab dropped item" },
  { method = "AddButton", id = "Grab item", text = "Grab item" },
  { method = "AddInput", id = "ITEMTOGRAB", text = "ITEMTOGRAB" },
  { method = "AddToggle", id = "FlightEnabled", text = "Enabled" },
  { method = "AddKeyPicker", id = "FlightKeybind", text = "Enabled" },
  { method = "AddToggle", id = "AntiAimEnabled", text = "Enabled" },
  { method = "AddDropdown", id = "AntiAimYaw", text = "AntiAimYaw" },
  { method = "AddToggle", id = "TextEnabled", text = "Enabled" },
  { method = "AddToggle", id = "TextOutline", text = "Outline" },
  { method = "AddToggle", id = "TextName", text = "TextName" },
  { method = "AddToggle", id = "TextHealth", text = "TextHealth" },
  { method = "AddToggle", id = "TextDistance", text = "TextDistance" },
  { method = "AddToggle", id = "ChamsEspEnabled", text = "Enabled" },
  { method = "AddColorPicker", id = "Chams color", text = "Chams color" },
  { method = "AddColorPicker", id = "BulletColor", text = "BulletColor" },
  { method = "AddDropdown", id = "MyDropdown", text = "MyDropdown" },
  { method = "AddToggle", id = "TracerEnabled", text = "Enabled" },
  { method = "AddColorPicker", id = "Tracer color", text = "Tracer color" },
  { method = "AddDropdown", id = "TracerOption", text = "Enabled" },
  { method = "AddColorPicker", id = "OutdoorAmbientColor", text = "OutdoorAmbientColor" },
  { method = "AddColorPicker", id = "ColorshiftTopColor", text = "ColorshiftTopColor" },
  { method = "AddColorPicker", id = "ColorshiftBotColor", text = "ColorshiftBotColor" },
  { method = "AddColorPicker", id = "Viewmodel color", text = "Viewmodel color" },
  { method = "AddDropdown", id = "ViewmodelMaterial", text = "Enabled" },
  { method = "AddColorPicker", id = "Viewmodel colorr", text = "Viewmodel colorr" },
  { method = "AddDropdown", id = "ViewmodelMateriall", text = "ViewmodelMateriall" },
  { method = "AddButton", id = "Unload", text = "Unload" },
  { method = "AddLabel", id = "Menu bind", text = "Menu bind" },
  { method = "AddKeyPicker", id = "MenuKeybind", text = "MenuKeybind" },
}

local RecoveredFunctionMap = {
  Utilities = {
    "editVal",
    "resetVal",
    "GetPlayer",
    "GetLocalPlayer",
    "GetSelectedItem",
    "GetCharacter",
    "GetPlayers",
    "GetTeam",
    "GetHumanoid",
    "GetPlayerPrimary",
    "GetHealth",
    "DistanceBetweenPlayers",
    "IsVisible",
    "WorldToScreen",
    "ClosestToMouseRadius",
    "SetCamPos",
    "beam",
    "UpdateChams",
    "UpdateText",
  },
}

local Settings = {
  Movement = {
    PrimaryPart = "HumanoidRootPart",
    Humanoid = "Humanoid",
    Bhop = { Enabled = false, AutobhopDelay = 0, Speed = 10 },
    Flight = { Enabled = false, DirectionSpeed = 100, YSpeed = 10 },
    WalkSpeed = { Enabled = false, Value = 17 },
    JumpPower = { Enabled = false, Value = 50 },
    AntiAim = { Enabled = false, Type = "Jitter", Yaw = 20 },
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
    Line = false,
  },
  Ragebot = {
    Enabled = false,
    Autohit = false,
    Wallcheck = false,
    Maxdist = 5000,
    BodyPart = "Head",
  },
  Triggerbot = {
    Enabled = false,
    ReactionTime = 0.1,
    TeamCheck = false,
  },
  Visuals = {
    Box = { Enabled = false, Outline = false, Distance = false, Health = false, Name = false, Offset = 15 },
    Line = { Enabled = false, StartFrom = "Top", Thickness = 1, Transparency = 0.6, Color = Color3.fromRGB(255, 255, 255) },
    Chams = { Enabled = false, Filled = false, Transparency = 0.7, OutlineTransparency = 0.7, Color = Color3.fromRGB(255, 255, 255) },
    Client = {
      Bullet = { Enabled = false, Color = Color3.fromRGB(0, 0, 255), Transparency = 0.7, Material = "ForceField", Lifetime = 0.5, Type = "2d" },
      FieldOfView = { Enabled = false, Value = 90 },
    },
    World = {
      Ambient = { Enabled = false, Color = Color3.fromRGB(255, 255, 255) },
      Brightness = { Enabled = false, Slider = 2 },
      ColorShift_Bottom = { Enabled = false, Color = Color3.fromRGB(255, 255, 255) },
      ColorShift_Top = { Enabled = false, Color = Color3.fromRGB(255, 255, 255) },
      OutdoorAmbient = { Enabled = false, Color = Color3.fromRGB(255, 255, 255) },
      Shadow = { Enabled = true, Softness = 1 },
    },
    Viewmodel = {
      Size = 0.25,
      SizeEnabled = true,
      Transparency = 0.5,
      Tools = { Enabled = false, Transparency = 0.8 },
    },
  },
  Godmode = { Enabled = false },
  Autofarm = { Enabled = false, Frequency = 0.6 },
  Building = { Enabled = false, Unbreakable = false, Offset = 0 },
  Anticheat = { Enabled = true },
  Teleport = {
    Offset = 0,
    MaxIteration = 500,
    Timer = 0.1,
    TimerCheck = 3,
    Monument = "Airfield",
    Pos = Vector3.new(0, 0, 0),
    Type = "State",
  },
}

getgenv().Settings = Settings
getgenv().tools = {
  Godmode = Settings.Godmode,
  Autofarm = Settings.Autofarm,
  Building = Settings.Building,
  Anticheat = Settings.Anticheat,
  Teleport = Settings.Teleport,
}
getgenv().Hitbox = { Enabled = false, Hitbox = "HumanoidRootPart", Size = 25 }

local function ensureGlobalTable(name)
  local env = getgenv()
  local value = env[name] or (type(_G) == "table" and _G[name]) or {}
  env[name] = value
  if type(_G) == "table" then
    _G[name] = value
  end
  return value
end

local Services = ensureGlobalTable("Services")
local Utilities = ensureGlobalTable("Utilities")
local Tracer = ensureGlobalTable("Tracer")
local Text = ensureGlobalTable("Text")
local Connections = ensureGlobalTable("Connections")
local Chams = getgenv().Chams or (type(_G) == "table" and _G.Chams)
if not Chams and Instance and Instance.new then
  Chams = Instance.new("Folder")
end
Chams = Chams or {}
getgenv().Chams = Chams
if type(_G) == "table" then
  _G.Chams = Chams
end

Services.Players = Services.Players or game:GetService("Players")
Services.RunService = Services.RunService or game:GetService("RunService")
Services.UserInputService = Services.UserInputService or game:GetService("UserInputService")
Services.TweenService = Services.TweenService or game:GetService("TweenService")
Services.Lighting = Services.Lighting or game:GetService("Lighting")
Services.ReplicatedStorage = Services.ReplicatedStorage or game:GetService("ReplicatedStorage")
Services.Workspace = Services.Workspace or workspace

local Camera = workspace.CurrentCamera
Utilities.Connections = Utilities.Connections or Connections

function Utilities.log(...)
  if AuthConfig.LogOutput then
    warn("[ASTRAL.LUA]", ...)
  end
end

-- removed recovered anti-tamper/auth loop-trap prelude
-- Rebuilt runtime bootstrap from recovered constants.
v50 = Utilities
v51 = Services
v52 = Tracer
v53 = Text
v54 = Chams
v55 = Settings
v1012 = Utilities
v1014 = Settings
v1016 = Camera
v31 = 0
v758 = Services.Players and Services.Players.LocalPlayer
Utilities.Players = Services.Players
for name, value in pairs(Settings) do
  if Utilities[name] == nil then
    Utilities[name] = value
  end
end

local FovCircle = Drawing and Drawing.new and Drawing.new("Circle") or {}
FovCircle.Radius = Settings.LegitBot.Fov
FovCircle.Color = Color3.fromRGB(255, 255, 255)
FovCircle.Filled = false
FovCircle.NumSides = 360
FovCircle.Position = Vector2.new(Camera.ViewportSize.X, Camera.ViewportSize.Y)
FovCircle.Transparency = 1
FovCircle.Thickness = 2
FovCircle.Visible = Settings.LegitBot.FieldOfView

local Snapline = Drawing and Drawing.new and Drawing.new("Line") or {}
Snapline.Thickness = 1
Snapline.Transparency = 0.7
Snapline.Color = Color3.fromRGB(255, 255, 255)

local CoreGui = game:GetService("CoreGui")
pcall(function()
  Chams.Parent = CoreGui
  Chams.Name = "Chams"
end)

local function newNoopUiObject()
  local object = {}
  return setmetatable(object, {
    __index = function(target, key)
      local value = function()
        return newNoopUiObject()
      end
      target[key] = value
      return value
    end,
  })
end

local function newRecoveredTable()
  local object = {}
  return setmetatable(object, {
    __call = function(target)
      return target
    end,
    __index = function(target, key)
      local value = newRecoveredTable()
      target[key] = value
      return value
    end,
  })
end

local function ensureCallable(value)
  if type(value) == "function" then
    return value
  end
  if type(value) == "table" then
    local mt = getmetatable(value) or {}
    if mt.__call == nil then
      mt.__call = function(target)
        return target
      end
      setmetatable(value, mt)
    end
    return value
  end
  return function()
    return newRecoveredTable()
  end
end

local function buildRecoveredWindow()
  local ok, Library = pcall(loadRemoteSource, "UiLibrary")
  if ok and type(Library) == "table" then
    if type(Library.CreateWindow) == "function" then
      local winOk, win = pcall(Library.CreateWindow, Library, {
        Title = "ASTRAL.LUA",
        Center = true,
        AutoShow = true,
      })
      if winOk and win then
        return win, Library
      end
    end
  end
  return newNoopUiObject(), Library
end

local RecoveredWindow, RecoveredLibrary = buildRecoveredWindow()
v70 = RecoveredWindow
v71 = {}
v72 = v70:AddTab("Main")
v71.Main = v72
v71.Movement = v72
v71.Visuals = v70:AddTab("Visuals")
v71.Misc = v70:AddTab("Misc")
v71["UI Settings"] = v70:AddTab("UI Settings")
function v62(v251, v501, v502)
  -- synthetic register locals stripped
  v254 = ensureCallable(v254)
  v254, v255, v256 = v254(v255)
  if false then -- removed constant-true decompiler loop
    -- removed decompiler goto
    v259 = ensureCallable(v259)
    v259 = v259(v260)
    if v259 ~= "table" then
    end
    -- removed decompiler goto
    -- removed decompiler label lbl_7
    v259 = ensureCallable(v259)
    v259 = v259(v260)
    v260 = v259
    if type(v259) ~= "table" and type(v259) ~= "userdata" then v259 = newRecoveredTable() end
    v259 = v259.lower
    v259 = ensureCallable(v259)
    v259 = v259(v260)
    v260 = v259
    if type(v259) ~= "table" and type(v259) ~= "userdata" then v259 = newRecoveredTable() end
    v259 = v259.find
    v262 = v501
    if type(v501) ~= "table" and type(v501) ~= "userdata" then v501 = newRecoveredTable() end
    v261 = v501.lower
  -- synthetic vararg register fan-out stripped
    -- trimmed huge synthetic register fan-out
    v259 = v259(v260, v261, v262, v263, v264, v265, v266, v267)
    if v259 then
    end
    -- removed decompiler label lbl_16
    if type(v251) ~= "table" and type(v251) ~= "userdata" then v251 = newRecoveredTable() end
    if v257 == nil then v257 = "RecoveredKey" end
    v251[v257] = v502
  end
end

if type(v50) ~= "table" and type(v50) ~= "userdata" then v50 = newRecoveredTable() end
Utilities.editVal = v62

function v62()
  -- synthetic register locals stripped
  v758 = ensureCallable(v758)
  v758, v252, v253 = v758(v252)
  if false then -- removed constant-true decompiler loop
    -- removed decompiler goto
    -- removed decompiler label lbl_3
    if type(v255) ~= "table" and type(v255) ~= "userdata" then v255 = newRecoveredTable() end
    if v254 == nil then v254 = "RecoveredKey" end
    v255[v254] = nil
  end
  v758 = ensureCallable(v758)
  v758, v252, v253 = v758(v252)
  if false then -- removed constant-true decompiler loop
    -- removed decompiler goto
    -- removed decompiler label lbl_8
    if type(v256) ~= "table" and type(v256) ~= "userdata" then v256 = newRecoveredTable() end
    if v254 == nil then v254 = "RecoveredKey" end
    v256[v254] = v255
  end
end

if type(v50) ~= "table" and type(v50) ~= "userdata" then v50 = newRecoveredTable() end
Utilities.resetVal = v62

function v62(v251)
  -- synthetic register locals stripped
  v252 = v1012
  if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
  v252 = v252.Players
  v253 = v252
  if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
  v252 = v252.FindFirstChild
  v254 = v251
  return v252(v253, v254)
end

if type(v50) ~= "table" and type(v50) ~= "userdata" then v50 = newRecoveredTable() end
Utilities.GetPlayer = v62

function v62()
  -- synthetic register locals stripped
  v758 = v1012
  if type(v758) ~= "table" and type(v758) ~= "userdata" then v758 = newRecoveredTable() end
  v758 = v758.Players
  if type(v758) ~= "table" and type(v758) ~= "userdata" then v758 = newRecoveredTable() end
  v758 = v758.LocalPlayer
  return v758
end

if type(v50) ~= "table" and type(v50) ~= "userdata" then v50 = newRecoveredTable() end
Utilities.GetLocalPlayer = v62
v62 = ensureCallable(v62)
v62 = v62()

function v63()
  -- synthetic register locals stripped
  v254 = v758
  if type(v758) ~= "table" and type(v758) ~= "userdata" then v758 = newRecoveredTable() end
  v253 = v758.GetChildren
  -- synthetic vararg register fan-out stripped
  -- trimmed huge synthetic register fan-out
  v252, v253, v254 = v252(v253, v254, v255, v256, v257, v258, v259, v260)
  if false then -- removed constant-true decompiler loop
    -- removed decompiler goto
    if v257 == "1" or v257 == "2" then
    end
    -- removed decompiler goto
    if v257 == "3" or v257 == "4" then
    end
    -- removed decompiler goto
    if v257 == "5" then
    end
    -- removed decompiler goto
    -- removed decompiler label lbl_19
    if v257 == "6" then
    else
    end
    -- removed decompiler label lbl_21
    return v256
  end
end

if type(v50) ~= "table" and type(v50) ~= "userdata" then v50 = newRecoveredTable() end
Utilities.GetSelectedItem = v63

function v63(v251)
  -- synthetic register locals stripped
end

if type(v50) ~= "table" and type(v50) ~= "userdata" then v50 = newRecoveredTable() end
Utilities.GetCharacter = v63

function v63()
  -- synthetic register locals stripped
  v758 = v1012
  if type(v758) ~= "table" and type(v758) ~= "userdata" then v758 = newRecoveredTable() end
  v758 = v758.Players
  v252 = v758
  if type(v758) ~= "table" and type(v758) ~= "userdata" then v758 = newRecoveredTable() end
  v758 = v758.GetPlayers
  v758 = ensureCallable(v758)
  v758 = v758(v252)
  return v758
end

if type(v50) ~= "table" and type(v50) ~= "userdata" then v50 = newRecoveredTable() end
Utilities.GetPlayers = v63

function v63(v251)
  -- synthetic register locals stripped
  v252 = ensureCallable(v252)
  v252 = v252(v253)
  if v252 then
  end
  do return v253 end
  v253 = nil
  return v253
end

if type(v50) ~= "table" and type(v50) ~= "userdata" then v50 = newRecoveredTable() end
Utilities.GetTeam = v63

function v63(v251)
  -- synthetic register locals stripped
  v252 = v1012
  if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
  v252 = v252.GetPlayer
  v253 = v251
  v252 = ensureCallable(v252)
  v252 = v252(v253)
  v253 = v1012
  if type(v253) ~= "table" and type(v253) ~= "userdata" then v253 = newRecoveredTable() end
  v253 = v253.GetCharacter
  if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
  v254 = v252.Name
  v253 = ensureCallable(v253)
  v253 = v253(v254)
  if not v253 then
  end
  -- removed decompiler goto
  v255 = v253
  if type(v253) ~= "table" and type(v253) ~= "userdata" then v253 = newRecoveredTable() end
  v254 = v253.FindFirstChild
  v254 = ensureCallable(v254)
  v254 = v254(v255, v256, v257)
  -- removed decompiler label lbl_14
  return v254
end

if type(v50) ~= "table" and type(v50) ~= "userdata" then v50 = newRecoveredTable() end
Utilities.GetHumanoid = v63

function v63(v251)
  -- synthetic register locals stripped
  v252 = v1012
  if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
  v252 = v252.GetPlayer
  v253 = v251
  v252 = ensureCallable(v252)
  v252 = v252(v253)
  v253 = v1012
  if type(v253) ~= "table" and type(v253) ~= "userdata" then v253 = newRecoveredTable() end
  v253 = v253.GetCharacter
  if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
  v254 = v252.Name
  v253 = ensureCallable(v253)
  v253 = v253(v254)
  if not v253 then
  end
  -- removed decompiler goto
  v255 = v253
  if type(v253) ~= "table" and type(v253) ~= "userdata" then v253 = newRecoveredTable() end
  v254 = v253.FindFirstChild
  v254 = ensureCallable(v254)
  v254 = v254(v255, v256, v257)
  -- removed decompiler label lbl_14
  do return v254 end
  v254 = nil
  return v254
end

if type(v50) ~= "table" and type(v50) ~= "userdata" then v50 = newRecoveredTable() end
Utilities.GetPlayerPrimary = v63

function v63(v251)
  -- synthetic register locals stripped
  v252 = ensureCallable(v252)
  v252 = v252(v253)
  if not v252 then
  end
  -- removed decompiler goto
  -- removed decompiler label lbl_5
  do return v253 end
  v253 = nil
  return v253
end

if type(v50) ~= "table" and type(v50) ~= "userdata" then v50 = newRecoveredTable() end
Utilities.GetHealth = v63

function v63(v251, v501)
  -- synthetic register locals stripped
  v253 = ensureCallable(v253)
  v253 = v253(v254)
  v254 = ensureCallable(v254)
  v254 = v254(v255)
  if not v253 then
  end
  -- removed decompiler goto
  if not v254 then
  end
  -- removed decompiler goto
  v256 = v253
  if type(v253) ~= "table" and type(v253) ~= "userdata" then v253 = newRecoveredTable() end
  v255 = v253.FindFirstChild
  v257 = v1012
  if type(v257) ~= "table" and type(v257) ~= "userdata" then v257 = newRecoveredTable() end
  v257 = v257.Options_Utility
  if type(v257) ~= "table" and type(v257) ~= "userdata" then v257 = newRecoveredTable() end
  v257 = v257.PrimaryPart
  v255 = ensureCallable(v255)
  v255 = v255(v256, v257, v258)
  v257 = v254
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v256 = v254.FindFirstChild
  v258 = v1012
  if type(v258) ~= "table" and type(v258) ~= "userdata" then v258 = newRecoveredTable() end
  v258 = v258.Options_Utility
  if type(v258) ~= "table" and type(v258) ~= "userdata" then v258 = newRecoveredTable() end
  v258 = v258.PrimaryPart
  v256 = ensureCallable(v256)
  v256 = v256(v257, v258, v259)
  if not v255 or not v256 then
  end
  -- removed decompiler goto
  -- removed decompiler label lbl_24
  do return v257 end
  return v255
end

if type(v50) ~= "table" and type(v50) ~= "userdata" then v50 = newRecoveredTable() end
Utilities.DistanceBetweenPlayers = v63

function v63(v251, v501)
  -- synthetic register locals stripped
  -- synthetic vararg register fan-out stripped
  -- trimmed huge synthetic register fan-out
  v254 = v254(v255, v256, v257, v258, v259, v260, v261, v262)
  if v253 then
  end
  -- removed decompiler goto
  if not v254 then
  end
  -- removed decompiler label lbl_8
  do return v255 end
  if type(v256) ~= "table" and type(v256) ~= "userdata" then v256 = newRecoveredTable() end
  v256.FilterDescendantsInstances = v257
  if type(v256) ~= "table" and type(v256) ~= "userdata" then v256 = newRecoveredTable() end
  v256.FilterType = v257
  if type(v256) ~= "table" and type(v256) ~= "userdata" then v256 = newRecoveredTable() end
  v256.IgnoreWater = true
  v258 = v257
  if type(v257) ~= "table" and type(v257) ~= "userdata" then v257 = newRecoveredTable() end
  v257 = v257.Raycast
  v257 = ensureCallable(v257)
  v257 = v257(v258, v259, v260, v261, v262)
  if v257 == nil then
  end
  v258 = false
end

if type(v50) ~= "table" and type(v50) ~= "userdata" then v50 = newRecoveredTable() end
Utilities.IsVisible = v63

function v63(v251)
  -- synthetic register locals stripped
end

if type(v50) ~= "table" and type(v50) ~= "userdata" then v50 = newRecoveredTable() end
Utilities.WorldToScreen = v63

function v63(v251, v501, v502)
  -- synthetic register locals stripped
  v255 = math
  if type(v255) ~= "table" and type(v255) ~= "userdata" then v255 = newRecoveredTable() end
  v255 = v255.huge
  v256 = v1012
  if type(v256) ~= "table" and type(v256) ~= "userdata" then v256 = newRecoveredTable() end
  v256 = v256.GetPlayers
  v256 = ensureCallable(v256)
  v256 = v256()
  v257 = v1014
  v259 = v257
  if type(v257) ~= "table" and type(v257) ~= "userdata" then v257 = newRecoveredTable() end
  v258 = v257.GetMouse
  v258 = ensureCallable(v258)
  v258 = v258(v259)
  v259 = pairs
  v260 = v256
  v259 = ensureCallable(v259)
  v259, v260, v261 = v259(v260)
  for v262, v263 in v259, v260, v261 do
    if v263 == v257 then
    end
    -- removed decompiler goto
    if not v251 then
    end
    v265 = Vector3
    if type(v265) ~= "table" and type(v265) ~= "userdata" then v265 = newRecoveredTable() end
    v265 = v265.new
    v266 = 0
    v267 = 0
    v268 = 0
    v265 = ensureCallable(v265)
    v265 = v265(v266, v267, v268, v269)
    v266 = nil
    v267 = v1012
    if type(v267) ~= "table" and type(v267) ~= "userdata" then v267 = newRecoveredTable() end
    v267 = v267.GetPlayerPrimary
    if type(v257) ~= "table" and type(v257) ~= "userdata" then v257 = newRecoveredTable() end
    v268 = v257.Name
    v267 = ensureCallable(v267)
    v267 = v267(v268)
    v268 = v1012
    if type(v268) ~= "table" and type(v268) ~= "userdata" then v268 = newRecoveredTable() end
    v268 = v268.GetCharacter
    if type(v263) ~= "table" and type(v263) ~= "userdata" then v263 = newRecoveredTable() end
    v269 = v263.Name
    v268 = ensureCallable(v268)
    v268 = v268(v269)
    if not v268 then
    end
    -- removed decompiler goto
    v268 = ensureCallable(v268)
    v268 = v268(v269)
    -- removed decompiler label lbl_43
    if v267 then
    end
    v269 = ensureCallable(v269)
    v269 = v269(v270)
    if not v269 then
    end
    -- removed decompiler goto
    v270 = ensureCallable(v270)
    v270, v271 = v270(v271)
    if v271 then
      v274 = v274 + 55
      v272 = ensureCallable(v272)
      v272 = v272(v273, v274, v275)
      -- removed decompiler goto
      if not v264 or not v268 then
      end
      -- removed decompiler goto
      if v255 > v272 then
      end
    end
    -- removed decompiler label lbl_67
  end
  return v259, v260
end

if type(v50) ~= "table" and type(v50) ~= "userdata" then v50 = newRecoveredTable() end
Utilities.ClosestToMouseRadius = v63

function v63(v251, v501)
  -- synthetic register locals stripped
  v253 = v501
  v254 = v1012
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254 = v254.CFrame
  v255 = CFrame
  if type(v255) ~= "table" and type(v255) ~= "userdata" then v255 = newRecoveredTable() end
  v255 = v255.new
  v256 = v1012
  if type(v256) ~= "table" and type(v256) ~= "userdata" then v256 = newRecoveredTable() end
  v256 = v256.CFrame
  if type(v256) ~= "table" and type(v256) ~= "userdata" then v256 = newRecoveredTable() end
  v256 = v256.Position
  v257 = v251
  v255 = ensureCallable(v255)
  v255 = v255(v256, v257, v258)
  if v501 ~= 1 then
  end
  -- removed decompiler goto
  if type(v256) ~= "table" and type(v256) ~= "userdata" then v256 = newRecoveredTable() end
  v256.CFrame = v255
  -- removed decompiler label lbl_15
  -- removed decompiler goto
  -- removed decompiler label lbl_16
end

if type(v50) ~= "table" and type(v50) ~= "userdata" then v50 = newRecoveredTable() end
Utilities.SetCamPos = v63

function v63(v251, v501)
  -- synthetic register locals stripped
  v254 = "Part"
  v253 = ensureCallable(v253)
  v253 = v253(v254, v255, v256)
  if type(v253) ~= "table" and type(v253) ~= "userdata" then v253 = newRecoveredTable() end
  v253.Anchored = true
  if type(v253) ~= "table" and type(v253) ~= "userdata" then v253 = newRecoveredTable() end
  v253.CanCollide = false
  if type(v253) ~= "table" and type(v253) ~= "userdata" then v253 = newRecoveredTable() end
  v253.Material = v254
  if type(v253) ~= "table" and type(v253) ~= "userdata" then v253 = newRecoveredTable() end
  v253.Color = v254
  v255 = 0.1
  v256 = 0.1
  v257 = v251 - v501
  if type(v257) ~= "table" and type(v257) ~= "userdata" then v257 = newRecoveredTable() end
  v257 = v257.magnitude
  v254 = ensureCallable(v254)
  v254 = v254(v255, v256, v257, v258)
  if type(v253) ~= "table" and type(v253) ~= "userdata" then v253 = newRecoveredTable() end
  v253.Size = v254
  v254 = CFrame
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254 = v254.new
  v255 = v251
  v256 = v501
  v254 = ensureCallable(v254)
  v254 = v254(v255, v256, v257)
  return v253
end

if type(v50) ~= "table" and type(v50) ~= "userdata" then v50 = newRecoveredTable() end
Utilities.beam = v63

function v63(v251)
  -- synthetic register locals stripped
  -- removed decompiler goto
  -- removed decompiler label lbl_2
  -- removed decompiler goto
  -- removed decompiler label lbl_3
  do return end
  v252 = ensureCallable(v252)
  v252 = v252(v253)
  v254 = v253
  if type(v253) ~= "table" and type(v253) ~= "userdata" then v253 = newRecoveredTable() end
  v253 = v253.FindFirstChild
  v253 = ensureCallable(v253)
  v253 = v253(v254, v255, v256)
  if v253 then
    v254 = v253
    if type(v253) ~= "table" and type(v253) ~= "userdata" then v253 = newRecoveredTable() end
    v253 = v253.FindFirstChild
    v253 = ensureCallable(v253)
    v253 = v253(v254, v255, v256)
    if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
    v254 = v254.Visuals
    if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
    v254 = v254.Chams
    if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
    v254 = v254.OutlineTransparency
    if type(v253) ~= "table" and type(v253) ~= "userdata" then v253 = newRecoveredTable() end
    v253.OutlineTransparency = v254
    v254 = v1012
    if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
    v254 = v254.Visuals
    if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
    v254 = v254.Chams
    if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
    v254 = v254.Transparency
    if type(v253) ~= "table" and type(v253) ~= "userdata" then v253 = newRecoveredTable() end
    v253.FillTransparency = v254
    v254 = v1012
    if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
    v254 = v254.Visuals
    if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
    v254 = v254.Chams
    if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
    v254 = v254.Color
    if type(v253) ~= "table" and type(v253) ~= "userdata" then v253 = newRecoveredTable() end
    v253.FillColor = v254
    if type(v253) ~= "table" and type(v253) ~= "userdata" then v253 = newRecoveredTable() end
    v253.OutlineColor = v254
    if type(v253) ~= "table" and type(v253) ~= "userdata" then v253 = newRecoveredTable() end
    v253.Adornee = v252
  end
  if type(v253) ~= "table" and type(v253) ~= "userdata" then v253 = newRecoveredTable() end
  v253.Name = v254
  if v252 then
    v254 = v253
    if type(v253) ~= "table" and type(v253) ~= "userdata" then v253 = newRecoveredTable() end
    v253 = v253.FindFirstChild
    v253 = ensureCallable(v253)
    v253 = v253(v254, v255, v256)
    if v253 then
    end
    -- removed decompiler goto
    v254 = "Highlight"
    v253 = ensureCallable(v253)
    v253 = v253(v254)
    if type(v253) ~= "table" and type(v253) ~= "userdata" then v253 = newRecoveredTable() end
    v253.Parent = v254
    if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
    v254 = v254.Visuals
    if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
    v254 = v254.Chams
    if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
    v254 = v254.OutlineTransparency
    if type(v253) ~= "table" and type(v253) ~= "userdata" then v253 = newRecoveredTable() end
    v253.OutlineTransparency = v254
    v254 = v1012
    if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
    v254 = v254.Visuals
    if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
    v254 = v254.Chams
    if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
    v254 = v254.Transparency
    if type(v253) ~= "table" and type(v253) ~= "userdata" then v253 = newRecoveredTable() end
    v253.FillTransparency = v254
    v254 = v1012
    if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
    v254 = v254.Visuals
    if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
    v254 = v254.Chams
    if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
    v254 = v254.Color
    if type(v253) ~= "table" and type(v253) ~= "userdata" then v253 = newRecoveredTable() end
    v253.FillColor = v254
    if type(v253) ~= "table" and type(v253) ~= "userdata" then v253 = newRecoveredTable() end
    v253.OutlineColor = v254
    if type(v253) ~= "table" and type(v253) ~= "userdata" then v253 = newRecoveredTable() end
    v253.Parent = v254
    if type(v253) ~= "table" and type(v253) ~= "userdata" then v253 = newRecoveredTable() end
    v253.Adornee = v252
  end
  -- removed decompiler label lbl_55
  if type(v253) ~= "table" and type(v253) ~= "userdata" then v253 = newRecoveredTable() end
  v253.Name = v254
end

if type(v50) ~= "table" and type(v50) ~= "userdata" then v50 = newRecoveredTable() end
Utilities.UpdateChams = v63

function v63(v251)
  -- synthetic register locals stripped
  if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
  v252 = v252[v253]
  if not v251 then
    if not v252 then
    end
    -- removed decompiler goto
    -- removed decompiler label lbl_7
    if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
    v252.Visible = false
  end
  do return end
  if not v253 then
    if not v252 then
    end
    -- removed decompiler goto
    -- removed decompiler label lbl_14
    if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
    v252.Visible = false
  end
  do return end
  v253 = ensureCallable(v253)
  v253 = v253(v254)
  if v253 then
  end
  -- removed decompiler goto
  if v252 then
  end
  if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
  v252.Visible = false
  -- removed decompiler label lbl_23
  do return end
  v254 = ensureCallable(v254)
  v254, v255 = v254(v255)
  if type(v256) ~= "table" and type(v256) ~= "userdata" then v256 = newRecoveredTable() end
  v256 = v256[v257]
  if not v256 then
    v257 = "Text"
    v256 = ensureCallable(v256)
    v256 = v256(v257)
    if type(v257) ~= "table" and type(v257) ~= "userdata" then v257 = newRecoveredTable() end
    if v258 == nil then v258 = "RecoveredKey" end
    v257[v258] = v256
    if type(v256) ~= "table" and type(v256) ~= "userdata" then v256 = newRecoveredTable() end
    v256.Center = true
    if type(v257) ~= "table" and type(v257) ~= "userdata" then v257 = newRecoveredTable() end
    v257 = v257.Visuals
    if type(v257) ~= "table" and type(v257) ~= "userdata" then v257 = newRecoveredTable() end
    v257 = v257.Text
    if type(v257) ~= "table" and type(v257) ~= "userdata" then v257 = newRecoveredTable() end
    v257 = v257.TextSize
    if type(v256) ~= "table" and type(v256) ~= "userdata" then v256 = newRecoveredTable() end
    v256.Size = v257
    v257 = v1014
    if type(v257) ~= "table" and type(v257) ~= "userdata" then v257 = newRecoveredTable() end
    v257 = v257.Visuals
    if type(v257) ~= "table" and type(v257) ~= "userdata" then v257 = newRecoveredTable() end
    v257 = v257.Text
    if type(v257) ~= "table" and type(v257) ~= "userdata" then v257 = newRecoveredTable() end
    v257 = v257.Outline
    if type(v256) ~= "table" and type(v256) ~= "userdata" then v256 = newRecoveredTable() end
    v256.Outline = v257
    v257 = v1014
    if type(v257) ~= "table" and type(v257) ~= "userdata" then v257 = newRecoveredTable() end
    v257 = v257.Visuals
    if type(v257) ~= "table" and type(v257) ~= "userdata" then v257 = newRecoveredTable() end
    v257 = v257.Text
    if type(v257) ~= "table" and type(v257) ~= "userdata" then v257 = newRecoveredTable() end
    v257 = v257.TextColor
    if type(v256) ~= "table" and type(v256) ~= "userdata" then v256 = newRecoveredTable() end
    v256.Color = v257
    v257 = v1014
    if type(v257) ~= "table" and type(v257) ~= "userdata" then v257 = newRecoveredTable() end
    v257 = v257.Visuals
    if type(v257) ~= "table" and type(v257) ~= "userdata" then v257 = newRecoveredTable() end
    v257 = v257.Text
    if type(v257) ~= "table" and type(v257) ~= "userdata" then v257 = newRecoveredTable() end
    v257 = v257.Transparency
    if type(v256) ~= "table" and type(v256) ~= "userdata" then v256 = newRecoveredTable() end
    v256.Transparency = v257
    v257 = Drawing
    if type(v257) ~= "table" and type(v257) ~= "userdata" then v257 = newRecoveredTable() end
    v257 = v257.Fonts
    if type(v257) ~= "table" and type(v257) ~= "userdata" then v257 = newRecoveredTable() end
    v257 = v257.UI
  end
  if type(v256) ~= "table" and type(v256) ~= "userdata" then v256 = newRecoveredTable() end
  v256.Font = v257
  v256 = ""
  v257 = ""
  v258 = ""
  v259 = ""
  if not v255 then
  end
  -- removed decompiler goto
  if type(v260) ~= "table" and type(v260) ~= "userdata" then v260 = newRecoveredTable() end
  v260 = v260[v261]
  if type(v260) ~= "table" and type(v260) ~= "userdata" then v260 = newRecoveredTable() end
  v260.Visible = true
  if type(v260) ~= "table" and type(v260) ~= "userdata" then v260 = newRecoveredTable() end
  v260.Center = true
  if type(v261) ~= "table" and type(v261) ~= "userdata" then v261 = newRecoveredTable() end
  v261 = v261.Visuals
  if type(v261) ~= "table" and type(v261) ~= "userdata" then v261 = newRecoveredTable() end
  v261 = v261.Text
  if type(v261) ~= "table" and type(v261) ~= "userdata" then v261 = newRecoveredTable() end
  v261 = v261.TextSize
  if type(v260) ~= "table" and type(v260) ~= "userdata" then v260 = newRecoveredTable() end
  v260.Size = v261
  v261 = v1014
  if type(v261) ~= "table" and type(v261) ~= "userdata" then v261 = newRecoveredTable() end
  v261 = v261.Visuals
  if type(v261) ~= "table" and type(v261) ~= "userdata" then v261 = newRecoveredTable() end
  v261 = v261.Text
  if type(v261) ~= "table" and type(v261) ~= "userdata" then v261 = newRecoveredTable() end
  v261 = v261.Outline
  if type(v260) ~= "table" and type(v260) ~= "userdata" then v260 = newRecoveredTable() end
  v260.Outline = v261
  v261 = v1014
  if type(v261) ~= "table" and type(v261) ~= "userdata" then v261 = newRecoveredTable() end
  v261 = v261.Visuals
  if type(v261) ~= "table" and type(v261) ~= "userdata" then v261 = newRecoveredTable() end
  v261 = v261.Text
  if type(v261) ~= "table" and type(v261) ~= "userdata" then v261 = newRecoveredTable() end
  v261 = v261.TextColor
  if type(v260) ~= "table" and type(v260) ~= "userdata" then v260 = newRecoveredTable() end
  v260.Color = v261
  v261 = v1014
  if type(v261) ~= "table" and type(v261) ~= "userdata" then v261 = newRecoveredTable() end
  v261 = v261.Visuals
  if type(v261) ~= "table" and type(v261) ~= "userdata" then v261 = newRecoveredTable() end
  v261 = v261.Text
  if type(v261) ~= "table" and type(v261) ~= "userdata" then v261 = newRecoveredTable() end
  v261 = v261.Transparency
  if type(v260) ~= "table" and type(v260) ~= "userdata" then v260 = newRecoveredTable() end
  v260.Transparency = v261
  v261 = Drawing
  if type(v261) ~= "table" and type(v261) ~= "userdata" then v261 = newRecoveredTable() end
  v261 = v261.Fonts
  if type(v261) ~= "table" and type(v261) ~= "userdata" then v261 = newRecoveredTable() end
  v261 = v261.UI
  if type(v260) ~= "table" and type(v260) ~= "userdata" then v260 = newRecoveredTable() end
  v260.Font = v261
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v262 = v254.X
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v263 = v254.Y
  v264 = v1014
  if type(v264) ~= "table" and type(v264) ~= "userdata" then v264 = newRecoveredTable() end
  v264 = v264.Visuals
  if type(v264) ~= "table" and type(v264) ~= "userdata" then v264 = newRecoveredTable() end
  v264 = v264.Text
  if type(v264) ~= "table" and type(v264) ~= "userdata" then v264 = newRecoveredTable() end
  v264 = v264.Offset
  v263 = v263 - v264
  v263 = v263 - 10
  v261 = ensureCallable(v261)
  v261 = v261(v262, v263, v264)
  if type(v260) ~= "table" and type(v260) ~= "userdata" then v260 = newRecoveredTable() end
  v260.Position = v261
  -- removed decompiler goto
  -- removed decompiler label lbl_99
  if v261 then
    v262 = "STUD: ["
  -- synthetic vararg register fan-out stripped
    -- trimmed huge synthetic register fan-out
    v263 = v263(v264, v265, v266, v267, v268, v269, v270, v271)
    v264 = "]"
  end
  if v261 then
  -- synthetic vararg register fan-out stripped
    -- trimmed huge synthetic register fan-out
    v261 = v261(v262, v263, v264, v265, v266, v267, v268, v269)
  end
  v261 = "["
  v262 = v259
  v263 = "]"
  v264 = " "
  v265 = v257
  v266 = " "
  v267 = v258
  v261 = v261 .. v262 .. v263 .. v264 .. v265 .. v266 .. v267
  if type(v260) ~= "table" and type(v260) ~= "userdata" then v260 = newRecoveredTable() end
  v260.Text = v261
  -- removed decompiler label lbl_118
  -- removed decompiler goto
  if type(v260) ~= "table" and type(v260) ~= "userdata" then v260 = newRecoveredTable() end
  v260 = v260[v261]
  -- removed decompiler label lbl_120
  if type(v260) ~= "table" and type(v260) ~= "userdata" then v260 = newRecoveredTable() end
  v260.Visible = false
end

if type(v50) ~= "table" and type(v50) ~= "userdata" then v50 = newRecoveredTable() end
Utilities.UpdateText = v63

function v63(v251)
  -- synthetic register locals stripped
  if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
  v252 = v252[v253]
  if not v253 then
    if v252 then
    end
    if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
    v252.Visible = false
  end
  do return end
  v253 = ensureCallable(v253)
  v253 = v253(v254)
  if v253 then
  end
  -- removed decompiler goto
  if not v252 then
  end
  -- removed decompiler goto
  -- removed decompiler label lbl_15
  if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
  v252.Visible = false
  -- removed decompiler label lbl_16
  do return end
  v254 = ensureCallable(v254)
  v254, v255 = v254(v255)
  if not v252 then
    if type(v256) ~= "table" and type(v256) ~= "userdata" then v256 = newRecoveredTable() end
    v256 = v256.new
    v257 = "Line"
    v256 = ensureCallable(v256)
    v256 = v256(v257)
    v252 = v256
    v256 = v1012
    if type(v251) ~= "table" and type(v251) ~= "userdata" then v251 = newRecoveredTable() end
    v257 = v251.Name
    if type(v256) ~= "table" and type(v256) ~= "userdata" then v256 = newRecoveredTable() end
    if v257 == nil then v257 = "RecoveredKey" end
    v256[v257] = v252
    v256 = v1014
    if type(v256) ~= "table" and type(v256) ~= "userdata" then v256 = newRecoveredTable() end
    v256 = v256.Visuals
    if type(v256) ~= "table" and type(v256) ~= "userdata" then v256 = newRecoveredTable() end
    v256 = v256.Line
    if type(v256) ~= "table" and type(v256) ~= "userdata" then v256 = newRecoveredTable() end
    v256 = v256.Thickness
    if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
    v252.Thickness = v256
    v256 = v1014
    if type(v256) ~= "table" and type(v256) ~= "userdata" then v256 = newRecoveredTable() end
    v256 = v256.Visuals
    if type(v256) ~= "table" and type(v256) ~= "userdata" then v256 = newRecoveredTable() end
    v256 = v256.Line
    if type(v256) ~= "table" and type(v256) ~= "userdata" then v256 = newRecoveredTable() end
    v256 = v256.Transparency
    if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
    v252.Transparency = v256
    v256 = v1014
    if type(v256) ~= "table" and type(v256) ~= "userdata" then v256 = newRecoveredTable() end
    v256 = v256.Visuals
    if type(v256) ~= "table" and type(v256) ~= "userdata" then v256 = newRecoveredTable() end
    v256 = v256.Line
    if type(v256) ~= "table" and type(v256) ~= "userdata" then v256 = newRecoveredTable() end
    v256 = v256.Color
  end
  if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
  v252.Color = v256
  if not v255 then
  end
  -- removed decompiler goto
  if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
  v252.Visible = true
  v256 = v1014
  if type(v256) ~= "table" and type(v256) ~= "userdata" then v256 = newRecoveredTable() end
  v256 = v256.Visuals
  if type(v256) ~= "table" and type(v256) ~= "userdata" then v256 = newRecoveredTable() end
  v256 = v256.Line
  if type(v256) ~= "table" and type(v256) ~= "userdata" then v256 = newRecoveredTable() end
  v256 = v256.StartFrom
  if v256 ~= "Top" then
  end
  -- removed decompiler goto
  if type(v256) ~= "table" and type(v256) ~= "userdata" then v256 = newRecoveredTable() end
  v256 = v256.new
  v257 = v1016
  if type(v257) ~= "table" and type(v257) ~= "userdata" then v257 = newRecoveredTable() end
  v257 = v257.ViewportSize
  if type(v257) ~= "table" and type(v257) ~= "userdata" then v257 = newRecoveredTable() end
  v257 = v257.X
  v257 = v257 / 2
  v258 = 0
  v256 = ensureCallable(v256)
  v256 = v256(v257, v258, v259)
  if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
  v252.From = v256
  -- removed decompiler label lbl_61
  -- removed decompiler goto
  if v256 ~= "Bottom" then
  end
  -- removed decompiler goto
  v257 = v257 / 2
  v256 = ensureCallable(v256)
  v256 = v256(v257, v258, v259)
  if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
  v252.From = v256
  -- removed decompiler label lbl_68
  -- removed decompiler goto
  if v256 == "Mouse" then
    v258 = v256
    if type(v256) ~= "table" and type(v256) ~= "userdata" then v256 = newRecoveredTable() end
    v257 = v256.GetMouse
    v257 = ensureCallable(v257)
    v257 = v257(v258)
    v260 = v260 + 55
    v258 = ensureCallable(v258)
    v258 = v258(v259, v260, v261)
  end
  -- removed decompiler label lbl_75
  if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
  v252.From = v258
  if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
  v252.To = v254
  -- removed decompiler label lbl_77
  -- removed decompiler goto
  -- removed decompiler label lbl_78
  if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
  v252.Visible = false
end

if type(v71) ~= "table" and type(v71) ~= "userdata" then v71 = newRecoveredTable() end
v71.Movement = v72
v74 = "AddTab"
v73 = v70
if type(v70) ~= "table" and type(v70) ~= "userdata" then v70 = newRecoveredTable() end
v72 = v70[v74]
v74 = "Visuals"
v72 = ensureCallable(v72)
v72 = v72(v73, v74, v75)
if type(v71) ~= "table" and type(v71) ~= "userdata" then v71 = newRecoveredTable() end
v71.Visuals = v72
v72 = "UI Settings"
v75 = "AddTab"
v74 = v70
if type(v70) ~= "table" and type(v70) ~= "userdata" then v70 = newRecoveredTable() end
v73 = v70[v75]
v75 = "UI Settings"
v73 = ensureCallable(v73)
v73 = v73(v74, v75, v76)
if type(v71) ~= "table" and type(v71) ~= "userdata" then v71 = newRecoveredTable() end
if v72 == nil then v72 = "RecoveredKey" end
v71[v72] = v73
v72 = "Main"
if type(v71) ~= "table" and type(v71) ~= "userdata" then v71 = newRecoveredTable() end
v72 = v71[v72]
v74 = "AddLeftGroupbox"
v73 = v72
if type(v72) ~= "table" and type(v72) ~= "userdata" then v72 = newRecoveredTable() end
v72 = v72[v74]
v74 = "Legit bot"
v72 = ensureCallable(v72)
v72 = v72(v73, v74, v75)
v73 = "Main"
if type(v71) ~= "table" and type(v71) ~= "userdata" then v71 = newRecoveredTable() end
v73 = v71[v73]
v75 = "AddLeftGroupbox"
v74 = v73
if type(v73) ~= "table" and type(v73) ~= "userdata" then v73 = newRecoveredTable() end
v73 = v73[v75]
v75 = "Trigger bot"
v73 = ensureCallable(v73)
v73 = v73(v74, v75, v76)
v74 = "Main"
if type(v71) ~= "table" and type(v71) ~= "userdata" then v71 = newRecoveredTable() end
v74 = v71[v74]
v76 = "AddRightGroupbox"
v75 = v74
if type(v74) ~= "table" and type(v74) ~= "userdata" then v74 = newRecoveredTable() end
v74 = v74[v76]
v76 = "Hitbox Expander"
v74 = ensureCallable(v74)
v74 = v74(v75, v76, v77)
v75 = "Main"
if type(v71) ~= "table" and type(v71) ~= "userdata" then v71 = newRecoveredTable() end
v75 = v71[v75]
v77 = "AddRightGroupbox"
v76 = v75
if type(v75) ~= "table" and type(v75) ~= "userdata" then v75 = newRecoveredTable() end
v75 = v75[v77]
v77 = "Fire rate"
v75 = ensureCallable(v75)
v75 = v75(v76, v77, v78)
v76 = "Misc"
if type(v71) ~= "table" and type(v71) ~= "userdata" then v71 = newRecoveredTable() end
v76 = v71[v76]
v78 = "AddRightGroupbox"
v77 = v76
if type(v76) ~= "table" and type(v76) ~= "userdata" then v76 = newRecoveredTable() end
v76 = v76[v78]
v78 = "Exploit"
v76 = ensureCallable(v76)
v76 = v76(v77, v78, v79)
v77 = "Misc"
if type(v71) ~= "table" and type(v71) ~= "userdata" then v71 = newRecoveredTable() end
v77 = v71[v77]
v79 = "AddLeftGroupbox"
v78 = v77
if type(v77) ~= "table" and type(v77) ~= "userdata" then v77 = newRecoveredTable() end
v77 = v77[v79]
v79 = "Misc"
v77 = ensureCallable(v77)
v77 = v77(v78, v79, v80)
v78 = "Misc"
if type(v71) ~= "table" and type(v71) ~= "userdata" then v71 = newRecoveredTable() end
v78 = v71[v78]
v80 = "AddLeftGroupbox"
v79 = v78
if type(v78) ~= "table" and type(v78) ~= "userdata" then v78 = newRecoveredTable() end
v78 = v78[v80]
v80 = "Character"
v78 = ensureCallable(v78)
v78 = v78(v79, v80, v81)
v79 = "Misc"
if type(v71) ~= "table" and type(v71) ~= "userdata" then v71 = newRecoveredTable() end
v79 = v71[v79]
v81 = "AddLeftGroupbox"
v80 = v79
if type(v79) ~= "table" and type(v79) ~= "userdata" then v79 = newRecoveredTable() end
v79 = v79[v81]
v81 = "Spawn Item"
v79 = ensureCallable(v79)
v79 = v79(v80, v81, v82)
v80 = "Misc"
if type(v71) ~= "table" and type(v71) ~= "userdata" then v71 = newRecoveredTable() end
v80 = v71[v80]
v82 = "AddRightGroupbox"
v81 = v80
if type(v80) ~= "table" and type(v80) ~= "userdata" then v80 = newRecoveredTable() end
v80 = v80[v82]
v82 = "Teleport"
v80 = ensureCallable(v80)
v80 = v80(v81, v82, v83)
if type(v71) ~= "table" and type(v71) ~= "userdata" then v71 = newRecoveredTable() end
v81 = v71.Movement
v83 = "AddLeftGroupbox"
v82 = v81
if type(v81) ~= "table" and type(v81) ~= "userdata" then v81 = newRecoveredTable() end
v81 = v81[v83]
v83 = "Flight"
v81 = ensureCallable(v81)
v81 = v81(v82, v83, v84)
if type(v71) ~= "table" and type(v71) ~= "userdata" then v71 = newRecoveredTable() end
v82 = v71.Movement
v84 = "AddRightGroupbox"
v83 = v82
if type(v82) ~= "table" and type(v82) ~= "userdata" then v82 = newRecoveredTable() end
v82 = v82[v84]
v84 = "Anti Aim"
v82 = ensureCallable(v82)
v82 = v82(v83, v84, v85)
if type(v71) ~= "table" and type(v71) ~= "userdata" then v71 = newRecoveredTable() end
v83 = v71.Visuals
v85 = "AddLeftGroupbox"
v84 = v83
if type(v83) ~= "table" and type(v83) ~= "userdata" then v83 = newRecoveredTable() end
v83 = v83[v85]
v85 = "Text esp"
v83 = ensureCallable(v83)
v83 = v83(v84, v85, v86)
if type(v71) ~= "table" and type(v71) ~= "userdata" then v71 = newRecoveredTable() end
v84 = v71.Visuals
v86 = "AddRightGroupbox"
v85 = v84
if type(v84) ~= "table" and type(v84) ~= "userdata" then v84 = newRecoveredTable() end
v84 = v84[v86]
v86 = "Tracer esp"
v84 = ensureCallable(v84)
v84 = v84(v85, v86, v87)
v87 = "AddLeftGroupbox"
v86 = v85
if type(v85) ~= "table" and type(v85) ~= "userdata" then v85 = newRecoveredTable() end
v85 = v85[v87]
v87 = "Chams esp"
v85 = ensureCallable(v85)
v85 = v85(v86, v87, v88)
v88 = "AddRightTabbox"
v87 = v86
if type(v86) ~= "table" and type(v86) ~= "userdata" then v86 = newRecoveredTable() end
v86 = v86[v88]
v86 = ensureCallable(v86)
v86 = v86(v87)
v89 = "AddTab"
v88 = v86
if type(v86) ~= "table" and type(v86) ~= "userdata" then v86 = newRecoveredTable() end
v87 = v86[v89]
v89 = "World"
v87 = ensureCallable(v87)
v87 = v87(v88, v89, v90)
v90 = "AddTab"
v89 = v86
if type(v86) ~= "table" and type(v86) ~= "userdata" then v86 = newRecoveredTable() end
v88 = v86[v90]
v90 = "Client"
v88 = ensureCallable(v88)
v88 = v88(v89, v90, v91)
v91 = "AddToggle"
v90 = v72
if type(v72) ~= "table" and type(v72) ~= "userdata" then v72 = newRecoveredTable() end
v89 = v72[v91]
v91 = "AimbotEnabled"
if type(v92) ~= "table" and type(v92) ~= "userdata" then v92 = newRecoveredTable() end
v92.Text = "Enabled"

function v94(v251)
  -- synthetic register locals stripped
  if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
  v252.Enabled = v251
end

if type(v92) ~= "table" and type(v92) ~= "userdata" then v92 = newRecoveredTable() end
if v93 == nil then v93 = "RecoveredKey" end
v92[v93] = v94
v89 = ensureCallable(v89)
v89 = v89(v90, v91, v92, v93)
v91 = "AddKeyPicker"
v90 = v89
if type(v89) ~= "table" and type(v89) ~= "userdata" then v89 = newRecoveredTable() end
v89 = v89[v91]
v91 = "LegitbotKeybind"
v93 = "Default"
v94 = "MB2"
if type(v92) ~= "table" and type(v92) ~= "userdata" then v92 = newRecoveredTable() end
if v93 == nil then v93 = "RecoveredKey" end
v92[v93] = v94
if type(v92) ~= "table" and type(v92) ~= "userdata" then v92 = newRecoveredTable() end
v92.Text = v93
v93 = "NoUI"
if type(v92) ~= "table" and type(v92) ~= "userdata" then v92 = newRecoveredTable() end
if v93 == nil then v93 = "RecoveredKey" end
v92[v93] = v94
v93 = "Callback"

function v94(v251)
  -- synthetic register locals stripped
  if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
  v252.Keybind = v251
end

if type(v92) ~= "table" and type(v92) ~= "userdata" then v92 = newRecoveredTable() end
if v93 == nil then v93 = "RecoveredKey" end
v92[v93] = v94
v93 = "ChangedCallback"

function v94(v251)
  -- synthetic register locals stripped
  if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
  v252.Keybind = v251
end

if type(v92) ~= "table" and type(v92) ~= "userdata" then v92 = newRecoveredTable() end
if v93 == nil then v93 = "RecoveredKey" end
v92[v93] = v94
v89 = ensureCallable(v89)
v89(v90, v91, v92)
v91 = "AddDropdown"
v90 = v72
if type(v72) ~= "table" and type(v72) ~= "userdata" then v72 = newRecoveredTable() end
v89 = v72[v91]
v91 = "LegitbotHitbox"
v92 = {}
v93 = "Values"
v94 = {}
v95 = "Head"
v96 = "HumanoidRootPart"
if type(v94) ~= "table" and type(v94) ~= "userdata" then v94 = newRecoveredTable() end
v94[1] = v95
if type(v94) ~= "table" and type(v94) ~= "userdata" then v94 = newRecoveredTable() end
v94[2] = v96
if type(v92) ~= "table" and type(v92) ~= "userdata" then v92 = newRecoveredTable() end
if v93 == nil then v93 = "RecoveredKey" end
v92[v93] = v94
v93 = "Callback"

function v94(v251)
  -- synthetic register locals stripped
  if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
  v252.Hitbox = v251
end

if type(v92) ~= "table" and type(v92) ~= "userdata" then v92 = newRecoveredTable() end
if v93 == nil then v93 = "RecoveredKey" end
v92[v93] = v94
v89 = ensureCallable(v89)
v89(v90, v91, v92)
v91 = "AddDropdown"
v90 = v72
if type(v72) ~= "table" and type(v72) ~= "userdata" then v72 = newRecoveredTable() end
v89 = v72[v91]
v91 = "LegitbotType"
v92 = {}
v93 = "Values"
v94 = {}
v95 = "Lock"
v96 = "Silent"
if type(v94) ~= "table" and type(v94) ~= "userdata" then v94 = newRecoveredTable() end
v94[1] = v95
if type(v94) ~= "table" and type(v94) ~= "userdata" then v94 = newRecoveredTable() end
v94[2] = v96
if type(v92) ~= "table" and type(v92) ~= "userdata" then v92 = newRecoveredTable() end
if v93 == nil then v93 = "RecoveredKey" end
v92[v93] = v94
v93 = "Callback"

function v94(v251)
  -- synthetic register locals stripped
  if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
  v252.Type = v251
end

v93 = "Min"
v94 = 1
if type(v92) ~= "table" and type(v92) ~= "userdata" then v92 = newRecoveredTable() end
if v93 == nil then v93 = "RecoveredKey" end
v92[v93] = v94
v93 = "Max"
v94 = 100
if type(v92) ~= "table" and type(v92) ~= "userdata" then v92 = newRecoveredTable() end
if v93 == nil then v93 = "RecoveredKey" end
v92[v93] = v94
v93 = "Rounding"
v94 = 1
if type(v92) ~= "table" and type(v92) ~= "userdata" then v92 = newRecoveredTable() end
if v93 == nil then v93 = "RecoveredKey" end
v92[v93] = v94
v93 = "Compact"
if type(v92) ~= "table" and type(v92) ~= "userdata" then v92 = newRecoveredTable() end
if v93 == nil then v93 = "RecoveredKey" end
v92[v93] = v94
v93 = "Callback"

function v94(v251)
  -- synthetic register locals stripped
  v253 = v251 / 100
  if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
  v252.Smoothness = v253
end

if type(v92) ~= "table" and type(v92) ~= "userdata" then v92 = newRecoveredTable() end
if v93 == nil then v93 = "RecoveredKey" end
v92[v93] = v94
v89 = ensureCallable(v89)
v89(v90, v91, v92)
v91 = "AddToggle"
v90 = v72
if type(v72) ~= "table" and type(v72) ~= "userdata" then v72 = newRecoveredTable() end
v89 = v72[v91]
v91 = "LegitBotLine"
v93 = "Target line"
if type(v92) ~= "table" and type(v92) ~= "userdata" then v92 = newRecoveredTable() end
v92.Text = v93

function v94(v251)
  -- synthetic register locals stripped
  if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
  v252.Line = v251
end

if type(v92) ~= "table" and type(v92) ~= "userdata" then v92 = newRecoveredTable() end
v92.Text = "Enabled"

function v94(v251)
  -- synthetic register locals stripped
  if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
  v252.FieldOfView = v251
end

if type(v92) ~= "table" and type(v92) ~= "userdata" then v92 = newRecoveredTable() end
if v93 == nil then v93 = "RecoveredKey" end
v92[v93] = v94
v93 = "Min"
v94 = 1
if type(v92) ~= "table" and type(v92) ~= "userdata" then v92 = newRecoveredTable() end
if v93 == nil then v93 = "RecoveredKey" end
v92[v93] = v94
v93 = "Max"
v94 = 360
if type(v92) ~= "table" and type(v92) ~= "userdata" then v92 = newRecoveredTable() end
if v93 == nil then v93 = "RecoveredKey" end
v92[v93] = v94
v93 = "Rounding"
v94 = 1
if type(v92) ~= "table" and type(v92) ~= "userdata" then v92 = newRecoveredTable() end
if v93 == nil then v93 = "RecoveredKey" end
v92[v93] = v94
v93 = "Compact"
if type(v92) ~= "table" and type(v92) ~= "userdata" then v92 = newRecoveredTable() end
if v93 == nil then v93 = "RecoveredKey" end
v92[v93] = v94
v93 = "Callback"

function v94(v251)
  -- synthetic register locals stripped
  if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
  v252.Fov = v251
end

if type(v92) ~= "table" and type(v92) ~= "userdata" then v92 = newRecoveredTable() end
v92.Text = "Enabled"

function v94(v251)
  -- synthetic register locals stripped
  if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
  v252.Teamcheck = v251
end

if type(v92) ~= "table" and type(v92) ~= "userdata" then v92 = newRecoveredTable() end
v92.Text = "Enabled"

function v94(v251)
  -- synthetic register locals stripped
  if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
  v252.Wallcheck = v251
end

if type(v92) ~= "table" and type(v92) ~= "userdata" then v92 = newRecoveredTable() end
if v93 == nil then v93 = "RecoveredKey" end
v92[v93] = v94
v89 = ensureCallable(v89)
v89(v90, v91, v92)
v91 = "AddToggle"
v90 = v73
if type(v73) ~= "table" and type(v73) ~= "userdata" then v73 = newRecoveredTable() end
v89 = v73[v91]
v91 = "TriggerbotEnabled"
v92 = {}
if type(v92) ~= "table" and type(v92) ~= "userdata" then v92 = newRecoveredTable() end
v92.Text = "Enabled"
v93 = "Default"
v94 = false
if type(v92) ~= "table" and type(v92) ~= "userdata" then v92 = newRecoveredTable() end
if v93 == nil then v93 = "RecoveredKey" end
v92[v93] = v94
v93 = "Tooltip"
v94 = "Enables triggerbot"
if type(v92) ~= "table" and type(v92) ~= "userdata" then v92 = newRecoveredTable() end
if v93 == nil then v93 = "RecoveredKey" end
v92[v93] = v94
v93 = "Callback"

function v94(v251)
  -- synthetic register locals stripped
  if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
  v252.Enabled = v251
end

if type(v92) ~= "table" and type(v92) ~= "userdata" then v92 = newRecoveredTable() end
if v93 == nil then v93 = "RecoveredKey" end
v92[v93] = v94
v89 = ensureCallable(v89)
v89(v90, v91, v92)
v91 = "AddToggle"
v90 = v73
if type(v73) ~= "table" and type(v73) ~= "userdata" then v73 = newRecoveredTable() end
v89 = v73[v91]
v91 = "TriggerbotEnabled"
v93 = "Team check"
if type(v92) ~= "table" and type(v92) ~= "userdata" then v92 = newRecoveredTable() end
v92.Text = v93

function v94(v251)
  -- synthetic register locals stripped
  if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
  v252.Teamcheck = v251
end

if type(v92) ~= "table" and type(v92) ~= "userdata" then v92 = newRecoveredTable() end
if v93 == nil then v93 = "RecoveredKey" end
v92[v93] = v94
v93 = "Min"
v94 = 0
if type(v92) ~= "table" and type(v92) ~= "userdata" then v92 = newRecoveredTable() end
if v93 == nil then v93 = "RecoveredKey" end
v92[v93] = v94
v93 = "Max"
v94 = 100
if type(v92) ~= "table" and type(v92) ~= "userdata" then v92 = newRecoveredTable() end
if v93 == nil then v93 = "RecoveredKey" end
v92[v93] = v94
v93 = "Rounding"
v94 = 1
if type(v92) ~= "table" and type(v92) ~= "userdata" then v92 = newRecoveredTable() end
if v93 == nil then v93 = "RecoveredKey" end
v92[v93] = v94
v93 = "Compact"
if type(v92) ~= "table" and type(v92) ~= "userdata" then v92 = newRecoveredTable() end
if v93 == nil then v93 = "RecoveredKey" end
v92[v93] = v94
v93 = "Callback"

function v94(v251)
  -- synthetic register locals stripped
  v253 = v251 / 100
  if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
  v252.ReactionTime = v253
end

if type(v92) ~= "table" and type(v92) ~= "userdata" then v92 = newRecoveredTable() end
if v93 == nil then v93 = "RecoveredKey" end
v92[v93] = v94
v89 = ensureCallable(v89)
v89(v90, v91, v92)
v91 = "AddToggle"
v90 = v74
if type(v74) ~= "table" and type(v74) ~= "userdata" then v74 = newRecoveredTable() end
v89 = v74[v91]
v91 = "HitboxEnabled"
v92 = {}
if type(v92) ~= "table" and type(v92) ~= "userdata" then v92 = newRecoveredTable() end
v92.Text = "Enabled"
v93 = "Default"
v94 = false
if type(v92) ~= "table" and type(v92) ~= "userdata" then v92 = newRecoveredTable() end
if v93 == nil then v93 = "RecoveredKey" end
v92[v93] = v94
v93 = "Tooltip"
v94 = "Expands hitbox"
if type(v92) ~= "table" and type(v92) ~= "userdata" then v92 = newRecoveredTable() end
if v93 == nil then v93 = "RecoveredKey" end
v92[v93] = v94
v93 = "Callback"

function v94(v251)
  -- synthetic register locals stripped
  if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
  v252.Enabled = v251
end

if type(v92) ~= "table" and type(v92) ~= "userdata" then v92 = newRecoveredTable() end
if v93 == nil then v93 = "RecoveredKey" end
v92[v93] = v94
v89 = ensureCallable(v89)
v89(v90, v91, v92)
v91 = "AddDropdown"
v90 = v74
if type(v74) ~= "table" and type(v74) ~= "userdata" then v74 = newRecoveredTable() end
v89 = v74[v91]
v91 = "HitboxOptions"
v92 = {}
v93 = "Values"
v94 = {}
v95 = "HumanoidRootPart"
v96 = "Head"
if type(v94) ~= "table" and type(v94) ~= "userdata" then v94 = newRecoveredTable() end
v94[1] = v95
if type(v94) ~= "table" and type(v94) ~= "userdata" then v94 = newRecoveredTable() end
v94[2] = v96
if type(v92) ~= "table" and type(v92) ~= "userdata" then v92 = newRecoveredTable() end
if v93 == nil then v93 = "RecoveredKey" end
v92[v93] = v94
v93 = "Callback"

function v94(v251)
  -- synthetic register locals stripped
  if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
  v252.Hitbox = v251
end

if type(v92) ~= "table" and type(v92) ~= "userdata" then v92 = newRecoveredTable() end
if v93 == nil then v93 = "RecoveredKey" end
v92[v93] = v94
v93 = "Min"
v94 = 1
if type(v92) ~= "table" and type(v92) ~= "userdata" then v92 = newRecoveredTable() end
if v93 == nil then v93 = "RecoveredKey" end
v92[v93] = v94
v93 = "Max"
v94 = 100
if type(v92) ~= "table" and type(v92) ~= "userdata" then v92 = newRecoveredTable() end
if v93 == nil then v93 = "RecoveredKey" end
v92[v93] = v94
v93 = "Rounding"
v94 = 1
if type(v92) ~= "table" and type(v92) ~= "userdata" then v92 = newRecoveredTable() end
if v93 == nil then v93 = "RecoveredKey" end
v92[v93] = v94
v93 = "Compact"
if type(v92) ~= "table" and type(v92) ~= "userdata" then v92 = newRecoveredTable() end
if v93 == nil then v93 = "RecoveredKey" end
v92[v93] = v94
v93 = "Callback"

function v94(v251)
  -- synthetic register locals stripped
  if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
  v252.Size = v251
end

if type(v92) ~= "table" and type(v92) ~= "userdata" then v92 = newRecoveredTable() end
if v93 == nil then v93 = "RecoveredKey" end
v92[v93] = v94
v89 = ensureCallable(v89)
v89(v90, v91, v92)
v89 = {}
v90 = false
if type(v89) ~= "table" and type(v89) ~= "userdata" then v89 = newRecoveredTable() end
v89.Enabled = v90
v90 = "Range"
v91 = 20
if type(v89) ~= "table" and type(v89) ~= "userdata" then v89 = newRecoveredTable() end
if v90 == nil then v90 = "RecoveredKey" end
v89[v90] = v91
v92 = "AddLabel"
v91 = v74
if type(v74) ~= "table" and type(v74) ~= "userdata" then v74 = newRecoveredTable() end
v90 = v74[v92]
v92 = "Melee aura"
v90 = ensureCallable(v90)
v90(v91, v92)
v92 = "AddToggle"
v91 = v74
if type(v74) ~= "table" and type(v74) ~= "userdata" then v74 = newRecoveredTable() end
v90 = v74[v92]
v92 = "MeleeEnabled"
if type(v93) ~= "table" and type(v93) ~= "userdata" then v93 = newRecoveredTable() end
v93.Text = "Enabled"

function v95(v251)
  -- synthetic register locals stripped
  if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
  v252.Enabled = v251
end

if type(v93) ~= "table" and type(v93) ~= "userdata" then v93 = newRecoveredTable() end
if v94 == nil then v94 = "RecoveredKey" end
v93[v94] = v95
v94 = "Min"
v95 = 1
if type(v93) ~= "table" and type(v93) ~= "userdata" then v93 = newRecoveredTable() end
if v94 == nil then v94 = "RecoveredKey" end
v93[v94] = v95
v94 = "Max"
v95 = 100
if type(v93) ~= "table" and type(v93) ~= "userdata" then v93 = newRecoveredTable() end
if v94 == nil then v94 = "RecoveredKey" end
v93[v94] = v95
v94 = "Rounding"
v95 = 1
if type(v93) ~= "table" and type(v93) ~= "userdata" then v93 = newRecoveredTable() end
if v94 == nil then v94 = "RecoveredKey" end
v93[v94] = v95
v94 = "Compact"
if type(v93) ~= "table" and type(v93) ~= "userdata" then v93 = newRecoveredTable() end
if v94 == nil then v94 = "RecoveredKey" end
v93[v94] = v95
v94 = "Callback"

function v95(v251)
  -- synthetic register locals stripped
  if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
  v252.Range = v251
end

if type(v93) ~= "table" and type(v93) ~= "userdata" then v93 = newRecoveredTable() end
if v94 == nil then v94 = "RecoveredKey" end
v93[v94] = v95
v90 = ensureCallable(v90)
v90(v91, v92, v93)
v91 = "FireRate"
if type(v92) ~= "table" and type(v92) ~= "userdata" then v92 = newRecoveredTable() end
v92.Enabled = v93
v93 = 6000
if type(v92) ~= "table" and type(v92) ~= "userdata" then v92 = newRecoveredTable() end
v92.Value = v93
if type(v90) ~= "table" and type(v90) ~= "userdata" then v90 = newRecoveredTable() end
if v91 == nil then v91 = "RecoveredKey" end
v90[v91] = v92
v91 = "Spread"
if type(v92) ~= "table" and type(v92) ~= "userdata" then v92 = newRecoveredTable() end
v92.Enabled = v93
v93 = 0
if type(v92) ~= "table" and type(v92) ~= "userdata" then v92 = newRecoveredTable() end
v92.Value = v93
if type(v90) ~= "table" and type(v90) ~= "userdata" then v90 = newRecoveredTable() end
if v91 == nil then v91 = "RecoveredKey" end
v90[v91] = v92
v91 = "Reload"
if type(v92) ~= "table" and type(v92) ~= "userdata" then v92 = newRecoveredTable() end
v92.Enabled = v93
v93 = 0
if type(v92) ~= "table" and type(v92) ~= "userdata" then v92 = newRecoveredTable() end
v92.Value = v93
if type(v90) ~= "table" and type(v90) ~= "userdata" then v90 = newRecoveredTable() end
if v91 == nil then v91 = "RecoveredKey" end
v90[v91] = v92
v91 = "MaxAmmo"
if type(v92) ~= "table" and type(v92) ~= "userdata" then v92 = newRecoveredTable() end
v92.Enabled = v93
v93 = 60
if type(v92) ~= "table" and type(v92) ~= "userdata" then v92 = newRecoveredTable() end
v92.Value = v93
if type(v90) ~= "table" and type(v90) ~= "userdata" then v90 = newRecoveredTable() end
if v91 == nil then v91 = "RecoveredKey" end
v90[v91] = v92
v93 = "AddToggle"
v92 = v75
if type(v75) ~= "table" and type(v75) ~= "userdata" then v75 = newRecoveredTable() end
v91 = v75[v93]
v93 = "FireRate"
if type(v94) ~= "table" and type(v94) ~= "userdata" then v94 = newRecoveredTable() end
v94.Text = "Enabled"

function v96(v251)
  -- synthetic register locals stripped
  if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
  v252.Enabled = v251
  if v251 then
    if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
    v252 = v252.editVal
    v253 = v1015
    v254 = "RPM"
    v255 = v1012
    if type(v255) ~= "table" and type(v255) ~= "userdata" then v255 = newRecoveredTable() end
    v255 = v255.FireRate
    if type(v255) ~= "table" and type(v255) ~= "userdata" then v255 = newRecoveredTable() end
    v255 = v255.Value
    v252 = ensureCallable(v252)
    v252(v253, v254, v255)
  end
  if false then -- removed constant-true decompiler loop
  end
end

v95 = "Min"
v96 = 1
if type(v94) ~= "table" and type(v94) ~= "userdata" then v94 = newRecoveredTable() end
if v95 == nil then v95 = "RecoveredKey" end
v94[v95] = v96
v95 = "Max"
v96 = 6000
if type(v94) ~= "table" and type(v94) ~= "userdata" then v94 = newRecoveredTable() end
if v95 == nil then v95 = "RecoveredKey" end
v94[v95] = v96
v95 = "Rounding"
v96 = 1
if type(v94) ~= "table" and type(v94) ~= "userdata" then v94 = newRecoveredTable() end
if v95 == nil then v95 = "RecoveredKey" end
v94[v95] = v96
v95 = "Compact"
if type(v94) ~= "table" and type(v94) ~= "userdata" then v94 = newRecoveredTable() end
if v95 == nil then v95 = "RecoveredKey" end
v94[v95] = v96
v95 = "Callback"

function v96(v251)
  -- synthetic register locals stripped
  -- removed decompiler goto
  if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
  v252 = v252.editVal
  v253 = v1015
  v254 = "RPM"
  v255 = v1012
  if type(v255) ~= "table" and type(v255) ~= "userdata" then v255 = newRecoveredTable() end
  v255 = v255.FireRate
  if type(v255) ~= "table" and type(v255) ~= "userdata" then v255 = newRecoveredTable() end
  v255 = v255.Value
  -- removed decompiler label lbl_8
  v252 = ensureCallable(v252)
  v252(v253, v254, v255)
end

if type(v94) ~= "table" and type(v94) ~= "userdata" then v94 = newRecoveredTable() end
v94.Text = "Enabled"

function v96(v251)
  -- synthetic register locals stripped
  if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
  v252.Enabled = v251
  if not v251 then
  end
  -- removed decompiler goto
  if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
  v252 = v252.editVal
  v253 = v1015
  v254 = "Spread"
  v255 = v1012
  if type(v255) ~= "table" and type(v255) ~= "userdata" then v255 = newRecoveredTable() end
  v255 = v255.FireRate
  if type(v255) ~= "table" and type(v255) ~= "userdata" then v255 = newRecoveredTable() end
  v255 = v255.Value
  v252 = ensureCallable(v252)
  v252(v253, v254, v255)
  -- removed decompiler label lbl_12
  if false then -- removed constant-true decompiler loop
  end
end

v95 = "Min"
v96 = 0
if type(v94) ~= "table" and type(v94) ~= "userdata" then v94 = newRecoveredTable() end
if v95 == nil then v95 = "RecoveredKey" end
v94[v95] = v96
v95 = "Max"
v96 = 50
if type(v94) ~= "table" and type(v94) ~= "userdata" then v94 = newRecoveredTable() end
if v95 == nil then v95 = "RecoveredKey" end
v94[v95] = v96
v95 = "Rounding"
v96 = 1
if type(v94) ~= "table" and type(v94) ~= "userdata" then v94 = newRecoveredTable() end
if v95 == nil then v95 = "RecoveredKey" end
v94[v95] = v96
v95 = "Compact"
if type(v94) ~= "table" and type(v94) ~= "userdata" then v94 = newRecoveredTable() end
if v95 == nil then v95 = "RecoveredKey" end
v94[v95] = v96
v95 = "Callback"

function v96(v251)
  -- synthetic register locals stripped
  -- removed decompiler goto
  if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
  v252 = v252.editVal
  v253 = v1015
  v254 = "Spread"
  v255 = v1012
  if type(v255) ~= "table" and type(v255) ~= "userdata" then v255 = newRecoveredTable() end
  v255 = v255.FireRate
  if type(v255) ~= "table" and type(v255) ~= "userdata" then v255 = newRecoveredTable() end
  v255 = v255.Value
  -- removed decompiler label lbl_8
  v252 = ensureCallable(v252)
  v252(v253, v254, v255)
end

if type(v94) ~= "table" and type(v94) ~= "userdata" then v94 = newRecoveredTable() end
v94.Text = "Enabled"

function v96(v251)
  -- synthetic register locals stripped
  if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
  v252.Enabled = v251
end

if type(v94) ~= "table" and type(v94) ~= "userdata" then v94 = newRecoveredTable() end
if v95 == nil then v95 = "RecoveredKey" end
v94[v95] = v96
v91 = ensureCallable(v91)
v91(v92, v93, v94)
v93 = "AddToggle"
v92 = v76
if type(v76) ~= "table" and type(v76) ~= "userdata" then v76 = newRecoveredTable() end
v91 = v76[v93]
v93 = "ACBypass"
v95 = "Anticheat bypass"
if type(v94) ~= "table" and type(v94) ~= "userdata" then v94 = newRecoveredTable() end
v94.Text = v95

function v96(v251)
  -- synthetic register locals stripped
  if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
  v252.Enabled = v251
end

if type(v94) ~= "table" and type(v94) ~= "userdata" then v94 = newRecoveredTable() end
if v95 == nil then v95 = "RecoveredKey" end
v94[v95] = v96
v91 = ensureCallable(v91)
v91(v92, v93, v94)
v92 = 0.15
v93 = 0.15
v96 = "AddButton"
v95 = v76
if type(v76) ~= "table" and type(v76) ~= "userdata" then v76 = newRecoveredTable() end
v94 = v76[v96]
v97 = "Bruteforce building"
if type(v96) ~= "table" and type(v96) ~= "userdata" then v96 = newRecoveredTable() end
v96.Text = v97
v97 = "Func"

function v98()
  -- synthetic register locals stripped
  -- removed decompiler goto
  -- removed decompiler label lbl_2
  do return end
  v255 = v758
  if type(v758) ~= "table" and type(v758) ~= "userdata" then v758 = newRecoveredTable() end
  v254 = v758.GetMouse
  v254 = ensureCallable(v254)
  v254 = v254(v255)
  v256 = nil
  v257 = nil
  if v258 == "Doors" then
  end
  -- removed decompiler goto
  if v258 == "Doors" then
  end
  -- removed decompiler label lbl_11
  v260 = v257
  if type(v257) ~= "table" and type(v257) ~= "userdata" then v257 = newRecoveredTable() end
  v259 = v257.GetDescendants
  -- synthetic vararg register fan-out stripped
  -- trimmed huge synthetic register fan-out
  v258, v259, v260 = v258(v259, v260, v261, v262, v263, v264, v265, v266)
  if false then -- removed constant-true decompiler loop
    -- removed decompiler goto
    if v263 == "Authorized" then
    end
    -- removed decompiler label lbl_17
    -- removed decompiler goto
    -- removed decompiler label lbl_19
  end
  v259 = "Drown Tick"
  v260 = false
  if type(v253) ~= "table" and type(v253) ~= "userdata" then v253 = newRecoveredTable() end
  v261 = v253.MaxHealth
  if type(v253) ~= "table" and type(v253) ~= "userdata" then v253 = newRecoveredTable() end
  v262 = v253.Health
  v261 = v261 - v262
  v261 = -v261
  v261 = v261 / 5
  v262 = nil
  if type(v258) ~= "table" and type(v258) ~= "userdata" then v258 = newRecoveredTable() end
  v258[1] = v259
  if type(v258) ~= "table" and type(v258) ~= "userdata" then v258 = newRecoveredTable() end
  v258[2] = v260
  if type(v258) ~= "table" and type(v258) ~= "userdata" then v258 = newRecoveredTable() end
  v258[3] = v261
  if type(v258) ~= "table" and type(v258) ~= "userdata" then v258 = newRecoveredTable() end
  v258[4] = v262
  v260 = v259
  if type(v259) ~= "table" and type(v259) ~= "userdata" then v259 = newRecoveredTable() end
  v259 = v259.GetService
  v261 = "ReplicatedStorage"
  v259 = ensureCallable(v259)
  v259 = v259(v260, v261, v262)
  v260 = v259
  if type(v259) ~= "table" and type(v259) ~= "userdata" then v259 = newRecoveredTable() end
  v259 = v259.WaitForChild
  v261 = "Remotes"
  v259 = ensureCallable(v259)
  v259 = v259(v260, v261, v262)
  v260 = v259
  if type(v259) ~= "table" and type(v259) ~= "userdata" then v259 = newRecoveredTable() end
  v259 = v259.WaitForChild
  v261 = "RemoteEvent"
  v259 = ensureCallable(v259)
  v259 = v259(v260, v261, v262)
  v260 = v259
  if type(v259) ~= "table" and type(v259) ~= "userdata" then v259 = newRecoveredTable() end
  v259 = v259.FireServer
  v261 = unpack
  v262 = v258
  -- synthetic vararg register fan-out stripped
  -- trimmed huge synthetic register fan-out
  v259(v260, v261, v262, v263, v264, v265, v266, v267)
  v259 = 1000
  v260 = 1
  v261 = 2250
  v262 = 1
  for v263 = v260, v261, v262 do
    if not v253 then
    end
    -- removed decompiler goto
    v264 = nil
    -- removed decompiler goto
    -- removed decompiler label lbl_53
    -- removed decompiler goto
    v266 = v265
    if type(v265) ~= "table" and type(v265) ~= "userdata" then v265 = newRecoveredTable() end
    v265 = v265.Notify
    v267 = "BRUTEFORCED! Code lock is in between: "
    v268 = tostring
    v269 = v259
    v268 = ensureCallable(v268)
    v268 = v268(v269)
    v269 = "-"
    v270 = tostring
    v271 = v259 - 4
    v270 = ensureCallable(v270)
    v270 = v270(v271)
    v271 = " (if doesnt work try removing 1-5 or adding 1-5 numbers)"
    v267 = v267 .. v268 .. v269 .. v270 .. v271
    v268 = 8
    v265 = ensureCallable(v265)
    v265(v266, v267, v268)
    v265 = v1012
    if type(v265) ~= "table" and type(v265) ~= "userdata" then v265 = newRecoveredTable() end
    v265 = v265.log
    v266 = "BRUTEFORCED"
    v267 = "Codelock is in between: "
    v268 = tostring
    v269 = v259
    v268 = ensureCallable(v268)
    v268 = v268(v269)
    v269 = "-"
    v270 = tostring
    v271 = v259 - 4
    v270 = ensureCallable(v270)
    v270 = v270(v271)
    v267 = v267 .. v268 .. v269 .. v270
    v268 = "(SERVER)"
    v265 = ensureCallable(v265)
    v265(v266, v267, v268)
    -- removed decompiler label lbl_81
    -- removed decompiler goto
    v265 = 1
    v266 = 4
    v267 = 1
    for v268 = v265, v266, v267 do
      v270 = v256
      if type(v256) ~= "table" and type(v256) ~= "userdata" then v256 = newRecoveredTable() end
      v269 = v256.FindFirstChild
      v269 = ensureCallable(v269)
      v269 = v269(v270, v271, v272)
      if v264 then
        v270 = v269
        if type(v269) ~= "table" and type(v269) ~= "userdata" then v269 = newRecoveredTable() end
        v269 = v269.Notify
        v271 = "BRUTEFORCED! Code lock is in between: "
        v272 = tostring
        v273 = v259
        v272 = ensureCallable(v272)
        v272 = v272(v273)
        v273 = "-"
        v274 = tostring
        v275 = v259 - 4
        v274 = ensureCallable(v274)
        v274 = v274(v275)
        v275 = " (if doesnt work try removing 1-5 or adding 1-5 numbers)"
        v271 = v271 .. v272 .. v273 .. v274 .. v275
        v272 = 8
        v269 = ensureCallable(v269)
        v269(v270, v271, v272)
        v269 = v1012
        if type(v269) ~= "table" and type(v269) ~= "userdata" then v269 = newRecoveredTable() end
        v269 = v269.log
        v270 = "BRUTEFORCED"
        v271 = "Codelock is in between: "
        v272 = tostring
        v273 = v259
        v272 = ensureCallable(v272)
        v272 = v272(v273)
        v273 = "-"
        v274 = tostring
        v275 = v259 - 4
        v274 = ensureCallable(v274)
        v274 = v274(v275)
        v271 = v271 .. v272 .. v273 .. v274
        v272 = "(SERVER)"
        v269 = ensureCallable(v269)
        v269(v270, v271, v272)
      end
      -- removed decompiler goto
      v259 = v259 + 1
      v270 = "Try Unlock Lock"
      v274 = 24
      v275 = 43
      v276 = 23
      v277 = 2
      v278 = 17
      v279 = 25
      v280 = 35
      v281 = 24
      v282 = 7
      v283 = 48
      v284 = 45
      v285 = 40
      v286 = 48
      v287 = 34
      v288 = 7
      v289 = 42
      v290 = 20
      v291 = 9
      v292 = 38
      v293 = 41
      v294 = 31
      v295 = 50
      v296 = 10
      v297 = 17
      v298 = 14
      v299 = 44
      v300 = 6
      v301 = 14
      v302 = 48
      v303 = 40
      v304 = 15
      v305 = 34
      v306 = 41
      v307 = 9
      v308 = 28
      v271 = v270
      if type(v270) ~= "table" and type(v270) ~= "userdata" then v270 = newRecoveredTable() end
      v270 = v270.GetService
      v272 = "ReplicatedStorage"
      v270 = ensureCallable(v270)
      v270 = v270(v271, v272, v273)
      v271 = v270
      if type(v270) ~= "table" and type(v270) ~= "userdata" then v270 = newRecoveredTable() end
      v270 = v270.WaitForChild
      v272 = "Remotes"
      v270 = ensureCallable(v270)
      v270 = v270(v271, v272, v273)
      v271 = v270
      if type(v270) ~= "table" and type(v270) ~= "userdata" then v270 = newRecoveredTable() end
      v270 = v270.WaitForChild
      v272 = "RemoteEvent"
      v270 = ensureCallable(v270)
      v270 = v270(v271, v272, v273)
      v271 = v270
      if type(v270) ~= "table" and type(v270) ~= "userdata" then v270 = newRecoveredTable() end
      v270 = v270.FireServer
      v272 = unpack
      v273 = v269
  -- synthetic vararg register fan-out stripped
      -- trimmed huge synthetic register fan-out
      v270(v271, v272, v273, v274, v275, v276, v277, v278)
      v270 = ensureCallable(v270)
      v270(v271)
      -- removed decompiler label lbl_170
    end
    if not v264 then
      v266 = "Drown Tick"
      v267 = false
      if type(v253) ~= "table" and type(v253) ~= "userdata" then v253 = newRecoveredTable() end
      v268 = v253.MaxHealth
      if type(v253) ~= "table" and type(v253) ~= "userdata" then v253 = newRecoveredTable() end
      v269 = v253.Health
      v268 = v268 - v269
      v268 = -v268
      v268 = v268 / 7
      v269 = nil
      if type(v265) ~= "table" and type(v265) ~= "userdata" then v265 = newRecoveredTable() end
      v265[1] = v266
      if type(v265) ~= "table" and type(v265) ~= "userdata" then v265 = newRecoveredTable() end
      v265[2] = v267
      if type(v265) ~= "table" and type(v265) ~= "userdata" then v265 = newRecoveredTable() end
      v265[3] = v268
      if type(v265) ~= "table" and type(v265) ~= "userdata" then v265 = newRecoveredTable() end
      v265[4] = v269
      v267 = v266
      if type(v266) ~= "table" and type(v266) ~= "userdata" then v266 = newRecoveredTable() end
      v266 = v266.GetService
      v268 = "ReplicatedStorage"
      v266 = ensureCallable(v266)
      v266 = v266(v267, v268, v269)
      v267 = v266
      if type(v266) ~= "table" and type(v266) ~= "userdata" then v266 = newRecoveredTable() end
      v266 = v266.WaitForChild
      v268 = "Remotes"
      v266 = ensureCallable(v266)
      v266 = v266(v267, v268, v269)
      v267 = v266
      if type(v266) ~= "table" and type(v266) ~= "userdata" then v266 = newRecoveredTable() end
      v266 = v266.WaitForChild
      v268 = "RemoteEvent"
      v266 = ensureCallable(v266)
      v266 = v266(v267, v268, v269)
      v267 = v266
      if type(v266) ~= "table" and type(v266) ~= "userdata" then v266 = newRecoveredTable() end
      v266 = v266.FireServer
      v268 = unpack
      v269 = v265
  -- synthetic vararg register fan-out stripped
    end
    -- trimmed huge synthetic register fan-out
    v266(v267, v268, v269, v270, v271, v272, v273, v274)
    v265 = ensureCallable(v265)
    v265(v266)
    -- removed decompiler label lbl_197
  end
end

if type(v96) ~= "table" and type(v96) ~= "userdata" then v96 = newRecoveredTable() end
if v97 == nil then v97 = "RecoveredKey" end
v96[v97] = v98
v97 = "DoubleClick"
if type(v96) ~= "table" and type(v96) ~= "userdata" then v96 = newRecoveredTable() end
if v97 == nil then v97 = "RecoveredKey" end
v96[v97] = v98
v97 = "Tooltip"
v98 = "Bruteforces the building on your cursor ( DISABLE GODMODE )"
if type(v96) ~= "table" and type(v96) ~= "userdata" then v96 = newRecoveredTable() end
if v97 == nil then v97 = "RecoveredKey" end
v96[v97] = v98
v94 = ensureCallable(v94)
v94 = v94(v95, v96, v97)
v97 = "AddSlider"
v96 = v76
if type(v76) ~= "table" and type(v76) ~= "userdata" then v76 = newRecoveredTable() end
v95 = v76[v97]
v97 = "HopSpeed"
v99 = "Bruteforce hopspeed"
if type(v98) ~= "table" and type(v98) ~= "userdata" then v98 = newRecoveredTable() end
v98.Text = v99
v99 = "Default"
v100 = 15
if type(v98) ~= "table" and type(v98) ~= "userdata" then v98 = newRecoveredTable() end
if v99 == nil then v99 = "RecoveredKey" end
v98[v99] = v100
v99 = "Min"
v100 = 0
if type(v98) ~= "table" and type(v98) ~= "userdata" then v98 = newRecoveredTable() end
if v99 == nil then v99 = "RecoveredKey" end
v98[v99] = v100
v99 = "Max"
v100 = 100
if type(v98) ~= "table" and type(v98) ~= "userdata" then v98 = newRecoveredTable() end
if v99 == nil then v99 = "RecoveredKey" end
v98[v99] = v100
v99 = "Rounding"
v100 = 1
if type(v98) ~= "table" and type(v98) ~= "userdata" then v98 = newRecoveredTable() end
if v99 == nil then v99 = "RecoveredKey" end
v98[v99] = v100
v99 = "Compact"
v100 = false
if type(v98) ~= "table" and type(v98) ~= "userdata" then v98 = newRecoveredTable() end
if v99 == nil then v99 = "RecoveredKey" end
v98[v99] = v100
v99 = "Callback"

function v100(v251)
  -- synthetic register locals stripped
  v252 = v251 / 100
end

if type(v98) ~= "table" and type(v98) ~= "userdata" then v98 = newRecoveredTable() end
if v99 == nil then v99 = "RecoveredKey" end
v98[v99] = v100
v99 = "Min"
v100 = 0
if type(v98) ~= "table" and type(v98) ~= "userdata" then v98 = newRecoveredTable() end
if v99 == nil then v99 = "RecoveredKey" end
v98[v99] = v100
v99 = "Max"
v100 = 100
if type(v98) ~= "table" and type(v98) ~= "userdata" then v98 = newRecoveredTable() end
if v99 == nil then v99 = "RecoveredKey" end
v98[v99] = v100
v99 = "Rounding"
v100 = 1
if type(v98) ~= "table" and type(v98) ~= "userdata" then v98 = newRecoveredTable() end
if v99 == nil then v99 = "RecoveredKey" end
v98[v99] = v100
v99 = "Compact"
if type(v98) ~= "table" and type(v98) ~= "userdata" then v98 = newRecoveredTable() end
if v99 == nil then v99 = "RecoveredKey" end
v98[v99] = v100
v99 = "Callback"

function v100(v251)
  -- synthetic register locals stripped
  v252 = v251 / 100
end

if type(v98) ~= "table" and type(v98) ~= "userdata" then v98 = newRecoveredTable() end
v98.Text = "Enabled"

function v100(v251)
  -- synthetic register locals stripped
  v254 = v253
  if type(v253) ~= "table" and type(v253) ~= "userdata" then v253 = newRecoveredTable() end
  v253 = v253.GetService
  v255 = "ReplicatedStorage"
  v253 = ensureCallable(v253)
  v253 = v253(v254, v255, v256)
  v254 = v253
  if type(v253) ~= "table" and type(v253) ~= "userdata" then v253 = newRecoveredTable() end
  v253 = v253.WaitForChild
  v255 = "Remotes"
  v253 = ensureCallable(v253)
  v253 = v253(v254, v255, v256)
  v254 = v253
  if type(v253) ~= "table" and type(v253) ~= "userdata" then v253 = newRecoveredTable() end
  v253 = v253.WaitForChild
  v255 = "RemoteEvent"
  v253 = ensureCallable(v253)
  v253 = v253(v254, v255, v256)
  v254 = v253
  if type(v253) ~= "table" and type(v253) ~= "userdata" then v253 = newRecoveredTable() end
  v253 = v253.FireServer
  v255 = unpack
  v256 = v252
  -- synthetic vararg register fan-out stripped
  -- trimmed huge synthetic register fan-out
  v253(v254, v255, v256, v257, v258, v259, v260, v261)
end

if type(v98) ~= "table" and type(v98) ~= "userdata" then v98 = newRecoveredTable() end
if v99 == nil then v99 = "RecoveredKey" end
v98[v99] = v100
v95 = ensureCallable(v95)
v95(v96, v97, v98)
v97 = "AddLabel"
v96 = v78
if type(v78) ~= "table" and type(v78) ~= "userdata" then v78 = newRecoveredTable() end
v95 = v78[v97]
v97 = "Semi noclip"
v95 = ensureCallable(v95)
v95(v96, v97)
v95 = false
v98 = "AddToggle"
v97 = v78
if type(v78) ~= "table" and type(v78) ~= "userdata" then v78 = newRecoveredTable() end
v96 = v78[v98]
v98 = "SemiNoclips"
if type(v99) ~= "table" and type(v99) ~= "userdata" then v99 = newRecoveredTable() end
v99.Text = "Enabled"

function v101(v251)
  -- synthetic register locals stripped
end

if type(v99) ~= "table" and type(v99) ~= "userdata" then v99 = newRecoveredTable() end
if v100 == nil then v100 = "RecoveredKey" end
v99[v100] = v101
v96 = ensureCallable(v96)
v96 = v96(v97, v98, v99, v100)
v98 = "AddKeyPicker"
v97 = v96
if type(v96) ~= "table" and type(v96) ~= "userdata" then v96 = newRecoveredTable() end
v96 = v96[v98]
v98 = "SemiNoclip"
v100 = "Default"
v101 = "Z"
if type(v99) ~= "table" and type(v99) ~= "userdata" then v99 = newRecoveredTable() end
if v100 == nil then v100 = "RecoveredKey" end
v99[v100] = v101
if type(v99) ~= "table" and type(v99) ~= "userdata" then v99 = newRecoveredTable() end
v99.Text = v100
v100 = "NoUI"
if type(v99) ~= "table" and type(v99) ~= "userdata" then v99 = newRecoveredTable() end
if v100 == nil then v100 = "RecoveredKey" end
v99[v100] = v101
v100 = "Callback"

function v101(v251)
  -- synthetic register locals stripped
  v252 = v1012
  if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
  v252 = v252.GetLocalPlayer
  v252 = ensureCallable(v252)
  v252 = v252()
  v253 = v1012
  if type(v253) ~= "table" and type(v253) ~= "userdata" then v253 = newRecoveredTable() end
  v253 = v253.GetCharacter
  if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
  v254 = v252.Name
  v253 = ensureCallable(v253)
  v253 = v253(v254)
  if v253 then
  end
  -- removed decompiler goto
  -- removed decompiler label lbl_11
  do return end
  v255 = v253
  if type(v253) ~= "table" and type(v253) ~= "userdata" then v253 = newRecoveredTable() end
  v254 = v253.FindFirstChildWhichIsA
  v256 = "Humanoid"
  v254 = ensureCallable(v254)
  v254 = v254(v255, v256, v257)
  if not v254 then
  end
  -- removed decompiler goto
  -- removed decompiler label lbl_19
  if not v255 then
  end
  do return end
  if type(v255) ~= "table" and type(v255) ~= "userdata" then v255 = newRecoveredTable() end
  v255 = v255.CurrentCamera
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254.Sit = true
  v256 = task
  if type(v256) ~= "table" and type(v256) ~= "userdata" then v256 = newRecoveredTable() end
  v256 = v256.wait
  v257 = 0.1
  v256 = ensureCallable(v256)
  v256(v257)
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v256 = v254.RootPart
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v257 = v254.RootPart
  if type(v257) ~= "table" and type(v257) ~= "userdata" then v257 = newRecoveredTable() end
  v257 = v257.CFrame
  v258 = CFrame
  v259 = -v259
  v260 = 0
  v261 = 0
  v258 = ensureCallable(v258)
  v258 = v258(v259, v260, v261, v262)
  v257 = v257 * v258
  if type(v256) ~= "table" and type(v256) ~= "userdata" then v256 = newRecoveredTable() end
  v256.CFrame = v257
  v258 = v254
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v257 = v254.GetPlayingAnimationTracks
  -- synthetic vararg register fan-out stripped
  -- trimmed huge synthetic register fan-out
  v256, v257, v258 = v256(v257, v258, v259, v260, v261, v262, v263, v264)
  if false then -- removed constant-true decompiler loop
    -- removed decompiler goto
    v262 = v260
    if type(v260) ~= "table" and type(v260) ~= "userdata" then v260 = newRecoveredTable() end
    v261 = v260.Stop
    -- removed decompiler label lbl_42
    v261 = ensureCallable(v261)
    v261(v262)
  end
end

if type(v99) ~= "table" and type(v99) ~= "userdata" then v99 = newRecoveredTable() end
if v100 == nil then v100 = "RecoveredKey" end
v99[v100] = v101
v100 = "ChangedCallback"
if type(v99) ~= "table" and type(v99) ~= "userdata" then v99 = newRecoveredTable() end
if v100 == nil then v100 = "RecoveredKey" end
v99[v100] = v101
v96 = ensureCallable(v96)
v96(v97, v98, v99)
v98 = "AddLabel"
v97 = v78
if type(v78) ~= "table" and type(v78) ~= "userdata" then v78 = newRecoveredTable() end
v96 = v78[v98]
v98 = "Better noclip"
v96 = ensureCallable(v96)
v96(v97, v98)
v96 = false
v97 = Vector3
if type(v97) ~= "table" and type(v97) ~= "userdata" then v97 = newRecoveredTable() end
v97 = v97.new
v98 = 0
v99 = 0
v100 = 0
v97 = ensureCallable(v97)
v97 = v97(v98, v99, v100, v101)
v98 = 5
v99 = 5
v102 = "AddToggle"
v101 = v78
if type(v78) ~= "table" and type(v78) ~= "userdata" then v78 = newRecoveredTable() end
v100 = v78[v102]
v102 = "NoclipBetter"
if type(v103) ~= "table" and type(v103) ~= "userdata" then v103 = newRecoveredTable() end
v103.Text = "Enabled"

function v105(v251)
  -- synthetic register locals stripped
  if not v251 then
  end
  -- removed decompiler goto
  -- removed decompiler label lbl_4
  v253 = v252
  if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
  v252 = v252.FindFirstChild
  v254 = "NoclipVisual"
  v252 = ensureCallable(v252)
  v252 = v252(v253, v254, v255)
  if v252 then
    v253 = v252
    if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
    v252 = v252.Destroy
  end
  v252 = ensureCallable(v252)
  v252(v253)
end

if type(v103) ~= "table" and type(v103) ~= "userdata" then v103 = newRecoveredTable() end
if v104 == nil then v104 = "RecoveredKey" end
v103[v104] = v105
v100 = ensureCallable(v100)
v100 = v100(v101, v102, v103, v104)
v102 = "AddKeyPicker"
v101 = v100
if type(v100) ~= "table" and type(v100) ~= "userdata" then v100 = newRecoveredTable() end
v100 = v100[v102]
v102 = "BetterNoclipK"
v104 = "Default"
if type(v103) ~= "table" and type(v103) ~= "userdata" then v103 = newRecoveredTable() end
if v104 == nil then v104 = "RecoveredKey" end
v103[v104] = "X"
if type(v103) ~= "table" and type(v103) ~= "userdata" then v103 = newRecoveredTable() end
v103.Text = v104
v104 = "NoUI"
if type(v103) ~= "table" and type(v103) ~= "userdata" then v103 = newRecoveredTable() end
if v104 == nil then v104 = "RecoveredKey" end
v103[v104] = v105
v104 = "Callback"

function v105(v251)
  -- synthetic register locals stripped
  v252 = ensureCallable(v252)
  v252 = v252(v253)
  v253 = ensureCallable(v253)
  v253 = v253(v254)
  v255 = v252
  if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
  v254 = v252.FindFirstChild
  v256 = "Humanoid"
  v254 = ensureCallable(v254)
  v254 = v254(v255, v256, v257)
  if not v255 then
  end
  -- removed decompiler goto
  v255 = ensureCallable(v255)
  v255 = v255()
  v256 = Enum
  if type(v256) ~= "table" and type(v256) ~= "userdata" then v256 = newRecoveredTable() end
  v256 = v256.HumanoidStateType
  if type(v256) ~= "table" and type(v256) ~= "userdata" then v256 = newRecoveredTable() end
  v256 = v256.Jumping
  if type(v255) ~= "table" and type(v255) ~= "userdata" then v255 = newRecoveredTable() end
  v255.state = v256
  
  function v255(v503)
    -- synthetic register locals stripped
    if false then -- removed constant-true decompiler loop
      v505 = 0
      -- removed decompiler goto
      -- removed decompiler goto
      -- removed decompiler label lbl_4
      -- removed decompiler goto
      -- removed decompiler label lbl_5
      -- removed decompiler goto
      if v508 < v507 then
        v505 = v505 + 0.1
      end
      -- removed decompiler goto
      -- removed decompiler label lbl_10
      v505 = 0
      v509 = 0
      v510 = 50
      v511 = 0
      v508 = ensureCallable(v508)
      v508 = v508(v509, v510, v511, v512)
      if type(v506) ~= "table" and type(v506) ~= "userdata" then v506 = newRecoveredTable() end
      v506.Velocity = v508
      v509 = 0.1
      v508 = ensureCallable(v508)
      v508(v509)
      -- removed decompiler label lbl_18
    end
    v506 = 1
    v507 = 15
    v508 = 1
    for v509 = v506, v507, v508 do
      if type(v504) ~= "table" and type(v504) ~= "userdata" then v504 = newRecoveredTable() end
      v504.CFrame = v503
      v511 = 0.05
      v510 = ensureCallable(v510)
      v510(v511)
      v511 = v510
      if type(v510) ~= "table" and type(v510) ~= "userdata" then v510 = newRecoveredTable() end
      v510 = v510.ChangeState
      v510 = ensureCallable(v510)
      v510(v511, v512)
    end
  end
  
  -- removed decompiler label lbl_18
  v256 = ensureCallable(v256)
  v256(v257)
end

if type(v103) ~= "table" and type(v103) ~= "userdata" then v103 = newRecoveredTable() end
if v104 == nil then v104 = "RecoveredKey" end
v103[v104] = v105
v104 = "ChangedCallback"
if type(v103) ~= "table" and type(v103) ~= "userdata" then v103 = newRecoveredTable() end
if v104 == nil then v104 = "RecoveredKey" end
v103[v104] = v105
v104 = "Min"
v105 = 0
if type(v103) ~= "table" and type(v103) ~= "userdata" then v103 = newRecoveredTable() end
if v104 == nil then v104 = "RecoveredKey" end
v103[v104] = v105
v104 = "Max"
v105 = 50
if type(v103) ~= "table" and type(v103) ~= "userdata" then v103 = newRecoveredTable() end
if v104 == nil then v104 = "RecoveredKey" end
v103[v104] = v105
v104 = "Rounding"
v105 = 1
if type(v103) ~= "table" and type(v103) ~= "userdata" then v103 = newRecoveredTable() end
if v104 == nil then v104 = "RecoveredKey" end
v103[v104] = v105
v104 = "Compact"
if type(v103) ~= "table" and type(v103) ~= "userdata" then v103 = newRecoveredTable() end
if v104 == nil then v104 = "RecoveredKey" end
v103[v104] = v105
v104 = "Callback"

function v105(v251)
  -- synthetic register locals stripped
end

if type(v103) ~= "table" and type(v103) ~= "userdata" then v103 = newRecoveredTable() end
if v104 == nil then v104 = "RecoveredKey" end
v103[v104] = v105
v104 = "Min"
v105 = 0
if type(v103) ~= "table" and type(v103) ~= "userdata" then v103 = newRecoveredTable() end
if v104 == nil then v104 = "RecoveredKey" end
v103[v104] = v105
v104 = "Max"
v105 = 50
if type(v103) ~= "table" and type(v103) ~= "userdata" then v103 = newRecoveredTable() end
if v104 == nil then v104 = "RecoveredKey" end
v103[v104] = v105
v104 = "Rounding"
v105 = 1
if type(v103) ~= "table" and type(v103) ~= "userdata" then v103 = newRecoveredTable() end
if v104 == nil then v104 = "RecoveredKey" end
v103[v104] = v105
v104 = "Compact"
if type(v103) ~= "table" and type(v103) ~= "userdata" then v103 = newRecoveredTable() end
if v104 == nil then v104 = "RecoveredKey" end
v103[v104] = v105
v104 = "Callback"

function v105(v251)
  -- synthetic register locals stripped
end

if type(v103) ~= "table" and type(v103) ~= "userdata" then v103 = newRecoveredTable() end
if v104 == nil then v104 = "RecoveredKey" end
v103[v104] = v105
v100 = ensureCallable(v100)
v100(v101, v102, v103)
v102 = "AddLabel"
v101 = v80
if type(v80) ~= "table" and type(v80) ~= "userdata" then v80 = newRecoveredTable() end
v100 = v80[v102]
v102 = "Teleport exploit"
v100 = ensureCallable(v100)
v100(v101, v102)
v103 = "AddButton"
v102 = v80
if type(v80) ~= "table" and type(v80) ~= "userdata" then v80 = newRecoveredTable() end
v101 = v80[v103]
v104 = "Teleport to camera"
if type(v103) ~= "table" and type(v103) ~= "userdata" then v103 = newRecoveredTable() end
v103.Text = v104
v104 = "Func"

function v105()
  -- synthetic register locals stripped
  v758 = v1012
  if type(v758) ~= "table" and type(v758) ~= "userdata" then v758 = newRecoveredTable() end
  v758 = v758.GetCharacter
  v252 = v1014
  if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
  v252 = v252.Name
  v758 = ensureCallable(v758)
  v758 = v758(v252)
  v252 = v1012
  if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
  v252 = v252.GetPlayerPrimary
  v253 = v1014
  if type(v253) ~= "table" and type(v253) ~= "userdata" then v253 = newRecoveredTable() end
  v253 = v253.Name
  v252 = ensureCallable(v252)
  v252 = v252(v253)
  v254 = v758
  if type(v758) ~= "table" and type(v758) ~= "userdata" then v758 = newRecoveredTable() end
  v253 = v758.FindFirstChild
  v255 = "Humanoid"
  v253 = ensureCallable(v253)
  v253 = v253(v254, v255, v256)
  v254 = v1015
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254 = v254.Teleport
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254 = v254.Type
  if v254 ~= "Vector" then
  end
  -- removed decompiler goto
  if not v252 then
  end
  do return end
  
  function v254(v503, v760, v761)
    -- synthetic register locals stripped
    v513 = RaycastParams
    if type(v513) ~= "table" and type(v513) ~= "userdata" then v513 = newRecoveredTable() end
    v513 = v513.new
    v513 = ensureCallable(v513)
    v513 = v513()
    v514 = {}
    v515 = v758
    if type(v514) ~= "table" and type(v514) ~= "userdata" then v514 = newRecoveredTable() end
    v514[1] = v515
    if type(v513) ~= "table" and type(v513) ~= "userdata" then v513 = newRecoveredTable() end
    v513.FilterDescendantsInstances = v514
    if type(v513) ~= "table" and type(v513) ~= "userdata" then v513 = newRecoveredTable() end
    v513.FilterType = v514
    v515 = v514
    if type(v514) ~= "table" and type(v514) ~= "userdata" then v514 = newRecoveredTable() end
    v514 = v514.Raycast
    v517 = 0
    v519 = 0
    v516 = ensureCallable(v516)
    v516 = v516(v517, v518, v519, v520)
    v516 = v503 + v516
    v517 = v506
    v518 = v513
    v514 = ensureCallable(v514)
    v514 = v514(v515, v516, v517, v518, v519)
    v507 = v514
    if v507 then
    end
    -- removed decompiler goto
    -- removed decompiler label lbl_21
    -- removed decompiler goto
    -- removed decompiler label lbl_22
    if type(v509) ~= "table" and type(v509) ~= "userdata" then v509 = newRecoveredTable() end
    v509.FinalIteration = v508
    if type(v509) ~= "table" and type(v509) ~= "userdata" then v509 = newRecoveredTable() end
    v509.Hit = v507
    return v509
  end
  
  v257 = ensureCallable(v257)
  v257 = v257(v258, v259, v260, v261)
  if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
  v258 = v252.Position
  if type(v258) ~= "table" and type(v258) ~= "userdata" then v258 = newRecoveredTable() end
  v258 = v258.Y
  if type(v257) ~= "table" and type(v257) ~= "userdata" then v257 = newRecoveredTable() end
  v259 = v257.FinalIteration
  v258 = v258 + v259
  v259 = v1015
  if type(v259) ~= "table" and type(v259) ~= "userdata" then v259 = newRecoveredTable() end
  v259 = v259.Teleport
  if type(v259) ~= "table" and type(v259) ~= "userdata" then v259 = newRecoveredTable() end
  v259 = v259.Offset
  v258 = v258 + v259
  if false then -- removed constant-true decompiler loop
    v259 = 0
    if not (v261 < v258) then
    end
    -- removed decompiler goto
    if type(v262) ~= "table" and type(v262) ~= "userdata" then v262 = newRecoveredTable() end
    v262 = v262.new
    v263 = 0
    v264 = 50
    v265 = 0
    v262 = ensureCallable(v262)
    v262 = v262(v263, v264, v265, v266)
    if type(v260) ~= "table" and type(v260) ~= "userdata" then v260 = newRecoveredTable() end
    v260.Velocity = v262
    v259 = 0
    -- removed decompiler label lbl_46
    -- removed decompiler goto
    if type(v262) ~= "table" and type(v262) ~= "userdata" then v262 = newRecoveredTable() end
    v262 = v262.Teleport
    if type(v262) ~= "table" and type(v262) ~= "userdata" then v262 = newRecoveredTable() end
    v262 = v262.Timer
    v259 = v259 + v262
    v262 = Vector3
    if type(v262) ~= "table" and type(v262) ~= "userdata" then v262 = newRecoveredTable() end
    v262 = v262.new
    v263 = 0
    v264 = 50
    v265 = 0
    v262 = ensureCallable(v262)
    v262 = v262(v263, v264, v265, v266)
    if type(v260) ~= "table" and type(v260) ~= "userdata" then v260 = newRecoveredTable() end
    v260.Velocity = v262
    v262 = v1015
    if type(v262) ~= "table" and type(v262) ~= "userdata" then v262 = newRecoveredTable() end
    v262 = v262.Teleport
    if type(v262) ~= "table" and type(v262) ~= "userdata" then v262 = newRecoveredTable() end
    v262 = v262.TimerCheck
    if v259 >= v262 then
      if type(v262) ~= "table" and type(v262) ~= "userdata" then v262 = newRecoveredTable() end
      v262 = v262.new
      v263 = 0
      v264 = 0
      v265 = 0
      v262 = ensureCallable(v262)
      v262 = v262(v263, v264, v265, v266)
      if type(v260) ~= "table" and type(v260) ~= "userdata" then v260 = newRecoveredTable() end
      v260.Velocity = v262
    end
    -- removed decompiler label lbl_68
    -- removed decompiler goto
    if type(v262) ~= "table" and type(v262) ~= "userdata" then v262 = newRecoveredTable() end
    v262 = v262.wait
    v263 = v1015
    if type(v263) ~= "table" and type(v263) ~= "userdata" then v263 = newRecoveredTable() end
    v263 = v263.Teleport
    if type(v263) ~= "table" and type(v263) ~= "userdata" then v263 = newRecoveredTable() end
    v263 = v263.Timer
    v262 = ensureCallable(v262)
    v262(v263)
    -- removed decompiler label lbl_74
  end
  v260 = 1
  v261 = 10
  v262 = 1
  for v263 = v260, v261, v262 do
  end
  -- removed decompiler label lbl_80
  -- removed decompiler goto
  if v253 then
  end
  -- removed decompiler goto
  -- removed decompiler label lbl_84
  do return end
  
  function v254(v503)
    -- synthetic register locals stripped
    if false then -- removed constant-true decompiler loop
      v507 = 0
      if not (v508 < v509) then
      end
      -- removed decompiler goto
      if type(v509) ~= "table" and type(v509) ~= "userdata" then v509 = newRecoveredTable() end
      v509 = v509.new
      v510 = 0
      v511 = 50
      v512 = 0
      v509 = ensureCallable(v509)
      v509 = v509(v510, v511, v512, v513)
      if type(v504) ~= "table" and type(v504) ~= "userdata" then v504 = newRecoveredTable() end
      v504.Velocity = v509
      if type(v506) ~= "table" and type(v506) ~= "userdata" then v506 = newRecoveredTable() end
      v509 = v506.Position
      if type(v509) ~= "table" and type(v509) ~= "userdata" then v509 = newRecoveredTable() end
      v509 = v509.Y
      if type(v504) ~= "table" and type(v504) ~= "userdata" then v504 = newRecoveredTable() end
      v510 = v504.Position
      if type(v510) ~= "table" and type(v510) ~= "userdata" then v510 = newRecoveredTable() end
      v510 = v510.Y
      v511 = "Progress: "
      v512 = ensureCallable(v512)
      v512 = v512(v513)
      v513 = " studs away"
      v510 = ensureCallable(v510)
      v510(v511)
      v507 = 0
      -- removed decompiler label lbl_20
      -- removed decompiler goto
      if type(v509) ~= "table" and type(v509) ~= "userdata" then v509 = newRecoveredTable() end
      v509 = v509.Teleport
      if type(v509) ~= "table" and type(v509) ~= "userdata" then v509 = newRecoveredTable() end
      v509 = v509.Timer
      v507 = v507 + v509
      v509 = Vector3
      if type(v509) ~= "table" and type(v509) ~= "userdata" then v509 = newRecoveredTable() end
      v509 = v509.new
      v510 = 0
      v511 = 50
      v512 = 0
      v509 = ensureCallable(v509)
      v509 = v509(v510, v511, v512, v513)
      if type(v504) ~= "table" and type(v504) ~= "userdata" then v504 = newRecoveredTable() end
      v504.Velocity = v509
      if not (1 <= v507) then
      end
      -- removed decompiler goto
      if type(v509) ~= "table" and type(v509) ~= "userdata" then v509 = newRecoveredTable() end
      v509 = v509.new
      v510 = 0
      v511 = 0
      v512 = 0
      v509 = ensureCallable(v509)
      v509 = v509(v510, v511, v512, v513)
      if type(v504) ~= "table" and type(v504) ~= "userdata" then v504 = newRecoveredTable() end
      v504.Velocity = v509
      -- removed decompiler label lbl_40
      -- removed decompiler goto
      v510 = 0.1
      v509 = ensureCallable(v509)
      v509(v510)
      -- removed decompiler label lbl_43
    end
    v509 = "Teleporting.. "
    v508 = ensureCallable(v508)
    v508(v509)
    if false then -- removed constant-true decompiler loop
      v508 = 0
      -- removed decompiler goto
      -- removed decompiler label lbl_48
      -- removed decompiler goto
      v508 = v508 + 0.05
      if type(v504) ~= "table" and type(v504) ~= "userdata" then v504 = newRecoveredTable() end
      v504.CFrame = v506
      v509 = 1
      v510 = 2
      v511 = 1
      for v512 = v509, v510, v511 do
        v514 = v513
        if type(v513) ~= "table" and type(v513) ~= "userdata" then v513 = newRecoveredTable() end
        v513 = v513.ChangeState
        v515 = Enum
        if type(v515) ~= "table" and type(v515) ~= "userdata" then v515 = newRecoveredTable() end
        v515 = v515.HumanoidStateType
        if type(v515) ~= "table" and type(v515) ~= "userdata" then v515 = newRecoveredTable() end
        v515 = v515.Jumping
        v513 = ensureCallable(v513)
        v513(v514, v515)
        v513 = task
        if type(v513) ~= "table" and type(v513) ~= "userdata" then v513 = newRecoveredTable() end
        v513 = v513.wait
        v513 = ensureCallable(v513)
        v513()
      end
      -- removed decompiler label lbl_64
    end
  end
  
  -- removed decompiler label lbl_88
  v255 = ensureCallable(v255)
  v255(v256)
end

if type(v103) ~= "table" and type(v103) ~= "userdata" then v103 = newRecoveredTable() end
if v104 == nil then v104 = "RecoveredKey" end
v103[v104] = v105
v104 = "DoubleClick"
if type(v103) ~= "table" and type(v103) ~= "userdata" then v103 = newRecoveredTable() end
if v104 == nil then v104 = "RecoveredKey" end
v103[v104] = v105
v104 = "Tooltip"
v105 = "Teleports the character to the camera position"
if type(v103) ~= "table" and type(v103) ~= "userdata" then v103 = newRecoveredTable() end
if v104 == nil then v104 = "RecoveredKey" end
v103[v104] = v105
v101 = ensureCallable(v101)
v101 = v101(v102, v103, v104)
v104 = "AddButton"
v103 = v80
if type(v80) ~= "table" and type(v80) ~= "userdata" then v80 = newRecoveredTable() end
v102 = v80[v104]
v105 = "Teleport to position"
if type(v104) ~= "table" and type(v104) ~= "userdata" then v104 = newRecoveredTable() end
v104.Text = v105
v105 = "Func"

function v106()
  -- synthetic register locals stripped
  v758 = v1012
  if type(v758) ~= "table" and type(v758) ~= "userdata" then v758 = newRecoveredTable() end
  v758 = v758.GetCharacter
  v252 = v1014
  if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
  v252 = v252.Name
  v758 = ensureCallable(v758)
  v758 = v758(v252)
  v252 = v1012
  if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
  v252 = v252.GetPlayerPrimary
  v253 = v1014
  if type(v253) ~= "table" and type(v253) ~= "userdata" then v253 = newRecoveredTable() end
  v253 = v253.Name
  v252 = ensureCallable(v252)
  v252 = v252(v253)
  v254 = v758
  if type(v758) ~= "table" and type(v758) ~= "userdata" then v758 = newRecoveredTable() end
  v253 = v758.FindFirstChild
  v255 = "Humanoid"
  v253 = ensureCallable(v253)
  v253 = v253(v254, v255, v256)
  v254 = v1015
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254 = v254.Teleport
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254 = v254.Type
  if v254 ~= "Vector" then
  end
  -- removed decompiler goto
  if not v252 then
  end
  do return end
  
  function v254(v503, v760, v761)
    -- synthetic register locals stripped
    v513 = RaycastParams
    if type(v513) ~= "table" and type(v513) ~= "userdata" then v513 = newRecoveredTable() end
    v513 = v513.new
    v513 = ensureCallable(v513)
    v513 = v513()
    v514 = {}
    v515 = v758
    if type(v514) ~= "table" and type(v514) ~= "userdata" then v514 = newRecoveredTable() end
    v514[1] = v515
    if type(v513) ~= "table" and type(v513) ~= "userdata" then v513 = newRecoveredTable() end
    v513.FilterDescendantsInstances = v514
    v514 = Enum
    if type(v514) ~= "table" and type(v514) ~= "userdata" then v514 = newRecoveredTable() end
    v514 = v514.RaycastFilterType
    if type(v514) ~= "table" and type(v514) ~= "userdata" then v514 = newRecoveredTable() end
    v514 = v514.Blacklist
    if type(v513) ~= "table" and type(v513) ~= "userdata" then v513 = newRecoveredTable() end
    v513.FilterType = v514
    v514 = v1014
    v515 = v514
    if type(v514) ~= "table" and type(v514) ~= "userdata" then v514 = newRecoveredTable() end
    v514 = v514.Raycast
    v516 = Vector3
    if type(v516) ~= "table" and type(v516) ~= "userdata" then v516 = newRecoveredTable() end
    v516 = v516.new
    v517 = 0
    v518 = v512
    v519 = 0
    v516 = ensureCallable(v516)
    v516 = v516(v517, v518, v519, v520)
    v516 = v503 + v516
    v517 = v506
    v518 = v513
    v514 = ensureCallable(v514)
    v514 = v514(v515, v516, v517, v518, v519)
    v507 = v514
    if not v507 then
    end
    -- removed decompiler goto
    -- removed decompiler label lbl_28
    if type(v509) ~= "table" and type(v509) ~= "userdata" then v509 = newRecoveredTable() end
    v509.FinalIteration = v508
    if type(v509) ~= "table" and type(v509) ~= "userdata" then v509 = newRecoveredTable() end
    v509.Hit = v507
    return v509
  end
  
  v257 = ensureCallable(v257)
  v257 = v257(v258, v259, v260, v261)
  if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
  v258 = v252.Position
  if type(v258) ~= "table" and type(v258) ~= "userdata" then v258 = newRecoveredTable() end
  v258 = v258.Y
  if type(v257) ~= "table" and type(v257) ~= "userdata" then v257 = newRecoveredTable() end
  v259 = v257.FinalIteration
  v258 = v258 + v259
  v259 = v1015
  if type(v259) ~= "table" and type(v259) ~= "userdata" then v259 = newRecoveredTable() end
  v259 = v259.Teleport
  if type(v259) ~= "table" and type(v259) ~= "userdata" then v259 = newRecoveredTable() end
  v259 = v259.Offset
  v258 = v258 + v259
  if false then -- removed constant-true decompiler loop
    v259 = 0
    if not (v261 < v258) then
    end
    -- removed decompiler goto
    if type(v262) ~= "table" and type(v262) ~= "userdata" then v262 = newRecoveredTable() end
    v262 = v262.new
    v263 = 0
    v264 = 50
    v265 = 0
    v262 = ensureCallable(v262)
    v262 = v262(v263, v264, v265, v266)
    if type(v260) ~= "table" and type(v260) ~= "userdata" then v260 = newRecoveredTable() end
    v260.Velocity = v262
    v259 = 0
    -- removed decompiler label lbl_46
    -- removed decompiler goto
    if type(v262) ~= "table" and type(v262) ~= "userdata" then v262 = newRecoveredTable() end
    v262 = v262.Teleport
    if type(v262) ~= "table" and type(v262) ~= "userdata" then v262 = newRecoveredTable() end
    v262 = v262.Timer
    v259 = v259 + v262
    v262 = Vector3
    if type(v262) ~= "table" and type(v262) ~= "userdata" then v262 = newRecoveredTable() end
    v262 = v262.new
    v263 = 0
    v264 = 50
    v265 = 0
    v262 = ensureCallable(v262)
    v262 = v262(v263, v264, v265, v266)
    if type(v260) ~= "table" and type(v260) ~= "userdata" then v260 = newRecoveredTable() end
    v260.Velocity = v262
    if not (v259 >= v262) then
    end
    -- removed decompiler goto
    if type(v262) ~= "table" and type(v262) ~= "userdata" then v262 = newRecoveredTable() end
    v262 = v262.new
    v263 = 0
    v264 = 0
    v265 = 0
    v262 = ensureCallable(v262)
    v262 = v262(v263, v264, v265, v266)
    if type(v260) ~= "table" and type(v260) ~= "userdata" then v260 = newRecoveredTable() end
    v260.Velocity = v262
    -- removed decompiler label lbl_66
    -- removed decompiler goto
    if type(v262) ~= "table" and type(v262) ~= "userdata" then v262 = newRecoveredTable() end
    v262 = v262.wait
    v263 = v1015
    if type(v263) ~= "table" and type(v263) ~= "userdata" then v263 = newRecoveredTable() end
    v263 = v263.Teleport
    if type(v263) ~= "table" and type(v263) ~= "userdata" then v263 = newRecoveredTable() end
    v263 = v263.Timer
    v262 = ensureCallable(v262)
    v262(v263)
    -- removed decompiler label lbl_72
  end
  v260 = 1
  v261 = 10
  v262 = 1
  for v263 = v260, v261, v262 do
  end
  -- removed decompiler label lbl_78
  -- removed decompiler goto
  if not v253 then
  end
  do return end
  
  function v254(v503)
    -- synthetic register locals stripped
    if false then -- removed constant-true decompiler loop
      v507 = 0
      if v508 < v509 then
        if type(v509) ~= "table" and type(v509) ~= "userdata" then v509 = newRecoveredTable() end
        v509 = v509.new
        v510 = 0
        v511 = 50
        v512 = 0
        v509 = ensureCallable(v509)
        v509 = v509(v510, v511, v512, v513)
        if type(v504) ~= "table" and type(v504) ~= "userdata" then v504 = newRecoveredTable() end
        v504.Velocity = v509
        if type(v506) ~= "table" and type(v506) ~= "userdata" then v506 = newRecoveredTable() end
        v509 = v506.Position
        if type(v509) ~= "table" and type(v509) ~= "userdata" then v509 = newRecoveredTable() end
        v509 = v509.Y
        if type(v504) ~= "table" and type(v504) ~= "userdata" then v504 = newRecoveredTable() end
        v510 = v504.Position
        if type(v510) ~= "table" and type(v510) ~= "userdata" then v510 = newRecoveredTable() end
        v510 = v510.Y
        v511 = "Progress: "
        v512 = ensureCallable(v512)
        v512 = v512(v513)
        v513 = " studs away"
        v510 = ensureCallable(v510)
        v510(v511)
        v507 = 0
      end
      -- removed decompiler goto
      if type(v509) ~= "table" and type(v509) ~= "userdata" then v509 = newRecoveredTable() end
      v509 = v509.Teleport
      if type(v509) ~= "table" and type(v509) ~= "userdata" then v509 = newRecoveredTable() end
      v509 = v509.Timer
      v507 = v507 + v509
      v509 = Vector3
      if type(v509) ~= "table" and type(v509) ~= "userdata" then v509 = newRecoveredTable() end
      v509 = v509.new
      v510 = 0
      v511 = 50
      v512 = 0
      v509 = ensureCallable(v509)
      v509 = v509(v510, v511, v512, v513)
      if type(v504) ~= "table" and type(v504) ~= "userdata" then v504 = newRecoveredTable() end
      v504.Velocity = v509
      if 1 <= v507 then
        if type(v509) ~= "table" and type(v509) ~= "userdata" then v509 = newRecoveredTable() end
        v509 = v509.new
        v510 = 0
        v511 = 0
        v512 = 0
        v509 = ensureCallable(v509)
        v509 = v509(v510, v511, v512, v513)
        if type(v504) ~= "table" and type(v504) ~= "userdata" then v504 = newRecoveredTable() end
        v504.Velocity = v509
      end
      -- removed decompiler label lbl_38
      -- removed decompiler goto
      v510 = 0.1
      v509 = ensureCallable(v509)
      v509(v510)
      -- removed decompiler label lbl_41
    end
    v509 = "Teleporting.. "
    v508 = ensureCallable(v508)
    v508(v509)
    if false then -- removed constant-true decompiler loop
      v508 = 0
      -- removed decompiler goto
      -- removed decompiler label lbl_46
      -- removed decompiler goto
      v508 = v508 + 0.05
      if type(v504) ~= "table" and type(v504) ~= "userdata" then v504 = newRecoveredTable() end
      v504.CFrame = v506
      v509 = 1
      v510 = 2
      v511 = 1
      for v512 = v509, v510, v511 do
        v514 = v513
        if type(v513) ~= "table" and type(v513) ~= "userdata" then v513 = newRecoveredTable() end
        v513 = v513.ChangeState
        v515 = Enum
        if type(v515) ~= "table" and type(v515) ~= "userdata" then v515 = newRecoveredTable() end
        v515 = v515.HumanoidStateType
        if type(v515) ~= "table" and type(v515) ~= "userdata" then v515 = newRecoveredTable() end
        v515 = v515.Jumping
        v513 = ensureCallable(v513)
        v513(v514, v515)
        v513 = task
        if type(v513) ~= "table" and type(v513) ~= "userdata" then v513 = newRecoveredTable() end
        v513 = v513.wait
        v513 = ensureCallable(v513)
        v513()
      end
      -- removed decompiler label lbl_62
    end
  end
  
  -- synthetic vararg register fan-out stripped
  -- removed decompiler label lbl_86
  -- trimmed huge synthetic register fan-out
  v255(v256, v257, v258, v259, v260, v261, v262, v263)
end

if type(v104) ~= "table" and type(v104) ~= "userdata" then v104 = newRecoveredTable() end
if v105 == nil then v105 = "RecoveredKey" end
v104[v105] = v106
v105 = "DoubleClick"
if type(v104) ~= "table" and type(v104) ~= "userdata" then v104 = newRecoveredTable() end
if v105 == nil then v105 = "RecoveredKey" end
v104[v105] = v106
v105 = "Tooltip"
v106 = "Teleports the character to the given position"
if type(v104) ~= "table" and type(v104) ~= "userdata" then v104 = newRecoveredTable() end
if v105 == nil then v105 = "RecoveredKey" end
v104[v105] = v106
v102 = ensureCallable(v102)
v102 = v102(v103, v104, v105)
v105 = "AddLabel"
v104 = v80
if type(v80) ~= "table" and type(v80) ~= "userdata" then v80 = newRecoveredTable() end
v103 = v80[v105]
v105 = "Teleport to monument"

function v107()
  -- synthetic register locals stripped
  v758 = ensureCallable(v758)
  v758 = v758(v252)
  v252 = ensureCallable(v252)
  v252 = v252(v253)
  v253 = ensureCallable(v253)
  v253 = v253(v254)
  if v252 or not v253 then
  end
  do return end
  if v254 == "Vector" then
    function v254(v503, v760, v761)
      -- synthetic register locals stripped
      
      v513 = RaycastParams
      if type(v513) ~= "table" and type(v513) ~= "userdata" then v513 = newRecoveredTable() end
      v513 = v513.new
      v513 = ensureCallable(v513)
      v513 = v513()
      v514 = {}
      v515 = v758
      if type(v514) ~= "table" and type(v514) ~= "userdata" then v514 = newRecoveredTable() end
      v514[1] = v515
      if type(v513) ~= "table" and type(v513) ~= "userdata" then v513 = newRecoveredTable() end
      v513.FilterDescendantsInstances = v514
      v514 = Enum
      if type(v514) ~= "table" and type(v514) ~= "userdata" then v514 = newRecoveredTable() end
      v514 = v514.RaycastFilterType
      if type(v514) ~= "table" and type(v514) ~= "userdata" then v514 = newRecoveredTable() end
      v514 = v514.Blacklist
      if type(v513) ~= "table" and type(v513) ~= "userdata" then v513 = newRecoveredTable() end
      v513.FilterType = v514
      v514 = v1014
      v515 = v514
      if type(v514) ~= "table" and type(v514) ~= "userdata" then v514 = newRecoveredTable() end
      v514 = v514.Raycast
      v516 = Vector3
      if type(v516) ~= "table" and type(v516) ~= "userdata" then v516 = newRecoveredTable() end
      v516 = v516.new
      v517 = 0
      v518 = v512
      v519 = 0
      v516 = ensureCallable(v516)
      v516 = v516(v517, v518, v519, v520)
      v516 = v503 + v516
      v517 = v506
      v518 = v513
      v514 = ensureCallable(v514)
      v514 = v514(v515, v516, v517, v518, v519)
      v507 = v514
      if not v507 then
      end
      -- removed decompiler goto
      -- removed decompiler label lbl_28
      if type(v509) ~= "table" and type(v509) ~= "userdata" then v509 = newRecoveredTable() end
      v509.FinalIteration = v508
      if type(v509) ~= "table" and type(v509) ~= "userdata" then v509 = newRecoveredTable() end
      v509.Hit = v507
      return v509
    end
    
    v256 = ensureCallable(v256)
    v256 = v256(v257)
    v257 = ensureCallable(v257)
    v257 = v257(v258, v259, v260, v261)
    if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
    v258 = v252.Position
    if type(v258) ~= "table" and type(v258) ~= "userdata" then v258 = newRecoveredTable() end
    v258 = v258.Y
    if type(v257) ~= "table" and type(v257) ~= "userdata" then v257 = newRecoveredTable() end
    v259 = v257.FinalIteration
    v258 = v258 + v259
    v259 = v1015
    if type(v259) ~= "table" and type(v259) ~= "userdata" then v259 = newRecoveredTable() end
    v259 = v259.Teleport
    if type(v259) ~= "table" and type(v259) ~= "userdata" then v259 = newRecoveredTable() end
    v259 = v259.Offset
    v258 = v258 + v259
    if false then -- removed constant-true decompiler loop
      v259 = 0
      if v261 < v258 then
        if type(v262) ~= "table" and type(v262) ~= "userdata" then v262 = newRecoveredTable() end
        v262 = v262.new
        v263 = 0
        v264 = 50
        v265 = 0
        v262 = ensureCallable(v262)
        v262 = v262(v263, v264, v265, v266)
        if type(v260) ~= "table" and type(v260) ~= "userdata" then v260 = newRecoveredTable() end
        v260.Velocity = v262
        v259 = 0
      end
      -- removed decompiler goto
      if type(v262) ~= "table" and type(v262) ~= "userdata" then v262 = newRecoveredTable() end
      v262 = v262.Teleport
      if type(v262) ~= "table" and type(v262) ~= "userdata" then v262 = newRecoveredTable() end
      v262 = v262.Timer
      v259 = v259 + v262
      v262 = Vector3
      if type(v262) ~= "table" and type(v262) ~= "userdata" then v262 = newRecoveredTable() end
      v262 = v262.new
      v263 = 0
      v264 = 50
      v265 = 0
      v262 = ensureCallable(v262)
      v262 = v262(v263, v264, v265, v266)
      if type(v260) ~= "table" and type(v260) ~= "userdata" then v260 = newRecoveredTable() end
      v260.Velocity = v262
      v262 = v1015
      if type(v262) ~= "table" and type(v262) ~= "userdata" then v262 = newRecoveredTable() end
      v262 = v262.Teleport
      if type(v262) ~= "table" and type(v262) ~= "userdata" then v262 = newRecoveredTable() end
      v262 = v262.TimerCheck
      if v259 >= v262 then
        if type(v262) ~= "table" and type(v262) ~= "userdata" then v262 = newRecoveredTable() end
        v262 = v262.new
        v263 = 0
        v264 = 0
        v265 = 0
        v262 = ensureCallable(v262)
        v262 = v262(v263, v264, v265, v266)
        if type(v260) ~= "table" and type(v260) ~= "userdata" then v260 = newRecoveredTable() end
        v260.Velocity = v262
      end
      -- removed decompiler label lbl_56
      -- removed decompiler goto
      if type(v262) ~= "table" and type(v262) ~= "userdata" then v262 = newRecoveredTable() end
      v262 = v262.wait
      v263 = v1015
      if type(v263) ~= "table" and type(v263) ~= "userdata" then v263 = newRecoveredTable() end
      v263 = v263.Teleport
      if type(v263) ~= "table" and type(v263) ~= "userdata" then v263 = newRecoveredTable() end
      v263 = v263.Timer
      v262 = ensureCallable(v262)
      v262(v263)
      -- removed decompiler label lbl_62
    end
    v260 = 1
    v261 = 10
    v262 = 1
    for v263 = v260, v261, v262 do
    end
  end
  -- removed decompiler goto
  if v253 then
  end
  -- removed decompiler goto
  -- removed decompiler label lbl_72
  do return end
  
  function v254(v503)
    -- synthetic register locals stripped
    if false then -- removed constant-true decompiler loop
      v507 = 0
      if not (v508 < v509) then
      end
      -- removed decompiler goto
      if type(v509) ~= "table" and type(v509) ~= "userdata" then v509 = newRecoveredTable() end
      v509 = v509.new
      v510 = 0
      v511 = 50
      v512 = 0
      v509 = ensureCallable(v509)
      v509 = v509(v510, v511, v512, v513)
      if type(v504) ~= "table" and type(v504) ~= "userdata" then v504 = newRecoveredTable() end
      v504.Velocity = v509
      if type(v506) ~= "table" and type(v506) ~= "userdata" then v506 = newRecoveredTable() end
      v509 = v506.Position
      if type(v509) ~= "table" and type(v509) ~= "userdata" then v509 = newRecoveredTable() end
      v509 = v509.Y
      if type(v504) ~= "table" and type(v504) ~= "userdata" then v504 = newRecoveredTable() end
      v510 = v504.Position
      if type(v510) ~= "table" and type(v510) ~= "userdata" then v510 = newRecoveredTable() end
      v510 = v510.Y
      v511 = "Progress: "
      v512 = ensureCallable(v512)
      v512 = v512(v513)
      v513 = " studs away"
      v510 = ensureCallable(v510)
      v510(v511)
      v507 = 0
      -- removed decompiler label lbl_20
      -- removed decompiler goto
      if type(v509) ~= "table" and type(v509) ~= "userdata" then v509 = newRecoveredTable() end
      v509 = v509.Teleport
      if type(v509) ~= "table" and type(v509) ~= "userdata" then v509 = newRecoveredTable() end
      v509 = v509.Timer
      v507 = v507 + v509
      v509 = Vector3
      if type(v509) ~= "table" and type(v509) ~= "userdata" then v509 = newRecoveredTable() end
      v509 = v509.new
      v510 = 0
      v511 = 50
      v512 = 0
      v509 = ensureCallable(v509)
      v509 = v509(v510, v511, v512, v513)
      if type(v504) ~= "table" and type(v504) ~= "userdata" then v504 = newRecoveredTable() end
      v504.Velocity = v509
      if not (1 <= v507) then
      end
      -- removed decompiler goto
      if type(v509) ~= "table" and type(v509) ~= "userdata" then v509 = newRecoveredTable() end
      v509 = v509.new
      v510 = 0
      v511 = 0
      v512 = 0
      v509 = ensureCallable(v509)
      v509 = v509(v510, v511, v512, v513)
      if type(v504) ~= "table" and type(v504) ~= "userdata" then v504 = newRecoveredTable() end
      v504.Velocity = v509
      -- removed decompiler label lbl_40
      -- removed decompiler goto
      v510 = 0.1
      v509 = ensureCallable(v509)
      v509(v510)
      -- removed decompiler label lbl_43
    end
    v509 = "Teleporting.. "
    v508 = ensureCallable(v508)
    v508(v509)
    if false then -- removed constant-true decompiler loop
      v508 = 0
      -- removed decompiler goto
      -- removed decompiler label lbl_48
      -- removed decompiler goto
      v508 = v508 + 0.05
      if type(v504) ~= "table" and type(v504) ~= "userdata" then v504 = newRecoveredTable() end
      v504.CFrame = v506
      v509 = 1
      v510 = 2
      v511 = 1
      for v512 = v509, v510, v511 do
        v514 = v513
        if type(v513) ~= "table" and type(v513) ~= "userdata" then v513 = newRecoveredTable() end
        v513 = v513.ChangeState
        v515 = Enum
        if type(v515) ~= "table" and type(v515) ~= "userdata" then v515 = newRecoveredTable() end
        v515 = v515.HumanoidStateType
        if type(v515) ~= "table" and type(v515) ~= "userdata" then v515 = newRecoveredTable() end
        v515 = v515.Jumping
        v513 = ensureCallable(v513)
        v513(v514, v515)
        v513 = task
        if type(v513) ~= "table" and type(v513) ~= "userdata" then v513 = newRecoveredTable() end
        v513 = v513.wait
        v513 = ensureCallable(v513)
        v513()
      end
      -- removed decompiler label lbl_64
    end
  end
  
  -- synthetic vararg register fan-out stripped
  -- removed decompiler label lbl_78
  -- trimmed huge synthetic register fan-out
  v255(v256, v257, v258, v259, v260, v261, v262, v263)
end

if type(v105) ~= "table" and type(v105) ~= "userdata" then v105 = newRecoveredTable() end
if v106 == nil then v106 = "RecoveredKey" end
v105[v106] = v107
v106 = "DoubleClick"
if type(v105) ~= "table" and type(v105) ~= "userdata" then v105 = newRecoveredTable() end
if v106 == nil then v106 = "RecoveredKey" end
v105[v106] = v107
v106 = "Tooltip"
v107 = "Teleports the character to the given monument"
if type(v105) ~= "table" and type(v105) ~= "userdata" then v105 = newRecoveredTable() end
if v106 == nil then v106 = "RecoveredKey" end
v105[v106] = v107
v103 = ensureCallable(v103)
v103 = v103(v104, v105, v106)
v106 = "AddDropdown"
v105 = v80
if type(v80) ~= "table" and type(v80) ~= "userdata" then v80 = newRecoveredTable() end
v104 = v80[v106]
v106 = "TpBypassType"
v108 = "Values"
v110 = "State"
v111 = "Vector"
if type(v109) ~= "table" and type(v109) ~= "userdata" then v109 = newRecoveredTable() end
v109[1] = v110
if type(v109) ~= "table" and type(v109) ~= "userdata" then v109 = newRecoveredTable() end
v109[2] = v111
if type(v107) ~= "table" and type(v107) ~= "userdata" then v107 = newRecoveredTable() end
if v108 == nil then v108 = "RecoveredKey" end
v107[v108] = v109
v108 = "Default"
v109 = 1
if type(v107) ~= "table" and type(v107) ~= "userdata" then v107 = newRecoveredTable() end
if v108 == nil then v108 = "RecoveredKey" end
v107[v108] = v109
v108 = "Multi"
if type(v107) ~= "table" and type(v107) ~= "userdata" then v107 = newRecoveredTable() end
if v108 == nil then v108 = "RecoveredKey" end
v107[v108] = v109
v108 = "Bypass type"
if type(v107) ~= "table" and type(v107) ~= "userdata" then v107 = newRecoveredTable() end
v107.Text = v108
v108 = "Tooltip"
v109 = "The bypass type it will use ( state is the best )"
if type(v107) ~= "table" and type(v107) ~= "userdata" then v107 = newRecoveredTable() end
if v108 == nil then v108 = "RecoveredKey" end
v107[v108] = v109
v108 = "Callback"

function v109(v251)
  -- synthetic register locals stripped
  if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
  v252.Type = v251
end

if type(v107) ~= "table" and type(v107) ~= "userdata" then v107 = newRecoveredTable() end
if v108 == nil then v108 = "RecoveredKey" end
v107[v108] = v109
v104 = ensureCallable(v104)
v104(v105, v106, v107)
v106 = "AddDropdown"
v105 = v80
if type(v80) ~= "table" and type(v80) ~= "userdata" then v80 = newRecoveredTable() end
v104 = v80[v106]
v106 = "MonumentType"
v107 = {}
v108 = "Values"
v109 = {}
v110 = "Airfield"
v111 = "Bunker"
v112 = "Military"
if type(v109) ~= "table" and type(v109) ~= "userdata" then v109 = newRecoveredTable() end
v109[1] = v110
if type(v109) ~= "table" and type(v109) ~= "userdata" then v109 = newRecoveredTable() end
v109[2] = v111
if type(v109) ~= "table" and type(v109) ~= "userdata" then v109 = newRecoveredTable() end
v109[3] = v112
if type(v107) ~= "table" and type(v107) ~= "userdata" then v107 = newRecoveredTable() end
if v108 == nil then v108 = "RecoveredKey" end
v107[v108] = v109
v108 = "Default"
v109 = 1
if type(v107) ~= "table" and type(v107) ~= "userdata" then v107 = newRecoveredTable() end
if v108 == nil then v108 = "RecoveredKey" end
v107[v108] = v109
v108 = "Multi"
if type(v107) ~= "table" and type(v107) ~= "userdata" then v107 = newRecoveredTable() end
if v108 == nil then v108 = "RecoveredKey" end
v107[v108] = v109
v108 = "Monument type"
if type(v107) ~= "table" and type(v107) ~= "userdata" then v107 = newRecoveredTable() end
v107.Text = v108
v108 = "Tooltip"
v109 = "The monument to teleport to"
if type(v107) ~= "table" and type(v107) ~= "userdata" then v107 = newRecoveredTable() end
if v108 == nil then v108 = "RecoveredKey" end
v107[v108] = v109
v108 = "Callback"

function v109(v251)
  -- synthetic register locals stripped
  if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
  v252.Monument = v251
end

if type(v107) ~= "table" and type(v107) ~= "userdata" then v107 = newRecoveredTable() end
if v108 == nil then v108 = "RecoveredKey" end
v107[v108] = v109
v104 = ensureCallable(v104)
v104(v105, v106, v107)
v106 = "AddInput"
v105 = v80
if type(v80) ~= "table" and type(v80) ~= "userdata" then v80 = newRecoveredTable() end
v104 = v80[v106]
v106 = "TeleportPos"
v108 = "Default"
if type(v107) ~= "table" and type(v107) ~= "userdata" then v107 = newRecoveredTable() end
if v108 == nil then v108 = "RecoveredKey" end
v107[v108] = "Position"
v108 = "Numeric"
if type(v107) ~= "table" and type(v107) ~= "userdata" then v107 = newRecoveredTable() end
if v108 == nil then v108 = "RecoveredKey" end
v107[v108] = v109
v108 = "Finished"
v109 = false
if type(v107) ~= "table" and type(v107) ~= "userdata" then v107 = newRecoveredTable() end
if v108 == nil then v108 = "RecoveredKey" end
v107[v108] = v109
if type(v107) ~= "table" and type(v107) ~= "userdata" then v107 = newRecoveredTable() end
v107.Text = "Position"
v108 = "Tooltip"
v109 = "Position to teleport to (VECTOR)"
if type(v107) ~= "table" and type(v107) ~= "userdata" then v107 = newRecoveredTable() end
if v108 == nil then v108 = "RecoveredKey" end
v107[v108] = v109
v108 = "Placeholder"
v109 = "0,0,0"
if type(v107) ~= "table" and type(v107) ~= "userdata" then v107 = newRecoveredTable() end
if v108 == nil then v108 = "RecoveredKey" end
v107[v108] = v109
v108 = "Callback"

function v109(v251)
  -- synthetic register locals stripped
  if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
  v252.Pos = v251
end

if type(v107) ~= "table" and type(v107) ~= "userdata" then v107 = newRecoveredTable() end
if v108 == nil then v108 = "RecoveredKey" end
v107[v108] = v109
v108 = "Min"
v109 = 0
if type(v107) ~= "table" and type(v107) ~= "userdata" then v107 = newRecoveredTable() end
if v108 == nil then v108 = "RecoveredKey" end
v107[v108] = v109
v108 = "Max"
v109 = 2000
if type(v107) ~= "table" and type(v107) ~= "userdata" then v107 = newRecoveredTable() end
if v108 == nil then v108 = "RecoveredKey" end
v107[v108] = v109
v108 = "Rounding"
v109 = 1
if type(v107) ~= "table" and type(v107) ~= "userdata" then v107 = newRecoveredTable() end
if v108 == nil then v108 = "RecoveredKey" end
v107[v108] = v109
v108 = "Compact"
if type(v107) ~= "table" and type(v107) ~= "userdata" then v107 = newRecoveredTable() end
if v108 == nil then v108 = "RecoveredKey" end
v107[v108] = v109
v108 = "Callback"

function v109(v251)
  -- synthetic register locals stripped
  if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
  v252.Offset = v251
end

if type(v107) ~= "table" and type(v107) ~= "userdata" then v107 = newRecoveredTable() end
if v108 == nil then v108 = "RecoveredKey" end
v107[v108] = v109
v108 = "Min"
v109 = 0
if type(v107) ~= "table" and type(v107) ~= "userdata" then v107 = newRecoveredTable() end
if v108 == nil then v108 = "RecoveredKey" end
v107[v108] = v109
v108 = "Max"
v109 = 1000
if type(v107) ~= "table" and type(v107) ~= "userdata" then v107 = newRecoveredTable() end
if v108 == nil then v108 = "RecoveredKey" end
v107[v108] = v109
v108 = "Rounding"
v109 = 1
if type(v107) ~= "table" and type(v107) ~= "userdata" then v107 = newRecoveredTable() end
if v108 == nil then v108 = "RecoveredKey" end
v107[v108] = v109
v108 = "Compact"
if type(v107) ~= "table" and type(v107) ~= "userdata" then v107 = newRecoveredTable() end
if v108 == nil then v108 = "RecoveredKey" end
v107[v108] = v109
v108 = "Callback"

function v109(v251)
  -- synthetic register locals stripped
  if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
  v252.MaxIteration = v251
end

v108 = "Min"
v109 = 0
if type(v107) ~= "table" and type(v107) ~= "userdata" then v107 = newRecoveredTable() end
if v108 == nil then v108 = "RecoveredKey" end
v107[v108] = v109
v108 = "Max"
v109 = 1
if type(v107) ~= "table" and type(v107) ~= "userdata" then v107 = newRecoveredTable() end
if v108 == nil then v108 = "RecoveredKey" end
v107[v108] = v109
v108 = "Rounding"
v109 = 1
if type(v107) ~= "table" and type(v107) ~= "userdata" then v107 = newRecoveredTable() end
if v108 == nil then v108 = "RecoveredKey" end
v107[v108] = v109
v108 = "Compact"
if type(v107) ~= "table" and type(v107) ~= "userdata" then v107 = newRecoveredTable() end
if v108 == nil then v108 = "RecoveredKey" end
v107[v108] = v109
v108 = "Callback"

function v109(v251)
  -- synthetic register locals stripped
  if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
  v252.Timer = v251
end

if type(v107) ~= "table" and type(v107) ~= "userdata" then v107 = newRecoveredTable() end
if v108 == nil then v108 = "RecoveredKey" end
v107[v108] = v109
v108 = "Min"
v109 = 0
if type(v107) ~= "table" and type(v107) ~= "userdata" then v107 = newRecoveredTable() end
if v108 == nil then v108 = "RecoveredKey" end
v107[v108] = v109
v108 = "Max"
v109 = 5
if type(v107) ~= "table" and type(v107) ~= "userdata" then v107 = newRecoveredTable() end
if v108 == nil then v108 = "RecoveredKey" end
v107[v108] = v109
v108 = "Rounding"
v109 = 1
if type(v107) ~= "table" and type(v107) ~= "userdata" then v107 = newRecoveredTable() end
if v108 == nil then v108 = "RecoveredKey" end
v107[v108] = v109
v108 = "Compact"
if type(v107) ~= "table" and type(v107) ~= "userdata" then v107 = newRecoveredTable() end
if v108 == nil then v108 = "RecoveredKey" end
v107[v108] = v109
v108 = "Callback"

function v109(v251)
  -- synthetic register locals stripped
  if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
  v252.TimerCheck = v251
end

if type(v107) ~= "table" and type(v107) ~= "userdata" then v107 = newRecoveredTable() end
v107.Text = "Enabled"

function v109(v251)
  -- synthetic register locals stripped
  if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
  v252.Enabled = v251
end

if type(v107) ~= "table" and type(v107) ~= "userdata" then v107 = newRecoveredTable() end
if v108 == nil then v108 = "RecoveredKey" end
v107[v108] = v109
v108 = "Min"
v109 = 0
if type(v107) ~= "table" and type(v107) ~= "userdata" then v107 = newRecoveredTable() end
if v108 == nil then v108 = "RecoveredKey" end
v107[v108] = v109
v108 = "Max"
v109 = 30
if type(v107) ~= "table" and type(v107) ~= "userdata" then v107 = newRecoveredTable() end
if v108 == nil then v108 = "RecoveredKey" end
v107[v108] = v109
v108 = "Rounding"
v109 = 1
if type(v107) ~= "table" and type(v107) ~= "userdata" then v107 = newRecoveredTable() end
if v108 == nil then v108 = "RecoveredKey" end
v107[v108] = v109
v108 = "Compact"
if type(v107) ~= "table" and type(v107) ~= "userdata" then v107 = newRecoveredTable() end
if v108 == nil then v108 = "RecoveredKey" end
v107[v108] = v109
v108 = "Callback"

function v109(v251)
  -- synthetic register locals stripped
  if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
  v252.Offset = v251
end

if type(v107) ~= "table" and type(v107) ~= "userdata" then v107 = newRecoveredTable() end
if v108 == nil then v108 = "RecoveredKey" end
v107[v108] = v109
v104 = ensureCallable(v104)
v104(v105, v106, v107)
v106 = "AddToggle"
v105 = v77
if type(v77) ~= "table" and type(v77) ~= "userdata" then v77 = newRecoveredTable() end
v104 = v77[v106]
v106 = "CustomBuilding"
v108 = "Hidden building hp"
if type(v107) ~= "table" and type(v107) ~= "userdata" then v107 = newRecoveredTable() end
v107.Text = v108

function v109(v251)
  -- synthetic register locals stripped
  if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
  v252.Unbreakable = v251
end

if type(v107) ~= "table" and type(v107) ~= "userdata" then v107 = newRecoveredTable() end
v107.Text = "Enabled"

function v109(v251)
  -- synthetic register locals stripped
  if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
  v252.Enabled = v251
end

v108 = "Min"
v109 = 1
if type(v107) ~= "table" and type(v107) ~= "userdata" then v107 = newRecoveredTable() end
if v108 == nil then v108 = "RecoveredKey" end
v107[v108] = v109
v108 = "Max"
v109 = 100
if type(v107) ~= "table" and type(v107) ~= "userdata" then v107 = newRecoveredTable() end
if v108 == nil then v108 = "RecoveredKey" end
v107[v108] = v109
v108 = "Rounding"
v109 = 1
if type(v107) ~= "table" and type(v107) ~= "userdata" then v107 = newRecoveredTable() end
if v108 == nil then v108 = "RecoveredKey" end
v107[v108] = v109
v108 = "Compact"
if type(v107) ~= "table" and type(v107) ~= "userdata" then v107 = newRecoveredTable() end
if v108 == nil then v108 = "RecoveredKey" end
v107[v108] = v109
v108 = "Callback"

function v109(v251)
  -- synthetic register locals stripped
  v253 = v251 / 10
  if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
  v252.Frequency = v253
end

if type(v107) ~= "table" and type(v107) ~= "userdata" then v107 = newRecoveredTable() end
if v108 == nil then v108 = "RecoveredKey" end
v107[v108] = v109
v104 = ensureCallable(v104)
v104(v105, v106, v107)
v106 = "AddDropdown"
v105 = v77
if type(v77) ~= "table" and type(v77) ~= "userdata" then v77 = newRecoveredTable() end
v104 = v77[v106]
v106 = "Autofarmoptions"
v107 = {}
v108 = "Values"
v109 = {}
v110 = "Tree"
v111 = "Brimstone Ore"
v112 = "Stone Ore"
v113 = "Iron Ore"
v114 = "Cloth"
if type(v109) ~= "table" and type(v109) ~= "userdata" then v109 = newRecoveredTable() end
v109[1] = v110
if type(v109) ~= "table" and type(v109) ~= "userdata" then v109 = newRecoveredTable() end
v109[2] = v111
if type(v109) ~= "table" and type(v109) ~= "userdata" then v109 = newRecoveredTable() end
v109[3] = v112
if type(v109) ~= "table" and type(v109) ~= "userdata" then v109 = newRecoveredTable() end
v109[4] = v113
if type(v109) ~= "table" and type(v109) ~= "userdata" then v109 = newRecoveredTable() end
v109[5] = v114
if type(v107) ~= "table" and type(v107) ~= "userdata" then v107 = newRecoveredTable() end
if v108 == nil then v108 = "RecoveredKey" end
v107[v108] = v109
v108 = "Default"
v109 = 1
if type(v107) ~= "table" and type(v107) ~= "userdata" then v107 = newRecoveredTable() end
if v108 == nil then v108 = "RecoveredKey" end
v107[v108] = v109
v108 = "Multi"
if type(v107) ~= "table" and type(v107) ~= "userdata" then v107 = newRecoveredTable() end
if v108 == nil then v108 = "RecoveredKey" end
v107[v108] = v109
v108 = "Whitelist"
if type(v107) ~= "table" and type(v107) ~= "userdata" then v107 = newRecoveredTable() end
v107.Text = v108
v108 = "Tooltip"
v109 = "Whitelists things that can be farmed"
if type(v107) ~= "table" and type(v107) ~= "userdata" then v107 = newRecoveredTable() end
if v108 == nil then v108 = "RecoveredKey" end
v107[v108] = v109
v108 = "Callback"
if type(v107) ~= "table" and type(v107) ~= "userdata" then v107 = newRecoveredTable() end
if v108 == nil then v108 = "RecoveredKey" end
v107[v108] = v109
v104 = ensureCallable(v104)
v104(v105, v106, v107)
local ItemRecipeModule = {}
pcall(function()
  local loaded = loadRemoteSource("ItemRecipeModule")
  if type(loaded) == "table" then
    ItemRecipeModule = loaded
  end
end)
v104 = ItemRecipeModule

function v105(v251)
  -- synthetic register locals stripped
  v254 = v253
  if type(v253) ~= "table" and type(v253) ~= "userdata" then v253 = newRecoveredTable() end
  v253 = v253.GetService
  v255 = "ReplicatedStorage"
  v253 = ensureCallable(v253)
  v253 = v253(v254, v255, v256)
  v252 = ensureCallable(v252)
  v252 = v252(v253)
  v254 = 0
  v255 = ensureCallable(v255)
  v255, v256, v257 = v255(v256)
  if false then -- removed constant-true decompiler loop
    -- removed decompiler goto
    v260 = ensureCallable(v260)
    v260, v261, v262 = v260(v261)
    for v263, v264 in v260, v261, v262 do
      if v264 == v251 then
        if type(v253) ~= "table" and type(v253) ~= "userdata" then v253 = newRecoveredTable() end
        if v258 == nil then v258 = "RecoveredKey" end
        v253[v258] = v258
      end
      -- removed decompiler label lbl_14
    end
  end
end

function v107(v251)
  -- synthetic register locals stripped
  v252 = ensureCallable(v252)
  v252, v253 = v252(v253)
  v254 = ensureCallable(v254)
  v254, v255, v256 = v254(v255)
  if false then -- removed constant-true decompiler loop
    -- removed decompiler goto
    v261 = v260
    if type(v260) ~= "table" and type(v260) ~= "userdata" then v260 = newRecoveredTable() end
    v260 = v260.GetService
    v262 = "ReplicatedStorage"
    v260 = ensureCallable(v260)
    v260 = v260(v261, v262, v263)
    v261 = v260
    if type(v260) ~= "table" and type(v260) ~= "userdata" then v260 = newRecoveredTable() end
    v260 = v260.WaitForChild
    v262 = "Remotes"
    v260 = ensureCallable(v260)
    v260 = v260(v261, v262, v263)
    v261 = v260
    if type(v260) ~= "table" and type(v260) ~= "userdata" then v260 = newRecoveredTable() end
    v260 = v260.WaitForChild
    v262 = "RemoteEvent"
    v260 = ensureCallable(v260)
    v260 = v260(v261, v262, v263)
    v261 = v260
    if type(v260) ~= "table" and type(v260) ~= "userdata" then v260 = newRecoveredTable() end
    v260 = v260.FireServer
    v262 = unpack
    v263 = v259
  -- synthetic vararg register fan-out stripped
    -- removed decompiler label lbl_17
    -- trimmed huge synthetic register fan-out
    v260(v261, v262, v263, v264, v265, v266, v267, v268)
  end
end

function v108(v251, v501, v502, v753)
  -- synthetic register locals stripped
  v255 = ensureCallable(v255)
  v255, v256 = v255(v256)
  -- synthetic vararg register fan-out stripped
  -- trimmed huge synthetic register fan-out
  v257 = v257(v258, v259, v260, v261, v262, v263, v264, v265)
  v258 = ensureCallable(v258)
  v258, v259, v260 = v258(v259)
  if false then -- removed constant-true decompiler loop
    -- removed decompiler goto
    v264 = "Move Item"
    v265 = false
    v266 = {}
    v267 = game
    if type(v267) ~= "table" and type(v267) ~= "userdata" then v267 = newRecoveredTable() end
    v267 = v267.Players
    if type(v267) ~= "table" and type(v267) ~= "userdata" then v267 = newRecoveredTable() end
    v267 = v267.LocalPlayer
    v268 = v267
    if type(v267) ~= "table" and type(v267) ~= "userdata" then v267 = newRecoveredTable() end
    v267 = v267.GetAttribute
    v269 = "InventoryId"
    v267 = ensureCallable(v267)
    v267 = v267(v268, v269, v270)
    if type(v266) ~= "table" and type(v266) ~= "userdata" then v266 = newRecoveredTable() end
    v266.FromContainerId = v267
    v267 = ensureCallable(v267)
    v267 = v267(v268)
    if type(v266) ~= "table" and type(v266) ~= "userdata" then v266 = newRecoveredTable() end
    v266.FromSlot = v267
    if type(v266) ~= "table" and type(v266) ~= "userdata" then v266 = newRecoveredTable() end
    v266.SplitAmount = v753
    if type(v266) ~= "table" and type(v266) ~= "userdata" then v266 = newRecoveredTable() end
    v266.ToSlot = v257
    v268 = v267
    if type(v267) ~= "table" and type(v267) ~= "userdata" then v267 = newRecoveredTable() end
    v267 = v267.GetAttribute
    v269 = "InventoryId"
    v267 = ensureCallable(v267)
    v267 = v267(v268, v269, v270)
    if type(v266) ~= "table" and type(v266) ~= "userdata" then v266 = newRecoveredTable() end
    v266.ToContainerId = v267
    v268 = -1521.513916015625
    v269 = 98.92546844482422
    v270 = -529.195068359375
    v271 = -0.30212387442588806
    v272 = -0.3019603490829468
    v273 = 0.9041798114776611
    v274 = 0
    v275 = 0.9485046863555908
    v276 = 0.31676313281059265
    v277 = -0.9532686471939087
    v278 = 0.09570170193910599
    v279 = -0.2865659296512604
    v267 = ensureCallable(v267)
    v267 = v267(v268, v269, v270, v271, v272, v273, v274, v275, v276, v277, v278, v279, v280)
    v268 = 48
    v269 = 6
    if type(v263) ~= "table" and type(v263) ~= "userdata" then v263 = newRecoveredTable() end
    v263[1] = v264
    if type(v263) ~= "table" and type(v263) ~= "userdata" then v263 = newRecoveredTable() end
    v263[2] = v265
    if type(v263) ~= "table" and type(v263) ~= "userdata" then v263 = newRecoveredTable() end
    v263[3] = v266
    if type(v263) ~= "table" and type(v263) ~= "userdata" then v263 = newRecoveredTable() end
    v263[4] = v267
    if type(v263) ~= "table" and type(v263) ~= "userdata" then v263 = newRecoveredTable() end
    v263[5] = v268
    if type(v263) ~= "table" and type(v263) ~= "userdata" then v263 = newRecoveredTable() end
    v263[6] = v269
    v265 = v264
    if type(v264) ~= "table" and type(v264) ~= "userdata" then v264 = newRecoveredTable() end
    v264 = v264.GetService
    v266 = "ReplicatedStorage"
    v264 = ensureCallable(v264)
    v264 = v264(v265, v266, v267)
    v265 = v264
    if type(v264) ~= "table" and type(v264) ~= "userdata" then v264 = newRecoveredTable() end
    v264 = v264.WaitForChild
    v266 = "Remotes"
    v264 = ensureCallable(v264)
    v264 = v264(v265, v266, v267)
    v265 = v264
    if type(v264) ~= "table" and type(v264) ~= "userdata" then v264 = newRecoveredTable() end
    v264 = v264.WaitForChild
    v266 = "RemoteEvent"
    v264 = ensureCallable(v264)
    v264 = v264(v265, v266, v267)
    v265 = v264
    if type(v264) ~= "table" and type(v264) ~= "userdata" then v264 = newRecoveredTable() end
    v264 = v264.FireServer
    v266 = unpack
    v267 = v263
  -- synthetic vararg register fan-out stripped
    -- removed decompiler label lbl_53
    -- trimmed huge synthetic register fan-out
    v264(v265, v266, v267, v268, v269, v270, v271, v272)
  end
end

function v109(v251, v501, v502, v753, v754)
  -- synthetic register locals stripped
  if type(v256) ~= "table" and type(v256) ~= "userdata" then v256 = newRecoveredTable() end
  v256 = v256[v251]
  v257 = 1
  v259 = 1
  for v260 = v257, v258, v259 do
    v262 = "Reserve Craft"
    v264 = ensureCallable(v264)
    v264 = v264(v265)
    if type(v261) ~= "table" and type(v261) ~= "userdata" then v261 = newRecoveredTable() end
    v261[1] = v262
    if type(v261) ~= "table" and type(v261) ~= "userdata" then v261 = newRecoveredTable() end
    v261[2] = v263
    if type(v261) ~= "table" and type(v261) ~= "userdata" then v261 = newRecoveredTable() end
    v261[3] = v264
    if type(v261) ~= "table" and type(v261) ~= "userdata" then v261 = newRecoveredTable() end
    v261[4] = v265
    v263 = v262
    if type(v262) ~= "table" and type(v262) ~= "userdata" then v262 = newRecoveredTable() end
    v262 = v262.GetService
    v264 = "ReplicatedStorage"
    v262 = ensureCallable(v262)
    v262 = v262(v263, v264, v265)
    v263 = v262
    if type(v262) ~= "table" and type(v262) ~= "userdata" then v262 = newRecoveredTable() end
    v262 = v262.WaitForChild
    v264 = "Remotes"
    v262 = ensureCallable(v262)
    v262 = v262(v263, v264, v265)
    v263 = v262
    if type(v262) ~= "table" and type(v262) ~= "userdata" then v262 = newRecoveredTable() end
    v262 = v262.WaitForChild
    v264 = "RemoteFunction"
    v262 = ensureCallable(v262)
    v262 = v262(v263, v264, v265)
    v263 = v262
    if type(v262) ~= "table" and type(v262) ~= "userdata" then v262 = newRecoveredTable() end
    v262 = v262.InvokeServer
  -- synthetic vararg register fan-out stripped
    -- trimmed huge synthetic register fan-out
    v262 = v262(v263, v264, v265, v266, v267, v268, v269, v270)
    if not v753 then
    end
    -- removed decompiler goto
    
    function v264()
      -- synthetic register locals stripped
      v759 = ensureCallable(v759)
      v759(v504)
      v759 = {}
      v504 = "Craft - Item Processed"
      v505 = false
      v506 = v1014
      v507 = 12
      v508 = 18
      if type(v759) ~= "table" and type(v759) ~= "userdata" then v759 = newRecoveredTable() end
      v759[1] = v504
      if type(v759) ~= "table" and type(v759) ~= "userdata" then v759 = newRecoveredTable() end
      v759[2] = v505
      if type(v759) ~= "table" and type(v759) ~= "userdata" then v759 = newRecoveredTable() end
      v759[3] = v506
      if type(v759) ~= "table" and type(v759) ~= "userdata" then v759 = newRecoveredTable() end
      v759[4] = v507
      if type(v759) ~= "table" and type(v759) ~= "userdata" then v759 = newRecoveredTable() end
      v759[5] = v508
      v505 = v504
      if type(v504) ~= "table" and type(v504) ~= "userdata" then v504 = newRecoveredTable() end
      v504 = v504.GetService
      v506 = "ReplicatedStorage"
      v504 = ensureCallable(v504)
      v504 = v504(v505, v506, v507)
      v505 = v504
      if type(v504) ~= "table" and type(v504) ~= "userdata" then v504 = newRecoveredTable() end
      v504 = v504.WaitForChild
      v506 = "Remotes"
      v504 = ensureCallable(v504)
      v504 = v504(v505, v506, v507)
      v505 = v504
      if type(v504) ~= "table" and type(v504) ~= "userdata" then v504 = newRecoveredTable() end
      v504 = v504.WaitForChild
      v506 = "RemoteEvent"
      v504 = ensureCallable(v504)
      v504 = v504(v505, v506, v507)
      v505 = v504
      if type(v504) ~= "table" and type(v504) ~= "userdata" then v504 = newRecoveredTable() end
      v504 = v504.FireServer
      v506 = unpack
      v507 = v759
  -- synthetic vararg register fan-out stripped
      -- trimmed huge synthetic register fan-out
      v504(v505, v506, v507, v508, v509, v510, v511, v512)
    end
    
    v263 = ensureCallable(v263)
    v263(v264)
    -- removed decompiler label lbl_27
    -- removed decompiler goto
    v264 = "Remove Craft"
    v267 = 15
    v268 = 18
    if type(v263) ~= "table" and type(v263) ~= "userdata" then v263 = newRecoveredTable() end
    v263[1] = v264
    if type(v263) ~= "table" and type(v263) ~= "userdata" then v263 = newRecoveredTable() end
    v263[2] = v265
    if type(v263) ~= "table" and type(v263) ~= "userdata" then v263 = newRecoveredTable() end
    v263[3] = v266
    if type(v263) ~= "table" and type(v263) ~= "userdata" then v263 = newRecoveredTable() end
    v263[4] = v267
    if type(v263) ~= "table" and type(v263) ~= "userdata" then v263 = newRecoveredTable() end
    v263[5] = v268
    v265 = v264
    if type(v264) ~= "table" and type(v264) ~= "userdata" then v264 = newRecoveredTable() end
    v264 = v264.GetService
    v266 = "ReplicatedStorage"
    v264 = ensureCallable(v264)
    v264 = v264(v265, v266, v267)
    v265 = v264
    if type(v264) ~= "table" and type(v264) ~= "userdata" then v264 = newRecoveredTable() end
    v264 = v264.WaitForChild
    v266 = "Remotes"
    v264 = ensureCallable(v264)
    v264 = v264(v265, v266, v267)
    v265 = v264
    if type(v264) ~= "table" and type(v264) ~= "userdata" then v264 = newRecoveredTable() end
    v264 = v264.WaitForChild
    v266 = "RemoteEvent"
    v264 = ensureCallable(v264)
    v264 = v264(v265, v266, v267)
    v265 = v264
    if type(v264) ~= "table" and type(v264) ~= "userdata" then v264 = newRecoveredTable() end
    v264 = v264.FireServer
    v266 = unpack
    v267 = v263
  -- synthetic vararg register fan-out stripped
    -- removed decompiler label lbl_45
    -- trimmed huge synthetic register fan-out
    v264(v265, v266, v267, v268, v269, v270, v271, v272)
  end
end

function v109(v251, v501)
  -- synthetic register locals stripped
  if type(v253) ~= "table" and type(v253) ~= "userdata" then v253 = newRecoveredTable() end
  v253 = v253[v251]
  v257 = 1
  if type(v259) ~= "table" and type(v259) ~= "userdata" then v259 = newRecoveredTable() end
  v259 = v259[v251]
  v258 = ensureCallable(v258)
  v258, v259, v260 = v258(v259)
  if false then -- removed constant-true decompiler loop
    -- removed decompiler goto
    if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
    if v261 == nil then v261 = "RecoveredKey" end
    v254[v261] = v261
    v264 = ensureCallable(v264)
    v264 = v264(v265)
    v265 = 60 + v261
    v266 = 60 + v261
    v267 = 1 / 0
    v263 = ensureCallable(v263)
    v263(v264, v265, v266, v267)
  -- synthetic vararg register fan-out stripped
    -- trimmed huge synthetic register fan-out
    v263, v264, v265 = v263(v264, v265, v266, v267, v268, v269, v270, v271)
    v266 = ensureCallable(v266)
    v266 = v266(v267)
    if type(v255) ~= "table" and type(v255) ~= "userdata" then v255 = newRecoveredTable() end
    if v266 == nil then v266 = "RecoveredKey" end
    v255[v266] = v265
    v266 = ensureCallable(v266)
    v266 = v266(v267)
    if type(v267) ~= "table" and type(v267) ~= "userdata" then v267 = newRecoveredTable() end
    v267 = v267[v251]
    -- removed decompiler label lbl_18
    if type(v256) ~= "table" and type(v256) ~= "userdata" then v256 = newRecoveredTable() end
    if v266 == nil then v266 = "RecoveredKey" end
    v256[v266] = v267
  end
  v258 = ensureCallable(v258)
  v258 = v258(v259, v260, v261)
  v258 = ensureCallable(v258)
  v258(v259)
  v259 = 0.5
  v258 = ensureCallable(v258)
  v258(v259)
  v258 = 1
  v260 = 1
  for v261 = v258, v259, v260 do
    v264 = 1
    if type(v266) ~= "table" and type(v266) ~= "userdata" then v266 = newRecoveredTable() end
    v266 = v266[v251]
    if type(v267) ~= "table" and type(v267) ~= "userdata" then v267 = newRecoveredTable() end
    v267 = v267[v251]
    v262 = ensureCallable(v262)
    v262(v263, v264, v265, v266, v267)
    v262 = ensureCallable(v262)
    v262(v263)
  end
  if type(v258) ~= "table" and type(v258) ~= "userdata" then v258 = newRecoveredTable() end
  v258 = v258.wait
  v259 = 0.5
  v258 = ensureCallable(v258)
  v258(v259)
  v258 = 1
  v259 = 10
  v260 = 1
  for v261 = v258, v259, v260 do
    if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
    v262 = v254[v261]
    if v262 then
      v263 = 1
      v262 = ensureCallable(v262)
      v262(v263)
      v263 = 60 + v261
    end
    v262 = ensureCallable(v262)
    v262(v263)
  end
end

v110 = 10
v111 = 50
v112 = "Wood"
v115 = "AddButton"
v114 = v79
if type(v79) ~= "table" and type(v79) ~= "userdata" then v79 = newRecoveredTable() end
v113 = v79[v115]
v116 = "Spawn item"
if type(v115) ~= "table" and type(v115) ~= "userdata" then v115 = newRecoveredTable() end
v115.Text = v116
v116 = "Func"

function v117()
  -- synthetic register locals stripped
  v758 = ensureCallable(v758)
  v758(v252, v253)
end

if type(v115) ~= "table" and type(v115) ~= "userdata" then v115 = newRecoveredTable() end
if v116 == nil then v116 = "RecoveredKey" end
v115[v116] = v117
v116 = "DoubleClick"
if type(v115) ~= "table" and type(v115) ~= "userdata" then v115 = newRecoveredTable() end
if v116 == nil then v116 = "RecoveredKey" end
v115[v116] = v117
v116 = "Tooltip"
v117 = "Spawns item using spawn type"
if type(v115) ~= "table" and type(v115) ~= "userdata" then v115 = newRecoveredTable() end
if v116 == nil then v116 = "RecoveredKey" end
v115[v116] = v117
v113 = ensureCallable(v113)
v113 = v113(v114, v115, v116)
v116 = "AddInput"
v115 = v79
if type(v79) ~= "table" and type(v79) ~= "userdata" then v79 = newRecoveredTable() end
v114 = v79[v116]
v116 = "ITEMTOSPAWNS"
v117 = {}
v118 = "Default"
v119 = "Wood"
if type(v117) ~= "table" and type(v117) ~= "userdata" then v117 = newRecoveredTable() end
if v118 == nil then v118 = "RecoveredKey" end
v117[v118] = v119
v118 = "Numeric"
v119 = false
if type(v117) ~= "table" and type(v117) ~= "userdata" then v117 = newRecoveredTable() end
if v118 == nil then v118 = "RecoveredKey" end
v117[v118] = v119
v118 = "Finished"
v119 = false
if type(v117) ~= "table" and type(v117) ~= "userdata" then v117 = newRecoveredTable() end
if v118 == nil then v118 = "RecoveredKey" end
v117[v118] = v119
v118 = "Item name"
if type(v117) ~= "table" and type(v117) ~= "userdata" then v117 = newRecoveredTable() end
v117.Text = v118
v118 = "Tooltip"
v119 = "Item to spawn"
if type(v117) ~= "table" and type(v117) ~= "userdata" then v117 = newRecoveredTable() end
if v118 == nil then v118 = "RecoveredKey" end
v117[v118] = v119
v118 = "Placeholder"
v119 = "Wood"
if type(v117) ~= "table" and type(v117) ~= "userdata" then v117 = newRecoveredTable() end
if v118 == nil then v118 = "RecoveredKey" end
v117[v118] = v119
v118 = "Callback"

function v119(v251)
  -- synthetic register locals stripped
end

if type(v117) ~= "table" and type(v117) ~= "userdata" then v117 = newRecoveredTable() end
if v118 == nil then v118 = "RecoveredKey" end
v117[v118] = v119
v118 = "Min"
v119 = 1
if type(v117) ~= "table" and type(v117) ~= "userdata" then v117 = newRecoveredTable() end
if v118 == nil then v118 = "RecoveredKey" end
v117[v118] = v119
v118 = "Max"
v119 = 100
if type(v117) ~= "table" and type(v117) ~= "userdata" then v117 = newRecoveredTable() end
if v118 == nil then v118 = "RecoveredKey" end
v117[v118] = v119
v118 = "Rounding"
v119 = 0
if type(v117) ~= "table" and type(v117) ~= "userdata" then v117 = newRecoveredTable() end
if v118 == nil then v118 = "RecoveredKey" end
v117[v118] = v119
v118 = "Compact"
if type(v117) ~= "table" and type(v117) ~= "userdata" then v117 = newRecoveredTable() end
if v118 == nil then v118 = "RecoveredKey" end
v117[v118] = v119
v118 = "Callback"

function v119(v251)
  -- synthetic register locals stripped
end

if type(v117) ~= "table" and type(v117) ~= "userdata" then v117 = newRecoveredTable() end
if v118 == nil then v118 = "RecoveredKey" end
v117[v118] = v119
v114 = ensureCallable(v114)
v114(v115, v116, v117)
v116 = "AddLabel"
v115 = v79
if type(v79) ~= "table" and type(v79) ~= "userdata" then v79 = newRecoveredTable() end
v114 = v79[v116]
v116 = "Grab dropped item"
v114 = ensureCallable(v114)
v114(v115, v116)
v114 = "AS Val"
v117 = "AddButton"
v116 = v79
if type(v79) ~= "table" and type(v79) ~= "userdata" then v79 = newRecoveredTable() end
v115 = v79[v117]
v118 = "Grab item"
if type(v117) ~= "table" and type(v117) ~= "userdata" then v117 = newRecoveredTable() end
v117.Text = v118
v118 = "Func"

function v119()
  -- synthetic register locals stripped
  v252 = "--------------- PICKABLE ITEMS ---------------"
  v758 = ensureCallable(v758)
  v758(v252)
  v252 = v1012
  if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
  v252 = v252.Dropped
  v253 = v252
  if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
  v252 = v252.GetChildren
  -- synthetic vararg register fan-out stripped
  -- trimmed huge synthetic register fan-out
  v758, v252, v253 = v758(v252, v253, v254, v255, v256, v257, v258, v259)
  if false then -- removed constant-true decompiler loop
    -- removed decompiler goto
    -- removed decompiler label lbl_9
    v256 = ensureCallable(v256)
    v256(v257, v258)
  end
  v252 = v758
  if type(v758) ~= "table" and type(v758) ~= "userdata" then v758 = newRecoveredTable() end
  v758 = v758.FindFirstChild
  v758 = ensureCallable(v758)
  v758 = v758(v252, v253, v254)
  if not v758 then
  end
  do return end
  v252 = ensureCallable(v252)
  v252 = v252(v253)
  if not v252 then
  end
  do return end
  if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
  v254 = v252.CFrame
  if type(v758) ~= "table" and type(v758) ~= "userdata" then v758 = newRecoveredTable() end
  v255 = v758.WorldPivot
  v256 = v1015
  if type(v256) ~= "table" and type(v256) ~= "userdata" then v256 = newRecoveredTable() end
  v256 = v256.GetHumanoid
  v257 = v1016
  if type(v257) ~= "table" and type(v257) ~= "userdata" then v257 = newRecoveredTable() end
  v257 = v257.Name
  v256 = ensureCallable(v256)
  v256 = v256(v257)
  if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
  v257 = v252.CFrame
  if v256 then
  end
  -- removed decompiler goto
  -- removed decompiler label lbl_32
  do return end
  v258 = nil
  v260 = v259
  if type(v259) ~= "table" and type(v259) ~= "userdata" then v259 = newRecoveredTable() end
  v259 = v259.GetService
  v261 = "RunService"
  v259 = ensureCallable(v259)
  v259 = v259(v260, v261, v262)
  v260 = v259
  if type(v259) ~= "table" and type(v259) ~= "userdata" then v259 = newRecoveredTable() end
  v259 = v259.Connect
  
  function v261()
    -- synthetic register locals stripped
    v759 = v1014
    if type(v759) ~= "table" and type(v759) ~= "userdata" then v759 = newRecoveredTable() end
    v759 = v759.CFrame
    v1012 = v759
    v759 = v758
    if v759 then
      if v759 then
        -- removed decompiler goto
      end
    end
    v504 = v759
    if type(v759) ~= "table" and type(v759) ~= "userdata" then v759 = newRecoveredTable() end
    v759 = v759.Disconnect
    v759 = ensureCallable(v759)
    v759(v504)
    v759 = nil
    v504 = 0.5
    v759 = ensureCallable(v759)
    v759(v504)
    v504 = v759
    if type(v759) ~= "table" and type(v759) ~= "userdata" then v759 = newRecoveredTable() end
    v759 = v759.GetService
    v505 = "RunService"
    v759 = ensureCallable(v759)
    v759 = v759(v504, v505, v506)
    v504 = v759
    if type(v759) ~= "table" and type(v759) ~= "userdata" then v759 = newRecoveredTable() end
    v759 = v759.UnbindFromRenderStep
    v505 = "pause cframe"
    -- removed decompiler label lbl_19
    v759 = ensureCallable(v759)
    v759(v504, v505)
    if not v759 then
    end
    -- removed decompiler goto
    v504 = v759
    if type(v759) ~= "table" and type(v759) ~= "userdata" then v759 = newRecoveredTable() end
    v759 = v759.ChangeState
    v759 = ensureCallable(v759)
    v759(v504, v505)
    
    function v504()
      -- synthetic register locals stripped
      v762 = {}
      v763 = "Pickup Item"
      v764 = false
      v765 = v758
      v766 = 41
      v767 = 35
      if type(v762) ~= "table" and type(v762) ~= "userdata" then v762 = newRecoveredTable() end
      v762[1] = v763
      if type(v762) ~= "table" and type(v762) ~= "userdata" then v762 = newRecoveredTable() end
      v762[2] = v764
      if type(v762) ~= "table" and type(v762) ~= "userdata" then v762 = newRecoveredTable() end
      v762[3] = v765
      if type(v762) ~= "table" and type(v762) ~= "userdata" then v762 = newRecoveredTable() end
      v762[4] = v766
      if type(v762) ~= "table" and type(v762) ~= "userdata" then v762 = newRecoveredTable() end
      v762[5] = v767
      v764 = v763
      if type(v763) ~= "table" and type(v763) ~= "userdata" then v763 = newRecoveredTable() end
      v763 = v763.GetService
      v765 = "ReplicatedStorage"
      v763 = ensureCallable(v763)
      v763 = v763(v764, v765, v766)
      v764 = v763
      if type(v763) ~= "table" and type(v763) ~= "userdata" then v763 = newRecoveredTable() end
      v763 = v763.WaitForChild
      v765 = "Remotes"
      v763 = ensureCallable(v763)
      v763 = v763(v764, v765, v766)
      v764 = v763
      if type(v763) ~= "table" and type(v763) ~= "userdata" then v763 = newRecoveredTable() end
      v763 = v763.WaitForChild
      v765 = "RemoteEvent"
      v763 = ensureCallable(v763)
      v763 = v763(v764, v765, v766)
      v764 = v763
      if type(v763) ~= "table" and type(v763) ~= "userdata" then v763 = newRecoveredTable() end
      v763 = v763.FireServer
      v765 = unpack
      v766 = v762
      -- trimmed huge synthetic register fan-out
      v765, v766, v767, v768, v769, v770, v771, v772 = v765(v766)
      -- trimmed huge synthetic register fan-out
      v763(v764, v765, v766, v767, v768, v769, v770, v771)
    end
    
    v759 = ensureCallable(v759)
    v759(v504)
    -- removed decompiler label lbl_28
    if type(v759) ~= "table" and type(v759) ~= "userdata" then v759 = newRecoveredTable() end
    v759.CFrame = v504
  end
  
  v259 = ensureCallable(v259)
  v259 = v259(v260, v261, v262)
  v260 = v259
  if type(v259) ~= "table" and type(v259) ~= "userdata" then v259 = newRecoveredTable() end
  v259 = v259.GetService
  v261 = "RunService"
  v259 = ensureCallable(v259)
  v259 = v259(v260, v261, v262)
  v260 = v259
  if type(v259) ~= "table" and type(v259) ~= "userdata" then v259 = newRecoveredTable() end
  v259 = v259.BindToRenderStep
  v261 = "pause cframe"
  
  function v263()
    -- synthetic register locals stripped
    if type(v759) ~= "table" and type(v759) ~= "userdata" then v759 = newRecoveredTable() end
    v759.CFrame = v504
  end
  
  v259 = ensureCallable(v259)
  v259(v260, v261, v262, v263)
end

if type(v117) ~= "table" and type(v117) ~= "userdata" then v117 = newRecoveredTable() end
if v118 == nil then v118 = "RecoveredKey" end
v117[v118] = v119
v118 = "DoubleClick"
if type(v117) ~= "table" and type(v117) ~= "userdata" then v117 = newRecoveredTable() end
if v118 == nil then v118 = "RecoveredKey" end
v117[v118] = v119
v118 = "Tooltip"
v119 = "Grabs dropped item"
if type(v117) ~= "table" and type(v117) ~= "userdata" then v117 = newRecoveredTable() end
if v118 == nil then v118 = "RecoveredKey" end
v117[v118] = v119
v115 = ensureCallable(v115)
v115 = v115(v116, v117, v118)
v118 = "AddInput"
v117 = v79
if type(v79) ~= "table" and type(v79) ~= "userdata" then v79 = newRecoveredTable() end
v116 = v79[v118]
v118 = "ITEMTOGRAB"
v119 = {}
v120 = "Default"
v121 = "AS Val"
if type(v119) ~= "table" and type(v119) ~= "userdata" then v119 = newRecoveredTable() end
if v120 == nil then v120 = "RecoveredKey" end
v119[v120] = v121
v120 = "Numeric"
v121 = false
if type(v119) ~= "table" and type(v119) ~= "userdata" then v119 = newRecoveredTable() end
if v120 == nil then v120 = "RecoveredKey" end
v119[v120] = v121
v120 = "Finished"
v121 = false
if type(v119) ~= "table" and type(v119) ~= "userdata" then v119 = newRecoveredTable() end
if v120 == nil then v120 = "RecoveredKey" end
v119[v120] = v121
v120 = "Item name"
if type(v119) ~= "table" and type(v119) ~= "userdata" then v119 = newRecoveredTable() end
v119.Text = v120
v120 = "Tooltip"
v121 = "Item to grab"
if type(v119) ~= "table" and type(v119) ~= "userdata" then v119 = newRecoveredTable() end
if v120 == nil then v120 = "RecoveredKey" end
v119[v120] = v121
v120 = "Placeholder"
v121 = "AS Val"
if type(v119) ~= "table" and type(v119) ~= "userdata" then v119 = newRecoveredTable() end
if v120 == nil then v120 = "RecoveredKey" end
v119[v120] = v121
v120 = "Callback"

function v121(v251)
  -- synthetic register locals stripped
end

function v120(v251)
  -- synthetic register locals stripped
  v252 = v1012
  if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
  v252 = v252.GetPlayerPrimary
  v253 = v1014
  if type(v253) ~= "table" and type(v253) ~= "userdata" then v253 = newRecoveredTable() end
  v253 = v253.Name
  v252 = ensureCallable(v252)
  v252 = v252(v253)
  if v252 then
  end
  -- removed decompiler goto
  -- removed decompiler label lbl_9
  do return end
  v254 = v253
  if type(v253) ~= "table" and type(v253) ~= "userdata" then v253 = newRecoveredTable() end
  v253 = v253.GetPartBoundsInBox
  v258 = 1000
  v256 = ensureCallable(v256)
  v256 = v256(v257, v258, v259, v260)
  v257 = nil
  v253 = ensureCallable(v253)
  v253 = v253(v254, v255, v256, v257, v258)
  v254 = nil
  v256 = ensureCallable(v256)
  v256, v257, v258 = v256(v257)
  for v259, v260 in v256, v257, v258 do
    v262 = v261
    if type(v261) ~= "table" and type(v261) ~= "userdata" then v261 = newRecoveredTable() end
    v261 = v261.match
    v261 = ensureCallable(v261)
    v261 = v261(v262, v263, v264)
    if not v261 then
    end
    -- removed decompiler goto
    if v261 == "Marker" then
    end
    -- removed decompiler goto
    v262 = v261
    if type(v261) ~= "table" and type(v261) ~= "userdata" then v261 = newRecoveredTable() end
    v261 = v261.GetAttribute
    v263 = "YieldLeft"
    v261 = ensureCallable(v261)
    v261 = v261(v262, v263, v264)
    if v261 then
      v262 = v261
      if type(v261) ~= "table" and type(v261) ~= "userdata" then v261 = newRecoveredTable() end
      v261 = v261.GetAttribute
      v263 = "YieldLeft"
      v261 = ensureCallable(v261)
      v261 = v261(v262, v263, v264)
      if not (500 < v261) then
      end
    else
    end
    -- removed decompiler goto
    -- removed decompiler label lbl_38
  end
  return v256, v257
end

function v121(v251, v501)
  -- synthetic register locals stripped
  v253 = getgenv
  v253 = ensureCallable(v253)
  v253 = v253()
  if type(v253) ~= "table" and type(v253) ~= "userdata" then v253 = newRecoveredTable() end
  v253.enabled = v501
  v253 = v1012
  if type(v253) ~= "table" and type(v253) ~= "userdata" then v253 = newRecoveredTable() end
  v253 = v253.GetPlayerPrimary
  v254 = v1014
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254 = v254.Name
  v253 = ensureCallable(v253)
  v253 = v253(v254)
  if not v253 then
  end
  do return end
  if false then -- removed constant-true decompiler loop
    v255 = ensureCallable(v255)
    v255 = v255()
    if not v255 then
    end
    -- removed decompiler goto
    v255 = ensureCallable(v255)
    v255, v256 = v255(v256)
    if type(v253) ~= "table" and type(v253) ~= "userdata" then v253 = newRecoveredTable() end
    v253.CFrame = v257
    v257 = 1
    v259 = 1
    for v260 = v257, v258, v259 do
      v262 = "Melee Hit"
      v266 = -2326.426025390625
      v267 = 87.04510498046875
      v268 = 499.3544921875
      v269 = -0.746397852897644
      v270 = 0.01643068715929985
      v271 = 0.6652970910072327
      v272 = -9.313225746154785E-10
      v273 = 0.9996951818466187
      v274 = -0.024689236655831337
      v275 = -0.6654999852180481
      v276 = -0.01842799410223961
      v277 = -0.7461703419685364
      v265 = ensureCallable(v265)
      v265 = v265(v266, v267, v268, v269, v270, v271, v272, v273, v274, v275, v276, v277, v278)
      v268 = false
      if type(v255) ~= "table" and type(v255) ~= "userdata" then v255 = newRecoveredTable() end
      v269 = v255.Parent
      v270 = nil
      if type(v261) ~= "table" and type(v261) ~= "userdata" then v261 = newRecoveredTable() end
      v261[10] = false
      if type(v261) ~= "table" and type(v261) ~= "userdata" then v261 = newRecoveredTable() end
      v261[11] = 43
      if type(v261) ~= "table" and type(v261) ~= "userdata" then v261 = newRecoveredTable() end
      v261[12] = 30
      if type(v261) ~= "table" and type(v261) ~= "userdata" then v261 = newRecoveredTable() end
      v261[13] = 17
      if type(v261) ~= "table" and type(v261) ~= "userdata" then v261 = newRecoveredTable() end
      v261[14] = 7
      if type(v261) ~= "table" and type(v261) ~= "userdata" then v261 = newRecoveredTable() end
      v261[15] = 3
      if type(v261) ~= "table" and type(v261) ~= "userdata" then v261 = newRecoveredTable() end
      v261[16] = 25
      if type(v261) ~= "table" and type(v261) ~= "userdata" then v261 = newRecoveredTable() end
      v261[17] = 21
      if type(v261) ~= "table" and type(v261) ~= "userdata" then v261 = newRecoveredTable() end
      v261[18] = 12
      if type(v261) ~= "table" and type(v261) ~= "userdata" then v261 = newRecoveredTable() end
      v261[19] = 49
      if type(v261) ~= "table" and type(v261) ~= "userdata" then v261 = newRecoveredTable() end
      v261[20] = 36
      if type(v261) ~= "table" and type(v261) ~= "userdata" then v261 = newRecoveredTable() end
      v261[21] = 15
      if type(v261) ~= "table" and type(v261) ~= "userdata" then v261 = newRecoveredTable() end
      v261[22] = 50
      if type(v261) ~= "table" and type(v261) ~= "userdata" then v261 = newRecoveredTable() end
      v261[23] = 45
      if type(v261) ~= "table" and type(v261) ~= "userdata" then v261 = newRecoveredTable() end
      v261[24] = 41
      if type(v261) ~= "table" and type(v261) ~= "userdata" then v261 = newRecoveredTable() end
      v261[25] = 26
      if type(v261) ~= "table" and type(v261) ~= "userdata" then v261 = newRecoveredTable() end
      v261[26] = 26
      if type(v261) ~= "table" and type(v261) ~= "userdata" then v261 = newRecoveredTable() end
      v261[27] = 46
      if type(v261) ~= "table" and type(v261) ~= "userdata" then v261 = newRecoveredTable() end
      v261[28] = 29
      if type(v261) ~= "table" and type(v261) ~= "userdata" then v261 = newRecoveredTable() end
      v261[29] = 25
      if type(v261) ~= "table" and type(v261) ~= "userdata" then v261 = newRecoveredTable() end
      v261[30] = 45
      if type(v261) ~= "table" and type(v261) ~= "userdata" then v261 = newRecoveredTable() end
      v261[31] = 46
      if type(v261) ~= "table" and type(v261) ~= "userdata" then v261 = newRecoveredTable() end
      v261[32] = 34
      if type(v261) ~= "table" and type(v261) ~= "userdata" then v261 = newRecoveredTable() end
      v261[33] = 43
      if type(v261) ~= "table" and type(v261) ~= "userdata" then v261 = newRecoveredTable() end
      v261[34] = 32
      if type(v261) ~= "table" and type(v261) ~= "userdata" then v261 = newRecoveredTable() end
      v261[35] = 40
      if type(v261) ~= "table" and type(v261) ~= "userdata" then v261 = newRecoveredTable() end
      v261[36] = 46
      if type(v261) ~= "table" and type(v261) ~= "userdata" then v261 = newRecoveredTable() end
      v261[37] = 41
      if type(v261) ~= "table" and type(v261) ~= "userdata" then v261 = newRecoveredTable() end
      v261[38] = 12
      if type(v261) ~= "table" and type(v261) ~= "userdata" then v261 = newRecoveredTable() end
      v261[39] = 41
      if type(v261) ~= "table" and type(v261) ~= "userdata" then v261 = newRecoveredTable() end
      v261[40] = 1
      if type(v261) ~= "table" and type(v261) ~= "userdata" then v261 = newRecoveredTable() end
      v261[41] = 21
      if type(v261) ~= "table" and type(v261) ~= "userdata" then v261 = newRecoveredTable() end
      v261[42] = 7
      if type(v261) ~= "table" and type(v261) ~= "userdata" then v261 = newRecoveredTable() end
      v261[43] = 40
      if type(v261) ~= "table" and type(v261) ~= "userdata" then v261 = newRecoveredTable() end
      v261[44] = 6
      if type(v261) ~= "table" and type(v261) ~= "userdata" then v261 = newRecoveredTable() end
      v261[45] = 8
      if type(v261) ~= "table" and type(v261) ~= "userdata" then v261 = newRecoveredTable() end
      v261[1] = v262
      if type(v261) ~= "table" and type(v261) ~= "userdata" then v261 = newRecoveredTable() end
      v261[2] = v263
      if type(v261) ~= "table" and type(v261) ~= "userdata" then v261 = newRecoveredTable() end
      v261[3] = v264
      if type(v261) ~= "table" and type(v261) ~= "userdata" then v261 = newRecoveredTable() end
      v261[4] = v265
      if type(v261) ~= "table" and type(v261) ~= "userdata" then v261 = newRecoveredTable() end
      v261[5] = v266
      if type(v261) ~= "table" and type(v261) ~= "userdata" then v261 = newRecoveredTable() end
      v261[6] = v267
      if type(v261) ~= "table" and type(v261) ~= "userdata" then v261 = newRecoveredTable() end
      v261[7] = v268
      if type(v261) ~= "table" and type(v261) ~= "userdata" then v261 = newRecoveredTable() end
      v261[8] = v269
      if type(v261) ~= "table" and type(v261) ~= "userdata" then v261 = newRecoveredTable() end
      v261[9] = v270
      v263 = v262
      if type(v262) ~= "table" and type(v262) ~= "userdata" then v262 = newRecoveredTable() end
      v262 = v262.GetService
      v264 = "ReplicatedStorage"
      v262 = ensureCallable(v262)
      v262 = v262(v263, v264, v265)
      v263 = v262
      if type(v262) ~= "table" and type(v262) ~= "userdata" then v262 = newRecoveredTable() end
      v262 = v262.WaitForChild
      v264 = "Remotes"
      v262 = ensureCallable(v262)
      v262 = v262(v263, v264, v265)
      v263 = v262
      if type(v262) ~= "table" and type(v262) ~= "userdata" then v262 = newRecoveredTable() end
      v262 = v262.WaitForChild
      v264 = "RemoteEvent"
      v262 = ensureCallable(v262)
      v262 = v262(v263, v264, v265)
      v263 = v262
      if type(v262) ~= "table" and type(v262) ~= "userdata" then v262 = newRecoveredTable() end
      v262 = v262.FireServer
      v264 = unpack
      v265 = v261
  -- synthetic vararg register fan-out stripped
      -- trimmed huge synthetic register fan-out
      v262(v263, v264, v265, v266, v267, v268, v269, v270)
      v262 = ensureCallable(v262)
      v262()
    end
    -- removed decompiler label lbl_91
  end
  if type(v253) ~= "table" and type(v253) ~= "userdata" then v253 = newRecoveredTable() end
  v253.CFrame = v254
end

v125 = "AddToggle"
v124 = v81
if type(v81) ~= "table" and type(v81) ~= "userdata" then v81 = newRecoveredTable() end
v123 = v81[v125]
v125 = "FlightEnabled"
if type(v126) ~= "table" and type(v126) ~= "userdata" then v126 = newRecoveredTable() end
v126.Text = "Enabled"

function v128(v251)
  -- synthetic register locals stripped
  v252 = v1012
  if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
  v252 = v252.Movement
  if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
  v252 = v252.Flight
  if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
  v252.Enabled = v251
end

if type(v126) ~= "table" and type(v126) ~= "userdata" then v126 = newRecoveredTable() end
if v127 == nil then v127 = "RecoveredKey" end
v126[v127] = v128
v123 = ensureCallable(v123)
v123 = v123(v124, v125, v126, v127)
v125 = "AddKeyPicker"
v124 = v123
if type(v123) ~= "table" and type(v123) ~= "userdata" then v123 = newRecoveredTable() end
v123 = v123[v125]
v125 = "FlightKeybind"
v127 = "Default"
v128 = "F"
if type(v126) ~= "table" and type(v126) ~= "userdata" then v126 = newRecoveredTable() end
if v127 == nil then v127 = "RecoveredKey" end
v126[v127] = v128
v127 = "SyncToggleState"
if type(v126) ~= "table" and type(v126) ~= "userdata" then v126 = newRecoveredTable() end
if v127 == nil then v127 = "RecoveredKey" end
v126[v127] = v128
v127 = "Mode"
v128 = "Toggle"
if type(v126) ~= "table" and type(v126) ~= "userdata" then v126 = newRecoveredTable() end
if v127 == nil then v127 = "RecoveredKey" end
v126[v127] = v128
if type(v126) ~= "table" and type(v126) ~= "userdata" then v126 = newRecoveredTable() end
v126.Text = "Flight"
v127 = "NoUI"
if type(v126) ~= "table" and type(v126) ~= "userdata" then v126 = newRecoveredTable() end
if v127 == nil then v127 = "RecoveredKey" end
v126[v127] = v128
v127 = "Callback"

function v128(v251)
  -- synthetic register locals stripped
end

if type(v126) ~= "table" and type(v126) ~= "userdata" then v126 = newRecoveredTable() end
if v127 == nil then v127 = "RecoveredKey" end
v126[v127] = v128
v127 = "ChangedCallback"
if type(v126) ~= "table" and type(v126) ~= "userdata" then v126 = newRecoveredTable() end
if v127 == nil then v127 = "RecoveredKey" end
v126[v127] = v128
v127 = "Min"
v128 = 0
if type(v126) ~= "table" and type(v126) ~= "userdata" then v126 = newRecoveredTable() end
if v127 == nil then v127 = "RecoveredKey" end
v126[v127] = v128
v127 = "Max"
v128 = 1000
if type(v126) ~= "table" and type(v126) ~= "userdata" then v126 = newRecoveredTable() end
if v127 == nil then v127 = "RecoveredKey" end
v126[v127] = v128
v127 = "Rounding"
v128 = 1
if type(v126) ~= "table" and type(v126) ~= "userdata" then v126 = newRecoveredTable() end
if v127 == nil then v127 = "RecoveredKey" end
v126[v127] = v128
v127 = "Compact"
if type(v126) ~= "table" and type(v126) ~= "userdata" then v126 = newRecoveredTable() end
if v127 == nil then v127 = "RecoveredKey" end
v126[v127] = v128
v127 = "Callback"

function v128(v251)
  -- synthetic register locals stripped
  v252 = v1012
  if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
  v252 = v252.Movement
  if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
  v252 = v252.Flight
  if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
  v252.DirectionSpeed = v251
end

if type(v126) ~= "table" and type(v126) ~= "userdata" then v126 = newRecoveredTable() end
if v127 == nil then v127 = "RecoveredKey" end
v126[v127] = v128
v127 = "Min"
v128 = 0
if type(v126) ~= "table" and type(v126) ~= "userdata" then v126 = newRecoveredTable() end
if v127 == nil then v127 = "RecoveredKey" end
v126[v127] = v128
v127 = "Max"
v128 = 50
if type(v126) ~= "table" and type(v126) ~= "userdata" then v126 = newRecoveredTable() end
if v127 == nil then v127 = "RecoveredKey" end
v126[v127] = v128
v127 = "Rounding"
v128 = 1
if type(v126) ~= "table" and type(v126) ~= "userdata" then v126 = newRecoveredTable() end
if v127 == nil then v127 = "RecoveredKey" end
v126[v127] = v128
v127 = "Compact"
if type(v126) ~= "table" and type(v126) ~= "userdata" then v126 = newRecoveredTable() end
if v127 == nil then v127 = "RecoveredKey" end
v126[v127] = v128
v127 = "Callback"

function v128(v251)
  -- synthetic register locals stripped
  v252 = v1012
  if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
  v252 = v252.Movement
  if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
  v252 = v252.Flight
  if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
  v252.YSpeed = v251
end

if type(v126) ~= "table" and type(v126) ~= "userdata" then v126 = newRecoveredTable() end
v126.Text = "Enabled"

function v128(v251)
  -- synthetic register locals stripped
  v252 = v1012
  if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
  v252 = v252.Movement
  if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
  v252 = v252.Bhop
  if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
  v252.Enabled = v251
end

if type(v126) ~= "table" and type(v126) ~= "userdata" then v126 = newRecoveredTable() end
if v127 == nil then v127 = "RecoveredKey" end
v126[v127] = v128
v127 = "Min"
v128 = 0
if type(v126) ~= "table" and type(v126) ~= "userdata" then v126 = newRecoveredTable() end
if v127 == nil then v127 = "RecoveredKey" end
v126[v127] = v128
v127 = "Max"
v128 = 200
if type(v126) ~= "table" and type(v126) ~= "userdata" then v126 = newRecoveredTable() end
if v127 == nil then v127 = "RecoveredKey" end
v126[v127] = v128
v127 = "Rounding"
v128 = 1
if type(v126) ~= "table" and type(v126) ~= "userdata" then v126 = newRecoveredTable() end
if v127 == nil then v127 = "RecoveredKey" end
v126[v127] = v128
v127 = "Compact"
if type(v126) ~= "table" and type(v126) ~= "userdata" then v126 = newRecoveredTable() end
if v127 == nil then v127 = "RecoveredKey" end
v126[v127] = v128
v127 = "Callback"

function v128(v251)
  -- synthetic register locals stripped
  v252 = v1012
  if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
  v252 = v252.Movement
  if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
  v252 = v252.Bhop
  if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
  v252.AutobhopDelay = v251
end

if type(v126) ~= "table" and type(v126) ~= "userdata" then v126 = newRecoveredTable() end
if v127 == nil then v127 = "RecoveredKey" end
v126[v127] = v128
v127 = "Min"
v128 = 0
if type(v126) ~= "table" and type(v126) ~= "userdata" then v126 = newRecoveredTable() end
if v127 == nil then v127 = "RecoveredKey" end
v126[v127] = v128
v127 = "Max"
v128 = 1000
if type(v126) ~= "table" and type(v126) ~= "userdata" then v126 = newRecoveredTable() end
if v127 == nil then v127 = "RecoveredKey" end
v126[v127] = v128
v127 = "Rounding"
v128 = 1
if type(v126) ~= "table" and type(v126) ~= "userdata" then v126 = newRecoveredTable() end
if v127 == nil then v127 = "RecoveredKey" end
v126[v127] = v128
v127 = "Compact"
if type(v126) ~= "table" and type(v126) ~= "userdata" then v126 = newRecoveredTable() end
if v127 == nil then v127 = "RecoveredKey" end
v126[v127] = v128
v127 = "Callback"

function v128(v251)
  -- synthetic register locals stripped
  v252 = v1012
  if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
  v252 = v252.Movement
  if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
  v252 = v252.Bhop
  if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
  v252.Value = v251
end

if type(v126) ~= "table" and type(v126) ~= "userdata" then v126 = newRecoveredTable() end
v126.Text = "Enabled"

function v128(v251)
  -- synthetic register locals stripped
  v252 = v1012
  if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
  v252 = v252.Movement
  if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
  v252 = v252.WalkSpeed
  if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
  v252.Enabled = v251
end

if type(v126) ~= "table" and type(v126) ~= "userdata" then v126 = newRecoveredTable() end
if v127 == nil then v127 = "RecoveredKey" end
v126[v127] = v128
v127 = "Min"
v128 = 0
if type(v126) ~= "table" and type(v126) ~= "userdata" then v126 = newRecoveredTable() end
if v127 == nil then v127 = "RecoveredKey" end
v126[v127] = v128
v127 = "Max"
v128 = 200
if type(v126) ~= "table" and type(v126) ~= "userdata" then v126 = newRecoveredTable() end
if v127 == nil then v127 = "RecoveredKey" end
v126[v127] = v128
v127 = "Rounding"
v128 = 1
if type(v126) ~= "table" and type(v126) ~= "userdata" then v126 = newRecoveredTable() end
if v127 == nil then v127 = "RecoveredKey" end
v126[v127] = v128
v127 = "Compact"
if type(v126) ~= "table" and type(v126) ~= "userdata" then v126 = newRecoveredTable() end
if v127 == nil then v127 = "RecoveredKey" end
v126[v127] = v128
v127 = "Callback"

function v128(v251)
  -- synthetic register locals stripped
  v252 = v1012
  if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
  v252 = v252.Movement
  if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
  v252 = v252.WalkSpeed
  if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
  v252.Value = v251
end

if type(v126) ~= "table" and type(v126) ~= "userdata" then v126 = newRecoveredTable() end
v126.Text = "Enabled"

function v128(v251)
  -- synthetic register locals stripped
  v252 = v1012
  if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
  v252 = v252.Movement
  if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
  v252 = v252.JumpPower
  if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
  v252.Enabled = v251
end

if type(v126) ~= "table" and type(v126) ~= "userdata" then v126 = newRecoveredTable() end
if v127 == nil then v127 = "RecoveredKey" end
v126[v127] = v128
v127 = "Min"
v128 = 0
if type(v126) ~= "table" and type(v126) ~= "userdata" then v126 = newRecoveredTable() end
if v127 == nil then v127 = "RecoveredKey" end
v126[v127] = v128
v127 = "Max"
v128 = 200
if type(v126) ~= "table" and type(v126) ~= "userdata" then v126 = newRecoveredTable() end
if v127 == nil then v127 = "RecoveredKey" end
v126[v127] = v128
v127 = "Rounding"
v128 = 1
if type(v126) ~= "table" and type(v126) ~= "userdata" then v126 = newRecoveredTable() end
if v127 == nil then v127 = "RecoveredKey" end
v126[v127] = v128
v127 = "Compact"
if type(v126) ~= "table" and type(v126) ~= "userdata" then v126 = newRecoveredTable() end
if v127 == nil then v127 = "RecoveredKey" end
v126[v127] = v128
v127 = "Callback"

function v128(v251)
  -- synthetic register locals stripped
  v252 = v1012
  if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
  v252 = v252.Movement
  if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
  v252 = v252.JumpPower
  if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
  v252.Value = v251
end

if type(v126) ~= "table" and type(v126) ~= "userdata" then v126 = newRecoveredTable() end
if v127 == nil then v127 = "RecoveredKey" end
v126[v127] = v128
v123 = ensureCallable(v123)
v123(v124, v125, v126)
v125 = "AddToggle"
v124 = v82
if type(v82) ~= "table" and type(v82) ~= "userdata" then v82 = newRecoveredTable() end
v123 = v82[v125]
v125 = "AntiAimEnabled"
v126 = {}
if type(v126) ~= "table" and type(v126) ~= "userdata" then v126 = newRecoveredTable() end
v126.Text = "Enabled"
v127 = "Default"
v128 = false
if type(v126) ~= "table" and type(v126) ~= "userdata" then v126 = newRecoveredTable() end
if v127 == nil then v127 = "RecoveredKey" end
v126[v127] = v128
v127 = "Tooltip"
v128 = "Enables anti aim"
if type(v126) ~= "table" and type(v126) ~= "userdata" then v126 = newRecoveredTable() end
if v127 == nil then v127 = "RecoveredKey" end
v126[v127] = v128
v127 = "Callback"

function v128(v251)
  -- synthetic register locals stripped
  v252 = v1012
  if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
  v252 = v252.Movement
  if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
  v252 = v252.AntiAim
  if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
  v252.Enabled = v251
end

if type(v126) ~= "table" and type(v126) ~= "userdata" then v126 = newRecoveredTable() end
if v127 == nil then v127 = "RecoveredKey" end
v126[v127] = v128
v123 = ensureCallable(v123)
v123(v124, v125, v126)
v125 = "AddDropdown"
v124 = v82
if type(v82) ~= "table" and type(v82) ~= "userdata" then v82 = newRecoveredTable() end
v123 = v82[v125]
v125 = "AntiAimYaw"
v126 = {}
v127 = "Values"
v128 = {}
v129 = "Jitter"
v130 = "Spin"
v131 = "Backward"
v132 = "Target"
v133 = "Freeze"
if type(v128) ~= "table" and type(v128) ~= "userdata" then v128 = newRecoveredTable() end
v128[1] = v129
if type(v128) ~= "table" and type(v128) ~= "userdata" then v128 = newRecoveredTable() end
v128[2] = v130
if type(v128) ~= "table" and type(v128) ~= "userdata" then v128 = newRecoveredTable() end
v128[3] = v131
if type(v128) ~= "table" and type(v128) ~= "userdata" then v128 = newRecoveredTable() end
v128[4] = v132
if type(v128) ~= "table" and type(v128) ~= "userdata" then v128 = newRecoveredTable() end
v128[5] = v133
if type(v126) ~= "table" and type(v126) ~= "userdata" then v126 = newRecoveredTable() end
if v127 == nil then v127 = "RecoveredKey" end
v126[v127] = v128
v127 = "Callback"

function v128(v251)
  -- synthetic register locals stripped
  v252 = v1012
  if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
  v252 = v252.Movement
  if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
  v252 = v252.AntiAim
  if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
  v252.Type = v251
end

if type(v126) ~= "table" and type(v126) ~= "userdata" then v126 = newRecoveredTable() end
if v127 == nil then v127 = "RecoveredKey" end
v126[v127] = v128
v127 = "Min"
v128 = 0
if type(v126) ~= "table" and type(v126) ~= "userdata" then v126 = newRecoveredTable() end
if v127 == nil then v127 = "RecoveredKey" end
v126[v127] = v128
v127 = "Max"
v128 = 360
if type(v126) ~= "table" and type(v126) ~= "userdata" then v126 = newRecoveredTable() end
if v127 == nil then v127 = "RecoveredKey" end
v126[v127] = v128
v127 = "Rounding"
v128 = 1
if type(v126) ~= "table" and type(v126) ~= "userdata" then v126 = newRecoveredTable() end
if v127 == nil then v127 = "RecoveredKey" end
v126[v127] = v128
v127 = "Compact"
if type(v126) ~= "table" and type(v126) ~= "userdata" then v126 = newRecoveredTable() end
if v127 == nil then v127 = "RecoveredKey" end
v126[v127] = v128
v127 = "Callback"

function v128(v251)
  -- synthetic register locals stripped
  v252 = v1012
  if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
  v252 = v252.Movement
  if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
  v252 = v252.AntiAim
  if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
  v252.Yaw = v251
end

if type(v126) ~= "table" and type(v126) ~= "userdata" then v126 = newRecoveredTable() end
if v127 == nil then v127 = "RecoveredKey" end
v126[v127] = v128
v123 = ensureCallable(v123)
v123(v124, v125, v126)
v125 = "AddToggle"
v124 = v83
if type(v83) ~= "table" and type(v83) ~= "userdata" then v83 = newRecoveredTable() end
v123 = v83[v125]
v125 = "TextEnabled"
v126 = {}
if type(v126) ~= "table" and type(v126) ~= "userdata" then v126 = newRecoveredTable() end
v126.Text = "Enabled"
v127 = "Default"
v128 = false
if type(v126) ~= "table" and type(v126) ~= "userdata" then v126 = newRecoveredTable() end
if v127 == nil then v127 = "RecoveredKey" end
v126[v127] = v128
v127 = "Tooltip"
v128 = "Enables text esp"
if type(v126) ~= "table" and type(v126) ~= "userdata" then v126 = newRecoveredTable() end
if v127 == nil then v127 = "RecoveredKey" end
v126[v127] = v128
v127 = "Callback"

function v128(v251)
  -- synthetic register locals stripped
  v252 = v1012
  if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
  v252 = v252.Visuals
  if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
  v252 = v252.Text
  if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
  v252.Enabled = v251
end

if type(v126) ~= "table" and type(v126) ~= "userdata" then v126 = newRecoveredTable() end
if v127 == nil then v127 = "RecoveredKey" end
v126[v127] = v128
v123 = ensureCallable(v123)
v123(v124, v125, v126)
v125 = "AddToggle"
v124 = v83
if type(v83) ~= "table" and type(v83) ~= "userdata" then v83 = newRecoveredTable() end
v123 = v83[v125]
v125 = "TextOutline"
v126 = {}
if type(v126) ~= "table" and type(v126) ~= "userdata" then v126 = newRecoveredTable() end
v126.Text = "Outline"
v127 = "Default"
v128 = false
if type(v126) ~= "table" and type(v126) ~= "userdata" then v126 = newRecoveredTable() end
if v127 == nil then v127 = "RecoveredKey" end
v126[v127] = v128
v127 = "Tooltip"
v128 = "Displays outline"
if type(v126) ~= "table" and type(v126) ~= "userdata" then v126 = newRecoveredTable() end
if v127 == nil then v127 = "RecoveredKey" end
v126[v127] = v128
v127 = "Callback"

function v128(v251)
  -- synthetic register locals stripped
  v252 = v1012
  if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
  v252 = v252.Visuals
  if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
  v252 = v252.Text
  if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
  v252.Outline = v251
end

if type(v126) ~= "table" and type(v126) ~= "userdata" then v126 = newRecoveredTable() end
if v127 == nil then v127 = "RecoveredKey" end
v126[v127] = v128
v123 = ensureCallable(v123)
v123(v124, v125, v126)
v125 = "AddToggle"
v124 = v83
if type(v83) ~= "table" and type(v83) ~= "userdata" then v83 = newRecoveredTable() end
v123 = v83[v125]
v125 = "TextName"
v127 = "Display name"
if type(v126) ~= "table" and type(v126) ~= "userdata" then v126 = newRecoveredTable() end
v126.Text = v127

function v128(v251)
  -- synthetic register locals stripped
  v252 = v1012
  if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
  v252 = v252.Visuals
  if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
  v252 = v252.Text
  if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
  v252.Name = v251
end

if type(v126) ~= "table" and type(v126) ~= "userdata" then v126 = newRecoveredTable() end
if v127 == nil then v127 = "RecoveredKey" end
v126[v127] = v128
v123 = ensureCallable(v123)
v123(v124, v125, v126)
v125 = "AddToggle"
v124 = v83
if type(v83) ~= "table" and type(v83) ~= "userdata" then v83 = newRecoveredTable() end
v123 = v83[v125]
v125 = "TextHealth"
v127 = "Display health"
if type(v126) ~= "table" and type(v126) ~= "userdata" then v126 = newRecoveredTable() end
v126.Text = v127

function v128(v251)
  -- synthetic register locals stripped
  v252 = v1012
  if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
  v252 = v252.Visuals
  if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
  v252 = v252.Text
  if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
  v252.Health = v251
end

if type(v126) ~= "table" and type(v126) ~= "userdata" then v126 = newRecoveredTable() end
if v127 == nil then v127 = "RecoveredKey" end
v126[v127] = v128
v123 = ensureCallable(v123)
v123(v124, v125, v126)
v125 = "AddToggle"
v124 = v83
if type(v83) ~= "table" and type(v83) ~= "userdata" then v83 = newRecoveredTable() end
v123 = v83[v125]
v125 = "TextDistance"
v127 = "Display distance"
if type(v126) ~= "table" and type(v126) ~= "userdata" then v126 = newRecoveredTable() end
v126.Text = v127

function v128(v251)
  -- synthetic register locals stripped
  v252 = v1012
  if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
  v252 = v252.Visuals
  if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
  v252 = v252.Text
  if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
  v252.Distance = v251
end

if type(v126) ~= "table" and type(v126) ~= "userdata" then v126 = newRecoveredTable() end
if v127 == nil then v127 = "RecoveredKey" end
v126[v127] = v128
v127 = "Min"
v128 = 1
if type(v126) ~= "table" and type(v126) ~= "userdata" then v126 = newRecoveredTable() end
if v127 == nil then v127 = "RecoveredKey" end
v126[v127] = v128
v127 = "Max"
v128 = 50
if type(v126) ~= "table" and type(v126) ~= "userdata" then v126 = newRecoveredTable() end
if v127 == nil then v127 = "RecoveredKey" end
v126[v127] = v128
v127 = "Rounding"
v128 = 1
if type(v126) ~= "table" and type(v126) ~= "userdata" then v126 = newRecoveredTable() end
if v127 == nil then v127 = "RecoveredKey" end
v126[v127] = v128
v127 = "Compact"
if type(v126) ~= "table" and type(v126) ~= "userdata" then v126 = newRecoveredTable() end
if v127 == nil then v127 = "RecoveredKey" end
v126[v127] = v128
v127 = "Callback"

function v128(v251)
  -- synthetic register locals stripped
  v252 = v1012
  if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
  v252 = v252.Visuals
  if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
  v252 = v252.Text
  if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
  v252.Offset = v251
end

v127 = "Default"
v129 = 255
v130 = 255
v131 = 255
v128 = ensureCallable(v128)
v128 = v128(v129, v130, v131, v132)
if type(v126) ~= "table" and type(v126) ~= "userdata" then v126 = newRecoveredTable() end
if v127 == nil then v127 = "RecoveredKey" end
v126[v127] = v128
v127 = "Title"
v128 = "Text Color"
if type(v126) ~= "table" and type(v126) ~= "userdata" then v126 = newRecoveredTable() end
if v127 == nil then v127 = "RecoveredKey" end
v126[v127] = v128
v127 = 0
if type(v126) ~= "table" and type(v126) ~= "userdata" then v126 = newRecoveredTable() end
v126.Transparency = v127
v127 = "Callback"

function v128(v251)
  -- synthetic register locals stripped
  v252 = v1012
  if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
  v252 = v252.Visuals
  if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
  v252 = v252.Text
  if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
  v252.TextColor = v251
end

if type(v126) ~= "table" and type(v126) ~= "userdata" then v126 = newRecoveredTable() end
if v127 == nil then v127 = "RecoveredKey" end
v126[v127] = v128
v127 = "Min"
v128 = 1
if type(v126) ~= "table" and type(v126) ~= "userdata" then v126 = newRecoveredTable() end
if v127 == nil then v127 = "RecoveredKey" end
v126[v127] = v128
v127 = "Max"
v128 = 10
if type(v126) ~= "table" and type(v126) ~= "userdata" then v126 = newRecoveredTable() end
if v127 == nil then v127 = "RecoveredKey" end
v126[v127] = v128
v127 = "Rounding"
v128 = 1
if type(v126) ~= "table" and type(v126) ~= "userdata" then v126 = newRecoveredTable() end
if v127 == nil then v127 = "RecoveredKey" end
v126[v127] = v128
v127 = "Compact"
if type(v126) ~= "table" and type(v126) ~= "userdata" then v126 = newRecoveredTable() end
if v127 == nil then v127 = "RecoveredKey" end
v126[v127] = v128
v127 = "Callback"

function v128(v251)
  -- synthetic register locals stripped
  v252 = v1012
  if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
  v252 = v252.Visuals
  if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
  v252 = v252.Text
  v253 = v251 / 10
  if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
  v252.Transparency = v253
end

if type(v126) ~= "table" and type(v126) ~= "userdata" then v126 = newRecoveredTable() end
if v127 == nil then v127 = "RecoveredKey" end
v126[v127] = v128
v127 = "Min"
v128 = 1
if type(v126) ~= "table" and type(v126) ~= "userdata" then v126 = newRecoveredTable() end
if v127 == nil then v127 = "RecoveredKey" end
v126[v127] = v128
v127 = "Max"
v128 = 50
if type(v126) ~= "table" and type(v126) ~= "userdata" then v126 = newRecoveredTable() end
if v127 == nil then v127 = "RecoveredKey" end
v126[v127] = v128
v127 = "Rounding"
v128 = 1
if type(v126) ~= "table" and type(v126) ~= "userdata" then v126 = newRecoveredTable() end
if v127 == nil then v127 = "RecoveredKey" end
v126[v127] = v128
v127 = "Compact"
if type(v126) ~= "table" and type(v126) ~= "userdata" then v126 = newRecoveredTable() end
if v127 == nil then v127 = "RecoveredKey" end
v126[v127] = v128
v127 = "Callback"

function v128(v251)
  -- synthetic register locals stripped
  v252 = v1012
  if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
  v252 = v252.Visuals
  if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
  v252 = v252.Text
  if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
  v252.TextSize = v251
end

if type(v126) ~= "table" and type(v126) ~= "userdata" then v126 = newRecoveredTable() end
if v127 == nil then v127 = "RecoveredKey" end
v126[v127] = v128
v123 = ensureCallable(v123)
v123(v124, v125, v126)
v125 = "AddToggle"
v124 = v85
if type(v85) ~= "table" and type(v85) ~= "userdata" then v85 = newRecoveredTable() end
v123 = v85[v125]
v125 = "ChamsEspEnabled"
v126 = {}
if type(v126) ~= "table" and type(v126) ~= "userdata" then v126 = newRecoveredTable() end
v126.Text = "Enabled"
v127 = "Default"
v128 = false
if type(v126) ~= "table" and type(v126) ~= "userdata" then v126 = newRecoveredTable() end
if v127 == nil then v127 = "RecoveredKey" end
v126[v127] = v128
v127 = "Tooltip"
v128 = "Displays chams"
if type(v126) ~= "table" and type(v126) ~= "userdata" then v126 = newRecoveredTable() end
if v127 == nil then v127 = "RecoveredKey" end
v126[v127] = v128
v127 = "Callback"

function v128(v251)
  -- synthetic register locals stripped
  v252 = v1012
  if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
  v252 = v252.Visuals
  if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
  v252 = v252.Chams
  if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
  v252.Enabled = v251
end

if type(v126) ~= "table" and type(v126) ~= "userdata" then v126 = newRecoveredTable() end
if v127 == nil then v127 = "RecoveredKey" end
v126[v127] = v128
v123 = ensureCallable(v123)
v123 = v123(v124, v125, v126, v127)
v125 = "AddColorPicker"
v124 = v123
if type(v123) ~= "table" and type(v123) ~= "userdata" then v123 = newRecoveredTable() end
v123 = v123[v125]
v125 = "Chams color"
v126 = {}
v127 = "Default"
v128 = Color3
if type(v128) ~= "table" and type(v128) ~= "userdata" then v128 = newRecoveredTable() end
v128 = v128.fromRGB
v129 = 255
v130 = 255
v131 = 255
v128 = ensureCallable(v128)
v128 = v128(v129, v130, v131, v132)
if type(v126) ~= "table" and type(v126) ~= "userdata" then v126 = newRecoveredTable() end
if v127 == nil then v127 = "RecoveredKey" end
v126[v127] = v128
v127 = "Title"
v128 = "Chams color"
if type(v126) ~= "table" and type(v126) ~= "userdata" then v126 = newRecoveredTable() end
if v127 == nil then v127 = "RecoveredKey" end
v126[v127] = v128
v127 = 0
if type(v126) ~= "table" and type(v126) ~= "userdata" then v126 = newRecoveredTable() end
v126.Transparency = v127
v127 = "Callback"

function v128(v251)
  -- synthetic register locals stripped
  if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
  v252.Color = v251
  v252 = ensureCallable(v252)
  v252 = v252()
  v253 = ensureCallable(v253)
  v253, v254, v255 = v253(v254)
  if false then -- removed constant-true decompiler loop
    -- removed decompiler goto
    -- removed decompiler label lbl_5
    v258 = ensureCallable(v258)
    v258(v259)
  end
end

if type(v126) ~= "table" and type(v126) ~= "userdata" then v126 = newRecoveredTable() end
if v127 == nil then v127 = "RecoveredKey" end
v126[v127] = v128
v127 = "Min"
v128 = 1
if type(v126) ~= "table" and type(v126) ~= "userdata" then v126 = newRecoveredTable() end
if v127 == nil then v127 = "RecoveredKey" end
v126[v127] = v128
v127 = "Max"
v128 = 10
if type(v126) ~= "table" and type(v126) ~= "userdata" then v126 = newRecoveredTable() end
if v127 == nil then v127 = "RecoveredKey" end
v126[v127] = v128
v127 = "Rounding"
v128 = 1
if type(v126) ~= "table" and type(v126) ~= "userdata" then v126 = newRecoveredTable() end
if v127 == nil then v127 = "RecoveredKey" end
v126[v127] = v128
v127 = "Compact"
if type(v126) ~= "table" and type(v126) ~= "userdata" then v126 = newRecoveredTable() end
if v127 == nil then v127 = "RecoveredKey" end
v126[v127] = v128
v127 = "Callback"

function v128(v251)
  -- synthetic register locals stripped
  v252 = v1012
  if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
  v252 = v252.Visuals
  if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
  v252 = v252.Chams
  v253 = v251 / 10
  if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
  v252.Transparency = v253
  v252 = v1014
  if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
  v252 = v252.GetPlayers
  v252 = ensureCallable(v252)
  v252 = v252()
  v253 = pairs
  v254 = v252
  v253 = ensureCallable(v253)
  v253, v254, v255 = v253(v254)
  if false then -- removed constant-true decompiler loop
    -- removed decompiler goto
    -- removed decompiler label lbl_13
    v258 = ensureCallable(v258)
    v258(v259)
  end
end

if type(v126) ~= "table" and type(v126) ~= "userdata" then v126 = newRecoveredTable() end
v126.Text = "Enabled"

function v128(v251)
  -- synthetic register locals stripped
  v252 = v1012
  if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
  v252 = v252.Visuals
  if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
  v252 = v252.Client
  if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
  v252 = v252.Bullet
  if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
  v252.Enabled = v251
end

if type(v126) ~= "table" and type(v126) ~= "userdata" then v126 = newRecoveredTable() end
if v127 == nil then v127 = "RecoveredKey" end
v126[v127] = v128
v123 = ensureCallable(v123)
v123 = v123(v124, v125, v126, v127)
v125 = "AddColorPicker"
v124 = v123
if type(v123) ~= "table" and type(v123) ~= "userdata" then v123 = newRecoveredTable() end
v123 = v123[v125]
v125 = "BulletColor"
v126 = {}
v127 = "Default"
v128 = Color3
if type(v128) ~= "table" and type(v128) ~= "userdata" then v128 = newRecoveredTable() end
v128 = v128.new
v129 = 0
v130 = 0
v131 = 1
v128 = ensureCallable(v128)
v128 = v128(v129, v130, v131, v132)
if type(v126) ~= "table" and type(v126) ~= "userdata" then v126 = newRecoveredTable() end
if v127 == nil then v127 = "RecoveredKey" end
v126[v127] = v128
v127 = "Title"
v128 = "Bullet Color"
if type(v126) ~= "table" and type(v126) ~= "userdata" then v126 = newRecoveredTable() end
if v127 == nil then v127 = "RecoveredKey" end
v126[v127] = v128
v127 = 0
if type(v126) ~= "table" and type(v126) ~= "userdata" then v126 = newRecoveredTable() end
v126.Transparency = v127
v127 = "Callback"

function v128(v251)
  -- synthetic register locals stripped
  v252 = v1012
  if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
  v252 = v252.Visuals
  if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
  v252 = v252.Client
  if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
  v252 = v252.Bullet
  if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
  v252.Color = v251
end

if type(v126) ~= "table" and type(v126) ~= "userdata" then v126 = newRecoveredTable() end
if v127 == nil then v127 = "RecoveredKey" end
v126[v127] = v128
v123 = ensureCallable(v123)
v123(v124, v125, v126)
v125 = "AddDropdown"
v124 = v85
if type(v85) ~= "table" and type(v85) ~= "userdata" then v85 = newRecoveredTable() end
v123 = v85[v125]
v125 = "MyDropdown"
v126 = {}
v127 = "Values"
v128 = {}
v129 = "2d"
v130 = "3d"
if type(v128) ~= "table" and type(v128) ~= "userdata" then v128 = newRecoveredTable() end
v128[1] = v129
if type(v128) ~= "table" and type(v128) ~= "userdata" then v128 = newRecoveredTable() end
v128[2] = v130
if type(v126) ~= "table" and type(v126) ~= "userdata" then v126 = newRecoveredTable() end
if v127 == nil then v127 = "RecoveredKey" end
v126[v127] = v128
v127 = "Default"
v128 = 1
if type(v126) ~= "table" and type(v126) ~= "userdata" then v126 = newRecoveredTable() end
if v127 == nil then v127 = "RecoveredKey" end
v126[v127] = v128
v127 = "Multi"
if type(v126) ~= "table" and type(v126) ~= "userdata" then v126 = newRecoveredTable() end
if v127 == nil then v127 = "RecoveredKey" end
v126[v127] = v128
v127 = "Bullet type"
if type(v126) ~= "table" and type(v126) ~= "userdata" then v126 = newRecoveredTable() end
v126.Text = v127
v127 = "Tooltip"
v128 = "The bullet tracer type: (3d: physical, 2d: drawing library)"
if type(v126) ~= "table" and type(v126) ~= "userdata" then v126 = newRecoveredTable() end
if v127 == nil then v127 = "RecoveredKey" end
v126[v127] = v128
v127 = "Callback"

function v128(v251)
  -- synthetic register locals stripped
  v252 = v1012
  if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
  v252 = v252.Visuals
  if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
  v252 = v252.Client
  if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
  v252 = v252.Bullet
  if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
  v252.Type = v251
end

v127 = "Min"
v128 = 0
if type(v126) ~= "table" and type(v126) ~= "userdata" then v126 = newRecoveredTable() end
if v127 == nil then v127 = "RecoveredKey" end
v126[v127] = v128
v127 = "Max"
v128 = 10
if type(v126) ~= "table" and type(v126) ~= "userdata" then v126 = newRecoveredTable() end
if v127 == nil then v127 = "RecoveredKey" end
v126[v127] = v128
v127 = "Rounding"
v128 = 1
if type(v126) ~= "table" and type(v126) ~= "userdata" then v126 = newRecoveredTable() end
if v127 == nil then v127 = "RecoveredKey" end
v126[v127] = v128
v127 = "Compact"
if type(v126) ~= "table" and type(v126) ~= "userdata" then v126 = newRecoveredTable() end
if v127 == nil then v127 = "RecoveredKey" end
v126[v127] = v128
v127 = "Callback"

function v128(v251)
  -- synthetic register locals stripped
  v252 = v1012
  if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
  v252 = v252.Visuals
  if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
  v252 = v252.Client
  if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
  v252 = v252.Bullet
  if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
  v252.Lifetime = v251
end

v127 = "Min"
v128 = 0
if type(v126) ~= "table" and type(v126) ~= "userdata" then v126 = newRecoveredTable() end
if v127 == nil then v127 = "RecoveredKey" end
v126[v127] = v128
v127 = "Max"
v128 = 1
if type(v126) ~= "table" and type(v126) ~= "userdata" then v126 = newRecoveredTable() end
if v127 == nil then v127 = "RecoveredKey" end
v126[v127] = v128
v127 = "Rounding"
v128 = 1
if type(v126) ~= "table" and type(v126) ~= "userdata" then v126 = newRecoveredTable() end
if v127 == nil then v127 = "RecoveredKey" end
v126[v127] = v128
v127 = "Compact"
if type(v126) ~= "table" and type(v126) ~= "userdata" then v126 = newRecoveredTable() end
if v127 == nil then v127 = "RecoveredKey" end
v126[v127] = v128
v127 = "Callback"

function v128(v251)
  -- synthetic register locals stripped
  v252 = v1012
  if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
  v252 = v252.Visuals
  if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
  v252 = v252.Client
  if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
  v252 = v252.Bullet
  if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
  v252.Transparency = v251
end

if type(v126) ~= "table" and type(v126) ~= "userdata" then v126 = newRecoveredTable() end
if v127 == nil then v127 = "RecoveredKey" end
v126[v127] = v128
v123 = ensureCallable(v123)
v123(v124, v125, v126)
v125 = "AddToggle"
v124 = v84
if type(v84) ~= "table" and type(v84) ~= "userdata" then v84 = newRecoveredTable() end
v123 = v84[v125]
v125 = "TracerEnabled"
v126 = {}
if type(v126) ~= "table" and type(v126) ~= "userdata" then v126 = newRecoveredTable() end
v126.Text = "Enabled"
v127 = "Default"
v128 = false
if type(v126) ~= "table" and type(v126) ~= "userdata" then v126 = newRecoveredTable() end
if v127 == nil then v127 = "RecoveredKey" end
v126[v127] = v128
v127 = "Tooltip"
v128 = "Enables tracer"
if type(v126) ~= "table" and type(v126) ~= "userdata" then v126 = newRecoveredTable() end
if v127 == nil then v127 = "RecoveredKey" end
v126[v127] = v128
v127 = "Callback"

function v128(v251)
  -- synthetic register locals stripped
  v252 = v1012
  if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
  v252 = v252.Visuals
  if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
  v252 = v252.Line
  if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
  v252.Enabled = v251
end

if type(v126) ~= "table" and type(v126) ~= "userdata" then v126 = newRecoveredTable() end
if v127 == nil then v127 = "RecoveredKey" end
v126[v127] = v128
v123 = ensureCallable(v123)
v123 = v123(v124, v125, v126, v127)
v125 = "AddColorPicker"
v124 = v123
if type(v123) ~= "table" and type(v123) ~= "userdata" then v123 = newRecoveredTable() end
v123 = v123[v125]
v125 = "Tracer color"
v126 = {}
v127 = "Default"
v128 = Color3
if type(v128) ~= "table" and type(v128) ~= "userdata" then v128 = newRecoveredTable() end
v128 = v128.new
v129 = 1
v130 = 1
v131 = 1
v128 = ensureCallable(v128)
v128 = v128(v129, v130, v131, v132)
if type(v126) ~= "table" and type(v126) ~= "userdata" then v126 = newRecoveredTable() end
if v127 == nil then v127 = "RecoveredKey" end
v126[v127] = v128
v127 = "Title"
v128 = "Line color"
if type(v126) ~= "table" and type(v126) ~= "userdata" then v126 = newRecoveredTable() end
if v127 == nil then v127 = "RecoveredKey" end
v126[v127] = v128
v127 = 0
if type(v126) ~= "table" and type(v126) ~= "userdata" then v126 = newRecoveredTable() end
v126.Transparency = v127
v127 = "Callback"

function v128(v251)
  -- synthetic register locals stripped
  v252 = v1012
  if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
  v252 = v252.Visuals
  if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
  v252 = v252.Line
  if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
  v252.Color = v251
end

if type(v126) ~= "table" and type(v126) ~= "userdata" then v126 = newRecoveredTable() end
if v127 == nil then v127 = "RecoveredKey" end
v126[v127] = v128
v123 = ensureCallable(v123)
v123(v124, v125, v126)
v125 = "AddDropdown"
v124 = v84
if type(v84) ~= "table" and type(v84) ~= "userdata" then v84 = newRecoveredTable() end
v123 = v84[v125]
v125 = "TracerOption"
v126 = {}
v127 = "Values"
v128 = {}
v129 = "Top"
v130 = "Mouse"
v131 = "Bottom"
if type(v128) ~= "table" and type(v128) ~= "userdata" then v128 = newRecoveredTable() end
v128[1] = v129
if type(v128) ~= "table" and type(v128) ~= "userdata" then v128 = newRecoveredTable() end
v128[2] = v130
if type(v128) ~= "table" and type(v128) ~= "userdata" then v128 = newRecoveredTable() end
v128[3] = v131
if type(v126) ~= "table" and type(v126) ~= "userdata" then v126 = newRecoveredTable() end
if v127 == nil then v127 = "RecoveredKey" end
v126[v127] = v128
v127 = "Default"
v128 = 1
if type(v126) ~= "table" and type(v126) ~= "userdata" then v126 = newRecoveredTable() end
if v127 == nil then v127 = "RecoveredKey" end
v126[v127] = v128
v127 = "Multi"
if type(v126) ~= "table" and type(v126) ~= "userdata" then v126 = newRecoveredTable() end
if v127 == nil then v127 = "RecoveredKey" end
v126[v127] = v128
v127 = "Tracer offset"
if type(v126) ~= "table" and type(v126) ~= "userdata" then v126 = newRecoveredTable() end
v126.Text = v127
v127 = "Tooltip"
v128 = "Selects an offset"
if type(v126) ~= "table" and type(v126) ~= "userdata" then v126 = newRecoveredTable() end
if v127 == nil then v127 = "RecoveredKey" end
v126[v127] = v128
v127 = "Callback"

function v128(v251)
  -- synthetic register locals stripped
  v252 = v1012
  if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
  v252 = v252.Visuals
  if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
  v252 = v252.Line
  if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
  v252.StartFrom = v251
end

v127 = "Min"
v128 = 1
if type(v126) ~= "table" and type(v126) ~= "userdata" then v126 = newRecoveredTable() end
if v127 == nil then v127 = "RecoveredKey" end
v126[v127] = v128
v127 = "Max"
v128 = 10
if type(v126) ~= "table" and type(v126) ~= "userdata" then v126 = newRecoveredTable() end
if v127 == nil then v127 = "RecoveredKey" end
v126[v127] = v128
v127 = "Rounding"
v128 = 1
if type(v126) ~= "table" and type(v126) ~= "userdata" then v126 = newRecoveredTable() end
if v127 == nil then v127 = "RecoveredKey" end
v126[v127] = v128
v127 = "Compact"
if type(v126) ~= "table" and type(v126) ~= "userdata" then v126 = newRecoveredTable() end
if v127 == nil then v127 = "RecoveredKey" end
v126[v127] = v128
v127 = "Callback"

function v128(v251)
  -- synthetic register locals stripped
  v252 = v1012
  if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
  v252 = v252.Visuals
  if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
  v252 = v252.Line
  v253 = v251 / 10
  if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
  v252.Transparency = v253
end

v127 = "Min"
v128 = 1
if type(v126) ~= "table" and type(v126) ~= "userdata" then v126 = newRecoveredTable() end
if v127 == nil then v127 = "RecoveredKey" end
v126[v127] = v128
v127 = "Max"
v128 = 5
if type(v126) ~= "table" and type(v126) ~= "userdata" then v126 = newRecoveredTable() end
if v127 == nil then v127 = "RecoveredKey" end
v126[v127] = v128
v127 = "Rounding"
v128 = 1
if type(v126) ~= "table" and type(v126) ~= "userdata" then v126 = newRecoveredTable() end
if v127 == nil then v127 = "RecoveredKey" end
v126[v127] = v128
v127 = "Compact"
if type(v126) ~= "table" and type(v126) ~= "userdata" then v126 = newRecoveredTable() end
if v127 == nil then v127 = "RecoveredKey" end
v126[v127] = v128
v127 = "Callback"

function v128(v251)
  -- synthetic register locals stripped
  v252 = v1012
  if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
  v252 = v252.Visuals
  if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
  v252 = v252.Line
  if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
  v252.Thickness = v251
end

if type(v126) ~= "table" and type(v126) ~= "userdata" then v126 = newRecoveredTable() end
v126.Text = "Enabled"

function v128(v251)
  -- synthetic register locals stripped
  v252 = v1012
  if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
  v252 = v252.Visuals
  if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
  v252 = v252.World
  if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
  v252 = v252.Ambient
  if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
  v252.Enabled = v251
end

v127 = "Default"
v129 = 1
v130 = 1
v131 = 1
v128 = ensureCallable(v128)
v128 = v128(v129, v130, v131, v132)
if type(v126) ~= "table" and type(v126) ~= "userdata" then v126 = newRecoveredTable() end
if v127 == nil then v127 = "RecoveredKey" end
v126[v127] = v128
v127 = "Title"
v128 = "Ambient color"
if type(v126) ~= "table" and type(v126) ~= "userdata" then v126 = newRecoveredTable() end
if v127 == nil then v127 = "RecoveredKey" end
v126[v127] = v128
v127 = 0
if type(v126) ~= "table" and type(v126) ~= "userdata" then v126 = newRecoveredTable() end
v126.Transparency = v127
v127 = "Callback"

function v128(v251)
  -- synthetic register locals stripped
  v252 = v1012
  if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
  v252 = v252.Visuals
  if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
  v252 = v252.World
  if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
  v252 = v252.Ambient
  if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
  v252.Color = v251
end

if type(v126) ~= "table" and type(v126) ~= "userdata" then v126 = newRecoveredTable() end
v126.Text = "Enabled"

function v128(v251)
  -- synthetic register locals stripped
  v252 = v1012
  if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
  v252 = v252.Visuals
  if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
  v252 = v252.World
  if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
  v252 = v252.OutdoorAmbient
  if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
  v252.Enabled = v251
end

if type(v126) ~= "table" and type(v126) ~= "userdata" then v126 = newRecoveredTable() end
if v127 == nil then v127 = "RecoveredKey" end
v126[v127] = v128
v123 = ensureCallable(v123)
v123 = v123(v124, v125, v126, v127)
v125 = "AddColorPicker"
v124 = v123
if type(v123) ~= "table" and type(v123) ~= "userdata" then v123 = newRecoveredTable() end
v123 = v123[v125]
v125 = "OutdoorAmbientColor"
v126 = {}
v127 = "Default"
v128 = Color3
if type(v128) ~= "table" and type(v128) ~= "userdata" then v128 = newRecoveredTable() end
v128 = v128.new
v129 = 1
v130 = 1
v131 = 1
v128 = ensureCallable(v128)
v128 = v128(v129, v130, v131, v132)
if type(v126) ~= "table" and type(v126) ~= "userdata" then v126 = newRecoveredTable() end
if v127 == nil then v127 = "RecoveredKey" end
v126[v127] = v128
v127 = "Title"
v128 = "Outdoor ambient color"
if type(v126) ~= "table" and type(v126) ~= "userdata" then v126 = newRecoveredTable() end
if v127 == nil then v127 = "RecoveredKey" end
v126[v127] = v128
v127 = 0
if type(v126) ~= "table" and type(v126) ~= "userdata" then v126 = newRecoveredTable() end
v126.Transparency = v127
v127 = "Callback"

function v128(v251)
  -- synthetic register locals stripped
  v252 = v1012
  if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
  v252 = v252.Visuals
  if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
  v252 = v252.World
  if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
  v252 = v252.OutdoorAmbient
  if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
  v252.Color = v251
end

if type(v126) ~= "table" and type(v126) ~= "userdata" then v126 = newRecoveredTable() end
v126.Text = "Enabled"

function v128(v251)
  -- synthetic register locals stripped
  v252 = v1012
  if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
  v252 = v252.Visuals
  if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
  v252 = v252.World
  if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
  v252 = v252.ColorShift_Top
  if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
  v252.Enabled = v251
end

if type(v126) ~= "table" and type(v126) ~= "userdata" then v126 = newRecoveredTable() end
if v127 == nil then v127 = "RecoveredKey" end
v126[v127] = v128
v123 = ensureCallable(v123)
v123 = v123(v124, v125, v126, v127)
v125 = "AddColorPicker"
v124 = v123
if type(v123) ~= "table" and type(v123) ~= "userdata" then v123 = newRecoveredTable() end
v123 = v123[v125]
v125 = "ColorshiftTopColor"
v126 = {}
v127 = "Default"
v128 = Color3
if type(v128) ~= "table" and type(v128) ~= "userdata" then v128 = newRecoveredTable() end
v128 = v128.new
v129 = 1
v130 = 1
v131 = 1
v128 = ensureCallable(v128)
v128 = v128(v129, v130, v131, v132)
if type(v126) ~= "table" and type(v126) ~= "userdata" then v126 = newRecoveredTable() end
if v127 == nil then v127 = "RecoveredKey" end
v126[v127] = v128
v127 = "Title"
v128 = "Colorshift top color"
if type(v126) ~= "table" and type(v126) ~= "userdata" then v126 = newRecoveredTable() end
if v127 == nil then v127 = "RecoveredKey" end
v126[v127] = v128
v127 = 0
if type(v126) ~= "table" and type(v126) ~= "userdata" then v126 = newRecoveredTable() end
v126.Transparency = v127
v127 = "Callback"

function v128(v251)
  -- synthetic register locals stripped
  v252 = v1012
  if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
  v252 = v252.Visuals
  if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
  v252 = v252.World
  if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
  v252 = v252.ColorShift_Top
  if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
  v252.Color = v251
end

if type(v126) ~= "table" and type(v126) ~= "userdata" then v126 = newRecoveredTable() end
v126.Text = "Enabled"

function v128(v251)
  -- synthetic register locals stripped
  v252 = v1012
  if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
  v252 = v252.Visuals
  if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
  v252 = v252.World
  if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
  v252 = v252.ColorShift_Bottom
  if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
  v252.Enabled = v251
end

if type(v126) ~= "table" and type(v126) ~= "userdata" then v126 = newRecoveredTable() end
if v127 == nil then v127 = "RecoveredKey" end
v126[v127] = v128
v123 = ensureCallable(v123)
v123 = v123(v124, v125, v126, v127)
v125 = "AddColorPicker"
v124 = v123
if type(v123) ~= "table" and type(v123) ~= "userdata" then v123 = newRecoveredTable() end
v123 = v123[v125]
v125 = "ColorshiftBotColor"
v126 = {}
v127 = "Default"
v128 = Color3
if type(v128) ~= "table" and type(v128) ~= "userdata" then v128 = newRecoveredTable() end
v128 = v128.new
v129 = 1
v130 = 1
v131 = 1
v128 = ensureCallable(v128)
v128 = v128(v129, v130, v131, v132)
if type(v126) ~= "table" and type(v126) ~= "userdata" then v126 = newRecoveredTable() end
if v127 == nil then v127 = "RecoveredKey" end
v126[v127] = v128
v127 = "Title"
v128 = "Colorshift bottom color"
if type(v126) ~= "table" and type(v126) ~= "userdata" then v126 = newRecoveredTable() end
if v127 == nil then v127 = "RecoveredKey" end
v126[v127] = v128
v127 = 0
if type(v126) ~= "table" and type(v126) ~= "userdata" then v126 = newRecoveredTable() end
v126.Transparency = v127
v127 = "Callback"

function v128(v251)
  -- synthetic register locals stripped
  v252 = v1012
  if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
  v252 = v252.Visuals
  if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
  v252 = v252.World
  if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
  v252 = v252.ColorShift_Bottom
  if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
  v252.Color = v251
end

if type(v126) ~= "table" and type(v126) ~= "userdata" then v126 = newRecoveredTable() end
v126.Text = "Enabled"

function v128(v251)
  -- synthetic register locals stripped
  v252 = v1012
  if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
  v252 = v252.Visuals
  if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
  v252 = v252.Client
  if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
  v252 = v252.FieldOfView
  if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
  v252.Enabled = v251
end

v127 = "Min"
v128 = 0
if type(v126) ~= "table" and type(v126) ~= "userdata" then v126 = newRecoveredTable() end
if v127 == nil then v127 = "RecoveredKey" end
v126[v127] = v128
v127 = "Max"
v128 = 120
if type(v126) ~= "table" and type(v126) ~= "userdata" then v126 = newRecoveredTable() end
if v127 == nil then v127 = "RecoveredKey" end
v126[v127] = v128
v127 = "Rounding"
v128 = 1
if type(v126) ~= "table" and type(v126) ~= "userdata" then v126 = newRecoveredTable() end
if v127 == nil then v127 = "RecoveredKey" end
v126[v127] = v128
v127 = "Compact"
if type(v126) ~= "table" and type(v126) ~= "userdata" then v126 = newRecoveredTable() end
if v127 == nil then v127 = "RecoveredKey" end
v126[v127] = v128
v127 = "Callback"

function v128(v251)
  -- synthetic register locals stripped
  v252 = v1012
  if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
  v252 = v252.Visuals
  if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
  v252 = v252.Client
  if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
  v252 = v252.FieldOfView
  if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
  v252.Value = v251
end

if type(v126) ~= "table" and type(v126) ~= "userdata" then v126 = newRecoveredTable() end
v126.Text = "Enabled"

function v128(v251)
  -- synthetic register locals stripped
  v252 = v1012
  if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
  v252 = v252.Visuals
  if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
  v252 = v252.Viewmodel
  if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
  v252.Enabled = v251
end

if type(v126) ~= "table" and type(v126) ~= "userdata" then v126 = newRecoveredTable() end
if v127 == nil then v127 = "RecoveredKey" end
v126[v127] = v128
v123 = ensureCallable(v123)
v123 = v123(v124, v125, v126, v127)
v125 = "AddColorPicker"
v124 = v123
if type(v123) ~= "table" and type(v123) ~= "userdata" then v123 = newRecoveredTable() end
v123 = v123[v125]
v125 = "Viewmodel color"
v126 = {}
v127 = "Default"
v128 = Color3
if type(v128) ~= "table" and type(v128) ~= "userdata" then v128 = newRecoveredTable() end
v128 = v128.new
v129 = 0
v130 = 0
v131 = 1
v128 = ensureCallable(v128)
v128 = v128(v129, v130, v131, v132)
if type(v126) ~= "table" and type(v126) ~= "userdata" then v126 = newRecoveredTable() end
if v127 == nil then v127 = "RecoveredKey" end
v126[v127] = v128
v127 = "Title"
v128 = "Arm color"
if type(v126) ~= "table" and type(v126) ~= "userdata" then v126 = newRecoveredTable() end
if v127 == nil then v127 = "RecoveredKey" end
v126[v127] = v128
v127 = 0
if type(v126) ~= "table" and type(v126) ~= "userdata" then v126 = newRecoveredTable() end
v126.Transparency = v127
v127 = "Callback"

function v128(v251)
  -- synthetic register locals stripped
  v252 = v1012
  if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
  v252 = v252.Visuals
  if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
  v252 = v252.Viewmodel
  if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
  v252.Color = v251
end

if type(v126) ~= "table" and type(v126) ~= "userdata" then v126 = newRecoveredTable() end
v126.Text = "Enabled"

function v128(v251)
  -- synthetic register locals stripped
  v252 = v1012
  if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
  v252 = v252.Visuals
  if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
  v252 = v252.Viewmodel
  if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
  v252.SizeEnabled = v251
end

if type(v126) ~= "table" and type(v126) ~= "userdata" then v126 = newRecoveredTable() end
if v127 == nil then v127 = "RecoveredKey" end
v126[v127] = v128
v127 = "Min"
v128 = 0
if type(v126) ~= "table" and type(v126) ~= "userdata" then v126 = newRecoveredTable() end
if v127 == nil then v127 = "RecoveredKey" end
v126[v127] = v128
v127 = "Max"
v128 = 100
if type(v126) ~= "table" and type(v126) ~= "userdata" then v126 = newRecoveredTable() end
if v127 == nil then v127 = "RecoveredKey" end
v126[v127] = v128
v127 = "Rounding"
v128 = 1
if type(v126) ~= "table" and type(v126) ~= "userdata" then v126 = newRecoveredTable() end
if v127 == nil then v127 = "RecoveredKey" end
v126[v127] = v128
v127 = "Compact"
if type(v126) ~= "table" and type(v126) ~= "userdata" then v126 = newRecoveredTable() end
if v127 == nil then v127 = "RecoveredKey" end
v126[v127] = v128
v127 = "Callback"

function v128(v251)
  -- synthetic register locals stripped
  v252 = v1012
  if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
  v252 = v252.Visuals
  if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
  v252 = v252.Viewmodel
  v253 = v251 / 100
  if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
  v252.Size = v253
end

if type(v126) ~= "table" and type(v126) ~= "userdata" then v126 = newRecoveredTable() end
if v127 == nil then v127 = "RecoveredKey" end
v126[v127] = v128
v123 = ensureCallable(v123)
v123(v124, v125, v126)
v125 = "AddDropdown"
v124 = v88
if type(v88) ~= "table" and type(v88) ~= "userdata" then v88 = newRecoveredTable() end
v123 = v88[v125]
v125 = "ViewmodelMaterial"
v126 = {}
v127 = "Values"
v128 = {}
v129 = "ForceField"
v130 = "Plastic"
v131 = "Glass"
v132 = "Neon"
if type(v128) ~= "table" and type(v128) ~= "userdata" then v128 = newRecoveredTable() end
v128[1] = v129
if type(v128) ~= "table" and type(v128) ~= "userdata" then v128 = newRecoveredTable() end
v128[2] = v130
if type(v128) ~= "table" and type(v128) ~= "userdata" then v128 = newRecoveredTable() end
v128[3] = v131
if type(v128) ~= "table" and type(v128) ~= "userdata" then v128 = newRecoveredTable() end
v128[4] = v132
if type(v126) ~= "table" and type(v126) ~= "userdata" then v126 = newRecoveredTable() end
if v127 == nil then v127 = "RecoveredKey" end
v126[v127] = v128
v127 = "Default"
v128 = 1
if type(v126) ~= "table" and type(v126) ~= "userdata" then v126 = newRecoveredTable() end
if v127 == nil then v127 = "RecoveredKey" end
v126[v127] = v128
v127 = "Multi"
if type(v126) ~= "table" and type(v126) ~= "userdata" then v126 = newRecoveredTable() end
if v127 == nil then v127 = "RecoveredKey" end
v126[v127] = v128
v127 = "Arm Material"
if type(v126) ~= "table" and type(v126) ~= "userdata" then v126 = newRecoveredTable() end
v126.Text = v127
v127 = "Tooltip"
v128 = "Viewmodel material type"
if type(v126) ~= "table" and type(v126) ~= "userdata" then v126 = newRecoveredTable() end
if v127 == nil then v127 = "RecoveredKey" end
v126[v127] = v128
v127 = "Callback"

function v128(v251)
  -- synthetic register locals stripped
end

if type(v126) ~= "table" and type(v126) ~= "userdata" then v126 = newRecoveredTable() end
if v127 == nil then v127 = "RecoveredKey" end
v126[v127] = v128
v127 = "Min"
v128 = 1
if type(v126) ~= "table" and type(v126) ~= "userdata" then v126 = newRecoveredTable() end
if v127 == nil then v127 = "RecoveredKey" end
v126[v127] = v128
v127 = "Max"
v128 = 10
if type(v126) ~= "table" and type(v126) ~= "userdata" then v126 = newRecoveredTable() end
if v127 == nil then v127 = "RecoveredKey" end
v126[v127] = v128
v127 = "Rounding"
v128 = 1
if type(v126) ~= "table" and type(v126) ~= "userdata" then v126 = newRecoveredTable() end
if v127 == nil then v127 = "RecoveredKey" end
v126[v127] = v128
v127 = "Compact"
if type(v126) ~= "table" and type(v126) ~= "userdata" then v126 = newRecoveredTable() end
if v127 == nil then v127 = "RecoveredKey" end
v126[v127] = v128
v127 = "Callback"

function v128(v251)
  -- synthetic register locals stripped
  v252 = v1012
  if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
  v252 = v252.Visuals
  if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
  v252 = v252.Viewmodel
  v253 = v251 / 10
  if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
  v252.Transparency = v253
end

if type(v126) ~= "table" and type(v126) ~= "userdata" then v126 = newRecoveredTable() end
v126.Text = "Enabled"

function v128(v251)
  -- synthetic register locals stripped
  v252 = v1012
  if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
  v252 = v252.Visuals
  if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
  v252 = v252.Viewmodel
  if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
  v252 = v252.Tools
  if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
  v252.Enabled = v251
end

if type(v126) ~= "table" and type(v126) ~= "userdata" then v126 = newRecoveredTable() end
if v127 == nil then v127 = "RecoveredKey" end
v126[v127] = v128
v123 = ensureCallable(v123)
v123 = v123(v124, v125, v126, v127)
v125 = "AddColorPicker"
v124 = v123
if type(v123) ~= "table" and type(v123) ~= "userdata" then v123 = newRecoveredTable() end
v123 = v123[v125]
v125 = "Viewmodel colorr"
v126 = {}
v127 = "Default"
v128 = Color3
if type(v128) ~= "table" and type(v128) ~= "userdata" then v128 = newRecoveredTable() end
v128 = v128.new
v129 = 0
v130 = 0
v131 = 1
v128 = ensureCallable(v128)
v128 = v128(v129, v130, v131, v132)
if type(v126) ~= "table" and type(v126) ~= "userdata" then v126 = newRecoveredTable() end
if v127 == nil then v127 = "RecoveredKey" end
v126[v127] = v128
v127 = "Title"
v128 = "Tool color"
if type(v126) ~= "table" and type(v126) ~= "userdata" then v126 = newRecoveredTable() end
if v127 == nil then v127 = "RecoveredKey" end
v126[v127] = v128
v127 = 0
if type(v126) ~= "table" and type(v126) ~= "userdata" then v126 = newRecoveredTable() end
v126.Transparency = v127
v127 = "Callback"

function v128(v251)
  -- synthetic register locals stripped
  v252 = v1012
  if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
  v252 = v252.Visuals
  if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
  v252 = v252.Viewmodel
  if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
  v252 = v252.Tools
  if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
  v252.Color = v251
end

if type(v126) ~= "table" and type(v126) ~= "userdata" then v126 = newRecoveredTable() end
if v127 == nil then v127 = "RecoveredKey" end
v126[v127] = v128
v123 = ensureCallable(v123)
v123(v124, v125, v126)
v125 = "AddDropdown"
v124 = v88
if type(v88) ~= "table" and type(v88) ~= "userdata" then v88 = newRecoveredTable() end
v123 = v88[v125]
v125 = "ViewmodelMateriall"
v126 = {}
v127 = "Values"
v128 = {}
v129 = "ForceField"
v130 = "Plastic"
v131 = "Glass"
v132 = "Neon"
if type(v128) ~= "table" and type(v128) ~= "userdata" then v128 = newRecoveredTable() end
v128[1] = v129
if type(v128) ~= "table" and type(v128) ~= "userdata" then v128 = newRecoveredTable() end
v128[2] = v130
if type(v128) ~= "table" and type(v128) ~= "userdata" then v128 = newRecoveredTable() end
v128[3] = v131
if type(v128) ~= "table" and type(v128) ~= "userdata" then v128 = newRecoveredTable() end
v128[4] = v132
if type(v126) ~= "table" and type(v126) ~= "userdata" then v126 = newRecoveredTable() end
if v127 == nil then v127 = "RecoveredKey" end
v126[v127] = v128
v127 = "Default"
v128 = 4
if type(v126) ~= "table" and type(v126) ~= "userdata" then v126 = newRecoveredTable() end
if v127 == nil then v127 = "RecoveredKey" end
v126[v127] = v128
v127 = "Multi"
if type(v126) ~= "table" and type(v126) ~= "userdata" then v126 = newRecoveredTable() end
if v127 == nil then v127 = "RecoveredKey" end
v126[v127] = v128
v127 = "Arm Material"
if type(v126) ~= "table" and type(v126) ~= "userdata" then v126 = newRecoveredTable() end
v126.Text = v127
v127 = "Tooltip"
v128 = "Viewmodel material type"
if type(v126) ~= "table" and type(v126) ~= "userdata" then v126 = newRecoveredTable() end
if v127 == nil then v127 = "RecoveredKey" end
v126[v127] = v128
v127 = "Callback"

function v128(v251)
  -- synthetic register locals stripped
  v252 = v1012
  if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
  v252 = v252.Visuals
  if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
  v252 = v252.Viewmodel
  if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
  v252 = v252.Tools
  v253 = Enum
  if type(v253) ~= "table" and type(v253) ~= "userdata" then v253 = newRecoveredTable() end
  v253 = v253.Material
  if type(v253) ~= "table" and type(v253) ~= "userdata" then v253 = newRecoveredTable() end
  v253 = v253[v251]
  if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
  v252.Material = v253
end

if type(v126) ~= "table" and type(v126) ~= "userdata" then v126 = newRecoveredTable() end
if v127 == nil then v127 = "RecoveredKey" end
v126[v127] = v128
v127 = "Min"
v128 = 1
if type(v126) ~= "table" and type(v126) ~= "userdata" then v126 = newRecoveredTable() end
if v127 == nil then v127 = "RecoveredKey" end
v126[v127] = v128
v127 = "Max"
v128 = 10
if type(v126) ~= "table" and type(v126) ~= "userdata" then v126 = newRecoveredTable() end
if v127 == nil then v127 = "RecoveredKey" end
v126[v127] = v128
v127 = "Rounding"
v128 = 1
if type(v126) ~= "table" and type(v126) ~= "userdata" then v126 = newRecoveredTable() end
if v127 == nil then v127 = "RecoveredKey" end
v126[v127] = v128
v127 = "Compact"
if type(v126) ~= "table" and type(v126) ~= "userdata" then v126 = newRecoveredTable() end
if v127 == nil then v127 = "RecoveredKey" end
v126[v127] = v128
v127 = "Callback"

function v128(v251)
  -- synthetic register locals stripped
  v253 = v251 / 10
  if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
  v252.Transparency = v253
end

if type(v126) ~= "table" and type(v126) ~= "userdata" then v126 = newRecoveredTable() end
if v127 == nil then v127 = "RecoveredKey" end
v126[v127] = v128
v123 = ensureCallable(v123)
v123(v124, v125, v126)
v124 = ensureCallable(v124)
v124 = v124()
v123 = ensureCallable(v123)
v123 = v123(v124)
v124 = 0
v126 = ensureCallable(v126)
v126 = v126()
if v123 then
  v124 = 0
  v127 = ensureCallable(v127)
  v127 = v127()
  v127 = "HealthChanged"
  if type(v123) ~= "table" and type(v123) ~= "userdata" then v123 = newRecoveredTable() end
  v127 = v123[v127]
  v129 = "Connect"
  v128 = v127
  if type(v127) ~= "table" and type(v127) ~= "userdata" then v127 = newRecoveredTable() end
  v127 = v127[v129]
  
  function v129(v251)
    -- synthetic register locals stripped
    if v252 then
    end
    -- removed decompiler goto
    v252 = ensureCallable(v252)
    v252 = v252()
    if not (1.3 < v252) then
    end
    -- removed decompiler goto
    if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
    v252 = v252.log
    v253 = "RESOLVING"
    v254 = "Resolved frozen variable!"
    v255 = "CLIENT"
    v252 = ensureCallable(v252)
    v252(v253, v254, v255)
    v252 = tick
    v252 = ensureCallable(v252)
    v252 = v252()
    v1014 = v252
    v252 = true
    -- removed decompiler label lbl_17
    v1012 = v252
    if not (v251 < v252) then
    end
    -- removed decompiler goto
    v252 = v252 - v251
    v253 = v1015
    if type(v253) ~= "table" and type(v253) ~= "userdata" then v253 = newRecoveredTable() end
    v253 = v253.log
    v254 = "RESOLVING"
    v255 = "Attempting to resolve health: "
    v256 = tostring
    v257 = v252
    v256 = ensureCallable(v256)
    v256 = v256(v257)
    v255 = v255 .. v256
    v256 = "SERVER"
    v253 = ensureCallable(v253)
    v253(v254, v255, v256)
    if not v253 or not v253 then
    end
    -- removed decompiler goto
    if v253 == 0 then
    end
    -- removed decompiler goto
    v1012 = v253
    v253 = {}
    v254 = "Drown Tick"
    v255 = false
    v256 = v1018
    if type(v256) ~= "table" and type(v256) ~= "userdata" then v256 = newRecoveredTable() end
    v256 = v256.MaxHealth
    v257 = v1018
    if type(v257) ~= "table" and type(v257) ~= "userdata" then v257 = newRecoveredTable() end
    v257 = v257.Health
    v256 = v256 - v257
    v256 = -v256
    v256 = v256 / 5
    v257 = nil
    if type(v253) ~= "table" and type(v253) ~= "userdata" then v253 = newRecoveredTable() end
    v253[1] = v254
    if type(v253) ~= "table" and type(v253) ~= "userdata" then v253 = newRecoveredTable() end
    v253[2] = v255
    if type(v253) ~= "table" and type(v253) ~= "userdata" then v253 = newRecoveredTable() end
    v253[3] = v256
    if type(v253) ~= "table" and type(v253) ~= "userdata" then v253 = newRecoveredTable() end
    v253[4] = v257
    v255 = v254
    if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
    v254 = v254.GetService
    v256 = "ReplicatedStorage"
    v254 = ensureCallable(v254)
    v254 = v254(v255, v256, v257)
    v255 = v254
    if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
    v254 = v254.WaitForChild
    v256 = "Remotes"
    v254 = ensureCallable(v254)
    v254 = v254(v255, v256, v257)
    v255 = v254
    if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
    v254 = v254.WaitForChild
    v256 = "RemoteEvent"
    v254 = ensureCallable(v254)
    v254 = v254(v255, v256, v257)
    v255 = v254
    if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
    v254 = v254.FireServer
    v256 = unpack
    v257 = v253
  -- synthetic vararg register fan-out stripped
    -- trimmed huge synthetic register fan-out
    v254(v255, v256, v257, v258, v259, v260, v261, v262)
    -- removed decompiler label lbl_67
    -- removed decompiler goto
    if not (v251 > v252) then
    end
    -- removed decompiler goto
    v252 = ensureCallable(v252)
    v252 = v252()
    v1014 = v252
    v252 = true
    v1012 = v252
    v252 = v1015
    if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
    v252 = v252.log
    v253 = "RESOLVED"
    v254 = "Successfully resolved health!"
    v255 = "SERVER"
    -- removed decompiler label lbl_80
    v252 = ensureCallable(v252)
    v252(v253, v254, v255)
  end
end
v127 = ensureCallable(v127)
v127(v128, v129)
v127 = ensureCallable(v127)
v127 = v127()
v128 = "CharacterAdded"
if type(v127) ~= "table" and type(v127) ~= "userdata" then v127 = newRecoveredTable() end
v127 = v127[v128]
v129 = "Connect"
v128 = v127
if type(v127) ~= "table" and type(v127) ~= "userdata" then v127 = newRecoveredTable() end
v127 = v127[v129]

function v129(v251)
  -- synthetic register locals stripped
  v253 = v251
  if type(v251) ~= "table" and type(v251) ~= "userdata" then v251 = newRecoveredTable() end
  v252 = v251.WaitForChild
  v254 = "Humanoid"
  v255 = 20
  v252 = ensureCallable(v252)
  v252 = v252(v253, v254, v255, v256)
  v254 = v251
  if type(v251) ~= "table" and type(v251) ~= "userdata" then v251 = newRecoveredTable() end
  v253 = v251.FindFirstChild
  v255 = "Humanoid"
  v253 = ensureCallable(v253)
  v253 = v253(v254, v255, v256)
  if v253 then
    v253 = 0
    v253 = ensureCallable(v253)
    v253 = v253()
    v254 = v253
    if type(v253) ~= "table" and type(v253) ~= "userdata" then v253 = newRecoveredTable() end
    v253 = v253.Connect
    
    function v255(v503)
      -- synthetic register locals stripped
      if v504 then
      end
      -- removed decompiler goto
      v504 = ensureCallable(v504)
      v504 = v504()
      -- removed decompiler goto
      if type(v504) ~= "table" and type(v504) ~= "userdata" then v504 = newRecoveredTable() end
      v504 = v504.log
      v505 = "RESOLVING"
      v506 = "Resolved frozen variable!"
      v507 = "CLIENT"
      v504 = ensureCallable(v504)
      v504(v505, v506, v507)
      v504 = tick
      v504 = ensureCallable(v504)
      v504 = v504()
      v1014 = v504
      v504 = true
      -- removed decompiler label lbl_15
      v1012 = v504
      if not (v503 < v504) then
      end
      -- removed decompiler goto
      v504 = v504 - v503
      v505 = v1015
      if type(v505) ~= "table" and type(v505) ~= "userdata" then v505 = newRecoveredTable() end
      v505 = v505.log
      v506 = "RESOLVING"
      v507 = "Attempting to resolve health: "
      v508 = tostring
      v509 = v504
      v508 = ensureCallable(v508)
      v508 = v508(v509)
      v507 = v507 .. v508
      v508 = "SERVER"
      v505 = ensureCallable(v505)
      v505(v506, v507, v508)
      v505 = v1017
      if type(v505) ~= "table" and type(v505) ~= "userdata" then v505 = newRecoveredTable() end
      v505 = v505.Godmode
      if type(v505) ~= "table" and type(v505) ~= "userdata" then v505 = newRecoveredTable() end
      v505 = v505.Enabled
      if not v505 then
      end
      -- removed decompiler goto
      if v505 and v505 ~= 0 then
        v507 = v506
        if type(v506) ~= "table" and type(v506) ~= "userdata" then v506 = newRecoveredTable() end
        v506 = v506.GetService
        v508 = "ReplicatedStorage"
        v506 = ensureCallable(v506)
        v506 = v506(v507, v508, v509)
        v507 = v506
        if type(v506) ~= "table" and type(v506) ~= "userdata" then v506 = newRecoveredTable() end
        v506 = v506.WaitForChild
        v508 = "Remotes"
        v506 = ensureCallable(v506)
        v506 = v506(v507, v508, v509)
        v507 = v506
        if type(v506) ~= "table" and type(v506) ~= "userdata" then v506 = newRecoveredTable() end
        v506 = v506.WaitForChild
        v508 = "RemoteEvent"
        v506 = ensureCallable(v506)
        v506 = v506(v507, v508, v509)
        v507 = v506
        if type(v506) ~= "table" and type(v506) ~= "userdata" then v506 = newRecoveredTable() end
        v506 = v506.FireServer
        v508 = unpack
        v509 = v505
  -- synthetic vararg register fan-out stripped
        -- trimmed huge synthetic register fan-out
        v506(v507, v508, v509, v510, v511, v512, v513, v514)
        -- removed decompiler label lbl_54
        -- removed decompiler goto
        if not (v503 >= v504) then
        end
        -- removed decompiler goto
        v504 = ensureCallable(v504)
        v504 = v504()
        v1014 = v504
        v504 = true
        v1012 = v504
        v504 = v1015
        if type(v504) ~= "table" and type(v504) ~= "userdata" then v504 = newRecoveredTable() end
        v504 = v504.log
        v505 = "RESOLVED"
        v506 = "Successfully resolved health!"
        v507 = "SERVER"
      end
      -- removed decompiler label lbl_67
      v504 = ensureCallable(v504)
      v504(v505, v506, v507)
    end
  end
  v253 = ensureCallable(v253)
  v253(v254, v255)
end

v127 = ensureCallable(v127)
v127(v128, v129)
v128 = 0
v129 = 0
v130 = 0
v127 = ensureCallable(v127)
v127 = v127(v128, v129, v130, v131)
v130 = "CamChildAdded"
v131 = "ChildAdded"
if type(v47) ~= "table" and type(v47) ~= "userdata" then v47 = newRecoveredTable() end
v131 = v47[v131]
v133 = "Connect"
v132 = v131
if type(v131) ~= "table" and type(v131) ~= "userdata" then v131 = newRecoveredTable() end
v131 = v131[v133]

function v133(v251)
  -- synthetic register locals stripped
  if v252 == "Model" then
  end
  if v252 ~= "Viewmodel" and v252 then
    v252 = v1012
    v253 = v252
    if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
    v252 = v252.FindFirstChildWhichIsA
    v254 = "MeshPart"
    v252 = ensureCallable(v252)
    v252 = v252(v253, v254, v255)
    if not v252 then
    end
    -- removed decompiler goto
    v253 = v252
    if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
    v252 = v252.FindFirstChildWhichIsA
    v254 = "MeshPart"
    v252 = ensureCallable(v252)
    v252 = v252(v253, v254, v255)
    if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
    v252 = v252.CFrame
  end
  -- removed decompiler label lbl_18
  v1014 = v252
end

v131 = ensureCallable(v131)
v131 = v131(v132, v133, v134)
if type(v129) ~= "table" and type(v129) ~= "userdata" then v129 = newRecoveredTable() end
if v130 == nil then v130 = "RecoveredKey" end
v129[v130] = v131
v129 = nil
v130 = nil
if type(v50) ~= "table" and type(v50) ~= "userdata" then v50 = newRecoveredTable() end
v131 = Utilities.Connections
v132 = "CamDescendantAdded"
v133 = "DescendantAdded"
if type(v47) ~= "table" and type(v47) ~= "userdata" then v47 = newRecoveredTable() end
v133 = v47[v133]
v135 = "Connect"
v134 = v133
if type(v133) ~= "table" and type(v133) ~= "userdata" then v133 = newRecoveredTable() end
v133 = v133[v135]

function v135(v251)
  -- synthetic register locals stripped
  v253 = v251
  if type(v251) ~= "table" and type(v251) ~= "userdata" then v251 = newRecoveredTable() end
  v252 = v251.IsA
  v254 = "Model"
  v252 = ensureCallable(v252)
  v252 = v252(v253, v254, v255)
  if not v252 then
  end
  -- removed decompiler goto
  if v252 ~= "Viewmodel" then
  end
  -- removed decompiler goto
  -- removed decompiler goto
  v253 = v251
  if type(v251) ~= "table" and type(v251) ~= "userdata" then v251 = newRecoveredTable() end
  v252 = v251.ScaleTo
  -- removed decompiler label lbl_12
  v252 = ensureCallable(v252)
  v252(v253, v254)
  v253 = v251
  if type(v251) ~= "table" and type(v251) ~= "userdata" then v251 = newRecoveredTable() end
  v252 = v251.IsDescendantOf
  v252 = ensureCallable(v252)
  v252 = v252(v253, v254, v255)
  if v252 then
    v253 = v251
    if type(v251) ~= "table" and type(v251) ~= "userdata" then v251 = newRecoveredTable() end
    v252 = v251.IsA
    v254 = "Model"
    v252 = ensureCallable(v252)
    v252 = v252(v253, v254, v255)
    if not v252 then
    end
    -- removed decompiler goto
    -- removed decompiler label lbl_23
    v253 = v251
    if type(v251) ~= "table" and type(v251) ~= "userdata" then v251 = newRecoveredTable() end
    v252 = v251.IsA
    v254 = "BasePart"
    v252 = ensureCallable(v252)
    v252 = v252(v253, v254, v255)
    if v252 then
    end
    -- removed decompiler goto
    v253 = v251
    if type(v251) ~= "table" and type(v251) ~= "userdata" then v251 = newRecoveredTable() end
    v252 = v251.IsA
    v254 = "MeshPart"
    v252 = ensureCallable(v252)
    v252 = v252(v253, v254, v255)
    -- removed decompiler label lbl_33
    if not v252 or not v252 then
    end
    -- removed decompiler goto
    if v252 == 1 then
    end
    -- removed decompiler goto
    if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
    v252 = v252.Visuals
    if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
    v252 = v252.Viewmodel
    if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
    v252 = v252.Color
    if type(v251) ~= "table" and type(v251) ~= "userdata" then v251 = newRecoveredTable() end
    v251.Color = v252
    v252 = v1014
    if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
    v252 = v252.Visuals
    if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
    v252 = v252.Viewmodel
    if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
    v252 = v252.Transparency
    if type(v251) ~= "table" and type(v251) ~= "userdata" then v251 = newRecoveredTable() end
    v251.Transparency = v252
    v252 = v1014
    if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
    v252 = v252.Visuals
    if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
    v252 = v252.Viewmodel
    if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
    v252 = v252.Material
  end
  -- removed decompiler label lbl_53
  if type(v251) ~= "table" and type(v251) ~= "userdata" then v251 = newRecoveredTable() end
  v251.Material = v252
  v253 = v251
  if type(v251) ~= "table" and type(v251) ~= "userdata" then v251 = newRecoveredTable() end
  v252 = v251.IsDescendantOf
  v252 = ensureCallable(v252)
  v252 = v252(v253, v254, v255)
  if not v252 then
  end
  -- removed decompiler goto
  if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
  v252 = v252.Visuals
  if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
  v252 = v252.Viewmodel
  if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
  v252 = v252.Tools
  if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
  v252 = v252.Enabled
  if v252 then
    v253 = v251
    if type(v251) ~= "table" and type(v251) ~= "userdata" then v251 = newRecoveredTable() end
    v252 = v251.IsA
    v254 = "MeshPart"
    v252 = ensureCallable(v252)
    v252 = v252(v253, v254, v255)
    if not v252 then
      v253 = v251
      if type(v251) ~= "table" and type(v251) ~= "userdata" then v251 = newRecoveredTable() end
      v252 = v251.IsA
      v254 = "BasePart"
      v252 = ensureCallable(v252)
      v252 = v252(v253, v254, v255)
      if not v252 or v252 == 1 then
        -- removed decompiler goto
      end
    end
    if type(v251) ~= "table" and type(v251) ~= "userdata" then v251 = newRecoveredTable() end
    v251.Color = v252
    if type(v251) ~= "table" and type(v251) ~= "userdata" then v251 = newRecoveredTable() end
    v251.Transparency = v252
    if type(v251) ~= "table" and type(v251) ~= "userdata" then v251 = newRecoveredTable() end
    v251.Material = v252
    -- removed decompiler label lbl_80
    -- removed decompiler goto
    v253 = v251
    if type(v251) ~= "table" and type(v251) ~= "userdata" then v251 = newRecoveredTable() end
    v252 = v251.IsA
    v254 = "SurfaceAppearance"
    v252 = ensureCallable(v252)
    v252 = v252(v253, v254, v255)
    if v252 then
      v253 = v251
      if type(v251) ~= "table" and type(v251) ~= "userdata" then v251 = newRecoveredTable() end
      v252 = v251.Destroy
    end
  end
  -- removed decompiler label lbl_87
  v252 = ensureCallable(v252)
  v252(v253)
end

v133 = ensureCallable(v133)
v133 = v133(v134, v135, v136)
if type(v131) ~= "table" and type(v131) ~= "userdata" then v131 = newRecoveredTable() end
if v132 == nil then v132 = "RecoveredKey" end
v131[v132] = v133
v131 = 60
v132 = 60

function v137(v251, v501)
  -- synthetic register locals stripped
  if v501 then
  end
  do return end
  if v253 and v253 == v254 then
    v254 = v253
    if type(v253) ~= "table" and type(v253) ~= "userdata" then v253 = newRecoveredTable() end
    v253 = v253.FindFirstChild
    v255 = v1015
    if type(v255) ~= "table" and type(v255) ~= "userdata" then v255 = newRecoveredTable() end
    v255 = v255.Name
    v253 = ensureCallable(v253)
    v253 = v253(v254, v255, v256)
    if not v253 then
    end
    -- removed decompiler goto
    v255 = v254
    if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
    v254 = v254.FindFirstChildWhichIsA
    v256 = "MeshPart"
    v254 = ensureCallable(v254)
    v254 = v254(v255, v256, v257)
    if v254 then
      v255 = v254
      if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
      v254 = v254.FindFirstChildWhichIsA
      v256 = "MeshPart"
      v254 = ensureCallable(v254)
      v254 = v254(v255, v256, v257)
      if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
      v254 = v254.CFrame
    end
    v1016 = v254
    v255 = "Place Object"
    v258 = "cf"
    v259 = nil
    if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
    v254[7] = false
    if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
    v254[1] = v255
    if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
    v254[2] = v256
    if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
    v254[3] = v257
    if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
    v254[4] = v258
    if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
    v254[5] = v259
    v256 = v255
    if type(v255) ~= "table" and type(v255) ~= "userdata" then v255 = newRecoveredTable() end
    v255 = v255.GetService
    v257 = "ReplicatedStorage"
    v255 = ensureCallable(v255)
    v255 = v255(v256, v257, v258)
    v256 = v255
    if type(v255) ~= "table" and type(v255) ~= "userdata" then v255 = newRecoveredTable() end
    v255 = v255.WaitForChild
    v257 = "Remotes"
    v255 = ensureCallable(v255)
    v255 = v255(v256, v257, v258)
    v256 = v255
    if type(v255) ~= "table" and type(v255) ~= "userdata" then v255 = newRecoveredTable() end
    v255 = v255.WaitForChild
    v257 = "RemoteFunction"
    v255 = ensureCallable(v255)
    v255 = v255(v256, v257, v258)
    v256 = v255
    if type(v255) ~= "table" and type(v255) ~= "userdata" then v255 = newRecoveredTable() end
    v255 = v255.InvokeServer
    v257 = unpack
    v258 = v254
  -- synthetic vararg register fan-out stripped
  end
  -- removed decompiler label lbl_43
  -- trimmed huge synthetic register fan-out
  v255(v256, v257, v258, v259, v260, v261, v262, v263)
  if v253 == v254 then
  end
  -- removed decompiler goto
  if v253 == v254 then
  end
  -- removed decompiler label lbl_49
end

v135 = ensureCallable(v135)
v135(v136, v137)

function v137(v251)
  -- synthetic register locals stripped
  if v252 == v253 then
  end
  -- removed decompiler goto
  if v252 ~= v253 then
  end
  -- removed decompiler goto
  -- removed decompiler label lbl_7
end

v135 = ensureCallable(v135)
v135(v136, v137)
v136 = "PlayerRemoving"
if type(v135) ~= "table" and type(v135) ~= "userdata" then v135 = newRecoveredTable() end
v135 = v135[v136]
v137 = "Connect"
v136 = v135
if type(v135) ~= "table" and type(v135) ~= "userdata" then v135 = newRecoveredTable() end
v135 = v135[v137]

function v137(v251)
  -- synthetic register locals stripped
  if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
  v252 = v252[v253]
  if not v252 then
  end
  -- removed decompiler goto
  if type(v251) ~= "table" and type(v251) ~= "userdata" then v251 = newRecoveredTable() end
  v253 = v251.Name
  if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
  v252 = v252[v253]
  v253 = v252
  if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
  v252 = v252.Destroy
  v252 = ensureCallable(v252)
  v252(v253)
  v252 = v1012
  if type(v251) ~= "table" and type(v251) ~= "userdata" then v251 = newRecoveredTable() end
  v253 = v251.Name
  -- removed decompiler label lbl_11
  if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
  if v253 == nil then v253 = "RecoveredKey" end
  v252[v253] = nil
  if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
  v252 = v252[v253]
  if not v252 then
  end
  -- removed decompiler goto
  if type(v251) ~= "table" and type(v251) ~= "userdata" then v251 = newRecoveredTable() end
  v253 = v251.Name
  if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
  v252 = v252[v253]
  v253 = v252
  if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
  v252 = v252.Destroy
  v252 = ensureCallable(v252)
  v252(v253)
  v252 = v1014
  if type(v251) ~= "table" and type(v251) ~= "userdata" then v251 = newRecoveredTable() end
  v253 = v251.Name
  -- removed decompiler label lbl_22
  if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
  if v253 == nil then v253 = "RecoveredKey" end
  v252[v253] = nil
end

v135 = ensureCallable(v135)
v135(v136, v137)
v135 = "so tuff"
if type(v64) ~= "table" and type(v64) ~= "userdata" then v64 = newRecoveredTable() end
v64.Name = v135
if type(v64) ~= "table" and type(v64) ~= "userdata" then v64 = newRecoveredTable() end
v64.Parent = v46
v135 = "Visualiziariaroro"
if type(v65) ~= "table" and type(v65) ~= "userdata" then v65 = newRecoveredTable() end
v65.Name = v135
v136 = "PlatformStand"
if type(v135) ~= "table" and type(v135) ~= "userdata" then v135 = newRecoveredTable() end
if v136 == nil then v136 = "RecoveredKey" end
v135[v136] = v137
v136 = "Anchored"
if type(v135) ~= "table" and type(v135) ~= "userdata" then v135 = newRecoveredTable() end
if v136 == nil then v136 = "RecoveredKey" end
v135[v136] = v137
v136 = "Anchored"
if type(v135) ~= "table" and type(v135) ~= "userdata" then v135 = newRecoveredTable() end
if v136 == nil then v136 = "RecoveredKey" end
v135[v136] = v137
v136 = "CanCollide"
if type(v135) ~= "table" and type(v135) ~= "userdata" then v135 = newRecoveredTable() end
if v136 == nil then v136 = "RecoveredKey" end
v135[v136] = v137
v136 = "CFrame"
v138 = 1000000
v139 = 1000000
v140 = 100000
v137 = ensureCallable(v137)
v137 = v137(v138, v139, v140, v141)
if type(v135) ~= "table" and type(v135) ~= "userdata" then v135 = newRecoveredTable() end
if v136 == nil then v136 = "RecoveredKey" end
v135[v136] = v137
v138 = "GetDescendants"
v137 = v47
if type(v47) ~= "table" and type(v47) ~= "userdata" then v47 = newRecoveredTable() end
v136 = v47[v138]
  -- synthetic vararg register fan-out stripped
-- trimmed huge synthetic register fan-out
v135, v136, v137 = v135(v136, v137, v138, v139, v140, v141, v142, v143)
if false then -- removed constant-true decompiler loop
  -- removed decompiler goto
  v142 = "IsA"
  v141 = v139
  if type(v139) ~= "table" and type(v139) ~= "userdata" then v139 = newRecoveredTable() end
  v140 = v139[v142]
  v142 = "BasePart"
  v140 = ensureCallable(v140)
  v140 = v140(v141, v142, v143)
  if v140 then
  end
  -- removed decompiler goto
  v142 = "IsA"
  v141 = v139
  if type(v139) ~= "table" and type(v139) ~= "userdata" then v139 = newRecoveredTable() end
  v140 = v139[v142]
  v142 = "MeshPart"
  v140 = ensureCallable(v140)
  v140 = v140(v141, v142, v143)
  if not v140 then
  end
  -- removed decompiler label lbl_2536
  -- removed decompiler goto
  v140 = "CanQuery"
  -- removed decompiler label lbl_2538
  if type(v139) ~= "table" and type(v139) ~= "userdata" then v139 = newRecoveredTable() end
  if v140 == nil then v140 = "RecoveredKey" end
  v139[v140] = v141
end
v138 = "GetChildren"
v137 = v64
if type(v64) ~= "table" and type(v64) ~= "userdata" then v64 = newRecoveredTable() end
v136 = v64[v138]
  -- synthetic vararg register fan-out stripped
-- trimmed huge synthetic register fan-out
v135, v136, v137 = v135(v136, v137, v138, v139, v140, v141, v142, v143)
if false then -- removed constant-true decompiler loop
  -- removed decompiler goto
  if v140 == "HumanoidRootPart" then
  end
  -- removed decompiler goto
  if v140 == "Humanoid" then
  end
  -- removed decompiler goto
  v142 = "Destroy"
  v141 = v139
  if type(v139) ~= "table" and type(v139) ~= "userdata" then v139 = newRecoveredTable() end
  v140 = v139[v142]
  -- removed decompiler label lbl_2554
  v140 = ensureCallable(v140)
  v140(v141)
end
v138 = "GetChildren"
v137 = v65
if type(v65) ~= "table" and type(v65) ~= "userdata" then v65 = newRecoveredTable() end
v136 = v65[v138]
  -- synthetic vararg register fan-out stripped
-- trimmed huge synthetic register fan-out
v135, v136, v137 = v135(v136, v137, v138, v139, v140, v141, v142, v143)
if false then -- removed constant-true decompiler loop
  -- removed decompiler goto
  v142 = "IsA"
  v141 = v139
  if type(v139) ~= "table" and type(v139) ~= "userdata" then v139 = newRecoveredTable() end
  v140 = v139[v142]
  v142 = "BasePart"
  v140 = ensureCallable(v140)
  v140 = v140(v141, v142, v143)
  if v140 then
  end
  -- removed decompiler goto
  v142 = "IsA"
  v141 = v139
  if type(v139) ~= "table" and type(v139) ~= "userdata" then v139 = newRecoveredTable() end
  v140 = v139[v142]
  v142 = "MeshPart"
  v140 = ensureCallable(v140)
  v140 = v140(v141, v142, v143)
  if v140 then
  end
  -- removed decompiler goto
  v142 = "IsA"
  v141 = v139
  if type(v139) ~= "table" and type(v139) ~= "userdata" then v139 = newRecoveredTable() end
  v140 = v139[v142]
  v142 = "Humanoid"
  v140 = ensureCallable(v140)
  v140 = v140(v141, v142, v143)
  if v140 then
  end
  -- removed decompiler goto
  v142 = "Destroy"
  v141 = v139
  if type(v139) ~= "table" and type(v139) ~= "userdata" then v139 = newRecoveredTable() end
  v140 = v139[v142]
  v140 = ensureCallable(v140)
  v140(v141)
  -- removed decompiler label lbl_2586
  -- removed decompiler goto
  v142 = "IsA"
  v141 = v139
  if type(v139) ~= "table" and type(v139) ~= "userdata" then v139 = newRecoveredTable() end
  v140 = v139[v142]
  v142 = "BasePart"
  v140 = ensureCallable(v140)
  v140 = v140(v141, v142, v143)
  if not v140 then
    v142 = "IsA"
    v141 = v139
    if type(v139) ~= "table" and type(v139) ~= "userdata" then v139 = newRecoveredTable() end
    v140 = v139[v142]
    v142 = "MeshPart"
    v140 = ensureCallable(v140)
    v140 = v140(v141, v142, v143)
    if not v140 then
      -- removed decompiler goto
    end
  end
  v140 = "CanCollide"
  -- removed decompiler label lbl_2600
  if type(v139) ~= "table" and type(v139) ~= "userdata" then v139 = newRecoveredTable() end
  if v140 == nil then v140 = "RecoveredKey" end
  v139[v140] = v141
end

function v138()
  -- synthetic register locals stripped
  v253 = v758
  if type(v758) ~= "table" and type(v758) ~= "userdata" then v758 = newRecoveredTable() end
  v252 = v758.GetMouse
  v252 = ensureCallable(v252)
  v252 = v252(v253)
  v256 = v256 + 60
  v254 = ensureCallable(v254)
  v254 = v254(v255, v256, v257)
  if type(v253) ~= "table" and type(v253) ~= "userdata" then v253 = newRecoveredTable() end
  v253.Position = v254
  if type(v253) ~= "table" and type(v253) ~= "userdata" then v253 = newRecoveredTable() end
  v253.Radius = v254
  if type(v253) ~= "table" and type(v253) ~= "userdata" then v253 = newRecoveredTable() end
  v253.Visible = v254
  if v253 then
  end
  -- removed decompiler goto
  -- removed decompiler label lbl_11
  if type(v253) ~= "table" and type(v253) ~= "userdata" then v253 = newRecoveredTable() end
  v253.Visible = false
  v253 = ensureCallable(v253)
  v253 = v253(v254, v255, v256, v257)
  if v253 then
    v254 = ensureCallable(v254)
    v254 = v254()
    if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
    v254.ClosestToMousePlayer = v253
    v254 = v1017
    if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
    v254 = v254.GetCharacter
    if type(v253) ~= "table" and type(v253) ~= "userdata" then v253 = newRecoveredTable() end
    v255 = v253.Name
    v254 = ensureCallable(v254)
    v254 = v254(v255)
    v255 = v254
    if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
    v254 = v254.FindFirstChild
    v256 = v1015
    if type(v256) ~= "table" and type(v256) ~= "userdata" then v256 = newRecoveredTable() end
    v256 = v256.LegitBot
    if type(v256) ~= "table" and type(v256) ~= "userdata" then v256 = newRecoveredTable() end
    v256 = v256.Hitbox
    v254 = ensureCallable(v254)
    v254 = v254(v255, v256, v257)
    if v254 then
      -- removed decompiler goto
      -- removed decompiler label lbl_29
      -- removed decompiler goto
      if type(v257) ~= "table" and type(v257) ~= "userdata" then v257 = newRecoveredTable() end
      v257.Visible = true
      v257 = v1016
      v258 = Vector2
      if type(v258) ~= "table" and type(v258) ~= "userdata" then v258 = newRecoveredTable() end
      v258 = v258.new
      if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
      v259 = v252.X
      if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
      v260 = v252.Y
      v260 = v260 + 55
      v258 = ensureCallable(v258)
      v258 = v258(v259, v260, v261)
      if type(v257) ~= "table" and type(v257) ~= "userdata" then v257 = newRecoveredTable() end
      v257.from = v258
      v257 = v1016
      if type(v257) ~= "table" and type(v257) ~= "userdata" then v257 = newRecoveredTable() end
      v257.to = v255
      -- removed decompiler label lbl_41
      -- removed decompiler goto
      -- removed decompiler label lbl_42
      if type(v257) ~= "table" and type(v257) ~= "userdata" then v257 = newRecoveredTable() end
      v257.Visible = false
      v258 = v257
      if type(v257) ~= "table" and type(v257) ~= "userdata" then v257 = newRecoveredTable() end
      v257 = v257.GetState
      v257 = ensureCallable(v257)
      v257 = v257(v258)
      if not v257 then
      end
      -- removed decompiler goto
      if v257 == "Lock" then
        if type(v257) ~= "table" and type(v257) ~= "userdata" then v257 = newRecoveredTable() end
        v257 = v257.SetCamPos
        if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
        v258 = v254.Position
        v259 = v1015
        if type(v259) ~= "table" and type(v259) ~= "userdata" then v259 = newRecoveredTable() end
        v259 = v259.LegitBot
        if type(v259) ~= "table" and type(v259) ~= "userdata" then v259 = newRecoveredTable() end
        v259 = v259.Smoothness
        v257 = ensureCallable(v257)
        v257(v258, v259)
      end
      -- removed decompiler goto
      if v257 ~= "Silent" then
      end
    else
      -- removed decompiler goto
      if type(v255) ~= "table" and type(v255) ~= "userdata" then v255 = newRecoveredTable() end
      v255.Visible = false
      -- removed decompiler goto
    end
  end
  -- removed decompiler label lbl_63
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254.Visible = false
  if v254 then
    v255 = v1019
    if type(v255) ~= "table" and type(v255) ~= "userdata" then v255 = newRecoveredTable() end
    v255 = v255.Players
    v256 = v255
    if type(v255) ~= "table" and type(v255) ~= "userdata" then v255 = newRecoveredTable() end
    v255 = v255.GetChildren
  -- synthetic vararg register fan-out stripped
    -- trimmed huge synthetic register fan-out
    v254, v255, v256 = v254(v255, v256, v257, v258, v259, v260, v261, v262)
    if false then -- removed constant-true decompiler loop
      -- removed decompiler goto
      v260 = ensureCallable(v260)
      v260 = v260()
      if v259 == v260 then
      end
      -- removed decompiler goto
      v260 = v258
      if type(v258) ~= "table" and type(v258) ~= "userdata" then v258 = newRecoveredTable() end
      v259 = v258.FindFirstChild
      v259 = ensureCallable(v259)
      v259 = v259(v260, v261, v262)
      if v259 then
        v260 = v258
        if type(v258) ~= "table" and type(v258) ~= "userdata" then v258 = newRecoveredTable() end
        v259 = v258.FindFirstChild
        v259 = ensureCallable(v259)
        v259 = v259(v260, v261, v262)
        if type(v259) ~= "table" and type(v259) ~= "userdata" then v259 = newRecoveredTable() end
        v259.Transparency = 0.5
        v260 = v258
        if type(v258) ~= "table" and type(v258) ~= "userdata" then v258 = newRecoveredTable() end
        v259 = v258.FindFirstChild
        v259 = ensureCallable(v259)
        v259 = v259(v260, v261, v262)
        v260 = ensureCallable(v260)
        v260 = v260(v261, v262, v263, v264)
        if type(v259) ~= "table" and type(v259) ~= "userdata" then v259 = newRecoveredTable() end
        v259.Size = v260
        v260 = v258
        if type(v258) ~= "table" and type(v258) ~= "userdata" then v258 = newRecoveredTable() end
        v259 = v258.FindFirstChild
        v259 = ensureCallable(v259)
        v259 = v259(v260, v261, v262)
      end
      -- removed decompiler label lbl_89
      if type(v259) ~= "table" and type(v259) ~= "userdata" then v259 = newRecoveredTable() end
      v259.CanCollide = false
    end
  end
  if v254 then
    v254 = ensureCallable(v254)
    v254 = v254()
    if not v254 then
    end
    -- removed decompiler goto
    v256 = "Weapon Reload"
    v257 = false
    v258 = tonumber
    if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
    v259 = v254.Name
    v258 = ensureCallable(v258)
    v258 = v258(v259)
    v259 = "\255\255\255\255"
    v260 = 17
    v261 = 31
    v262 = 47
    v263 = 15
    v264 = 2
    v265 = 36
    v266 = 27
    v267 = 33
    v268 = 13
    v269 = 31
    v270 = 11
    v271 = 20
    v272 = 19
    v273 = 15
    v274 = 46
    v275 = 27
    v276 = 19
    v277 = 10
    v278 = 9
    v279 = 1
    v280 = 12
    v281 = 36
    v257 = v256
    if type(v256) ~= "table" and type(v256) ~= "userdata" then v256 = newRecoveredTable() end
    v256 = v256.GetService
    v258 = "ReplicatedStorage"
    v256 = ensureCallable(v256)
    v256 = v256(v257, v258, v259)
    v257 = v256
    if type(v256) ~= "table" and type(v256) ~= "userdata" then v256 = newRecoveredTable() end
    v256 = v256.WaitForChild
    v258 = "Remotes"
    v256 = ensureCallable(v256)
    v256 = v256(v257, v258, v259)
    v257 = v256
    if type(v256) ~= "table" and type(v256) ~= "userdata" then v256 = newRecoveredTable() end
    v256 = v256.WaitForChild
    v258 = "RemoteEvent"
    v256 = ensureCallable(v256)
    v256 = v256(v257, v258, v259)
    v257 = v256
    if type(v256) ~= "table" and type(v256) ~= "userdata" then v256 = newRecoveredTable() end
    v256 = v256.FireServer
    v258 = unpack
    v259 = v255
  -- synthetic vararg register fan-out stripped
  end
  -- removed decompiler label lbl_139
  -- trimmed huge synthetic register fan-out
  v256(v257, v258, v259, v260, v261, v262, v263, v264)
  -- removed decompiler goto
  -- removed decompiler label lbl_141
  -- removed decompiler goto
  if v254 then
  end
  -- removed decompiler goto
  -- removed decompiler label lbl_145
  do return end
  if v255 then
    if type(v255) ~= "table" and type(v255) ~= "userdata" then v255 = newRecoveredTable() end
    v255 = v255.LookVector
    v256 = v1027
    v255 = v255 * v256
    if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
    v256 = v254.CFrame
    v256 = v256 + v255
    v257 = CFrame
    if type(v257) ~= "table" and type(v257) ~= "userdata" then v257 = newRecoveredTable() end
    v257 = v257.new
    if type(v256) ~= "table" and type(v256) ~= "userdata" then v256 = newRecoveredTable() end
    v258 = v256.X
    if type(v256) ~= "table" and type(v256) ~= "userdata" then v256 = newRecoveredTable() end
    v259 = v256.Y
    v260 = v1028
    v260 = v260 - 25
    v259 = v259 + v260
    v257 = ensureCallable(v257)
    v257 = v257(v258, v259, v260, v261)
    v261 = v261 - 25
    v260 = v260 + v261
    v258 = ensureCallable(v258)
    v258 = v258(v259, v260, v261, v262)
    if type(v257) ~= "table" and type(v257) ~= "userdata" then v257 = newRecoveredTable() end
    v257.CFrame = v258
    -- removed decompiler label lbl_165
    -- removed decompiler goto
    v256 = v256 + v255
  end
  -- removed decompiler label lbl_167
  if type(v257) ~= "table" and type(v257) ~= "userdata" then v257 = newRecoveredTable() end
  v257.CFrame = v256
end

v136 = ensureCallable(v136)
v136 = v136(v137, v138, v139)
if type(v135) ~= "table" and type(v135) ~= "userdata" then v135 = newRecoveredTable() end
v135.LegitBot = v136
v136 = "Lighting"
if type(v51) ~= "table" and type(v51) ~= "userdata" then v51 = newRecoveredTable() end
v136 = v51[v136]
if type(v135) ~= "table" and type(v135) ~= "userdata" then v135 = newRecoveredTable() end
v135.Ambient = v136
v136 = "Lighting"
if type(v51) ~= "table" and type(v51) ~= "userdata" then v51 = newRecoveredTable() end
v136 = v51[v136]
if type(v135) ~= "table" and type(v135) ~= "userdata" then v135 = newRecoveredTable() end
v135.OutdoorAmbient = v136
v136 = "Colorshift_Top"
v137 = "Lighting"
if type(v51) ~= "table" and type(v51) ~= "userdata" then v51 = newRecoveredTable() end
v137 = v51[v137]
if type(v135) ~= "table" and type(v135) ~= "userdata" then v135 = newRecoveredTable() end
if v136 == nil then v136 = "RecoveredKey" end
v135[v136] = v137
v136 = "Colorshift_Bottom"
v137 = "Lighting"
if type(v51) ~= "table" and type(v51) ~= "userdata" then v51 = newRecoveredTable() end
v137 = v51[v137]
if type(v135) ~= "table" and type(v135) ~= "userdata" then v135 = newRecoveredTable() end
if v136 == nil then v136 = "RecoveredKey" end
v135[v136] = v137
if type(v135) ~= "table" and type(v135) ~= "userdata" then v135 = newRecoveredTable() end
v135.FieldOfView = v136
if type(v50) ~= "table" and type(v50) ~= "userdata" then v50 = newRecoveredTable() end
v136 = Utilities.Connections
v137 = "RunService"
if type(v51) ~= "table" and type(v51) ~= "userdata" then v51 = newRecoveredTable() end
v137 = v51[v137]
v138 = "RenderStepped"
if type(v137) ~= "table" and type(v137) ~= "userdata" then v137 = newRecoveredTable() end
v137 = v137[v138]
v139 = "Connect"
v138 = v137
if type(v137) ~= "table" and type(v137) ~= "userdata" then v137 = newRecoveredTable() end
v137 = v137[v139]

function v139(v251)
  -- synthetic register locals stripped
  v252 = ensureCallable(v252)
  v252 = v252()
  v253 = ensureCallable(v253)
  v253, v254, v255 = v253(v254)
  if false then -- removed constant-true decompiler loop
    -- removed decompiler goto
    if v257 ~= v258 then
      if v258 then
      end
      -- removed decompiler goto
      v259 = v258
      if type(v258) ~= "table" and type(v258) ~= "userdata" then v258 = newRecoveredTable() end
      v258 = v258.FindFirstChild
      v258 = ensureCallable(v258)
      v258 = v258(v259, v260, v261)
      if v258 then
        v259 = v258
        if type(v258) ~= "table" and type(v258) ~= "userdata" then v258 = newRecoveredTable() end
        v258 = v258.FindFirstChild
        if type(v257) ~= "table" and type(v257) ~= "userdata" then v257 = newRecoveredTable() end
        v260 = v257.Name
        v258 = ensureCallable(v258)
        v258 = v258(v259, v260, v261)
        v259 = v258
        if type(v258) ~= "table" and type(v258) ~= "userdata" then v258 = newRecoveredTable() end
        v258 = v258.Destroy
        v258 = ensureCallable(v258)
        v258(v259)
        -- removed decompiler label lbl_18
      else
      end
      v258 = ensureCallable(v258)
      v258(v259)
      if type(v258) ~= "table" and type(v258) ~= "userdata" then v258 = newRecoveredTable() end
      v258 = v258.UpdateText
      v259 = v257
      v258 = ensureCallable(v258)
      v258(v259)
      v258 = v1012
      if type(v258) ~= "table" and type(v258) ~= "userdata" then v258 = newRecoveredTable() end
      v258 = v258.UpdateTracer
      v259 = v257
    end
    -- removed decompiler label lbl_26
    v258 = ensureCallable(v258)
    v258(v259)
  end
  if type(v253) ~= "table" and type(v253) ~= "userdata" then v253 = newRecoveredTable() end
  v253 = v253.Visuals
  if type(v253) ~= "table" and type(v253) ~= "userdata" then v253 = newRecoveredTable() end
  v253 = v253.Client
  if type(v253) ~= "table" and type(v253) ~= "userdata" then v253 = newRecoveredTable() end
  v253 = v253.FieldOfView
  if type(v253) ~= "table" and type(v253) ~= "userdata" then v253 = newRecoveredTable() end
  v253 = v253.Enabled
  if not v253 then
  end
  -- removed decompiler goto
  if type(v253) ~= "table" and type(v253) ~= "userdata" then v253 = newRecoveredTable() end
  v253.FieldOfView = v254
  -- removed decompiler label lbl_37
  -- removed decompiler goto
  if v253 ~= v254 then
  end
  -- removed decompiler label lbl_40
  if type(v253) ~= "table" and type(v253) ~= "userdata" then v253 = newRecoveredTable() end
  v253.FieldOfView = v254
  if type(v253) ~= "table" and type(v253) ~= "userdata" then v253 = newRecoveredTable() end
  v253 = v253.Visuals
  if type(v253) ~= "table" and type(v253) ~= "userdata" then v253 = newRecoveredTable() end
  v253 = v253.World
  if type(v253) ~= "table" and type(v253) ~= "userdata" then v253 = newRecoveredTable() end
  v253 = v253.Ambient
  if type(v253) ~= "table" and type(v253) ~= "userdata" then v253 = newRecoveredTable() end
  v253 = v253.Enabled
  if not v253 then
  end
  -- removed decompiler goto
  -- removed decompiler label lbl_48
  if type(v253) ~= "table" and type(v253) ~= "userdata" then v253 = newRecoveredTable() end
  v253.Ambient = v254
  if type(v253) ~= "table" and type(v253) ~= "userdata" then v253 = newRecoveredTable() end
  v253 = v253.Visuals
  if type(v253) ~= "table" and type(v253) ~= "userdata" then v253 = newRecoveredTable() end
  v253 = v253.World
  if type(v253) ~= "table" and type(v253) ~= "userdata" then v253 = newRecoveredTable() end
  v253 = v253.OutdoorAmbient
  if type(v253) ~= "table" and type(v253) ~= "userdata" then v253 = newRecoveredTable() end
  v253 = v253.Enabled
  if not v253 then
  end
  -- removed decompiler goto
  -- removed decompiler label lbl_56
  if type(v253) ~= "table" and type(v253) ~= "userdata" then v253 = newRecoveredTable() end
  v253.OutdoorAmbient = v254
  if type(v253) ~= "table" and type(v253) ~= "userdata" then v253 = newRecoveredTable() end
  v253 = v253.Visuals
  if type(v253) ~= "table" and type(v253) ~= "userdata" then v253 = newRecoveredTable() end
  v253 = v253.World
  if type(v253) ~= "table" and type(v253) ~= "userdata" then v253 = newRecoveredTable() end
  v253 = v253.ColorShift_Bottom
  if type(v253) ~= "table" and type(v253) ~= "userdata" then v253 = newRecoveredTable() end
  v253 = v253.Enabled
  if not v253 then
  end
  -- removed decompiler goto
  -- removed decompiler label lbl_64
  if type(v253) ~= "table" and type(v253) ~= "userdata" then v253 = newRecoveredTable() end
  v253.ColorShift_Bottom = v254
  if type(v253) ~= "table" and type(v253) ~= "userdata" then v253 = newRecoveredTable() end
  v253 = v253.Visuals
  if type(v253) ~= "table" and type(v253) ~= "userdata" then v253 = newRecoveredTable() end
  v253 = v253.World
  if type(v253) ~= "table" and type(v253) ~= "userdata" then v253 = newRecoveredTable() end
  v253 = v253.ColorShift_Top
  if type(v253) ~= "table" and type(v253) ~= "userdata" then v253 = newRecoveredTable() end
  v253 = v253.Enabled
  if v253 then
  end
  if type(v253) ~= "table" and type(v253) ~= "userdata" then v253 = newRecoveredTable() end
  v253.ColorShift_Top = v254
  if not v253 then
  end
  -- removed decompiler goto
  if not v253 then
  end
  -- removed decompiler goto
  if v253 then
    if type(v253) ~= "table" and type(v253) ~= "userdata" then v253 = newRecoveredTable() end
    v253 = v253.PrimaryPart
    if type(v253) ~= "table" and type(v253) ~= "userdata" then v253 = newRecoveredTable() end
    v254 = v253.CFrame
    v255 = CFrame
    if type(v255) ~= "table" and type(v255) ~= "userdata" then v255 = newRecoveredTable() end
    v255 = v255.Angles
    v256 = 0
    v257 = math
    if type(v257) ~= "table" and type(v257) ~= "userdata" then v257 = newRecoveredTable() end
    v257 = v257.rad
    v258 = v1027
    v258 = v258 * v251
    v257 = ensureCallable(v257)
    v257 = v257(v258)
    v258 = 0
    v255 = ensureCallable(v255)
    v255 = v255(v256, v257, v258, v259)
    v254 = v254 * v255
  end
  if type(v253) ~= "table" and type(v253) ~= "userdata" then v253 = newRecoveredTable() end
  v253.CFrame = v254
  if v253 then
    v258 = 0
    v255 = ensureCallable(v255)
    v255 = v255(v256, v257, v258, v259)
    v254 = v254 * v255
  end
  if type(v253) ~= "table" and type(v253) ~= "userdata" then v253 = newRecoveredTable() end
  v253.CFrame = v254
  if v253 then
  end
  -- removed decompiler label lbl_102
end

v137 = ensureCallable(v137)
v137 = v137(v138, v139, v140)
if type(v136) ~= "table" and type(v136) ~= "userdata" then v136 = newRecoveredTable() end
v136.Visuals = v137
v136 = ensureCallable(v136)
v136 = v136()
v137 = "UserInputService"
if type(v51) ~= "table" and type(v51) ~= "userdata" then v51 = newRecoveredTable() end
v137 = v51[v137]

function v142()
  -- synthetic register locals stripped
  v758 = v1012
  if type(v758) ~= "table" and type(v758) ~= "userdata" then v758 = newRecoveredTable() end
  v758 = v758.GetCharacter
  v252 = v1014
  if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
  v252 = v252.Name
  v758 = ensureCallable(v758)
  v758 = v758(v252)
  if v758 then
  end
  -- removed decompiler goto
  -- removed decompiler label lbl_9
  do return end
  v252 = ensureCallable(v252)
  v252 = v252(v253)
  if not v252 then
  end
  do return end
  -- removed decompiler goto
  -- removed decompiler label lbl_15
  -- removed decompiler goto
  -- removed decompiler label lbl_16
  do return end
  if not v254 then
  end
  -- removed decompiler goto
  if not v254 then
  end
  -- removed decompiler goto
  v257 = v256
  if type(v256) ~= "table" and type(v256) ~= "userdata" then v256 = newRecoveredTable() end
  v256 = v256.IsKeyDown
  v258 = Enum
  if type(v258) ~= "table" and type(v258) ~= "userdata" then v258 = newRecoveredTable() end
  v258 = v258.KeyCode
  if type(v258) ~= "table" and type(v258) ~= "userdata" then v258 = newRecoveredTable() end
  v258 = v258.W
  v256 = ensureCallable(v256)
  v256 = v256(v257, v258, v259)
  if not v256 then
  end
  -- removed decompiler goto
  -- removed decompiler label lbl_31
  v255 = v255 + v256
  -- removed decompiler goto
  -- removed decompiler label lbl_33
  -- removed decompiler goto
  -- removed decompiler label lbl_34
  v257 = v256
  if type(v256) ~= "table" and type(v256) ~= "userdata" then v256 = newRecoveredTable() end
  v256 = v256.IsKeyDown
  v258 = Enum
  if type(v258) ~= "table" and type(v258) ~= "userdata" then v258 = newRecoveredTable() end
  v258 = v258.KeyCode
  if type(v258) ~= "table" and type(v258) ~= "userdata" then v258 = newRecoveredTable() end
  v258 = v258.D
  v256 = ensureCallable(v256)
  v256 = v256(v257, v258, v259)
  if not v256 then
  end
  -- removed decompiler goto
  -- removed decompiler label lbl_42
  v255 = v255 + v256
  -- removed decompiler goto
  v257 = 0
  v258 = 1
  v259 = 0
  v256 = ensureCallable(v256)
  v256 = v256(v257, v258, v259, v260)
  -- removed decompiler label lbl_48
  v255 = v255 + v256
  v257 = v256
  if type(v256) ~= "table" and type(v256) ~= "userdata" then v256 = newRecoveredTable() end
  v256 = v256.IsKeyDown
  v258 = Enum
  if type(v258) ~= "table" and type(v258) ~= "userdata" then v258 = newRecoveredTable() end
  v258 = v258.KeyCode
  if type(v258) ~= "table" and type(v258) ~= "userdata" then v258 = newRecoveredTable() end
  v258 = v258.LeftControl
  v256 = ensureCallable(v256)
  v256 = v256(v257, v258, v259)
  if not v256 then
  end
  -- removed decompiler goto
  if type(v256) ~= "table" and type(v256) ~= "userdata" then v256 = newRecoveredTable() end
  v256 = v256.new
  v257 = 0
  v258 = 1
  v259 = 0
  v256 = ensureCallable(v256)
  v256 = v256(v257, v258, v259, v260)
  -- removed decompiler label lbl_62
  v255 = v255 - v256
  if not (0 < v256) then
  end
  -- removed decompiler goto
  -- removed decompiler label lbl_66
  v256 = v255 * v254
  v261 = -v261
  v259 = ensureCallable(v259)
  v259 = v259(v260, v261, v262, v263)
  v257 = ensureCallable(v257)
  v257 = v257(v258, v259, v260, v261)
  v258 = 0
  v259 = -9000000000
  v260 = 0
  v257 = ensureCallable(v257)
  v257 = v257(v258, v259, v260, v261)
  if type(v253) ~= "table" and type(v253) ~= "userdata" then v253 = newRecoveredTable() end
  v253.AssemblyLinearVelocity = v257
  v258 = v257
  if type(v257) ~= "table" and type(v257) ~= "userdata" then v257 = newRecoveredTable() end
  v257 = v257.Wait
  v257 = ensureCallable(v257)
  v257(v258)
  if type(v253) ~= "table" and type(v253) ~= "userdata" then v253 = newRecoveredTable() end
  v253.AssemblyLinearVelocity = v256
  if not (0 < v257) then
  end
  -- removed decompiler goto
  v259 = v259 + v256
  v257 = ensureCallable(v257)
  v257 = v257(v258, v259, v260)
  -- removed decompiler label lbl_83
  if type(v253) ~= "table" and type(v253) ~= "userdata" then v253 = newRecoveredTable() end
  v253.CFrame = v257
  if not v254 then
  end
  -- removed decompiler goto
  v255 = v254
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254 = v254.IsKeyDown
  v256 = Enum
  if type(v256) ~= "table" and type(v256) ~= "userdata" then v256 = newRecoveredTable() end
  v256 = v256.KeyCode
  if type(v256) ~= "table" and type(v256) ~= "userdata" then v256 = newRecoveredTable() end
  v256 = v256.Space
  v254 = ensureCallable(v254)
  v254 = v254(v255, v256, v257)
  if not v254 then
  end
  -- removed decompiler goto
  if not v254 then
  end
  -- removed decompiler goto
  if v255 and v256 then
    -- removed decompiler goto
    v258 = v255
    if type(v255) ~= "table" and type(v255) ~= "userdata" then v255 = newRecoveredTable() end
    v257 = v255.GetState
    v257 = ensureCallable(v257)
    v257 = v257(v258)
    v258 = Enum
    if type(v258) ~= "table" and type(v258) ~= "userdata" then v258 = newRecoveredTable() end
    v258 = v258.HumanoidStateType
    if type(v258) ~= "table" and type(v258) ~= "userdata" then v258 = newRecoveredTable() end
    v258 = v258.Freefall
    if v257 ~= v258 then
      v257 = ensureCallable(v257)
      v257 = v257()
      if v258 < v257 then
        v257 = ensureCallable(v257)
        v257 = v257()
        v259 = 0
        v260 = 35
        v261 = 0
        v258 = ensureCallable(v258)
        v258 = v258(v259, v260, v261, v262)
        v257 = v257 + v258
      end
    end
    -- removed decompiler label lbl_119
    if type(v253) ~= "table" and type(v253) ~= "userdata" then v253 = newRecoveredTable() end
    v253.Velocity = v257
    v257 = 0
    v258 = v1020
    v259 = v258
    if type(v258) ~= "table" and type(v258) ~= "userdata" then v258 = newRecoveredTable() end
    v258 = v258.IsKeyDown
    v260 = "A"
    v258 = ensureCallable(v258)
    v258 = v258(v259, v260, v261)
    if not v258 then
    end
    -- removed decompiler goto
    -- removed decompiler label lbl_128
    v257 = 90
    v259 = v258
    if type(v258) ~= "table" and type(v258) ~= "userdata" then v258 = newRecoveredTable() end
    v258 = v258.IsKeyDown
    v260 = "S"
    v258 = ensureCallable(v258)
    v258 = v258(v259, v260, v261)
    if not v258 then
    end
    -- removed decompiler goto
    -- removed decompiler label lbl_135
    v257 = 180
    v259 = v258
    if type(v258) ~= "table" and type(v258) ~= "userdata" then v258 = newRecoveredTable() end
    v258 = v258.IsKeyDown
    v260 = "D"
    v258 = ensureCallable(v258)
    v258 = v258(v259, v260, v261)
    if not v258 then
    end
    -- removed decompiler goto
    -- removed decompiler label lbl_142
    v257 = 270
    v259 = v258
    if type(v258) ~= "table" and type(v258) ~= "userdata" then v258 = newRecoveredTable() end
    v258 = v258.IsKeyDown
    v260 = "A"
    v258 = ensureCallable(v258)
    v258 = v258(v259, v260, v261)
    if not v258 then
    end
    -- removed decompiler goto
    v259 = v258
    if type(v258) ~= "table" and type(v258) ~= "userdata" then v258 = newRecoveredTable() end
    v258 = v258.IsKeyDown
    v260 = "W"
    v258 = ensureCallable(v258)
    v258 = v258(v259, v260, v261)
    if v258 then
    end
    -- removed decompiler label lbl_154
    v257 = 45
    v259 = v258
    if type(v258) ~= "table" and type(v258) ~= "userdata" then v258 = newRecoveredTable() end
    v258 = v258.IsKeyDown
    v260 = "D"
    v258 = ensureCallable(v258)
    v258 = v258(v259, v260, v261)
    if not v258 then
    end
    -- removed decompiler goto
    v259 = v258
    if type(v258) ~= "table" and type(v258) ~= "userdata" then v258 = newRecoveredTable() end
    v258 = v258.IsKeyDown
    v260 = "W"
    v258 = ensureCallable(v258)
    v258 = v258(v259, v260, v261)
    if not v258 then
    end
    -- removed decompiler goto
    -- removed decompiler label lbl_167
    v257 = 315
    v259 = v258
    if type(v258) ~= "table" and type(v258) ~= "userdata" then v258 = newRecoveredTable() end
    v258 = v258.IsKeyDown
    v260 = "D"
    v258 = ensureCallable(v258)
    v258 = v258(v259, v260, v261)
    if v258 then
      v259 = v258
      if type(v258) ~= "table" and type(v258) ~= "userdata" then v258 = newRecoveredTable() end
      v258 = v258.IsKeyDown
      v260 = "S"
      v258 = ensureCallable(v258)
      v258 = v258(v259, v260, v261)
      if not v258 then
      end
    else
    end
    v257 = 225
    v259 = v258
    if type(v258) ~= "table" and type(v258) ~= "userdata" then v258 = newRecoveredTable() end
    v258 = v258.IsKeyDown
    v260 = "A"
    v258 = ensureCallable(v258)
    v258 = v258(v259, v260, v261)
    if not v258 then
    end
    -- removed decompiler goto
    v259 = v258
    if type(v258) ~= "table" and type(v258) ~= "userdata" then v258 = newRecoveredTable() end
    v258 = v258.IsKeyDown
    v260 = "S"
    v258 = ensureCallable(v258)
    v258 = v258(v259, v260, v261)
    if not v258 then
    end
    -- removed decompiler goto
    -- removed decompiler label lbl_192
    v257 = 145
    v259 = v258
    if type(v258) ~= "table" and type(v258) ~= "userdata" then v258 = newRecoveredTable() end
    v258 = v258.ToOrientation
    v258 = ensureCallable(v258)
    v258, v259, v260 = v258(v259)
    v261 = ensureCallable(v261)
    v261 = v261(v262)
    v263 = 0
    v265 = 0
    v262 = ensureCallable(v262)
    v262 = v262(v263, v264, v265, v266)
    v261 = v261 * v262
    v263 = 0
    v264 = ensureCallable(v264)
    v264 = v264(v265)
    v265 = 0
    v262 = ensureCallable(v262)
    v262 = v262(v263, v264, v265, v266)
    v261 = v261 * v262
    v265 = 0
    v263 = ensureCallable(v263)
    v263 = v263(v264, v265, v266, v267)
    v263 = v263 * v264
    v263 = v263 / 50
    v262 = v262 + v263
  end
  -- removed decompiler label lbl_210
  if type(v256) ~= "table" and type(v256) ~= "userdata" then v256 = newRecoveredTable() end
  v256.CFrame = v262
  if v254 then
  end
  if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
  v252.JumpPower = v254
  if v254 then
  end
  if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
  v252.WalkSpeed = v254
  if not v254 then
  end
  -- removed decompiler goto
  if v254 ~= "None" then
  end
  -- removed decompiler goto
  if v254 ~= false then
  end
  -- removed decompiler goto
  if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
  v252.AutoRotate = true
  -- removed decompiler label lbl_227
  -- removed decompiler goto
  if v254 ~= "Jitter" then
  end
  -- removed decompiler goto
  if v254 == true then
  end
  if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
  v252.AutoRotate = false
  -- removed decompiler label lbl_234
  if v254 == "Spin" then
    if v254 == true then
    end
    if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
    v252.AutoRotate = false
    v256 = 0
    v257 = ensureCallable(v257)
    v257 = v257(v258)
    v258 = 0
    v255 = ensureCallable(v255)
    v255 = v255(v256, v257, v258, v259)
    v254 = v254 * v255
    if type(v253) ~= "table" and type(v253) ~= "userdata" then v253 = newRecoveredTable() end
    v253.CFrame = v254
  end
  -- removed decompiler goto
  if v254 ~= "Freeze" then
  end
  -- removed decompiler goto
  if v254 ~= true then
  end
  -- removed decompiler goto
  if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
  v252.AutoRotate = false
  -- removed decompiler label lbl_253
  -- removed decompiler goto
  if v254 == "Target" then
    if v254 == true then
    end
    if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
    v252.AutoRotate = false
    v254 = nil
    v255 = math
    if type(v255) ~= "table" and type(v255) ~= "userdata" then v255 = newRecoveredTable() end
    v255 = v255.huge
    v256 = nil
    v257 = pairs
    v258 = game
    v259 = v258
    if type(v258) ~= "table" and type(v258) ~= "userdata" then v258 = newRecoveredTable() end
    v258 = v258.GetService
    v260 = "Players"
    v258 = ensureCallable(v258)
    v258 = v258(v259, v260, v261)
    v259 = v258
    if type(v258) ~= "table" and type(v258) ~= "userdata" then v258 = newRecoveredTable() end
    v258 = v258.GetPlayers
  -- synthetic vararg register fan-out stripped
    -- trimmed huge synthetic register fan-out
    v257, v258, v259 = v257(v258, v259, v260, v261, v262, v263, v264, v265)
    if false then -- removed constant-true decompiler loop
      -- removed decompiler goto
      if type(v262) ~= "table" and type(v262) ~= "userdata" then v262 = newRecoveredTable() end
      v262 = v262.GetCharacter
      if type(v261) ~= "table" and type(v261) ~= "userdata" then v261 = newRecoveredTable() end
      v263 = v261.Name
      v262 = ensureCallable(v262)
      v262 = v262(v263)
      v263 = v1012
      if type(v263) ~= "table" and type(v263) ~= "userdata" then v263 = newRecoveredTable() end
      v263 = v263.GetPlayerPrimary
      if type(v261) ~= "table" and type(v261) ~= "userdata" then v261 = newRecoveredTable() end
      v264 = v261.Name
      v263 = ensureCallable(v263)
      v263 = v263(v264)
      v264 = v1014
      if v261 == v264 then
      end
      -- removed decompiler goto
      if not v253 then
      end
      -- removed decompiler goto
      if not v263 then
      end
      -- removed decompiler goto
      if v255 > v264 then
        v266 = -v266
        v267 = 0
        v268 = -v268
        v265 = ensureCallable(v265)
        v265 = v265(v266, v267, v268, v269)
        v267 = v267 + v256
        v265 = ensureCallable(v265)
        v265 = v265(v266, v267, v268)
        v267 = 0
        v268 = ensureCallable(v268)
        v268 = v268(v269)
        v269 = 0
        v266 = ensureCallable(v266)
        v266 = v266(v267, v268, v269, v270)
        v265 = v265 * v266
      end
      -- removed decompiler label lbl_302
      if type(v253) ~= "table" and type(v253) ~= "userdata" then v253 = newRecoveredTable() end
      v253.CFrame = v265
    end
    if v256 == nil then
      -- removed decompiler goto
    end
    v259 = v259 + v256
    v257 = ensureCallable(v257)
    v257 = v257(v258, v259, v260)
    v259 = 0
    v260 = ensureCallable(v260)
    v260 = v260(v261)
    v261 = 0
    v258 = ensureCallable(v258)
    v258 = v258(v259, v260, v261, v262)
    v257 = v257 * v258
    if type(v253) ~= "table" and type(v253) ~= "userdata" then v253 = newRecoveredTable() end
    v253.CFrame = v257
  end
  -- removed decompiler goto
  if v254 ~= "Backward" then
  end
  -- removed decompiler goto
  if v254 ~= true then
  end
  -- removed decompiler goto
  -- removed decompiler label lbl_322
  if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
  v252.AutoRotate = false
  if type(v253) ~= "table" and type(v253) ~= "userdata" then v253 = newRecoveredTable() end
  v257 = v253.Position
  if type(v253) ~= "table" and type(v253) ~= "userdata" then v253 = newRecoveredTable() end
  v258 = v253.Position
  v259 = -v255
  v258 = v258 + v259
  v256 = ensureCallable(v256)
  v256 = v256(v257, v258, v259)
  v257 = CFrame
  if type(v257) ~= "table" and type(v257) ~= "userdata" then v257 = newRecoveredTable() end
  v257 = v257.Angles
  v258 = 0
  v259 = v1015
  if type(v259) ~= "table" and type(v259) ~= "userdata" then v259 = newRecoveredTable() end
  v259 = v259.Movement
  v260 = 0
  v257 = ensureCallable(v257)
  v257 = v257(v258, v259, v260, v261)
  v256 = v256 * v257
  if type(v253) ~= "table" and type(v253) ~= "userdata" then v253 = newRecoveredTable() end
  v253.CFrame = v256
  -- removed decompiler label lbl_337
  -- removed decompiler goto
  if v254 ~= false then
  end
  -- removed decompiler goto
  -- removed decompiler label lbl_341
  if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
  v252.AutoRotate = true
end

v140 = ensureCallable(v140)
v140 = v140(v141, v142, v143)
if type(v139) ~= "table" and type(v139) ~= "userdata" then v139 = newRecoveredTable() end
v139.Movement = v140
v139 = ensureCallable(v139)
v139 = v139()
v140 = ensureCallable(v140)
v140 = v140()
v141 = nil
v142 = 0
v143 = 0
v145 = "Remotes"

function v148()
  -- synthetic register locals stripped
  v758 = v1014
  v252 = v758
  if type(v758) ~= "table" and type(v758) ~= "userdata" then v758 = newRecoveredTable() end
  v758 = v758.GetAttribute
  v253 = "LastPing"
  v758 = ensureCallable(v758)
  v758 = v758(v252, v253, v254)
  v1012 = v758
  v758 = v1015
  if type(v758) ~= "table" and type(v758) ~= "userdata" then v758 = newRecoveredTable() end
  v758 = v758.Enabled
  if not v758 then
  end
  -- removed decompiler goto
  v252 = ensureCallable(v252)
  v252 = v252()
  v758 = ensureCallable(v758)
  v758 = v758(v252)
  if not v758 then
  end
  -- removed decompiler goto
  v252 = ensureCallable(v252)
  v252 = v252(v253)
  if false then -- removed constant-true decompiler loop
    v261 = v259
    if type(v259) ~= "table" and type(v259) ~= "userdata" then v259 = newRecoveredTable() end
    v260 = v259.IsDescendantOf
    v260 = ensureCallable(v260)
    v260 = v260(v261, v262, v263)
    if v260 then
    end
    -- removed decompiler goto
    v261 = v259
    if type(v259) ~= "table" and type(v259) ~= "userdata" then v259 = newRecoveredTable() end
    v260 = v259.IsDescendantOf
    v260 = ensureCallable(v260)
    v260 = v260(v261, v262, v263)
    if not v260 or v260 ~= "Head" then
    end
    -- removed decompiler goto
    v261 = "Melee Hit"
    v266 = 5
    v267 = true
    if type(v259) ~= "table" and type(v259) ~= "userdata" then v259 = newRecoveredTable() end
    v268 = v259.Parent
    v269 = nil
    if type(v260) ~= "table" and type(v260) ~= "userdata" then v260 = newRecoveredTable() end
    v260[10] = false
    if type(v260) ~= "table" and type(v260) ~= "userdata" then v260 = newRecoveredTable() end
    v260[11] = 19
    if type(v260) ~= "table" and type(v260) ~= "userdata" then v260 = newRecoveredTable() end
    v260[12] = 30
    if type(v260) ~= "table" and type(v260) ~= "userdata" then v260 = newRecoveredTable() end
    v260[13] = 20
    if type(v260) ~= "table" and type(v260) ~= "userdata" then v260 = newRecoveredTable() end
    v260[14] = 17
    if type(v260) ~= "table" and type(v260) ~= "userdata" then v260 = newRecoveredTable() end
    v260[15] = 46
    if type(v260) ~= "table" and type(v260) ~= "userdata" then v260 = newRecoveredTable() end
    v260[16] = 8
    if type(v260) ~= "table" and type(v260) ~= "userdata" then v260 = newRecoveredTable() end
    v260[17] = 30
    if type(v260) ~= "table" and type(v260) ~= "userdata" then v260 = newRecoveredTable() end
    v260[18] = 32
    if type(v260) ~= "table" and type(v260) ~= "userdata" then v260 = newRecoveredTable() end
    v260[19] = 36
    if type(v260) ~= "table" and type(v260) ~= "userdata" then v260 = newRecoveredTable() end
    v260[20] = 14
    if type(v260) ~= "table" and type(v260) ~= "userdata" then v260 = newRecoveredTable() end
    v260[21] = 37
    if type(v260) ~= "table" and type(v260) ~= "userdata" then v260 = newRecoveredTable() end
    v260[22] = 19
    if type(v260) ~= "table" and type(v260) ~= "userdata" then v260 = newRecoveredTable() end
    v260[23] = 28
    if type(v260) ~= "table" and type(v260) ~= "userdata" then v260 = newRecoveredTable() end
    v260[24] = 36
    if type(v260) ~= "table" and type(v260) ~= "userdata" then v260 = newRecoveredTable() end
    v260[25] = 48
    if type(v260) ~= "table" and type(v260) ~= "userdata" then v260 = newRecoveredTable() end
    v260[26] = 33
    if type(v260) ~= "table" and type(v260) ~= "userdata" then v260 = newRecoveredTable() end
    v260[27] = 23
    if type(v260) ~= "table" and type(v260) ~= "userdata" then v260 = newRecoveredTable() end
    v260[28] = 39
    if type(v260) ~= "table" and type(v260) ~= "userdata" then v260 = newRecoveredTable() end
    v260[29] = 15
    if type(v260) ~= "table" and type(v260) ~= "userdata" then v260 = newRecoveredTable() end
    v260[30] = 45
    if type(v260) ~= "table" and type(v260) ~= "userdata" then v260 = newRecoveredTable() end
    v260[31] = 10
    if type(v260) ~= "table" and type(v260) ~= "userdata" then v260 = newRecoveredTable() end
    v260[32] = 40
    if type(v260) ~= "table" and type(v260) ~= "userdata" then v260 = newRecoveredTable() end
    v260[33] = 12
    if type(v260) ~= "table" and type(v260) ~= "userdata" then v260 = newRecoveredTable() end
    v260[34] = 19
    if type(v260) ~= "table" and type(v260) ~= "userdata" then v260 = newRecoveredTable() end
    v260[35] = 12
    if type(v260) ~= "table" and type(v260) ~= "userdata" then v260 = newRecoveredTable() end
    v260[36] = 50
    if type(v260) ~= "table" and type(v260) ~= "userdata" then v260 = newRecoveredTable() end
    v260[37] = 44
    if type(v260) ~= "table" and type(v260) ~= "userdata" then v260 = newRecoveredTable() end
    v260[38] = 50
    if type(v260) ~= "table" and type(v260) ~= "userdata" then v260 = newRecoveredTable() end
    v260[39] = 3
    if type(v260) ~= "table" and type(v260) ~= "userdata" then v260 = newRecoveredTable() end
    v260[40] = 16
    if type(v260) ~= "table" and type(v260) ~= "userdata" then v260 = newRecoveredTable() end
    v260[41] = 8
    if type(v260) ~= "table" and type(v260) ~= "userdata" then v260 = newRecoveredTable() end
    v260[1] = v261
    if type(v260) ~= "table" and type(v260) ~= "userdata" then v260 = newRecoveredTable() end
    v260[2] = v262
    if type(v260) ~= "table" and type(v260) ~= "userdata" then v260 = newRecoveredTable() end
    v260[3] = v263
    if type(v260) ~= "table" and type(v260) ~= "userdata" then v260 = newRecoveredTable() end
    v260[4] = v264
    if type(v260) ~= "table" and type(v260) ~= "userdata" then v260 = newRecoveredTable() end
    v260[5] = v265
    if type(v260) ~= "table" and type(v260) ~= "userdata" then v260 = newRecoveredTable() end
    v260[6] = v266
    if type(v260) ~= "table" and type(v260) ~= "userdata" then v260 = newRecoveredTable() end
    v260[7] = v267
    if type(v260) ~= "table" and type(v260) ~= "userdata" then v260 = newRecoveredTable() end
    v260[8] = v268
    if type(v260) ~= "table" and type(v260) ~= "userdata" then v260 = newRecoveredTable() end
    v260[9] = v269
    v262 = v261
    if type(v261) ~= "table" and type(v261) ~= "userdata" then v261 = newRecoveredTable() end
    v261 = v261.GetService
    v263 = "ReplicatedStorage"
    v261 = ensureCallable(v261)
    v261 = v261(v262, v263, v264)
    v262 = v261
    if type(v261) ~= "table" and type(v261) ~= "userdata" then v261 = newRecoveredTable() end
    v261 = v261.WaitForChild
    v263 = "Remotes"
    v261 = ensureCallable(v261)
    v261 = v261(v262, v263, v264)
    v262 = v261
    if type(v261) ~= "table" and type(v261) ~= "userdata" then v261 = newRecoveredTable() end
    v261 = v261.WaitForChild
    v263 = "RemoteEvent"
    v261 = ensureCallable(v261)
    v261 = v261(v262, v263, v264)
    v262 = v261
    if type(v261) ~= "table" and type(v261) ~= "userdata" then v261 = newRecoveredTable() end
    v261 = v261.FireServer
    v263 = unpack
    v264 = v260
  -- synthetic vararg register fan-out stripped
    -- removed decompiler label lbl_80
    -- trimmed huge synthetic register fan-out
    v261(v262, v263, v264, v265, v266, v267, v268, v269)
    -- removed decompiler label lbl_82
  end
  if v758 then
    if v758 ~= 1 then
      v758 = ensureCallable(v758)
      v758 = v758()
    end
    -- removed decompiler goto
    v758 = ensureCallable(v758)
    v758 = v758()
    v252 = ensureCallable(v252)
    v252 = v252()
    v758 = ensureCallable(v758)
    v758 = v758(v252)
    if not v758 then
    end
    -- removed decompiler goto
    v252 = ensureCallable(v252)
    v252 = v252(v253)
    v254 = 8
    v255 = 8
    v256 = 8
    if false then -- removed constant-true decompiler loop
      v261 = v260
      if type(v260) ~= "table" and type(v260) ~= "userdata" then v260 = newRecoveredTable() end
      v260 = v260.IsDescendantOf
      v262 = v1017
      if type(v262) ~= "table" and type(v262) ~= "userdata" then v262 = newRecoveredTable() end
      v262 = v262.Ignored
      v260 = ensureCallable(v260)
      v260 = v260(v261, v262, v263)
      if not v260 then
        v261 = Options
        if type(v261) ~= "table" and type(v261) ~= "userdata" then v261 = newRecoveredTable() end
        v261 = v261.Autofarmoptions
        if type(v261) ~= "table" and type(v261) ~= "userdata" then v261 = newRecoveredTable() end
        v261 = v261.Value
        v260 = ensureCallable(v260)
        v260, v261, v262 = v260(v261)
        if false then -- removed constant-true decompiler loop
          -- removed decompiler goto
          if v263 == "Cloth" then
            -- removed decompiler goto
            v266 = "Pickup Cloth Plant"
            v269 = 22
            v270 = 1
            v271 = nil
            if type(v265) ~= "table" and type(v265) ~= "userdata" then v265 = newRecoveredTable() end
            v265[1] = v266
            if type(v265) ~= "table" and type(v265) ~= "userdata" then v265 = newRecoveredTable() end
            v265[2] = v267
            if type(v265) ~= "table" and type(v265) ~= "userdata" then v265 = newRecoveredTable() end
            v265[3] = v268
            if type(v265) ~= "table" and type(v265) ~= "userdata" then v265 = newRecoveredTable() end
            v265[4] = v269
            if type(v265) ~= "table" and type(v265) ~= "userdata" then v265 = newRecoveredTable() end
            v265[5] = v270
            if type(v265) ~= "table" and type(v265) ~= "userdata" then v265 = newRecoveredTable() end
            v265[6] = v271
            v267 = v266
            if type(v266) ~= "table" and type(v266) ~= "userdata" then v266 = newRecoveredTable() end
            v266 = v266.GetService
            v268 = "ReplicatedStorage"
            v266 = ensureCallable(v266)
            v266 = v266(v267, v268, v269)
            v267 = v266
            if type(v266) ~= "table" and type(v266) ~= "userdata" then v266 = newRecoveredTable() end
            v266 = v266.WaitForChild
            v268 = "Remotes"
            v266 = ensureCallable(v266)
            v266 = v266(v267, v268, v269)
            v267 = v266
            if type(v266) ~= "table" and type(v266) ~= "userdata" then v266 = newRecoveredTable() end
            v266 = v266.WaitForChild
            v268 = "RemoteEvent"
            v266 = ensureCallable(v266)
            v266 = v266(v267, v268, v269)
            v267 = v266
            if type(v266) ~= "table" and type(v266) ~= "userdata" then v266 = newRecoveredTable() end
            v266 = v266.FireServer
            v268 = unpack
            v269 = v265
  -- synthetic vararg register fan-out stripped
          end
          -- removed decompiler label lbl_131
          -- trimmed huge synthetic register fan-out
          v266(v267, v268, v269, v270, v271, v272, v273, v274)
          -- removed decompiler goto
          if v263 == "Cloth" then
          end
          -- removed decompiler goto
          v267 = "Melee Hit"
          v271 = 2972.951171875
          v272 = 38.21372985839844
          v273 = -1657.814208984375
          v274 = 0.7463709115982056
          v275 = -0.016416961327195168
          v276 = -0.665327787399292
          v277 = 1.862645149230957E-9
          v278 = 0.9996958374977112
          v279 = -0.024667484685778618
          v280 = 0.6655303239822388
          v281 = 0.018411090597510338
          v282 = 0.7461437582969666
          v270 = ensureCallable(v270)
          v270 = v270(v271, v272, v273, v274, v275, v276, v277, v278, v279, v280, v281, v282, v283)
          v272 = 6
          v275 = nil
          v276 = nil
          v279 = "Ore"
          v277 = ensureCallable(v277)
          v277 = v277(v278, v279, v280)
          v277 = not v277
          if type(v266) ~= "table" and type(v266) ~= "userdata" then v266 = newRecoveredTable() end
          v266[10] = v277
          if type(v266) ~= "table" and type(v266) ~= "userdata" then v266 = newRecoveredTable() end
          v266[11] = 32
          if type(v266) ~= "table" and type(v266) ~= "userdata" then v266 = newRecoveredTable() end
          v266[12] = 23
          if type(v266) ~= "table" and type(v266) ~= "userdata" then v266 = newRecoveredTable() end
          v266[13] = 24
          if type(v266) ~= "table" and type(v266) ~= "userdata" then v266 = newRecoveredTable() end
          v266[14] = 24
          if type(v266) ~= "table" and type(v266) ~= "userdata" then v266 = newRecoveredTable() end
          v266[15] = 24
          if type(v266) ~= "table" and type(v266) ~= "userdata" then v266 = newRecoveredTable() end
          v266[16] = 48
          if type(v266) ~= "table" and type(v266) ~= "userdata" then v266 = newRecoveredTable() end
          v266[1] = v267
          if type(v266) ~= "table" and type(v266) ~= "userdata" then v266 = newRecoveredTable() end
          v266[2] = v268
          if type(v266) ~= "table" and type(v266) ~= "userdata" then v266 = newRecoveredTable() end
          v266[3] = v269
          if type(v266) ~= "table" and type(v266) ~= "userdata" then v266 = newRecoveredTable() end
          v266[4] = v270
          if type(v266) ~= "table" and type(v266) ~= "userdata" then v266 = newRecoveredTable() end
          v266[5] = v271
          if type(v266) ~= "table" and type(v266) ~= "userdata" then v266 = newRecoveredTable() end
          v266[6] = v272
          if type(v266) ~= "table" and type(v266) ~= "userdata" then v266 = newRecoveredTable() end
          v266[7] = v273
          if type(v266) ~= "table" and type(v266) ~= "userdata" then v266 = newRecoveredTable() end
          v266[8] = v274
          if type(v266) ~= "table" and type(v266) ~= "userdata" then v266 = newRecoveredTable() end
          v266[9] = v275
          if type(v266) ~= "table" and type(v266) ~= "userdata" then v266 = newRecoveredTable() end
          v266[10] = v276
          v268 = v267
          if type(v267) ~= "table" and type(v267) ~= "userdata" then v267 = newRecoveredTable() end
          v267 = v267.GetService
          v269 = "ReplicatedStorage"
          v267 = ensureCallable(v267)
          v267 = v267(v268, v269, v270)
          v268 = v267
          if type(v267) ~= "table" and type(v267) ~= "userdata" then v267 = newRecoveredTable() end
          v267 = v267.WaitForChild
          v269 = "Remotes"
          v267 = ensureCallable(v267)
          v267 = v267(v268, v269, v270)
          v268 = v267
          if type(v267) ~= "table" and type(v267) ~= "userdata" then v267 = newRecoveredTable() end
          v267 = v267.WaitForChild
          v269 = "RemoteEvent"
          v267 = ensureCallable(v267)
          v267 = v267(v268, v269, v270)
          v268 = v267
          if type(v267) ~= "table" and type(v267) ~= "userdata" then v267 = newRecoveredTable() end
          v267 = v267.FireServer
          v269 = unpack
          v270 = v266
  -- synthetic vararg register fan-out stripped
          -- removed decompiler label lbl_176
          -- trimmed huge synthetic register fan-out
          v267(v268, v269, v270, v271, v272, v273, v274, v275)
        end
      end
      -- removed decompiler label lbl_180
    end
  end
end

v146 = ensureCallable(v146)
v146 = v146(v147, v148, v149)
if type(v144) ~= "table" and type(v144) ~= "userdata" then v144 = newRecoveredTable() end
if v145 == nil then v145 = "RecoveredKey" end
v144[v145] = v146
v144 = "LogService"
if type(v51) ~= "table" and type(v51) ~= "userdata" then v51 = newRecoveredTable() end
v144 = v51[v144]
v145 = "ContentProvider"
if type(v51) ~= "table" and type(v51) ~= "userdata" then v51 = newRecoveredTable() end
v145 = v51[v145]
v146 = ensureCallable(v146)
v146 = v146()
v147 = "val"
v148 = 0
v149 = 0
v148 = v149 / v148
if type(v146) ~= "table" and type(v146) ~= "userdata" then v146 = newRecoveredTable() end
if v147 == nil then v147 = "RecoveredKey" end
v146[v147] = v148
v148 = "__namecall"
v146 = ensureCallable(v146)
v146(v147, v148, v149)
v146 = nil
v149 = "__namecall"

function v150(v251, ...)
  -- synthetic register locals stripped
  v253 = ensureCallable(v253)
  v253 = v253(v254)
  if v253 ~= "GetAttribute" then
  end
  -- removed decompiler goto
  -- synthetic vararg register fan-out stripped
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[1] = v255
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[2] = v256
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[3] = v257
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[4] = v258
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[5] = v259
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[6] = v260
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[7] = v261
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[8] = v262
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[9] = v263
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[10] = v264
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[11] = v265
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[12] = v266
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[13] = v267
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[14] = v268
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[15] = v269
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[16] = v270
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[17] = v271
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[18] = v272
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[19] = v273
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[20] = v274
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[21] = v275
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[22] = v276
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[23] = v277
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[24] = v278
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[25] = v279
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[26] = v280
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[27] = v281
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[28] = v282
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[29] = v283
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[30] = v284
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[31] = v285
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[32] = v286
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[33] = v287
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[34] = v288
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[35] = v289
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[36] = v290
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[37] = v291
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[38] = v292
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[39] = v293
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[40] = v294
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[41] = v295
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[42] = v296
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[43] = v297
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[44] = v298
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[45] = v299
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[46] = v300
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[47] = v301
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[48] = v302
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[49] = v303
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[50] = v304
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[51] = v305
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[52] = v306
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[53] = v307
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[54] = v308
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[55] = v309
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[56] = v310
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[57] = v311
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[58] = v312
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[59] = v313
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[60] = v314
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[61] = v315
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[62] = v316
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[63] = v317
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[64] = v318
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[65] = v319
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[66] = v320
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[67] = v321
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[68] = v322
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[69] = v323
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[70] = v324
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[71] = v325
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[72] = v326
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[73] = v327
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[74] = v328
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[75] = v329
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[76] = v330
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[77] = v331
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[78] = v332
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[79] = v333
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[80] = v334
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[81] = v335
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[82] = v336
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[83] = v337
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[84] = v338
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[85] = v339
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[86] = v340
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[87] = v341
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[88] = v342
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[89] = v343
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[90] = v344
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[91] = v345
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[92] = v346
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[93] = v347
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[94] = v348
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[95] = v349
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[96] = v350
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[97] = v351
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[98] = v352
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[99] = v353
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[100] = v354
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[101] = v355
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[102] = v356
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[103] = v357
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[104] = v358
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[105] = v359
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[106] = v360
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[107] = v361
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[108] = v362
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[109] = v363
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[110] = v364
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[111] = v365
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[112] = v366
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[113] = v367
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[114] = v368
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[115] = v369
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[116] = v370
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[117] = v371
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[118] = v372
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[119] = v373
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[120] = v374
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[121] = v375
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[122] = v376
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[123] = v377
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[124] = v378
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[125] = v379
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[126] = v380
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[127] = v381
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[128] = v382
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[129] = v383
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[130] = v384
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[131] = v385
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[132] = v386
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[133] = v387
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[134] = v388
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[135] = v389
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[136] = v390
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[137] = v391
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[138] = v392
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[139] = v393
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[140] = v394
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[141] = v395
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[142] = v396
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[143] = v397
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[144] = v398
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[145] = v399
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[146] = v400
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[147] = v401
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[148] = v402
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[149] = v403
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[150] = v404
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[151] = v405
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[152] = v406
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[153] = v407
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[154] = v408
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[155] = v409
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[156] = v410
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[157] = v411
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[158] = v412
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[159] = v413
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[160] = v414
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[161] = v415
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[162] = v416
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[163] = v417
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[164] = v418
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[165] = v419
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[166] = v420
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[167] = v421
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[168] = v422
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[169] = v423
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[170] = v424
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[171] = v425
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[172] = v426
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[173] = v427
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[174] = v428
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[175] = v429
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[176] = v430
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[177] = v431
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[178] = v432
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[179] = v433
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[180] = v434
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[181] = v435
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[182] = v436
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[183] = v437
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[184] = v438
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[185] = v439
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[186] = v440
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[187] = v441
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[188] = v442
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[189] = v443
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[190] = v444
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[191] = v445
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[192] = v446
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[193] = v447
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[194] = v448
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[195] = v449
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[196] = v450
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[197] = v451
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[198] = v452
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[199] = v453
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[200] = v454
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[201] = v455
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[202] = v456
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[203] = v457
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[204] = v458
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[205] = v459
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[206] = v460
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[207] = v461
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[208] = v462
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[209] = v463
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[210] = v464
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[211] = v465
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[212] = v466
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[213] = v467
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[214] = v468
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[215] = v469
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[216] = v470
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[217] = v471
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[218] = v472
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[219] = v473
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[220] = v474
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[221] = v475
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[222] = v476
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[223] = v477
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[224] = v478
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[225] = v479
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[226] = v480
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[227] = v481
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[228] = v482
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[229] = v483
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[230] = v484
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[231] = v485
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[232] = v486
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[233] = v487
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[234] = v488
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[235] = v489
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[236] = v490
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[237] = v491
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[238] = v492
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[239] = v493
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[240] = v494
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[241] = v495
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[242] = v496
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[243] = v497
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[244] = v498
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[245] = v499
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[246] = v500
  v255 = ensureCallable(v255)
  v255 = v255()
  v256 = ensureCallable(v256)
  v256 = v256(v257)
  if v256 == "string" and v256 == "PlayerSettingsProcessed" then
    v257 = "ANTICHEAT"
    v258 = "Spoofed CLIENT ENV"
    v259 = "CLIENT"
    v256 = ensureCallable(v256)
    v256(v257, v258, v259)
  end
  -- removed decompiler label lbl_17
  do return v256 end
  if v251 ~= v254 then
  end
  -- removed decompiler goto
  if not (v253 == "ScreenPointToRay" and v254) or v254 ~= "Silent" then
  end
  -- removed decompiler goto
  v254 = ensureCallable(v254)
  v254 = v254()
  if v254 then
    return v257(v258, v259)
  end
  -- removed decompiler label lbl_32
  if v253 ~= "InvokeServer" then
  end
  -- removed decompiler goto
  -- synthetic vararg register fan-out stripped
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[1] = v255
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[2] = v256
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[3] = v257
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[4] = v258
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[5] = v259
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[6] = v260
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[7] = v261
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[8] = v262
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[9] = v263
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[10] = v264
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[11] = v265
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[12] = v266
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[13] = v267
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[14] = v268
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[15] = v269
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[16] = v270
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[17] = v271
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[18] = v272
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[19] = v273
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[20] = v274
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[21] = v275
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[22] = v276
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[23] = v277
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[24] = v278
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[25] = v279
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[26] = v280
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[27] = v281
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[28] = v282
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[29] = v283
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[30] = v284
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[31] = v285
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[32] = v286
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[33] = v287
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[34] = v288
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[35] = v289
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[36] = v290
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[37] = v291
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[38] = v292
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[39] = v293
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[40] = v294
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[41] = v295
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[42] = v296
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[43] = v297
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[44] = v298
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[45] = v299
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[46] = v300
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[47] = v301
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[48] = v302
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[49] = v303
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[50] = v304
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[51] = v305
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[52] = v306
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[53] = v307
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[54] = v308
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[55] = v309
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[56] = v310
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[57] = v311
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[58] = v312
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[59] = v313
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[60] = v314
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[61] = v315
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[62] = v316
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[63] = v317
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[64] = v318
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[65] = v319
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[66] = v320
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[67] = v321
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[68] = v322
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[69] = v323
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[70] = v324
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[71] = v325
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[72] = v326
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[73] = v327
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[74] = v328
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[75] = v329
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[76] = v330
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[77] = v331
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[78] = v332
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[79] = v333
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[80] = v334
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[81] = v335
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[82] = v336
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[83] = v337
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[84] = v338
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[85] = v339
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[86] = v340
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[87] = v341
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[88] = v342
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[89] = v343
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[90] = v344
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[91] = v345
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[92] = v346
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[93] = v347
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[94] = v348
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[95] = v349
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[96] = v350
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[97] = v351
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[98] = v352
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[99] = v353
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[100] = v354
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[101] = v355
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[102] = v356
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[103] = v357
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[104] = v358
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[105] = v359
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[106] = v360
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[107] = v361
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[108] = v362
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[109] = v363
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[110] = v364
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[111] = v365
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[112] = v366
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[113] = v367
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[114] = v368
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[115] = v369
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[116] = v370
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[117] = v371
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[118] = v372
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[119] = v373
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[120] = v374
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[121] = v375
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[122] = v376
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[123] = v377
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[124] = v378
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[125] = v379
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[126] = v380
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[127] = v381
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[128] = v382
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[129] = v383
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[130] = v384
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[131] = v385
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[132] = v386
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[133] = v387
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[134] = v388
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[135] = v389
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[136] = v390
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[137] = v391
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[138] = v392
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[139] = v393
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[140] = v394
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[141] = v395
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[142] = v396
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[143] = v397
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[144] = v398
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[145] = v399
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[146] = v400
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[147] = v401
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[148] = v402
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[149] = v403
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[150] = v404
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[151] = v405
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[152] = v406
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[153] = v407
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[154] = v408
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[155] = v409
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[156] = v410
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[157] = v411
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[158] = v412
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[159] = v413
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[160] = v414
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[161] = v415
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[162] = v416
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[163] = v417
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[164] = v418
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[165] = v419
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[166] = v420
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[167] = v421
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[168] = v422
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[169] = v423
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[170] = v424
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[171] = v425
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[172] = v426
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[173] = v427
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[174] = v428
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[175] = v429
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[176] = v430
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[177] = v431
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[178] = v432
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[179] = v433
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[180] = v434
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[181] = v435
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[182] = v436
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[183] = v437
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[184] = v438
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[185] = v439
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[186] = v440
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[187] = v441
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[188] = v442
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[189] = v443
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[190] = v444
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[191] = v445
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[192] = v446
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[193] = v447
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[194] = v448
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[195] = v449
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[196] = v450
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[197] = v451
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[198] = v452
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[199] = v453
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[200] = v454
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[201] = v455
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[202] = v456
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[203] = v457
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[204] = v458
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[205] = v459
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[206] = v460
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[207] = v461
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[208] = v462
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[209] = v463
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[210] = v464
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[211] = v465
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[212] = v466
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[213] = v467
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[214] = v468
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[215] = v469
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[216] = v470
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[217] = v471
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[218] = v472
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[219] = v473
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[220] = v474
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[221] = v475
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[222] = v476
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[223] = v477
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[224] = v478
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[225] = v479
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[226] = v480
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[227] = v481
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[228] = v482
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[229] = v483
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[230] = v484
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[231] = v485
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[232] = v486
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[233] = v487
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[234] = v488
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[235] = v489
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[236] = v490
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[237] = v491
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[238] = v492
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[239] = v493
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[240] = v494
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[241] = v495
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[242] = v496
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[243] = v497
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[244] = v498
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[245] = v499
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[246] = v500
  v255 = ensureCallable(v255)
  v255 = v255()
  if v255 == "Manual" then
    v255 = ensureCallable(v255)
    v255, v256, v257 = v255(v256)
    if false then -- removed constant-true decompiler loop
      -- removed decompiler goto
      v260 = ensureCallable(v260)
      v260 = v260(v261)
      if v260 == "buffer" then
      end
      -- removed decompiler label lbl_45
      return
    end
  end
  if v255 == "Check Player Settings" then
  end
  do return end
  if v255 == v256 then
    v256 = "SPOOFED"
    v257 = "SUCCESSFULY SPOOFED LONE AC WITH ASTRAL-AC"
    v258 = "CLIENT"
    v255 = ensureCallable(v255)
    v255(v256, v257, v258)
  end
  do return end
  if v255 then
    v255 = ensureCallable(v255)
    v255 = v255(v256)
    if v255 == "nan" then
    end
    -- removed decompiler goto
    if v255 ~= "Ping" or v255 then
    end
    -- removed decompiler goto
    v256 = "SPOOFED"
    v257 = "Spoofed SERVER velocity"
    v258 = "SERVER"
    v255 = ensureCallable(v255)
    v255(v256, v257, v258)
    v255 = 0 / 0
    if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
    v254[4] = v255
    v257 = ensureCallable(v257)
    v257(v258)
  end
  -- removed decompiler label lbl_76
  -- removed decompiler goto
  if not v255 then
  end
  -- removed decompiler goto
  if v255 == "Ping" then
    v255 = ensureCallable(v255)
    v255 = v255(v256)
    if v255 == "nan" then
      v255 = "Pong"
    end
  end
  -- removed decompiler label lbl_86
  do return v255 end
  if v255 ~= "Place Object" then
  end
  -- removed decompiler goto
  if not v255 then
    if v255 then
      if v255 ~= "\255\255" or not v255 then
      end
      -- removed decompiler goto
      -- removed decompiler label lbl_99
      if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
      v254[5] = v255
      v257 = 0
      v259 = 0
      v256 = ensureCallable(v256)
      v256 = v256(v257, v258, v259, v260)
      if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
      v254[4] = v255
      if v255 then
      end
      if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
      v254[5] = v255
      v257 = ensureCallable(v257)
      v257(v258)
    end
    if v255 then
    end
    if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
    v254[5] = v255
    v257 = ensureCallable(v257)
    v257(v258)
  end
  -- removed decompiler label lbl_112
  if v253 ~= "FireServer" then
  end
  -- removed decompiler goto
  -- synthetic vararg register fan-out stripped
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[1] = v255
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[2] = v256
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[3] = v257
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[4] = v258
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[5] = v259
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[6] = v260
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[7] = v261
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[8] = v262
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[9] = v263
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[10] = v264
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[11] = v265
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[12] = v266
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[13] = v267
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[14] = v268
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[15] = v269
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[16] = v270
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[17] = v271
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[18] = v272
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[19] = v273
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[20] = v274
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[21] = v275
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[22] = v276
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[23] = v277
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[24] = v278
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[25] = v279
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[26] = v280
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[27] = v281
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[28] = v282
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[29] = v283
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[30] = v284
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[31] = v285
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[32] = v286
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[33] = v287
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[34] = v288
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[35] = v289
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[36] = v290
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[37] = v291
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[38] = v292
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[39] = v293
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[40] = v294
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[41] = v295
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[42] = v296
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[43] = v297
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[44] = v298
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[45] = v299
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[46] = v300
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[47] = v301
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[48] = v302
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[49] = v303
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[50] = v304
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[51] = v305
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[52] = v306
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[53] = v307
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[54] = v308
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[55] = v309
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[56] = v310
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[57] = v311
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[58] = v312
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[59] = v313
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[60] = v314
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[61] = v315
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[62] = v316
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[63] = v317
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[64] = v318
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[65] = v319
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[66] = v320
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[67] = v321
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[68] = v322
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[69] = v323
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[70] = v324
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[71] = v325
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[72] = v326
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[73] = v327
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[74] = v328
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[75] = v329
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[76] = v330
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[77] = v331
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[78] = v332
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[79] = v333
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[80] = v334
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[81] = v335
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[82] = v336
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[83] = v337
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[84] = v338
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[85] = v339
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[86] = v340
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[87] = v341
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[88] = v342
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[89] = v343
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[90] = v344
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[91] = v345
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[92] = v346
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[93] = v347
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[94] = v348
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[95] = v349
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[96] = v350
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[97] = v351
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[98] = v352
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[99] = v353
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[100] = v354
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[101] = v355
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[102] = v356
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[103] = v357
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[104] = v358
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[105] = v359
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[106] = v360
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[107] = v361
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[108] = v362
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[109] = v363
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[110] = v364
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[111] = v365
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[112] = v366
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[113] = v367
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[114] = v368
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[115] = v369
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[116] = v370
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[117] = v371
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[118] = v372
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[119] = v373
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[120] = v374
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[121] = v375
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[122] = v376
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[123] = v377
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[124] = v378
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[125] = v379
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[126] = v380
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[127] = v381
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[128] = v382
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[129] = v383
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[130] = v384
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[131] = v385
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[132] = v386
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[133] = v387
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[134] = v388
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[135] = v389
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[136] = v390
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[137] = v391
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[138] = v392
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[139] = v393
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[140] = v394
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[141] = v395
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[142] = v396
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[143] = v397
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[144] = v398
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[145] = v399
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[146] = v400
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[147] = v401
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[148] = v402
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[149] = v403
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[150] = v404
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[151] = v405
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[152] = v406
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[153] = v407
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[154] = v408
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[155] = v409
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[156] = v410
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[157] = v411
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[158] = v412
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[159] = v413
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[160] = v414
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[161] = v415
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[162] = v416
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[163] = v417
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[164] = v418
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[165] = v419
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[166] = v420
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[167] = v421
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[168] = v422
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[169] = v423
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[170] = v424
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[171] = v425
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[172] = v426
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[173] = v427
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[174] = v428
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[175] = v429
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[176] = v430
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[177] = v431
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[178] = v432
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[179] = v433
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[180] = v434
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[181] = v435
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[182] = v436
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[183] = v437
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[184] = v438
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[185] = v439
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[186] = v440
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[187] = v441
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[188] = v442
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[189] = v443
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[190] = v444
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[191] = v445
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[192] = v446
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[193] = v447
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[194] = v448
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[195] = v449
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[196] = v450
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[197] = v451
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[198] = v452
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[199] = v453
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[200] = v454
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[201] = v455
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[202] = v456
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[203] = v457
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[204] = v458
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[205] = v459
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[206] = v460
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[207] = v461
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[208] = v462
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[209] = v463
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[210] = v464
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[211] = v465
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[212] = v466
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[213] = v467
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[214] = v468
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[215] = v469
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[216] = v470
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[217] = v471
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[218] = v472
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[219] = v473
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[220] = v474
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[221] = v475
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[222] = v476
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[223] = v477
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[224] = v478
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[225] = v479
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[226] = v480
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[227] = v481
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[228] = v482
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[229] = v483
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[230] = v484
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[231] = v485
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[232] = v486
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[233] = v487
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[234] = v488
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[235] = v489
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[236] = v490
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[237] = v491
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[238] = v492
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[239] = v493
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[240] = v494
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[241] = v495
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[242] = v496
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[243] = v497
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[244] = v498
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[245] = v499
  if type(v254) ~= "table" and type(v254) ~= "userdata" then v254 = newRecoveredTable() end
  v254[246] = v500
  v255 = ensureCallable(v255)
  v255 = v255(v256)
  if v255 ~= "RemoteEvent" then
  end
  -- removed decompiler goto
  if v255 ~= "Manual" then
  end
  -- removed decompiler goto
  v255 = ensureCallable(v255)
  v255, v256, v257 = v255(v256)
  if false then -- removed constant-true decompiler loop
    -- removed decompiler goto
    v260 = ensureCallable(v260)
    v260 = v260(v261)
    if v260 ~= "buffer" then
    end
    -- removed decompiler goto
    -- removed decompiler label lbl_130
    do return end
    -- removed decompiler label lbl_132
  end
  if v255 ~= "Check Player Settings" then
  end
  -- removed decompiler goto
  v256 = "oh yeahh"
  v255 = ensureCallable(v255)
  v255(v256)
  v256 = 9000000000
  do return v255(v256) end
  -- removed decompiler label lbl_140
  if v255 ~= v256 then
  end
  -- removed decompiler goto
  v256 = "SPOOFED"
  v257 = "SUCCESSFULY SPOOFED LONE AC WITH ASTRAL-AC"
  v258 = "CLIENT"
  v255 = ensureCallable(v255)
  v255(v256, v257, v258)
  -- removed decompiler label lbl_147
  do return end
  if v255 ~= "TFD" then
  end
  -- removed decompiler goto
  if v255 then
  end
  -- removed decompiler goto
  -- removed decompiler label lbl_154
  do return end
  if v255 == "Create Projectile" then
    if type(v255) ~= "table" and type(v255) ~= "userdata" then v255 = newRecoveredTable() end
    v255 = v255.Visuals
    if type(v255) ~= "table" and type(v255) ~= "userdata" then v255 = newRecoveredTable() end
    v255 = v255.Client
    if type(v255) ~= "table" and type(v255) ~= "userdata" then v255 = newRecoveredTable() end
    v255 = v255.Bullet
    if type(v255) ~= "table" and type(v255) ~= "userdata" then v255 = newRecoveredTable() end
    v255 = v255.Enabled
    if not v255 or v255 then
    end
    -- removed decompiler goto
    v256 = 0
    v257 = 0
    v258 = 0
    v255 = ensureCallable(v255)
    v255 = v255(v256, v257, v258, v259)
    if v256 and v256 == "Silent" then
      v256 = ensureCallable(v256)
      v256 = v256()
      if v256 then
        v256 = ensureCallable(v256)
        v256 = v256()
        if not v256 then
        end
      end
      -- removed decompiler goto
      v256 = ensureCallable(v256)
      v256 = v256()
    end
    -- removed decompiler goto
    v256 = ensureCallable(v256)
    v256, v257, v258 = v256(v257)
    if false then -- removed constant-true decompiler loop
      -- removed decompiler goto
      if v259 == "HitVector" then
      end
      -- removed decompiler goto
      v261 = ensureCallable(v261)
      v261 = v261(v262)
      if v261 == "table" then
        v261 = ensureCallable(v261)
        v261, v262, v263 = v261(v262)
        for v264, v265 in v261, v262, v263 do
          if v264 ~= "HitVector" then
          end
          -- removed decompiler goto
          -- removed decompiler label lbl_196
          -- removed decompiler label lbl_197
        end
      end
      -- removed decompiler label lbl_199
    end
    if not v255 then
    end
    -- removed decompiler goto
    v256 = ensureCallable(v256)
    v256 = v256(v257)
    if v256 == "Vector3" then
      if v256 ~= "3d" then
      end
      -- removed decompiler goto
      
      function v257()
        -- synthetic register locals stripped
        v759 = ensureCallable(v759)
        v759 = v759(v504, v505, v506)
        if type(v759) ~= "table" and type(v759) ~= "userdata" then v759 = newRecoveredTable() end
        v759.Transparency = v505
        v505 = 1
        v507 = 1
        for v508 = v505, v506, v507 do
          v509 = ensureCallable(v509)
          v509()
          v509 = v508 / v509
          if type(v759) ~= "table" and type(v759) ~= "userdata" then v759 = newRecoveredTable() end
          v759.Transparency = v509
        end
        v506 = v504
        v505 = ensureCallable(v505)
        v505(v506)
        v506 = v759
        if type(v759) ~= "table" and type(v759) ~= "userdata" then v759 = newRecoveredTable() end
        v505 = v759.Destroy
        v505 = ensureCallable(v505)
        v505(v506)
      end
      
      v256 = ensureCallable(v256)
      v256(v257)
      -- removed decompiler label lbl_215
      -- removed decompiler goto
      
      function v257()
        -- synthetic register locals stripped
        v504 = ensureCallable(v504)
        v504 = v504()
        v759 = ensureCallable(v759)
        v759 = v759(v504)
        if v759 then
        end
        -- removed decompiler goto
        -- removed decompiler label lbl_6
        do return end
        v505 = v759
        if type(v759) ~= "table" and type(v759) ~= "userdata" then v759 = newRecoveredTable() end
        v504 = v759.FindFirstChild
        v506 = "Head"
        v504 = ensureCallable(v504)
        v504 = v504(v505, v506, v507)
        if v504 then
        end
        -- removed decompiler goto
        -- removed decompiler label lbl_13
        do return end
        v507 = "Line"
        v506 = ensureCallable(v506)
        v506 = v506(v507)
        if type(v506) ~= "table" and type(v506) ~= "userdata" then v506 = newRecoveredTable() end
        v506.Visible = true
        if type(v506) ~= "table" and type(v506) ~= "userdata" then v506 = newRecoveredTable() end
        v506.Color = v507
        if type(v506) ~= "table" and type(v506) ~= "userdata" then v506 = newRecoveredTable() end
        v506.Thickness = 2
        if type(v506) ~= "table" and type(v506) ~= "userdata" then v506 = newRecoveredTable() end
        v506.Transparency = v507
        v509 = ensureCallable(v509)
        v509 = v509()
        v510 = nil
        v512 = v511
        if type(v511) ~= "table" and type(v511) ~= "userdata" then v511 = newRecoveredTable() end
        v511 = v511.Connect
        
        function v513()
          -- synthetic register locals stripped
          -- removed decompiler goto
          -- removed decompiler label lbl_2
          -- removed decompiler goto
          v764 = v763
          if type(v763) ~= "table" and type(v763) ~= "userdata" then v763 = newRecoveredTable() end
          v763 = v763.Remove
          v763 = ensureCallable(v763)
          v763(v764)
          v764 = v763
          if type(v763) ~= "table" and type(v763) ~= "userdata" then v763 = newRecoveredTable() end
          v763 = v763.Disconnect
          v763 = ensureCallable(v763)
          v763(v764)
          -- removed decompiler label lbl_7
          do return end
          v764 = v763
          if type(v763) ~= "table" and type(v763) ~= "userdata" then v763 = newRecoveredTable() end
          v763 = v763.WorldToViewportPoint
          v765 = v1018
          v763 = ensureCallable(v763)
          v763, v764 = v763(v764, v765)
          v765 = v1017
          v766 = v765
          if type(v765) ~= "table" and type(v765) ~= "userdata" then v765 = newRecoveredTable() end
          v765 = v765.WorldToViewportPoint
          v767 = v1019
          v765 = ensureCallable(v765)
          v765, v766 = v765(v766, v767)
          v767 = v1015
          v768 = Vector2
          if type(v768) ~= "table" and type(v768) ~= "userdata" then v768 = newRecoveredTable() end
          v768 = v768.new
          if type(v763) ~= "table" and type(v763) ~= "userdata" then v763 = newRecoveredTable() end
          v769 = v763.X
          if type(v763) ~= "table" and type(v763) ~= "userdata" then v763 = newRecoveredTable() end
          v770 = v763.Y
          v768 = ensureCallable(v768)
          v768 = v768(v769, v770, v771)
          if type(v767) ~= "table" and type(v767) ~= "userdata" then v767 = newRecoveredTable() end
          v767.From = v768
          v767 = v1015
          v768 = Vector2
          if type(v768) ~= "table" and type(v768) ~= "userdata" then v768 = newRecoveredTable() end
          v768 = v768.new
          if type(v765) ~= "table" and type(v765) ~= "userdata" then v765 = newRecoveredTable() end
          v769 = v765.X
          if type(v765) ~= "table" and type(v765) ~= "userdata" then v765 = newRecoveredTable() end
          v770 = v765.Y
          v768 = ensureCallable(v768)
          v768 = v768(v769, v770, v771)
          if type(v767) ~= "table" and type(v767) ~= "userdata" then v767 = newRecoveredTable() end
          v767.To = v768
        end
        
        v511 = ensureCallable(v511)
        v511 = v511(v512, v513, v514)
      end
    end
    -- removed decompiler label lbl_222
    v256 = ensureCallable(v256)
    v256(v257)
    -- removed decompiler label lbl_223
    v257 = ensureCallable(v257)
    v257(v258)
  end
  -- removed decompiler label lbl_225
  v255 = v251
  -- synthetic vararg register fan-out stripped
  -- trimmed huge synthetic register fan-out
  return v254(v255, v256, v257, v258, v259, v260, v261, v262)
end

v147 = ensureCallable(v147)
v147 = v147(v148, v149, v150, v151)
v149 = "SetWatermarkVisibility"
v148 = v67
if type(v67) ~= "table" and type(v67) ~= "userdata" then v67 = newRecoveredTable() end
v147 = v67[v149]
v147 = ensureCallable(v147)
v147(v148, v149)
v147 = ensureCallable(v147)
v147 = v147()
v148 = 0
v149 = 60
v151 = v150
if type(v150) ~= "table" and type(v150) ~= "userdata" then v150 = newRecoveredTable() end
v150 = v150.GetService
v152 = "RunService"
v150 = ensureCallable(v150)
v150 = v150(v151, v152, v153)
v151 = "RenderStepped"
if type(v150) ~= "table" and type(v150) ~= "userdata" then v150 = newRecoveredTable() end
v150 = v150[v151]
v152 = "Connect"
v151 = v150
if type(v150) ~= "table" and type(v150) ~= "userdata" then v150 = newRecoveredTable() end
v150 = v150[v152]

function v152()
  -- synthetic register locals stripped
  v758 = v758 + 1
  v758 = ensureCallable(v758)
  v758 = v758()
  if 1 <= v758 then
    v1015 = v758
    v758 = tick
    v758 = ensureCallable(v758)
    v758 = v758()
    v1014 = v758
    v758 = 0
  end
  v1012 = v758
  v252 = v758
  if type(v758) ~= "table" and type(v758) ~= "userdata" then v758 = newRecoveredTable() end
  v758 = v758.SetWatermark
  v254 = " | %s fps | %s ms | UID: %s "
  v254 = v253
  if type(v253) ~= "table" and type(v253) ~= "userdata" then v253 = newRecoveredTable() end
  v253 = v253.format
  v255 = ensureCallable(v255)
  v255 = v255(v256)
  v258 = v257
  if type(v257) ~= "table" and type(v257) ~= "userdata" then v257 = newRecoveredTable() end
  v257 = v257.GetService
  v259 = "Stats"
  v257 = ensureCallable(v257)
  v257 = v257(v258, v259, v260)
  v258 = v257
  if type(v257) ~= "table" and type(v257) ~= "userdata" then v257 = newRecoveredTable() end
  v257 = v257.GetValue
  -- synthetic vararg register fan-out stripped
  -- trimmed huge synthetic register fan-out
  v256 = v256(v257, v258, v259, v260, v261, v262, v263, v264)
  -- synthetic vararg register fan-out stripped
  -- trimmed huge synthetic register fan-out
  v758(v252, v253, v254, v255, v256, v257, v258, v259)
end

function v153()
  -- synthetic register locals stripped
  v252 = v758
  if type(v758) ~= "table" and type(v758) ~= "userdata" then v758 = newRecoveredTable() end
  v758 = v758.Disconnect
  v758 = ensureCallable(v758)
  v758(v252)
  v758 = ensureCallable(v758)
  v758, v252, v253 = v758(v252)
  if false then -- removed constant-true decompiler loop
    -- removed decompiler goto
    v257 = v255
    if type(v255) ~= "table" and type(v255) ~= "userdata" then v255 = newRecoveredTable() end
    v256 = v255.Disconnect
    -- removed decompiler label lbl_6
    v256 = ensureCallable(v256)
    v256(v257)
  end
  v758 = ensureCallable(v758)
  v758 = v758()
  v252 = {}
  if type(v758) ~= "table" and type(v758) ~= "userdata" then v758 = newRecoveredTable() end
  v758.Tools = v252
  v758 = getgenv
  v758 = ensureCallable(v758)
  v758 = v758()
  v252 = {}
  if type(v758) ~= "table" and type(v758) ~= "userdata" then v758 = newRecoveredTable() end
  v758.Settings = v252
  v758 = pairs
  v252 = v1014
  if type(v252) ~= "table" and type(v252) ~= "userdata" then v252 = newRecoveredTable() end
  v252 = v252.GetPlayers
  -- synthetic vararg register fan-out stripped
  -- trimmed huge synthetic register fan-out
  v758, v252, v253 = v758(v252, v253, v254, v255, v256, v257, v258, v259)
  if false then -- removed constant-true decompiler loop
    -- removed decompiler goto
    if type(v256) ~= "table" and type(v256) ~= "userdata" then v256 = newRecoveredTable() end
    v256 = v256[v257]
    if not v256 then
    end
    -- removed decompiler goto
    if type(v255) ~= "table" and type(v255) ~= "userdata" then v255 = newRecoveredTable() end
    v257 = v255.Name
    if type(v256) ~= "table" and type(v256) ~= "userdata" then v256 = newRecoveredTable() end
    v256 = v256[v257]
    v257 = v256
    if type(v256) ~= "table" and type(v256) ~= "userdata" then v256 = newRecoveredTable() end
    v256 = v256.Destroy
    v256 = ensureCallable(v256)
    v256(v257)
    v256 = v1015
    if type(v255) ~= "table" and type(v255) ~= "userdata" then v255 = newRecoveredTable() end
    v257 = v255.Name
    -- removed decompiler label lbl_32
    if type(v256) ~= "table" and type(v256) ~= "userdata" then v256 = newRecoveredTable() end
    if v257 == nil then v257 = "RecoveredKey" end
    v256[v257] = nil
    if type(v256) ~= "table" and type(v256) ~= "userdata" then v256 = newRecoveredTable() end
    v256 = v256[v257]
    if v256 then
      if type(v255) ~= "table" and type(v255) ~= "userdata" then v255 = newRecoveredTable() end
      v257 = v255.Name
      if type(v256) ~= "table" and type(v256) ~= "userdata" then v256 = newRecoveredTable() end
      v256 = v256[v257]
      v257 = v256
      if type(v256) ~= "table" and type(v256) ~= "userdata" then v256 = newRecoveredTable() end
      v256 = v256.Destroy
      v256 = ensureCallable(v256)
      v256(v257)
      v256 = v1016
      if type(v255) ~= "table" and type(v255) ~= "userdata" then v255 = newRecoveredTable() end
      v257 = v255.Name
    end
    -- removed decompiler label lbl_42
    if type(v256) ~= "table" and type(v256) ~= "userdata" then v256 = newRecoveredTable() end
    if v257 == nil then v257 = "RecoveredKey" end
    v256[v257] = nil
  end
  v252 = v758
  if type(v758) ~= "table" and type(v758) ~= "userdata" then v758 = newRecoveredTable() end
  v758 = v758.Destroy
  v758 = ensureCallable(v758)
  v758(v252)
  v252 = v758
  if type(v758) ~= "table" and type(v758) ~= "userdata" then v758 = newRecoveredTable() end
  v758 = v758.Destroy
  v758 = ensureCallable(v758)
  v758(v252)
  if type(v758) ~= "table" and type(v758) ~= "userdata" then v758 = newRecoveredTable() end
  v758.Unloaded = true
end

v151 = ensureCallable(v151)
v151(v152, v153)
v151 = "UI Settings"
if type(v71) ~= "table" and type(v71) ~= "userdata" then v71 = newRecoveredTable() end
v151 = v71[v151]
v153 = "AddLeftGroupbox"
v152 = v151
if type(v151) ~= "table" and type(v151) ~= "userdata" then v151 = newRecoveredTable() end
v151 = v151[v153]
v153 = "Menu"
v151 = ensureCallable(v151)
v151 = v151(v152, v153, v154)
v154 = "AddButton"
v153 = v151
if type(v151) ~= "table" and type(v151) ~= "userdata" then v151 = newRecoveredTable() end
v152 = v151[v154]
v154 = "Unload"

function v155()
  -- synthetic register locals stripped
  v252 = v758
  if type(v758) ~= "table" and type(v758) ~= "userdata" then v758 = newRecoveredTable() end
  v758 = v758.Unload
  v758 = ensureCallable(v758)
  v758(v252)
end

v152 = ensureCallable(v152)
v152(v153, v154, v155)
v154 = "AddLabel"
v153 = v151
if type(v151) ~= "table" and type(v151) ~= "userdata" then v151 = newRecoveredTable() end
v152 = v151[v154]
v154 = "Menu bind"
v152 = ensureCallable(v152)
v152 = v152(v153, v154, v155)
v154 = "AddKeyPicker"
v153 = v152
if type(v152) ~= "table" and type(v152) ~= "userdata" then v152 = newRecoveredTable() end
v152 = v152[v154]
v154 = "MenuKeybind"
v156 = "Default"
v157 = "End"
if type(v155) ~= "table" and type(v155) ~= "userdata" then v155 = newRecoveredTable() end
if v156 == nil then v156 = "RecoveredKey" end
v155[v156] = v157
v156 = "NoUI"
if type(v155) ~= "table" and type(v155) ~= "userdata" then v155 = newRecoveredTable() end
if v156 == nil then v156 = "RecoveredKey" end
v155[v156] = v157
v156 = "Menu keybind"
if type(v155) ~= "table" and type(v155) ~= "userdata" then v155 = newRecoveredTable() end
v155.Text = v156
v152 = ensureCallable(v152)
v152(v153, v154, v155)
v152 = "ToggleKeybind"
v154 = "MenuKeybind"
if type(v153) ~= "table" and type(v153) ~= "userdata" then v153 = newRecoveredTable() end
v153 = v153[v154]
if type(v67) ~= "table" and type(v67) ~= "userdata" then v67 = newRecoveredTable() end
if v152 == nil then v152 = "RecoveredKey" end
v67[v152] = v153
v154 = "SetLibrary"
v153 = v68
if type(v68) ~= "table" and type(v68) ~= "userdata" then v68 = newRecoveredTable() end
v152 = v68[v154]
v152 = ensureCallable(v152)
v152(v153, v154)
v154 = "SetLibrary"
v153 = v69
if type(v69) ~= "table" and type(v69) ~= "userdata" then v69 = newRecoveredTable() end
v152 = v69[v154]
v152 = ensureCallable(v152)
v152(v153, v154)
v154 = "IgnoreThemeSettings"
v153 = v69
if type(v69) ~= "table" and type(v69) ~= "userdata" then v69 = newRecoveredTable() end
v152 = v69[v154]
v152 = ensureCallable(v152)
v152(v153)
v154 = "SetIgnoreIndexes"
v153 = v69
if type(v69) ~= "table" and type(v69) ~= "userdata" then v69 = newRecoveredTable() end
v152 = v69[v154]
v155 = "MenuKeybind"
if type(v154) ~= "table" and type(v154) ~= "userdata" then v154 = newRecoveredTable() end
v154[1] = v155
v152 = ensureCallable(v152)
v152(v153, v154)
v154 = "SetFolder"
v153 = v68
if type(v68) ~= "table" and type(v68) ~= "userdata" then v68 = newRecoveredTable() end
v152 = v68[v154]
v152 = ensureCallable(v152)
v152(v153, v154)
v154 = "SetFolder"
v153 = v69
if type(v69) ~= "table" and type(v69) ~= "userdata" then v69 = newRecoveredTable() end
v152 = v69[v154]
v155 = "/Saves"
v152 = ensureCallable(v152)
v152(v153, v154)
v154 = "BuildConfigSection"
v153 = v69
if type(v69) ~= "table" and type(v69) ~= "userdata" then v69 = newRecoveredTable() end
v152 = v69[v154]
v154 = "UI Settings"
if type(v71) ~= "table" and type(v71) ~= "userdata" then v71 = newRecoveredTable() end
v154 = v71[v154]
v152 = ensureCallable(v152)
v152(v153, v154)
v154 = "ApplyToTab"
v153 = v68
if type(v68) ~= "table" and type(v68) ~= "userdata" then v68 = newRecoveredTable() end
v152 = v68[v154]
v154 = "UI Settings"
if type(v71) ~= "table" and type(v71) ~= "userdata" then v71 = newRecoveredTable() end
v154 = v71[v154]
v152 = ensureCallable(v152)
v152(v153, v154)
v154 = "LoadAutoloadConfig"
v153 = v69
if type(v69) ~= "table" and type(v69) ~= "userdata" then v69 = newRecoveredTable() end
v152 = v69[v154]
v152 = ensureCallable(v152)
v152(v153)
v152 = warn
v153 = "[ASTRALGUARD] - Authenticating.."
v152 = ensureCallable(v152)
v152(v153)
v152 = warn
v153 = "AUTHENTICATED | Took "
v154 = v31
v155 = " seconds"
v153 = v153 .. v154 .. v155
v152 = ensureCallable(v152)
v152(v153)
v153 = "LOADED! | Took "
v155 = ensureCallable(v155)
v155 = v155()
v154 = ensureCallable(v154)
v154 = v154(v155)
v155 = " seconds to fully load"
v152 = ensureCallable(v152)
v152(v153)
v154 = v153
if type(v153) ~= "table" and type(v153) ~= "userdata" then v153 = newRecoveredTable() end
v153 = v153.GetService
v155 = "LogService"
v153 = ensureCallable(v153)
v153 = v153(v154, v155, v156)
v154 = "MessageOut"
if type(v153) ~= "table" and type(v153) ~= "userdata" then v153 = newRecoveredTable() end
v153 = v153[v154]
v152 = ensureCallable(v152)
v152 = v152(v153)
v153 = 2
if type(v152) ~= "table" and type(v152) ~= "userdata" then v152 = newRecoveredTable() end
v152 = v152[v153]
v154 = "Disconnect"
v153 = v152
if type(v152) ~= "table" and type(v152) ~= "userdata" then v152 = newRecoveredTable() end
v152 = v152[v154]
v152 = ensureCallable(v152)
v152(v153)
