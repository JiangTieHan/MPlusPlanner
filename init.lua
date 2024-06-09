-- NameSpace
local _, core = ...
core.commands = {
    ["."] = core.Config.Toggle,
    ["help"] = function ()
        local listHeadStr = string.format("%s: List of slash commands:", core.Config.addonTitle)
        local menuStr = string.format("%s: /mpp . - Toggle M+ Planner window.", core.Config.addonTitle)
        local helpStr = string.format("%s: /mpp help - Show help info.", core.Config.addonTitle)
        print(" ")
        print(listHeadStr)
        print(menuStr)
        print(helpStr)
        print(" ")
    end
}
--

local function HandleSlashCommands(str)
    if (#str == 0) then
        core.commands.help()
        return
    end

    local args = {}
    for _, arg in pairs({ string.split(' ', str) }) do
        if (#arg > 0) then
            table.insert(args, arg)
        end
    end

    local path = core.commands
    for id, arg in ipairs(args) do
        arg = string.lower(arg)
        if (path[arg]) then
            if (type(path[arg] == "function")) then
                path[arg](select(id + 1, unpack(args))) -- remaining args are passed to the function
                return
            else
                core.commands.help()
                return
            end
        else
            core.commands.help()
            return
        end
    end
end

function core:init(event, name)
    if (name ~= core.Config.addonName) then return end

    local cmd1 = "/mpp"
    local welcomeStr = string.format("%s's ready! Invite your teammates and type /mpp . to start", core.Config.addonTitle)

    SLASH_MPlusPlanner1 = cmd1
    SlashCmdList.MPlusPlanner = HandleSlashCommands
    print(welcomeStr)
end

local events = CreateFrame("Frame")
events:RegisterEvent("ADDON_LOADED")
events:SetScript("OnEvent", core.init)