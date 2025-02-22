-- Load Rayfield UI Library
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

-- Read JSON config
local HttpService = game:GetService("HttpService")
local config = HttpService:JSONDecode(readfile("FischScript.json")) -- Adjust path if needed

-- Create main UI window
local Window = Rayfield:CreateWindow({
    Name = "Game Settings",
    LoadingTitle = "Loading Config...",
    LoadingSubtitle = "Please wait",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = "MyGameSettings",
        FileName = "Config"
    },
    Discord = {
        Enabled = false,
        Invite = "",
        RememberJoins = true
    },
})

-- Create a settings tab
local SettingsTab = Window:CreateTab("Settings", 4483362458)

-- Iterate through JSON config and create UI elements
for setting, value in pairs(config) do
    if type(value) == "boolean" then
        SettingsTab:CreateToggle({
            Name = setting,
            CurrentValue = value,
            Callback = function(state)
                config[setting] = state
                print(setting .. " set to: " .. tostring(state))
            end
        })
    elseif type(value) == "string" then
        SettingsTab:CreateInput({
            Name = setting,
            PlaceholderText = "Enter value",
            CurrentText = value,
            Callback = function(input)
                config[setting] = input
                print(setting .. " set to: " .. input)
            end
        })
    elseif type(value) == "number" then
        SettingsTab:CreateSlider({
            Name = setting,
            Range = {0, 100},
            Increment = 1,
            CurrentValue = value,
            Callback = function(num)
                config[setting] = num
                print(setting .. " set to: " .. num)
            end
        })
    elseif type(value) == "table" then
        SettingsTab:CreateDropdown({
            Name = setting,
            Options = value,
            CurrentOption = value[1] or "",
            MultipleOptions = false,
            Callback = function(option)
                config[setting] = option
                print(setting .. " set to: " .. option)
            end
        })
    end
end

-- Save settings button
SettingsTab:CreateButton({
    Name = "Save Settings",
    Callback = function()
        writefile("FischScript.json", HttpService:JSONEncode(config))
        Rayfield:Notify({
            Title = "Settings Saved",
            Content = "Your settings have been saved successfully!",
            Duration = 5
        })
    end
})

-- Finish
Rayfield:Notify({
    Title = "UI Loaded",
    Content = "All settings loaded from config.",
    Duration = 3
})
