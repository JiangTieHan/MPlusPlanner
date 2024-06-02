local prefix = "MPlusPlanner"
local addonTitle = "M+ Planner"
local titleHOffset, titleVOffset = 10, -2
local UIFrameWidth = UIParent:GetWidth() / 2
local UIFrameHeight = UIParent:GetHeight() / 2

-- Create UI Frame
local UIFrame = CreateFrame("Frame", prefix.."Frame", UIParent, "BasicFrameTemplateWithInset");
UIFrame:SetSize(UIFrameWidth, UIFrameHeight)
UIFrame:SetPoint("CENTER", UIParent, "CENTER")
UIFrame.title = UIFrame:CreateFontString(nil, "OVERLAY")
UIFrame.title:SetFontObject("GameFontHighlight")
UIFrame.title:SetPoint("LEFT", UIFrame.TitleBg, "LEFT", titleHOffset, titleVOffset);
UIFrame.title:SetText(addonTitle)
UIFrame:SetMovable(true)
UIFrame:SetClampedToScreen(true)
UIFrame:SetScript("OnMouseUp", function ()
    UIFrame:StopMovingOrSizing()
end)
UIFrame:SetScript("OnMouseDown", function ()
    UIFrame:StartMoving()
end)
UIFrame:SetFrameStrata("HIGH")