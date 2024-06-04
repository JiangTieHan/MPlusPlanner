-- NameSpaces
local _, core = ...
core.Config = {}
core.Config.addonName = "MPlusPlanner"
core.Config.addonTitle = "M+ Planner"
--


local Config = core.Config
local UIFrame

function Config:Toggle()
    local menu = UIFrame or Config:CreateMenu()
    menu:SetShown(not menu:IsShown())
end

function Config:CreateMenu()
    local titleHOffset, titleVOffset = 10, -2
    local UIFrameWidth, UIFrameHeight = UIParent:GetWidth() / 2, UIParent:GetHeight() / 2

    -- Create UI Frame
    UIFrame = CreateFrame("Frame", core.Config.addonName.."Frame", UIParent, "BasicFrameTemplateWithInset");
    UIFrame:SetSize(UIFrameWidth, UIFrameHeight)
    UIFrame:SetPoint("CENTER", UIParent, "CENTER")
    UIFrame.title = UIFrame:CreateFontString(nil, "OVERLAY")
    UIFrame.title:SetFontObject("GameFontHighlight")
    UIFrame.title:SetPoint("LEFT", UIFrame.TitleBg, "LEFT", titleHOffset, titleVOffset);
    UIFrame.title:SetText(core.Config.addonTitle)
    -- Make UI Frame movable
    UIFrame:SetMovable(true)
    UIFrame:SetClampedToScreen(true)
    UIFrame:SetFrameStrata("HIGH")
    UIFrame:SetScript("OnMouseUp", function () UIFrame:StopMovingOrSizing() end)
    UIFrame:SetScript("OnMouseDown", function () UIFrame:StartMoving() end)
    
    UIFrame:Hide()
    return UIFrame
end
