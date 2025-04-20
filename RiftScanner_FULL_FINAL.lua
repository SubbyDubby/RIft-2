-- Fully Automatic AWP.GG Rift Scanner
-- Configuration (EDIT THESE)
local WEBHOOK_URL = "https://discord.com/api/webhooks/1363251024210432164/B26f2Tvrl_QuigIZ5AJswcd1hYKPGxIHlYzUUu-cicdhF6kj2i5hrQi16-YK2-R7rk0Y" -- Replace with your actual webhook
-- Add the 25x webhook URL (you can use the same URL if you want)
local WEBHOOK_URL_25X = "https://discord.com/api/webhooks/1363451259016712192/OIMNA2MKvtfFW2IZOj5zDyoqhDYFlV-uU1GARyJwWSPSVHQzDAvSThojSOf1n9f5E6de" -- Replace with your special webhook for 25x rifts
local PLACE_ID = 85896571713843
local jobIds = {
    "caf64c7b-3514-4481-8054-2a8986b14986",
    "239f7147-5147-4356-a64d-94db4c437fda",
    "e100ab0a-5154-4ed6-9321-b43446083358",
    "02e929b2-7ed7-45db-9a35-a9c3caeac426",
    "ab47a03d-0a60-4759-9c76-3bfad3c301d2",
    "4c26270d-5493-49e8-bacb-bef42ad133ac",
    "e838b14d-5411-4a43-a306-d018b413e7d0",
    "9ea622a4-2648-4761-9f85-093e9ecc01c4",
    "a3ed1dcf-b56e-4989-a765-0c156bb081ed",
    "39e4e265-0548-4bfa-9574-2409335ed881",
    "4cc2a3a3-1ab9-44c8-a0b7-ca2842a8e978",
    "b6cdafe2-0b7c-484e-bc5a-aa4e742283bd",
    "48850f3e-6034-464e-afe5-990e8027dc19",
    "90e2a5ab-ad13-4312-a374-e9006e639ddb",
    "6de54149-95b5-429c-bd6d-78a8c61b194b",
    "ea6355d2-e64b-4610-9b51-3c97ab947f51",
    "0b97d697-572b-42dd-99c3-1a53766a2648",
    "00a39509-d0ac-4df3-b238-6a66fa1dbec5",
    "9490743f-7786-44b2-a64d-ecc281313135",
    "b1c7ae58-93e8-4802-9bdf-a9aa9c02d39b",
    "c9e47af7-083b-498e-a6df-3329179af9f0",
    "55b1c43a-5894-4361-907e-373ae0973d30",
    "31ddb552-ae53-4f6d-8cd4-d6d38a93809d",
    "5ad70d20-83af-424a-a8c6-97891995233b",
    "5d1607ea-c6ec-4a67-a437-8b8a0713d452",
    "9aaf0a81-30cf-42ac-925c-a296ecb37daa",
    "f27b6ccb-7121-4975-a0e4-37d7cf41cbbc",
    "74dfd692-7364-4289-9f30-48652ed2df4d",
    "ff4ca6fa-91c6-4a39-b58b-df8786cb518a",
    "06d1a44b-2a4b-4efd-86e5-1039f519f91f",
    "42b024fd-e463-4f9c-900a-1532049898ec",
    "5b44b33a-bdbe-4ad1-88d6-6b80c67350a9",
    "520a475b-8954-48dc-8911-7ed1cbcaf199",
    "1d31cb5f-4400-441d-b818-e7203ba5b4c5",
    "f9bad6d8-839d-4cdb-86b5-f0192effe23a",
    "cc53e3be-1cb1-4477-938a-40a68ea1a05c",
    "3429a682-5333-4467-9b01-1cfc2c2ed64c",
    "f39dd8cb-80f8-4952-ab6c-d9117065c6d6",
    "33044390-a2c0-40fb-9d98-5137f27125f0",
    "6df5f8ad-aa0f-400c-ae82-a2d9e7ae8bab",
    "06ca471f-ae4e-48e0-8a3f-88add5cbf207",
    "178ad271-5956-4a1d-9c0b-dfd2e7bc7b2e",
    "436c62f3-7264-4904-908a-096b34fa86ee",
    "8316068f-1568-4de7-a722-fd9763dead8e",
    "f3d63c93-bcee-41c8-94d9-76d991c68b99",
    "2a306811-bf54-4b56-9436-6740feac5dbe",
    "ef568e97-f3ae-403c-92ab-aaa66c0dfe62",
    "4b9f816d-0c6f-4a57-b1a1-30c5c855abbf",
    "4b8c8249-4f3b-4ef5-870e-041788eae3a0",
    "c123ab08-0f16-4889-bce9-ad00e5025ae3",
    "d73f0123-f569-47da-b7e6-6c5e10a030ab",
    "908a7aa2-cc3a-420a-a3b0-0c8360df641b",
    "cd2eed28-e344-4664-ba54-95bf3bd5f274",
    "b4d625ed-f39b-455e-8053-96c5aaa50ad6",
    "3447c7fc-15cf-4ab9-90b3-af8e780b3a42",
    "bd6ef944-df0f-45ea-a517-5d936d89637d",
    "3c6e0ded-3bd3-49d7-b46b-67662172b43c",
    "55ae924a-d7c5-402d-a29a-a8d11edc059f",
    "a01aa2ff-ee91-4abe-97c5-1ed1ca7c0c74",
    "92dafe78-0264-48c7-b607-6a9342c73277",
    "446718c4-8932-4d33-9cf2-66b54a9eaf6a",
    "0ae4556a-fc35-4d88-bf21-9ae885890265",
    "cf0d228a-615e-42ff-9d87-195a70e9ce3f",
    "20e1425e-2589-4d6f-8056-b153b81884aa",
    "32607c74-46a5-41b5-8beb-7f930fa9386e",
    "bdac0342-6fd6-44de-87d7-bd9fdb5ced32",
    "3dc5df7a-bcca-4005-bd3b-5b290fd05162",
    "98f43975-cda3-41f4-b87c-e76b366c2cc4",
    "a922077a-87ff-482c-b824-930ead241b30",
    "cdaf37a5-6ff2-419a-bd9e-f639584fdddf",
    "d7540879-2d62-49ba-85cf-b11fa75b52d6",
    "23f76589-9595-4ddf-8dcb-a96194f5f6c5",
    "f41cff00-71ac-475d-b682-1d1852afa2e9",
    "cb02faa3-587d-4ba8-b978-4266ddd1ae1f",
    "5c5998f9-4f08-434c-972f-18b7b5608905",
    "be5ef998-f250-4533-8e4b-0699e33e20f3",
    "27ff64ba-3aaf-456f-9a65-fa9a44ba5889",
    "f5cb5acf-a2e4-43c4-826a-a9118cb08888",
    "8a3cc76b-9c4b-41a5-b95c-dd9650d0e5a4",
    "b700ce41-c121-4cfb-91bf-e52f01e5e1d2",
    "8e185a5a-3630-4dbe-9eb3-9bf80ceabe3e",
    "c52b835c-82ce-4235-92fe-f0ae2749045f",
    "f70c3fcf-5b84-4dd0-b8a0-01fbdebf3cd0",
    "028879f3-f7a6-4938-856c-c09e0fb2cdef",
    "a88f7878-3acc-42a5-9961-4099b4aaaf95",
    "4c008771-eb9b-41af-8d08-5190407a941f",
    "66c585d9-a09d-4b87-862d-cd694a4bdbba",
    "437b0dce-ef26-4814-9a15-8e855fbfbc79",
    "2dbf01c4-f2da-4fff-9805-e50dc0fc64c3",
    "76eb732e-b4e4-495d-8253-25d2b82d1451",
    "eb3b87b8-5258-47e1-a2a3-05c4d57d8db5",
    "6836c03d-e890-4a1e-8bb8-5437d269302d",
    "5f600d3e-a6d2-484f-98c1-a2e9edddf9f1",
    "55048463-41dd-4d26-a19f-bdef25cdf483",
    "861e9d61-0770-4151-b09f-2123127c2194",
    "70cee3cd-dda8-45d9-b6ce-0bff45513984",
    "a963b9b1-9f85-420b-b89f-70cf2121042d",
    "80c5aee3-2657-46a6-9e68-058eccb156ec",
    "d4fceb42-3233-4e90-9d55-49ce8af35180",
    "3fcdd862-6f6b-48b4-8511-269d6e254f27"
}

