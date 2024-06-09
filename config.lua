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

local function ScrollFrame_OnMouseWheel(self, delta)
    local stepFactor = 500
    local newValue = self:GetVerticalScroll() - (delta * UIParent:GetHeight() / stepFactor)

    if (newValue < 0) then
        newValue = 0
    elseif (newValue > self:GetVerticalScrollRange()) then
        newValue = self:GetVerticalScrollRange()
    end

    self:SetVerticalScroll(newValue)
end

function Config:CreateMenu()
    local titleXOffset, titleYOffset = 10, 1
    local UIFrameWidth, UIFrameHeight = UIParent:GetWidth() / 2, UIParent:GetHeight() / 2

    -- Create UI Frame
    UIFrame = CreateFrame("Frame", core.Config.addonName.."Frame", UIParent, "UIPanelDialogTemplate")
    UIFrame:SetSize(UIFrameWidth, UIFrameHeight)
    UIFrame:SetPoint("CENTER", UIParent, "CENTER")

    -- Create UI Frame title
    UIFrame.title = UIFrame:CreateFontString(nil, "OVERLAY")
    UIFrame.title:SetFontObject("GameFontHighlight")
    UIFrame.title:SetPoint("LEFT", MPlusPlannerFrameTitleBG, "LEFT", titleXOffset, titleYOffset)
    UIFrame.title:SetText(core.Config.addonTitle)

    -- Create scroll bar
    local scrollFrameTopXOffset, scrollFrameTopYOffset, scrollFrameBottomXOffset, scrollFrameBottomYOffset = 0, 0, 0, 0
    UIFrame.ScrollFrame = CreateFrame("ScrollFrame", nil, UIFrame, "UIPanelScrollFrameTemplate")
    UIFrame.ScrollFrame:SetPoint("TOPLEFT", MPlusPlannerFrameDialogBG, "TOPLEFT", scrollFrameTopXOffset, scrollFrameTopYOffset)
    UIFrame.ScrollFrame:SetPoint("BOTTOM", MPlusPlannerFrameDialogBG, "BOTTOM", scrollFrameBottomXOffset, scrollFrameBottomYOffset)
    UIFrame.ScrollFrame:SetClipsChildren(true)

    local child = CreateFrame("Frame", nil, UIFrame.ScrollFrame)
    child:SetSize(UIFrameWidth, UIFrameHeight)
    UIFrame.ScrollFrame:SetScrollChild(child)

    local scrollbarTopXOffset, scrollbarTopYOffset, scrollbarBottomXOffset, scrollbarBottomYOffset = -12, -18, -7, 18
    UIFrame.ScrollFrame.ScrollBar:ClearAllPoints()
    UIFrame.ScrollFrame.ScrollBar:SetPoint("TOPLEFT", UIFrame.ScrollFrame, "TOPRIGHT", scrollbarTopXOffset, scrollbarTopYOffset)
    UIFrame.ScrollFrame.ScrollBar:SetPoint("BOTTOMRIGHT", UIFrame.ScrollFrame, "BOTTOMRIGHT", scrollbarBottomXOffset, scrollbarBottomYOffset)

    UIFrame.ScrollFrame:SetScript("OnMouseWheel", ScrollFrame_OnMouseWheel)
    
    -- Make UI Frame movable
    UIFrame:SetMovable(true)
    UIFrame:SetClampedToScreen(true)
    UIFrame:SetFrameStrata("HIGH")
    UIFrame:SetScript("OnMouseUp", function () UIFrame:StopMovingOrSizing() end)
    UIFrame:SetScript("OnMouseDown", function () UIFrame:StartMoving() end)
    
    UIFrame:Hide()
    return UIFrame
end
