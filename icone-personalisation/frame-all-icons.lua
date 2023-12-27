local _,core = ...

function core.Functions.createFrameContainerIcone()
    local frame = CreateFrame("Frame", "IconSelectorFrame", UIParent, "UIPanelDialogTemplate")
    frame:SetSize(425, 400)
    frame:SetPoint("CENTER")
    frame:SetClampedToScreen(true)
    frame:SetMovable(true)
    frame:EnableMouse(true)
    frame:RegisterForDrag("LeftButton")
    frame:SetScript("OnDragStart", frame.StartMoving)
    frame:SetScript("OnDragStop", frame.StopMovingOrSizing)
    frame:SetScript("OnHide", frame.StopMovingOrSizing)

    frame.title = frame:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
    frame.title:SetPoint("TOPLEFT", 16, -10)
    frame.title:SetText("Sélectionnez une icone pour 'Toutes les montures'")
    frame:SetFrameStrata("HIGH")

    local iconSize = 50
    local numColumns = 7

    local scrollFrame = CreateFrame("ScrollFrame", "IconSelectorScrollFrame", frame, "UIPanelScrollFrameTemplate")
    scrollFrame:SetPoint("TOPLEFT", 16, -40)
    scrollFrame:SetPoint("BOTTOMRIGHT", -32, 30)

    local scrollChild = CreateFrame("Frame", "IconSelectorScrollChild", scrollFrame)
    scrollChild:SetSize(numColumns * (iconSize + 4), 0) -- La largeur doit correspondre à la largeur du ScrollFrame, la hauteur sera ajustée dynamiquement
    scrollFrame:SetScrollChild(scrollChild)
    core.Functions.PopulateIconSelector(scrollChild, iconSize, numColumns, frame)
end