-- Initialize or restore global state
_G.RiftScanner = _G.RiftScanner or {
    CurrentIndex = 1,
    SentNotifications = {}
}

-- Services
local Workspace = game:GetService("Workspace")
local HttpService = game:GetService("HttpService")
local TeleportService = game:GetService("TeleportService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- Get the appropriate request function
local request = http_request or request or (syn and syn.request) or (fluxus and fluxus.request) or getgenv().request
if not request then
    print("ERROR: No HTTP request function found!")
    return
end

-- Send webhook function (unchanged)
local function sendWebhook(title, fields)
    print("Sending webhook: " .. title)
    
    local embed = {
        title = title,
        fields = fields,
        color = 10597128,
        timestamp = os.date("!%Y-%m-%dT%H:%M:%SZ")
    }

    local payload = HttpService:JSONEncode({ embeds = { embed } })

    local success, response = pcall(function()
        return request({
            Url = WEBHOOK_URL,
            Method = "POST",
            Headers = { ["Content-Type"] = "application/json" },
            Body = payload
        })
    end)
    
    if success then
        print("Webhook sent successfully!")
    else
        print("Failed to send webhook: " .. tostring(response))
    end
end

-- NEW: Special webhook function for 25x multipliers
local function send25xWebhook(title, fields)
    print("Sending 25x webhook: " .. title)
    
    local embed = {
        title = title,
        fields = fields,
        color = 16711680, -- Bright red color for emphasis
        timestamp = os.date("!%Y-%m-%dT%H:%M:%SZ")
    }

    local payload = HttpService:JSONEncode({ embeds = { embed } })

    local success, response = pcall(function()
        return request({
            Url = WEBHOOK_URL_25X,
            Method = "POST",
            Headers = { ["Content-Type"] = "application/json" },
            Body = payload
        })
    end)
    
    if success then
        print("25x webhook sent successfully!")
    else
        print("Failed to send 25x webhook: " .. tostring(response))
    end
end

-- Scan for rifts
local function scanRifts()
    print("Scanning for rifts...")
    local foundRift = false
    local currentSeen = {}

    -- Look for the rifts folder
    local riftFolder = Workspace:FindFirstChild("Rendered") and Workspace.Rendered:FindFirstChild("Rifts")
    if not riftFolder then 
        print("Rifts folder not found")
    else
        print("Rifts folder found, checking for rifts...")
        
        -- Loop through all rifts
        for _, rift in pairs(riftFolder:GetChildren()) do
            if not rift:IsA("Model") then continue end

            local name = rift.Name:lower()
            local gui = rift:FindFirstChild("Display") and rift.Display:FindFirstChild("SurfaceGui")
            if not gui then continue end

            local timerLabel = gui:FindFirstChild("Timer")
            local luckLabel = gui:FindFirstChild("Icon") and gui.Icon:FindFirstChild("Luck")

            local timer = timerLabel and timerLabel.Text or nil
            local multiplier = luckLabel and luckLabel.Text or nil

            if not timer or timer == "" then continue end

            -- Y Position for height
            local y = rift:GetPivot().Position.Y
            local key = name .. "|" .. timer .. "|" .. (multiplier or "n/a") .. "|" .. y
            currentSeen[key] = true
            foundRift = true

            if not _G.RiftScanner.SentNotifications[key] then
                _G.RiftScanner.SentNotifications[key] = true

                -- MODIFIED: Check for 25x multiplier
                if multiplier and string.find(multiplier, "25x") then
                    -- 25x multiplier found - use special webhook
                    print("Found 25x multiplier rift: " .. name)
                    send25xWebhook("🌈 25x MULTIPLIER RIFT FOUND!", {
                        { name = "Egg", value = name, inline = true },
                        { name = "Multiplier", value = multiplier, inline = true },
                        { name = "Time Left", value = timer, inline = true },
                        { name = "Height (Y)", value = tostring(math.floor(y)), inline = true },
                        { name = "Join Server", value = "[Click to Join](https://slayervalue.com/roblox/join_game.php?placeId=" .. PLACE_ID .. "&jobId=" .. game.JobId .. ")", inline = false }
                    })
                elseif multiplier then
                    -- Regular multiplier rift (unchanged)
                    print("Found rift: " .. name .. " with " .. multiplier .. " luck")
                    sendWebhook("🌈 Rift Detected!", {
                        { name = "Egg", value = name, inline = true },
                        { name = "Multiplier", value = multiplier, inline = true },
                        { name = "Time Left", value = timer, inline = true },
                        { name = "Height (Y)", value = tostring(math.floor(y)), inline = true },
                        { name = "Server ID", value = game.JobId, inline = false }
                    })
                else
                    -- Chest rift (unchanged)
                    print("Found chest: " .. name)
                    sendWebhook("🎁 Chest Detected!", {
                        { name = "Chest", value = name, inline = true },
                        { name = "Time Left", value = timer, inline = true },
                        { name = "Height (Y)", value = tostring(math.floor(y)), inline = true },
                        { name = "Server ID", value = game.JobId, inline = false }
                    })
                end
            end
        end

        -- Clear despawned entries
        for key in pairs(_G.RiftScanner.SentNotifications) do
            if not currentSeen[key] then
                _G.RiftScanner.SentNotifications[key] = nil
            end
        end
    end

    if not foundRift then
        print("No rifts found in this server")
    end
    
    -- After scanning, wait 15 seconds before hopping
    print("Waiting 15 seconds before moving to next server...")
    wait(15)
    hopToNextServer()
end

-- Auto-continuation script for the next server
local CONTINUATION_SCRIPT = [[
-- Initialize global variables
_G.RiftScanner = _G.RiftScanner or {}
_G.RiftScanner.CurrentIndex = %d
_G.RiftScanner.SentNotifications = {}

-- Wait for game to load
if not game:IsLoaded() then game.Loaded:Wait() end
wait(5) -- Additional wait to ensure everything loads properly

-- Load and execute main script
loadstring(game:HttpGet('https://raw.githubusercontent.com/SubbyDubby/Roblox-Rift-Scanner/main/Rift.lua'))()
]]

-- Hop to next server with advanced auto-continuation and error handling
-- COMPLETELY UNCHANGED FROM YOUR WORKING VERSION
function hopToNextServer()
    local nextIndex = _G.RiftScanner.CurrentIndex + 1
    
    if nextIndex <= #jobIds then
        local nextJobId = jobIds[nextIndex]
        print("Hopping to server " .. nextIndex .. " with JobID: " .. nextJobId)
        
        -- Update the current index immediately
        _G.RiftScanner.CurrentIndex = nextIndex
        
        -- Create continuation script
        local scriptToQueue = string.format(CONTINUATION_SCRIPT, nextIndex)
        
        -- Queue script to run after teleport
        if getgenv().queue_on_teleport then
            getgenv().queue_on_teleport(scriptToQueue)
            print("Using AWP.GG queue_on_teleport")
        elseif queue_on_teleport then
            queue_on_teleport(scriptToQueue)
            print("Using standard queue_on_teleport")
        elseif syn and syn.queue_on_teleport then
            syn.queue_on_teleport(scriptToQueue)
            print("Using Synapse queue_on_teleport")
        end
        
        -- Wait for queue_on_teleport to register
        wait(1)
        
        -- Set up a failsafe timer to move to the next server
        spawn(function()
            wait(15) -- Wait 15 seconds
            
            -- Check if we're still in the same server
            local currentServer = game.JobId
            if game.JobId == currentServer then
                print("Teleport likely failed or showing error. Moving to next server...")
                loadstring(game:HttpGet('https://raw.githubusercontent.com/SubbyDubby/Roblox-Rift-Scanner/main/Rift.lua'))()
            end
        end)
        
        -- Attempt teleport
        print("Executing teleport...")
        pcall(function()
            game:GetService("TeleportService"):TeleportToPlaceInstance(PLACE_ID, nextJobId, LocalPlayer)
        end)
        
        -- If teleport call returns (didn't throw error), wait a moment and try next method
        wait(3)
        
        -- Try alternative method if we're still here
        pcall(function()
            TeleportService:TeleportToPlaceInstance(PLACE_ID, nextJobId)
        end)
        
        -- Still here? Try one last method
        wait(3)
        if getgenv().teleport then
            pcall(function()
                getgenv().teleport(PLACE_ID, nextJobId)
            end)
        end
        
        -- If we get here, all teleport methods returned without error
        -- but we might still be showing an error dialog
        print("All teleport methods attempted. Waiting for failsafe timer...")
        
    else
        print("Finished scanning all servers in the list. Restarting from the beginning...")
        _G.RiftScanner.CurrentIndex = 0
        hopToNextServer()
    end
end

-- Main execution starts here
print("Rift Scanner started")
print("Current server index: " .. _G.RiftScanner.CurrentIndex)

-- Wait for game to load completely
if not game:IsLoaded() then
    print("Waiting for game to load...")
    game.Loaded:Wait()
end

-- Wait for player character to load
if not LocalPlayer.Character then
    print("Waiting for character to load...")
    LocalPlayer.CharacterAdded:Wait()
end

-- Wait a bit for everything to initialize
print("Waiting 10 seconds before starting scan...")
wait(10)

-- Start scanning
scanRifts()
