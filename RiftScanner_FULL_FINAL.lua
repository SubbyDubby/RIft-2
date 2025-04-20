-- Fully Automatic AWP.GG Rift Scanner
-- Configuration (EDIT THESE)
local WEBHOOK_URL = "https://discord.com/api/webhooks/1363251024210432164/B26f2Tvrl_QuigIZ5AJswcd1hYKPGxIHlYzUUu-cicdhF6kj2i5hrQi16-YK2-R7rk0Y" -- Replace with your actual webhook
-- Add the 25x webhook URL (you can use the same URL if you want)
local WEBHOOK_URL_25X = "https://discord.com/api/webhooks/1363451259016712192/OIMNA2MKvtfFW2IZOj5zDyoqhDYFlV-uU1GARyJwWSPSVHQzDAvSThojSOf1n9f5E6de" -- Replace with your special webhook for 25x rifts
local PLACE_ID = 85896571713843
local PLACE_ID = 85896571713843
local jobIds = {
    "35cac887-cc04-4af7-acbd-c00d30962226",
    "f875dd14-0512-411c-aa29-5a0c003103c9",
    "3fe28945-6564-4431-a5f1-5dbe7f16a585",
    "e6159a44-8130-4627-94fd-29fb15456838",
    "8c8430db-128c-4365-a739-63ec31ac7271",
    "1c0f30ff-a03a-4b21-966c-8917c2b2358c",
    "fdf2549c-d7f2-4c6f-b8a2-76ec5b45ad5d",
    "44cce721-a030-4f15-88de-85f0d4039da6",
    "7d9ad3e3-a731-467d-9ac3-48bdd67289ad",
    "239f7147-5147-4356-a64d-94db4c437fda",
    "35ecd373-ba03-4f75-b803-398af729ab2d",
    "c4f6a630-94b2-4c78-bcae-acb107dc1d1d",
    "d1885af6-4df3-4ea2-9f07-3a10aab3b7c3",
    "474569e0-0a99-4826-a91b-b761cae9c89a",
    "fda93d1e-652a-496f-a4cf-c89a3139541f",
    "c27083c1-fe3c-4365-8e76-942c5b4d1b2b",
    "fe0d4fae-ccf3-4f9f-8c35-db99e12da6b3",
    "9a61873d-7b31-4260-85ab-5e34656ad83e",
    "5a334dfc-a816-4b43-84b5-9ef58659caa5",
    "e8d2d9cc-011a-4689-97ad-c336ee1e8855",
    "cd2eed28-e344-4664-ba54-95bf3bd5f274",
    "f6ba733e-3cf0-4cfa-a32f-e6d51a51c7d0",
    "e838b14d-5411-4a43-a306-d018b413e7d0",
    "d43d6a05-a939-4cd2-8d8e-4dfed4afb1ad",
    "b1d82299-e45a-47cc-8230-72a922c83794",
    "0a6d7a07-5aef-4f3c-b5aa-8bca762d0bfc",
    "a92a55ff-8ad2-412a-ab64-4adbf9bafb93",
    "724740b5-0c69-445b-a039-cbccb055e88f",
    "8422efd6-dfd5-430b-b190-69be7abd2d98",
    "85b883e8-1ed9-45ff-bacf-e2d960c65de1",
    "a4de44d7-d240-4eda-abbc-c3128bbb6cab",
    "0ede8ae4-7554-4a11-a2f0-e520763b34b2",
    "51188e03-fb39-4134-9cb6-2a7a4697ca30",
    "659baf8b-ec53-4f77-bee1-5d574488fb51",
    "c2b2dcb8-5086-40ef-a387-ccb67fd3ffb8",
    "e4809e77-feb0-4d70-88b9-d3d1242a5f33",
    "8e1fd0fe-86e9-4b53-9436-3d8e36dd9d30",
    "b3e72352-e550-4283-8049-92801f147445",
    "dcb534d0-817b-453b-8614-4e81d89a9a2e",
    "c6854392-f4a1-4ecb-8225-a1d23bafd19d",
    "d73c8c2c-916a-4b59-8311-64eefa82ffed",
    "0fe2b526-4380-4f37-887c-b9c3c4ab67c6",
    "c986573c-da11-4c43-814c-cdf527870d50",
    "58997593-17f4-4c82-ae06-2837cb5dc365",
    "8b3ad56c-c73c-441a-b7ef-8e2af930e12e",
    "0a35cd01-ca45-4acb-927c-ef96e9428cd0",
    "e4777c15-ce40-4ae0-8588-d3ce3e9c265f",
    "c90b6e4a-e05b-45bc-af59-3d4066701110",
    "d7fd823f-56d4-4727-9573-3b77ea2f9c06",
    "b840256c-ac61-4990-8574-c026cf32255e",
    "b700ce41-c121-4cfb-91bf-e52f01e5e1d2",
    "188e8698-ebf3-4111-8db3-db8ebf1f5db2",
    "baada7e3-ac89-4216-9b3d-3a28d7b4813c",
    "918a085f-f007-4376-ba06-3f28219cb65c",
    "b7f20666-f8a2-4821-b820-9c8ecf361825",
    "b8e7f5be-74fb-4552-98d8-09fcdf13508c",
    "e3a886da-06d3-4058-a8bb-8c1fa23efb6d",
    "ff95ddfd-0098-4e3d-8e04-223e83cfe7b0",
    "100905f8-9cd0-4489-8593-772517372eba",
    "5e26b1cf-ff39-4966-95d3-c4b880a137f9",
    "8f3c6d97-23e4-40b0-ad76-c29bfdbfe0d9",
    "6b39cefd-5dad-4819-a0f6-e9d1732f9a80",
    "8e645eb9-0e7e-4d5a-882a-04ec8ba24592",
    "a088b91a-46b7-4ea5-b140-177aa7e8bea8",
    "5b0ea662-39cc-4f4f-9a59-8734f1aecc3c",
    "05060f38-c4e2-41ac-9f94-a2f8333831c3",
    "434fe497-a565-4066-98f7-05ec0c294728",
    "e3c241b8-616d-4cc1-86a0-17c46ccf36ba",
    "85b883e8-1ed9-45ff-bacf-e2d960c65de1",
    "ddde389e-0539-4b17-a533-1abffdf18374",
    "d43d6a05-a939-4cd2-8d8e-4dfed4afb1ad",
    "f6ba733e-3cf0-4cfa-a32f-e6d51a51c7d0",
    "1185c1f2-b362-40ad-9846-5b4bdee138fa",
    "ceee9930-521b-47ba-9524-1041ebbff79c",
    "a6d7b478-96e0-4125-b8f2-39bcb38d3d59",
    "e9fc5eed-c932-4075-bd97-365b79ff70ae"
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

-- Special webhook function for 25x multipliers
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

-- Optional: Uncomment to test the 25x webhook
--send25xWebhook("TEST 25x WEBHOOK", {
--    { name = "Test", value = "This is a test", inline = true },
--    { name = "Join Server", value = "[Click to Join](https://slayervalue.com/roblox/join_game.php?placeId=" .. PLACE_ID .. "&jobId=test)", inline = false }
--})
--print("Test webhook sent")

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

                -- Debug print the multiplier
                print("Checking multiplier:", multiplier)

                -- More robust pattern matching for 25x
                if multiplier and (string.find(tostring(multiplier):lower(), "25%s*x") or string.find(tostring(multiplier), "25")) then
                    -- 25x multiplier found - use special webhook
                    print("25x multiplier detected! Attempting to send to webhook...")
                    send25xWebhook("🌈 25x MULTIPLIER RIFT FOUND!", {
                        { name = "Egg", value = name, inline = true },
                        { name = "Multiplier", value = multiplier, inline = true },
                        { name = "Time Left", value = timer, inline = true },
                        { name = "Height (Y)", value = tostring(math.floor(y)), inline = true },
                        { name = "Join Server", value = "[Click to Join](https://slayervalue.com/roblox/join_game.php?placeId=" .. PLACE_ID .. "&jobId=" .. game.JobId .. ")", inline = false }
                    })
                elseif multiplier then
                    -- Regular multiplier rift (unchanged)
                    print("Found regular rift: " .. name .. " with " .. multiplier .. " luck")
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
