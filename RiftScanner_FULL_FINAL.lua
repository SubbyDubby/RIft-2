-- Fully Automatic AWP.GG Rift Scanner
-- Configuration (EDIT THESE)
local WEBHOOK_URL = "https://discord.com/api/webhooks/1363251024210432164/B26f2Tvrl_QuigIZ5AJswcd1hYKPGxIHlYzUUu-cicdhF6kj2i5hrQi16-YK2-R7rk0Y" -- Replace with your actual webhook
-- Add the 25x webhook URL (you can use the same URL if you want)
local WEBHOOK_URL_25X = "https://discord.com/api/webhooks/1363451259016712192/OIMNA2MKvtfFW2IZOj5zDyoqhDYFlV-uU1GARyJwWSPSVHQzDAvSThojSOf1n9f5E6de" -- Replace with your special webhook for 25x rifts
local PLACE_ID = 85896571713843
local jobIds = {
    "eec54f87-d328-4e3a-8722-1f4b1ffe835f",
    "2125d925-26ee-478d-8ab5-b01348c583ed",
    "469c54d7-4f69-411b-8163-a77d25dc23ae",
    "4376faec-6f36-4c8d-9656-1b25f527b554",
    "5ea8def7-86ae-492f-bb70-dab67aac7ee7",
    "8f1b850e-04e4-4c10-987c-cf6d34dcc525",
    "9469aa76-edee-45bc-b4a3-1957b8c83f33",
    "16531237-08cc-482d-bdc0-83f7b7bc0517",
    "5fe08d34-c495-42a0-a03b-26ebbb7aa27e",
    "976f8a0c-18a3-4950-a04a-7b06edb54a86",
    "ac9ab1df-521f-478c-ac8c-71527d14b2fe",
    "11ffb114-b12a-47fe-a3e5-2bb2ef00f923",
    "f7ff62b6-86b2-4f1c-82c5-2ffc80007ed6",
    "245e0c01-c1de-4916-aae3-63e843698f7a",
    "c55d75df-e6fc-4c75-8376-36dd8b5d8d1c",
    "4a656618-0703-4e9e-96aa-615171ca9923",
    "2217f614-2877-4cdc-b898-8903e23ca4a2",
    "0cd90ec8-1aa0-4ebc-8cf2-a7c18f1fe6a6",
    "3956f39e-8c01-455a-8f93-e151955bf51b",
    "ca2f34c0-e370-4608-ab57-62b39d237e37",
    "2943f9e3-1226-4f16-be4b-7629bfdc3ac2",
    "dd1418c2-e4f4-4902-a75f-c64b6f3a568b",
    "02f00c99-bbf0-4d0f-b14c-70a550323852",
    "3c901806-6199-4084-890c-419a31e4b1b1",
    "46e96bc2-929f-4074-88cb-39821ae388de",
    "c8e702a6-654c-4de5-b3e8-17382cb3b600",
    "f3be4a2a-a8ee-4a72-bc8d-59a237320c97",
    "ae7ab1dc-4566-4d69-8277-9104e592342e",
    "cbed8949-a714-4a4b-94c6-f5a766302335",
    "13b702ed-24a8-4f71-a007-c4f24c02ba9a",
    "bb802102-7d67-4103-8c3f-b767f66ff113",
    "07cc8337-e462-46b8-8fb3-529a88b50446",
    "8a40ad7d-5714-441d-a962-fc71613a0a0d",
    "36c3c526-2294-43c5-951d-cca7ca730962",
    "c2cc1cce-6a32-47be-b2c0-83e90ae2dc6e",
    "8a639f65-4277-4c0f-bc43-200c057ca486",
    "438c1662-defe-47e5-8d8d-8b6850b72a53",
    "f6d0f69c-a525-4e74-8d49-934088b89320",
    "e8216460-3c6a-4d16-b612-f1b0451d9430",
    "ad29156c-2618-413e-ab61-c52a10592b44",
    "d4cb81da-1b7b-46a9-a4dc-d5fcee106b7b",
    "c68c8985-281a-476f-af92-156364df15c2",
    "db58229e-cd20-44c8-91ab-00f4233bc802",
    "ab56f7f4-069d-4f52-861d-91ca5d040f85",
    "d3ffb940-a0e9-435e-9f7c-8b76dfd93e22",
    "c0ba0f33-44ad-42b7-935a-3c14c41f8686",
    "fddc92e9-b984-4e15-b43e-7127bb6ea85e",
    "bb72c9da-db46-4026-a37c-22910f8c8d45",
    "4bb1885e-50bd-482d-ab6c-7f1cd7407b91",
    "f262718b-0425-4844-8965-bae44ce3a459",
    "cbc5eb42-bb22-46bd-977c-c9251cc9ee2d",
    "8209aca8-fc6d-4ac4-a744-a975848d2f1b",
    "c177dddc-a2f9-4864-9532-546c3a7db187",
    "1868b816-4240-4c45-a9f4-83df79514069",
    "1f49b368-1270-4654-b01d-5cd6e2290c32",
    "f0d2ce35-ebbd-401a-9c2c-3f829827c4d9",
    "8885fe04-fccc-48bf-9f0c-f187711dab12",
    "df5208cb-4e0f-4d15-8f07-873a42b0b3ca",
    "b80dee6d-7232-4edd-a9b6-ba6b75f89894",
    "851a8b0f-63bf-4642-8a6f-fdd2be6729f6",
    "15bb2ba9-5ed8-4d81-a7df-7ed0f1904e6f",
    "b02adbdf-c5c9-4b90-9ba8-96da01844e2e",
    "acf8b1ea-91e6-41ba-8eb6-0a18f56abe16",
    "47d6e6af-7cc3-486d-9a4d-d2c49a0b20a1",
    "5990f455-975d-42e0-a9e6-92c598a61abc",
    "8453a7ff-3dcd-47f9-9732-bbba52d1694d",
    "487505fc-49c7-49be-b966-109e04625988",
    "46799147-004f-4f04-b268-a8678c35049c",
    "0fdcdee5-04a5-4f27-b12a-afaad9efe928",
    "9cedf6ce-e359-4dba-9a0a-f653c8e6fe74",
    "fd28a70a-6cf7-4b46-8218-56da651a43d4",
    "61034f62-d594-41fe-a0e9-2bf6b1f8406c",
    "f9de37ed-7a3d-49a9-a530-461fef4553f0",
    "90b5056b-0a77-419a-bcc9-42262a826d74",
    "7801c131-019e-48fb-92b5-b79abcbd7a20",
    "f1cc068e-453e-4765-8fa7-38695ba02845",
    "2d4e61c3-e45f-4ec3-a8fa-786cc8f63349",
    "a68f11e7-f5ce-41fe-bea3-7fdf93a27d3a",
    "c01e60ea-d3f4-4d64-800b-245cffcface8",
    "e480728a-f689-4f43-8acd-f7c11221e6a9",
    "9d9f1628-91ed-4c38-a607-595adf54d67e",
    "c541ef2b-90f1-4069-9822-d6917fb5c007",
    "9284b2e1-06ac-42e2-b031-ca21fcb244f2",
    "4b1c1148-1209-4b3e-b8c3-a1dd8beec9af",
    "c5638b29-5e3e-4415-86ad-56db775f4675",
    "899341d8-ad01-4ba1-a5c0-2aafea3a2a02",
    "ede5bab6-e654-45c4-8ff1-c93300c80d8a",
    "85950cac-42a0-448f-8d7f-677da9c52f40",
    "842a8471-a286-415b-8edf-cde3a211c44a",
    "22ef1f1a-2f34-4e22-96b9-018f79957c9d",
    "ec4a52a5-8ea1-496a-a942-ec7346e3c61f",
    "610d06f1-5ac1-4761-8525-d80a3051785e",
    "45cdde1a-2158-43b0-9c5a-ff50194c5cba",
    "868b28fd-a976-4835-ab16-7208705676b1",
    "29380912-e969-4b20-b855-4dd4440b7057",
    "07172ae9-ea58-421e-bb61-24e22dbe191b",
    "9171bdfd-4d00-4ef4-bbeb-b9e73c78fe2f",
    "5781f077-fe0c-43fb-ae97-4aff6c541dd0",
    "db2430ae-b317-4643-8ba5-b5546f4cbd5b",
    "85b0c468-36e2-4c88-92cf-6bb64e52c02f",
    "3aab69c0-4aaf-44d0-ab40-2f3aca6fef59",
    "b0dc82c4-6dac-4826-99a0-88b7243e83b1",
    "1178dcd0-40ff-4b54-ba27-dbd2ffba54d7",
    "b509e787-9e41-49c2-bb4a-89aee2e5613b"
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
