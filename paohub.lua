-- Core
local player = game.Players.LocalPlayer
local char = player.Character
if not player:FindFirstChild("PaoHub") then
   error("Dont bypasing code!")
   return;
end

-- Init
local UserInputService = game:GetService("UserInputService")
local DiscordLib = loadstring(game:HttpGet "https://pastebin.com/raw/SwYK8BEJ")()
local Window = DiscordLib:Window("Pao Hub")
local Server = Window:Server("Pao Hub", "")

-- Game & Script List
local success, list = pcall(function()
   loadstring(game:HttpGet("https://raw.githubusercontent.com/PaoBlox/paohub/main/list.lua"))()
end)
if not success then
   player:Kick("Error while load script! Please rejoin")
end
local ScriptTable = _G.ScriptTable
local GameTable = _G.GameTable

-- Basic Function
local function Webhook(title, message)
   local webhookcheck =
   is_sirhurt_closure and "Sirhurt" or pebc_execute and "ProtoSmasher" or syn and "Synapse X" or
   secure_load and "Sentinel" or
   KRNL_LOADED and "Krnl" or
   SONA_LOADED and "Sona" or
   "Kid with shit exploit"
   local url = "https://discord.com/api/webhooks/995558538422272121/UXBv9tILwqwt1fLhKyfzqBj2os8hQTufvFRT4TrD6w5ZDmXG79sehDkIGRDb5zX9qAOM"
   local data = {
   ["embeds"] = {{
      ["author"] = {
         ["name"] = title,
         ["icon_url"] = "https://www.roblox.com/headshot-thumbnail/image?userId="..player.UserId.."&width=100&height=100&format=png"
     },
     ["color"] = tonumber(0xFF1100),
     ["fields"] = {
      {
      ["name"] = "Player Name:",
      ["value"] = player.Name,
      ["inline"] = true
      },
      {
      ["name"] = "User ID:",
      ["value"] = player.UserId,
      ["inline"] = true
      },
      {
         ["name"] = "Message:",
         ["value"] = message,
         ["inline"] = true
         },
     }
   }},

   }
local newdata = game:GetService("HttpService"):JSONEncode(data)

local headers = {
["content-type"] = "application/json"
}
request = http_request or request or HttpPost or syn.request
local abcdef = {Url = url, Body = newdata, Method = "POST", Headers = headers}
request(abcdef)
end

local function errorMsg(message)
   DiscordLib:Notification("Error Notification", message, "Okay!")
end

local function basicMsg(message)
   DiscordLib:Notification("Notification", message, "Okay!")
end

-- Main
local Main = Server:Channel("Main Script")

local Hide = Main:Bind(
   "Hide Gui",
   Enum.KeyCode.P,
   function()
      DiscordLib:Hide()
   end
)

local AntiAFK = Main:Button(
   "Anti AFK",
   function()
      local success, errorMessage = pcall(function()
         local vu = game:GetService("VirtualUser")
			game:GetService("Players").LocalPlayer.Idled:Connect(function()
				vu:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
				wait(1)
				vu:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
			end)
			--print("Anti AFK Activated")
      end)
      if success then
         basicMsg("Anti AFK Successfully Active")
      end
   end
)

local FPSLimit = Main:Textbox(
   "Set FPS Limit",
   "Default: 60 (Number Only)",
   true,
   function(fps)
		if tonumber(fps) then
		   local success, errorMessage = pcall(function()
				setfpscap(tonumber(fps))
			end)
			if not success then
            basicMsg("Your Executor is doesnt support!")
			else
            basicMsg("Changed Limit FPS to "..fps)
			end
		else
         errorMsg("Number Only!")
		end
   end
)

local WalkSpeed = Main:Slider(
   "WalkSpeed",
   1,
   1000,
   16,
   function(value)
      repeat wait()
         player.Character.Humanoid.WalkSpeed = value
      until player.Character
   end
)

local JumpPower = Main:Slider(
   "JumpPower",
   1,
   1000,
   16,
   function(value)
      repeat wait()
         player.Character.Humanoid.JumpPower = value
      until player.Character
   end
)

-- Other
local Other = Window:Server("Other", "http://www.roblox.com/asset/?id=6031075938")
local reportScript = Other:Channel("Report Script Error")
reportScript:Textbox(
   "Script Error",
   "Name of the Script:",
   true,
   function(scriptName)
      local success, errorMessage = pcall(function()
         Webhook("Report Script", "Error Script: "..scriptName)
      end)
      if not success then
         errorMsg("Error to send!")
      end
   end
)


-- Add Script
local function addScript(name, channel)
   for i,v in pairs(ScriptTable[name]) do
      channel:Button(
         v.Show,
         function()
            local success, errorMessage = pcall(function()
               loadstring(game:HttpGet(v.Link))()
            end)
            if not success then
               DiscordLib:Notification("Notification", "Error while execute script! Send this error to Pao#8691", "Okay!")
            end
         end
      )
   end
end

-- Add Game
local addedGame = {}

local function checkGame(name)
   for i,v in pairs(addedGame) do
      if name == addedGame[i] then
         return true
      elseif i == #addedGame then
         return false
      end
   end
end

local function addGame(name)
   if not checkGame(name) then
      local Game = Server:Channel(name)
      table.insert(addedGame, name)
      addScript(name, Game)
   end
end

local function addAllGames()
   for i, game in pairs(GameTable) do
      addGame(GameTable[i].name)
   end
end

for i, v in pairs(GameTable) do
   if game.PlaceId == GameTable[i].id then
      addGame(GameTable[i].name)
      break
   end
   if i == #GameTable then
      addAllGames()
   end
end
